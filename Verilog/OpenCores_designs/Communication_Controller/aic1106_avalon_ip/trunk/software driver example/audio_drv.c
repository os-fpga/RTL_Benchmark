/*
 * audio_drv.c
 *
 *  Created on: Jun 22, 2014
 *      Author: AlexO
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <float.h>
#include <math.h>
#include <sys/alt_cache.h>
#include <sys/alt_irq.h>
#include <sys/time.h>
#include <fcntl.h>
#include "sys/alt_timestamp.h"
#include "sys/alt_alarm.h"
#include "altera_avalon_fifo_regs.h"
#include "altera_avalon_fifo_util.h"
#include "alt_types.h"
#include "altera_avalon_spi_regs.h"
#include "altera_avalon_spi.h"
#include "altera_avalon_pio_regs.h"
#include "altera_avalon_uart.h"
#include "altera_avalon_uart_regs.h"
#include "altera_vic_irq.h"
#include "altera_vic_regs.h"
#include "system.h"

#include "fifo.h"
#include "audio_drv.h"

#define DEBUG_LOG				AUDIO_DRV_DEBUG_LOG
#define	AUDIO_DEV_PATH			"/mnt/audio/"
#define	AUDIO_DRV_HANDLE		0x0000001
#define AUDIO_INP_FIFO_SZ		8000 //2sec
#define AUDIO_BEEP_BUF_DURATION_MS	10

#define LOG_PRINT()

typedef struct{
    char rID[4];      // 'RIFF'
    long int rLen;
    char wID[4];      // 'WAVE'
    char fId[4];      // 'fmt'
    long int pcmHeaderLength;
    short int wFormatTag;
    short int numChannels;
    long int nSamplesPerSec;
    long int nAvgBytesPerSec;
    short int numBlockAlingn;
    short int numBitsPerSample;
}  __attribute__ (( packed ))  WAV_HDR;

/* header of wave file */
typedef struct
{
    char dId[4];  // 'data' or 'fact'
    long int dLen;
}  __attribute__ (( packed )) CHUNK_HDR;

void (*g_audio_idle_fn)(alt_fd* fd)  = NULL;
static int g_dev_opened = 0;
static int g_io_cancel_req = 0;
static int g_cur_volume = SYS_SOUND_VOLUME;
static int g_inp_fifo_ovf_cnt = 0;
static int g_out_fifo_udf_cnt = 0;
static int g_out_flag = 0;

void* fifo_lock()
{
	 return (void*)alt_irq_disable_all();
}

void fifo_unlock(void* ctx)
{
	alt_irq_enable_all((alt_irq_context)ctx);
}

MAKE_FIFO_INSTANCE(audio_inp, AUDIO_INP_FIFO_SZ, alt_u32, fifo_lock, fifo_unlock);


void aic1106_inp_irq_handler(void* context)
{
	alt_u32 smp2x16;
	volatile int fifo_evt;

	fifo_evt = altera_avalon_fifo_read_event(AIC1106_INPUT_FIFO_OUT_CSR_BASE, ALTERA_AVALON_FIFO_EVENT_ALL);
	if (fifo_evt & ALTERA_AVALON_FIFO_EVENT_OVF_MSK)
	{
		g_inp_fifo_ovf_cnt++;
	}

	while (!(IORD_ALTERA_AVALON_FIFO_STATUS(AIC1106_INPUT_FIFO_OUT_CSR_BASE) & ALTERA_AVALON_FIFO_STATUS_E_MSK))
	{
		smp2x16 = IORD_ALTERA_AVALON_FIFO_DATA(AIC1106_INPUT_FIFO_OUT_BASE);


#if SYSID_ID == 0xABBA002 || SYSID_ID == 0xABBA003
		// followed code fix HW bug in aic1106_pcm.v (aso_valid signal gated two times)
		// for fix it in HW lets change line 129 as followed:
		// wire     fs_rxvalid_off     = (main_cnt == 9'd278);
		// I spent 3 fucking days for found it !!!
		static unsigned char nsmp = 0;
		if (nsmp++ & 0x01)
		{
			audio_inp_put(smp2x16);
		}
#elif SYSID_ID >= 0xABBA004
		// Followed code assume that HW bug fixed (since 0xABBA004)
		audio_inp_put(smp2x16);
#else
#error AUDIO_DRV: UNKNOWN HARDWARE VERSION
#endif
	}

	altera_avalon_fifo_clear_event(AIC1106_INPUT_FIFO_OUT_CSR_BASE, ALTERA_AVALON_FIFO_EVENT_ALL);

}

