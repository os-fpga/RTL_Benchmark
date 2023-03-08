`ifndef SYNCBUS
`define SYNCBUS

module sync_bus #(
  parameter DWIDTH = 10
) (
  input  logic              clk_in     ,
  input  logic              clk_out    ,
  input  logic              rst_n_in   ,
  input  logic              rst_n_out  ,
  input  logic              bus_vld_in ,
  input  logic [DWIDTH-1:0] bus_in     ,  
  output logic              bus_vld_out,
  output logic [DWIDTH-1:0] bus_out    
);

  logic              bus_vld_in_ext      ;
  logic [DWIDTH-1:0] bus_in_ff           ;
  logic [       2:0] bus_vld_out_clkin_ff;
  logic [       2:0] bus_vld_out_ff      ;

  // input clk domain
  always @(posedge clk_in or negedge rst_n_in)
  if (~rst_n_in)       bus_in_ff <= {DWIDTH{1'b0}};
  else if (bus_vld_in) bus_in_ff <= bus_in;

  always @(posedge clk_in or negedge rst_n_in)
    if (~rst_n_in)                     bus_vld_in_ext <= 1'b0;
    else if (bus_vld_out_clkin_ff[2])  bus_vld_in_ext <= 1'b0;
    else if (bus_vld_in)               bus_vld_in_ext <= 1'b1;

  always @(posedge clk_in or negedge rst_n_in)
   if (~rst_n_in)  bus_vld_out_clkin_ff <= 'h0;
   else            bus_vld_out_clkin_ff <= {bus_vld_out_clkin_ff[1:0], bus_vld_out_ff[2]};

  // output clk domain 
  always @(posedge clk_out or negedge rst_n_out)
      if (~rst_n_out) bus_vld_out_ff <= 'h0;
      else            bus_vld_out_ff <= {bus_vld_out_ff[1:0],bus_vld_in_ext};

  always @(posedge clk_out or negedge rst_n_out)
   if (~rst_n_out) bus_vld_out <= 1'b0;
   else            bus_vld_out <= ~bus_vld_out_ff[2] & bus_vld_out_ff[1];


  always @(posedge clk_out or negedge rst_n_out)
   if (~rst_n_out)                                  bus_out <= {DWIDTH{1'b0}};
   else if (~bus_vld_out_ff[2] & bus_vld_out_ff[1]) bus_out <= bus_in_ff;
   
endmodule
`endif