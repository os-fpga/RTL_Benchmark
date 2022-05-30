#! /usr/bin/python
# -*- coding: ISO-8859-1 -*-

##########################################################################
# LPC Dongle programming software 
#
# Copyright (C) 2006 Artec Design
# 
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
# 
# This software is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.

# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
##########################################################################

#-------------------------------------------------------------------------
# Project:   LPC Dongle programming software 
# Name:      dongle.py
# Purpose:   Executable command line tool 
#
# Author:    J’ri Toomessoo <jyrit@artecdesign.ee>
# Copyright: (c) 2006 by Artec Design
# Licence:   LGPL
#
# Created:   06 Oct. 2006
# History:   12 oct. 2006  Version 1.0 released
#            22 Feb. 2007  Test options added to test PCB board
#            14 Nov. 2007  Moved dongle spesific code to class Dongle from USPP
#                          USPP is allmost standard now (standard USPP would work)
#                          Artec USPP has serial open retry
#            14 Nov. 2007  Improved help. 
#-------------------------------------------------------------------------

import os
import sys
import string
import time
from sets import *
from struct import *
from Uspp.uspp import *

#### global funcs ####
def usage(s):
    print "Artec USB Dongle programming utility ver. 2.0"
    print "Usage:"
    print "Write file      : ",s," [-vq] -c <name> <file> <offset>"
    print "Readback file   : ",s," [-vq] -c <name> [-vq] -r <offset> <length> <file>"
    print "Options:"
    print " <file> <offset> When file and offset are given file will be written to dongle"
    print "        file:    File name to be written to dongle"
    print "        offset:  Specifies data writing starting point in bytes to 4M window"
    print "                 For ThinCan boot code the offset = 4M - filesize. To write"
    print "                 256K file the offset must be 3840K"
    print " "
    print " -c <name>       Indicate port name where the USB Serial Device is"
    print "        name:    COM port name in Windows or Linux Examples: COM3,/dev/ttyS3"
    print "                 See Device Manager in windows for USB Serial Port number"
    print " "
    print " -v              Enable verbose mode. Displays more progress information"
    print " "
    print " -q              Perform flash query to see if dongle flash is responding"
    print " "
    print " -r <offset> <length> <file>  Readback data. Available window size is 4MB"
    print "        offset:  Hexademical offset byte addres inside 4MB window"
    print "        length:  Amount in bytes to read starting from offset. Example: 1M"
    print "                 use M for MegaBytes, K for KiloBytes, none for bytes"
    print "        file:    Filename where data will be written"
    print " "
    print " -e              Erase device. Erases Full 4 MegaBytes"    
    print "Board test options: "
    print " -t              Marching one and zero test. Device must be empty"
    print "                 To test dongle erase the flash with command -e"
    print "                 Enables dongle memory tests to be executed by user"
    print " "
    print " -b              Leave flash blanc after test. Used with option -t"
    print ""       
    print "Examples:"
    print ""
    print " ",s," -c COM3 loader.bin 0                       "
    print " ",s," -c /dev/ttyS3 boot.bin 3840K"
    print " ",s," -c COM3 -r 0x3C0000 256K flashcontent.bin"
######################


class DongleMode:
    def __init__(self):
        self.v = 0
        self.f = 0
        self.d = 0
        self.q = 0
        self.r = 0
        self.t = 0
        self.e = 0
        self.b = 0        
        self.filename=""
        self.portname=""
        self.address=-1
        self.offset=-1
        self.length=-1
     
    def convParamStr(self,param):
        mult = 1
        value = 0
        str = param
        if str.find("K")>-1:
            mult = 1024
            str=str.strip("K")
        if str.find("M")>-1:
            mult = 1024*1024
            str=str.strip("M")
        try:    
            if str.find("x")>-1:
                value = int(str,0)*mult  #conver hex string to int
            else:
                value = int(str)*mult  #conver demical string to int
        except ValueError:
            print "Bad parameter format given for: ",param

        return value

    
    
    
