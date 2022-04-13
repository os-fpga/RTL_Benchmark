////////////////////////////////////////////////////////////
//
//        Copyright (C) 2021 Eximius Design
//                All Rights Reserved
//
// This entire notice must be reproduced on all copies of this file
// and copies of this file may only be made by a person if such person is
// permitted to do so under the terms of a subsisting license agreement
// from Eximius Design
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//Functional Descript:
//
//
//
////////////////////////////////////////////////////////////

module spimreg_top 
#( 
parameter FIFO_WIDTH = 32, 
parameter FIFO_DEPTH = 64	
) 
(
input	logic		sclk_in,
input	logic		m_avmm_clk,
input	logic		rst_n,
input	logic		m_avmm_rst_n,
// spi read/write
input 	logic		ssn_off_pulse_sclk,
input 	logic		ssn_on_pulse_sclk,
input 	logic	[31:0]	dbg_bus0,
input 	logic	[31:0]	dbg_bus1,
input 	logic	[31:0]	miso_data, // spi_wdata, - read data from slave for rd_buf
input	logic		spi_write, // from m_cmd - read data from write buf and send to slave
input	logic		spi_read,  // from m_cmd - receive read data from slave and write to read buf
input	logic		cmd_is_read,  // from m_cmd - receive read data from slave and write to read buf
input	logic		cmd_is_write,  // from m_cmd - receive read data from slave and write to read buf
input	logic	[15:0] 	spi_rd_addr,  // from spim intf 
input	logic	[15:0] 	spi_wr_addr,  // from spim intf 
output	logic	[31:0] 	mosi_data, //spi_rdata, - write data to slave

// avmm read/write
input 	logic	[31:0]	avbreg_wdata, // write data to master
input	logic		avbreg_write,
input	logic		avbreg_read,
input	logic	[15:0] 	avbreg_addr,
output	logic	[31:0] 	avbreg_rdata, // read data from master
output	logic	 	avbreg_rdatavld,
output	logic	 	avbreg_waitreq,

// input to update m_cmd register 
input 	logic		stransvld_up,  	// Indication to update (set to 1'b0) s_transvld from SPIM Intf

// Outputs from m_cmd register
output	logic	[13:0] 	spim_brstlen,
output	logic		s_transvld_sclk_d1,
output	logic		s_transvld,
output	logic		spim_rdnwr,
output	logic	[1:0]	spim_sselect	// Selects spis0(when set to 1'b0) or spis1(when set to 1'b1). 

);

// Local 

localparam FIFO_DEPTH_WIDTH = $clog2(FIFO_DEPTH);
localparam FIFO_ADDR_WIDTH = FIFO_DEPTH_WIDTH + 1;

logic 	[(FIFO_WIDTH-1):0]	wbuf_fifo_rddata;
logic 	[(FIFO_WIDTH-1):0]	wbuf_fifo_wrdata;
logic 	[(FIFO_ADDR_WIDTH-1):0]	wbuf_rd_numfilled;
logic 	[(FIFO_ADDR_WIDTH-1):0]	wbuf_wr_numempty;

logic 	[(FIFO_WIDTH-1):0]	rbuf_fifo_rddata;
logic 	[(FIFO_WIDTH-1):0]	rbuf_fifo_wrdata;
logic 	[(FIFO_ADDR_WIDTH-1):0]	rbuf_rd_numfilled;
logic 	[(FIFO_ADDR_WIDTH-1):0]	rbuf_wr_numempty;

logic				wbuf_write_push;
logic				wbuf_read_pop;
logic				rbuf_write_push;
logic				rbuf_read_pop;


logic				wbuf_wr_overflow_pulse;
logic				wbuf_rd_underflow_pulse;
logic				rbuf_wr_overflow_pulse;
logic				rbuf_rd_underflow_pulse;

logic				wbuf_wr_overflow_sticky;
logic				wbuf_rd_underflow_sticky;
logic				rbuf_wr_overflow_sticky;
logic				rbuf_rd_underflow_sticky;

