/*
 * audio_drv.h
 *
 *  Created on: Jun 22, 2014
 *      Author: AlexO
 */

#ifndef AUDIO_DRV_H_
#define AUDIO_DRV_H_

#include "sys/alt_dev.h"
// -------------------- TLV320AIC1106 definitions
#define AIC1106_p3db			0
#define AIC1106_0db				1
#define AIC1106_m3db			2
#define AIC1106_m6db			3
#define AIC1106_m9db			4
#define AIC1106_m12db			5
#define AIC1106_m15db			6
#define AIC1106_m18db			7
#define AIC1106_off				AIC1106_MUTE

#define AIC1106_MUTE			0x08
#define AIC1106_ENABLE			0x10
#define AIC1106_LOOPBACK		0x20
#define AIC1106_RESET			0x40

#define AIC1106_ALMOST_EMPTY	16
#define AIC1106_ALMOST_FULL		AIC1106_OUTPUT_FIFO_IN_FIFO_DEPTH - 16
#define AIC1106_SAMPLE_RATE     8000
#define AIC1106_BITS_PER_SAMPLE	16

// ioctl codes
#define AUDIO_IOCTL_SET_VOL		0
#define AUDIO_IOCTL_GET_VOL		1
#define AUDIO_IOCTL_RESET		2
#define AUDIO_IOCTL_LOOPBACK	3
#define AUDIO_IOCTL_IOCANCEL	4

#define AUDIO_FAIL				-1
#define AUDIO_SUCCESS			0


int		audio_driver_init();

void	audio_set_volume(int volume);
int		audio_get_volume();

int		audio_beep(int volume, int freq, int duration_ms, int pause_ms, int beep_count);

alt_16* audio_read_wav(char* fname, int* samples_num);
int		audio_write_wav(char* fname, alt_16 *sample_ptr, int samples_num);

int		audio_play_wav(char* fname);
int		audio_record_wav(char* fname, int (*rec_callback)(int time));

int 	audio_io_cancel();

void	audio_set_idle_callback(void (*idle_fn)(alt_fd* fd));

int 	audio_write_direct(char* ptr, int len);

/*
 * Old API compatible functions
 * */

int		PlayWavFile(char* fname, int volume);
void 	SoundToneAlarm(int volume, int freq, int duration_ms, int pause_ms, int beep_count);

#endif /* AUDIO_DRV_H_ */
