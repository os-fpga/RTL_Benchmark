//******************************************************************************************************
// Copyright (c) 2007 TooMuch Semiconductor Solutions Pvt Ltd.


//File name             :       wb_ahb_master.sv
//Date                  :        Aug, 2007
//Description   	:       Master for initializing values during Reset State of Device
//Revision              :       1.0

//******************************************************************************************************

`timescale 1 ns/1 ps

import global::*;
module stimulus_gen( wb_ahb_if.master_wb m_wb,
                     input bit clk,
                     input bit reset);

//****************************************** 
// assign input clk and reset to stimulus gen
//******************************************

 assign m_wb.clk_i = clk;
 assign m_wb.rst_i = reset;

//*****************************************
// Values of various signals at Reset State of the Device
//*****************************************
always @(posedge m_wb.clk_i)
	if (m_wb.rst_i) 
		begin
		m_wb.cyc_i='bx;
		m_wb.stb_i='bx;
		m_wb.sel_i='bx;
		m_wb.addr_i='bx;
		m_wb.data_i='bx;
		$display("Values of various signals at Reset State of the Device");
		$display("%0b, %0b, %0b, %0d, %0d" ,m_wb.cyc_i , m_wb.stb_i , m_wb.sel_i,m_wb.addr_i,m_wb.data_i );
		end

//******************************************
// initial signal setups
//******************************************
task initial_setup; 
     	begin
        @(posedge m_wb.clk_i);
	# 2     m_wb.cyc_i='b0;
		m_wb.stb_i='b0;
		m_wb.sel_i='b0;
		m_wb.we_i='bx;
		m_wb.addr_i='bx;
		m_wb.data_i='bx;
		$display("Initial signal setups values");
		$display("%0b, %0b, %0b, %0b, %0d, %0d" ,m_wb.cyc_i , m_wb.stb_i , m_wb.sel_i,m_wb.we_i,m_wb.addr_i,m_wb.data_i);
   	#20	m_wb.cyc_i='b1;
		m_wb.stb_i='b1;
		m_wb.sel_i='b0;
		m_wb.we_i='b1;//Write operation
		$display("Initial signal setups values to start working");
		$display("at %0d ,%0b, %0b, %0b, %0b",$time,m_wb.cyc_i , m_wb.stb_i , m_wb.sel_i,m_wb.we_i );

	end
endtask

endmodule


