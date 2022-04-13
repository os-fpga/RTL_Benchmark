module IDELAYCTRL (output reg RDY,
                    input wire REFCLK, RST

  
   );

   
   always @ (posedge REFCLK or posedge RST)
     if(RST)
       RDY <= 1'b0;
     else
       RDY <= 1'b1; //one clock cycle on REFCLK
   
endmodule // IDELAYCTRL