logic				wbuf_wr_soft_reset;
logic				wbuf_rd_soft_reset;
logic				rbuf_wr_soft_reset;
logic				rbuf_rd_soft_reset;

logic                           wbuf_wr_full;
logic                           wbuf_rd_empty;
logic                           rbuf_wr_full;
logic                           rbuf_rd_empty;

logic 	[31:0]	wdata_reg; 	// write data to CSRs
logic 	[31:0]	rdata_reg;	// read data from CSRs
logic 	[31:0]	avmm_rb_data;   // capture NIOS write data to wbuf location 0x0200 only
logic 	[15:0]	addr;
logic 	[15:0]	spi_addr;

logic 	[31:0] 	m_status_in;
logic 	[31:0] 	m_diag0_in;
logic 	[31:0] 	m_diag1_in;

logic 	[31:0] 	m_status;
logic 	[31:0] 	m_diag0;
logic 	[31:0] 	m_diag1;

logic 	[31:0] 	m_cmd;

logic	stransvld_up_aclk_pulse; // syc'd to aclk
logic	ssn_off_pulse_aclk;
logic	ssn_on_pulse_aclk;
logic 	write_reg;
logic	s_transvld_sclk;
logic 	rd_buf_access;
logic	wr_buf_access;
logic 	cmd_is_write_d1;
logic 	cmd_is_read_d1;
logic 	avmm_access;
logic 	spi_rbuf_access;
logic 	avmm_rbuf_access;
logic 	spi_wbuf_access;
logic 	avmm_wbuf_access;

logic   load_dbg_bus0;

logic wbuf_sfrst_ctrl;
logic rbuf_sfrst_ctrl;
logic wbuf_rd_sfrst_cmb;
logic rbuf_rd_sfrst_cmb;


pulse_sync trans_pulse_sync (
        .dest_pulse (stransvld_up_aclk_pulse),
        .clk_dest (m_avmm_clk),
        .rst_dest_n (m_avmm_rst_n),
        .clk_src (sclk_in),
        .rst_src_n (rst_n),
        .src_pulse (stransvld_up)
        );


pulse_sync ssn_off_pulse_sync (
        .dest_pulse (ssn_off_pulse_aclk),
        .clk_dest (m_avmm_clk),
        .rst_dest_n (m_avmm_rst_n),
        .clk_src (sclk_in),
        .rst_src_n (rst_n),
        .src_pulse (ssn_off_pulse_sclk)
        );


pulse_sync ssn_on_pulse_sync (
        .dest_pulse (ssn_on_pulse_aclk),
        .clk_dest (m_avmm_clk),
        .rst_dest_n (m_avmm_rst_n),
        .clk_src (sclk_in),
        .rst_src_n (rst_n),
        .src_pulse (ssn_on_pulse_sclk)
        );

assign spi_rbuf_access =  ((16'h1000 <= spi_wr_addr) & (spi_wr_addr <= 16'h17FF));
assign avmm_rbuf_access = ((16'h1000 <= avbreg_addr) & (avbreg_addr <= 16'h17FF));
assign spi_wbuf_access =  ((16'h0200 <= spi_rd_addr) & (spi_rd_addr <= 16'h09FF));
assign avmm_wbuf_access = ((16'h0200 <= avbreg_addr) & (avbreg_addr <= 16'h09FF));

assign rd_buf_access = (spi_rbuf_access | avmm_rbuf_access);
assign wr_buf_access = (spi_wbuf_access | avmm_wbuf_access);


// The registers can be read and written by SPI and AVMM. 
// s_trans_valid is used to determine if the access is from SPI or AVMM
// Writes from AVMM register is prevented when SPI is active
logic write_reg_quald;
logic waitreq_reg;
logic waitreq_buf;
logic waitreq_reg_aclk;
logic waitreq_reg_aclk_d1;
logic waitreq_reg_aclk_pulse;

assign waitreq_buf = (avmm_rbuf_access | avmm_wbuf_access) ? 1'b0 : 1'b1;
assign waitreq_reg = (spi_rbuf_access  | spi_wbuf_access)  ? 1'b1 : 1'b0;

