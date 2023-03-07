// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary



`timescale 1ns/1ps

module i2c_master_model (
	  scl,
	  sda,
	  smbsus,
	  smbalert
);

parameter OUT_DELAY = 1.0;
parameter DEFAULT_CLK_PERIOD = 1000;
parameter TIMEOUT_COUNT = 1000000;
parameter BUFFER_INDEX_SIZE = 10;

parameter DEFAULT_TS_TIME = (DEFAULT_CLK_PERIOD >> 2);
parameter BUFFER_SIZE = (1 << BUFFER_INDEX_SIZE);

parameter I2C_READ  = 8'd1;
parameter I2C_WRITE = 8'd0;
parameter I2C_ACK  = 1'b0;
parameter I2C_NACK = 1'b1;
parameter GC_ADDR = 8'h0;
parameter SB_ADDR = 8'h1;

inout		scl;
inout		sda;
inout		smbsus;
inout		smbalert;

reg				scl_out;
reg				sda_out;
reg				smbsus_out;
reg				smbsus_en;
reg				smbalert_out;

reg				i2c_busy;
reg				i2c_cbusy;
reg				i2c_cown;
reg				arb_lose;

reg	[7:0]			read_buf	[0:BUFFER_SIZE-1];
reg	[7:0]			write_buf	[0:BUFFER_SIZE-1];
reg	[BUFFER_INDEX_SIZE-1:0]	read_index;

reg	[10:0]			address_setting;
reg	[31:0]			counter_setting;
event				master_write_enable;
event				master_read_enable;


reg [31:0]	seed;
integer		i2c_clk_period;
integer		i2c_ts_time;
real		i2c_halfclk_period;
real		i2c_ts_time_rem;

`include "sync_tasks.vh"

initial begin
	if ($value$plusargs("seed=%d", seed))
		seed = seed ^ 32'hd6abc6d1 ^ MODEL_ID;
	else
		seed = 32'hd6abc6d1 ^ MODEL_ID;
	address_setting = 11'bx;
	counter_setting = 32'bx;
end

assign #(OUT_DELAY) sda = sda_out ? 1'bz : 1'b0;
assign #(OUT_DELAY) scl = scl_out ? 1'bz : 1'b0;
assign #(OUT_DELAY) smbsus = smbsus_en ? smbsus_out : 1'bz;
assign #(OUT_DELAY) smbalert = smbalert_out ? 1'bz : 1'b0;

