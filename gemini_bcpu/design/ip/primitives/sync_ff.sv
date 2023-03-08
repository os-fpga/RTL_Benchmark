`ifndef SYNCFF
`define SYNCFF

module sync_ff #(parameter SYNC_STAGE = 2, parameter DWIDTH = 32) (
    input  logic              clk  ,
    input  logic              rst_n,
    input  logic [DWIDTH-1:0] din  ,
    output logic [DWIDTH-1:0] dout
);

logic   [DWIDTH*SYNC_STAGE -1:0] sync_ff ; 


always @(posedge clk or negedge rst_n)
    if      (!rst_n)    sync_ff <= {DWIDTH*SYNC_STAGE{1'b0}};
    else                sync_ff <= {sync_ff[DWIDTH*(SYNC_STAGE-1)-1:0], din} ;
  
assign dout = sync_ff[DWIDTH*SYNC_STAGE-1:DWIDTH*(SYNC_STAGE-1)];


endmodule
`endif