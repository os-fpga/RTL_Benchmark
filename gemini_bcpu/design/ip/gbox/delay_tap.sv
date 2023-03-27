/********************************
 * Module: 	delay_tap
 * Date:	6/27/2022	
 * Compnay:	RapidSilicon
 * Created by Alex Hsiung
 *  Description : delay tap 
********************************/
module delay_tap
#(
   parameter PAR_TWID = 6
)
( 
   input                 in,            
   input [PAR_TWID-1 :0 ] sel,
//*************************************
   output  logic         out 
);
//*****************************************************************************
 logic [PAR_TWID-1:0] rst_d_NC;
//*************************************
assign out = ~in ;
//*****************************************************************************
endmodule