int audio_open(alt_fd* fd, const char* name, int flags, int mode)
{
	int ret_code = -ENOENT;
	int handle = 0;

	if (!g_dev_opened)
	{
		audio_inp_clean();

		IOWR_ALTERA_AVALON_PIO_DATA(AIC1106_BASE, AIC1106_RESET);
		usleep(10);

		altera_avalon_fifo_clear_event(AIC1106_OUTPUT_FIFO_IN_CSR_BASE, ALTERA_AVALON_FIFO_EVENT_ALL);
		altera_avalon_fifo_clear_event(AIC1106_INPUT_FIFO_OUT_CSR_BASE, ALTERA_AVALON_FIFO_EVENT_ALL);

		// flush fifo
		while (!(IORD_ALTERA_AVALON_FIFO_STATUS(AIC1106_INPUT_FIFO_OUT_CSR_BASE) & ALTERA_AVALON_FIFO_STATUS_E_MSK))
		{
			IORD_ALTERA_AVALON_FIFO_DATA(AIC1106_INPUT_FIFO_OUT_BASE);
		}

		altera_avalon_fifo_write_ienable(AIC1106_INPUT_FIFO_OUT_CSR_BASE, ALTERA_AVALON_FIFO_IENABLE_ALL);

		IOWR_ALTERA_AVALON_PIO_DATA(AIC1106_BASE, AIC1106_ENABLE | g_cur_volume);

		handle = AUDIO_DRV_HANDLE;
		g_dev_opened = 1;
		g_io_cancel_req = 0;
		g_inp_fifo_ovf_cnt = 0;
		g_out_fifo_udf_cnt = 0;
		g_out_flag = 0;
		ret_code = AUDIO_SUCCESS;
	}

	fd->priv = (alt_u8*)handle;

	LOG_PRINT(LOG_DEBUG, ":: name=%s, audio_flags=0x%08x, mode=%d, handle=%d\n\r", name, (unsigned int)flags, mode, handle);

	return ret_code;
}

int audio_close(alt_fd* fd)
{
	int ret_code = -ENOENT;

	if ((int)fd->priv == AUDIO_DRV_HANDLE)
	{
		altera_avalon_fifo_write_ienable(AIC1106_INPUT_FIFO_OUT_CSR_BASE, 0);
		g_dev_opened = 0;

		if (g_out_fifo_udf_cnt > 0)
		{
			LOG_PRINT(LOG_DEBUG, "::Output stream %d times underflow detected\n\r", g_out_fifo_udf_cnt);
		}

		if (g_inp_fifo_ovf_cnt > 0)
		{
			LOG_PRINT(LOG_DEBUG, "::Input stream %d times overflow detected\n\r", g_inp_fifo_ovf_cnt);
		}

		ret_code = AUDIO_SUCCESS;
	}

	LOG_PRINT(LOG_DEBUG, "::handle=%d, ret_code=%d\n\r", (int)fd->priv, ret_code);

	return ret_code;
}

