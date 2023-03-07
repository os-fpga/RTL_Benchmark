//
//	Note:
//	Some SPI device may needs to enable Quad Transfer bit
//	before execute Quad I/O.
//	Check 4X I/O patterns when adding new SPI device model

#ifndef FLASH_DEVICE
	#define MX66L1G45G
#endif

#ifdef  MX25L1633E
	#define DEVICE_ID		0x1524c2
	#define DEVICE_SIZE		0x200000u
	#define DEVICE_PAGE_SIZE	0x000100u
	#define DEVICE_SUPPORT_DUAL
	#define DEVICE_SUPPORT_QUAD
	#define DEVICE_SUPPORT_QUAD_WRITE
	#define DEVICE_SUPPORT_SPECIAL_TOKEN
#endif
#ifdef  MX25U1635E
// default MXIC MX25U1635E 16 Mbit Serial Flash
	#define DEVICE_ID		0x3525c2
	#define DEVICE_SIZE		0x200000u
	#define DEVICE_PAGE_SIZE	0x000100u
	#define DEVICE_SUPPORT_DUAL
	#define DEVICE_SUPPORT_QUAD
	#define DEVICE_SUPPORT_QUAD_WRITE
	#define DEVICE_SUPPORT_SPECIAL_TOKEN
#endif
#ifdef  MX66L1G45G
// default MXIC MX66L1G45G 1G-bit Serial Flash
	#define DEVICE_ID		0x1b20c2
	#define DEVICE_SIZE		0x8000000u
	#define DEVICE_PAGE_SIZE	0x000100u
	#define DEVICE_SUPPORT_DUAL
	#define DEVICE_SUPPORT_QUAD
	#define DEVICE_SUPPORT_QUAD_WRITE
	#define DEVICE_SUPPORT_SPECIAL_TOKEN
#endif

#ifdef  spi_flash
// default MXIC MX66L1G45G 1G-bit Serial Flash
	#define DEVICE_ID		0x1b20c2
	#define DEVICE_SIZE		0x8000000u
	#define DEVICE_PAGE_SIZE	0x000100u
	#define DEVICE_SUPPORT_DUAL
	#define DEVICE_SUPPORT_QUAD
	#define DEVICE_SUPPORT_QUAD_WRITE
	#define DEVICE_SUPPORT_SPECIAL_TOKEN
#endif

// Flash Command
#define SPI_CMD_READ      0x03  // Read data
#define SPI_CMD_FAST_READ 0x0b  // Fast read data
#define SPI_CMD_2READ     0xbb  // 2x I/O read
#define SPI_CMD_4READ     0xeb  // 4x I/O read
#define SPI_CMD_RDID      0x9f  // Read ID
#define SPI_CMD_READ_ID   0x90  // Read ID
#define SPI_CMD_WREN      0x06  // Write enable
#define SPI_CMD_WRDI      0x04  // Write disable
#define SPI_CMD_SE        0x20	// Sector erase
#define SPI_CMD_BE        0xd8  // Block erase
#define SPI_CMD_CE        0xc7  // Chip erase
#define SPI_CMD_PP        0x02  // Page program
#define SPI_CMD_4PP       0x38  // Quad page program
#define SPI_CMD_RDSR      0x05  // Read status register
#define SPI_CMD_WRSR      0x01  // Write status register
#define SPI_CMD_DP        0xb9  // Deep power down
#define SPI_CMD_RES       0xab  // Release from deep power down
#define SPI_CMD_EN4B	  0xB7

// Status byte
#define FLASH_STATUS_WIP_MASK   0x01
#define FLASH_STATUS_WEL_MASK   0x02
#define FLASH_STATUS_QE_MASK    0x40
#define FLASH_CONFIG_4BYTE_MASK    0x20

// ATCSPI200 Register SPI Interface Timing Setting
// CS_CLK    [13:12]  0x00
// CSHT      [11:8]   0x02
// SCLK_DIV  [7:0]    0x10
#define REG_TIMING         0x00000210

#define WORD_TO_BYTES(b3, b2, b1, b0, w0) do {\
	b0=(uint8_t)(w0);\
	b1=(uint8_t)((w0)>>8);\
	b2=(uint8_t)((w0)>>16);\
	b3=(uint8_t)((w0)>>24);} while (0)

#define BYTES_TO_WORD(w0, b3, b2, b1, b0) \
	w0=((b3)<<24)|((b2)<<16)|((b1)<<8)|(b0)


static const char lut_br[16] = {0x0, 0x8, 0x4, 0xc, 0x2, 0xa, 0x6, 0xe,
	0x1, 0x9, 0x5, 0xd, 0x3, 0xb, 0x7, 0xf};

#define BIT_REVERT8(x) (lut_br[((x) & 0xf0) >> 4] | lut_br[(x) & 0xf] << 4)

#define BIT_REVERT_BY_BYTE(x) (\
		BIT_REVERT8((x) >>  0) <<  0 |\
		BIT_REVERT8((x) >>  8) <<  8 |\
		BIT_REVERT8((x) >> 16) << 16 |\
		BIT_REVERT8((x) >> 24) << 24)

#define BIT_REVERT24(x) (\
		BIT_REVERT8((x) >>  0) << 16 |\
		BIT_REVERT8((x) >>  8) <<  8 |\
		BIT_REVERT8((x) >> 16) <<  0)

void spi_wait_intr(uint32_t intr_types);
void spi_isr(uint32_t int_no);
void spi_install_isr();
void spi_exe_cmd(uint8_t cmd, uint32_t addr,
		uint32_t rcnt, uint32_t *rbuf, uint32_t wcnt, uint32_t *wbuf);
void flash_write_enable();
void flash_check_wip();
void flash_chip_erase();
void flash_sector_erase(uint32_t addr);
void flash_block_erase(uint32_t addr);
void flash_4b_enable(uint32_t);

