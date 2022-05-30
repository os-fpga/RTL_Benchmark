/*!
 * \brief UsB FT232H core module
 * \version 1.8
 */


module usb_ft232h (
  clk_i,
  reset_i,
  
  //Avalon-MM Slave
  address_i,
  read_i,
  readdata_o,
  readdatavalid_o,
  write_i,
  writedata_i,
  waitrequest_o,

  //FT232H
  usb_clk_i,
  usb_data_io,
  usb_rxf_n_i,
  usb_txe_n_i,
  usb_rd_n_o,
  usb_wr_n_o,
  usb_oe_n_o
);


parameter TX_FIFO_NUMWORDS  = 512;
parameter TX_FIFO_WIDTHU    = 9;
parameter RX_FIFO_NUMWORDS  = 512;
parameter RX_FIFO_WIDTHU    = 9;
parameter FIFOS_DELAYPIPE   = 11;

parameter USB_READ_LATENCY  = 1;
parameter USB_WRITE_LATENCY = 1;

parameter AVALON_CMD_LATENCY = 1;
parameter AVALON_READ_LATENCY = 1;
parameter AVALON_WRITE_LATENCY = 1;



input  logic       clk_i;
input  logic       reset_i;
input  logic [2:0] address_i;
input  logic       read_i;
output logic [7:0] readdata_o;
output logic       readdatavalid_o;
input  logic       write_i;
input  logic [7:0] writedata_i;
output logic       waitrequest_o;

input  logic       usb_clk_i;
inout  wire  [7:0] usb_data_io;
input  logic       usb_rxf_n_i;
input  logic       usb_txe_n_i;
output logic       usb_rd_n_o;
output logic       usb_wr_n_o;
output logic       usb_oe_n_o;



logic [7:0]                txf_wrdata;
logic                      txf_wrclk;
logic                      txf_wrreq;
logic                      txf_wrfull;
logic [TX_FIFO_WIDTHU-1:0] txf_wrusedw;

logic                      txf_rdclk;
logic                      txf_rdreq;
logic [7:0]                txf_rddata;
logic                      txf_rdempty;

logic [7:0]                rxf_wrdata;
logic                      rxf_wrclk;
logic                      rxf_wrreq;
logic                      rxf_wrfull;

logic [RX_FIFO_WIDTHU-1:0] rxf_rdusedw;
logic                      rxf_rdclk;
logic                      rxf_rdreq;
logic [7:0]                rxf_rddata;
logic                      rxf_rdempty;
logic                      rxf_rdfull;




ft232h_fifos_interface ffi (
  .reset_i        (reset_i),
  // FT232H
  .usb_clk_i      (usb_clk_i),
  .usb_data_io    (usb_data_io),
  .usb_rxf_n_i    (usb_rxf_n_i),
  .usb_txe_n_i    (usb_txe_n_i),
  .usb_rd_n_o     (usb_rd_n_o),
  .usb_wr_n_o     (usb_wr_n_o),
  .usb_oe_n_o     (usb_oe_n_o),
  // RX FIFO
  .rxf_wrclk_o    (rxf_wrclk),
  .rxf_wrfull_i   (rxf_wrfull),
  .rxf_wrreq_o    (rxf_wrreq),
  .rxf_wrdata_o   (rxf_wrdata),
  // TX FIFO
  .txf_rdclk_o    (txf_rdclk),
  .txf_rdempty_i  (txf_rdempty),
  .txf_rdreq_o    (txf_rdreq),
  .txf_rddata_i   (txf_rddata)
  );
  defparam
    ffi.READ_LATENCY = USB_READ_LATENCY,
    ffi.WRITE_LATENCY = USB_WRITE_LATENCY;



