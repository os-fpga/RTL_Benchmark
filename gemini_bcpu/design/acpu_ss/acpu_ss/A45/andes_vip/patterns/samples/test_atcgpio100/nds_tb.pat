
initial begin: program_blk
	reg [31:0] channel_no;
	reg [31:0] data32, data2;
	integer i, j;

	#1 ;
	`NDS_GPIO_MODEL.gpio_oe = 32'hffffffff;
	`NDS_GPIO_MODEL.gpio_out = 32'h0;

	for (j = 0; j < 2; j = j + 1) begin
		@(`NDS_SIM_CONTROL.event_model_0) ;
		channel_no = `NDS_SIM_CONTROL.temp6;

		// Mode 0 test - reserved value (NOP)
		@(`NDS_SIM_CONTROL.event_model_1) ;
		`NDS_GPIO_MODEL.gpio_out = 32'hffffffff;	// Test high & rising edge
		@(`NDS_SIM_CONTROL.event_model_0) ;
		`NDS_GPIO_MODEL.gpio_out = 32'h00000000;	// Test low & falling edge

		for (i = 0; i < channel_no; i = i + 1) begin
			@(`NDS_SIM_CONTROL.event_model_1) ;
			`NDS_GPIO_MODEL.gpio_out[i] = 1'b1;	// High-level trigger

			@(`NDS_SIM_CONTROL.event_model_0) ;
			`NDS_GPIO_MODEL.gpio_out[i] = 1'b0;	// Low-level trigger

			@(`NDS_SIM_CONTROL.event_model_1) ;
			`NDS_GPIO_MODEL.gpio_out[i] = 1'b1;	// Rising-edge trigger

			@(`NDS_SIM_CONTROL.event_model_0) ;
			`NDS_GPIO_MODEL.gpio_out[i] = 1'b0;	// Falling-edge trigger

			@(`NDS_SIM_CONTROL.event_model_1) ;
			`NDS_GPIO_MODEL.gpio_out[i] = 1'b1;	// Dual-edge trigger

			@(`NDS_SIM_CONTROL.event_model_0) ;
			`NDS_GPIO_MODEL.gpio_out[i] = 1'b0;	// Dual-edge trigger
		end
	end

end


