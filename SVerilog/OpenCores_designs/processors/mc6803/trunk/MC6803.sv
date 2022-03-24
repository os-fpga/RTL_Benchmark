//MC6803 processor
module MC6803(
		input logic Clk,
		RST,
		hold,
		halt,
		//irq,
		nmi,
		input logic[7:0] PORT_A_IN,
		input logic[4:0] PORT_B_IN,
		input logic[7:0] DATA_IN,
		output logic[7:0] PORT_A_OUT,
		PORT_B_OUT,
		output logic[15:0] ADDRESS, last_write,
		output logic[7:0] DATA_OUT,
		output logic E_CLK, rw);
logic[15:0] address, counter, next_counter;// capture;
logic[7:0] A_DIRECTION_o, B_DIRECTION_o, data_in, data_out, outcomp_l, outcomp_h;
//logic[7:0] DATA_IN_S;
//logic[4:0] PORT_B_IN_S, PORT_A_IN_S;
//logic[1:0] cycle, next_cycle;
logic[7:0] REG_DATA;
logic REG_RW, iRAM_E;
logic B_EN, A_EN, vma, hold_s, nmi_s, PORTB_W, PORTA_W, outcomp_l_EN, outcomp_h_EN, counter_he, counter_le, counter_w, RST_S, irq_s;
logic OCF, TOF, EOCI, ETOI, TCSR_EN, TCSR_READ;
REG_8 direction_a(.Din(data_out), .Dout(A_DIRECTION_o), .EN(A_EN), .Clk);
REG_8 direction_b(.Din(data_out), .Dout(B_DIRECTION_o), .EN(B_EN), .Clk);
REG_8 port_b(.Din(data_out), .Dout(PORT_B_OUT), .EN(PORTB_W), .Clk);
REG_8 port_a(.Din(data_out), .Dout(PORT_A_OUT), .EN(PORTA_W), .Clk);
REG_8 outc_h(.Din(data_out), .Dout(outcomp_h), .EN(outcomp_h_EN), .Clk);
REG_8 outc_l(.Din(data_out), .Dout(outcomp_l), .EN(outcomp_l_EN), .Clk);

