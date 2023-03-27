/********************************
 * Module: 	gbox_iobp_oe
 * Date:	8/4/2022	
 * Compnay:	RapidSilicon
 * Created by Alex Hsiung
 * gearbox IO bypass for output
 * Description : output enable bypass IO, customer design ?
********************************/

module gbox_iobp_oe
( 
  input clk,
  input cfg_bypass,
  input [1:0] cfg_ddr_mode,
  input din,
//**************************
  output logic dout
);
//*****************************************************************************
logic 	ddr_mode ;
logic 	sdr_mode ;
logic 	direct_mode ;
logic   din_d1 ;
logic 	p_din_dly_n ;
logic 	din_dly_n ;
logic 	ddr_oe ;
//*****************************************************************************
assign ddr_mode    =  cfg_bypass && cfg_ddr_mode[0] ;
assign sdr_mode    =  cfg_bypass && cfg_ddr_mode[1] ;
assign direct_mode =  cfg_bypass && !ddr_mode && ! sdr_mode ;

//*****************************************************************************
always @(posedge clk )
	din_d1 <= din ;

//*************************************

assign dout =  direct_mode ?  din : din_d1 ;
//*****************************************************************************
endmodule
