/*
--------------------------------------------------------------------------------

Module : hive_pc_ring.sv

--------------------------------------------------------------------------------

Function:
- Processor PC generation and storage ring.

Instantiates:
- (1x) pipe.sv

Dependencies:
- Nothing.

Notes:
- 8 stages.
- Externally loop feedback so interstage registering forms a storage ring.

--------------------------------------------------------------------------------
*/

module hive_pc_ring
	(
	// clocks & resets
	input			logic								clk_i,						// clock
	input			logic								rst_i,						// async. reset, active high
	// control I/O
	input			ID_T								id_i,							// id
	input			logic								clt_i,						// 1 : pc clear
	input			logic								irq_i,						// 1 : pc=int
	input			logic								jmp_i,						// 1 : pc=pc+B|I for jump (cond)
	input			logic								gto_i,						// 1 : pc=B for goto | gosub (cond)
	input			logic								tst_res_3_i,				// 1 : true (or disabled)
	// address I/O
	input			logic	[PC_W-1:0]				b_im_i,						// b | im
	output		PC_T								pc_o
	);

	
	/*
	----------------------
	-- internal signals --
	----------------------
	*/
	import hive_params::*; 
	import hive_types::*; 
	import hive_rst_vals::*; 
	//
	logic					[3:1]						gto, jmp;
	logic					[2:1]						irq;
	logic					[PC_W-1:0]				b_im [1:3];
	logic					[PC_W-1:0]				pc_3;


	/*
	================
	== code start ==
	================
	*/


	// 0:1 mux & register
	always_ff @ ( posedge clk_i or posedge rst_i ) begin
		if ( rst_i ) begin
			irq[1] <= '0;
			jmp[1] <= '0;
			gto[1] <= '0;
			b_im[1] <= '0;
			pc_o[1] <= CLT_BASE | (ID_RST[1] << CLT_SPAN);
		end else begin
			irq[1] <= irq_i;
			jmp[1] <= jmp_i;
			gto[1] <= gto_i;
			b_im[1] <= b_im_i;
			unique casex ( { clt_i, irq_i } )
				'b01    : pc_o[1] <= pc_o[0];  // no change for irq
				'b1x    : pc_o[1] <= CLT_BASE | (id_i[0] << CLT_SPAN);  // clear
				default : pc_o[1] <= pc_o[0] + 1'd1;  // inc for next
			endcase
		end
	end


	// 1:2 register
	always_ff @ ( posedge clk_i or posedge rst_i ) begin
		if ( rst_i ) begin
			irq[2] <= '0;
			jmp[2] <= '0;
			gto[2] <= '0;
			b_im[2] <= '0;
			pc_o[2] <= CLT_BASE | (ID_RST[2] << CLT_SPAN);
		end else begin
			irq[2] <= irq[1];
			jmp[2] <= jmp[1];
			gto[2] <= gto[1];
			b_im[2] <= b_im[1];
			pc_o[2] <= pc_o[1];
		end
	end


	// 2:3 mux & register
	always_ff @ ( posedge clk_i or posedge rst_i ) begin
		if ( rst_i ) begin
			jmp[3] <= '0;
			gto[3] <= '0;
			b_im[3] <= '0;
			pc_o[3] <= CLT_BASE | (ID_RST[3] << CLT_SPAN);
		end else begin
			jmp[3] <= jmp[2];
			gto[3] <= gto[2];
			b_im[3] <= b_im[2];
			unique casex ( irq[2] )
				'b1     : pc_o[3] <= IRQ_BASE | (id_i[2] << IRQ_SPAN);  // interrupt
				default : pc_o[3] <= pc_o[2];  // no change
			endcase
		end
	end


	// 3:4 mux & register
	always_ff @ ( posedge clk_i or posedge rst_i ) begin
		if ( rst_i ) begin
			pc_o[4] <= CLT_BASE | (ID_RST[4] << CLT_SPAN);
		end else begin
			unique casex ( { tst_res_3_i, gto[3], jmp[3] } )
				'b101   : pc_o[4] <= pc_o[3] + b_im[3];  // lit | sk1 | sk2 | jmp | jmp_i
				'b11x   : pc_o[4] <= b_im[3];  // gto | gsb
				default : pc_o[4] <= pc_o[3];  // no change
			endcase
		end
	end


	// 4:0 regs
	always_ff @ ( posedge clk_i or posedge rst_i ) begin
		if ( rst_i ) begin
			pc_o[5] <= CLT_BASE | (ID_RST[5] << CLT_SPAN);
			pc_o[6] <= CLT_BASE | (ID_RST[6] << CLT_SPAN);
			pc_o[7] <= CLT_BASE | (ID_RST[7] << CLT_SPAN);
			pc_o[0] <= CLT_BASE | (ID_RST[0] << CLT_SPAN);
		end else begin
			pc_o[5] <= pc_o[4];
			pc_o[6] <= pc_o[5];
			pc_o[7] <= pc_o[6];
			pc_o[0] <= pc_o[7];
		end
	end


endmodule
