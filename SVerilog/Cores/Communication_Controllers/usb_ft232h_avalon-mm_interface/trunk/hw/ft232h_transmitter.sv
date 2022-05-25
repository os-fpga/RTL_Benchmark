module ft232h_transmitter (
  reset_i,
  ready_o,
  transmit_i,
  sending_o,
  
  // FT232H
  usb_clk_i,
  usb_txe_n_i,
  usb_wr_n_o,
  
  usb_data_o,
  
  // FIFO
  fifo_rdclk_o,
  fifo_rdempty_i,
  fifo_rdreq_o,
  fifo_rddata_i
);


parameter LATENCY = 1;


input  logic        reset_i;
output logic        ready_o;
input  logic        transmit_i;
output logic        sending_o;

input  logic        usb_clk_i;
input  logic        usb_txe_n_i;
output logic        usb_wr_n_o;

output logic [7:0]  usb_data_o;

output logic        fifo_rdclk_o;
input  logic        fifo_rdempty_i;
output logic        fifo_rdreq_o;
input  logic [7:0]  fifo_rddata_i;



logic dest_ready;
logic fifo_datavalid;
reg   fifo_datavalid_reg;
logic pipeline_ready;
logic usb_datavalid;
logic usb_txe_n_reg;




assign fifo_rdclk_o = usb_clk_i;
assign dest_ready = transmit_i & ~usb_txe_n_i & ~usb_txe_n_reg;
assign ready_o = ~usb_txe_n_i & (~fifo_rdempty_i | fifo_datavalid_reg);
assign sending_o = fifo_rdreq_o | ~usb_wr_n_o;
assign usb_wr_n_o = ~(usb_datavalid & dest_ready);

assign fifo_datavalid = dest_ready ? fifo_datavalid_reg : 1'b0;



pipeline pipe_inst (
  .clk_i   (usb_clk_i),
  .reset_i (reset_i),
  // data source side
  .valid_i (fifo_datavalid),
  .data_i  (fifo_rddata_i),
  .ready_o (pipeline_ready),
  // data destination side
  .ready_i (dest_ready),
  .valid_o (usb_datavalid),
  .data_o  (usb_data_o)
  );
  defparam
    pipe_inst.LATENCY = LATENCY;

    


always_ff @(posedge usb_clk_i)
begin
  usb_txe_n_reg <= usb_txe_n_i;
end


always_ff @(negedge fifo_rdclk_o or posedge reset_i)
begin
  if (reset_i)
    begin
      fifo_rdreq_o <= 1'b0;
    end
  else
    begin
      if (transmit_i & ~fifo_rdempty_i & pipeline_ready)
        fifo_rdreq_o <= 1'b1;
      else
        fifo_rdreq_o <= 1'b0;
    end
end

always_ff @(posedge fifo_rdclk_o or posedge reset_i)
begin
  if (reset_i)
    begin
      fifo_datavalid_reg <= 1'b0;
    end
  else
    begin
      if (pipeline_ready)
        begin
          if (fifo_rdreq_o)
            fifo_datavalid_reg <= 1'b1;
          else
            fifo_datavalid_reg <= 1'b0;
        end
    end
end

endmodule
