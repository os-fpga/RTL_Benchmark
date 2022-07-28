//******************************************************************************************************
// Copyright (c) 2007 TooMuch Semiconductor Solutions Pvt Ltd.


//File name             :       wb_ahb_responder.svh
//Date                  :        Aug, 2007
//Description   	:       Response from AHB to the Inputs from Wishbone
//Revision              :       1.0

//******************************************************************************************************


// responder class
import avm_pkg::*;
import global::*;
class wb_ahb_responder extends avm_threaded_component;

int cnt;
virtual wb_ahb_if pin_if;

	function new(string name ,avm_named_component parent);
		super.new(name,parent);
		pin_if   =null;
	endfunction

task run;
	// local memory in AHB slave model
	logic [DWIDTH-1 : 0] ahb_mem [AWIDTH-1 : 0]; 
	logic [AWIDTH-1:0] haddr_temp;
	logic [DWIDTH-1 :0] hrdata_temp;
	logic hwrite_temp;

	forever		
		begin 
			@(pin_if.slave_ba.haddr or pin_if.slave_ba.hwrite);	
			
				if(pin_if.master_wb.rst_i)	
					begin
					pin_if.slave_ba.hready='b0;
					pin_if.slave_ba.hwdata='bx;
					pin_if.slave_ba.hresp='b00;
					end
				else
					@(posedge pin_if.master_wb.clk_i)
					if(pin_if.slave_ba.hready)
					begin
					haddr_temp = #2 pin_if.slave_ba.haddr;
					hwrite_temp=#2 pin_if.slave_ba.hwrite;
					$display("@ %0d,temp addr=%0d",$time,haddr_temp);
					if(hwrite_temp)
						begin
						ahb_mem[haddr_temp] = #2 pin_if.slave_ba.hwdata;// data stored in ahb slave
						$display("@ %0d,temp data=%0d",$time,pin_if.slave_ba.hwdata);
						end
					else if (!pin_if.slave_ba.hwrite) //Read Operation
						begin
						pin_if.slave_ba.hrdata = #2 ahb_mem[pin_if.slave_ba.haddr];
						end
					end
		end
endtask
		

//*****************************************
//Write operations with no wait states
//*****************************************
task wait_state_by_slave;
	pin_if.slave_ba.hready='b1;
	$display("\n@%0d Block Write operations \n",$time);
		do
			begin
			@(posedge pin_if.master_wb.clk_i);
			cnt++;
			end
		while (cnt <= 6);//Write operations with no wait states for 7 clk cycles
//************************************************
//Write operations with wait states from AHB Slave
//************************************************
	#2 pin_if.slave_ba.hready='b0; 
	$display("\n@%0d Write operations with wait states from AHB Slave \n",$time);
	cnt=0;
		do
			begin
			@(posedge pin_if.master_wb.clk_i);
			++cnt;
			end
		while (cnt <= 1);// 2 clock cycle asserted AHB Master is in Wait State
//*****************************************
//Write operations with no wait states
//*****************************************
	#2 pin_if.slave_ba.hready='b1;
	$display("\n@%0d Block Write operations \n",$time);
	cnt=0;
		do
			begin
			@(posedge pin_if.master_wb.clk_i);
			cnt++;
			end
		while (cnt <= 3);//Write operations with no wait states for 4 clk cycles
//***********************************************
//Write operations with wait states from WB Master
//***********************************************
	 #2 pin_if.slave_ba.hready='b1; 
	$display("\n@%0d Write operations with wait states from WB Master \n",$time);
	cnt=0;
		do
			begin
			@(posedge pin_if.master_wb.clk_i);
			++cnt;
			end
		while (cnt <= 1);// 2 clock cycle deasserted WB Master is in Wait State
//*****************************************
//Write operations with no wait states
//*****************************************
	#2 pin_if.slave_ba.hready='b1;
	$display("\n@%0d Block Write operations \n",$time);
	cnt=0;
		do
			begin
			@(posedge pin_if.master_wb.clk_i);
			cnt++;
			end
		while (cnt <= 3);//Write operations with no wait states for 4 clk cycles

//*************************************
//Read operations without wait states
//*************************************
	#2 pin_if.slave_ba.hready='b1; 
	$display("\n@%0d Block Read operations \n",$time);
	cnt=0;
		do
			begin
				@(posedge pin_if.master_wb.clk_i);
			cnt++;
			end
	while (cnt <= 5);// Read operations with no wait states for 6 clk cycles

//**********************************************
//Read operations with wait states from AHB Slave
//**********************************************
	#2 pin_if.slave_ba.hready='b0; // 25 clock cycle asserted AHB Master is in Wait State
	$display("\n@%0d Read operations with wait states from AHB Slave\n",$time);
	cnt=0;
		do
			begin
				@(posedge pin_if.master_wb.clk_i);
			++cnt;
			end
	while (cnt <= 1);// 2 clock cycle asserted AHB Master is in Wait State

//*************************************
//Read operations without wait states
//*************************************
	#2 pin_if.slave_ba.hready='b1; 
	$display("\n@%0d Block Read operations \n",$time);
	cnt=0;
		do
			begin
				@(posedge pin_if.master_wb.clk_i);
			cnt++;
			end
	while (cnt <= 3);// Read operations with no wait states for 4 clk cycles
//**********************************************
//Read operations with wait states from WB Master
//**********************************************
	#2 pin_if.slave_ba.hready='b1; // 5 clock cycle  deasserted WB Master in in Wait state
	$display("\n@%0d Read operations with wait states from WB Master\n",$time);
	cnt=0;
		do
			begin
				@(posedge pin_if.master_wb.clk_i);
			++cnt;
			end
		while (cnt <= 4);// 5 clock cycle  asserted WB Master in in Wait state

endtask 


endclass
