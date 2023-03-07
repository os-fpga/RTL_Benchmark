// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


`timescale 1ns/1ps

module gpio (
	  gpio
);

parameter	NDS_GPIO_BITS	= 32;
parameter	OUT_DELAY	= 1;

inout	[NDS_GPIO_BITS-1:0]	gpio;

reg	[NDS_GPIO_BITS-1:0]	gpio_io;
reg	[NDS_GPIO_BITS-1:0]	gpio_oe;
reg	[NDS_GPIO_BITS-1:0]	gpio_out;
integer				i;
reg [31:0]			seed;

`include "sync_tasks.vh"


always @(gpio_out or gpio_oe)
begin
	for (i = 0; i < NDS_GPIO_BITS; i = i + 1) begin
		gpio_io[i] = gpio_oe[i] ? gpio_out[i]:1'bz;
	end
end


assign #(OUT_DELAY) gpio = gpio_io;


initial begin
	if ($value$plusargs("seed=%d", seed))
		seed = seed ^ 32'hf5c2cd30;
	else
		seed = 32'hf5c2cd30;

	gpio_oe = {NDS_GPIO_BITS{1'h0}};
	gpio_out = {NDS_GPIO_BITS{1'bx}};
end


`ifdef NDS_GPIO_MODEL_PAT
`include "gpio_model.pat"
`endif

endmodule

