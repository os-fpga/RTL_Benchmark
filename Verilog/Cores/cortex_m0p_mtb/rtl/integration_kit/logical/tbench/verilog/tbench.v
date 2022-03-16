//-----------------------------------------------------------------------------
// The confidential and proprietary information contained in this file may
// only be used by a person authorised under and to the extent permitted
// by a subsisting licensing agreement from ARM Limited.
//
//            (C) COPYRIGHT 2008-2012 ARM Limited.
//                ALL RIGHTS RESERVED
//
// This entire notice must be reproduced on all copies of this file
// and copies of this file may only be made by a person if such person is
// permitted to do so under the terms of a subsisting license agreement
// from ARM Limited.
//
//      SVN Information
//
//      Checked In          : $Date: 2012-09-12 16:06:58 +0100 (Wed, 12 Sep 2012) $
//
//      Revision            : $Revision: 222412 $
//
//      Release Information : Cortex-M0+ AT590-r0p1-00rel0
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//     Top-level testbench for CORTEX-M0+ Integration Kit
//-----------------------------------------------------------------------------
//
// This block instantiates:
//  o u_mcu          - Example MCU system
//  o u_clk_src      - Clock source
//  o u_poreset      - Power-On-Reset Generator
//  o u_debug_driver - Debug Driver
// It also optionally includes:
//  o u_tarmac       - Tarmac Logger for CORTEX-M0+ in MCU
//
// The testbench also contains code for
//  o SDF Timing Annotation
//  o VCD Generation
//  o Charater output and test status (passed/failed/killed)
//-----------------------------------------------------------------------------
`include "cm0p_ik_defs.v"
`timescale 1ns/1ps

module tbench();

//-----------------------------------------------------------------------------
// Signal declarations
//-----------------------------------------------------------------------------

  wire                  CLK;        //  primary clock
  wire                  PORESETn;   //  power-on-reset
  wire                  nTRST;      //  JTAG reset signal
  wire                  SWCLKTCK;   //  SW/JTAG clock
  wire                  SWDIOTMS;   //  SW Data In/Out / JTAG TMS
  wire                  TDI;        //  JTAG data in
  wire                  TDO;        //  JTAG data out
  wire [31:0]           EXTGPIO;    //  GPIO pins from ARMIKMCU

//-----------------------------------------------------------------------------
// SDF Timing Annotation
//-----------------------------------------------------------------------------

`ifdef ARM_CM0PIK_NETLIST
//-----------------------------------------------------------------------------
// Modify this define to point to SDF file that delays inputs to Netlist
`define ARM_CM0PIK_NETLIST_IODELAY  "../sdf/CM0PINTEGRATION_iodelay.sdf.gz"
//-----------------------------------------------------------------------------
// Modify this define to point to SDF from synthesis flow
`define ARM_CM0PIK_NETLIST_SDF      "../CM0PINTEGRATION.sdf.gz"
//-----------------------------------------------------------------------------
// Modify this define to point to instance of Netlist
// Note that netlist is instantiated in CM0PIKMCU and Debug Driver system
`define ARM_CM0PIK_NETLIST_SCOPE    u_cm0pmtbintegration.u_cm0pintegration
//-----------------------------------------------------------------------------

   initial
     begin
       // IO Delay for Netlist
       $sdf_annotate(`ARM_CM0PIK_NETLIST_IODELAY, u_mcu.u_sys.`ARM_CM0PIK_NETLIST_SCOPE,,"dut_io.log");
       $sdf_annotate(`ARM_CM0PIK_NETLIST_IODELAY, u_dbg_drv.`ARM_CM0PIK_NETLIST_SCOPE,,"dbg_io.log");

`ifdef ARM_CM0PIK_SDF

       // SDF Annotation for Netlist
       $sdf_annotate(`ARM_CM0PIK_NETLIST_SDF, u_mcu.u_sys.`ARM_CM0PIK_NETLIST_SCOPE,,"dut_net.log");
       $sdf_annotate(`ARM_CM0PIK_NETLIST_SDF, u_dbg_drv.`ARM_CM0PIK_NETLIST_SCOPE,,"dbg_net.log");

`endif // ARM_CM0PIK_SDF
     end
`endif // ARM_CM0PIK_NETLIST

//-----------------------------------------------------------------------------
// VCD Generation
//-----------------------------------------------------------------------------
`ifdef ARM_CM0PIK_VCD