class Dongle:
    def __init__(self,name, baud, timeout):  #time out in millis 1000 = 1s baud like 9600, 57600
        try:
	    self.tty = SerialPort(name,timeout, baud) 
        except SerialPortException , e:
            print "Unable to open port " + name
            sys.exit();

    def testReturn(self,byteCount):
        i=0
        while don.tty.inWaiting()<byteCount:
            i=i+1
            if i==10000*byteCount:
                break
        if i==10000*byteCount:
            return 0
        return don.tty.inWaiting()  ## ret two bytes            
            
    def getReturn(self,byteCount):
        i=0
        while don.tty.inWaiting()<byteCount:
            i=i+1
            if i==10000*byteCount:
                break
        if i==10000*byteCount:
            print "Dongle not communicating"
            sys.exit()
        return don.tty.read(byteCount)  ## ret two bytes
    

    def write_command(self,command):
        lsb = command&0xff
        msb = (command>>8)&0xff
        self.write_2bytes(msb,lsb)
        
    def write_2bytes(self, msb,lsb):
        """Write one word MSB,LSB to the serial port MSB first"""
        s = pack('BB', msb, lsb)
        self.tty.write(s)
        # Wait for the write to complete
        #WaitForSingleObject(overlapped.hEvent, INFINITE)               

    def get_address_buf(self,address):  #set word address
        lsbyte = address&0xff
        byte = (address>>8)&0xff
        msbyte = (address>>16)&0xff
        buffer = ""
        buffer += chr(lsbyte)
        buffer += chr(0xA0)
        buffer +=  chr(byte)
        buffer +=  chr(0xA1)
        buffer +=  chr(msbyte)
        buffer +=  chr(0xA2)
        evaluate = (address>>24)
        if evaluate != 0:
            print "Addressign fault. Too large address passed"
            sys.exit()
        return buffer
        

    def set_address(self,address):  #set word address
        lsbyte = address&0xff
        byte = (address>>8)&0xff
        msbyte = (address>>16)&0xff
        evaluate = (address>>24)
        if evaluate != 0:
            print "Addressign fault. Too large address passed"
            sys.exit()
        self.write_2bytes(lsbyte,0xA0)            #set internal address to dongle
        self.write_2bytes(byte,0xA1)            #set internal address to dongle
        self.write_2bytes(msbyte,0xA2)            #send query command

    def read_data(self,wordCount,address):
        command = 0
        byteCount = wordCount<<1  #calc byte count
        if wordCount>0 :
            command = (command|wordCount)<<8;
            command = command|0xCD
            self.set_address(address)    # send read address
            self.write_command(command)  # send get data command
            return self.getReturn(byteCount)
        else:
            print "Word count can't be under 1"
            sys.exit() 
            
    def read_status(self):
        don.write_command(0x0070) # 0x0098 //clear status
        command = 0
        wordCount= 1  #calc byte count
        byteCount = wordCount<<1
        command = (command|wordCount)<<8;
        command = command|0xCD
        self.write_command(command)  # send get data command
        return self.getReturn(byteCount)

    
    def get_block_no(self,address):
        return address >> 16 # 16 bit mode block is 64Kwords
    
    def wait_on_busy(self):
        exit=0
        while exit==0:
            buf=self.read_status()
            statReg = ord(buf[0])  #8 bit reg
            if statReg>>7 == 1:
                exit=1
                
    def parse_status(self):  # use only after wait on busy commad to get result of the operation
        exit = 0
        buf=self.read_status()
        statReg = ord(buf[0])  #8 bit reg
        if (statReg>>5)&1 == 1:
            print "Block erase suspended"
            exit = 1
        if (statReg>>4)&3 == 3:
            print "Error in command order"  #if bits 4 and 5 are set then 
            exit = 1
        if (statReg>>4)&3 == 1:
            print "Error in setting lock bit"
            exit = 1
        if (statReg>>3)&1 == 1:
            print "Low Programming Voltage Detected, Operation Aborted"        
            exit = 1
        if (statReg>>2)&1 == 1:
            print "Programming suspended"                
            exit = 1
        if (statReg>>1)&1 == 1:
            print "Block lock bit detected"   
            exit = 1
        if exit == 1:
            sys.exit()
                
    def erase_block(self,blockNo):
        blockAddress = blockNo << 16
        command = 0x0020
        self.set_address(blockAddress)
        self.write_command(command)  #issue block erase
        command = 0x00D0
        self.write_command(command)  #issue block erase confirm
        self.wait_on_busy()
        self.parse_status()
    
    def buffer_write(self,wordCount,startAddress,buffer):
        # to speed up buffer writing compose all commands into one buffer
        # instead of multiple single writes this is needed as the FTDI chip
        # round lag is amazingly large with VCOM drivers
        #u = len(buffer)
        if len(buffer)<32:            #don't ever make unaligned writes
            i=len(buffer)
            while len(buffer)<32:
                buffer += "\xff"
        adrBuf = self.get_address_buf(startAddress)   #6 bytes total
        cmd_e8=""  #8 bytes total
        cmd_e8+= chr(16)   #make it always 16 wordCount
        cmd_e8+= chr(0xE8)              
        cmd_wcnt=""  #10 bytes total
        cmd_wcnt+= chr(0x00)
        cmd_wcnt+= chr(16-1)        
        cmd_buf=""  #12 bytes total
        cmd_buf+= chr(0x00)
        cmd_buf+= chr(0xD0)
        wr_buffer_cmd = adrBuf + cmd_e8 + cmd_wcnt + buffer + cmd_buf   #44 bytes total
        self.write_buf_cmd(wr_buffer_cmd)
        # no wait needad as the FTDI chip is so slow

    def write_buf_cmd(self, buffer):
        """Write one word MSB,LSB to the serial port MSB first"""
        a=0
        s=""
	if (len(buffer) < 44):  # if buffer is shorter than expected then pad with read array mode commands
            i=0
            while i<len(buffer):
                print '0x%02x'%(ord(buffer[i]))
                i+=1
            while(a < len(buffer)):
                if a < 10:
                    s= pack('2c', buffer[a], buffer[a+1])
                    self.tty.write(s)
                elif a < len(buffer)-2:
                    s= pack('2c', buffer[a+1], buffer[a])
                    self.tty.write(s)
                elif  len(buffer)==2:
                    s=pack('2c', buffer[a], buffer[a+1])
                    self.tty.write(s)
                else:
                     s=pack('2c', buffer[a], chr(0xFF))
                     self.tty.write(s)
                a+=2       
        else:
            #first 10 bytes are in correct order + 32 data bytes are in wrong order and + 2 confirm bytes are in correct order
            s=pack('44c', 
            buffer[0], buffer[1], buffer[2], buffer[3], buffer[4], buffer[5], buffer[6], buffer[7],
            buffer[8], buffer[9], buffer[11], buffer[10], buffer[13], buffer[12], buffer[15], buffer[14],
            buffer[17], buffer[16], buffer[19], buffer[18], buffer[21], buffer[20], buffer[23], buffer[22],
            buffer[25], buffer[24], buffer[27], buffer[26], buffer[29], buffer[28], buffer[31], buffer[30],
            buffer[33], buffer[32], buffer[35], buffer[34], buffer[37], buffer[36], buffer[39], buffer[38],
            buffer[41], buffer[40], buffer[42], buffer[43]
            )
            self.tty.write(s)
        
        # Wait for the write to complete
        #WaitForSingleObject(overlapped.hEvent, INFINITE)        
        n = 0
        if sys.platform=='win32':
            while (n < 1024):
		n += 1;
        elif sys.platform=='linux2':
            #Linux FTDI VCP driver is way faster and needs longer grace time than windows driver
            while (n < 1024*7):
		n += 1;            
        
        
