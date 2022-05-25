module usb_fifos_avalon_mm_interface(
  reset_i,
  clk_i,
  
  // Avalon-MM
  address_i,
  read_i,
  readdata_o,
  readdatavalid_o,
  write_i,
  writedata_i,
  waitrequest_o,
  
  // RX FIFO
  rxf_rdclk_o,
  rxf_rdempty_i,
  rxf_rdfull_i,
  rxf_rdreq_o,
  rxf_rddata_i,
  rxf_rdusedw_i,
  
  // TX FIFO
  txf_wrclk_o,
  txf_wrfull_i,
  txf_wrreq_o,
  txf_wrdata_o,
  txf_wrusedw_i
);


parameter RX_FIFO_WIDTHU  = 9;
parameter TX_FIFO_WIDTHU  = 9;
parameter CMD_LATENCY     = 1;
parameter READ_LATENCY    = 1;
parameter WRITE_LATENCY   = 1;


localparam WRDATA_ADDR    = 3'd0;
localparam RDDATA_ADDR    = 3'd1;
localparam TXSTATUSL_ADDR = 3'd2;
localparam TXSTATUSH_ADDR = 3'd3;
localparam RXSTATUSL_ADDR = 3'd4;
localparam RXSTATUSH_ADDR = 3'd5;



input  logic                      reset_i;
input  logic                      clk_i;
  // Avalon-MM
input  logic [2:0]                address_i;
input  logic                      read_i;
output logic [7:0]                readdata_o;
output logic                      readdatavalid_o;
input  logic                      write_i;
input  logic [7:0]                writedata_i;
output logic                      waitrequest_o;
  // RX FIFO
output logic                      rxf_rdclk_o;
input  logic                      rxf_rdempty_i;
input  logic                      rxf_rdfull_i;
output logic                      rxf_rdreq_o;
input  logic [7:0]                rxf_rddata_i;
input  logic [RX_FIFO_WIDTHU-1:0] rxf_rdusedw_i;
  // TX FIFO
output logic                      txf_wrclk_o;
input  logic                      txf_wrfull_i;
output logic                      txf_wrreq_o;
output logic [7:0]                txf_wrdata_o;
input  logic [TX_FIFO_WIDTHU-1:0] txf_wrusedw_i;




logic [15:0]  txstatus;
logic [15:0]  rxstatus;


logic         read_ready;
logic         read_waitrequest;

logic         read_pipe;
logic [2:0]   address_pipe;

logic [7:0]   read_data;
logic         read_datavalid;

logic         rxf_rdreq_reg;

logic [5:0]   address_decode;
logic [5:0]   address_decode_pipe;

logic         ad_en;
logic         ad_clken;
logic         ad_en_reg;
logic [3:0]   ad_status;

logic         ad_rdata;
logic         ad_rxsl;
logic         ad_rxsh;
logic         ad_txsl;
logic         ad_txsh;




assign rxf_rdclk_o = clk_i;


// READ
assign read_ready = ~rxf_rdempty_i;
assign read_waitrequest = ad_rdata & ~read_ready;

assign ad_en = read_pipe | read_waitrequest;
assign ad_clken = (ad_en | ad_en_reg) & ~read_waitrequest;

assign ad_rdata  = address_decode_pipe[1];
assign ad_rxsl  = ad_status[2];
assign ad_rxsh  = ad_status[3];
assign ad_txsl  = ad_status[0];
assign ad_txsh  = ad_status[1];




