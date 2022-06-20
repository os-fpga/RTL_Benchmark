# -*- coding: iso-8859-1 -*-

##########################################################################
# USPP Library (Universal Serial Port Python Library)
#
# Copyright (C) 2006 Isaac Barona <ibarona@gmail.com>
# 
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
# 
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.

# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
##########################################################################

#-------------------------------------------------------------------------
# Project:   USPP Library (Universal Serial Port Python Library)
# Name:      SerialPort_win.py
# Purpose:   Handle low level access to serial port in windows.
#
# Author:    Isaac Barona Martinez <ibarona@gmail.com>
# Copyright: (c) 2001 by Isaac Barona Martínez
# Licence:   LGPL
#
# Created:   26 June 2001
# History:
# 20 January 2002 : Damien Géranton <dgeranton@voila.fr>
#  Bug fix for Win2000, the file must not be open with
#  FILE_FLAG_OVERLAPPED
#
#-------------------------------------------------------------------------

"""
SerialPort_win.py - Handle low level access to serial port in windows.

See also uspp module docstring.

"""
import sys
from struct import *
from win32file import *
from win32event import *
import win32con
import exceptions

class SerialPortException(exceptions.Exception):
    """Exception raise in the SerialPort methods"""
    def __init__(self, args=None):
        self.args=args


