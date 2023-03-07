/********************************
 * Module: 	gbox_hpio
 * Date:	8/18/2022	
 * Compnay:	RapidSilicon
 * Created by Alex Hsiung
 *  Description : gearbox HPIO
********************************/
////** PAR_X_DWID : gearbox data path width,  value allowed 10 or 5 
////** PAR_TWID : delay tap value, either 32 taps or 64 taps
////** PAR_TYPE : 1--> RS_HPIO_DIF_EW 
////** PAR_TYPE : 2--> RS_HPIO_DIF_NS 
////** PAR_TYPE : 3--> RS_HVIO_DIF_EW 
////** PAR_TYPE : 4--> RS_HVIO_DIF_NS 

module gbox_hpio
#(
   parameter PAR_TYPE = 1,
   parameter PAR_TX_DWID = 10,
   parameter PAR_RX_DWID = 10,
   parameter PAR_TWID =  6
)
(
   inout VDD,
   inout VDDIO,
   inout VDD18,
   inout VREF,
   inout VSS,
   input POC,
   input DFEN, 
   input [4:0] AICP, 
   input [4:0] AICN, 
   input [3:0] MCA, 
   input [3:0] MCB, 
   input SRA, 
   input SRB, 
   input PEA, 
   input PEB, 
   input PUDA, 
   input PUDB, 
   input DFODTEN, 
   output logic CDETA, 
   output logic CDETB, 
   inout IOA , 
   inout IOB , 
//**************************************
  input  system_reset_n, 		// Input async system Reset
  input  pll_lock ,  
  input  [3:0] cfg_rate_sel [0:1] ,  
  input  cfg_done  ,  
////  input  [1:0] cfg_dif  ,  
  input  [1:0] cfg_chan_master  ,  
  input  [1:0] cfg_tx_clk_phase [0:1], 
  input  [1:0] cfg_tx_clk_io  ,  
  input  [1:0] cfg_peer_is_on  ,  
  input  [1:0] cfg_tx_bypass  ,  
  input  [1:0] cfg_rx_bypass  ,  
  input  [PAR_TWID-1:0] cfg_tx_dly [0:1],  
  input  [PAR_TWID-1:0] cfg_rx_dly [0:1],  
  input  [1:0] cfg_tx_ddr_mode  [0:1],  
  input  [1:0] cfg_rx_ddr_mode  [0:1],  
  input  fast_clk,  			// Input fast Clock
  input  [3:0] fast_phase_clk  ,  
  input  [1:0] f2g_tx_reset_n,  			// Input sync Reset , core clock domain
  input  [1:0] f2g_tx_core_clk,  // core clock domain
  input  [1:0] f2g_tx_dly_ld , 
  input  [1:0] f2g_tx_dly_adj , 
  input  [1:0] f2g_tx_dly_inc , 
  input  [1:0] f2g_tx_oe ,  		// core clock
  input  [PAR_TX_DWID-1:0] f2g_tx_out ,  // core clock
  input  [1:0] f2g_in_en ,  		// core clock
  input  [1:0] f2g_tx_dvalid,  			// core clock domain
  input  [1:0] f2g_rx_reset_n,  			// Input sync Reset , core clock domain
  input  [1:0] f2g_rx_sfifo_reset,  		// dpa sync_fifo_dpa fifo reset , core clock domain
  input  [1:0] f2g_rx_dly_ld , 
  input  [1:0] f2g_rx_dly_adj , 
  input  [1:0] f2g_rx_dly_inc , 
  input  [1:0] f2g_rx_bitslip_adj ,  		// core clock
  input  [1:0] f2g_rx_dpa_mode [0:1] ,  
  input  [1:0] f2g_rx_dpa_restart ,  		// core clock
  input  [1:0] fast_clk_sync_in ,  	// fast clock from adjacent GBOX
  input  [1:0] fast_cdr_clk_sync_in ,  	// fast clock from adjacent GBOX
//****************************
  output logic [1:0] fast_clk_sync_out , // fast clock domain to adjacent GBOX
  output logic [1:0] fast_cdr_clk_sync_out , // fast clock domain to adjacent GBOX
  output logic [1:0] cdr_clk , 		// fast clock domain
  output logic [PAR_TWID-1:0] g2f_tx_dly_tap [0:1], 	// core clock domain
  output logic [1:0] g2f_core_clk , 	// core clock domain , used by both tx and rx if source-synchronous
  output logic [1:0] g2f_rx_cdr_core_clk , 	// core clock domain , used by only rx if not source-synchronous
  output logic [1:0] g2f_rx_dpa_lock , 		// fast clock domain
  output logic [1:0] g2f_rx_dpa_error , 	// fast clock domain
  output logic [2:0] g2f_rx_dpa_phase [0:1] , 	// fast clock domain
  output logic [PAR_TWID-1:0] g2f_rx_dly_tap [0:1], 	// core clock domain
  output logic [PAR_RX_DWID-1:0] g2f_rx_in , // quasi core clock domain 
  output logic [1:0] g2f_rx_dvalid  // core clock domain 
);
//*****************************************************************************
logic [1:0] g2i_tx_out; 
logic [1:0] g2i_tx_clk ; 		// fast clock divided by 2 in DDR mode
logic [1:0] f_g2i_tx_out; 
logic [1:0] i2g_rx_in; 
logic [1:0] g2i_ie; 
logic [1:0] g2i_tx_oe; 
logic [5-1:0] g2f_rx_in_peer ; // core clock domain
logic i2g_rx_in_sdr , i2g_rx_in_dif ;
//*****************************************************************************
gbox_top #(
       .PAR_TX_DWID(PAR_TX_DWID),
       .PAR_RX_DWID(PAR_RX_DWID),
       .PAR_TWID(PAR_TWID)
) u_gbox_top_0 (
    .system_reset_n(system_reset_n), 		// Input async system Reset
    .pll_lock(pll_lock) ,  
    .cfg_rate_sel (cfg_rate_sel[0] ),  
    .cfg_done  (cfg_done  ),  
    .cfg_dif  (DFEN), // cfg_dif[0]  ),  
    .cfg_chan_master  (cfg_chan_master[0]  ),  
    .cfg_tx_clk_phase  (cfg_tx_clk_phase[0]  ),  
    .cfg_peer_is_on  (cfg_peer_is_on[0]  ),  
    .cfg_tx_bypass  (cfg_tx_bypass[0]  ),  
    .cfg_rx_bypass  (cfg_rx_bypass[0]  ),  
    .cfg_tx_dly  (cfg_tx_dly[0]  ),  
    .cfg_rx_dly  (cfg_rx_dly[0]  ),  
    .cfg_tx_ddr_mode  (cfg_tx_ddr_mode[0]  ),  
    .cfg_rx_ddr_mode  (cfg_rx_ddr_mode[0]  ),  
    .fast_clk(fast_clk),		// Input fast Clock
    .i2g_rx_in(i2g_rx_in[0]),		// Input fast Clock
    .fast_phase_clk  (fast_phase_clk  ),  
    .f2g_tx_reset_n(f2g_tx_reset_n[0]),		// Input sync Reset , core clock domain
    .f2g_tx_core_clk(f2g_tx_core_clk[0]),	// core clock domain
    .f2g_tx_dly_ld ( f2g_tx_dly_ld[0] ), 
    .f2g_tx_dly_adj ( f2g_tx_dly_adj[0] ), 
    .f2g_tx_dly_inc ( f2g_tx_dly_inc[0] ), 
    .f2g_tx_oe (f2g_tx_oe[0] ),	// core clock
    .f2g_tx_out ( f2g_tx_out ), // core clock
    .f2g_in_en (f2g_in_en[0] ),	// core clock
    .f2g_tx_dvalid ( f2g_tx_dvalid[0] ), // core clock
    .f2g_rx_reset_n(f2g_rx_reset_n[0]),		// Input sync Reset , core clock domain
    .f2g_rx_sfifo_reset( f2g_rx_sfifo_reset[0]),	// dpa sync_fifo_dpa fifo reset , core clock domain
    .f2g_rx_dly_ld ( f2g_rx_dly_ld[0] ), 
    .f2g_rx_dly_adj ( f2g_rx_dly_adj[0] ), 
    .f2g_rx_dly_inc ( f2g_rx_dly_inc[0] ), 
    .f2g_rx_bitslip_adj (f2g_rx_bitslip_adj[0] ),	// core clock
    .f2g_rx_dpa_mode  (f2g_rx_dpa_mode[0]  ),  
    .f2g_rx_dpa_restart ( f2g_rx_dpa_restart[0] ),	// core clock
    .fast_clk_sync_in (fast_clk_sync_in[0] ),// fast clock from adjacent GBOX
    .fast_cdr_clk_sync_in ( fast_cdr_clk_sync_in[0] ), // fast clock from adjacent GBOX
    .peer_data_in ( g2f_rx_in_peer ), // core clock domain
//****************************
    .fast_clk_sync_out ( fast_clk_sync_out[0] ), // fast clock domain to adjacent GBOX
    .fast_cdr_clk_sync_out ( fast_cdr_clk_sync_out[0] ), // fast clock domain to adjacent GBOX
    .g2i_tx_out (g2i_tx_out[0] ), 		// fast clock
    .g2i_tx_oe ( g2i_tx_oe[0] ), 		// fast clock
    .g2i_tx_clk (g2i_tx_clk[0] ), 		// fast clock divided by 2 in DDR mode
    .g2i_ie (g2i_ie[0] ), 	// core clock domain
    .cdr_clk (cdr_clk[0] ), 		// fast clock domain
    .g2f_tx_dly_tap (g2f_tx_dly_tap[0] ), 	// core clock domain
    .g2f_core_clk ( g2f_core_clk[0] ), 	// core clock domain , used by both tx and rx if source-synchronous
    .g2f_rx_cdr_core_clk ( g2f_rx_cdr_core_clk[0] ), 	// core clock domain , used by only rx if not source-synchronous
    .g2f_rx_dpa_lock ( 	g2f_rx_dpa_lock[0] ), 		// fast clock domain
    .g2f_rx_dpa_error ( g2f_rx_dpa_error[0] ), 		// fast clock domain
    .g2f_rx_dpa_phase ( g2f_rx_dpa_phase[0] ), 	// fast clock domain
    .g2f_rx_dly_tap ( g2f_rx_dly_tap[0] ), 	// core clock domain
    .g2f_rx_in ( g2f_rx_in ), // quasi core clock domain 
    .g2f_rx_dvalid(g2f_rx_dvalid[0])  // core clock domain 
);
//*****************************************************************************
gbox_top #(
       .PAR_TX_DWID(5),
       .PAR_RX_DWID(5),
       .PAR_TWID(PAR_TWID)
) u_gbox_top_1 (
    .system_reset_n(system_reset_n), 		// Input async system Reset
    .pll_lock(pll_lock) ,  
    .cfg_rate_sel (cfg_rate_sel[1] ),  
    .cfg_done  (cfg_done  ),  
    .cfg_dif  (1'b0) , // TODO cfg_dif[1]  ),  
    .cfg_chan_master  (cfg_chan_master[1]  ),  
    .cfg_tx_clk_phase  (cfg_tx_clk_phase[1]  ),  
    .cfg_peer_is_on  (1'b0), // _peer_is_on[1]  ),  
    .cfg_tx_bypass  (cfg_tx_bypass[1]  ),  
    .cfg_rx_bypass  (cfg_rx_bypass[1]  ),  
    .cfg_tx_dly  (cfg_tx_dly[1]  ),  
    .cfg_rx_dly  (cfg_rx_dly[1]  ),  
    .cfg_tx_ddr_mode  (cfg_tx_ddr_mode[1]  ),  
    .cfg_rx_ddr_mode  (cfg_rx_ddr_mode[1]  ),  
    .fast_clk(fast_clk),		// Input fast Clock
    .i2g_rx_in(i2g_rx_in[1]),		// Input fast Clock
    .fast_phase_clk  (fast_phase_clk  ),  
    .f2g_tx_reset_n(f2g_tx_reset_n[1]),		// Input sync Reset , core clock domain
    .f2g_tx_core_clk(f2g_tx_core_clk[1]),	// core clock domain
    .f2g_tx_dly_ld ( f2g_tx_dly_ld[1] ), 
    .f2g_tx_dly_adj ( f2g_tx_dly_adj[1] ), 
    .f2g_tx_dly_inc ( f2g_tx_dly_inc[1] ), 
    .f2g_tx_oe (f2g_tx_oe[1] ),	// core clock
    .f2g_tx_out ( f2g_tx_out[5-1:0] ), // core clock
    .f2g_in_en (f2g_in_en[1] ),	// core clock
    .f2g_tx_dvalid ( f2g_tx_dvalid[1] ), // core clock
    .f2g_rx_reset_n(f2g_rx_reset_n[1]),		// Input sync Reset , core clock domain
    .f2g_rx_sfifo_reset( f2g_rx_sfifo_reset[1]),	// dpa sync_fifo_dpa fifo reset , core clock domain
    .f2g_rx_dly_ld ( f2g_rx_dly_ld[1] ), 
    .f2g_rx_dly_adj ( f2g_rx_dly_adj[1] ), 
    .f2g_rx_dly_inc ( f2g_rx_dly_inc[1] ), 
    .f2g_rx_bitslip_adj (f2g_rx_bitslip_adj[1] ),	// core clock
    .f2g_rx_dpa_mode  (f2g_rx_dpa_mode[1]  ),  
    .f2g_rx_dpa_restart ( f2g_rx_dpa_restart[1] ),	// core clock
    .fast_clk_sync_in (fast_clk_sync_in[1] ),// fast clock from adjacent GBOX
    .fast_cdr_clk_sync_in ( fast_cdr_clk_sync_in[1] ), // fast clock from adjacent GBOX
    .peer_data_in ( 5'd0) , /// peer_data_in[1] ), // core clock domain
//****************************
    .fast_clk_sync_out ( fast_clk_sync_out[1] ), // fast clock domain to adjacent GBOX
    .fast_cdr_clk_sync_out ( fast_cdr_clk_sync_out[1] ), // fast clock domain to adjacent GBOX
    .g2i_tx_out (g2i_tx_out[1] ), 		// fast clock
    .g2i_tx_oe ( g2i_tx_oe[1] ), 		// fast clock
    .g2i_tx_clk ( g2i_tx_clk[1] ), 		// fast clock divided by 2 in DDR mode
    .g2i_ie (g2i_ie[1] ), 	// core clock domain
    .cdr_clk (cdr_clk[1] ), 		// fast clock domain
    .g2f_tx_dly_tap (g2f_tx_dly_tap[1] ), 	// core clock domain
    .g2f_core_clk ( g2f_core_clk[1] ), 	// core clock domain , used by both tx and rx if source-synchronous
    .g2f_rx_cdr_core_clk ( g2f_rx_cdr_core_clk[1] ), 	// core clock domain , used by only rx if not source-synchronous
    .g2f_rx_dpa_lock ( 	g2f_rx_dpa_lock[1] ), 		// fast clock domain
    .g2f_rx_dpa_error ( g2f_rx_dpa_error[1] ), 		// fast clock domain
    .g2f_rx_dpa_phase ( g2f_rx_dpa_phase[1] ), 	// fast clock domain
    .g2f_rx_dly_tap ( g2f_rx_dly_tap[1] ), 	// core clock domain
    .g2f_rx_in ( g2f_rx_in_peer ), // quasi core clock domain 
    .g2f_rx_dvalid(g2f_rx_dvalid[1])  // core clock domain 
);
//*****************************************************************************
assign i2g_rx_in[0] = DFEN ? i2g_rx_in_dif : i2g_rx_in_sdr ;
assign f_g2i_tx_out[0] = cfg_tx_clk_io[0] ? g2i_tx_clk[0] : g2i_tx_out[0] ;
assign f_g2i_tx_out[1] = cfg_tx_clk_io[1] ? g2i_tx_clk[1] : g2i_tx_out[1] ;
//*****************************************************************************
generate 
if (PAR_TYPE == 1) begin
RS_HPIO_DIF_EW u_RS_HPIO_DIF_EW  (
    .VDD(VDD),
    .VDDIO(VDDIO),
    .VDD18(VDD18),
    .VREF(VREF),
    .VSS(VSS),
    .POC(POC),
    .DFEN(DFEN), 
    .AICP(AICP), 
    .AICN(AICN), 
    .MCA(MCA), 
    .MCB(MCB), 
    .IEA(g2i_ie[0]),
    .IEB(g2i_ie[1]),
    .OEA(g2i_tx_oe[0]),
    .OEB(g2i_tx_oe[1]),
    .SRA(SRA),
    .SRB(SRB),
    .PEA(PEA),
    .PEB(PEB),
    .PUDA(PUDA),
    .PUDB(PUDB),
    .DINA(f_g2i_tx_out[0]),
    .DINB(f_g2i_tx_out[1]),
    .DOUTA(i2g_rx_in_sdr), 
    .DOUTB(i2g_rx_in[1]), 
    .DFTX(f_g2i_tx_out[0]), 
    .DFRX(i2g_rx_in_dif) ,  // TODO
    .DFRXEN(g2i_ie[0]), 
    .DFTXEN(g2i_tx_oe[0]), 
    .DFODTEN(DFODTEN), 
    .CDETA(CDETA), 
    .CDETB(CDETB), 
    .IOB(IOB) ,  // 1.2 - 1.8V PAD
    .IOA(IOA) ) ;  // 1.2 - 1.8V PAD
end
else if (PAR_TYPE == 2) begin
RS_HPIO_DIF_NS u_RS_HPIO_DIF_NS  (
    .VDD(VDD),
    .VDDIO(VDDIO),
    .VDD18(VDD18),
    .VREF(VREF),
    .VSS(VSS),
    .POC(POC),
    .DFEN(DFEN), 
    .AICP(AICP), 
    .AICN(AICN), 
    .MCA(MCA), 
    .MCB(MCB), 
    .IEA(g2i_ie[0]),
    .IEB(g2i_ie[1]),
    .OEA(g2i_tx_oe[0]),
    .OEB(g2i_tx_oe[1]),
    .SRA(SRA),
    .SRB(SRB),
    .PEA(PEA),
    .PEB(PEB),
    .PUDA(PUDA),
    .PUDB(PUDB),
    .DINA(f_g2i_tx_out[0]),
    .DINB(f_g2i_tx_out[1]),
    .DOUTA(i2g_rx_in_sdr), 
    .DOUTB(i2g_rx_in[1]), 
    .DFTX(f_g2i_tx_out[0]), 
    .DFRX(i2g_rx_in_dif) ,  // TODO
    .DFRXEN(g2i_ie[0]), 
    .DFTXEN(g2i_tx_oe[0]), 
    .DFODTEN(DFODTEN), 
    .CDETA(CDETA), 
    .CDETB(CDETB), 
    .IOB(IOB) ,  // 1.2 - 1.8V PAD
    .IOA(IOA) ) ;  // 1.2 - 1.8V PAD
end
endgenerate
//*****************************************************************************
endmodule

