//author :Renliang Gu
//Email: gurenliang@gmail.com
//note: if there are some errors, please feel free to contact me. Thank you very much!

//Next step, reduce the resource consumed

//version 0.5, defined many parameter to configure the IP core, making it easier to use.
//version 0.3, create this file to be a common included one for future use to config the IP core
//This file used to define some macro-varibles which can be used by all other files

//NOTE!!! Olny one of the following two definitions can be open
`define frameIDfromRx			//frameID comes from Rxmodule
//`define frameIDcount			//frameID counts for itself by adding one every frame

`define Preamble	64'hd555_5555_5555_5555

//The MAC address of this MAC IP core and the other terminal on the Ethernet, can be changed!
`define MAC_ADD		48'h0100_0000_0000	//mac address: 0x00-00-00-00-00-01
`define PC_MAC_ADD	48'hffff_ffff_ffff	//mac address of the other terminal

`define frameidlen 		24		//the id of the MAC frame
`define uframelen 		148 	//148-bit
`define num_uframe 		8		//the number of uframes received once
`define interval		8.25	//the interval between frames without send any data on fifo
											
`define da_offset		(8<<1)					//8 byte before
`define sa_offset		(`da_offset+(6<<1))		//8+6 bytes before
`define typelen_offset	(`sa_offset+(6<<1))
`define frameid_offset	(`typelen_offset+(2<<1))//index of first bit of frameid
`define data_offset		(`frameid_offset+(`frameidlen>>2))	
												//index of first bit of data