/*
 *	Если error срабатывает на последнем байте пакета, то он не будет отправлен, пока
 * не придет следующий пакет
 */

`define WRDATA_ADDR		0
`define RDDATA_ADDR		1
`define TXSTATUSL_ADDR	2
`define TXSTATUSH_ADDR	3
`define RXSTATUSL_ADDR	4
`define RXSTATUSH_ADDR	5

module usb_ft232h (
	//Avalon-MM Slave
	clk,
	reset,
	address,
	read,
	readdata,
	write,
	writedata,

	//FT232H
	usb_clk,
	usb_data,
	usb_rxf_n,
	usb_txe_n,
	usb_rd_n,
	usb_wr_n,
	usb_oe_n
);

parameter FIFO_DEPTH = 512;
parameter FIFO_WIDTHU = 9;


input logic clk;
input logic reset;
input logic [3:0]address;
input logic read;
output logic [7:0]readdata;
input logic write;
input logic [7:0]writedata;

input logic usb_clk;
inout logic [7:0]usb_data;
input logic usb_rxf_n;
input logic usb_txe_n;
output logic usb_rd_n;
output logic usb_wr_n;
output logic usb_oe_n;


logic [15:0]txstatus;
logic [15:0]rxstatus;

logic [3:0]addr;
reg reg_usb_rd_n;
reg reg_usb_oe_n;
reg reg_usb_wr_n;
reg reg_rxf_wrreq;
reg reg_txf_rdreq;
reg error;


logic [7:0]txf_wrdata;
logic txf_wrclk;
logic txf_wrreq;
logic txf_wrfull;
logic [FIFO_WIDTHU-1:0]txf_wrusedw;
logic txf_rdclk;
logic txf_rdreq;
logic [7:0]txf_rddata;
logic txf_rdempty;

logic [7:0]rxf_wrdata;
logic rxf_wrclk;
logic rxf_wrreq;
logic rxf_wrfull;
logic [FIFO_WIDTHU-1:0]rxf_rdusedw;
logic rxf_rdclk;
logic rxf_rdreq;
logic [7:0]rxf_rddata;
logic rxf_rdempty;
logic rxf_rdfull;



