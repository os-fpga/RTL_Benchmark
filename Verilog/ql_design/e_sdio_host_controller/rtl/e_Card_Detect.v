///////////////////////////////////////////////////////////////////////////////
//
//
// Copyright (C) 2007, Licensed customers of QuickLogic may copy or modify
// this file for use in designing QuickLogic devices only.
//
// Module Name:  e_card_detect
// File Name:    e_card_detect.v
// 
// Version 1.0   April  1, 2006  -Original
// Version 1.1   Feb.   7, 2007  -Added 16 bit support
// Version 1.2   May.   14,2007  -Fixed cmd to cmd delay
//                               -SDIO power on switch clock line level
//                               -Used latched signal for datline0
//                               -Optimized to use fifo controllers
//                               -Modified to use one RAMBLOCK instead of two
//
///////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ns

module e_card_detect(
										rst,
										clk,
										
										sd_pon,            
										wp_level,              
										cd_level,             
										card_stable,           
										card_inserted,              
										                  
										cd,               
										wp,               
										pon             
									);

	input		rst;
 	input		clk;

	input		sd_pon;            
	output	    wp_level;              
	output	    cd_level;             
	output	    card_stable;           
	output	    card_inserted;              

	input		cd;               
	input		wp;               
	output	    pon;   
     
	
	assign	pon				    = sd_pon;	
	assign	cd_level			= 1'b0;
	assign	wp_level			= 1'b1;	
	assign	card_stable		    = 1'b1;
	assign  card_inserted       = 1'b1;

  
endmodule