module pipeline_step (
  clk_i,
  reset_i,

  // data source side
  valid_i,
  data_i,
  ready_o,
  
  // data destination side
  ready_i,
  valid_o,
  data_o
);


parameter DATA_WIDTH = 8;


input  wire                   clk_i;
input  wire                   reset_i;

input  wire                   valid_i;
input  wire  [DATA_WIDTH-1:0] data_i;
output wire                   ready_o;

input  wire                   ready_i;
output logic                  valid_o;
output reg   [DATA_WIDTH-1:0] data_o;



reg valid_reg;



assign ready_o = ready_i;
assign valid_o = ready_i ? valid_reg : 1'b0;



always_ff @(posedge clk_i or posedge reset_i)
begin
  if (reset_i)
    begin
      valid_reg <= 1'b0;
      data_o <= '0;
    end
  else
    begin
      if (ready_i)
        begin
          valid_reg <= valid_i;
          data_o <= data_i;
        end
    end
end


endmodule


module pipeline (
  clk_i,
  reset_i,

  // data source side
  valid_i,
  data_i,
  ready_o,
  
  // data destination side
  ready_i,
  valid_o,
  data_o
);


parameter DATA_WIDTH = 8;
parameter LATENCY    = 1;


localparam COUNT = LATENCY + 1;


input  wire                   clk_i;
input  wire                   reset_i;

input  wire                   valid_i;
input  wire  [DATA_WIDTH-1:0] data_i;
output wire                   ready_o;

input  wire                   ready_i;
output logic                  valid_o;
output reg   [DATA_WIDTH-1:0] data_o;



logic                   pl_ready [COUNT];
logic                   pl_valid [COUNT];
logic [DATA_WIDTH-1:0]  pl_data  [COUNT];



assign ready_o = pl_ready[0];
assign pl_valid[0] = valid_i;
assign pl_data[0] = data_i;

assign pl_ready[COUNT-1] = ready_i;
assign valid_o = pl_valid[COUNT-1];
assign data_o = pl_data[COUNT-1];


genvar i;
generate
for ( i = 1; i < COUNT; i = i + 1 )
begin: pipeline_generate
  pipeline_step pl_step(
    .clk_i   (clk_i),
    .reset_i (reset_i),
    
    .valid_i (pl_valid[i-1]),
    .data_i  (pl_data[i-1]),
    .ready_o (pl_ready[i-1]),
    
    .ready_i (pl_ready[i]),
    .valid_o (pl_valid[i]),
    .data_o  (pl_data[i])
  );
  defparam
    pl_step.DATA_WIDTH = DATA_WIDTH;
end
endgenerate 


endmodule

