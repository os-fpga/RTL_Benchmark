module eh2_btb_tag_hash
// #(
//`include "eh2_param.vh"
 //..)
  (
                       input logic [5+9+9+9:5+1] pc,
                       output logic [9-1:0] hash
                       );

    assign hash = {(pc[5+9+9+9:5+9+9+1] ^
                   pc[5+9+9:5+9+1] ^
                   pc[5+9:5+1])};
endmodule

module eh2_btb_tag_hash_fold 
// #(
//`include "eh2_param.vh"
 //)
 (
                       input logic [5+9+9:5+1] pc,
                       output logic [9-1:0] hash
                       );

    assign hash = {(
                   pc[5+9+9:5+9+1] ^
                   pc[5+9:5+1])};

endmodule

module eh2_btb_addr_hash 
// #(
//`include "eh2_param.vh"
 //)
 (
                        input logic [9:4] pc,
                        output logic [5:4] hash
                        );
localparam BTB_USE_SRAM=1;

if(1) begin : fold2
   assign hash[5:4] = pc[5:4] ^
                                                pc[9:8];
end
   else begin

      // overload bit pc[3] onto last bit of hash for sram case
      
      if(BTB_USE_SRAM) begin
        assign hash[5:4+1] = pc[5:4+1] ^
                                                       pc[7:6] ^
                                                       pc[9:8];
         assign hash[3] = pc[3];
      end

      else

        assign hash[5:4] = pc[5:4] ^
                                                     pc[7:6] ^
                                                     pc[9:8];
end

endmodule


module eh2_btb_ghr_hash 
// #(
//`include "eh2_param.vh"
 //)
 (
                       input logic [5:4] hashin,
                       input logic [5-1:0] ghr,
                       output logic [7:4] hash
                       );

   if(1) begin : ghrhash_cfg1
     assign hash[7:4] = { ghr[5-1:5-2], hashin[5:4]^ghr[5-3:0]};
//     assign hash[7:4] = {ghr[8:7], hashin[5:3]^ghr[6:0]};
   end
   else begin : ghrhash_cfg2
// this makes more sense but is lower perf on dhrystone
//     assign hash[7:4] = { hashin[5+2:3]^ghr[5-1:0]};
     assign hash[7:4] = { hashin[5+2:5]^ghr[5-1:2], ghr[1:0]};
   end


endmodule