int audio_read(alt_fd* fd, char* ptr, int len)
{
	static int stw = 0;
	static alt_u32 s32;
	int cnt = 0;
	char* pptr = (char*)ptr;

	while (cnt < len)
	{
		if (g_io_cancel_req)
		{
			LOG_PRINT(LOG_DEBUG, "::IO CANCELLED; len=%d, ret_code=%d\n\r", len, cnt);
			break;
		}

		switch (stw)
		{
			case 0:
				while (audio_inp_empty())
				{
					if (g_audio_idle_fn != NULL)
					{
						g_audio_idle_fn(fd); // up to 60 msec is still safe
					}
				}
				audio_inp_get(&s32);

				*pptr++ = s32 & 0xff;
				stw++;
				break;

			case 1: *pptr++ = (s32 >> 8) & 0xff;  stw++; 	break;
			case 2: *pptr++ = (s32 >> 16) & 0xff; stw++; 	break;
			case 3:	*pptr++ = (s32 >> 24) & 0xff; stw = 0;	break;
		}
		cnt++;
	}

	//LOG_PRINT(LOG_DEBUG, "::handle=%d, len=%d, ret_code=%d\n\r", (int)fd->priv, len, cnt);
	return cnt;
}

int audio_write(alt_fd* fd, const char* ptr, int len)
{
	static alt_u8 b0, b1, b2, b3;
	static int stw = 0;
	alt_u32 s32;
	int cnt = 0;
	char* pptr = (char*)ptr;

	while (cnt < len)
	{
		if (g_io_cancel_req)
		{
			LOG_PRINT(LOG_DEBUG, "::IO CANCELLED; len=%d, ret_code=%d\n\r", len, cnt);
			break;
		}

		switch (stw)
		{
			case 0: b0 = *pptr++; stw++; break;
			case 1: b1 = *pptr++; stw++; break;
			case 2: b2 = *pptr++; stw++; break;
			case 3: b3 = *pptr++;
					stw = 0;
					s32 = ((b3 << 24) | (b2 << 16) | (b1 << 8) | b0) & 0x1fff1fff;

					if (g_out_flag && altera_avalon_fifo_read_event(AIC1106_OUTPUT_FIFO_IN_CSR_BASE, ALTERA_AVALON_FIFO_STATUS_E_MSK))
					{
						g_out_fifo_udf_cnt++;
						altera_avalon_fifo_clear_event(AIC1106_OUTPUT_FIFO_IN_CSR_BASE, ALTERA_AVALON_FIFO_EVENT_ALL);
					}

					while (IORD_ALTERA_AVALON_FIFO_STATUS(AIC1106_OUTPUT_FIFO_IN_CSR_BASE) & ALTERA_AVALON_FIFO_STATUS_F_MSK)
					{
						if (g_audio_idle_fn != NULL)
						{
							g_audio_idle_fn(fd); // up to 60 msec is still safe
						}
					}
					IOWR_ALTERA_AVALON_FIFO_DATA(AIC1106_OUTPUT_FIFO_IN_BASE, s32);
					g_out_flag = 1;

					break;
		}
		cnt++;
	}

	//LOG_PRINT(LOG_DEBUG, "::handle=%d, len=%d, ret_code=%d\n\r", (int)fd->priv, len, cnt);
	return cnt;
}

int audio_ioctl(alt_fd* fd, int req, void* arg)
{
	int ret_code = -EINVAL;

	switch (req)
	{
	case AUDIO_IOCTL_SET_VOL:
		g_cur_volume = *((int*)arg) & 0x000000F;
		IOWR_ALTERA_AVALON_PIO_DATA(AIC1106_BASE, AIC1106_ENABLE | g_cur_volume);
		ret_code = AUDIO_SUCCESS;
		break;

	case AUDIO_IOCTL_GET_VOL:
		*((int*)arg) = g_cur_volume;
		ret_code = AUDIO_SUCCESS;
		break;

	case AUDIO_IOCTL_RESET:
		IOWR_ALTERA_AVALON_PIO_DATA(AIC1106_BASE, AIC1106_RESET);
		ret_code = AUDIO_SUCCESS;
		break;

	case AUDIO_IOCTL_LOOPBACK:
		IOWR_ALTERA_AVALON_PIO_DATA(AIC1106_BASE, AIC1106_LOOPBACK);
		ret_code = AUDIO_SUCCESS;
		break;

	case AUDIO_IOCTL_IOCANCEL:
		g_io_cancel_req = 1;
		ret_code = AUDIO_SUCCESS;
		break;

	default:
		break;
	}

	//LOG_PRINT(LOG_DEBUG, "handle=%d, req=%d, arg=%d, ret_code=%d\n\r", (int)fd->priv, req, *((int*)arg), ret_code);
	return ret_code;
}