//cpu68 cpu68_inst(.clk(Clk), .rst(RST_S), .rw(rw), .vma(vma), .address(address), .data_in(data_in), .data_out(data_out), .hold(hold_s), .halt(halt), .irq(1'b0), .nmi(nmi_s));
cpu01 cpu01_inst(.clk(Clk), .rst(RST_S), .rw(rw), .vma(vma), .address(address), .data_in(data_in), .data_out(data_out), .hold(hold_s), .halt(halt), .irq(1'b0), .nmi(nmi_s), .irq_icf(1'b0), .irq_ocf(1'b0), .irq_tof(1'b0), .irq_sci(1'b0));
MEM_128_8 iMEM(.Clk, .reset(RST_S), .data_in(data_out), .data_out(REG_DATA), .RW(REG_RW), .address(address[6:0]));
assign ADDRESS = address;
assign DATA_OUT = data_out;
//assign last_write = {1'b1, OCF, TOF, 1'b0, EOCI, ETOI, 10'h00};
always_ff @ (negedge Clk)
begin
	hold_s <= hold;
	nmi_s <= nmi;
	RST_S <= RST;
	//irq_s <= irq;
	//PORT_B_IN_S <= PORT_B_IN;
	//PORT_A_IN_S <= PORT_A_IN;
	if(vma & (~rw))
		last_write <= address;
//	if(counter_he)
//		counter <= {data_out, counter[7:0]};
//	else if(counter_le)
//		counter <= {counter[15:8], data_out};
	if(RST_S)
	begin
		counter <= 0;
		OCF <= 0;
		TOF <= 0;
		EOCI <= 0;
		ETOI <= 0;
	end
	else
	begin
	if(counter_w)
		counter <= 16'hfff8;
	else
	begin
		counter <= next_counter;
	end
	//cycle <= next_cycle;
//	if(capture_EN)
//		capture <= counter;
	if(TCSR_EN)
	begin
		EOCI <= data_out[3];
		ETOI <= data_out[2];
	end
	if(TCSR_READ)
	begin
		TOF <= 0;
		OCF <= 0;
	end
	else 
	begin
	if(counter == {outcomp_h, outcomp_l})
		OCF <= 1'b1;
	if(counter == 16'hffff)
		TOF <= 1'b1;
	end
	end
end

always_comb
begin
outcomp_h_EN = 0;
outcomp_l_EN = 0;
REG_RW = 1;
TCSR_EN = 0;
TCSR_READ = 0;
next_counter = counter + 16'h01;
//next_cycle = cycle + 2'b01;
//if(counter == {outcomp_h, outcomp_l})
//	capture_EN = 1'b1;
//else
//	capture_EN = 0;
if(address > 16'h7f && address < 16'h100 && vma)
	iRAM_E = 1'b1;
else
	iRAM_E = 0;
counter_w = 0;
A_EN = 0;
B_EN = 0;
PORTB_W = 0;
PORTA_W = 0;
//ADDRESS = 16'h06;
E_CLK = 0;
data_in = DATA_IN;
//DATA_OUT = 8'bxxxxxxxx;
	case (address)
	16'h00:
	begin
	if(vma & (~rw))
		A_EN = 1'b1;
	else if(vma)
		data_in = A_DIRECTION_o;
	end
	16'h01:
	begin
	if(vma & (~rw))
		B_EN = 1'b1;
	else if(vma)
		data_in = B_DIRECTION_o;
	end
	16'h02:
	begin
	if(vma & (~rw))
		PORTA_W = 1'b1;
	else if(vma)
		data_in = PORT_A_IN;
	end
	16'h03:
	begin
	if(vma & (~rw))	//write to port B
		PORTB_W = 1'b1;
	else if(vma)	//read port B
		data_in = {PORT_B_OUT[7:5], PORT_B_IN};
	end
	16'h08:
	begin
	if(vma & (~rw))
		TCSR_EN = 1'b1;
	else if(vma)
		begin
		TCSR_READ = 1'b1;
		data_in = {1'b1, OCF, TOF, 1'b0, EOCI, ETOI, 2'b00};
		end
	end
	16'h09:
	begin
	if(vma & (~rw))
		counter_w = 1'b1;	//preset the counter
	else if(vma)
		data_in = counter[15:8];
	end
	16'h0A:
	begin
	if(vma & rw)
		data_in = counter[7:0];
	end
	16'h0B:
	begin
	if(vma & (~rw))
		outcomp_h_EN = 1'b1;
	else if(vma)
		data_in = outcomp_h;
	end
	16'h0C:
	begin
	if(vma & (~rw))
		outcomp_l_EN = 1'b1;
	else if(vma)
		data_in = outcomp_l;
	end
//	16'h0D:
//	begin
//	if(vma & rw)
//		data_in = capture[15:8];
//	end
//	16'h0E:
//	begin
//	if(vma & rw)
//		data_in = capture[7:0];
//	end
	default:
	begin
	if(iRAM_E)
	begin
		REG_RW = rw;
		data_in = REG_DATA;
	end
	else
	begin
		E_CLK = vma;
		data_in = DATA_IN;
	end
	end
	endcase
end
endmodule

module REG_8(input logic [7:0] Din, input logic EN, Clk, output logic[7:0] Dout);
	always_ff @ (posedge Clk)
	begin
		if(EN)
			Dout <= Din;
		else
			Dout <= Dout;
	end
endmodule

module MEM_128_8(input logic[6:0] address, input logic RW, Clk, reset, input logic[7:0] data_in, output logic[7:0] data_out);
logic[7:0] REGS[127:0];
integer i;
always_ff @ (posedge Clk)
begin
if(reset)
	for(i=0; i<128; i=i+1)
		REGS[i]=0;
else if(~RW)
	REGS[address] <= data_in;
end
assign data_out = REGS[address];
endmodule