`ifdef NDS_I2C_MASTER_MODEL_PAT
`include "i2c_master.pat"
`endif

initial begin
	i2c_clk_period = DEFAULT_CLK_PERIOD;
	i2c_ts_time = DEFAULT_TS_TIME;
	i2c_halfclk_period = i2c_clk_period/2.0;
	i2c_ts_time_rem = i2c_halfclk_period - $itor(i2c_ts_time);
end

initial begin
	reset_process;
end

always @(sda) begin
	if (scl === 1'b1) begin
		if (sda === 1'b0) begin
			@(negedge scl);
			if (i2c_cbusy === 1'b0) begin
				i2c_busy <= 1'b1;
			end
		end
		else begin
			i2c_busy <= 1'b0;
		end
	end
end

always @(posedge arb_lose) begin
	if ((i2c_busy === 1'b0) && (arb_lose === 1'b1)) begin
		i2c_busy <= 1'b1;
	end
end

always @(posedge scl) begin
	if ((i2c_cbusy === 1'b1) && (i2c_cown === 1'b1) && (sda !== sda_out)) begin
		arb_lose <= 1'b1;
	end
end

always @(master_write_enable) begin
	send_write(address_setting, counter_setting);
end

always @(master_read_enable) begin
	send_read(address_setting, counter_setting);
end


task reset_process;
begin
	i2c_busy  = 1'b0;
	i2c_cbusy = 1'b0;
	i2c_cown  = 1'b0;
	arb_lose  = 1'b0;
	sda_out   = 1'b1;
	scl_out   = 1'b1;
	smbsus_en    = 1'b1;
	smbsus_out   = 1'b1;
	smbalert_out = 1'b1;
end
endtask

task wait_i2c_clk_times;
input	[31:0]	i_count;
begin
	repeat (i_count) #(i2c_clk_period);
end
endtask

task set_clk_ts;
input	[31:0]	i_period;
input	[31:0]	i_ts;
begin
	if ($itor(i_ts) > (i_period/2.0)) begin
		$display("%0t:%m:ERROR: set_clk_ts failed. requirement: i_ts < (i_period/2.0)", $realtime);
		program_exit(1);
		disable set_clk_ts;
	end
	i2c_clk_period = i_period;
	i2c_ts_time = i_ts;
	i2c_halfclk_period = i2c_clk_period/2.0;
	i2c_ts_time_rem = i2c_halfclk_period - $itor(i2c_ts_time);
end
endtask

task send_one_byte;
output		o_ack;
input		i_start;
input	[7:0]	i_data;
input		i_stop;

reg		o_ack;
reg	[2:0]	index;
begin
	if (i_start) begin
		wait(i2c_busy === 1'b0);
		#(i2c_halfclk_period);
		scl_out = 1'b1;
		wait(scl === 1'b1);
		#i2c_ts_time;
		sda_out = 1'b0;
		i2c_cbusy = 1'b1;
		#(i2c_ts_time_rem);
		scl_out = 1'b0;
	end

	for (index = 3'h7; index > 3'h0; index = index - 3'h1) begin
		#i2c_ts_time;
		sda_out = arb_lose | i_data[index];
		i2c_cown = 1'b1;
		#(i2c_ts_time_rem);
		scl_out = 1'b1;
		wait(scl === 1'b1);
		#(i2c_halfclk_period);
		scl_out = 1'b0;
	end
	#i2c_ts_time;
	sda_out = arb_lose | i_data[index];
	i2c_cown = 1'b1;
	#(i2c_ts_time_rem);
	scl_out = 1'b1;
	wait(scl === 1'b1);
	#(i2c_halfclk_period);
	scl_out = 1'b0;

	#i2c_ts_time;
	sda_out = 1'b1;
	i2c_cown = 1'b0;
	#(i2c_ts_time_rem);
	scl_out = 1'b1;
	wait(scl === 1'b1);
	#i2c_ts_time;
	o_ack = sda;
	#(i2c_ts_time_rem);
	scl_out = arb_lose;

	if (arb_lose === 1'b1) begin
		arb_lose = 1'b0;
		i2c_cbusy = 1'b0;
		o_ack = I2C_NACK;
	end
	else if (i_stop) begin
		#i2c_ts_time;
		sda_out = arb_lose | 1'b0;
		i2c_cown = 1'b1;
		#(i2c_ts_time_rem);
		scl_out = 1'b1;
		wait(scl === 1'b1);
		#i2c_ts_time;
		sda_out = 1'b1;
		i2c_cown = 1'b0;
		arb_lose = 1'b0;
		i2c_cbusy = 1'b0;
	end
end
endtask

task receive_one_byte;
output	[7:0]	o_data;
input		i_ack;
input		i_stop;

reg	[7:0]	o_data;
reg	[2:0]	index;
begin
	index = 3'h7;
	#i2c_ts_time;
	sda_out = 1'b1;
	i2c_cown = 1'b0;
	#(i2c_ts_time_rem);
	scl_out = 1'b1;
	wait(scl === 1'b1);
	#i2c_ts_time;
	o_data[index] = sda;
	#(i2c_ts_time_rem);
	scl_out = 1'b0;

	for (index = 3'h6; index > 3'h0; index = index - 3'h1) begin
		#(i2c_halfclk_period);
		scl_out = 1'b1;
		wait(scl === 1'b1);
		#i2c_ts_time;
		o_data[index] = sda;
		#(i2c_ts_time_rem);
		scl_out = 1'b0;
	end
	#(i2c_halfclk_period);
	scl_out = 1'b1;
	wait(scl === 1'b1);
	#i2c_ts_time;
	o_data[index] = sda;
	#(i2c_ts_time_rem);
	scl_out = 1'b0;

	#i2c_ts_time;
	sda_out = arb_lose | i_ack;
	i2c_cown = 1'b1;
	#(i2c_ts_time_rem);
	scl_out = 1'b1;
	wait(scl === 1'b1);
	#(i2c_halfclk_period);
	scl_out = arb_lose;

	if (arb_lose === 1'b1) begin
		i2c_cown = 1'b0;
		arb_lose = 1'b0;
		i2c_cbusy = 1'b0;
	end
	else if (i_stop) begin
		#i2c_ts_time;
		sda_out = arb_lose | 1'b0;
		i2c_cown = 1'b1;
		#(i2c_ts_time_rem);
		scl_out = 1'b1;
		wait(scl === 1'b1);
		#i2c_ts_time;
		sda_out = 1'b1;
		i2c_cown = 1'b0;
		arb_lose = 1'b0;
		i2c_cbusy = 1'b0;
	end
end
endtask

task send_read;
input	[10:0]	i_slave_addr;
input	[31:0]	i_count;

reg	[7:0]	temp8;
reg	[31:0]	counter;
reg		ack;
begin
	if (i_slave_addr[10] === 1'b1) begin
		$display("%0t:%m:ERROR: 10-bit slave address is not supported", $realtime);
		program_exit(20);
		disable send_read;
	end
	else begin
		temp8 = {i_slave_addr[6:0], 1'b0} | I2C_READ;
	end
	counter = 32'h0;
	ack = I2C_NACK;
	while (ack !== I2C_ACK) begin
		send_one_byte(ack, 1'b1, temp8, 1'b0);
		counter = counter + 32'h1;
		if (counter == TIMEOUT_COUNT) begin
			$display("%0t:%m:ERROR: wait slave address ready timeout", $realtime);
			program_exit(21);
			disable send_read;
		end
	end

	read_index = {BUFFER_INDEX_SIZE{1'b0}};
	counter = i_count;
	while (counter !== 32'h0) begin
		receive_one_byte(temp8, ((counter === 32'h1) ? I2C_NACK : I2C_ACK), (counter === 32'h1));
		read_buf[read_index] = temp8;
		read_index = read_index + {{(BUFFER_INDEX_SIZE-1){1'b0}}, 1'h1};
		counter = counter - 32'b1;
	end
end
endtask

task send_write;
input	[10:0]			i_slave_addr;
input	[31:0]			i_count;

reg	[7:0]			temp8;
reg	[31:0]			counter;
reg				ack;
reg	[BUFFER_INDEX_SIZE-1:0]	write_index;
begin
	if (i_slave_addr[10] === 1'b1) begin
		$display("%0t:%m:ERROR: 10-bit slave address is not supported", $realtime);
		program_exit(30);
		disable send_write;
	end
	else begin
		temp8 = {i_slave_addr[6:0], 1'b0} | I2C_WRITE;
	end
	counter = 32'h0;
	ack = I2C_NACK;
	while (ack !== I2C_ACK) begin
		send_one_byte(ack, 1'b1, temp8, 1'b0);
		counter = counter + 32'h1;
		if (counter == TIMEOUT_COUNT) begin
			$display("%0t:%m:ERROR: wait slave address ready timeout", $realtime);
			program_exit(31);
			disable send_write;
		end
	end

	write_index = {BUFFER_INDEX_SIZE{1'b0}};
	counter = i_count;
	while (counter !== 32'h0) begin
		temp8 = write_buf[write_index];
		send_one_byte(ack, 1'b0, temp8, (counter === 32'h1));
		if (ack !== I2C_ACK) begin
			$display("%0t:%m:ERROR: response mismatch: got %d, expected %d (ACK)", $realtime, ack, I2C_ACK);
			program_exit(32);
			disable send_write;
		end
		write_index = write_index + {{(BUFFER_INDEX_SIZE-1){1'b0}}, 1'h1};
		counter = counter - 32'b1;
	end
end
endtask

task send_random_write;
input	[10:0]			i_slave_addr;
input	[31:0]			i_count;

reg	[31:0]			temp32;
reg	[7:0]			temp8;
reg	[31:0]			counter;
reg				ack;
reg	[BUFFER_INDEX_SIZE-1:0]	write_index;
begin
	if (i_slave_addr[10] === 1'b1) begin
		$display("%0t:%m:ERROR: 10-bit slave address is not supported", $realtime);
		program_exit(40);
		disable send_random_write;
	end
	else begin
		temp8 = {i_slave_addr[6:0], 1'b0} | I2C_WRITE;
	end
	counter = 32'h0;
	ack = I2C_NACK;
	while (ack !== I2C_ACK) begin
		send_one_byte(ack, 1'b1, temp8, 1'b0);
		counter = counter + 32'h1;
		if (counter == TIMEOUT_COUNT) begin
			$display("%0t:%m:ERROR: wait slave address ready timeout", $realtime);
			program_exit(41);
			disable send_random_write;
		end
	end

	write_index = {BUFFER_INDEX_SIZE{1'b0}};
	counter = i_count;
	while (counter !== 32'h0) begin
		temp32 = {$random(seed)};
		temp8 = temp32[7:0];
		write_buf[write_index] = temp8;
		send_one_byte(ack, 1'b0, temp8, (counter === 32'h1));
		if (ack !== I2C_ACK) begin
			$display("%0t:%m:ERROR: response mismatch: got %d, expected %d (ACK)", $realtime, ack, I2C_ACK);
			program_exit(42);
			disable send_random_write;
		end
		write_index = write_index + {{(BUFFER_INDEX_SIZE-1){1'b0}}, 1'h1};
		counter = counter - 32'b1;
	end
end
endtask

task send_general_call;
reg	[31:0]			temp32;
reg	[7:0]			temp8;
reg	[31:0]			counter;
reg				ack;
begin
	temp8 = GC_ADDR;
	counter = 32'h0;
	ack = I2C_NACK;
	while (ack !== I2C_ACK) begin
		send_one_byte(ack, 1'b1, temp8, 1'b0);
		counter = counter + 32'h1;
		if (counter == TIMEOUT_COUNT) begin
			$display("%0t:%m:ERROR: wait general call address ready timeout", $realtime);
			program_exit(51);
			disable send_general_call;
		end
	end

	temp32 = {$random(seed)};
	temp8 = temp32[7:0];
	if (temp8[0] == 1'b1) begin
		send_one_byte(ack, 1'b0, temp8, 1'b0);
		if (ack !== I2C_ACK) begin
			$display("%0t:%m:ERROR: response mismatch: got %d, expected %d (ACK)", $realtime, ack, I2C_ACK);
			program_exit(52);
			disable send_general_call;
		end

		counter = {$random(seed)};
		counter = (counter & 32'h7) + 32'h1;
		while (counter !== 32'h0) begin
			temp32 = {$random(seed)};
			temp8 = temp32[7:0];
			send_one_byte(ack, 1'b0, temp8, (counter === 32'h1));
			if (ack !== I2C_ACK) begin
				$display("%0t:%m:ERROR: response mismatch: got %d, expected %d (ACK)", $realtime, ack, I2C_ACK);
				program_exit(53);
				disable send_general_call;
			end
			counter = counter - 32'b1;
		end
	end
	else begin
		if (temp8[1] == 1'b1) begin
			temp8 = 8'h6;
		end
		else begin
			temp8 = 8'h4;
		end
		send_one_byte(ack, 1'b0, temp8, 1'b1);
		if (ack !== I2C_ACK) begin
			$display("%0t:%m:ERROR: response mismatch: got %d, expected %d (ACK)", $realtime, ack, I2C_ACK);
			program_exit(54);
			disable send_general_call;
		end
	end
end
endtask

task send_start_byte;
reg	[7:0]			temp8;
reg	[31:0]			counter;
reg				ack;
begin
	temp8 = SB_ADDR;
	counter = 32'h0;
	send_one_byte(ack, 1'b1, temp8, 1'b0);
	if (ack !== I2C_NACK) begin
		$display("%0t:%m:ERROR: response mismatch: got %d, expected %d (NACK)", $realtime, ack, I2C_NACK);
		program_exit(61);
		disable send_start_byte;
	end
end
endtask

endmodule
