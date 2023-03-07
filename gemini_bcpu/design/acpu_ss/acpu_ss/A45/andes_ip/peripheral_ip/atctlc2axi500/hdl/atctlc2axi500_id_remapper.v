// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module atctlc2axi500_id_remapper (
    	  clk,
    	  resetn,
    	  us_grant,
    	  us_id,
    	  ds_grant,
    	  ds_id,
    	  ds2us_id,
    	  next_id,
    	  busy
);

parameter US_IDW = 4;
parameter DS_IDW = 4;
localparam DS_IDLEN = 1 << DS_IDW;

input                     clk;
input                     resetn;
input                     us_grant;
input        [US_IDW-1:0] us_id;
input                     ds_grant;
input        [DS_IDW-1:0] ds_id;
output       [US_IDW-1:0] ds2us_id;
output       [DS_IDW-1:0] next_id;
output                    busy;

reg          [DS_IDW-1:0] s0;
wire         [DS_IDW-1:0] s1;

reg        [DS_IDLEN-1:0] s2;
wire       [DS_IDLEN-1:0] s3;
wire       [DS_IDLEN-1:0] s4;
wire       [DS_IDLEN-1:0] s5;

wire       [DS_IDLEN-1:0] s6;
wire       [DS_IDLEN-1:0] s7;

reg [DS_IDLEN*US_IDW-1:0] s8;

atctlc2axi500_bin2onehot #(.N(DS_IDLEN)) u_next_id_onehot(.out(s6), .in(next_id));
atctlc2axi500_bin2onehot #(.N(DS_IDLEN)) u_ds_id_onehot  (.out(s7  ), .in(ds_id  ));

assign next_id = s0;
assign busy = s2[next_id];
assign ds2us_id = s8[ds_id*US_IDW+:US_IDW];

assign s1 = s0 + {{(DS_IDW-1){1'b0}}, 1'b1};
always @(posedge clk or negedge resetn) begin
    if(!resetn)begin
        s0 <= {DS_IDW{1'b0}};
    end
    else if(us_grant)begin
        s0 <= s1;
    end
end

assign s3  = ~s5 & (s2 | s4);
assign s4 = {DS_IDLEN{us_grant}} & s6;
assign s5 = {DS_IDLEN{ds_grant}} & s7;
generate
genvar i;
for (i=0; i<DS_IDLEN; i=i+1) begin : gen_ent
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            s2[i] <= 1'b0;
        end
        else begin
            s2[i] <= s3[i];
        end
    end
    always @(posedge clk) begin
        if (s4[i]) begin
            s8[i*US_IDW+:US_IDW] <= us_id;
        end
    end
end
endgenerate

endmodule