assign usb_data = usb_oe_n ? txf_rddata : {8{1'bZ}};
assign rxf_wrdata = usb_oe_n ? 8'b0 : usb_data;

assign usb_oe_n = (~usb_rxf_n & ~rxf_wrfull) ? reg_usb_oe_n : 1'b1;
assign usb_rd_n = (~usb_rxf_n & ~rxf_wrfull) ? reg_usb_rd_n : 1'b1;
assign usb_wr_n = (usb_oe_n & ~usb_txe_n) ? reg_usb_wr_n : 1'b1;
assign rxf_wrreq = (~usb_rxf_n & ~rxf_wrfull) ? reg_rxf_wrreq : 1'b0;
assign txf_rdreq = (reg_txf_rdreq & (~error));

assign txstatus[15] = ~txf_wrfull; //can write
assign txstatus[14:FIFO_WIDTHU+1] = 0;
assign txstatus[FIFO_WIDTHU] = txf_wrfull;
assign txstatus[FIFO_WIDTHU-1:0] = txf_wrusedw;

assign rxstatus[15] = ~rxf_rdempty; //can read
assign rxstatus[14:FIFO_WIDTHU+1] = 0;
assign rxstatus[FIFO_WIDTHU] = rxf_rdfull;
assign rxstatus[FIFO_WIDTHU-1:0] = rxf_rdusedw;

assign txf_wrclk = ~clk;
assign txf_wrreq = (~txf_wrfull & (address == `WRDATA_ADDR)) ? write : 0;
assign txf_wrdata = writedata;
assign txf_rdclk = usb_clk;

assign rxf_wrclk = usb_clk;
assign rxf_rdclk = ~clk;
assign rxf_rdreq = (address == `RDDATA_ADDR) ? read : 0;


dcfifo	txfifo (
				.aclr (reset),
				.data (txf_wrdata),
				.rdclk (txf_rdclk),
				.rdreq (txf_rdreq),
				.wrclk (txf_wrclk),
				.wrreq (txf_wrreq),
				.q (txf_rddata),
				.rdempty (txf_rdempty),
				.wrfull (txf_wrfull),
				.wrusedw (txf_wrusedw),
				.eccstatus (),
				.rdfull (),
				.rdusedw (),
				.wrempty ());
	defparam
		txfifo.intended_device_family = "Cyclone IV E",
		txfifo.lpm_numwords = FIFO_DEPTH,
		txfifo.lpm_showahead = "OFF",
		txfifo.lpm_type = "dcfifo",
		txfifo.lpm_width = 8,
		txfifo.lpm_widthu = FIFO_WIDTHU,
		txfifo.overflow_checking = "ON",
		txfifo.rdsync_delaypipe = 4,
		txfifo.read_aclr_synch = "OFF",
		txfifo.underflow_checking = "ON",
		txfifo.use_eab = "ON",
		txfifo.write_aclr_synch = "OFF",
		txfifo.wrsync_delaypipe = 4;
		
		
dcfifo	rxfifo (
				.aclr (reset),
				.data (rxf_wrdata),
				.rdclk (rxf_rdclk),
				.rdreq (rxf_rdreq),
				.wrclk (rxf_wrclk),
				.wrreq (rxf_wrreq),
				.q (rxf_rddata),
				.rdempty (rxf_rdempty),
				.wrfull (rxf_wrfull),
				.wrusedw (),
				.eccstatus (),
				.rdfull (rxf_rdfull),
				.rdusedw (rxf_rdusedw),
				.wrempty ());
	defparam
		rxfifo.intended_device_family = "Cyclone IV E",
		rxfifo.lpm_numwords = FIFO_DEPTH,
		rxfifo.lpm_showahead = "OFF",
		rxfifo.lpm_type = "dcfifo",
		rxfifo.lpm_width = 8,
		rxfifo.lpm_widthu = FIFO_WIDTHU,
		rxfifo.overflow_checking = "ON",
		rxfifo.rdsync_delaypipe = 4,
		rxfifo.read_aclr_synch = "OFF",
		rxfifo.underflow_checking = "ON",
		rxfifo.use_eab = "ON",
		rxfifo.write_aclr_synch = "OFF",
		rxfifo.wrsync_delaypipe = 4;

		

always_ff @(negedge clk)
begin
	if(read)
		addr <= address;
end
		
always_ff @(posedge clk)
begin
		case(addr)
		`RDDATA_ADDR: begin
			readdata <= rxf_rddata;
		end
		`TXSTATUSL_ADDR: begin
			readdata <= txstatus[7:0];
		end
		`TXSTATUSH_ADDR: begin
			readdata <= txstatus[15:8];
		end
		`RXSTATUSL_ADDR: begin
			readdata <= rxstatus[7:0];
		end
		`RXSTATUSH_ADDR: begin
			readdata <= rxstatus[15:8];
		end
		default: begin
			readdata <= 8'b0;
		end
		endcase
end
		

always_ff @(negedge txf_rdclk or posedge reset)
begin
	if(reset)
	begin
		reg_txf_rdreq <= 1'b0;
		error <= 1'b0;
	end
	else
	begin
		if(usb_oe_n & (~txf_rdempty | error) & ~usb_txe_n)
		begin
			reg_txf_rdreq <= 1'b1;
		end
		else
		begin
			reg_txf_rdreq <= 1'b0;
		end
		
		if(reg_txf_rdreq)
		begin
			if(usb_txe_n)
				error <= 1'b1;
			else
				error <= 1'b0;
		end
	end
end

always_ff @(posedge usb_clk or posedge reset)
begin
	if(reset)
	begin
		reg_usb_wr_n <= 1'b1;
	end
	else
	begin
		if(reg_txf_rdreq)
		begin
			reg_usb_wr_n <= 1'b0;
		end
		else
			reg_usb_wr_n <= 1'b1;
	end
end

always_ff @(posedge usb_clk or posedge reset)
begin
	if(reset)
	begin
		reg_usb_rd_n <= 1'b1;
		reg_usb_oe_n <= 1'b1;
	end
	else
	begin
		if((txf_rdempty | usb_txe_n | ~usb_oe_n) & ~rxf_wrfull & ~usb_rxf_n)
		begin
			reg_usb_oe_n <= 1'b0;
			if(~reg_usb_oe_n)
			begin
				reg_usb_rd_n <= 1'b0;
			end
			else
			begin
				reg_usb_rd_n <= 1'b1;
			end
		end
		else
		begin
			reg_usb_oe_n <= 1'b1;
			reg_usb_rd_n <= 1'b1;
		end
	end
end

always_ff @(negedge rxf_wrclk or posedge reset)
begin
	if(reset)
	begin
		reg_rxf_wrreq <= 1'b0;
	end
	else
	begin
		if(~usb_rd_n & ~usb_rxf_n)
			reg_rxf_wrreq <= 1'b1;
		else
			reg_rxf_wrreq <= 1'b0;
	end
end



endmodule
