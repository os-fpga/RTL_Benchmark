// Copyright (c) 2013-2020 Qualcomm Technologies, Inc. All rights reserved.
// This RTL contains confidential and trade secret material and you may make, have
// made, use, reproduce, display or perform (publicly or otherwise), prepare
// derivative works based on, offer for sale, sell, distribute, import,
// disclose, license, sublicense, dispose of and otherwise exploit this RTL solely in
// accordance with your license agreement.
// If you have not agreed to all of the terms and conditions in such License
// Agreement, you should immediately return this RTL (including any copies)
// to your licensor.
// This RTL or portions thereof are protected under U.S. and foreign patent and patent applications.


`ifndef ANVU_INTERFACES
`define ANVU_INTERFACES

`include "anvu_defines.sv"
`include "anvu_axi_interface.sv"
`include "anvu_apb_interface.sv"
`include "anvu_ahb_interface.sv"

interface anvu_rstn_if();
	wire Clk     ;
	wire RstN    ;
clocking clk_blk @(Clk);
	input     Clk;
endclocking

clocking driver_cb @(posedge Clk);
	default input #`ANVU_TIMEINCREMENT output #`ANVU_TIMEINCREMENT ;
	inout RstN    ; // Defined inout so that we can drive, but also reread the value to check when the change is effectively done
endclocking

logic   RstN_async;
assign  RstN = RstN_async;
initial RstN_async = 1'hz;

modport driver_port(clocking driver_cb,inout RstN);

endinterface: anvu_rstn_if

interface anvu_clk_if();
	logic Clk ;
	logic Sel ;

modport driver_port(output Clk,output Sel);

endinterface: anvu_clk_if

interface anvu_signal_if ();
	wire Clk          ;
	wire[63:0] Signal ;
clocking clk_blk @(Clk);
	input     Clk;
endclocking

clocking driver_cb @(posedge Clk);
	default input #`ANVU_TIMEINCREMENT output #`ANVU_TIMEINCREMENT ;
	inout Signal    ; // Defined inout so that we can drive, but also reread the value to check when the change is effectively done
endclocking

clocking reader_cb @(posedge Clk);
	default input #`ANVU_TIMEINCREMENT output #`ANVU_TIMEINCREMENT ;
	input Signal    ;
endclocking

clocking mon_cb @(posedge Clk);
	default input #`ANVU_TIMEINCREMENT output #`ANVU_TIMEINCREMENT ;
	input Signal    ;
endclocking

logic[63:0]  Signal_async;
assign  Signal = Signal_async;
initial Signal_async = 64'hzzzzzzzzzzzzzzzz;


modport reader_port(clocking reader_cb,input Signal);
modport driver_port(clocking driver_cb,inout Signal);
modport mon_port(clocking mon_cb,input Signal);

endinterface: anvu_signal_if




//
//interface anvu_clkEn_if ();
//	wire Clk          ;
//	wire ClkEn ;
//clocking clk_blk @(Clk);
//  input     Clk;
//endclocking
//
//clocking driver_cb @(posedge Clk);
//	default input #`ANVU_TIMEINCREMENT output #`ANVU_TIMEINCREMENT ;
//	inout ClkEn    ; // Defined inout so that we can drive, but also reread the value to check when the change is effectively done
//endclocking
//
//modport driver_port(clocking driver_cb);
//
//endinterface: anvu_clkEn_if

`endif // ANVU_INTERFACES