################## Main program #########################


last_ops = 0
mode = DongleMode()
# PARSE ARGUMENTS 
for arg in sys.argv:
    if len(sys.argv) == 1: # if no arguments display help
       #usage(sys.argv[0])
       usage("dongle.py")
       sys.exit()        
    if arg in ("-h","--help","/help","/h"):
        #usage(sys.argv[0])
        usage("dongle.py")
        sys.exit()
    if arg in ("-c"):
        last_ops = sys.argv.index(arg) + 1  #if remains last set of options from here start ordered strings
        i = sys.argv.index(arg)
        print "Opening port: "+sys.argv[i+1]
        mode.portname = sys.argv[i+1]   # next element after -c open port for usage
    if arg[0]=="-" and arg[1]!="c": # if other opptions
        # parse all options in this
        last_ops = sys.argv.index(arg)  #if remains last set of options from here start ordered strings
        ops = arg[1:]# get all besides the - sign
        for op in ops:
            if op=="q":
                mode.q = 1
            if op=="v":
                mode.v = 1
            if op=="f":
                mode.f = 1
            if op=="d":
                mode.d = 1
            if op=="r":
                mode.r = 1
            if op=="t":
                mode.t = 1  
            if op=="e":
                mode.e = 1   
            if op=="b":
                mode.b = 1                   
    else:
        i = sys.argv.index(arg)
        if i ==  last_ops + 1:
            if mode.r==1:
                mode.offset=mode.convParamStr(arg)
            else:
                mode.filename=arg
        if i ==  last_ops + 2:
            if mode.r==1:
                mode.length=mode.convParamStr(arg)
            else:
                mode.address=mode.convParamStr(arg)
                
        if i ==  last_ops + 3:
            if mode.r==1:
                mode.filename=arg
            else:
                print "Too many parameters provided"
                sys.exit()
        if i >  last_ops + 3:
             print "Too many parameters provided"
             sys.exit()  

