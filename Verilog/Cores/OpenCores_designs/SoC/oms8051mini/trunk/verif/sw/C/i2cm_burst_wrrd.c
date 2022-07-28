/*
 * I2C Master Burst Write and Read Test
 *
 * I2C Master Write to Slave Chip with Id: 0x20
 *
 * Burst 4 Byte Write  to address starting from 0x66 with 0x12, 0x34, 0x56 and 0x78
 * Read Back in Burst mode and verify the expected data
 */

/*---------------------------------------------------------------------------*/

#include <8051.h>

char cErrCnt;
/*---------------------------------------------------------------------------*/

__xdata __at (0xA000) unsigned char i2c_prescale_low;
__xdata __at (0xA001) unsigned char i2c_prescale_high;
__xdata __at (0xA002) unsigned char i2c_control;
volatile __xdata __at (0xA003) unsigned char i2c_data;
volatile __xdata __at (0xA004) unsigned char i2c_cmd;

void main() {
   int ErrCnt = 0;

  //Wrire Prescale registers
   i2c_prescale_low  = 0xC7;  
   i2c_prescale_high = 0x00;

  // Core Enable
  i2c_control = 0x80;
  
  // Writing Data
  i2c_data = 0x20; // Slave Addr + WR
  i2c_cmd  = 0x90;
  while(i2c_cmd & 0x2);
  
  // Memory Address 
  i2c_data = 0x66; 
  i2c_cmd  = 0x10;
  while(i2c_cmd & 0x2);
 
 /* Byte1: 12 */ 
  i2c_data = 0x12; 
  i2c_cmd  = 0x10;
  while(i2c_cmd & 0x2);
 
 /* Byte2: 34 */ 
  i2c_data = 0x34; 
  i2c_cmd  = 0x10;
  while(i2c_cmd & 0x2);

 /* Byte3: 56 */ 
  i2c_data = 0x56; 
  i2c_cmd  = 0x10;
  while(i2c_cmd & 0x2);

 /* Byte4: 78 */ 
  i2c_data = 0x78; 
  i2c_cmd  = 0x50; // Stop + Write
  while(i2c_cmd & 0x2);

  //Reading Data
  // Slave Address + Write 
  i2c_data = 0x20; 
  i2c_cmd  = 0x90; 
  while(i2c_cmd & 0x2);
   
  // Memorry Address
  i2c_data = 0x66; 
  i2c_cmd  = 0x50; // Stop 
  while(i2c_cmd & 0x2);

  //Burst Read
  i2c_data = 0x21; 
  i2c_cmd  = 0x90; 
  while(i2c_cmd & 0x2);

  /* BYTE-1 : 0x12  */ 
  i2c_cmd  = 0x20; 
  while(i2c_cmd & 0x2);
  if(i2c_data != 0x12) ErrCnt++;


   
  /* BYTE-2 : 0x34  */ 
  i2c_cmd  = 0x20; 
  while(i2c_cmd & 0x2);
  if(i2c_data != 0x34) ErrCnt++;

  /* BYTE-3 : 0x56  */ 
  i2c_cmd  = 0x20; 
  while(i2c_cmd & 0x2);
  if(i2c_data != 0x56) ErrCnt++;

  /* BYTE-4 : 0x78  */ 
  i2c_cmd  = 0x68; // STOP + RD + NACK 
  while(i2c_cmd & 0x2);
  if(i2c_data != 0x78) ErrCnt++;

    if(ErrCnt !=0) {
        P2 = 0x55; // Test Fail
        P3 = ErrCnt;
 
    } else {
       P2 = 0xAA; // Test PASS
       P3 = 0xAA; // Test PASS
    }

    while(1);

}