levelsync sync_waitreq_req_pulse (
   	.dest_data (waitreq_reg_aclk),
   	.clk_dest (m_avmm_clk), 
   	.rst_dest_n (m_avmm_rst_n), 
   	.src_data (waitreq_reg)
   );

always_ff @ (posedge m_avmm_clk or negedge m_avmm_rst_n)
        if (~m_avmm_rst_n) 
          waitreq_reg_aclk_d1 <= 1'b0;	
	else 
          waitreq_reg_aclk_d1 <= waitreq_reg_aclk;
           
assign waitreq_reg_aclk_pulse = waitreq_reg_aclk & ~waitreq_reg_aclk_d1;

assign avbreg_waitreq = (avbreg_write | avbreg_read) ? 1'b0 : 1'b1; 


//SPI does not write to registers
assign write_reg = avbreg_write; // spi write is to rd buffer(sclk); 
							           //avb write (nios) is to wr buffer(avmm) 

assign write_reg_quald = (write_reg);

assign wdata_reg = avbreg_wdata; 
assign rbuf_fifo_wrdata = miso_data;

assign wbuf_fifo_wrdata = (avbreg_write & wr_buf_access) ? avbreg_wdata : 'b0;


// mosi data is always from wbuf fifo
assign mosi_data = spi_read & ~cmd_is_read ? wbuf_fifo_rddata : 32'b0;  



assign avbreg_rdata =  (avbreg_read & avmm_rbuf_access)  ? rbuf_fifo_rddata : 
                       (avbreg_read & ~avmm_rbuf_access) ? rdata_reg : 32'hdead_beef;  



// Mux register address from spi or avmm 
assign addr  = avbreg_addr; 





assign wbuf_write_push = (avbreg_write & avmm_wbuf_access);
assign wbuf_read_pop =   (~cmd_is_read & spi_read & spi_wbuf_access) ;
 
assign rbuf_write_push = (spi_write);
assign rbuf_read_pop =  (avbreg_read & avmm_rbuf_access);



assign m_status_in	= 'b0;

assign m_diag0_in	= dbg_bus0;
assign m_diag1_in	= dbg_bus1;

// assign m_cmd outputs
logic s_transvld_int;  
assign s_transvld	= s_transvld_sclk; 
assign s_transvld_int	= m_cmd[0]; 

//Adding the following logic to account for case when SPI clock is 
//very very slow in comparision to AVMM clock. 
localparam ST_ZERO         =2'b00;
localparam ST_WAIT_ONE     =2'b01;
localparam ST_ONE          =2'b10;
localparam ST_WAIT_ZERO    =2'b11;

logic [1:0] cdc_st;
logic start_transvld; 
logic cdc_req;
logic cdc_ack;
logic cdc_req_sclk;
logic cdc_ack_aclk;

always_ff @(posedge m_avmm_clk or negedge m_avmm_rst_n)
        if (~m_avmm_rst_n) begin
          start_transvld <= 1'b0;
          cdc_st         <= ST_ZERO;
          cdc_req        <= 1'b0;
        end 
        else begin
          case (cdc_st)
//10/13:            ST_ZERO:      if (s_transvld & ~cdc_ack_aclk) begin
           ST_ZERO:      if (s_transvld_int & ~cdc_ack_aclk) begin
                            cdc_st <= ST_WAIT_ONE;
                            cdc_req <= 1'b1;
                            start_transvld <= 1'b0;
                         end 
           
           ST_WAIT_ONE:  if (cdc_ack_aclk) begin
                            cdc_st <= ST_ONE;
                            cdc_req <= 1'b0;
                            start_transvld <= 1'b1;
                         end 
           
