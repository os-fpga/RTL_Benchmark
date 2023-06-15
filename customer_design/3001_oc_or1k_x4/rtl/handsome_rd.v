// ============================================================================
//  
//                           Copyright (C) 2006 
//                            by M2000, France 
//  
//                           All Rights Reserved 
//  
//  
//  This file contains confidential information, trade secrets, and proprietary
//  products of M2000 or its licensors. No part of this file may be copied,
//  reproduced, translated, transferred, disclosed or otherwise provided to
//  third parties, without the prior written consent of M2000. 
//  
//  M2000 reserves the right to make changes in specifications and other
//  information contained on the file without prior notice, and the user should,
//  in all cases, consult M2000 to determine whether any changes have been made. 
//  
// ============================================================================
// 
//  Title       : 
//
//  Description :  
//                
//
//  Version     :
//
//  Date        : December , 2007
//  
// ============================================================================

 
 

module handsome_rd (clk, load, par_in, sr_out);

parameter length=5;


input clk;
input load;
input [length-1:0] par_in;
output sr_out;
reg [length-1:0] sr;



always @ (posedge clk)
begin
		sr[length-1:1] <= (load) ? par_in[length-2:0]: sr[length-2:0];
		sr[0] <= (load) ? par_in[length-1] : 1'b0;
end


assign sr_out = sr[length-1];


endmodule




