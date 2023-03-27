/********************************
 * Module: 	gbox_hpio_40
 * Date:	8/22/2022	
 * Compnay:	RapidSilicon
 * Created by Alex Hsiung
 *  Description : gearbox HPIO bank of 40
********************************/
////** PAR_X_DWID : gearbox data path width,  value allowed 10 or 5 
////** PAR_TWID : delay tap value, 64 taps
////** PAR_TYPE : 1--> RS_HPIO_DIF_EW 
////** PAR_TYPE : 2--> RS_HPIO_DIF_NS 
////** PAR_TYPE : 3--> RS_HVIO_DIF_EW 
////** PAR_TYPE : 4--> RS_HVIO_DIF_NS 

module gbox_hpio_40
#(
   parameter PAR_IO_NUM = 40,
   parameter PAR_TYPE = 1,
   parameter PAR_TX_DWID = 10,
   parameter PAR_RX_DWID = 10,
   parameter PAR_TWID =  6
)
(
   inout VDD,
   inout VDDIO,
   inout VDD18,
   inout VSS,
   input [PAR_IO_NUM/2 - 1 : 0 ] DFEN, 
   input [3:0] MC [PAR_IO_NUM - 1 : 0 ], 
   input [PAR_IO_NUM - 1 : 0 ] SR, 
   input [PAR_IO_NUM - 1 : 0 ] PE, 
   input [PAR_IO_NUM - 1 : 0 ] PUD, 
   input DFODTEN, 
   output logic [PAR_IO_NUM - 1 : 0 ] CDET, 
   inout  [PAR_IO_NUM - 1 : 0 ] IO , 
   input PGEN, // TODO RS_HP_VDDIO_TERM_EW
   input EN, // TODO  RS_HP_VREF_EW
   inout RCAL_IO ,  // RCAL signals
   input RCAL_CK,  // RCAL signals
   input RCAL_MSTR,  // RCAL signals
   input RCAL_RST,  // RCAL signals
   inout [4:0] AIXN,  // RCAL signals
   inout [4:0] AIXP,  // RCAL signals
//**************************************
  input  system_reset_n, 		// Input async system Reset
  input  pll_lock ,  
  input  [3:0] cfg_rate_sel [ PAR_IO_NUM - 1 : 0] ,  
  input  cfg_done  ,  
  input  [PAR_IO_NUM - 1:0] cfg_chan_master  ,  
  input  [1:0] cfg_tx_clk_phase [ PAR_IO_NUM - 1 : 0], 
  input  [PAR_IO_NUM - 1:0] cfg_tx_clk_io , // fast clock divided by 2 in DDR mode
  input  [PAR_IO_NUM - 1:0] cfg_peer_is_on  ,  
  input  [PAR_IO_NUM - 1:0] cfg_tx_bypass  ,  
  input  [PAR_IO_NUM - 1:0] cfg_rx_bypass  ,  
  input  [PAR_TWID-1:0] cfg_tx_dly [ PAR_IO_NUM - 1 : 0],  
  input  [PAR_TWID-1:0] cfg_rx_dly [ PAR_IO_NUM - 1 : 0],  
  input  [1:0] cfg_tx_ddr_mode  [ PAR_IO_NUM - 1 : 0],  
  input  [1:0] cfg_rx_ddr_mode  [ PAR_IO_NUM - 1 : 0],  
  input  fast_clk,  			// Input fast Clock
  input  [3:0] fast_phase_clk  ,  
  input  [PAR_IO_NUM - 1:0] f2g_tx_reset_n,  // Input sync Reset , core clock domain
  input  [PAR_IO_NUM - 1:0] f2g_tx_core_clk,  // core clock domain
  input  [PAR_IO_NUM - 1:0] f2g_tx_dly_ld , 
  input  [PAR_IO_NUM - 1:0] f2g_tx_dly_adj , 
  input  [PAR_IO_NUM - 1:0] f2g_tx_dly_inc , 
  input  [PAR_IO_NUM - 1:0] f2g_tx_oe ,  		// core clock
  input  [PAR_TX_DWID-1:0] f2g_tx_out [ PAR_IO_NUM/2 - 1 : 0] ,  // core clock
  input  [PAR_IO_NUM - 1:0] f2g_in_en ,  		// core clock
  input  [PAR_IO_NUM - 1:0] f2g_tx_dvalid,  			// core clock domain
  input  [PAR_IO_NUM - 1:0] f2g_rx_reset_n,  			// Input sync Reset , core clock domain
  input  [PAR_IO_NUM - 1:0] f2g_rx_sfifo_reset,  		// dpa sync_fifo_dpa fifo reset , core clock domain
  input  [PAR_IO_NUM - 1:0] f2g_rx_dly_ld , 
  input  [PAR_IO_NUM - 1:0] f2g_rx_dly_adj , 
  input  [PAR_IO_NUM - 1:0] f2g_rx_dly_inc , 
  input  [PAR_IO_NUM - 1:0] f2g_rx_bitslip_adj ,  		// core clock
  input  [1:0] f2g_rx_dpa_mode [ PAR_IO_NUM - 1 : 0] ,  
  input  [PAR_IO_NUM - 1:0] f2g_rx_dpa_restart ,  		// core clock
///  input  bank_fast_clk_sync_in ,  	// fast clock from adjacent IO BANK
///  input  [PAR_IO_NUM - 1:0] bank_fast_cdr_clk_sync_in ,  	// fast clock from adjacent GBOX
//****************************
///  output logic bank_fast_clk_sync_out , // fast clock domain to adjacent IO BANK
///  output logic bank_fast_cdr_clk_sync_out , // fast clock domain to adjacent IO BANK
////  output logic [PAR_IO_NUM - 1:0] cdr_clk , // fast clock domain
  output logic [PAR_TWID-1:0] g2f_tx_dly_tap [ PAR_IO_NUM - 1 : 0], 	// core clock domain
  output logic [PAR_IO_NUM - 1:0] g2f_core_clk , 	// core clock domain , used by both tx and rx if source-synchronous
  output logic [PAR_IO_NUM - 1:0] g2f_rx_cdr_core_clk , 	// core clock domain , used by only rx if not source-synchronous
  output logic [PAR_IO_NUM - 1:0] g2f_rx_dpa_lock , 		// fast clock domain
  output logic [PAR_IO_NUM - 1:0] g2f_rx_dpa_error , 		// fast clock domain
  output logic [2:0] g2f_rx_dpa_phase [ PAR_IO_NUM - 1 : 0] , 	// fast clock domain
  output logic [PAR_TWID-1:0] g2f_rx_dly_tap [ PAR_IO_NUM - 1 : 0], 	// core clock domain
  output logic [PAR_RX_DWID-1:0] g2f_rx_in [ PAR_IO_NUM/2 - 1 : 0], // quasi core clock domain 
  output logic [PAR_IO_NUM - 1:0] g2f_rx_dvalid  // core clock domain 
);
//*****************************************************************************
////RS_HP_VDDIO_POC_EW  inout POC,
wire POC; 
wire [4:0] AICP; 
wire [4:0] AICN; 
wire  VREF ;
wire [PAR_IO_NUM - 1:0] fast_clk_sync_in ; 
wire [PAR_IO_NUM - 1:0] fast_clk_sync_out ;
wire [PAR_IO_NUM - 1:0] fast_cdr_clk_sync_in ; 
wire [PAR_IO_NUM - 1:0] fast_cdr_clk_sync_out ;
//*****************************************************************************
assign fast_clk_sync_in  = {fast_clk_sync_out[PAR_IO_NUM-3 : 0] ,2'b00 } ;  // even to even , odd to odd
assign fast_cdr_clk_sync_in  = {fast_cdr_clk_sync_out[PAR_IO_NUM-3 : 0] ,2'b00 } ;  // even to even , odd to odd
//*****************************************************************************
generate
for (genvar i=0; i < PAR_IO_NUM/2 ; i++)  begin
gbox_hpio #(
       .PAR_TYPE(PAR_TYPE), // HPIO
       .PAR_TX_DWID(PAR_TX_DWID),
       .PAR_RX_DWID(PAR_RX_DWID),
       .PAR_TWID(PAR_TWID)
) u_gbox_hpio_gen (
    .VDD					(VDD),
    .VDDIO					(VDDIO),
    .VDD18					(VDD18),
    .VREF					(VREF),
    .VSS					(VSS),
    .POC					(POC),
    .DFEN					(DFEN[i]), 
    .AICP					(AICP), 
    .AICN					(AICN), 
    .MCA					(MC[2*i]), 
    .MCB					(MC[2*i+1]), 
    .SRA					(SR[2*i]),
    .SRB					(SR[2*i+1]),
    .PEA					(PE[2*i]),
    .PEB					(PE[2*i+1]),
    .PUDA					(PUD[2*i]),
    .PUDB					(PUD[2*i+1]),
    .DFODTEN				(DFODTEN), 
    .CDETA					(CDET[2*i]), 
    .CDETB					(CDET[2*i+1]), 
    .IOB					(IO[2*i]) ,  
    .IOA					(IO[2*i+1]) , 
//*****************************************************************************
	.system_reset_n			(system_reset_n), 		// Input async system Reset
    .pll_lock				(pll_lock) ,  
    .cfg_rate_sel 			(cfg_rate_sel[2*i +: 2]  ),  
    .cfg_done  				(cfg_done  ),  
    .cfg_chan_master 		(cfg_chan_master[2*i +: 2] ),  
    .cfg_tx_clk_phase  		(cfg_tx_clk_phase[2*i +: 2] ),  
    .cfg_tx_clk_io 		(cfg_tx_clk_io[2*i +: 2] ), 		// fast clock divided by 2 in DDR mode
    .cfg_peer_is_on  		(cfg_peer_is_on[2*i +: 2] ),
    .cfg_tx_bypass  		(cfg_tx_bypass[2*i +: 2] ),  
    .cfg_rx_bypass  		(cfg_rx_bypass[2*i +: 2] ),  
    .cfg_tx_dly  		(cfg_tx_dly[2*i +: 2] ),  
    .cfg_rx_dly  		(cfg_rx_dly[2*i +: 2] ),  
    .cfg_tx_ddr_mode  		(cfg_tx_ddr_mode[2*i +: 2] ),  
    .cfg_rx_ddr_mode  		(cfg_rx_ddr_mode[2*i +: 2] ),  
    .fast_clk			(fast_clk),		// Input fast Clock
    .fast_phase_clk  		(fast_phase_clk  ),  
    .f2g_tx_reset_n		(f2g_tx_reset_n[2*i +: 2] ),		// Input sync Reset , core clock domain
    .f2g_tx_core_clk		(f2g_tx_core_clk[2*i +: 2] ),		// core clock domain
    .f2g_tx_dly_ld 		(f2g_tx_dly_ld[2*i +: 2]  ), 
    .f2g_tx_dly_adj 		(f2g_tx_dly_adj[2*i +: 2] ), 
    .f2g_tx_dly_inc 		(f2g_tx_dly_inc[2*i +: 2] ), 
    .f2g_tx_oe 			(f2g_tx_oe[2*i +: 2] ),	// core clock
    .f2g_tx_out 		(f2g_tx_out[i] ), // core clock
    .f2g_in_en 			(f2g_in_en[2*i +: 2] ),	// core clock
    .f2g_tx_dvalid 		(f2g_tx_dvalid[2*i +: 2] ), // core clock
    .f2g_rx_reset_n		(f2g_rx_reset_n[2*i +: 2]  ),		// Input sync Reset , core clock domain
    .f2g_rx_sfifo_reset		(f2g_rx_sfifo_reset[2*i +: 2] ),	// dpa sync_fifo_dpa fifo reset , core clock domain
    .f2g_rx_dly_ld 		(f2g_rx_dly_ld[2*i +: 2] ), 
    .f2g_rx_dly_adj 		(f2g_rx_dly_adj[2*i +: 2] ), 
    .f2g_rx_dly_inc 		(f2g_rx_dly_inc[2*i +: 2] ), 
    .f2g_rx_bitslip_adj 	(f2g_rx_bitslip_adj[2*i +: 2] ),	// core clock
    .f2g_rx_dpa_mode  		(f2g_rx_dpa_mode[2*i +: 2] ),  
    .f2g_rx_dpa_restart 	(f2g_rx_dpa_restart[2*i +: 2] ),	// core clock
    .fast_clk_sync_in 		(fast_clk_sync_in[2*i +: 2] ),// fast clock from adjacent GBOX, even to even , odd to odd
    .fast_cdr_clk_sync_in 	(fast_cdr_clk_sync_in[2*i +: 2] ), // fast clock from adjacent GBOX, even to even , odd to odd
//****************************
    .fast_clk_sync_out 		(fast_clk_sync_out[2*i +: 2] ), // fast clock domain to adjacent GBOX
    .fast_cdr_clk_sync_out 	(fast_cdr_clk_sync_out[2*i +: 2] ), // fast clock domain to adjacent GBOX
////    .g2i_tx_clk 		(g2i_tx_clk[2*i +: 2] ), 		// fast clock divided by 2 in DDR mode
    .cdr_clk 			() , //// cdr_clk[2*i +: 2] ), 		// fast clock domain
    .g2f_tx_dly_tap 		(g2f_tx_dly_tap[2*i +: 2] ), 	// core clock domain
    .g2f_core_clk 		(g2f_core_clk[2*i +: 2] ), 	// core clock domain , used by both tx and rx if source-synchronous
    .g2f_rx_cdr_core_clk 	(g2f_rx_cdr_core_clk[2*i +: 2] ), 	// core clock domain , used by only rx if not source-synchronous
    .g2f_rx_dpa_lock 		(g2f_rx_dpa_lock[2*i +: 2] ), 		// fast clock domain
    .g2f_rx_dpa_error 		(g2f_rx_dpa_error[2*i +: 2] ), 		// fast clock domain
    .g2f_rx_dpa_phase 		(g2f_rx_dpa_phase[2*i +: 2] ), 	// fast 
    .g2f_rx_dly_tap 		(g2f_rx_dly_tap[2*i +: 2] ), 	// core clock domain
    .g2f_rx_in 			(g2f_rx_in[i] ), //  core clock domain 
    .g2f_rx_dvalid		(g2f_rx_dvalid[2*i +: 2] )  // core clock domain
);
 end
endgenerate
//*****************************************************************************
generate 
if (PAR_TYPE == 1) begin
RS_HP_VDDIO_TERM_EW RS_HP_VDDIO_TERM_EW_1 (
 .AICN (AICN) , // inout
 .AICP (AICP) , // inout  
 .AIXN (AIXN) , // inout
 .AIXP (AIXP) , // inout  
 .PGEN (PGEN) , //  input  
 .POC (POC) , //  input  
 .VDD(VDD),  // inout
 .VDDIO(VDDIO),  // inout
 .VDD18(VDD18),  // inout
 .VREF(VREF),  // inout
 .VSS(VSS) ) ;  // inout
//***************
RS_HPIO_RCAL_EW u_RS_HPIO_RCAL_EW  (
 .IO (RCAL_IO) , // inout
 .DOUT () , // output
 .CK (RCAL_CK),  // input
 .DIN (1'b0) ,  // input
 .IE (1'b0) ,  // input
 .MSTR (RCAL_MSTR) ,  // input
 .OE (1'b0) ,  // input
 .PE (1'b0) ,  // input
 .PUD (1'b0) ,  // input
 .RST (RCAL_RST) ,  // input
 .AICN (AICN) , // inout
 .AICP (AICP) , // inout  
 .POC (POC) , //  input  
 .VDD(VDD),  // inout
 .VDDIO(VDDIO),  // inout
 .VDD18(VDD18),  // inout
 .VREF(VREF),  // inout
 .VSS(VSS) ) ;  // inout
//***************
RS_HP_VDDIO_POC_EW u_RS_HP_VDDIO_POC_EW (
 .AICN (AICN) , // input
 .AICP (AICP) , // input  
 .POC (POC) , //  inout  
 .VDD(VDD),  // inout
 .VDDIO(VDDIO),  // inout
 .VDD18(VDD18),  // inout
 .VREF(VREF),  // inout
 .VSS(VSS) ) ;  // inout
//***************
RS_HP_VDDIO_TERM_EW RS_HP_VDDIO_TERM_EW_44 (
 .AICN (AICN) , // inout
 .AICP (AICP) , // inout  
 .AIXN (AIXN) , // inout
 .AIXP (AIXP) , // inout  
 .PGEN (PGEN) , //  input  
 .POC (POC) , //  input  
 .VDD(VDD),  // inout
 .VDDIO(VDDIO),  // inout
 .VDD18(VDD18),  // inout
 .VREF(VREF),  // inout
 .VSS(VSS) ) ;  // inout
//***************
RS_HP_VREF_EW u_RS_HP_VREF_EW (
 .AICN (AICN) , // input
 .AICP (AICP) , // input  
 .EN (EN)  ,//  input  
 .POC (POC) , //  input  
 .VDD(VDD),  // inout
 .VDDIO(VDDIO),  // inout
 .VDD18(VDD18),  // inout
 .VREF(VREF),  // inout
 .VSS(VSS) ) ;  // inout
//***************
RS_HP_VDD_EW u_RS_HP_VDD_EW (
 .AICN (AICN) , // input
 .AICP (AICP) , // input  
 .POC (POC) , //  input  
 .VDD(VDD),  // inout
 .VDDIO(VDDIO),  // inout
 .VDD18(VDD18),  // inout
 .VREF(VREF),  // inout
 .VSS(VSS) ) ;  // inout
//***************
end
//*************************
//*************************
//*************************
//*************************
//*************************
else if (PAR_TYPE == 2) begin
RS_HP_VDDIO_TERM_NS RS_HP_VDDIO_TERM_NS_0 (
 .AICN (AICN) , // inout
 .AICP (AICP) , // inout  
 .AIXN (AIXN) , // inout
 .AIXP (AIXP) , // inout  
 .PGEN (PGEN) , //  input  
 .POC (POC) , //  input  
 .VDD(VDD),  // inout
 .VDDIO(VDDIO),  // inout
 .VDD18(VDD18),  // inout
 .VREF(VREF),  // inout
 .VSS(VSS) ) ;  // inout
//***************
RS_HPIO_RCAL_NS u_RS_HPIO_RCAL_NS  (
 .IO (RCAL_IO) , // inout
 .DOUT (RCAL_DOUT) , // output
 .CK (RCAL_CK),  // input
 .DIN (RCAL_DIN) ,  // input
 .IE (RCAL_IE) ,  // input
 .MSTR (RCAL_MSTR) ,  // input
 .OE (RCAL_OE) ,  // input
 .PE (RCAL_PE) ,  // input
 .PUD (RCAL_PUD) ,  // input
 .RST (RCAL_RST) ,  // input
 .AICN (AICN) , // inout
 .AICP (AICP) , // inout  
 .POC (POC) , //  input  
 .VDD(VDD),  // inout
 .VDDIO(VDDIO),  // inout
 .VDD18(VDD18),  // inout
 .VREF(VREF),  // inout
 .VSS(VSS) ) ;  // inout
//***************
RS_HP_VDDIO_POC_NS u_RS_HP_VDDIO_POC_NS (
 .AICN (AICN) , // input
 .AICP (AICP) , // input  
 .POC (POC) , //  inout  
 .VDD(VDD),  // inout
 .VDDIO(VDDIO),  // inout
 .VDD18(VDD18),  // inout
 .VREF(VREF),  // inout
 .VSS(VSS) ) ;  // inout
//***************
RS_HP_VDDIO_TERM_NS RS_HP_VDDIO_TERM_NS_44 (
 .AICN (AICN) , // inout
 .AICP (AICP) , // inout  
 .AIXN (AIXN) , // inout
 .AIXP (AIXP) , // inout  
 .PGEN (PGEN) , //  input  
 .POC (POC) , //  input  
 .VDD(VDD),  // inout
 .VDDIO(VDDIO),  // inout
 .VDD18(VDD18),  // inout
 .VREF(VREF),  // inout
 .VSS(VSS) ) ;  // inout
//***************
RS_HP_VREF_NS u_RS_HP_VREF_NS (
 .AICN (AICN) , // input
 .AICP (AICP) , // input  
 .EN (EN) , //  input  
 .POC (POC) , //  input  
 .VDD(VDD),  // inout
 .VDDIO(VDDIO),  // inout
 .VDD18(VDD18),  // inout
 .VREF(VREF),  // inout
 .VSS(VSS) ) ;  // inout
//***************
RS_HP_VDD_NS u_RS_HP_VDD_NS (
 .AICN (AICN) , // input
 .AICP (AICP) , // input  
 .POC (POC) , //  input  
 .VDD(VDD),  // inout
 .VDDIO(VDDIO),  // inout
 .VDD18(VDD18),  // inout
 .VREF(VREF),  // inout
 .VSS(VSS) ) ;  // inout
//***************
end
endgenerate
//*****************************************************************************
//*****************************************************************************
endmodule

