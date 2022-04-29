"""
 *  Simple python script
 *    Functions: 
 *        - Send hardcoded data(key and plainText) and commands via UART
 *        - Receive and output ciphered data
 *
 *  Copyright 2020 by Vyacheslav Gulyaev <v.gulyaev181@gmail.com>
 *
 *  Licensed under GNU General Public License 3.0 or later. 
 *  Some rights reserved. See COPYING, AUTHORS.
 *
 * @license GPL-3.0+ <http://spdx.org/licenses/GPL-3.0+>
"""


import serial
import serial.tools.list_ports
from time import sleep

SERIAL_PORT_PATH = '/dev/ttyUSB0'
SERIAL_PORT_SPEED = 38400


CMD_SET_KEY  = 0xF0
CMD_SET_DATA = 0xE1

PAUSE_SEC = 0.1

ser = None
receivedData = None


def main():
    ports = serial.tools.list_ports.comports(include_links=False)
    for port in ports :
        print(port.device)

    ser = serial.Serial(SERIAL_PORT_PATH, SERIAL_PORT_SPEED, timeout = 1)

    key       = [0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF]    
    plainText = [0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F]

    print ('Sendeded CMD_SET_KEY:', format(CMD_SET_KEY, '02x'))
    print ('Sending Key         :', '  '.join(format(byte, '02x') for byte in key))
    ser.write(chr(CMD_SET_KEY))
    sleep(PAUSE_SEC)
    for byte_key in key:
        ser.write(chr(byte_key)) 

    print ('Sendeded CMD_SET_DATA:', format(CMD_SET_DATA, '02x'))
    print ('Sending plainText:', '  '.join(format(byte, '02x') for byte in plainText))
    ser.write(chr(CMD_SET_DATA))
    sleep(PAUSE_SEC)
    for byte_plainText in plainText:
        ser.write(chr(byte_plainText)) 

    print ('Waiting ciphered data...')
    received_ok = False;
    while (received_ok==False):
        receivedData = ser.readline()
        if (len(receivedData)>0):
            print('Data:', '  '.join(format(ord(byte), '02x') for byte in receivedData))
            received_ok = True



if __name__ == "__main__":
    main()    

