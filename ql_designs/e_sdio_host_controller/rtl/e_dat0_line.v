///////////////////////////////////////////////////////////////////////////////
//
//
// Copyright (C) 2007, Licensed customers of QuickLogic may copy or modify
// this file for use in designing QuickLogic devices only.
//
// Module Name:  e_dat0_line
// File Name:    e_dat0_line.v
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

module e_dat0_line(
									rst,
									clk,
									clkn,
							
									high_speed,
									crc_rst,
									dat_width,
									oe,								
									data_sel,
									crc_check_en,											
									dat_phase,
									xmit_data,
									
									rcv_data,
									crc_error,
									dat_in,
									dat
								);

	input					rst;
	input					clk;
	input					clkn;

	input					high_speed;
	input					crc_rst;
	input					dat_width;
	input					oe;								
	input		[2:0]	data_sel;
	input					crc_check_en;											
	input		[1:0]	dat_phase;
	input		[7:0]	xmit_data;

	output	[7:0]	rcv_data;
	output				crc_error;
	output				dat_in;
	
	inout					dat;
	
	reg					dout_reg_hs;
	reg					oe_reg_hs;
	reg		[7:0]	dat_dly;
	reg					dout_reg_ls;
	reg					oe_reg_ls;
	reg					dout;
	reg					sdata;
	reg					crc_error;
	
	wire				dout_reg;
	wire				oe_reg;
	wire				oe_reg_hs_e;
	
	wire				crc_din;
	wire				crc_dout;
	wire				gen_en;
	wire				out_en;

	assign	rcv_data	= dat_dly;
	
	assign	dat_in	= dat;
	assign	dat 		= ( oe_reg ) ? dout_reg : 1'b0;  
	
	assign	dout_reg		= ( high_speed ) ? dout_reg_hs : dout_reg_ls;
	assign	oe_reg			= ( high_speed ) ? oe_reg_hs_e : oe_reg_ls;	
	assign	oe_reg_hs_e	= oe_reg_hs | oe;

	assign	crc_din	= ( crc_check_en ) ? dat_dly[0] : dout;
	assign	gen_en	= ( dat_phase == 2'b10 );
	assign	out_en	= ( dat_phase == 2'b11 );

	always@( posedge clk or posedge rst )	 
	begin
		if( rst )
		begin
			dout_reg_hs		<= 1'b0;
			oe_reg_hs			<= 1'b0;
			dat_dly[7:0]	<= 8'b0;
		end
		else
		begin
			dout_reg_hs	<= dout;
			oe_reg_hs		<= oe;	
			if( ~oe_reg_hs )
			begin
				dat_dly[7:1]	<= dat_dly[6:0];	   
				dat_dly[0]		<= dat;
			end
		end	
	end	  

	always@( posedge clkn or posedge rst )
	begin
		if( rst )
		begin
			dout_reg_ls	<= 1'b0;
			oe_reg_ls		<= 1'b0;
		end
		else
		begin
			dout_reg_ls	<= dout_reg_hs;
			oe_reg_ls		<= oe_reg_hs_e;
		end
	end	

	always@( dat_phase or sdata or crc_dout )
	begin
		case( dat_phase )
			2'b01:
			begin
				dout	<= 1'b1;
			end
			2'b10:
			begin
				dout	<= sdata;
			end
			2'b11:
			begin
				dout	<= crc_dout;
			end
			default:
			begin
				dout	<= 1'b0;
			end
		endcase
	end
	
	always@( xmit_data or data_sel or dat_width )
	begin
		if( dat_width )
		begin
			if( ~data_sel[0] ) 
			begin
				sdata	<= xmit_data[1];
			end
			else
			begin
				sdata	<= xmit_data[0];
			end
		end
		else
		begin
			case( data_sel )
				3'b000:		sdata <= xmit_data[7];
				3'b001:		sdata <= xmit_data[6];
				3'b010:		sdata <= xmit_data[5];
				3'b011:		sdata <= xmit_data[4];
				3'b100:		sdata <= xmit_data[3];
				3'b101:		sdata <= xmit_data[2];
				3'b110:		sdata <= xmit_data[1];
				default:	sdata <= xmit_data[0];	
			endcase
		end
	end	
			
	always@( posedge clk or posedge rst )	  
	begin
		if( rst )
		begin
			crc_error	<= 1'b0;
		end
		else
		begin
			if( ~crc_check_en )
			begin
				crc_error	<= 1'b0;
			end
			else if( out_en & ( crc_dout != dat_dly[0] ) )
			begin
				crc_error <= 1'b1;
			end
		end	
	end

	e_crc16 e_crc16_inst(
										.rst		( crc_rst				),
										.clk		( clk				),
										.gen_en ( gen_en		),
										.out_en ( out_en		),
										.din		( crc_din		),
										.dout		( crc_dout	)
									);	   

endmodule