# END PARSE ARGUMENTS             
             
if mode.portname=="":
    print "No port name given see -h for help"
    sys.exit()    
else:
    # test PC speed to find sutable delay for linux driver
    # to get 250 us 
    mytime = time.clock()
    n = 0
    while (n < 100000):
	n += 1;
    k10Time = time.clock() - mytime   # time per 10000 while cycles
    wait = k10Time/100000.0     # time per while cycle
    wait = (0.00025/wait) * 1.20   # count for 250us + safe margin
    # ok done
    reopened = 0

    don  = Dongle(mode.portname,115200,100)
    don.tty.wait = wait   
    while 1:
        don.write_command(0x0050) # 0x0098
        don.write_command(0x00C5)            #send dongle check internal command
        don_ret=don.testReturn(2)
        if don_ret==2:
            break
        if reopened == 3:
             print 'Dongle connected, but does not communicate'
             sys.exit()
        reopened = reopened + 1
        # reopen and do new cycle
        don = Dongle(mode.portname,115200,100)
        don.tty.wait = wait   

    buf=don.getReturn(2)  # two bytes expected to this command
          
    if ord(buf[1])==0x32 and  ord(buf[0])==0x10:
        print "Dongle OK"
    else:
        print 'Dongle returned on open: %02x %02x '%(ord(buf[1]), ord(buf[0]))
 
    
if mode.q == 1:   # perform a query from dongle
    
    buf=don.read_data(4,0x0)  # word count and word address
    don.write_command(0x0050) # 0x0098
    don.write_command(0x0098) # 0x0098
    buf=don.read_data(3,0x000010)  # word count and word address
    if ord(buf[0])==0x51 and  ord(buf[2])==0x52 and  ord(buf[4])==0x59:
        buf=don.read_data(2,0x000000)  # word count and word address
        print 'Query  OK, Factory: 0x%02x device: 0x%02x '%(ord(buf[0]),ord(buf[2]))
        buf=don.read_data(2,0x000002)
	print 'lock bit is 0x%02x 0x%02x'%(ord(buf[0]),ord(buf[1]))
    else:
        print "Got bad query data:"
        print 'Query address 0x10 = 0x%02x%02x '%(ord(buf[1]),ord(buf[0]))
        print 'Query address 0x12 = 0x%02x%02x '%(ord(buf[3]),ord(buf[2]))
        print 'Query address 0x14 = 0x%02x%02x '%(ord(buf[5]),ord(buf[4]))    
        print "Read byte count:",len(buf)
 
    don.write_command(0x00FF) # 0x0098
    buf=don.read_data(4,0xff57c0>>1)  # word count and word address

    print 'Data: 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x '%(ord(buf[1]),ord(buf[0]),ord(buf[3]),ord(buf[2]),ord(buf[5]),ord(buf[4]),ord(buf[7]),ord(buf[6]) )

    
    
