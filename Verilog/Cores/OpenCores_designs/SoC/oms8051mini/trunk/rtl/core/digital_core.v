//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OMS 8051 Digital core Module                                ////
////                                                              ////
////  This file is part of the OMS 8051 cores project             ////
////  http://www.opencores.org/cores/oms8051mini/                 ////
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
////  Revision : Nov 26, 2016                                     //// 
////                                                              ////
//////////////////////////////////////////////////////////////////////
//     v0.0 - Dinesh A, 26th Nov 2016
//          1. MAC related logic are remved
//     v0.1 - Dinesh A, 1st Dec 2016
//          1. RAM and ROM are internally connected to interconnect
//          2. Memory Map Change
//          3. Remove the External ROM Option & Enabled Internal ROM
//     v0.2 - Dinesh A, 9st Dec 2016
//          1. Bus interface is changed from 32 bit to 8 bit
//     v0.3 - Dinesh A, 21 Dec 2016
//          1. Uart Message Handler is integrated 
//          2. Message handler is connected as Register Master to 
//             Inter-connect
//     v0.4 - Dinesh A, 6th Jan 2017
//          1. I2C Master Core is integrated
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

`include "top_defines.v"
module digital_core  (

             aresetn                ,
             scan_mode              ,
             scan_enable             ,
             fastsim_mode           ,
             mastermode             ,
             xtal_clk               ,
             clkout                 ,
             reset_out_n            ,
             ea_in                  ,

        // Reg Bus Interface Signal
             ext_reg_cs             ,
             ext_reg_tid            ,
             ext_reg_wr             ,
             ext_reg_addr           ,
             ext_reg_wdata          ,

            // Outputs
             ext_reg_rdata          ,
             ext_reg_ack            ,



       // UART Line Interface
             uart0_txd              ,
             uart0_rxd              ,

             uart1_txd              ,
             uart1_rxd              ,

             spi_sck                ,
             spi_so                 ,
             spi_si                 ,
             spi_cs_n               ,               

	// i2cm clock line
	     i2cm_scl_i             ,
	     i2cm_scl_o             ,
	     i2cm_scl_oen           ,

	// i2cm data line
	     i2cm_sda_i             ,
	     i2cm_sda_o             ,
	     i2cm_sda_oen


        );


//----------------------------------------
// Global Clock Defination
//----------------------------------------
input            aresetn               ; // Async Active Low Reset           
input            scan_mode             ; // scan mode
input            scan_enable           ; // scan enable
input            fastsim_mode          ; // Fast Sim Mode
input            mastermode            ; // 1 : Risc master mode
input            ea_in                  ; // input for external access (ea signal)
                                          // ea=0 program is in external rom
                                          // ea=1 program is in internal rom

input            xtal_clk              ; // xtal clock 25Mhz
output           clkout                ; // clock output
output           reset_out_n           ; // clock output

//---------------------------------
// Reg Bus Interface Signal
//---------------------------------
input            ext_reg_cs            ;
input            ext_reg_wr            ;
input [3:0]      ext_reg_tid           ;
input [14:0]     ext_reg_addr          ;
input [7:0]      ext_reg_wdata         ;

// Outputs
output [7:0]     ext_reg_rdata         ;
output           ext_reg_ack           ;



//----------------------------------------
// UART Line Interface
//----------------------------------------
input            uart0_rxd             ; // serial in
output           uart0_txd             ; // serial out

input            uart1_rxd             ; // serial in
output           uart1_txd             ; // serial out

//----------------------------------------
// SPI Line Interface
//----------------------------------------

output           spi_sck                ; // clock
output           spi_so                 ; // data out
input            spi_si                 ; // data in
output  [3:0]    spi_cs_n               ; // chip select

//----------------------------------------
// i2cm clock line
//----------------------------------------
input	         i2cm_scl_i             ;
output	         i2cm_scl_o             ;
output	         i2cm_scl_oen           ;

//----------------------------------------
// i2cm data line
//----------------------------------------
input	         i2cm_sda_i             ;
output	         i2cm_sda_o             ;
output	         i2cm_sda_oen           ;

//----------------------------------------
// 8051 core RAM related signals
//---------------------------------------
wire [15:0]      wb_xram_adr            ; // data-ram address
wire             wb_xram_ack            ; // data-ram acknowlage
wire             wb_xram_err            ; // data-ram error
wire             wb_xram_wr             ; // data-ram error
wire [7:0]       wb_xram_rdata          ; // ram data input
wire [7:0]       wb_xram_wdata          ; // ram data input

wire             wb_xram_stb            ; // data-ram strobe
wire             wb_xram_cyc            ; // data-ram cycle

//----------------------------------------
// i2CM Wishbone I/F
//---------------------------------------
wire [15:0]      wb_i2cm_addr           ; // data-ram address
wire             wb_i2cm_ack            ; // data-ram acknowlage
wire             wb_i2cm_err            ; // data-ram error
wire             wb_i2cm_we             ; // data-ram error
wire [7:0]       wb_i2cm_rdata          ; // ram data input
wire [7:0]       wb_i2cm_wdata          ; // ram data input

wire             wb_i2cm_stb            ; // data-ram strobe
wire             wb_i2cm_cyc            ; // data-ram cycle

//----------------------------------------
// Message Controller Reg Master
//---------------------------------------
wire             mh_reg_cs              ;
wire             mh_reg_wr              ;
wire  [3:0]      mh_reg_tid             ;
wire  [15:0]     mh_reg_addr            ;
wire  [7:0]      mh_reg_wdata           ;

// Outputs
wire  [7:0]      mh_reg_rdata           ;
wire             mh_reg_ack             ;

//-----------------------------
// wire Decleration
//-----------------------------
wire             gen_resetn             ;


//---------------------------------------------
// 8051 Instruction RAM interface
//---------------------------------------------
wire    [15:0]   wbd_risc_adr           ;
wire    [7:0]    wbd_risc_rdata         ;
wire    [7:0]    wbd_risc_wdata         ;
           

wire    [14:0]   reg_uart_addr          ;
wire    [7:0]    reg_uart_wdata         ;
wire    [7:0]    reg_uart_rdata         ;
wire             reg_uart_ack           ;
                                          
wire    [14:0]   reg_spi_addr           ;
wire    [7:0]    reg_spi_wdata          ;
wire    [7:0]    reg_spi_rdata          ;
wire             reg_spi_ack            ;


wire    [7:0]    p0              ;
wire    [7:0]    p1              ;
wire    [7:0]    p2              ;
wire    [7:0]    p3              ;


wire [7:0] reg_rdata = (reg_uart_ack) ? reg_uart_rdata :
                        (reg_spi_ack)  ? reg_spi_rdata : 'h0;

wire reg_ack = reg_uart_ack | reg_spi_ack;


assign reset_out_n = gen_resetn;

assign wb_xram_adr[15]    = 0;

//-------------------------------------------
// clock-gen  instantiation
//-------------------------------------------
clkgen u_clkgen (
               . aresetn                (aresetn               ),
               . fastsim_mode           (fastsim_mode          ),
               . mastermode             (mastermode            ),
               . xtal_clk               (xtal_clk              ),
               . clkout                 (clkout                ),
               . gen_resetn             (gen_resetn            ),
               . risc_resetn            (risc_resetn           ),
               . app_clk                (app_clk               ),
               . uart_ref_clk           (uart_clk_16x          )

              );

/************* Message Handler **********/

msg_handler_top u_msg_hand_top (  
              . line_reset_n            (aresetn               ),
              . line_clk                (app_clk               ),

      // Towards Register Interface
              . reg_addr                (mh_reg_addr           ),
              . reg_wr                  (mh_reg_wr             ),  
              . reg_wdata               (mh_reg_wdata          ),
              . reg_req                 (mh_reg_cs             ),
	      . reg_ack                 (mh_reg_ack            ),
	      . reg_rdata               (mh_reg_rdata          ),

       // Status information
              . frm_error               (                      ),
	      . par_error               (                      ),
 
	      . baud_clk_16x            (                      ),

       // Line Interface
              . rxd                     (uart0_rxd             ),
              . txd                     (uart0_txd             )


     );



/***************************************/
wire [7:0] wb_master2_rdata;

assign     wbd_risc_rdata = wb_master2_rdata[7:0];

//------------------------------
// 8051 Data Memory Map
// 0x0000 to 0x7FFFF  - Data Memory
// 0x8000 to 0x8FFF   - SPI 
// 0x9000 to 0x9FFF   - UART
// 0xA000 to 0xAFFF   - I2CM
//--------------------------------------------------------------
// Target ID Mapping
// 4'b0011 -- I2CM
// 4'b0010 -- UART
// 4'b0001 -- SPI core
// 4'b0000 -- External RAM
//--------------------------------------------------------------
// 
wire [3:0] wbd_tar_id     = (wbd_risc_adr[15]    == 1'b0 ) ? 4'b0000 :
                            (wbd_risc_adr[15:12] == 4'b1000 ) ? 4'b0001 :
                            (wbd_risc_adr[15:12] == 4'b1001 ) ? 4'b0010 : 
                            (wbd_risc_adr[15:12] == 4'b1010 ) ? 4'b0011 : 4'b0000;

wire [3:0] mh_tar_id     = (mh_reg_addr[15]    == 1'b0 ) ? 4'b0000 :
                           (mh_reg_addr[15:12] == 4'b1000 ) ? 4'b0001 :
                           (mh_reg_addr[15:12] == 4'b1001 ) ? 4'b0010 : 
                           (mh_reg_addr[15:12] == 4'b1010 ) ? 4'b0011 : 4'b0000;

wb_crossbar #(.WB_MASTER(3),
	      .WB_SLAVE(4),
	      .D_WD(8),
	      .BE_WD(1),
	      .ADR_WD(15),
	      .TAR_WD(4)) 
	      u_wb_crossbar (

              .rst_n                    (gen_resetn           ), 
              .clk                      (app_clk              ),


    // Master Interface Signal
              .wbd_taddr_master         ({mh_tar_id, 
		                          wbd_tar_id,
                                          ext_reg_tid }),

              .wbd_din_master           ({mh_reg_wdata,
	                                  wbd_risc_wdata[7:0],
                                          ext_reg_wdata }
                                         ),

              .wbd_dout_master          ({mh_reg_rdata,
	                                  wb_master2_rdata,
                                          ext_reg_rdata}),

              .wbd_adr_master           ({mh_reg_addr[14:0],
	                                  wbd_risc_adr[14:0],
                                          ext_reg_addr[14:0]}),

              .wbd_be_master            ({1'b1,1'b1,1'b1}),

              .wbd_we_master            ({mh_reg_wr,
	                                  wbd_risc_we,
					  ext_reg_wr }   ), 

              .wbd_ack_master           ({mh_reg_ack,
	                                  wbd_risc_ack,
                                          ext_reg_ack } ),

              .wbd_stb_master           ({mh_reg_cs,
	                                  wbd_risc_stb,
                                          ext_reg_cs} ), 

              .wbd_cyc_master           ({mh_reg_cs| mh_reg_ack,
	                                  wbd_risc_stb|wbd_risc_ack,
                                          ext_reg_cs|ext_reg_ack }), 

              .wbd_err_master           (),
              .wbd_rty_master           (),
 
    // Slave Interface Signal
              .wbd_din_slave            ({wb_i2cm_wdata,
                                          reg_uart_wdata,
                                          reg_spi_wdata,
                                          wb_xram_wdata
                                          }),

              .wbd_dout_slave           ({wb_i2cm_rdata,
                                          reg_uart_rdata,
                                          reg_spi_rdata,
                                          wb_xram_rdata
                                         }),

              .wbd_adr_slave            ({wb_i2cm_addr[14:0],
                                          reg_uart_addr[14:0],
                                          reg_spi_addr[14:0],
                                          wb_xram_adr[14:0]
					  }
                                        ), 

              .wbd_be_slave             (), 

              .wbd_we_slave             ({wb_i2cm_we,
                                          reg_uart_wr,
                                          reg_spi_wr,
                                          wb_xram_wr
                                          }), 

              .wbd_ack_slave            ({wb_i2cm_ack,
                                          reg_uart_ack,
                                          reg_spi_ack,
                                          wb_xram_ack
                                         }),
              .wbd_stb_slave            ({wb_i2cm_stb,
                                          reg_uart_cs,
                                          reg_spi_cs,
                                          wb_xram_stb
					  
                                         }), 

              .wbd_cyc_slave            ({wb_i2cm_cyc,
                                          wb_uart_cyc,
                                          wb_spi_cyc,
				          wb_xram_cyc
				          }), 
              .wbd_err_slave            (),
              .wbd_rty_slave            ()
         );



//-------------------------------------
// UART core instantiation
//-------------------------------------

uart_core  u_uart_core

     (  
          . app_reset_n                 (gen_resetn            ),
          . app_clk                     (app_clk               ),


        // Reg Bus Interface Signal
          . reg_cs                      (reg_uart_cs           ),
          . reg_wr                      (reg_uart_wr           ),
          . reg_addr                    (reg_uart_addr[3:0]    ),
          . reg_wdata                   (reg_uart_wdata        ),
          . reg_be                      (1'b1                  ),

            // Outputs
          . reg_rdata                   (reg_uart_rdata        ),
          . reg_ack                     (reg_uart_ack          ),



       // Line Interface
          . si                          (uart1_rxd             ),
          . so                          (uart1_txd             )

     );


//--------------------------------
// SPI core instantiation
//--------------------------------


spi_core u_spi_core (

          . clk                         (app_clk               ),
          . reset_n                     (gen_resetn            ),
               
        // Reg Bus Interface Signal
          . reg_cs                      (reg_spi_cs            ),
          . reg_wr                      (reg_spi_wr            ),
          . reg_addr                    (reg_spi_addr[3:0]     ),
          . reg_wdata                   (reg_spi_wdata         ),
          . reg_be                      (1'b1                  ),

            // Outputs
          . reg_rdata                   (reg_spi_rdata         ),
          . reg_ack                     (reg_spi_ack           ),


          . sck                         (spi_sck               ),
          . so                          (spi_so                ),
          . si                          (spi_si                ),
          . cs_n                        (spi_cs_n              )

           );

/******************************************************
*   I2C Master Core
*   ***************************************************/
i2cm_top  i_i2cm_core (
	// wishbone signals
	        .wb_clk_i                (app_clk              ),
	        .sresetn                 (gen_resetn           ), 
	        .aresetn                 (aresetn              ), 
	        .wb_adr_i                (wb_i2cm_addr[2:0]    ),
	        .wb_dat_i                (wb_i2cm_wdata        ),
	        .wb_dat_o                (wb_i2cm_rdata        ),
	        .wb_we_i                 (wb_i2cm_we           ),
	        .wb_stb_i                (wb_i2cm_stb          ),
	        .wb_cyc_i                (wb_i2cm_cyc          ),
	        .wb_ack_o                (wb_i2cm_ack          ),
	        .wb_inta_o               (i2cm_inta            ),

	// I2C signals
	// i2c clock line
	        .scl_pad_i              (i2cm_scl_i            ),
	        .scl_pad_o              (i2cm_scl_o            ),
	        .scl_padoen_o           (i2cm_scl_oen          ),

	// i2c data line
	        .sda_pad_i              (i2cm_sda_i            ),
	        .sda_pad_o              (i2cm_sda_o            ),
	        .sda_padoen_o           (i2cm_sda_oen          ) 

         );



/******************************************************
*   8051 Core
*******************************************************/

oc8051_top u_8051_core (
          . resetn                      (risc_resetn           ), 
          . wb_clk_i                    (app_clk               ),

//interface to data ram
          . wbd_dat_i                   (wbd_risc_rdata        ), 
          . wbd_dat_o                   (wbd_risc_wdata        ),
          . wbd_adr_o                   (wbd_risc_adr          ), 
          . wbd_we_o                    (wbd_risc_we           ), 
          . wbd_ack_i                   (wbd_risc_ack          ),
          . wbd_stb_o                   (wbd_risc_stb          ),
          . wbd_cyc_o                   (wbd_risc_cyc          ),
          . wbd_err_i                   (wbd_risc_err          ),

// interrupt interface
          . int0_i                      (                      ), 
          . int1_i                      (                      ),


// port interface
  `ifdef OC8051_PORTS
        `ifdef OC8051_PORT0
          .p0_i                         ( p0                    ),
          .p0_o                         ( p0                    ),
        `endif

        `ifdef OC8051_PORT1
           .p1_i                        ( p1                    ),
           .p1_o                        ( p1                    ),
        `endif

        `ifdef OC8051_PORT2
           .p2_i                        ( p2                    ),
           .p2_o                        ( p2                    ),
        `endif

        `ifdef OC8051_PORT3
           .p3_i                        ( p3                    ),
           .p3_o                        ( p3                    ),
        `endif
  `endif

// serial interface
        `ifdef OC8051_UART
           .rxd_i                       (                      ), 
           .txd_o                       (                      ),
        `endif

// counter interface
        `ifdef OC8051_TC01
           .t0_i                        (                      ), 
           .t1_i                        (                      ),
        `endif

        `ifdef OC8051_TC2
           .t2_i                        (                      ),
           .t2ex_i                      (                      ),
        `endif

// BIST
`ifdef OC8051_BIST
            .scanb_rst                  (                      ),
            .scanb_clk                  (                      ),
            .scanb_si                   (                      ),
            .scanb_so                   (                      ),
            .scanb_en                   (                      ),
`endif
// external access (active low)
            .ea_in                      (ea_in                 )
         );

//
// external data ram
//
oc8051_xram oc8051_xram1 (
          .clk               (app_clk       ), 
          .rst               (!aresetn      ), 
          .wr                (wb_xram_wr    ), 
          .addr              (wb_xram_adr   ), 
          .data_in           (wb_xram_wdata ), 
          .data_out          (wb_xram_rdata ), 
          .ack               (wb_xram_ack   ), 
          .stb               (wb_xram_stb   )
      );


defparam oc8051_xram1.DELAY = 2;
endmodule