//10/13:            ST_ONE:       if (~s_transvld & ~cdc_ack_aclk) begin
           ST_ONE:       if (~s_transvld_int & ~cdc_ack_aclk) begin
                            cdc_st <= ST_WAIT_ZERO;
                            cdc_req <= 1'b1;
                            start_transvld <= 1'b1;
                         end 
           
           ST_WAIT_ZERO: if (cdc_ack_aclk == 1'b1) begin
                            cdc_st <= ST_ZERO;
                            cdc_req <= 1'b0;
                            start_transvld <= 1'b0;
                         end 
            endcase
        end
           

 levelsync sync_strans_req (
    	.dest_data (cdc_req_sclk),
    	.clk_dest (sclk_in), 
    	.rst_dest_n (rst_n), 
    	.src_data (cdc_req)
    );

 levelsync sync_strans_ack (
    	.dest_data (cdc_ack_aclk),
    	.clk_dest (m_avmm_clk), 
    	.rst_dest_n (m_avmm_rst_n), 
    	.src_data (cdc_req_sclk)
    );


//Using level sync to synchronize the register bit from avmm clk to spi clk
levelsync sync_transvld (
   	.dest_data (s_transvld_sclk),
   	.clk_dest (sclk_in), 
   	.rst_dest_n (rst_n), 
   	.src_data (start_transvld)
   );


always_ff @ (posedge sclk_in or negedge rst_n)
        if (~rst_n) begin
          spim_brstlen <= 14'b0;	
          spim_rdnwr   <= 1'b0;	
          spim_sselect <= 2'b00;	
         end
	else if (s_transvld_sclk) begin
          spim_brstlen <= m_cmd[15:2];	
          spim_rdnwr   <= m_cmd[1];	
          spim_sselect <= m_cmd[31:30];	
         end
           
always_ff @ (posedge sclk_in or negedge rst_n)
        if (~rst_n) 
          s_transvld_sclk_d1 <= 1'b0;	
	else 
          s_transvld_sclk_d1 <= s_transvld_sclk;
           
//Use s_transvld_sclk to generate the reset pulse for read buffer soft reset
logic start_transvld_d1;
logic start_transvld_pulse;
always_ff @ (posedge m_avmm_clk or negedge m_avmm_rst_n)
        if (~m_avmm_rst_n) 
          start_transvld_d1 <= 1'b0;	
	else 
          start_transvld_d1 <= start_transvld;
           
assign start_transvld_pulse = start_transvld & ~start_transvld_d1;

assign load_dbg_bus0 =  ~stransvld_up_aclk_pulse & ssn_off_pulse_aclk;

always_ff @ (posedge m_avmm_clk or negedge m_avmm_rst_n)
        if (~m_avmm_rst_n) 
          avmm_rb_data <= 32'b0;	
	else if (avbreg_addr == 16'h0200 & avbreg_write) 
          avmm_rb_data <= wbuf_fifo_wrdata;	
           
           
always_ff @ (posedge sclk_in or negedge rst_n)
        if (~rst_n) 
          cmd_is_write_d1 <= 1'b0;	
	else 
          cmd_is_write_d1 <= cmd_is_write;	

always_ff @ (posedge sclk_in or negedge rst_n)
        if (~rst_n) 
          cmd_is_read_d1 <= 1'b0;	
	else 
          cmd_is_read_d1 <= cmd_is_read;	

//FIFO SOFT RESET LOGIC 
//Required when command is write (transferring both write data and write cmd to slave)
//to reset write and read buffers
//Use wbuf/rbuf sfrst ctrl to disable this feature and depend on FW to reset

logic wbuf_sfrst_ctrl_sclk;
logic cmd_is_wr_d1_aclk;
logic cmd_is_rd_d1_aclk;
logic wbuf_rdsfrst_sclk;
logic rbuf_wrsfrst_sclk;


levelsync sync_wbuf_srst_ctrl (
   	.dest_data (wbuf_sfrst_ctrl_sclk),
   	.clk_dest (sclk_in), 
   	.rst_dest_n (rst_n), 
   	.src_data (wbuf_sfrst_ctrl)
   );

levelsync sync_cmdwr_d1_aclk (
   	.dest_data (cmd_is_wr_d1_aclk),
   	.clk_dest (m_avmm_clk), 
   	.rst_dest_n (m_avmm_rst_n), 
   	.src_data (cmd_is_write_d1)
   );

levelsync sync_cmdrd_d1_aclk (
   	.dest_data (cmd_is_rd_d1_aclk),
   	.clk_dest (m_avmm_clk), 
   	.rst_dest_n (m_avmm_rst_n), 
   	.src_data (cmd_is_read_d1)
   );

levelsync sync_wbuf_rdsrst (
   	.dest_data (wbuf_rdsfrst_sclk),
   	.clk_dest (sclk_in), 
   	.rst_dest_n (rst_n), 
   	.src_data (wbuf_rd_soft_reset)
   );

levelsync sync_rbuf_wrsrst (
   	.dest_data (rbuf_wrsfrst_sclk),
   	.clk_dest (sclk_in), 
   	.rst_dest_n (rst_n), 
   	.src_data (rbuf_wr_soft_reset)
   );


// Changing the auto reset of fifo to happen at the start of the tansaction instead of the end
// Write buffer is read by spi clock
// Read buffer is read by avmm clock
// ONLY READ BUFFER RD IS AUTO RESET AT THE BEGINING OF A READ CMD TO SLAVE 
// WRITE BUFFER RD IS NOT AUTO RESET AT THE BEGINING OF CMD
// TO PREVENT MESSING UP READ COMMAND TO SLAVE FOR POLLING PURPOSES

//Changing to reset read buffer at the beginning of each transaction
assign rbuf_rd_sfrst_cmb = rbuf_sfrst_ctrl ? rbuf_rd_soft_reset :  start_transvld_pulse;


 
//instantiation of asynchronous fifo 
// Wrbuf is written with avmm_clk and read with spi clk

asyncfifo 
 #( // Paramenters
	.FIFO_WIDTH_WID		(FIFO_WIDTH), 	// Data width of the FIFO
	.FIFO_DEPTH_WID		(FIFO_DEPTH)) 	// Depth of the FIFO
i_spim_wrbuf_fifo (
   // Outputs
	.rddata			(wbuf_fifo_rddata), 
	.rd_numfilled		(wbuf_rd_numfilled), // to CSR 
	.wr_numempty		(wbuf_wr_numempty),  // to CSR
	.wr_full		(wbuf_wr_full), 	// to CSR & to spim output
	.rd_empty		(wbuf_rd_empty),	// to CSR & to spim output
	.wr_overflow_pulse	(wbuf_wr_overflow_pulse),	// avmm clk 
	.rd_underflow_pulse	(wbuf_rd_underflow_pulse),	// spi clk
   
  // Inputs
	.clk_write		(m_avmm_clk), 
	.rst_write_n		(m_avmm_rst_n), 
	.clk_read		(sclk_in), 	
	.rst_read_n		(rst_n), 
	.wrdata			(wbuf_fifo_wrdata), 
	.write_push		(wbuf_write_push),
	.read_pop		(wbuf_read_pop), 
	.rd_soft_reset		(wbuf_rdsfrst_sclk),   // from CSR
	.wr_soft_reset		(1'b0)  
   );

always_ff @(posedge m_avmm_clk or negedge m_avmm_rst_n)
       if (~m_avmm_rst_n) 
          wbuf_wr_overflow_sticky <= 1'b0;
       else if (wbuf_wr_overflow_pulse)                   // wrt clk (avmm)
          wbuf_wr_overflow_sticky <= 1'b1;
       else if (wbuf_wr_soft_reset)                   // wrt clk (avmm)
          wbuf_wr_overflow_sticky <= 1'b0;

always_ff @(posedge sclk_in or negedge rst_n)
       if (~rst_n) 
          wbuf_rd_underflow_sticky <= 1'b0;
       else if (wbuf_rd_underflow_pulse)                  // read clk (spi)
          wbuf_rd_underflow_sticky <= 1'b1;
       else if (wbuf_rdsfrst_sclk)                  // read clk (spi)
          wbuf_rd_underflow_sticky <= 1'b0;

// Rdbuf is written with spi clk and read with avmm clk 
asyncfifo 
 #( // Paramenters
	.FIFO_WIDTH_WID		(FIFO_WIDTH), 	// Data width of the FIFO
	.FIFO_DEPTH_WID		(FIFO_DEPTH)) 	// Depth of the FIFO
i_spim_rdbuf_fifo (
   // Outputs
	.rddata			(rbuf_fifo_rddata), 
	.rd_numfilled		(rbuf_rd_numfilled), // to CSR 
	.wr_numempty		(rbuf_wr_numempty),  // to CSR
	.wr_full		(rbuf_wr_full), 	// to CSR & to spim output
	.rd_empty		(rbuf_rd_empty),	// to CSR & to spim output
	.wr_overflow_pulse	(rbuf_wr_overflow_pulse), // sclk 
	.rd_underflow_pulse	(rbuf_rd_underflow_pulse), // avmm clk
   
   // Inputs
	.clk_write		(sclk_in), 	
	.rst_write_n		(rst_n), 
	.clk_read		(m_avmm_clk),
	.rst_read_n		(m_avmm_rst_n), 
	.wrdata			(rbuf_fifo_wrdata), 
	.write_push		(rbuf_write_push),
	.read_pop		(rbuf_read_pop), 
	.rd_soft_reset		(rbuf_rd_sfrst_cmb),    // from logic  
	.wr_soft_reset		(1'b0)  
   );

always_ff @(posedge m_avmm_clk or negedge m_avmm_rst_n)
       if (~m_avmm_rst_n) 
          rbuf_rd_underflow_sticky <= 1'b0;
       else if (rbuf_rd_underflow_pulse)                // read clk (avmm)
          rbuf_rd_underflow_sticky <= 1'b1;
       else if (rbuf_rd_soft_reset)                // read clk (avmm)
          rbuf_rd_underflow_sticky <= 1'b0;

always_ff @(posedge sclk_in or negedge rst_n)
       if (~rst_n)
          rbuf_wr_overflow_sticky <= 1'b0;
       else if (rbuf_wr_overflow_pulse)                // write clk (spi)
          rbuf_wr_overflow_sticky <= 1'b1;
       else if (rbuf_wrsfrst_sclk)                // write clk (spi)
          rbuf_wr_overflow_sticky <= 1'b0;


//instanstiation of spim_reg 
spim_reg 
#( 
   .FIFO_ADDR_WIDTH (FIFO_ADDR_WIDTH)
) 
  i_spim_reg (

	.aclk (m_avmm_clk),
	.arst_n (m_avmm_rst_n),
	.wdata (wdata_reg),
	.write (write_reg_quald),
	.read (avbreg_read),
	.addr (addr),
	.rdata (rdata_reg),
	.avbreg_rdatavld (avbreg_rdatavld),
	.stransvld_up (stransvld_up_aclk_pulse),         
        .load_dbg_bus0 (load_dbg_bus0),
	.m_status_in (m_status_in),         
	.m_diag0_in (m_diag0_in),         
	.m_diag1_in (m_diag1_in),         
	.wbuf_wr_overflow_sticky (wbuf_wr_overflow_sticky),
	.wbuf_rd_underflow_sticky (wbuf_rd_underflow_sticky),
	.rbuf_wr_overflow_sticky (rbuf_wr_overflow_sticky),
	.rbuf_rd_underflow_sticky (rbuf_rd_underflow_sticky),
	.avmm_rb_data (avmm_rb_data),
        
	.wbuf_wr_soft_reset (wbuf_wr_soft_reset),
	.wbuf_rd_soft_reset (wbuf_rd_soft_reset),
	.rbuf_wr_soft_reset (rbuf_wr_soft_reset),
	.rbuf_rd_soft_reset (rbuf_rd_soft_reset),
	.wbuf_sfrst_ctrl (wbuf_sfrst_ctrl),
	.rbuf_sfrst_ctrl (rbuf_sfrst_ctrl),
        
	.m_cmd (m_cmd)
);

endmodule