int audio_io_cancel()
{
	g_io_cancel_req = 1;
	return AUDIO_SUCCESS;
	//return ioctl(0, AUDIO_IOCTL_IOCANCEL, NULL);
}

void audio_set_idle_callback(void (*idle_fn)(alt_fd* fd))
{
	g_audio_idle_fn = idle_fn;
}

int audio_write_direct(char* ptr, int len)
{
	int rval;

	if (!g_dev_opened)
	{
		audio_inp_clean();

		IOWR_ALTERA_AVALON_PIO_DATA(AIC1106_BASE, AIC1106_RESET);
		usleep(10);

		altera_avalon_fifo_clear_event(AIC1106_OUTPUT_FIFO_IN_CSR_BASE, ALTERA_AVALON_FIFO_EVENT_ALL);
		altera_avalon_fifo_clear_event(AIC1106_INPUT_FIFO_OUT_CSR_BASE, ALTERA_AVALON_FIFO_EVENT_ALL);

		// flush fifo
		while (!(IORD_ALTERA_AVALON_FIFO_STATUS(AIC1106_INPUT_FIFO_OUT_CSR_BASE) & ALTERA_AVALON_FIFO_STATUS_E_MSK))
		{
			IORD_ALTERA_AVALON_FIFO_DATA(AIC1106_INPUT_FIFO_OUT_BASE);
		}

		altera_avalon_fifo_write_ienable(AIC1106_INPUT_FIFO_OUT_CSR_BASE, ALTERA_AVALON_FIFO_IENABLE_ALL);

		IOWR_ALTERA_AVALON_PIO_DATA(AIC1106_BASE, AIC1106_ENABLE | g_cur_volume);

		g_dev_opened = 1;
		g_io_cancel_req = 0;
		g_inp_fifo_ovf_cnt = 0;
		g_out_fifo_udf_cnt = 0;
		g_out_flag = 0;
	}

	rval = audio_write(NULL, ptr, len);

	altera_avalon_fifo_write_ienable(AIC1106_INPUT_FIFO_OUT_CSR_BASE, 0);
	g_dev_opened = 0;

	if (g_out_fifo_udf_cnt > 0)
	{
		LOG_PRINT(LOG_DEBUG, "::Output stream %d times underflow detected\n\r", g_out_fifo_udf_cnt);
	}

	if (g_inp_fifo_ovf_cnt > 0)
	{
		LOG_PRINT(LOG_DEBUG, "::Input stream %d times overflow detected\n\r", g_inp_fifo_ovf_cnt);
	}

	return rval;
}

