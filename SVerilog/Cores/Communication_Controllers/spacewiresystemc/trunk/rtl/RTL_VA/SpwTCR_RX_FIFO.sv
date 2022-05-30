module SpwTCR_RX_FIFO(
clk,
RESETn,
data_req, 
we,
data_i, 
data_o,
full,
almost_full, 
empty
);

parameter DATA_SIZE = 9;
parameter ADDR_SIZE = 7;

parameter FIFO_SIZE = 2**ADDR_SIZE;

input 								clk; 
input 								RESETn;
input 								data_req; 
input 								we; 
input			 [DATA_SIZE-1:0] 	data_i; 
output logic [DATA_SIZE-1:0] 	data_o;
output logic 						full;  
output logic 						almost_full;
output logic 						empty;

logic [ADDR_SIZE:0]				wrusedw;

logic re_ff1;
logic re_ff2;
logic rdreq_w;
always @(posedge clk, negedge RESETn)
begin
if(!RESETn)
	begin
	re_ff1 <= 1'b0;
	re_ff2 <= 1'b0;
	end
else
	begin
	re_ff1 <= data_req;
	re_ff2 <= re_ff1;
	end
end 
assign rdreq_w = !re_ff2 & re_ff1;

assign almost_full = (wrusedw > FIFO_SIZE-8) ? 1'b1 : 1'b0;


FIFO	#(.DATA_SIZE(DATA_SIZE), .ADDR_SIZE(ADDR_SIZE)) FIFO_inst (
	.data (data_i ),
	.rdclk (clk ),
	.rd_rst_n(RESETn),
	.rdreq (rdreq_w ),
	.wrclk (clk ),
	.wr_rst_n(RESETn),
	.wrreq (we ),
	.q (data_o ),
	.rdempty (empty ),
	.rdusedw (),
	.wrfull (full),
	.wrusedw (wrusedw)
	);


endmodule




module FIFO (
	data,
	rdclk,
	rd_rst_n,
	rdreq,
	wrclk,
	wr_rst_n,
	wrreq,
	q,
	rdempty,
	rdusedw,
	wrfull,
	wrusedw);

parameter DATA_SIZE = 9;
parameter ADDR_SIZE = 7;

input	 			[DATA_SIZE-1:0]  	data;
input	  									rdclk;
input										rd_rst_n;
input	  									rdreq;
input	  									wrclk;
input										wr_rst_n;
input	  									wrreq;
output logic 	[DATA_SIZE-1:0]  	q;
output logic 	  						rdempty;
output logic 	[ADDR_SIZE:0]  	rdusedw;
output logic 	  						wrfull;
output logic 	[ADDR_SIZE:0]  	wrusedw;

logic [ADDR_SIZE:0] waddr, raddr;
logic [DATA_SIZE-1:0] MEM [(2**ADDR_SIZE)-1:0];

assign wrusedw = waddr-raddr;
assign rdusedw = raddr;

always @(posedge wrclk) 
begin
	if (!wr_rst_n) begin
		waddr <={(ADDR_SIZE+1){1'b0}};
		end
	else begin
		if(wrreq && !wrfull)
			waddr <= waddr + 1'b1;
		else			waddr <= waddr;
	end
end

always @(posedge wrclk) 
begin
		if(wrreq && !wrfull)
			MEM[waddr[ADDR_SIZE-1:0]] <= data;
		else
			MEM[waddr[ADDR_SIZE-1:0]] <= MEM[waddr[ADDR_SIZE-1:0]];
end




always @(posedge rdclk) begin
if (!rd_rst_n) begin
	raddr <= {(ADDR_SIZE+1){1'b0}};
	end
else begin
	if(rdreq && !rdempty)
		raddr <= raddr + 1'b1;
	else
		raddr <= raddr;
	end
end

always @(posedge rdclk) begin
if (!rd_rst_n) begin
	q <= {(DATA_SIZE){1'b0}};
	end
else begin
	if(rdreq && !rdempty)
		q <= MEM[raddr[ADDR_SIZE-1:0]] ;
	else
		q <= q;
	end
end

assign wrfull = (((waddr[ADDR_SIZE-1:0] == raddr[ADDR_SIZE-1:0]) & (waddr[ADDR_SIZE] != raddr[ADDR_SIZE])));
assign rdempty = (waddr == raddr);


endmodule
