/********************************
 * Module: 	gbox_iobp_o
 * Date:	6/10/2022	
 * Compnay:	RapidSilicon
 * Created by Alex Hsiung
 * gearbox IO bypass for output
 *  Description : output bypass IO, customer design ?
********************************/

module gbox_iobp_o
( 
  input clk,
  input cfg_bypass,
  input [1:0] cfg_ddr_mode,
  input [1:0] din,
//**************************
  output logic dout
);
//*****************************************************************************
logic 	ddr_mode ;
logic 	sdr_mode ;
logic 	direct_mode ;
logic [1:0]  din_d1 ;
logic 	din_d2_1 ;
//*****************************************************************************
always @(posedge clk )
	din_d1 <= din ;

always @(negedge clk )
	din_d2_1 <= din_d1[1] ;

assign ddr_mode    =  cfg_bypass && cfg_ddr_mode[0] ;
assign sdr_mode    =  cfg_bypass && cfg_ddr_mode[1] ;
assign direct_mode =  cfg_bypass && !ddr_mode && ! sdr_mode ;

assign dout =  direct_mode & din[0] |
               sdr_mode & din_d1[0] |
	       ddr_mode & (clk & din_d1[0] | !clk & din_d2_1) ;
//*****************************************************************************
endmodule
