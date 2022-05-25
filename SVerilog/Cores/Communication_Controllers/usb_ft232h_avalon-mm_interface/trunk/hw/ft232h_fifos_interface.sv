module ft232h_fifos_interface (
  reset_i,
  
  // FT232H
  usb_clk_i,
  usb_data_io,
  usb_rxf_n_i,
  usb_txe_n_i,
  usb_rd_n_o,
  usb_wr_n_o,
  usb_oe_n_o,
  
  // RX FIFO
  rxf_wrclk_o,
  rxf_wrfull_i,
  rxf_wrreq_o,
  rxf_wrdata_o,
  
  // TX FIFO
  txf_rdclk_o,
  txf_rdempty_i,
  txf_rdreq_o,
  txf_rddata_i
);


parameter READ_LATENCY = 1;
parameter WRITE_LATENCY = 1;


input  logic        reset_i;

input  logic        usb_clk_i;
inout  logic [7:0]  usb_data_io;
input  logic        usb_rxf_n_i;
input  logic        usb_txe_n_i;
output logic        usb_rd_n_o;
output logic        usb_wr_n_o;
output logic        usb_oe_n_o;

output logic        rxf_wrclk_o;
input  logic        rxf_wrfull_i;
output logic        rxf_wrreq_o;
output logic [7:0]  rxf_wrdata_o;

output logic        txf_rdclk_o;
input  logic        txf_rdempty_i;
output logic        txf_rdreq_o;
input  logic [7:0]  txf_rddata_i;



logic [7:0] usb_data_in;
logic [7:0] usb_data_out;

logic       rx_ready;
logic       receiving;
logic       receive;

logic       tx_ready;
logic       sending;
logic       send;



assign usb_data_io = usb_oe_n_o ? usb_data_out : {8{1'bZ}};
assign usb_data_in = usb_data_io;



ft232h_receiver rx_inst (
  .reset_i        (reset_i),
  .ready_o        (rx_ready),
  .receive_i      (receive),
  .receiving_o    (receiving),
  // USB
  .usb_clk_i      (usb_clk_i),
  .usb_rxf_n_i    (usb_rxf_n_i),
  .usb_rd_n_o     (usb_rd_n_o),
  .usb_oe_n_o     (usb_oe_n_o),
  .usb_data_i     (usb_data_in),
  // FIFO
  .fifo_wrfull_i  (rxf_wrfull_i),
  .fifo_wrclk_o   (rxf_wrclk_o),
  .fifo_wrreq_o   (rxf_wrreq_o),
  .fifo_data_o    (rxf_wrdata_o)
  );
  defparam
    rx_inst.LATENCY = READ_LATENCY;



ft232h_transmitter tx_inst (
  .reset_i        (reset_i),
  .ready_o        (tx_ready),
  .transmit_i     (send),
  .sending_o      (sending),
  // FT232H
  .usb_clk_i      (usb_clk_i),
  .usb_txe_n_i    (usb_txe_n_i),
  .usb_wr_n_o     (usb_wr_n_o),
  .usb_data_o     (usb_data_out),
  // FIFO
  .fifo_rdclk_o   (txf_rdclk_o),
  .fifo_rdempty_i (txf_rdempty_i),
  .fifo_rdreq_o   (txf_rdreq_o),
  .fifo_rddata_i  (txf_rddata_i)
  );
  defparam
    tx_inst.LATENCY = WRITE_LATENCY;

    
    
always_ff @(posedge usb_clk_i or posedge reset_i)
begin
  if (reset_i)
    begin
      send <= 1'b0;
      receive <= 1'b0;
    end
  else
    begin
      if (tx_ready & ~receiving & ~(receive & rx_ready)) 
        begin
          send <= 1'b1;
          receive <= 1'b0;
        end
      else if (rx_ready & ~sending)
        begin
          send <= 1'b0;
          receive <= 1'b1;
        end
    end
end


endmodule
