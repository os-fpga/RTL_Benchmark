//******************************************************************************************************
// Copyright (c) 2007 TooMuch Semiconductor Solutions Pvt Ltd.


//File name             :       wb_ahb_stim_gen.svh
//Date                  :        Aug, 2007
//Description   	:       Stimulus Generation for WISHBONE_AHB Bridge
//Revision              :       1.0

//******************************************************************************************************

// class to generate write and read packet
import avm_pkg::*;
import global::*;
class wb_ahb_stim_gen extends avm_named_component;


avm_blocking_put_port#( wb_req_pkt) initiator_port;
tlm_fifo#(wb_req_pkt) fifo;

	function new(string name ,avm_named_component parent);
		super.new(name,parent);
		initiator_port=new("initiatot_port",this);
		fifo =new("fifo",this);
	endfunction

task stimulus(input int count = 41);

	wb_req_pkt p;
//*****************************************
//Write operations with no wait states
//*****************************************
		for(int i=0; i<8 ;i++)
		begin
				p.wr='b1;
				p.adr=i+1;	
				p.dat=i;	
				p.stb='b1;	
				write_to_pipe(p);
		end

//************************************************
//Write operations with wait states from AHB Slave
//************************************************
		for(int i=8;i<10;i++)
		begin
				p.wr='b1;//Wait state from AHB SLAVE
				p.stb='b1;
				write_to_pipe(p);
		end

//*****************************************
//Write operations with no wait states
//*****************************************
		for(int i=10; i<14 ;i++)
		begin
				p.wr='b1;
				p.adr=i+1;	
				p.dat=i;
				p.stb='b1;
				write_to_pipe(p);
		end

//***********************************************
//Write operations with wait states from WB Master
//***********************************************
		for(int i=14;i<16;i++)
		begin
				p.stb='b0;
				p.wr='b1;//Wait state from AHB SLAVE
		write_to_pipe(p);
		end

//*****************************************
//Write operations with no wait states
//*****************************************
		for(int i=15; i<19 ;i++)
		begin
				p.wr='b1;
				p.adr=i+1;	
				p.dat=i;
				p.stb='b1;	
				write_to_pipe(p);
		end

//*************************************
//Read operations without wait states
//*************************************
		for(int i=19; i<25 ;i++)
		begin
				p.wr='b0;
				p.adr=i+1;
				p.stb='b1;	
				write_to_pipe(p);
		end

//**********************************************
//Read operations with wait states from AHB Slave
//**********************************************
		for(int i=25; i<27 ;i++)
		begin
				p.wr='b0;
		write_to_pipe(p);
		end
//*************************************
//Read operations without wait states
//*************************************
		for(int i=27; i<31 ;i++)
		begin
				p.wr='b0;
				p.adr=$random;	
				$display("%0d, %0d", p.wr, p.adr );
		write_to_pipe(p);
		end
//**********************************************
//Read operations with wait states from WB Master
//**********************************************
		for(int i=31; i<33 ;i++)
		begin
				p.wr='b0;
		write_to_pipe(p);
		end
//*************************************
//Read operations without wait states
//*************************************
		for(int i=33; i<38 ;i++)
		begin
				p.wr='b0;
				p.adr=$random;	
				$display("%0d, %0d",p.wr, p.adr );
		write_to_pipe(p);
		end
//*****************************************
//Write operations with no wait states
//*****************************************
		for(int i=38; i<41 ;i++)
		begin
				p.wr='b1;
				p.adr=$random;	
				p.dat=$random;	
				$display("%0d, %0d", p.adr , p.dat );
		write_to_pipe(p);
		end 

endtask

// task to push transaction in the fifo
task write_to_pipe(wb_req_pkt p);
		initiator_port.put(p);
endtask

endclass 
