`ifndef RSTSYNC
`define RSTSYNC
module rstsync
(
    input  logic clk       ,
    input  logic rst_soft  ,
    input  logic rst_async ,
    
    output logic rst_sync_out
);

logic [1:0] sync_ff;

always @ (posedge clk or negedge rst_async) begin
    if (!rst_async) sync_ff <= 2'b00;
    else            sync_ff <= {sync_ff[0], rst_soft};
  end

assign rst_sync_out = sync_ff[1];

endmodule
`endif