if mode.filename!="" and mode.address!=-1:
    #Calculate number of blocks and start of blocks
    size = 0
    mode.address = mode.address>>1  #make word address
    try:
        f=open(mode.filename,"rb")
        f.seek(0,2) #seek to end
        size = f.tell()
        f.seek(0) #seek to start
        print 'File size %iK '%(size/1024)
        f.close()
    except IOError:
         print "IO Error on file open"
         sys.exit()
    #clear blockLock bits
    don.write_command(0x0060) # 0x0098
    don.write_command(0x00D0) # 0x0098
    don.wait_on_busy()
    don.parse_status()
    wordSize = (size+ (size&1))>> 1    # round byte count up and make word address
    endBlock = don.get_block_no(mode.address+wordSize - 1)  
    startBlock = don.get_block_no(mode.address)
    i=startBlock
    print 'Erasing from block %i to %i '%(i,endBlock)
    while i <= endBlock:
        if mode.v == 1:
            print 'Erasing block %i '%(i)
        else:
            sys.stdout.write(".")
            sys.stdout.flush()
        don.erase_block(i)
        don.wait_on_busy()
        don.parse_status()   #do this after programming all but uneaven ending
        i=i+1
    if mode.v == 0:
        print " "
    #don.write_command(0x00FF) # 0x0098
    #buf=don.read_data(4,0x000000)  # word count and word address     
    #print 'Data: 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x '%(ord(buf[0]),ord(buf[1]),ord(buf[2]),ord(buf[3]),ord(buf[4]),ord(buf[5]),ord(buf[6]),ord(buf[7]) )

    f=open(mode.filename,"rb")
    f.seek(0) #seek to start
    address= mode.address
    #don.set_address(address)
    print 'Writing %iK'%(size/1024)
    while 1:
        if (address/(1024*64) != (address-16)/(1024*64)) and address != mode.address:  # get bytes from words if 512
            if mode.v == 1:
                print 'Progress: %iK of %iK at 0x%06x'%((address-mode.address)/512,size/1024,address)
            else:
                sys.stdout.write(".")
                sys.stdout.flush()
        buf = f.read(32)  #16 words is maximum write here bytes are read
        if len(buf)==32:
            don.buffer_write(16,address,buf)
            address = address + 16
        elif len(buf)>0:
            don.parse_status()   #do this after programming all but uneaven ending
            print "Doing an unaligned write..."
            length = len(buf)
            length = (length + (length&1))>> 1   #round up to get even word count
            buf = buf+"\xff"   #pad just in case rounding took place
            don.buffer_write(len,address,buf)
            address = address + 16     #inc word address
            break
        else:
            break
    if mode.v == 0:
        print " "
    print "Write DONE!"
    don.parse_status()   #do this after programming all but uneaven ending
    f.close()
    
if mode.r == 1:   # perform a readback
    if mode.offset!=-1 and mode.length!=-1 and mode.filename!="":
        mode.offset=mode.offset>>1    #make word offset
        mode.length= mode.length>>1   #make word length
        print 'Reading %iK'%(mode.length/512)
        try:
            f=open(mode.filename,"wb")
            don.write_command(0x00FF) #  put flash to data read mode
            address = mode.offset    # set word address
            while 1:
                if address/(1024*32) != (address-128)/(1024*32):  # get K bytes from words if 512
                    if mode.v == 1:
                        print 'Progress: %iK of %iK'%((address-mode.offset)/512,mode.length/512)
                    else:
                        sys.stdout.write(".")
                        sys.stdout.flush()
                buf=don.read_data(128,address)  # word count and byte address read 64 words to speed up
                f.write(buf)
                #print "from address:",address<<1," ", len(buf)
                if address+128 >= (mode.offset + mode.length):  # 2+64 estimates the end to end in right place
                    break
                address = address + 128    #this is word address
            f.close()
            if mode.v == 0:
                print " "            
            print "Readback done!"
        except IOError:
            print "IO Error on file open"
            sys.exit()        
        
    else:
       print "Some of readback parameters missing..."
       print mode.offset,mode.length, mode.filename
       sys.exit()  

