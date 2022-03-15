/*
 * $Id: utestbench.v,v 1.1 2007-04-13 13:02:34 sybreon Exp $
 * 
 * AEMB Generic Testbench
 * Copyright (C) 2006 Shawn Tan Ser Ngiap <shawn.tan@aeste.net>
 *  
 * This library is free software; you can redistribute it and/or modify it 
 * under the terms of the GNU Lesser General Public License as published by 
 * the Free Software Foundation; either version 2.1 of the License, 
 * or (at your option) any later version.
 * 
 * This library is distributed in the hope that it will be useful, but 
 * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY 
 * or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public 
 * License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License 
 * along with this library; if not, write to the Free Software Foundation, Inc.,
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA 
 *
 * DESCRIPTION
 * Top level test bench and fake RAM/ROM for unified core.
 *
 * HISTORY
 * $Log: not supported by cvs2svn $
 */

module utestbench ();
   parameter ASIZ = 16;
   parameter CSIZ = 7;   
   
   reg sys_clk_i, sys_rst_i, sys_int_i, sys_exc_i;

   // VCD DUMP ///////////////////////////////////////////////////////
   initial begin
      $dumpfile("dump.vcd");
      $dumpvars(1,dut);
   end

   // INITIAL SETUP /////////////////////////////////////////////////
   initial begin
      sys_clk_i = 0;
      sys_rst_i = 0;
      sys_int_i = 0;
      sys_exc_i = 0;      
      #10 sys_rst_i = 1;
      #10000 sys_int_i = 1;
      #100 sys_int_i = 0;      
   end

   // SIMULATION FORCES /////////////////////////////////////////////
   initial fork	
      //#100000 $displayh("\nTest Completed."); 
      //#11000 $finish;
   join   
   
   always #5 sys_clk_i = ~sys_clk_i;   

   // FAKE MEMORY ///////////////////////////////////////////////////
   wire [ASIZ-1:0] wb_adr_o;
   wire 	   wb_stb_o;
   wire [31:0] 	   wb_dat_o;
   wire [31:0] 	   wb_dat_i;
   reg [ASIZ-1:2]  adr;   
   reg 		   wb_ack_i;
   reg [31:0] 	   ram [0:65535];

   assign 	   wb_dat_i = ram[adr];   
   always @(posedge sys_clk_i) begin
      wb_ack_i <= wb_stb_o;
      //& $random;
      adr <= wb_adr_o[ASIZ-1:2];      
      if (wb_wre_o)
	ram[wb_adr_o[ASIZ-1:2]] <= wb_dat_o;      
   end
   
   integer i;   
   initial begin
      for (i=0;i<65536;i=i+1) begin
	 ram[i] <= $random;
      end      
      #1 $readmemh("aeMB.rom",ram); 
   end

   // SIMULATION OUTPUT ////////////////////////////////////////////////
   always @(negedge sys_clk_i) begin
      $write("\nT: ",$stime);

      if (wb_stb_o & !wb_wre_o & wb_ack_i)
	$writeh("\tRD: 0x",wb_adr_o,"=0x",wb_dat_i);
      if (wb_stb_o & wb_wre_o & wb_ack_i)
	$writeh("\tWR: 0x",wb_adr_o,"=0x",wb_dat_o);      
      if (dut.cpu.nrun & dut.iwb_stb_o & dut.iwb_ack_i)
	$writeh("\tPC: 0x",dut.iwb_adr_o,"=0x",dut.iwb_dat_i);
      if (dut.dwb_stb_o & dut.dwb_we_o & dut.dwb_ack_i) 
	$writeh("\tST: 0x",dut.dwb_adr_o,"=0x",dut.dwb_dat_o);     
      if (dut.dwb_stb_o & ~dut.dwb_we_o & dut.dwb_ack_i)
	$writeh("\tLD: 0x",dut.dwb_adr_o,"=0x",dut.dwb_dat_i);

      if (dut.cpu.regfile.wDWE)
	$writeh("\tR",dut.cpu.regfile.rRD_,"=",dut.cpu.regfile.wDDAT,";");         

      if ((dut.dwb_adr_o == 16'h8888) && (dut.dwb_dat_o == 32'h7a55ed00))
	$display("\n*** SERVICE ***");      
      if (dut.cpu.control.rFSM == 2'o1)
	$display("\n*** INTERRUPT ***");      

      if (dut.wb_wre_o & (dut.wb_dat_o == 32'hFA17ED00)) begin
	 $display("\n*** FAILED ***");	 
	 $finish;
      end
   end // always @ (posedge sys_clk_i)

   // DEVICE UNDER TEST ////////////////////////////////////////////////

   aeMB_ucore #(ASIZ,CSIZ)
     dut (
	  // Outputs
	  .wb_adr_o			(wb_adr_o[ASIZ-1:0]),
	  .wb_dat_o			(wb_dat_o[31:0]),
	  //.wb_sel_o			(wb_sel_o[3:0]),
	  .wb_stb_o			(wb_stb_o),
	  .wb_wre_o			(wb_wre_o),
	  // Inputs
	  .sys_clk_i			(sys_clk_i),
	  .sys_exc_i			(sys_exc_i),
	  .sys_int_i			(sys_int_i),
	  .sys_rst_i			(sys_rst_i),
	  .wb_ack_i			(wb_ack_i),
	  .wb_dat_i			(wb_dat_i[31:0]));
   
endmodule // testbench