//-----------------------------------------------------------------------------
// Modify this define to change name of VCD file
`define ARM_CM0PIK_VCD_FILE "CM0PINTEGRATIONIMP.vcd"
//-----------------------------------------------------------------------------

   initial
     begin
       $dumpfile(`ARM_CM0PIK_VCD_FILE);
       #(`ARM_CM0PIK_VCD_START) // Start VCD dump
       $display("%t : Started dumping signals to %s\n",$time,`ARM_CM0PIK_VCD_FILE);
       $dumpvars(0, u_mcu.u_sys.u_cm0pmtbintegration.u_cm0pintegration);
       $dumpon;
       #(`ARM_CM0PIK_VCD_STOP-`ARM_CM0PIK_VCD_START) // Stop VCD dump
       $dumpoff;
       $display("%t : Finished dumping VCD data\n",$time);
     end
`endif // ARM_CM0PIK_VCD


//-----------------------------------------------------------------------------
// MCU System
//-----------------------------------------------------------------------------

   // Add pullups and pulldowns on Debug Interface
   pullup (nTRST);
   pullup (TDI);
   pullup (TDO);
   pullup (SWDIOTMS);
   pulldown (SWCLKTCK);

  CM0PIKMCU u_mcu
  (// Inputs
   .CLK                                 (CLK),
   .PORESETn                            (PORESETn),
   .nTRST                               (nTRST),
   .SWCLKTCK                            (SWCLKTCK),
   .TDI                                 (TDI),
   // Outputs
   .TDO                                 (TDO),
   // Inouts
   .SWDIOTMS                            (SWDIOTMS),
   .EXTGPIO                             (EXTGPIO[31:0]));

//-----------------------------------------------------------------------------
// Clock Source
//-----------------------------------------------------------------------------

  cm0p_ik_clk_src u_clk_src
  (//Outputs
   .CLK                                 (CLK));

//-----------------------------------------------------------------------------
// Power-On-Reset
//-----------------------------------------------------------------------------

  cm0p_ik_poreset u_poreset
  (// Outputs
   .PORESETn                            (PORESETn));

//-----------------------------------------------------------------------------
// Debug driver block
//-----------------------------------------------------------------------------

  // Add pulldowns on interface signals between ARMIKMCU and debug driver
  pulldown(EXTGPIO[24]);
  pulldown(EXTGPIO[25]);
  pulldown(EXTGPIO[26]);
  pulldown(EXTGPIO[27]);
  pulldown(EXTGPIO[28]);
  pulldown(EXTGPIO[29]);
  pulldown(EXTGPIO[30]);
  pulldown(EXTGPIO[31]);

  cm0p_ik_debug_driver u_dbg_drv
  (// Inputs
   .CLK                                 (CLK),
   .PORESETn                            (PORESETn),
   .FUNCTIONSTROBE                      (EXTGPIO[29]),
   .FUNCTIONSELECT                      (EXTGPIO[28:24]),
   .TDO                                 (TDO),
   // Outputs
   .RUNNING                             (EXTGPIO[31]),
   .ERROR                               (EXTGPIO[30]),
   .nTRST                               (nTRST),
   .SWCLKTCK                            (SWCLKTCK),
   .SWDIOTMS                            (SWDIOTMS),
   .TDI                                 (TDI));


//-----------------------------------------------------------------------------
// Pull Ups on unused GPIO pins
//-----------------------------------------------------------------------------

  pullup(EXTGPIO[ 2]);
  pullup(EXTGPIO[ 3]);
  pullup(EXTGPIO[ 4]);
  pullup(EXTGPIO[ 5]);
  pullup(EXTGPIO[ 6]);
  pullup(EXTGPIO[ 7]);
  pullup(EXTGPIO[16]);
  pullup(EXTGPIO[17]);
  pullup(EXTGPIO[18]);
  pullup(EXTGPIO[19]);
  pullup(EXTGPIO[20]);
  pullup(EXTGPIO[21]);
  pullup(EXTGPIO[22]);
  pullup(EXTGPIO[23]);


//-----------------------------------------------------------------------------
// Character Output - debug_driver block
//-----------------------------------------------------------------------------

  wire [7:0]  d_chardata = {1'b0, u_dbg_drv.GPIOOUT[14:8]};

  wire        d_charstrobe = u_dbg_drv.GPIOOUT[15];

  always@(d_charstrobe)
    if(d_charstrobe == 1'b1)
       $write ("%c", d_chardata);

//-----------------------------------------------------------------------------
// Character Output - STDOUT
//-----------------------------------------------------------------------------

  wire [7:0]  chardata = {1'b0, EXTGPIO[14:8]};

  wire        charstrobe = EXTGPIO[15];

  always@(charstrobe)
    if(charstrobe == 1'b1)
       $write ("%c", chardata);

//-----------------------------------------------------------------------------
// TESTCOMPLETE, TESTPASS
//-----------------------------------------------------------------------------

  pulldown(EXTGPIO[0]);
  pulldown(EXTGPIO[1]);

  wire        TESTCOMPLETE = EXTGPIO[0];

  wire        TESTPASS = EXTGPIO[1];

  always@(posedge CLK)
    begin
      if(TESTCOMPLETE == 1'b1)
        begin
          if(TESTPASS == 1'b1)
               $display ("** TEST PASSED OK ** (Time:%d)", $time);
          else
               $display ("** TEST FAILED ** (Time:%d)", $time);
          $finish;
        end
    end

//-----------------------------------------------------------------------------
// Runaway Simulation Timer
//-----------------------------------------------------------------------------

  initial
    begin
      #`ARM_CM0PIK_SIM_TIMEOUT
      $display ("** TEST KILLED ** (Time:%d)", $time);
      $finish(2);
    end

//-----------------------------------------------------------------------------
// Tarmac
//-----------------------------------------------------------------------------

`ifdef ARM_CM0PIK_TARMAC

`define ARM_CM0PIK_PATH tbench.u_mcu.u_sys.u_cm0pmtbintegration.u_cm0pintegration.u_imp.u_cortexm0plus

 cm0p_tarmac
   u_tarmac
     (.en_i           (1'b1),
      .echo_i         (1'b0),
      .id_i           (32'h0),
      .use_time_i     (1'b1),
      .tube_i         (32'h40400000),
      .halted_i       (`ARM_CM0PIK_PATH.HALTED),
      .lockup_i       (`ARM_CM0PIK_PATH.LOCKUP),
      .hclk           (`ARM_CM0PIK_PATH.HCLK),
      .hready_i       (`ARM_CM0PIK_PATH.HREADY),
      .haddr_i        (`ARM_CM0PIK_PATH.HADDR[31:0]),
      .hprot_i        (`ARM_CM0PIK_PATH.HPROT[3:0]),
      .hsize_i        (`ARM_CM0PIK_PATH.HSIZE[2:0]),
      .hwrite_i       (`ARM_CM0PIK_PATH.HWRITE),
      .htrans_i       (`ARM_CM0PIK_PATH.HTRANS[1:0]),
      .hresetn_i      (`ARM_CM0PIK_PATH.HRESETn),
      .hresp_i        (`ARM_CM0PIK_PATH.HRESP),
      .hrdata_i       (`ARM_CM0PIK_PATH.HRDATA[31:0]),
      .hwdata_i       (`ARM_CM0PIK_PATH.HWDATA[31:0]),
      .ppb_trans_i    (`ARM_CM0PIK_PATH.u_top.u_sys.u_matrix.ppb_trans),
      .scs_rdata_i    (`ARM_CM0PIK_PATH.u_top.u_sys.u_matrix.scs_rdata),
      .ahb_trans_i    (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.ahb_trans),
      .ipsr_i         (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.ipsr_q[5:0]),
      .tbit_i         (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.tbit_q),
      .fault_i        (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.fault_q),
      .cc_pass_i      (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.cc_pass),
      .spsel_i        (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.spsel_q),
      .npriv_i        (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.npriv_q),
      .primask_i      (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.primask_q),
      .apsr_i         (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.apsr_q[3:0]),
      .state_i        (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.state_q[3:0]),
      .op_i           (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.op_q[15:0]),
      .op_s_i         (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.op_s_q),
      .iq_i           (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.iq_q[15:0]),
      .iq_s_i         (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.iq_s_q),
      .psp_en_i       (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.psp_en),
      .msp_en_i       (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.msp_en),
      .wr_data_i      (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.wr_data[31:0]),
      .wr_data_sp_i   (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.wr_data_sp[29:0]),
      .wr_addr_en_i   (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.wr_addr_en[3:0]),
      .iaex_i         (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.iaex_q[30:0]),
      .preempt_i      (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.preempt),
      .int_ready_i    (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.int_ready_q),
      .irq_ack_i      (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.irq_ack),
      .rfe_ack_i      (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.rfe_ack),
      .int_pend_num_i (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.nvm_int_pend_num_i[5:0]),
      .atomic_i       (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.atomic_q),
      .hardfault_i    (`ARM_CM0PIK_PATH.u_top.u_sys.u_core.hdf_req),
      .iotrans_i      (`ARM_CM0PIK_PATH.IOTRANS),
      .iowrite_i      (`ARM_CM0PIK_PATH.IOWRITE),
      .iosize_i       (`ARM_CM0PIK_PATH.IOSIZE[1:0]),
      .ioaddr_i       (`ARM_CM0PIK_PATH.IOADDR[31:0]),
      .iordata_i      (`ARM_CM0PIK_PATH.IORDATA[31:0]),
      .iowdata_i      (`ARM_CM0PIK_PATH.IOWDATA[31:0]),
      .slvtrans_i     (`ARM_CM0PIK_PATH.SLVTRANS[1:0]),
      .slvwrite_i     (`ARM_CM0PIK_PATH.SLVWRITE),
      .slvsize_i      (`ARM_CM0PIK_PATH.SLVSIZE[1:0]),
      .slvaddr_i      (`ARM_CM0PIK_PATH.SLVADDR[31:0]),
      .slvrdata_i     (`ARM_CM0PIK_PATH.SLVRDATA[31:0]),
      .slvwdata_i     (`ARM_CM0PIK_PATH.SLVWDATA[31:0]),
      .slvready_i     (`ARM_CM0PIK_PATH.SLVREADY),
      .slvresp_i      (`ARM_CM0PIK_PATH.SLVRESP)
  );

`endif // ARM_CM0PIK_TARMAC



endmodule // tbench
