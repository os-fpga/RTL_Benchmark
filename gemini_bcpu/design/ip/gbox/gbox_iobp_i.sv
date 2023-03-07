/********************************
 * Module: 	gbox_iobp_i
 * Date:	8/10/2022	
 * Compnay:	RapidSilicon
 * Created by Alex Hsiung
 * gearbox IO bypass for input
 *  Description : input bypass IO, customer design ?
********************************/

module gbox_iobp_i
( 
  input clk,
  input cfg_bypass,
  input [1:0] cfg_ddr_mode,
  input din, // from tap delay
//**************************
  output logic dout0, // sdr , ddr , direct
  output logic dout1 // ddr
);
//*****************************************************************************
logic 	ddr_mode ;
logic 	sdr_mode ;
logic 	direct_mode ;
logic 	din_d1_neg ;
logic 	din_d1_pos ;
logic 	p_dout0 ;
logic 	dout0_a ;
//*****************************************************************************
assign ddr_mode    =  cfg_bypass && cfg_ddr_mode[0] ;
assign sdr_mode    =  cfg_bypass && cfg_ddr_mode[1] ;
assign direct_mode =  cfg_bypass && !ddr_mode && ! sdr_mode ;
//*****************************************************************************
assign dout0 = direct_mode ? din : dout0_a ;
//*****************************************************************************
always @(negedge clk )
	din_d1_neg <= din ;

always @(posedge clk )
	din_d1_pos <= din ;

always @(posedge clk )
	dout1 <= din_d1_neg ;

always @(posedge clk )
	dout0_a <= p_dout0 ;

assign p_dout0 = ddr_mode & din_d1_pos | sdr_mode & din ;
//*****************************************************************************
endmodule
