/*
--------------------------------------------------------------------------------

Module : hive_top.sv

--------------------------------------------------------------------------------

Function:
- General purpose barrel processor FPGA core with:
  - 8 threads & 8 stage pipeline
  - 8 indexed LIFO stacks per thread w/ pop control
  - 32 bit data
  - 16 bit opcode
  - 32 bit GPIO
  - Double buffered UART

Instantiates (at this level):
- rst_bridge.sv
- hive_core.sv
- hive_uart.sv
- hive_gpio.sv

Dependencies:
- hive_pkg.sv


--------------------
- Revision History -
--------------------

v08.06 - 2015-09-04
- Fixed SKP & SK2 odd test opcodes flagging errors.
- Passes new verification & functional testing.
- EP3C5E144C: 2420 LEs, 194.1 MHz.

v08.06 - 2015-08-26
- Opcode renaming: 
  - op_pop_8 => op_pop
  - op_cls_8 => op_cls
  - op_mem_4* => op_mem_*
  - op_reg_6* => op_reg_*
  - op_dat_8* => op_byt

v08.05 - 2015-08-24
- Opcode renaming: 
  - op_mem_4rls => op_mem_4rs
  - op_lit_ls => op_lit_s
  - op_lit_lu => op_lit_u
  - op_cpy_ls => op_cpy_s
  - op_cpy_lu => op_cpy_u

v08.04 - 2015-08-22
- Added A odd tests to SKP & SK2 opcodes.

v08.03 - 2015-07-24
- Swapped locations of op_dat_8 and op_add_8.
- Opcode decoding is now purely nested case statements.
- Opcode renaming: 
  - op_*_xu => op_*_u
  - op_*_xs => op_*_s

v08.03 - 2015-07-21
- Fixed horrific bug that goes all the way back to v06.01:
  - Copy path through the ALU not specified for op_dat immediate data!
- op_sk2 (A?B) opcodes are back, op_skp name unchanged.
- Shuffled opcodes, removed opcode type CODE_T, streamlined default decoding.
- No significan blank contiguous opcode space.
- Opcode renaming: op_nsb => op_bnh.
- Added a bit of buffering to baud clock to ease UART timing.

v08.02 - 2015-07-14
- Removed op_sk2 (A?B) opcodes, op_sk1 is now op_skp.
- Added jmp_8 unconditional jump opcode.
- Blank contiguous opcode space 0x7000 : 0x7fff.
- Opcode renaming: 
  - op_pus_6 => op_shp_6u.
  - op_dat_8s => op_dat_8.
  - op_add_8s => op_add_8.

v08.01 - 2015-07-13
- Removed op_jmp_4 (A?B) opcodes - hogging too much opcode space.
- Added op_sk1 and op_sk2 (A?B) opcodes.
- op_jmp_6s, op_dat_6s, and op_add_6s are now *_8s.
- Removed redundant PC+1 & PC+2 lit logic.
- Shuffled opcodes.

v07.02 - 2015-06-16
- Bit reduction opcodes now return 1/0 rather than -1/0 (more useful?).
- Added conditional (A?0) GTO opcodes.  (Need to add bootcode tests!)
- Fixed horrific bug that goes all the way back to v05.03:
  - AB Pops not inhibited during decode of IRQ cycle!
- Pop default decode is now don't pop (for clarity).
- Signal renaming: 
  - isr/ISR => irq/IRQ, push/PUSH => psh/PSH.
  - pop_i/o => pop_im_i/o.
  - cls_i/o => cls_im_i/o.
- Opcode rename: nsg => nsb
- Untested.

v07.01 - 2015-04-21
- Welcome to the new top level, hive_top.sv.
- The core has the version, time, vector, and error registers,
  the top level contains the UART and GPIO registers.
- The core port now sports the RBUS master interface.
- Added parameter MEM_ROM_W to protect ROM area in low main memory.
- Added parameter XSR_LIVE_MASK to enable / disable XSR inputs.
- Moved remaining trivial registering of RBUS bridge to the data ring.
- Components removed: hive_reg_set.sv.
- Components renamed: hive_reg_base.sv => hive_base_reg.sv.
- Register descriptions now in hive_rbus_regs.txt.
- Untested.

v06.10 - 2015-04-13
- MEM_IM_W is now 5, moved *2 shift for 32 bit access address
  offset into op_decode.
- Simplified & sped up boot code interpretation & initializaion.
- New global parameter: MEM_DEPTH.
- rst_bridge sync depth back to SYNC_W.
- Played with async reset removal - doesn't use that many resources,
  doesn't really impact top speed, and useful for sim, so keeping it.
- EP3C5E144C: 2463 LEs, 196.4MHz
- Passes all boot code verification & functional tests.

v06.09 - 2015-04-12
- ISR servicing state moved back to vectoring logic which 
  minimizes pipeline registering between it and the register set.
  This logic is now a single register deep.
- Removed thread clear events from error register.  Cleared
  threads can report this through some other mechanism if needed.
- New component: hive_in_cond.sv to handle XSR & register set 
  input conditioning (identical functionality).
- Fixed bug regarding register set input data edge detection 
  option masks (mask vectors weren't indexed).
- Functions lzc and flip now use ALU_W (rather than fixed 32).
- Renamed global params: 
  - ALU_LOW_W => LOW_W
  - CLR_BASE => CLT_BASE
  - CLR_SPAN => CLT_SPAN
- Promoted local params to global: ZSX_W, DBL_W
- Removed DATA_W parameter in alu_multiply.sv, now using ZSX_W.
- Reorged/renamed dp_ram_dual.sv => ram_dp_dual.sv.
- Reorged/renamed dq_ram.sv => ram_dq.sv.
- +1 stage in hive_rst_bridge.sv.
- A bit of mucking about with op decode reset values.
- EP3C5E144C: 2487 LEs, 200MHz!
- Passes all boot code verification & functional tests.

v06.08 - 2015-03-29
- Removed input registers @ ALU top, now using those in the 
  subcomponents which should synthesize equivalently.
- Made pc_im in op_decode PC_W wide to make selection in the 
  PC control ring less weird looking, did the same for alu_im
  in the data ring and for the same reason.  No synthesis impact.
- Global parameters PC_IM_W and ALU_IM_W removed.
- EP3C5E144C: 2488 LEs, 195.7MHz.
- Passes all boot code verification & functional tests.

v06.07 - 2015-03-27
- Changes to register base and set logic:
  - 3 register pipe through the set rather than 2.
  - OUT_MODE is now RD_MODE.
  - COW1 mode moved to write side logic.
  - Separate live bit masks for read and write sides.
  - Global SYNC_W parameter used for optional resync of inputs.
- EP3C5E144C: ~2500 LEs, ~195MHz.
- Passes all boot code verification & functional tests.

v06.06 - 2015-03-21
- Vectoring:
  - Back to single register control in register set.
  - Removed individual tracking of ISR / XSR (no point).
  - Current ISR servicing state now maintained in op decoder.
  - ISR state machines gone due to simplifications.
  - All feed-forward.
- Register set now distributed rather than in one component,
  which makes the design more modular.  "RBUS" is the internal bus.
- Time, vectoring, UART, GPIO, and error now have internal register set 
  registers, GPIO & error are now separate components.
- Eliminated MSB linter pruning warnings in hive_alu_multiply.sv.
- Signal rename: clr_i => cla_i.
- A few parameters added to package.
- EP3C5E144C: ~2570 LEs, ~195MHz.
- Passes all boot code verification & functional tests.

v06.05 - 2015-03-16
- Edited main_mem to give 32 bit offset w/ 32 bit access.
- Vectoring:
  - State machine now differentiates between ISR & XSR.
  - Vector register 1 now reads XSR status rather than clearing status.
  - Moved vector pipe component from register set to control ring.
  - Shuffled vector register 0 bits.
- Moved stack push binary=>one-hot 1 stage earlier for registering.
- EP3C5E144C: ~2650 LEs, ~195MHz using:
  - Placement Effort Multiplier = 2
  - Router Effort Multiplier = 2
  - Router Timing Optimization Level = max
- Passes all boot code verification & functional tests.

v06.04 - 2015-03-13
- Opcode immediates separated out to eliminate re-encoding/decoding.
- Moved cls and pop decoding to data_ring | stacks stage 0 for speedup.
- New parameters:
  - ALU_LOW_W (=ALU_W>>1)
  - ALU_IM_W
  - PC_IM_W
  - MEM_IM_W
- Removed parameters:
  - TIME_W (=ALU_W).
- Renamed parameters:
  - STK* => STK_*
  - STACKS_W => STK_W
  - ID_W => THD_W
- EP3C5E144C: ~2600 LEs, ~195MHz using:
  - Placement Effort Multiplier = 4
  - Router Timing Optimization Level = max
- Passes all boot code verification & functional tests.
  
v06.04 - 2015-03-05
- Removed most interstage feedback, now almost competely feedforward:
  - Push stack selector encoded binary w/ enable rather than one-hot.
  - Stack push moved to stage 5.
  - Stack errors pipelined to next cycle @ stage 0.
  - Opcode error and thread clear reporting @ stage 0.
- File edit & rename:
  - hive_stack_level => hive_level_ring
  - hive_stack_pipe => hive_stack_ring
  - hive_stack_ring => hive_stacks
- EP3C5E144C: ~2613 LEs, ~195MHz (using DSE).
- Passes all boot code verification & functional tests.

v06.03 - 2015-02-27
- Revamped vectoring (clear, ISR, XSR) and initialization (async reset):
  - Now fully pipelined and conceptually simpler WRT thread timing.
  - Vectoring control logic now straddles stages 2 & 3 (post regs out).
  - Separate masks for internal (ISR) and external (XSR) service requests.
  - Arm / disarm X/ISR states separated from state machines.
  - Thread X/ISR & clear current status brought to the register set.
  - Error register now indicates thread clearing history.
  - Single vector register expanded to two, register space juggled.
  - Added rst_bridge.sv for async assert / sync de-assert of reset.
  - Added clr_i to top level - clear all threads, active high.
  - PC async reset init values now correctly assigned.
  - ID & PC clear / reset values now typed parameters in hive_rst_vals package.
- Edited stack error and opcode error reporting logic, all do so at stage 3.
- Removed stack ring external level I/O & feedback.
- Swapped sense of WAR & RAW: "Write And Read" & "Read And Write".
- File major edit & rename:
  - hive_vector_sm.sv => hive_vector_ctl.sv.
  - hive_vector.sv => hive_vector_pipe.sv.
- Signal & state rename:
  - clr* => clt* (clear thread)
- Opcode rename:
  - rtn => irt (to make clear it is not for subroutines)
  - isg => nsg (to differentiate from irt)
- Other misc. minor style edits here and there.
- EP3C5E144C: ~2650 LEs, ~195MHz (using DSE).
- Passes all boot code verification & functional tests.

v06.02 - 2014-12-24
- Minor style edits to UART, DDS baud rate generator replaced with
  more generic component ramp_tri_sq.sv.
- Prepended "hive_" to UART component names.
- Minor style edits to hive_vector_sm.sv.
- Entity renaming: 
  - hive_vector_ctrl.sv => hive_vector.sv
- New / different opcodes:
  - cls_8 : clear[7:0] none/one/some/all stacks
- Opcode renaming:
  - pcp => pgc
  - pop => pop_8
  - all *_i* now have immediate width in place of 'i' 
    e.g. op_jmp_inls => op_jmp_4nls

v06.01 - 2014-07-13 - PUBLIC RELEASE -
- Major changes in hive_main_mem.sv to support 16 & 32 bit 
  aligned and unaligned access for literals and memory R/W.
- Main memory BRAM now a dual entity to provide separate addressing
  of high and low and to circumvent bootcode init issues.
- R/W immediate field offset is based on 16 bit access.
- New / different opcodes:
  - cpy_ls   : 16 bit copy low signed
  - cpy_lu   : 16 bit copy low unsigned
  - lit      : 32 bit literal 
  - lit_ls   : 16 bit literal low signed
  - lit_lu   : 16 bit literal low unsigned
  - mem_ir   : 32 bit memory read
  - mem_irls : 16 bit mememory read low signed
  - mem_iw   : 32 bit mememory write
  - mem_iwl  : 16 bit memory write low
- Some juggling of opcode order to hopefully ease decode.
- hive_alu_logical.sv rearranged a bit, removed a and default paths.
- Passes all boot code verification & functional tests.

v05.04 - 2014-06-13 - PUBLIC RELEASE -
- SystemVerilog!  Many edits to take advantage of SV language constructs.
  - All functions, parameters, defines, types, etc. are now in hive_pkg.sv.
  - If synthesis fails position package first in project list.
- Parameter renaming:
  - LEVEL_W => STKLVL_W
  - POINTER_W => STKPTR_W
  - UART_BAUD_RATE => UART_BAUD
  - BAUD_RATE => BAUD
  - TIME_ID_ADDR => TIME_A
  - All reg addresses => *_A
- File renaming:
  - All hive specific modules are now named hive_*.sv.
- Pointer to boot code file is in dp_ram_infer.sv:
  - ex: `include "boot_code\boot_code_v_alu.sv"
- Passes all boot code verification & functional tests.

v05.03 - 2014-06-07 - PUBLIC RELEASE -
- Register access now uses immediate for address, up to 64 regs supported.
- Bypass path for A added to alu_logical.v, decoded via an unused lg value.
- Rewrite of op_decode.v to simplify decode.
- Passes all boot code verification & functional tests.

v05.02 - 2014-05-26
- Parameter renaming:
  - DATA_W => ALU_W
  - ACCESS_W => CODE_W
  - STK_W => STACKS_W
  - DM_OFFS_W = MEM_IM_W
  - ADDR_W => PC_W & MEM_ADDR_W
- PC_W and MEM_ADDR_W now somewhat independent, though the user 
  should ensure that PC_W >= MEM_ADDR_W.
- VER_W removed.
- A bit of cleanup here and there.

v05.01 - 2014-05-20
- Rewrite / edit / reorg of modules to facilitate verification.
- Major changes to interrupt functionality:
  - Interrupts now automatically disarmed during ISR and rearmed @ return.
  - New op_rtn instruction to support auto ISR disarm / rearm.
  - ISR register set arm / disarm now s/b safe w/ multiple access.
- Register set access is now 32 bits wide (to support coprocessors & such).
- Expanded ID register to Time/ID (32 vs. 3 bits).
- Combined RX & TX UART registers.
- Combined HI & LO I/O registers.
- Combined interrupt and clear registers.
- Version width generalized (and VER register fixed).
- Register set component moved two pipe stages earlier.
- Integrated main memory into former reg_mem_shim component.
- MEM_DATA_W is now ACCESS_W.
- ADDR_W now applies to ALL addresses, including PCs and such.
- Changed op_lit_h to use B[lo] rather than A[lo] as input.
- Simplified lzc_32 function a bit to make it more uniform.
- Now compiles in XST 14.7 (but not BRAM boot code?)
- Passes all boot code verification & functional tests.

v04.06 - 2014-01-28
- Fixed pop typo in boot_code_exp2.h
- Fixed trailing comma typo in alu_logical.v
- Op renaming:
    psu_i => pus_i
    pcn => pcp
    nsg => isg

v04.05 - 2014-01-02 - PUBLIC RELEASE -
- Note main version jump.
- Forked design back into main line.
- OP_CODE_W is now MEM_DATA_W.

v01.04 - 2014-01-01
- Moved register set and main memory data port one pipeline stage later.
- op_pow is back and is now sign neutral.
- Op renaming: psh_iu => psu_i.
- `_0, `_1, etc. is now `s* in all boot code.
- Added header blocking statements to some *.h files (didn't work for all).
- Use of real rather than integer types in UART calculations for clarity.
- EP3C5E144C: 2662 LEs, 198MHz (w/o DSE, synthesis optimized for speed).
- Passes all boot code verification & functional tests.

v01.03 - 2013-12-23
- Short 4 bit (+7/-8) immediate (A?B) jumps have replaced all following jumps.
- Removed unconditional immediate jump (use op_jmp_ie).
- Immediate (A?0) jumps, data, and add IM value reduced to 6 bits.
- Removed op_pow_i, op_shl_iu is op_psh_iu: combo pow2 and right shift, 
  op_shl_u is strictly unsigned shift.
- UART added to register set.
- Op renaming:
    dat_f* => lit_*
    shl_iu => psh_iu
- Small changes to register set base component parameters & I/O.
- Opcode encode/decode now over full opcode width.
- EP3C5E144C: 2650 LEs, 189MHz (w/o DSE).
- Passes all boot code verification & functional tests.

v01.02 - 2013-12-06
- Following jumps (jmp_f) have replaced all skips.
- Added op_pow & op_pow_i opcodes.
- A odd testing removed (lack of opcode space).
- op_pop now covers all stacks at once via {pb, sb, pa, sa} binary field.
- op_reg_r now signed, added read and write high register ops (_wh is ~free).
- Added op_lit_u to accomodate 16 bit addresses & such.
- Op renaming:
    lit => dat_f
    byt => dat_i
    *_sx => *_xs
    *_ux => *_xu
- Moved PC interrupt & jmp_f address loads to stage 4 of PC pipe.
- op_dat_fh now uses A as source of low data rather than B,
  which is more consistent and allows unrelated pop.
- Register set addresses now defined as 8 bits wide.
- EP3C5E144C: ~2500 LEs, 185MHz (w/o DSE).
- Passes all boot code verification tests.
- Passes boot code functional tests: divide, sqrt, log2, exp2.

v01.01 - 2013-11-19
- Born.  Based on Hive v3.10.  Has 8 stacks per thread.
- Skips are back for A odd and (A?B) testing.
- Removed op_cls as it seems too dangerous.  May put back in register set.
- Lots of op renaming: 
    dat_f => lit
    dat_i => byt
    or_br => bro, etc.
    or => orr
    pc => pgc (to make all op bases 3 letters)
- Reg access now unsigned low with no immediate offset.
- Added register to flag decode output, moved all PC changes to stage 3.
- EP3C5E144C: ~2400 LEs, 178MHz (w/o DSE).
- BROKEN: reg_mem_shim.v has bad decoding for dmem addr.

--------------------------------------------------------------------------------
*/
`include "hive_pkg.sv"
module hive_top
	(
	// clocks & resets
	input			logic								clk_i,						// clock
	input			logic								rst_i,						// async. reset, active high
	//
	input			logic								cla_i,						// clear all threads, active high
	input			logic	[THREADS-1:0]			xsr_i,						// external service request
	//
	input			logic	[ALU_W-1:0]				gpio_i,						// gpio
	output		logic	[ALU_W-1:0]				gpio_o,
	//
	input			logic								uart_rx_i,					// serial data
	output		logic								uart_tx_o					// serial data
	);

	
	/*
	----------------------
	-- internal signals --
	----------------------
	*/
	import hive_params::*; 
	import hive_types::*; 
	//
	logic												rst;
	logic					[RBUS_ADDR_W-1:0]		rbus_addr;
	logic												rbus_wr, rbus_rd;
	logic					[ALU_W-1:0]				rbus_wr_data, rbus_rd_data;
	logic					[ALU_W-1:0]				uart_rd_data, gpio_rd_data;


	/*
	================
	== code start ==
	================
	*/


	// reset bridge
	rst_bridge
	#(
	.SYNC_W				( SYNC_W )
	)
	rst_bridge
	(
	.*,
	.rst_o				( rst )
	);


	// the core
	hive_core  hive_core
	(
	.*,
	.rst_i				( rst ),
	.rbus_addr_o		( rbus_addr ),
	.rbus_wr_o			( rbus_wr ),
	.rbus_rd_o			( rbus_rd ),
	.rbus_wr_data_o	( rbus_wr_data ),
	.rbus_rd_data_i	( rbus_rd_data )
	);


	// big ORing of rbus read data
	always_comb rbus_rd_data = 
		uart_rd_data |
		gpio_rd_data;


	// uart
	hive_uart  hive_uart
	(
	.*,
	.rst_i				( rst ),
	.rbus_addr_i		( rbus_addr ),
	.rbus_wr_i			( rbus_wr ),
	.rbus_rd_i			( rbus_rd ),
	.rbus_wr_data_i	( rbus_wr_data ),
	.rbus_rd_data_o	( uart_rd_data ),
	.loop_i				( '0 )
	);


	// gpio
	hive_gpio  hive_gpio
	(
	.*,
	.rst_i				( rst ),
	.rbus_addr_i		( rbus_addr ),
	.rbus_wr_i			( rbus_wr ),
	.rbus_rd_i			( rbus_rd ),
	.rbus_wr_data_i	( rbus_wr_data ),
	.rbus_rd_data_o	( gpio_rd_data )
	);


endmodule