int audio_driver_init()
{
	static int g_already_initialized = FALSE;
	static alt_dev g_audio_dev =
	  {
	    ALT_LLIST_ENTRY,
	    AUDIO_DEV_PATH,
	    audio_open,
	    audio_close,
	    audio_read,
	    audio_write,
	    NULL,
	    NULL,
	    audio_ioctl
	  };

	int ret_code = AUDIO_FAIL;

	IOWR_ALTERA_AVALON_PIO_DATA(AIC1106_BASE, AIC1106_RESET);
	altera_avalon_fifo_init(AIC1106_OUTPUT_FIFO_IN_CSR_BASE,	0,	AIC1106_ALMOST_EMPTY,	AIC1106_ALMOST_FULL);
	altera_avalon_fifo_init(AIC1106_INPUT_FIFO_OUT_CSR_BASE,	0,	AIC1106_ALMOST_EMPTY,	AIC1106_ALMOST_FULL);

	if (g_already_initialized)
	{
		return AUDIO_SUCCESS;
	}

	ret_code = alt_ic_isr_register(VIC_INTERRUPT_CONTROLLER_ID, AIC1106_INPUT_FIFO_OUT_CSR_IRQ, aic1106_inp_irq_handler, NULL, NULL);
	if (ret_code != 0)
	{
		goto _EXIT;
	}

	ret_code = alt_fs_reg(&g_audio_dev);
	if (ret_code != 0)
	{
		// unregister IRQ handler
		alt_ic_isr_register(VIC_INTERRUPT_CONTROLLER_ID, AIC1106_INPUT_FIFO_OUT_CSR_IRQ, NULL, NULL, NULL);
	}

_EXIT:

	if (ret_code == AUDIO_SUCCESS)
	{
		g_already_initialized = TRUE;
	}

	return ret_code;
}

void	audio_set_volume(int volume)
{
	g_cur_volume = volume & 0x000000F;
	IOWR_ALTERA_AVALON_PIO_DATA(AIC1106_BASE, AIC1106_ENABLE | g_cur_volume);
}

int		audio_get_volume()
{
	return g_cur_volume;
}

int audio_beep(int volume, int freq, int duration_ms, int pause_ms, int beep_count)
{
	int ret_val = AUDIO_FAIL;
	//int audio_fd;
	int ix, np;
	alt_16 wav_buf[AUDIO_BEEP_BUF_DURATION_MS * (AIC1106_SAMPLE_RATE / 1000)]; // allocate buffer for AUDIO_BEEP_BUF_DURATION_MS
	float t;

	if (freq < (1.0 / (AUDIO_BEEP_BUF_DURATION_MS / 1000.0)))
	{
		freq = (1.0 / (AUDIO_BEEP_BUF_DURATION_MS / 1000.0));
	}

	if (duration_ms < 20)
	{
		duration_ms = 20;
	}

	if (pause_ms < 50)
	{
		pause_ms = 50;
	}

	np = sizeof(wav_buf) / sizeof(alt_16); //AIC1106_SAMPLE_RATE / freq;

	// generate AUDIO_BEEP_BUF_DURATION_MS of signal
	t = 0;
	for (ix = 0; ix < np; ix++)
	{
		wav_buf[ix] = floor(4095.0 * sin(2 * 3.1415926 * freq * t));
		t += 1.0 / AIC1106_SAMPLE_RATE;
	}

		audio_set_volume(volume);

		for (ix = 0; ix < beep_count; ix++)
		{
			//audio_fd = open("/mnt/audio/", O_WRONLY);
			//if (audio_fd <= 0) goto _EXIT;

			t = 0;
			while (t < duration_ms)
			{
				//write(audio_fd, wav_buf, sizeof(wav_buf));
				audio_write_direct(wav_buf, sizeof(wav_buf));
				t += 1000.0 * np / AIC1106_SAMPLE_RATE;
				if (g_io_cancel_req)
				{
					//close(audio_fd);
					goto _EXIT;
				}
			}

			//close(audio_fd);

			alt_u32 stop_tick = pause_ms / 1000.0 * alt_ticks_per_second() + alt_nticks();
			while (alt_nticks() < stop_tick)
			{
				if (g_audio_idle_fn != NULL)
				{
					g_audio_idle_fn(NULL);
					if (g_io_cancel_req) goto _EXIT;
				}
			}
		}
		ret_val = AUDIO_SUCCESS;

_EXIT:

	return ret_val;
}

