// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


`timescale 1ns/1ps

module pwm_model (
	  pwm
);

parameter	NDS_PWM_WIDTH	= 4;

input	[(NDS_PWM_WIDTH - 1):0]	pwm;

reg [31:0]			seed;


`include "sync_tasks.vh"


initial begin
	if ($value$plusargs("seed=%d", seed))
		seed = seed ^ 32'h959220e6;
	else
		seed = 32'h959220e6;
end


`ifdef NDS_PWM_MODEL_PAT
`include "pwm_model.pat"
`endif


endmodule