if mode.t == 1:   # perform dongle test
        print "Dongle TEST"
        if mode.e == 1:
            #Erase Dongle
            print "Erasing"
            don.write_command(0x0060) # 0x0098
            don.write_command(0x00D0) # 0x0098
            don.wait_on_busy()
            don.parse_status()
            endBlock = 31
            startBlock = 0
            i=startBlock
            while i <= endBlock:
                if mode.v == 1:
                    print 'Erasing block %i '%(i)
                else:
                     sys.stdout.write(".")
                     sys.stdout.flush()
                don.erase_block(i)
                don.wait_on_busy()
                don.parse_status()   #do this after programming all but uneaven ending
                i=i+1  
            if mode.v == 0: # add CRTL return to dots
                print ""
        #Do marching one test on data and address
        mode.length= 0   #make word length
        try:
            #Marching one test
            #---------------------------------------------------------------------------
            address = 0x100000    # set word address
            data = 0x100000
            while mode.length<20: # last address to test 0x20 0000  
                buf1=pack('BBBB', (0x000000FF&data),(0x0000FF00&data)>>8 ,(0x00FF0000&data)>>16 ,(0xFF0000&data)>>24 )
                don.buffer_write(2,address,buf1)
                don.parse_status()   #do this after programming all but uneaven ending
                don.write_command(0x00FF) #  put flash to data read mode   
                buf2=don.read_data(2,address)  # word count and byte address read 64 words to speed up
                if buf1 != buf2:
                    print 'IN  %02x %02x %02x %02x '%(ord(buf1[3]), ord(buf1[2]),ord(buf1[1]), ord(buf1[0]))
                    print 'OUT %02x %02x %02x %02x '%(ord(buf2[3]), ord(buf2[2]),ord(buf2[1]), ord(buf2[0]))
                    print "Test FAIL!!!!!"
                    sys.exit()
                address = address >> 1
                if address == 0x2:
                    address = address >> 1  # 0x2 is written and will return zero on read as write new write will fail
                data = data >> 1
                mode.length =  mode.length + 1
                buf2=don.read_data(1,0)  #read first byte
                if ord(buf2[0]) != 0xFF:
                    print "Test FAIL (At least one address line const. 0)!!!!!"
                    sys.exit()
            #-----------------------------------------------------------------------
            #Marching zero test
            address = 0xFFEFFFFF    # set word address
            data = 0x100000
            while mode.length<18: # last address to test 0x20 0000  
                buf1=pack('BBBB', (0x000000FF&data),(0x0000FF00&data)>>8 ,(0x00FF0000&data)>>16 ,(0xFF0000&data)>>24 )
                don.buffer_write(2,address,buf1)
                don.parse_status()   #do this after programming all but uneaven ending
                don.write_command(0x00FF) #  put flash to data read mode   
                buf2=don.read_data(2,address&0x1FFFFF)  # word count and byte address read 64 words to speed up
                if buf1 != buf2:
                    print 'IN  %02x %02x %02x %02x '%(ord(buf1[3]), ord(buf1[2]),ord(buf1[1]), ord(buf1[0]))
                    print 'OUT %02x %02x %02x %02x '%(ord(buf2[3]), ord(buf2[2]),ord(buf2[1]), ord(buf2[0]))
                    print "Test FAIL!!!!!"
                    sys.exit()
                address = (address >> 1)|0xFF000000
                data = data >> 1
                mode.length =  mode.length + 1
                buf2=don.read_data(1,0x1FFFFF)  #read first byte
                if ord(buf2[0]) != 0xFF:
                    print "Test FAIL (At least two address lines bonded)!!!!!"                
                    sys.exit()
            if mode.b == 1:
                #Erase Dongle
                print "Erasing"
                don.write_command(0x0060) # 0x0098
                don.write_command(0x00D0) # 0x0098
                don.wait_on_busy()
                don.parse_status()
                endBlock = 31
                startBlock = 0
                i=startBlock
                while i <= endBlock:
                    if mode.v == 1:
                        print 'Blanking block %i '%(i)
                    else:
                        sys.stdout.write(".")
                        sys.stdout.flush()
                    don.erase_block(i)
                    don.wait_on_busy()
                    don.parse_status()   #do this after programming all but uneaven ending
                    i=i+1
                if mode.v == 0:
                    print " "
            print "Test SUCCESSFUL!"
            sys.exit()  
        except IOError:
            print "IO Error on file open"
            sys.exit()        

if mode.e == 1:   # perform dongle test
            #Erase Dongle
            print "Erasing all"
            don.write_command(0x0060) # 0x0098
            don.write_command(0x00D0) # 0x0098
            don.wait_on_busy()
            don.parse_status()
            endBlock = 31
            startBlock = 0
            i=startBlock
            while i <= endBlock:
                if mode.v == 1:
                    print 'Erasing block %i '%(i)
                else:
                     sys.stdout.write(".")
                     sys.stdout.flush()
                don.erase_block(i)
                don.wait_on_busy()
                don.parse_status()   #do this after programming all but uneaven ending
                i=i+1  
            if mode.v == 0: # add CRTL return to dots
                print "" 
            print "Erase done."
       
##########################################################