//dcfifo  txfifo (
//        .aclr      ( reset_i ),
//        .data      ( txf_wrdata ),
//        .rdclk     ( txf_rdclk ),
//        .rdreq     ( txf_rdreq ),
//        .wrclk     ( txf_wrclk ),
//        .wrreq     ( txf_wrreq ),
//        .q         ( txf_rddata ),
//        .rdempty   ( txf_rdempty ),
//        .wrfull    ( txf_wrfull ),
//        .wrusedw   ( txf_wrusedw ),
//        .eccstatus (),
//        .rdfull    (),
//        .rdusedw   (),
//        .wrempty   ());
//  defparam
//    txfifo.intended_device_family = "Cyclone IV E",
//    txfifo.lpm_numwords = TX_FIFO_NUMWORDS,
//    txfifo.lpm_showahead = "OFF",
//    txfifo.lpm_type = "dcfifo",
//    txfifo.lpm_width = 8,
//    txfifo.lpm_widthu = TX_FIFO_WIDTHU,
//    txfifo.overflow_checking = "ON",
//    txfifo.rdsync_delaypipe = FIFOS_DELAYPIPE,
//    txfifo.read_aclr_synch = "ON",
//    txfifo.underflow_checking = "ON",
//    txfifo.use_eab = "ON",
//    txfifo.write_aclr_synch = "ON",
//    txfifo.wrsync_delaypipe = FIFOS_DELAYPIPE;
//
//
//dcfifo rxfifo (
//        .aclr      ( reset_i ),
//        .data      ( rxf_wrdata ),
//        .rdclk     ( rxf_rdclk ),
//        .rdreq     ( rxf_rdreq ),
//        .wrclk     ( rxf_wrclk ),
//        .wrreq     ( rxf_wrreq ),
//        .q         ( rxf_rddata ),
//        .rdempty   ( rxf_rdempty ),
//        .wrfull    ( rxf_wrfull ),
//        .wrusedw   (),
//        .eccstatus (),
//        .rdfull    ( rxf_rdfull ),
//        .rdusedw   ( rxf_rdusedw ),
//        .wrempty   ());
//  defparam
//    rxfifo.intended_device_family = "Cyclone IV E",
//    rxfifo.lpm_numwords = RX_FIFO_NUMWORDS,
//    rxfifo.lpm_showahead = "OFF",
//    rxfifo.lpm_type = "dcfifo",
//    rxfifo.lpm_width = 8,
//    rxfifo.lpm_widthu = RX_FIFO_WIDTHU,
//    rxfifo.overflow_checking = "ON",
//    rxfifo.rdsync_delaypipe = FIFOS_DELAYPIPE,
//    rxfifo.read_aclr_synch = "ON",
//    rxfifo.underflow_checking = "ON",
//    rxfifo.use_eab = "ON",
//    rxfifo.write_aclr_synch = "ON",
//    rxfifo.wrsync_delaypipe = FIFOS_DELAYPIPE;
//
//
//
usb_fifos_avalon_mm_interface ufai (
  .reset_i          (reset_i),
  .clk_i            (clk_i),
  // Avalon-MM
  .address_i        (address_i),
  .read_i           (read_i),
  .readdata_o       (readdata_o),
  .readdatavalid_o  (readdatavalid_o),
  .write_i          (write_i),
  .writedata_i      (writedata_i),
  .waitrequest_o    (waitrequest_o),
  // RX FIFO
  .rxf_rdclk_o      (rxf_rdclk),
  .rxf_rdempty_i    (rxf_rdempty),
  .rxf_rdfull_i     (rxf_rdfull),
  .rxf_rdreq_o      (rxf_rdreq),
  .rxf_rddata_i     (rxf_rddata),
  .rxf_rdusedw_i    (rxf_rdusedw),
  // TX FIFO
  .txf_wrclk_o      (txf_wrclk),
  .txf_wrfull_i     (txf_wrfull),
  .txf_wrreq_o      (txf_wrreq),
  .txf_wrdata_o     (txf_wrdata),
  .txf_wrusedw_i    (txf_wrusedw)
  );
  defparam
    ufai.TX_FIFO_WIDTHU = TX_FIFO_WIDTHU,
    ufai.RX_FIFO_WIDTHU = RX_FIFO_WIDTHU,
    ufai.CMD_LATENCY = AVALON_CMD_LATENCY,
    ufai.READ_LATENCY = AVALON_READ_LATENCY,
    ufai.WRITE_LATENCY = AVALON_WRITE_LATENCY;


endmodule
