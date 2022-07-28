//////////////////////////////////////////////////////////////////////
////                                                              ////
////                                                              ////
////  This file is part of the OMS 8051 cores project             ////
////  http://www.opencores.org/cores/oms8051/                     ////
////                                                              ////
////  Description                                                 ////
////  OMS 8051 definitions.                                       ////
////                                                              ////
////  To Do:                                                      ////
////    nothing                                                   ////
////                                                              ////
////  Author(s):                                                  ////
////      - Dinesh Annayya, dinesha@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////



`include "tb_defines.v"

module tb_top;


reg    reset_n;
reg    reset;
reg    xtal_clk;
reg    ref_clk_125;
wire   app_clk;
reg    ref_clk_50;
reg    uart_clk_16x;


parameter XTAL_CLK_PERIOD = 10; // 100MHZ 40; // 25Mhz
parameter APP_CLK_PERIOD = 10;
parameter REF_CLK_125_PERIOD = 8;
parameter REF_CLK_50_PERIOD = 20;
parameter UART_REF_CLK_PERIOD = 20;

reg[31:0] events_log;

initial
begin
        reset_n = 1;
   #100 reset_n = 0;
   #100 reset_n = 1;
end


initial begin
  xtal_clk = 1'b0;
  forever #(XTAL_CLK_PERIOD/2.0) xtal_clk = ~xtal_clk;
end


//initial begin
//  app_clk = 1'b0;
//  forever #(APP_CLK_PERIOD/2.0) app_clk = ~app_clk;
//end

initial begin
  ref_clk_125 = 1'b0;
  forever #(REF_CLK_125_PERIOD/2.0) ref_clk_125 = ~ref_clk_125;
end

initial begin
  ref_clk_50 = 1'b0;
  forever #(REF_CLK_50_PERIOD/2.0) ref_clk_50 = ~ref_clk_50;
end


initial begin
  uart_clk_16x = 1'b0;
  forever #(UART_REF_CLK_PERIOD/2.0) uart_clk_16x = ~uart_clk_16x;
end


wire [3:0]   phy_txd            ;
wire [3:0]   phy_rxd            ;

//---------------------------------
// Reg Bus Interface Signal
//---------------------------------
reg                reg_cs        ;
reg [3:0]          reg_id        ;
reg                reg_wr        ;
reg  [14:0]        reg_addr      ;
reg  [7:0]         reg_wdata     ;
reg                reg_be        ;

// Outputs
wire  [7:0]        reg_rdata     ;
wire               reg_ack       ;

reg                master_mode   ;
reg                ea_in         ;   // 1--> Internal Memory

 
wire               spi_sck       ;
wire               spi_so        ;
wire               spi_si        ;
wire [3:0]         spi_cs_n      ;

wire               clkout        ;
wire               reset_out_n   ;

parameter I2CS_ADDR    = 7'b0010_000; // I2C Slave Addr
//----------------------------------------

digital_core  u_core (

             . aresetn             (reset_n            ),
             . fastsim_mode        (1'b1               ),
             . mastermode          (master_mode        ),

             . xtal_clk            (xtal_clk           ),
             . clkout              (app_clk            ),
             . reset_out_n         (reset_out_n        ),
             . ea_in               (ea_in              ), // internal ROM

        // Reg Bus Interface Signal
             . ext_reg_cs          (reg_cs             ),
             . ext_reg_tid         (reg_id             ),
             . ext_reg_wr          (reg_wr             ),
             . ext_reg_addr        (reg_addr[14:0]     ),
             . ext_reg_wdata       (reg_wdata          ),

            // Outputs
             . ext_reg_rdata       (reg_rdata          ),
             . ext_reg_ack         (reg_ack            ),



       // UART Line Interface
             .uart1_rxd            (si                 ),
             .uart1_txd            (so                 ),

             .uart0_rxd            (1'b0               ),
             .uart0_txd            (                   ),

             .spi_sck              (spi_sck            ),
             .spi_so               (spi_so             ),
             .spi_si               (spi_si             ),
             .spi_cs_n             (spi_cs_n           ),

	// i2cm clock line
	     .i2cm_scl_i           (scl                ),
	     .i2cm_scl_o           (i2cm_scl_o         ),
	     .i2cm_scl_oen         (i2cm_scl_oen       ),

	// i2cm data line
	     .i2cm_sda_i           (sda                ),
	     .i2cm_sda_o           (i2cm_sda_o         ),
	     .i2cm_sda_oen         (i2cm_sda_oen       )



        );

	        // create i2c lines
	delay m0_scl (i2cm_scl_oen ? 1'bz : i2cm_scl_o, scl),
	      m0_sda (i2cm_sda_oen ? 1'bz : i2cm_sda_o, sda);

	pullup p1(scl); // pullup scl line
	pullup p2(sda); // pullup sda line

	// hookup i2c slave model
	i2c_slave_model #(I2CS_ADDR) tb_i2cs (
	     .scl                  (scl                  ),
	     .sda                  (sda                  )
	);


 uart_agent tb_uart (
               . test_clk          (uart_clk_16x       ),
               . sin               (si                 ),
               . dsr_n             (                   ),
               . cts_n             (                   ),
               . dcd_n             (                   ),

               . sout              (so                 ),
               . dtr_n             (1'b0               ),
               . rts_n             (1'b0               ),
               . out1_n            (1'b0               ),
               . out2_n            (1'b0               )
       );


//----------------------- SPI Agents

m25p20 i_m25p20_0 ( 
               .c                  (spi_sck            ),
               .s                  (spi_cs_n[0]        ), // Include selection logic
               .w                  (1'b1               ), // Write protect is always disabled
               .hold               (1'b1               ), // Hold support not used
               .data_in            (spi_so             ),
               .data_out           (spi_si             )
             );


AT45DB321 i_AT45DB321_0 ( 
               .CSB                (spi_cs_n[1]        ),
               .SCK                (spi_sck            ),
               .SI                 (spi_so             ),
               .WPB                (1'b1               ),
               .RESETB             (1'b1               ),
               .RDY_BUSYB          (                   ),
               .SO                 (spi_si             )
      );
/***************
spi_agent_3120 spi_agent_3120_0 ( 
               .cs_b               (spi_cs_n[2]        ),
               .spi_din            (spi_si             ),
               .spi_dout           (spi_so             ),
               .spi_clk            (spi_sck            )
       );

spi_agent_3120 spi_agent_3120_1 ( 
               .cs_b               (spi_cs_n[3]        ),
               .spi_din            (spi_si             ),
               .spi_dout           (spi_so             ),
               .spi_clk            (spi_sck            )
       );
*****************/

tb_glbl  tb_glbl ();


`ifdef DUMP_ENABLE
initial begin
   if ( $test$plusargs("DUMP") ) begin
          $fsdbDumpfile("../dump/test_1.fsdb");
      $fsdbDumpvars;
      $fsdbDumpon;
   end