class SerialPort:
    """Encapsulate methods for accesing to a serial port."""

    BaudRatesDic={110: CBR_110,
                  300: CBR_300,
                  600: CBR_600,
                  1200: CBR_1200,
                  2400: CBR_2400,
                  4800: CBR_4800, 
                  9600: CBR_9600,
                  19200: CBR_19200,
                  38400: CBR_38400,
                  57600: CBR_57600,
                  115200: CBR_115200
                  }

    def __init__(self, dev, timeout=None, speed=115200, mode='232', params=None):
        """Open the serial port named by the string 'dev'

        'dev' can be any of the following strings: 'COM1', 'COM2', ... 'COMX'
        
        'timeout' specifies the inter-byte timeout or first byte timeout
        (in miliseconds) for all subsequent reads on SerialPort.
        If we specify None time-outs are not used for reading operations
        (blocking reading).
        If 'timeout' is 0 then reading operations are non-blocking. It
        specifies that the reading operation is to return inmediately
        with the bytes that have already been received, even if
        no bytes have been received.
        
        'speed' is an integer that specifies the input and output baud rate to
        use. Possible values are: 110, 300, 600, 1200, 2400, 4800, 9600,
        19200, 38400, 57600 and 115200.
        If None a default speed of 9600 bps is selected.
        
        'mode' specifies if we are using RS-232 or RS-485. The RS-485 mode
        is half duplex and use the RTS signal to indicate the
        direction of the communication (transmit or recive).
        Default to RS232 mode (at moment, only the RS-232 mode is
        implemented).

        'params' is a list that specifies properties of the serial 
        communication.
        If params=None it uses default values for the number of bits
        per byte (8), the parity (NOPARITY) and the number of stop bits (1)
        else params must be a list with three items setting up the 
        these values in this order.

        """
        self.wait = 1024
        self.__devName, self.__timeout, self.__speed=dev, timeout, speed
        self.__mode=mode
        self.__params=params
        self.__speed = 0
        self.__reopen = 0
        while 1:
            try:
                self.__handle=CreateFile (dev,
                win32con.GENERIC_READ|win32con.GENERIC_WRITE,
                0, # exclusive access
                None, # no security
                win32con.OPEN_EXISTING,
                win32con.FILE_ATTRIBUTE_NORMAL,
                None)
                break
                        
            except:
                n=0
                while (n < 2000000):
                    n += 1;                
                self.__reopen = self.__reopen + 1
            if self.__reopen > 32:
                print "Port does not exist..."
                sys.exit()
        self.__configure()

    def __del__(self):
        """Close the serial port
        
        To close the serial port we have to do explicity: del s
        (where s is an instance of SerialPort)
        """
        if self.__speed:
            try:
                CloseHandle(self.__handle)
            except:
                raise SerialPortException('Unable to close port')


            

    def __configure(self):
        """Configure the serial port.

        Private method called in the class constructor that configure the 
        serial port with the characteristics given in the constructor.
        """
        if not self.__speed:
            self.__speed=115200
        # Tell the port we want a notification on each char
        SetCommMask(self.__handle, EV_RXCHAR)
        # Setup a 4k buffer
        SetupComm(self.__handle, 4096, 4096)
        # Remove anything that was there
        PurgeComm(self.__handle, PURGE_TXABORT|PURGE_RXABORT|PURGE_TXCLEAR|
                  PURGE_RXCLEAR)

        # Setup the timeouts parameters for the port
        # timeouts is a tuple with the following items:
        # [0] int : ReadIntervalTimeout
        # [1] int : ReadTotalTimeoutMultiplier
        # [2] int : ReadTotalTimeoutConstant
        # [3] int : WriteTotalTimeoutMultiplier
        # [4] int : WriteTotalTimeoutConstant

        if self.__timeout==None:
            timeouts= 0, 0, 0, 0, 0
        elif self.__timeout==0:
            timeouts = win32con.MAXDWORD, 0, 0, 0, 1000
        else:
            timeouts= self.__timeout, 0, self.__timeout, 0 , 1000
        SetCommTimeouts(self.__handle, timeouts)

        # Setup the connection info
        dcb=GetCommState(self.__handle)
        dcb.BaudRate=SerialPort.BaudRatesDic[self.__speed]
        if not self.__params:
            dcb.ByteSize=8
            dcb.Parity=NOPARITY
            dcb.StopBits=ONESTOPBIT
        else:
            dcb.ByteSize, dcb.Parity, dcb.StopBits=self.__params
        SetCommState(self.__handle, dcb)
        

    def fileno(self):
        """Return the file descriptor for opened device.

        This information can be used for example with the 
        select function.
        """
        return self.__handle


    def read(self, num=1):
        """Read num bytes from the serial port.

        If self.__timeout!=0 and != None and the number of read bytes is less
        than num an exception is generated because a timeout has expired.
        If self.__timeout==0 read is non-blocking and inmediately returns
        up to num bytes that have previously been received.
        """

        (Br, buff) = ReadFile(self.__handle, num)
        if len(buff)<>num and self.__timeout!=0: # Time-out  
            raise SerialPortException('Timeout')
        else:
            return buff


    def readline(self):
        """Read a line from the serial port.  Returns input once a '\n'
        character is found.
        
        """

        s = ''
        while not '\n' in s:
            s = s+SerialPort.read1(self,1)

        return s 


    def write(self, s):
        """Write the string s to the serial port"""
        overlapped=OVERLAPPED()
        overlapped.hEvent=CreateEvent(None, 0,0, None)
        WriteFile(self.__handle, s, overlapped)
        # Wait for the write to complete
        WaitForSingleObject(overlapped.hEvent, INFINITE)
        
    def write_2bytes(self, msb,lsb):
        """Write one word MSB,LSB to the serial port MSB first"""
        overlapped=OVERLAPPED()
        overlapped.hEvent=CreateEvent(None, 0,0, None)
        WriteFile(self.__handle, pack('BB', msb, lsb), overlapped)
        # Wait for the write to complete
        #WaitForSingleObject(overlapped.hEvent, INFINITE)        

    def write_word(self, word):
        """Write one word MSB,LSB to the serial port MSB first"""
        overlapped=OVERLAPPED()
        overlapped.hEvent=CreateEvent(None, 0,0, None)
        WriteFile(self.__handle, pack('h', word), overlapped)
        # Wait for the write to complete
        #WaitForSingleObject(overlapped.hEvent, INFINITE)
        
    def write_buf_cmd(self, buffer):
        """Write one word MSB,LSB to the serial port MSB first"""
        a=0
	if (len(buffer) < 44):  # if buffer is shorter than expected then pad with read array mode commands
            i=0
            while i<len(buffer):
                print '0x%02x'%(ord(buffer[i]))
                i+=1
            while(a < len(buffer)):
                overlapped=OVERLAPPED()
                overlapped.hEvent=CreateEvent(None, 0,0, None)
                if a < 10:
                    WriteFile(self.__handle, pack('2c', buffer[a], buffer[a+1]), overlapped)
                elif a < len(buffer)-2:
                    WriteFile(self.__handle, pack('2c', buffer[a+1], buffer[a]), overlapped)    
                elif  len(buffer)==2:
                    WriteFile(self.__handle, pack('2c', buffer[a], buffer[a+1]), overlapped)
                else:
                     WriteFile(self.__handle, pack('2c', buffer[a], chr(0xFF)), overlapped)
                a+=2       
        else:
            overlapped=OVERLAPPED()
            overlapped.hEvent=CreateEvent(None, 0,0, None)
            #first 10 bytes are in correct order + 32 data bytes are in wrong order and + 2 confirm bytes are in correct order
            WriteFile(self.__handle, pack('44c', 
            buffer[0], buffer[1], buffer[2], buffer[3], buffer[4], buffer[5], buffer[6], buffer[7],
            buffer[8], buffer[9], buffer[11], buffer[10], buffer[13], buffer[12], buffer[15], buffer[14],
            buffer[17], buffer[16], buffer[19], buffer[18], buffer[21], buffer[20], buffer[23], buffer[22],
            buffer[25], buffer[24], buffer[27], buffer[26], buffer[29], buffer[28], buffer[31], buffer[30],
            buffer[33], buffer[32], buffer[35], buffer[34], buffer[37], buffer[36], buffer[39], buffer[38],
            buffer[41], buffer[40], buffer[42], buffer[43]
            ), overlapped)
        
        # Wait for the write to complete
        #WaitForSingleObject(overlapped.hEvent, INFINITE)        
        n = 0
	while (n < self.wait):
		n += 1;
        
        
    def inWaiting(self):
        """Returns the number of bytes waiting to be read"""
        flags, comstat = ClearCommError(self.__handle)
        return comstat.cbInQue

    def flush(self):
        """Discards all bytes from the output or input buffer"""
        PurgeComm(self.__handle, PURGE_TXABORT|PURGE_RXABORT|PURGE_TXCLEAR|
                  PURGE_RXCLEAR)



        