pipeline cmd_pipe_inst (
  .clk_i   (clk_i),
  .reset_i (reset_i),
  // data source side
  .valid_i (1'b1),
  .data_i  (read_i),
  .ready_o (),
  // data destination side
  .ready_i (~read_waitrequest),
  .valid_o (),
  .data_o  (read_pipe)
  );
  defparam
    cmd_pipe_inst.LATENCY = CMD_LATENCY,
    cmd_pipe_inst.DATA_WIDTH = 1;


pipeline addr_pipe_inst (
  .clk_i   (clk_i),
  .reset_i (reset_i),
  // data source side
  .valid_i (1'b1),
  .data_i  (address_i),
  .ready_o (),
  // data destination side
  .ready_i (~read_waitrequest),
  .valid_o (),
  .data_o  (address_pipe)
  );
  defparam
    addr_pipe_inst.LATENCY = CMD_LATENCY,
    addr_pipe_inst.DATA_WIDTH = 3;


pipeline read_pipe_inst (
  .clk_i   (clk_i),
  .reset_i (reset_i),
  // data source side
  .valid_i (read_datavalid),
  .data_i  (read_data),
  .ready_o (),
  // data destination side
  .ready_i (1'b1),
  .valid_o (readdatavalid_o),
  .data_o  (readdata_o)
  );
  defparam
    read_pipe_inst.LATENCY = READ_LATENCY;
    
    
lpm_decode LPM_DECODE_component (
  .clock (clk_i),
  .data (address_pipe),
  .eq (address_decode),
  .aclr (),
  .clken (ad_clken),
  .enable (ad_en)
  );
  defparam
    LPM_DECODE_component.lpm_decodes = 6,
    LPM_DECODE_component.lpm_pipeline = 1,
    LPM_DECODE_component.lpm_type = "LPM_DECODE",
    LPM_DECODE_component.lpm_width = 3;




always_ff @(posedge clk_i)
begin
  txstatus[15]                  <= ~txf_wrfull_i; //can write
  txstatus[14:TX_FIFO_WIDTHU+1] <= 0;
  txstatus[TX_FIFO_WIDTHU]      <= txf_wrfull_i;
  txstatus[TX_FIFO_WIDTHU-1:0]  <= ( txf_wrfull_i ? {TX_FIFO_WIDTHU{1'b0}} : txf_wrusedw_i );

  rxstatus[15]                  <= ~rxf_rdempty_i; //can read
  rxstatus[14:RX_FIFO_WIDTHU+1] <= 0;
  rxstatus[RX_FIFO_WIDTHU]      <= rxf_rdfull_i;
  rxstatus[RX_FIFO_WIDTHU-1:0]  <= ( rxf_rdempty_i ? {RX_FIFO_WIDTHU{1'b0}} : rxf_rdusedw_i );
end



/* READ */
always_ff @(posedge clk_i)
begin
  if (~read_waitrequest)
    address_decode_pipe <= address_decode;
  
  ad_en_reg <= ad_en;
  
  ad_status <= address_decode_pipe[5:2];
end


always_ff @(posedge clk_i)
begin
  if (rxf_rdreq_reg)
    begin
      read_data <= rxf_rddata_i;
      read_datavalid <= 1;
    end
  else if (ad_rxsl)
    begin
      read_data <= rxstatus[7:0];
      read_datavalid <= 1;
    end
  else if (ad_rxsh)
    begin
      read_data <= rxstatus[15:8];
      read_datavalid <= 1;
    end
  else if (ad_txsl)
    begin
      read_data <= txstatus[7:0];
      read_datavalid <= 1;
    end
  else if (ad_txsh)
    begin
      read_data <= txstatus[15:8];
      read_datavalid <= 1;
    end
  else
    begin
      read_data <= 0;
      read_datavalid <= 0;
    end
end


always_ff @(negedge rxf_rdclk_o or posedge reset_i)
begin
  if (reset_i)
    begin
      rxf_rdreq_o <= 1'b0;
    end
  else
    begin
      if (ad_rdata & ~rxf_rdempty_i)
        rxf_rdreq_o <= 1'b1;
      else
        rxf_rdreq_o <= 1'b0;
    end
end


always_ff @(posedge clk_i)
begin
  rxf_rdreq_reg <= rxf_rdreq_o;
end
/*==========================================*/




/*          ----=== WRITE ===----           */

logic         write_reg;
logic         write_data_request;
logic         write_ready;
logic [7:0]   write_data;
logic         write_datavalid;
logic         write_waitrequest;

logic         txf_wrfull_reg;

logic [2:0]   write_data_addr = WRDATA_ADDR;



assign txf_wrclk_o = ~clk_i;

assign write_ready = ~txf_wrfull_reg;
assign write_datavalid = write_reg & write_data_request & write_ready;
assign write_waitrequest = ~write_ready;



lpm_compare LPM_COMPARE_component (
  .clken (1'b1),
  .clock (clk_i),
  .dataa (address_i),
  .datab (write_data_addr),
  .aeb (write_data_request),
  .aclr (reset_i),
  .agb (),
  .ageb (),
  .alb (),
  .aleb (),
  .aneb ());
  defparam
    LPM_COMPARE_component.lpm_hint = "ONE_INPUT_IS_CONSTANT=YES",
    LPM_COMPARE_component.lpm_pipeline = 1,
    LPM_COMPARE_component.lpm_representation = "UNSIGNED",
    LPM_COMPARE_component.lpm_type = "LPM_COMPARE",
    LPM_COMPARE_component.lpm_width = 3;


pipeline write_pipe_inst (
  .clk_i   (clk_i),
  .reset_i (reset_i),
  // data source side
  .valid_i (write_datavalid),
  .data_i  (write_data),
  .ready_o (),
  // data destination side
  .ready_i (write_ready),
  .valid_o (txf_wrreq_o),
  .data_o  (txf_wrdata_o)
  );
  defparam
    write_pipe_inst.LATENCY = WRITE_LATENCY;




always_ff @(posedge clk_i)
begin
  txf_wrfull_reg <= txf_wrfull_i;
end


always_ff @(posedge clk_i or posedge reset_i)
begin
  if (reset_i)
    begin
      write_data <= '0;
      write_reg <= 1'b0;
    end
  else
    begin
      if (write_i & write_ready)
        write_data <= writedata_i;
        
      if (~write_waitrequest)
        write_reg <= write_i;
    end
end
/*==========================================*/



assign waitrequest_o = (read_waitrequest & read_i) | (write_i & write_waitrequest);


endmodule