alt_16* audio_read_wav(char* fname, int* samples_num)
{
    alt_16* pWavData;
    long int maxInSamples;

    int i;
    FILE *pFile;
    unsigned int stat;
    char outBuffer[80];

    WAV_HDR   WavHeader;
    CHUNK_HDR ChunkHeader;

    short int* pU;
    int sFlag;
    long int rMore;

    char* wBuffer;
    int wBufferLength;

    /* set the defaults values. */
    pWavData = NULL;
    wBuffer = NULL;
    maxInSamples = 0;
    pFile = NULL;

    /*
     * open the wav file
     */
    pFile = fopen( fname, "rb");
    if(pFile == NULL)
    {
        LOG_PRINT(LOG_ERROR, "::Can't open wav file.\n\r");
        goto _EXIT;
    }

    /* read riff/wav header */
    stat = fread((void*) &WavHeader, sizeof(WAV_HDR), (size_t)1, pFile);
    if(stat != 1)
    {
        LOG_PRINT(LOG_ERROR, "::Header missing. May be format is not OK!\n\r");
        goto _EXIT;
    }

    /* check format of header */
    for(i = 0; i < 4; i++)
    {
        outBuffer[i] = WavHeader.rID[i];
    }
    outBuffer[4] = 0;
    if(strcmp(outBuffer, "RIFF") != 0)
    {
        LOG_PRINT(LOG_ERROR, "::Bad RIFF format.\n\r");
        goto _EXIT;
    }

    for(i = 0; i < 4; i++)
    {
        outBuffer[i] = WavHeader.wID[i];
    }
    outBuffer[4] = 0;

    if(strcmp(outBuffer, "WAVE") != 0)
    {
        LOG_PRINT(LOG_ERROR, "::Bad WAVE format\n\r");
        goto _EXIT;
    }

    for(i = 0; i < 4; i++)
    {
        outBuffer[i] = WavHeader.fId[i];
    }
    outBuffer[4] = 0;

    if(strcmp(outBuffer, "fmt ") != 0) // not with "fmt" since 4th pos is blank
    {
        LOG_PRINT(LOG_ERROR, "::Bad fmt format\n\r");
        goto _EXIT;
    }

    if(WavHeader.wFormatTag != 1)
    {
        LOG_PRINT(LOG_ERROR, "::Bad wav wFormatTag\n\r");
        goto _EXIT;
    }

    /*
     * Skip over any remaining portion of wav header.
     */
    rMore = WavHeader.pcmHeaderLength - (sizeof(WAV_HDR) - 20);
    if( 0 != fseek(pFile, rMore, SEEK_CUR))
    {
        LOG_PRINT(LOG_ERROR, "::Can't seek.\n\r");
    }

    /*
     * read chunk untill a data chunk is found.
     */

    sFlag = 1;
    while(sFlag != 0)
    {
        // check attempts.
        if(sFlag > 10)
        {
        	LOG_PRINT(LOG_ERROR, "::Too many chunks\n\r");
            goto _EXIT;
        }

        // read chunk header
        stat = fread((void*)&ChunkHeader, sizeof(CHUNK_HDR), (size_t)1, pFile);
        if( 1 != stat)
        {
            LOG_PRINT(LOG_ERROR, "::Can't read data.\n\r");
            goto _EXIT;
        }

        // check chunk type.
        for(i =0; i < 4; i++)
        {
            outBuffer[i] = ChunkHeader.dId[i];
        }
        outBuffer[4] = 0;
        if(strcmp(outBuffer, "data") == 0) { break;}

        // skip over chunk.
        sFlag++;
        stat = fseek(pFile, ChunkHeader.dLen, SEEK_CUR);
        if(stat != 0)
        {
            LOG_PRINT(LOG_ERROR, "::Can't seek.\n\r");
            goto _EXIT;
        }

    }

    if (WavHeader.nSamplesPerSec != 8000)
    {
        LOG_PRINT(LOG_ERROR, "::Only 8000Hz sample rate is supported.\n\r");
        goto _EXIT;
    }

    if(WavHeader.numBitsPerSample != 16)
    {
        LOG_PRINT(LOG_ERROR, "::Only 16 bit sample is supported.\n\r");
        goto _EXIT;
    }

    if(WavHeader.numChannels != 1)
    {
        LOG_PRINT(LOG_ERROR, "::Only 1 channel is supported.\n\r");
        goto _EXIT;
    }

    /* find length of remaining data. */
    wBufferLength = ChunkHeader.dLen;

    /* find number of samples. */
    maxInSamples = ChunkHeader.dLen;
    maxInSamples /= WavHeader.numBitsPerSample/8;


    /* allocate new buffers */
    wBuffer = malloc(wBufferLength);
    if( wBuffer == NULL)
    {
        LOG_PRINT(LOG_ERROR, "::Can't allocate wBuffer.\n\r");
        goto _EXIT;
    }

    pWavData = malloc(maxInSamples*sizeof(alt_16));
    if(pWavData == NULL)
    {
        LOG_PRINT(LOG_ERROR, "::Can't allocate pWavData\n\r");
        goto _EXIT;
    }

    /* read signal data */

    stat = fread((void*)wBuffer, wBufferLength, (size_t)1, pFile);
    if( 1 != stat)
    {
        LOG_PRINT(LOG_ERROR, "::Can't read buffer.\n\r");
        free(pWavData);
        pWavData = NULL;
        goto _EXIT;
    }

    /* convert data to  13 bit linear format for AIC1106 codec*/
    pU = (alt_16*) wBuffer;
    for( i = 0; i < maxInSamples; i++)
    {
        pWavData[i] = pU[i] / 8;
    }

_EXIT:

  /* reset and delete */
   if(wBuffer != NULL)
	   free(wBuffer);

   fclose(pFile);

   *samples_num = maxInSamples;

   return pWavData;
}

