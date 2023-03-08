/********************************
 * Module: 	reset_sync
 * Date:	6/27/2022	
 * Compnay:	RapidSilicon
 * Created by Alex Hsiung
 *  Description : pararmeterized reset sync stages
********************************/
module reset_sync
#(
   parameter PAR_STAGE = 2
)
( 
   input             clk,            
   input             rst_n,
//*************************************
   output  logic     rst_sync 
);
//*****************************************************************************
 logic [PAR_STAGE-1:0] rst_d;
//*************************************
assign rst_sync = rst_d[PAR_STAGE-1];
//*****************************************************************************
always_ff @(posedge clk, negedge rst_n)
  if (!rst_n) begin
     for(int ii=0; ii < PAR_STAGE; ii++)
        rst_d[ii] <= 1'b1;
  end
  else begin
     rst_d[0]  <= 1'b0 ;
      for(int ii=1; ii < PAR_STAGE; ii++)
          rst_d[ii] <= rst_d[ii-1];
  end 
//*****************************************************************************
endmodule

