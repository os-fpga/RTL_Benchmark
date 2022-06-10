module el2_btb_tag_hash  (
                       input logic [5+9+9+9:5+1] pc,
                       output logic [9-1:0] hash
                       );

    assign hash = {(pc[5+9+9+9:5+9+9+1] ^
                   pc[5+9+9:5+9+1] ^
                   pc[5+9:5+1])};
endmodule

module el2_btb_tag_hash_fold  (
                       input logic [5+9+9:5+1] pc,
                       output logic [9-1:0] hash
                       );

    assign hash = {(
                   pc[5+9+9:5+9+1] ^
                   pc[5+9:5+1])};

endmodule

module el2_btb_addr_hash  (
                        input logic [5:8] pc,
                        output logic [5:4] hash
                        );


if(1) begin : fold2
   assign hash[5:4] = pc[5:8] ^
                                                pc[5:8];
end
   else begin
   assign hash[5:4] = pc[5:4] ^
                                                pc[5:5] ^
                                                pc[5:8];
end

endmodule

module el2_btb_ghr_hash  (
                       input logic [5:4] hashin,
                       input logic [5-1:0] ghr,
                       output logic [5:4] hash
                       );

   // The hash function is too complex to write in verilog for all cases.
   // The config script generates the logic string based on the bp config.
   if(1) begin : ghrhash_cfg1
     assign hash[5:4] = { ghr[5-1:5-1], hashin[5:4]^ghr[5-2:0]};
   end
   else begin : ghrhash_cfg2
     assign hash[5:4] = { hashin[5+1:2]^ghr[5-1:0]};
   end


endmodule