int audio_write_wav_header(FILE *fw, int samples_num)
{
	unsigned int wstat;
	int i;
	char* obuff;

	WAV_HDR wav;
	CHUNK_HDR chk;

	int num_ch = 1;

	// setup wav header
	obuff = "RIFF";
	for (i = 0; i < 4; i++)
		wav.rID[i] = obuff[i];

	obuff = "WAVE";
	for (i = 0; i < 4; i++)
		wav.wID[i] = obuff[i];

	obuff = "fmt ";
	for (i = 0; i < 4; i++)
		wav.fId[i] = obuff[i];

	// setup chunk header
	obuff = "data";
	for (i = 0; i < 4; i++)
	{
		chk.dId[i] = obuff[i];
	}

	wav.numBitsPerSample = AIC1106_BITS_PER_SAMPLE;
	wav.nSamplesPerSec = AIC1106_SAMPLE_RATE;
	wav.nAvgBytesPerSec = AIC1106_SAMPLE_RATE * (AIC1106_BITS_PER_SAMPLE / 8) * num_ch;
	wav.numChannels = num_ch;

	wav.pcmHeaderLength = 16;
	wav.wFormatTag = 1;
	wav.rLen = sizeof(WAV_HDR) + sizeof(CHUNK_HDR) + samples_num*sizeof(alt_16);
	wav.numBlockAlingn = num_ch * AIC1106_BITS_PER_SAMPLE / 8;

	chk.dLen = samples_num*sizeof(alt_16);

	/* rewind file to beginning */
	fseek(fw, 0, SEEK_SET);

	/* write riff/wav header */
	wstat = fwrite((void *)&wav, sizeof(WAV_HDR), (size_t) 1, fw);
	if (wstat != 1)
	{
		LOG_PRINT(LOG_ERROR, "::Can't write wav header\n\r");
		return -2;
	}

	/* write chunk header */
	wstat = fwrite((void *)&chk, sizeof(CHUNK_HDR), (size_t) 1, fw);
	if (wstat != 1)
	{
		LOG_PRINT(LOG_ERROR, "::Can't write chk header\n\r");
		return -3;
	}

	return sizeof(WAV_HDR) + sizeof(CHUNK_HDR);
}

