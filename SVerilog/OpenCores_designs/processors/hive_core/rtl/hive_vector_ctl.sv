/*
--------------------------------------------------------------------------------

Module: hive_vector_ctl.sv

Function: 
- Vector (clear & interrupt) control for single processor thread.

Instantiates: 
- Nothing.

Dependencies:
- None.

Notes:
- Clear / IRQ latched until output.
- Automatic thread clearing @ async reset.
- Interrupts automatically disarmed with associated thread clear.
- Interrupt arm / disarm inputs behave like set / reset FF.
- Interrupt service history tracked, no new IRQ issued until the 
  current one is done.  History cleared @ thread clear.

--------------------------------------------------------------------------------
*/
module hive_vector_ctl
	(
	// clocks & resets
	input			logic								clk_i,						// clock
	input			logic								rst_i,						// async. reset, active high
	// external interface
	input			logic								cla_i,						// clear all, active high
	input			logic								xsr_i,						// external interrupt edge(s)
	// register set interface
	input			logic								reg_wr_i,					// arm/dis/clt/isr write, active high
	input			logic								reg_arm_i,					// interrupt arm, active high one clock
	input			logic								reg_dis_i,					// interrupt disarm, active high one clock
	input			logic								reg_clt_i,					// clear thread, active high one clock
	input			logic								reg_isr_i,					// interrupt, active high one clock
	output		logic								reg_armed_o,				// interrupt armed, active high level
	output		logic								reg_isv_o,					// servicing interrupt, active high level
	// serial interface
	input			logic								en_1_i,						// I/O enable, active high
	input			logic								clt_1_i,						// clear thread, active high
	input			logic								irt_1_i,						// isr return, active high
	output		logic								clt_2_o,						// clear thread, active high
	output		logic								irq_2_o						// interrupt, active high
	);


	/*
	----------------------
	-- internal signals --
	----------------------
	*/
	logic												en_2, armed_2, irq_2, isv_2, clt_2;


	/*
	================
	== code start ==
	================
	*/


	// decode
	always_ff @ ( posedge clk_i or posedge rst_i ) begin
		if ( rst_i ) begin
			en_2 <= '0;
			armed_2 <= '0;
			irq_2 <= '0;
			isv_2 <= '0;
			clt_2 <= '1;  // note: assert @ async reset!
		end else begin
			// one clock delay
			en_2 <= en_1_i;
			// disarm @ thread clear or reg request, arm @ reg request
			if ( ( clt_1_i & en_1_i ) | ( reg_dis_i & reg_wr_i ) ) begin
				armed_2 <= '0;
			end else if ( reg_arm_i & reg_wr_i ) begin
				armed_2 <= '1;
			end
			// clear service state @ thread clear or reg request, set @ int
			if ( ( clt_1_i | irt_1_i ) & en_1_i ) begin
				isv_2 <= '0;
			end else if ( armed_2 & ( ( reg_isr_i & reg_wr_i ) | xsr_i ) ) begin
				isv_2 <= '1;
			end
			// set pending irq @ isr w/ arm, clear @ issue
			if ( ~isv_2 & armed_2 & ( ( reg_isr_i & reg_wr_i ) | xsr_i ) ) begin
				irq_2 <= '1;
			end else if ( en_2 ) begin
				irq_2 <= '0;
			end
			// set pending clt @ core clear or reg request, clear @ issue
			if ( cla_i | ( reg_clt_i & reg_wr_i ) ) begin
				clt_2 <= '1;
			end else if ( en_2 ) begin
				clt_2 <= '0;
			end
			//
		end
	end
	
	// decode outputs
	always_comb reg_armed_o = armed_2;
	always_comb reg_isv_o = isv_2;
	always_comb clt_2_o = ( clt_2 & en_2 );
	always_comb irq_2_o = ( irq_2 & en_2 );


endmodule