end
`endif

initial begin //{
   $display ("--> Dumpping the design");
   $shm_open("simvision.shm"); 
   $shm_probe("AC"); 
end //}


initial begin

   if ( $test$plusargs("INTERNAL_ROM") )  begin
      ea_in       = 1;
      master_mode = 1;
   end else if ( $test$plusargs("EXTERNAL_ROM") ) begin
      ea_in       = 0;
      master_mode = 1;
   end else begin
      ea_in       = 0;
      master_mode = 0;
   end

  `TB_GLBL.init;

   #1000 wait(reset_out_n == 1);

   if ( $test$plusargs("uart_lb") ) 
       uart_lb();
   else if ( $test$plusargs("spi_test_1") ) 
       spi_test1();
   else if ( $test$plusargs("i2cm_test_1") ) 
       i2cm_test1();
   else begin
     // 8051 Test Cases
     #80000000
     $display("time ",$time, "\n faulire: end of time\n \n");
   end

   `TB_GLBL.test_stats;
   `TB_GLBL.test_finish;
   #1000 $finish;
end

wire [7:0] p2_out = u_core.u_8051_core.p2_o;
wire [7:0] p3_out = u_core.u_8051_core.p3_o;
always @(p2_out or p3_out)
begin
  if((p2_out == 8'haa) &&      // fib.c
     (p3_out == 8'haa )) begin
      $display("################################");
      $display("TEST STATUS : PASSED ");
      $display("################################");
      #100
      $finish;
  end else if(p2_out == 8'h55) begin     // fib.c
      $display("");
      $display("time ",$time," Error: %h", p3_out);
      $display("TEST STATUS : FAILED ");
      $display("");
      #100
      $finish;
  end
end


module delay (in, out);
  input  in;
  output out;

  assign out = in;

  specify
    (in => out) = (600,600);
  endspecify
endmodule


`include "uart_lb.v"
`include "spi_test1.v"
`include "i2cm_test1.v"
`include "tb_tasks.v"
`include "spi_tasks.v"


endmodule
`include "tb_glbl.v"