int audio_write_wav(char* fname, alt_16 *sample_ptr, int samples_num)
{
	FILE *fw;
	unsigned int wstat;

	/* open wav file */
	fw = fopen(fname, "wb");
	if (fw == NULL)
	{
		printf("Can't open wav file\n\r");
		return AUDIO_FAIL;
	}

	if (audio_write_wav_header(fw, samples_num) > 0)
	{
		/* write data */
		wstat = fwrite((void *) sample_ptr, samples_num * sizeof(alt_16), (size_t) 1, fw);
		if (wstat != 1)
		{
			LOG_PRINT(LOG_ERROR, "::Can't write wave data\n\r");
			return AUDIO_FAIL;
		}
	}
	fclose(fw);

	return samples_num;
}

int	audio_play_wav(char* fname)
{
	alt_16* 	buffer = NULL;
	int     	samples_num;
	int 		audio_fd;
	int			ret_val = AUDIO_FAIL;

	buffer = audio_read_wav(fname, &samples_num);

	if ((samples_num > 0) && (buffer != NULL))
	{
		audio_fd = open("/mnt/audio/", O_RDWR);

		if (audio_fd > 0)
		{
			write(audio_fd, buffer, samples_num * sizeof(alt_16));
			close(audio_fd);
			ret_val = AUDIO_SUCCESS;
		}
	}

	if (buffer != NULL)
	{
		free(buffer);
	}

	return ret_val;
}

#define AUDIO_CHUNK_SIZE	100 /*msec*/
int	audio_record_wav(char* fname, int (*rec_callback)(int time))
{
	FILE*	wav_file;
	FILE*	audio_dev;
	int    	samples_num;
	int		chunk_size;
	int		wstat;
	int 	ret_val = AUDIO_FAIL;
	char* 	audio_chunk;

	/* open wav file */
    wav_file = fopen(fname, "wb");
	if (wav_file == NULL)
	{
		LOG_PRINT(LOG_ERROR, "::Can't open wave file.\n\r");
		return ret_val;
	}

	if (audio_write_wav_header(wav_file, 0) == 0)
	{
		LOG_PRINT(LOG_ERROR, "::Can't write header to wave file.\n\r");
		return ret_val;
	}

	chunk_size = AUDIO_CHUNK_SIZE * AIC1106_SAMPLE_RATE / 1000 * sizeof(alt_16);
	audio_chunk = malloc(chunk_size);
    if(audio_chunk == NULL)
    {
        LOG_PRINT(LOG_ERROR, "::Can't allocate audio_buf.\n\r");
        return ret_val;
    }

	audio_dev = fopen("/mnt/audio/", "r");
	samples_num = 0;

	while (1)
	{
		if (rec_callback(1000 * samples_num / AIC1106_SAMPLE_RATE))
		{
			if (audio_write_wav_header(wav_file, samples_num) > 0)
			{
				ret_val = samples_num;
			}
			break;
		}

		if ((wstat=fread((void*)audio_chunk, 1, chunk_size, audio_dev)) == chunk_size)
		{
			if ((wstat=fwrite((void*)audio_chunk, 1, chunk_size, wav_file)) == chunk_size)
			{
				samples_num += chunk_size / sizeof(alt_16);
			}
			else
			{
				LOG_PRINT(LOG_ERROR, "::Can't write wave data to file (%d).\n\r", wstat);
				break;
			}
		}
		else
		{
			LOG_PRINT(LOG_ERROR, "::Can't read wave data from device (%d).\n\r", wstat);
			break;
		}
	}

	fclose(audio_dev);
	fclose(wav_file);
	free(audio_chunk);

	return ret_val;
}

int		PlayWavFile(char* fname, int volume)
{
	audio_set_volume(volume);
	return audio_play_wav(fname);
}

void 	SoundToneAlarm(int volume, int freq, int duration_ms, int pause_ms, int beep_count)
{
	audio_beep(volume, freq, duration_ms, pause_ms, beep_count);
}

