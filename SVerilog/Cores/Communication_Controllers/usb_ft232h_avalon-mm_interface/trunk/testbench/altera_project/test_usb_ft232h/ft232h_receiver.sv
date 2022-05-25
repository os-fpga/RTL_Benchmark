module ft232h_receiver (
  reset_i,
  ready_o,
  receive_i,
  receiving_o,
  
  // USB
  usb_clk_i,
  usb_rxf_n_i,
  usb_rd_n_o,
  usb_oe_n_o,
  
  usb_data_i,
  
  // FIFO
  fifo_wrfull_i,
  fifo_wrclk_o,
  fifo_wrreq_o,
  fifo_data_o
);


parameter LATENCY = 1;


input  logic        reset_i;
output logic        ready_o;
input  logic        receive_i;
output logic        receiving_o;
  
input  logic        usb_clk_i;
input  logic        usb_rxf_n_i;
output logic        usb_rd_n_o;
output logic        usb_oe_n_o;

input  logic [7:0]  usb_data_i;
  
input  logic        fifo_wrfull_i;
output logic        fifo_wrclk_o;
output logic        fifo_wrreq_o;
output logic [7:0]  fifo_data_o;



logic fifo_wrfull_reg;
logic usb_datavalid;
logic pipeline_ready;



assign fifo_wrclk_o = ~usb_clk_i;
assign ready_o = pipeline_ready & ~usb_rxf_n_i;
assign receiving_o = ~usb_oe_n_o | ~usb_rd_n_o;

assign usb_datavalid = ~usb_rd_n_o & ~usb_rxf_n_i;



pipeline pipe_inst (
  .clk_i   (usb_clk_i),
  .reset_i (reset_i),
  // data source side
  .valid_i (usb_datavalid),
  .data_i  (usb_data_i),
  .ready_o (pipeline_ready),
  // data destination side
  .ready_i (~fifo_wrfull_reg),
  .valid_o (fifo_wrreq_o),
  .data_o  (fifo_data_o)
  );
  defparam
    pipe_inst.LATENCY = LATENCY;
    
    
    
always_ff @(posedge usb_clk_i)
begin
  fifo_wrfull_reg <= fifo_wrfull_i;
end


always_ff @(posedge usb_clk_i or posedge reset_i)
begin
  if (reset_i)
    begin
    end
  else
    begin
      if (receive_i & ready_o & ~fifo_wrfull_i)
        begin
          usb_oe_n_o <= 1'b0;
          if (~usb_oe_n_o)
            usb_rd_n_o <= 1'b0;
        end
      else
        begin
          usb_oe_n_o <= 1'b1;
          usb_rd_n_o <= 1'b1;
        end
    end
end


endmodule
