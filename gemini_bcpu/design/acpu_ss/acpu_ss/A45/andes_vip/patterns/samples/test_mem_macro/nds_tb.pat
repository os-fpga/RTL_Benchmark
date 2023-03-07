`include "xmr.vh"

// XMR
`ifndef NDS_CORE0_TOP
`define NDS_CORE0_TOP   `NDS_CORE_TOP
`endif // NDS_CORE0_TOP

bit flg_fail;

// VPERL_BEGIN
// my $max_hart_cnt = 8;
// for (my $i = 0; $i < $max_hart_cnt; $i++) {
// if ($i != 0) {
//:`ifdef NDS_IO_HART${i}
// }
//:bind `NDS_CORE${i}_TOP core_mem_checker #(
//:        .ISA_BASE (`NDS_ISA_BASE),
//:        // LM INTERFACE
//:        .LM_INTERFACE (`NDS_LM_INTERFACE),
//:        // ILM
//:        // ECC handled by wrapper
//:        .ILM_RAM_AW   (`NDS_ILM_RAM_AW),
//:        .ILM_RAM_DW   (`NDS_ILM_RAM_DW),
//:        .ILM_RAM_WEW  (`NDS_ILM_RAM_BWEW),
//:        .ILM_RAM_WUNIT(8),
//:        .ILM_ECC_TYPE (`NDS_ILM_ECC_TYPE),
//:        .ILM_ECCW     (0),		// FIXME: ECC is not supported yet
//:        .ILM_WAIT_CYCLE (`NDS_ILM_WAIT_CYCLE),
//:        // DLM
//:        .NUM_DLM_BANKS(`NDS_NUM_DLM_BANKS),
//:        // ECC handled by wrapper
//:        .DLM_RAM_AW   (`NDS_DLM_RAM_AW),
//:        .DLM_RAM_DW   (`NDS_DLM_RAM_DW),
//:        .DLM_RAM_WEW  (`NDS_DLM_RAM_BWEW),
//:        .DLM_RAM_WUNIT(8),
//:        .DLM_ECC_TYPE (`NDS_DLM_ECC_TYPE),
//:        .DLM_ECCW     (0),		// FIXME: ECC is not supported yet
//:        .DLM_WAIT_CYCLE (`NDS_DLM_WAIT_CYCLE),
//:        // BTB (No ECC)
//:        .BTB_BANK     (2),
//:        .BTB_RAM_AW   (`NDS_BTB_RAM_ADDR_WIDTH),
//:        .BTB_RAM_DW   (`NDS_BTB_RAM_DATA_WIDTH),
//:        .BTB_RAM_WEW  (1),
//:        .BTB_RAM_WUNIT(`NDS_BTB_RAM_DATA_WIDTH),
//:        // ICACHE
//:        // Tag:  ECC handled by core
//:        // Data: ECC handled by core
//:        .ICACHE_WAY           (`NDS_ICACHE_WAY),
//:        .ICACHE_TAG_RAM_AW    (`NDS_ICACHE_TAG_RAM_AW),
//:        .ICACHE_TAG_RAM_DW    (`NDS_ICACHE_TAG_RAM_DW),
//:        .ICACHE_TAG_RAM_WEW   (1),
//:        .ICACHE_TAG_RAM_WUNIT (`NDS_ICACHE_TAG_RAM_DW),
//:        .ICACHE_DATA_RAM_AW   (`NDS_ICACHE_DATA_RAM_AW),
//:        .ICACHE_DATA_RAM_DW   (`NDS_ICACHE_DATA_RAM_DW),
//:        .ICACHE_DATA_RAM_WEW  (1),
//:        .ICACHE_DATA_RAM_WUNIT(`NDS_ICACHE_DATA_RAM_DW),
//:        .ICACHE_ECC_TYPE      (`NDS_ICACHE_ECC_TYPE),
//:        .ICACHE_TAG_ECCW      (0),
//:        .ICACHE_DATA_ECCW     (0),
//:        // DCACHE
//:        // Tag:  ECC handled by core
//:        // Data: ECC handled by wrapper
//:        .DCACHE_WAY           (`NDS_DCACHE_WAY),
//:        .DCACHE_TAG_RAM_AW    (`NDS_DCACHE_TAG_RAM_AW),
//:        .DCACHE_TAG_RAM_DW    (`NDS_DCACHE_TAG_RAM_DW),
//:        .DCACHE_TAG_RAM_WEW   (1			),
//:        .DCACHE_TAG_RAM_WUNIT (`NDS_DCACHE_TAG_RAM_DW),
//:        .DCACHE_DATA_RAM_AW   (`NDS_DCACHE_DATA_RAM_AW),
//:        .DCACHE_DATA_RAM_DW   (`NDS_DCACHE_DATA_RAM_DW),
//:        .DCACHE_DATA_RAM_WEW  (`NDS_DCACHE_DATA_RAM_BWEW),
//:        .DCACHE_DATA_RAM_WUNIT(8),
//:        .DCACHE_ECC_TYPE      (`NDS_DCACHE_ECC_TYPE),
//:        .DCACHE_TAG_ECCW      (0),      // ECC is not handled in mem wrapper
//:        .DCACHE_DATA_ECCW     (0),		// FIXME: ECC is not supported yet
//:	   `ifdef NDS_IO_CLUSTER
//:	   // DCACHE WPT RAM
//:        .DCACHE_WPT_RAM_AW   (`NDS_DCACHE_WPT_RAM_AW),
//:        .DCACHE_WPT_RAM_DW   (`NDS_DCACHE_WPT_RAM_DW),
//:        .DCACHE_WPT_RAM_WEW  (`NDS_DCACHE_WPT_RAM_BWEW),
//:        .DCACHE_WPT_RAM_WUNIT(8),
//:        .DCACHE_WPT_ECCW     (0),     
//:	   `endif // NDS_IO_CLUSTER
//:#       // DTAG
//:#       // ECC handled by core
//:#       .DTAG_WAY      (`NDS_DCACHE_WAY),
//:#       .DTAG_RAM_AW   (`NDS_DTAG_TAG_RAM_AW),
//:#       .DTAG_RAM_DW   (`NDS_DTAG_TAG_RAM_DW),
//:#       .DTAG_RAM_WEW  (`NDS_DTAG_TAG_RAM_DW),
//:#       .DTAG_RAM_WUNIT(1),
//:#       .DTAG_ECC_TYPE (`NDS_DCACHE_ECC_TYPE),
//:#       .DTAG_ECCW     (0),     // ECC is not handled in mem wrapper
//:        .STLB_WAY      (4),
//:        .STLB_RAM_AW   (`NDS_STLB_RAM_AW),
//:        .STLB_RAM_DW   (`NDS_STLB_RAM_DW),
//:        .STLB_TAG_RAM_DW   (`NDS_STLB_TAG_RAM_DW),
//:        .STLB_DATA_RAM_DW   (`NDS_STLB_DATA_RAM_DW),
//:        .STLB_RAM_WEW  (1),
//:        .STLB_RAM_WUNIT(`NDS_STLB_RAM_DW),
//:        .STLB_TAG_RAM_WUNIT(`NDS_STLB_TAG_RAM_DW),
//:        .STLB_DATA_RAM_WUNIT(`NDS_STLB_DATA_RAM_DW),
//:        .STLB_ECC_TYPE  (`NDS_STLB_ECC_TYPE)
//:) core${i}_mem_checker (.clk(core_clk), .ilm_clk(ilm_clk), .dlm_clk(dlm_clk), .*);
//:always @(`NDS_CORE${i}_TOP.core${i}_mem_checker.e_fail) flg_fail = 1;
//:initial force `NDS_CORE${i}_TOP.`NDS_CORE_NAME.core_reset_n = 1'b0;
//:initial begin
//:	force `NDS_CORE${i}_TOP.`NDS_CORE_NAME.lm_reset_n = 1'b0;
//:	#1;
//:	force `NDS_CORE${i}_TOP.`NDS_CORE_NAME.lm_reset_n = 1'b1;
//:end	
// if ($i != 0) {
//:`endif // NDS_IO_HART${i}
// }
// }
//:
// VPERL_END

// VPERL_GENERATED_BEGIN
bind `NDS_CORE0_TOP core_mem_checker #(
       .ISA_BASE (`NDS_ISA_BASE),
       // LM INTERFACE
       .LM_INTERFACE (`NDS_LM_INTERFACE),
       // ILM
       // ECC handled by wrapper
       .ILM_RAM_AW   (`NDS_ILM_RAM_AW),
       .ILM_RAM_DW   (`NDS_ILM_RAM_DW),
       .ILM_RAM_WEW  (`NDS_ILM_RAM_BWEW),
       .ILM_RAM_WUNIT(8),
       .ILM_ECC_TYPE (`NDS_ILM_ECC_TYPE),
       .ILM_ECCW     (0),		// FIXME: ECC is not supported yet
       .ILM_WAIT_CYCLE (`NDS_ILM_WAIT_CYCLE),
       // DLM
       .NUM_DLM_BANKS(`NDS_NUM_DLM_BANKS),
       // ECC handled by wrapper
       .DLM_RAM_AW   (`NDS_DLM_RAM_AW),
       .DLM_RAM_DW   (`NDS_DLM_RAM_DW),
       .DLM_RAM_WEW  (`NDS_DLM_RAM_BWEW),
       .DLM_RAM_WUNIT(8),
       .DLM_ECC_TYPE (`NDS_DLM_ECC_TYPE),
       .DLM_ECCW     (0),		// FIXME: ECC is not supported yet
       .DLM_WAIT_CYCLE (`NDS_DLM_WAIT_CYCLE),
       // BTB (No ECC)
       .BTB_BANK     (2),
       .BTB_RAM_AW   (`NDS_BTB_RAM_ADDR_WIDTH),
       .BTB_RAM_DW   (`NDS_BTB_RAM_DATA_WIDTH),
       .BTB_RAM_WEW  (1),
       .BTB_RAM_WUNIT(`NDS_BTB_RAM_DATA_WIDTH),
       // ICACHE
       // Tag:  ECC handled by core
       // Data: ECC handled by core
       .ICACHE_WAY           (`NDS_ICACHE_WAY),
       .ICACHE_TAG_RAM_AW    (`NDS_ICACHE_TAG_RAM_AW),
       .ICACHE_TAG_RAM_DW    (`NDS_ICACHE_TAG_RAM_DW),
       .ICACHE_TAG_RAM_WEW   (1),
       .ICACHE_TAG_RAM_WUNIT (`NDS_ICACHE_TAG_RAM_DW),
       .ICACHE_DATA_RAM_AW   (`NDS_ICACHE_DATA_RAM_AW),
       .ICACHE_DATA_RAM_DW   (`NDS_ICACHE_DATA_RAM_DW),
       .ICACHE_DATA_RAM_WEW  (1),
       .ICACHE_DATA_RAM_WUNIT(`NDS_ICACHE_DATA_RAM_DW),
       .ICACHE_ECC_TYPE      (`NDS_ICACHE_ECC_TYPE),
       .ICACHE_TAG_ECCW      (0),
       .ICACHE_DATA_ECCW     (0),
       // DCACHE
       // Tag:  ECC handled by core
       // Data: ECC handled by wrapper
       .DCACHE_WAY           (`NDS_DCACHE_WAY),
       .DCACHE_TAG_RAM_AW    (`NDS_DCACHE_TAG_RAM_AW),
       .DCACHE_TAG_RAM_DW    (`NDS_DCACHE_TAG_RAM_DW),
       .DCACHE_TAG_RAM_WEW   (1			),
       .DCACHE_TAG_RAM_WUNIT (`NDS_DCACHE_TAG_RAM_DW),
       .DCACHE_DATA_RAM_AW   (`NDS_DCACHE_DATA_RAM_AW),
       .DCACHE_DATA_RAM_DW   (`NDS_DCACHE_DATA_RAM_DW),
       .DCACHE_DATA_RAM_WEW  (`NDS_DCACHE_DATA_RAM_BWEW),
       .DCACHE_DATA_RAM_WUNIT(8),
       .DCACHE_ECC_TYPE      (`NDS_DCACHE_ECC_TYPE),
       .DCACHE_TAG_ECCW      (0),      // ECC is not handled in mem wrapper
       .DCACHE_DATA_ECCW     (0),		// FIXME: ECC is not supported yet
	   `ifdef NDS_IO_CLUSTER
	   // DCACHE WPT RAM
       .DCACHE_WPT_RAM_AW   (`NDS_DCACHE_WPT_RAM_AW),
       .DCACHE_WPT_RAM_DW   (`NDS_DCACHE_WPT_RAM_DW),
       .DCACHE_WPT_RAM_WEW  (`NDS_DCACHE_WPT_RAM_BWEW),
       .DCACHE_WPT_RAM_WUNIT(8),
       .DCACHE_WPT_ECCW     (0),
	   `endif // NDS_IO_CLUSTER









       .STLB_WAY      (4),
       .STLB_RAM_AW   (`NDS_STLB_RAM_AW),
       .STLB_RAM_DW   (`NDS_STLB_RAM_DW),
       .STLB_TAG_RAM_DW   (`NDS_STLB_TAG_RAM_DW),
       .STLB_DATA_RAM_DW   (`NDS_STLB_DATA_RAM_DW),
       .STLB_RAM_WEW  (1),
       .STLB_RAM_WUNIT(`NDS_STLB_RAM_DW),
       .STLB_TAG_RAM_WUNIT(`NDS_STLB_TAG_RAM_DW),
       .STLB_DATA_RAM_WUNIT(`NDS_STLB_DATA_RAM_DW),
       .STLB_ECC_TYPE  (`NDS_STLB_ECC_TYPE)
) core0_mem_checker (.clk(core_clk), .ilm_clk(ilm_clk), .dlm_clk(dlm_clk), .*);
always @(`NDS_CORE0_TOP.core0_mem_checker.e_fail) flg_fail = 1;
initial force `NDS_CORE0_TOP.`NDS_CORE_NAME.core_reset_n = 1'b0;
initial begin
	force `NDS_CORE0_TOP.`NDS_CORE_NAME.lm_reset_n = 1'b0;
	#1;
	force `NDS_CORE0_TOP.`NDS_CORE_NAME.lm_reset_n = 1'b1;
end
`ifdef NDS_IO_HART1
bind `NDS_CORE1_TOP core_mem_checker #(
       .ISA_BASE (`NDS_ISA_BASE),
       // LM INTERFACE
       .LM_INTERFACE (`NDS_LM_INTERFACE),
       // ILM
       // ECC handled by wrapper
       .ILM_RAM_AW   (`NDS_ILM_RAM_AW),
       .ILM_RAM_DW   (`NDS_ILM_RAM_DW),
       .ILM_RAM_WEW  (`NDS_ILM_RAM_BWEW),
       .ILM_RAM_WUNIT(8),
       .ILM_ECC_TYPE (`NDS_ILM_ECC_TYPE),
       .ILM_ECCW     (0),		// FIXME: ECC is not supported yet
       .ILM_WAIT_CYCLE (`NDS_ILM_WAIT_CYCLE),
       // DLM
       .NUM_DLM_BANKS(`NDS_NUM_DLM_BANKS),
       // ECC handled by wrapper
       .DLM_RAM_AW   (`NDS_DLM_RAM_AW),
       .DLM_RAM_DW   (`NDS_DLM_RAM_DW),
       .DLM_RAM_WEW  (`NDS_DLM_RAM_BWEW),
       .DLM_RAM_WUNIT(8),
       .DLM_ECC_TYPE (`NDS_DLM_ECC_TYPE),
       .DLM_ECCW     (0),		// FIXME: ECC is not supported yet
       .DLM_WAIT_CYCLE (`NDS_DLM_WAIT_CYCLE),
       // BTB (No ECC)
       .BTB_BANK     (2),
       .BTB_RAM_AW   (`NDS_BTB_RAM_ADDR_WIDTH),
       .BTB_RAM_DW   (`NDS_BTB_RAM_DATA_WIDTH),
       .BTB_RAM_WEW  (1),
       .BTB_RAM_WUNIT(`NDS_BTB_RAM_DATA_WIDTH),
       // ICACHE
       // Tag:  ECC handled by core
       // Data: ECC handled by core
       .ICACHE_WAY           (`NDS_ICACHE_WAY),
       .ICACHE_TAG_RAM_AW    (`NDS_ICACHE_TAG_RAM_AW),
       .ICACHE_TAG_RAM_DW    (`NDS_ICACHE_TAG_RAM_DW),
       .ICACHE_TAG_RAM_WEW   (1),
       .ICACHE_TAG_RAM_WUNIT (`NDS_ICACHE_TAG_RAM_DW),
       .ICACHE_DATA_RAM_AW   (`NDS_ICACHE_DATA_RAM_AW),
       .ICACHE_DATA_RAM_DW   (`NDS_ICACHE_DATA_RAM_DW),
       .ICACHE_DATA_RAM_WEW  (1),
       .ICACHE_DATA_RAM_WUNIT(`NDS_ICACHE_DATA_RAM_DW),
       .ICACHE_ECC_TYPE      (`NDS_ICACHE_ECC_TYPE),
       .ICACHE_TAG_ECCW      (0),
       .ICACHE_DATA_ECCW     (0),
       // DCACHE
       // Tag:  ECC handled by core
       // Data: ECC handled by wrapper
       .DCACHE_WAY           (`NDS_DCACHE_WAY),
       .DCACHE_TAG_RAM_AW    (`NDS_DCACHE_TAG_RAM_AW),
       .DCACHE_TAG_RAM_DW    (`NDS_DCACHE_TAG_RAM_DW),
       .DCACHE_TAG_RAM_WEW   (1			),
       .DCACHE_TAG_RAM_WUNIT (`NDS_DCACHE_TAG_RAM_DW),
       .DCACHE_DATA_RAM_AW   (`NDS_DCACHE_DATA_RAM_AW),
       .DCACHE_DATA_RAM_DW   (`NDS_DCACHE_DATA_RAM_DW),
       .DCACHE_DATA_RAM_WEW  (`NDS_DCACHE_DATA_RAM_BWEW),
       .DCACHE_DATA_RAM_WUNIT(8),
       .DCACHE_ECC_TYPE      (`NDS_DCACHE_ECC_TYPE),
       .DCACHE_TAG_ECCW      (0),      // ECC is not handled in mem wrapper
       .DCACHE_DATA_ECCW     (0),		// FIXME: ECC is not supported yet
	   `ifdef NDS_IO_CLUSTER
	   // DCACHE WPT RAM
       .DCACHE_WPT_RAM_AW   (`NDS_DCACHE_WPT_RAM_AW),
       .DCACHE_WPT_RAM_DW   (`NDS_DCACHE_WPT_RAM_DW),
       .DCACHE_WPT_RAM_WEW  (`NDS_DCACHE_WPT_RAM_BWEW),
       .DCACHE_WPT_RAM_WUNIT(8),
       .DCACHE_WPT_ECCW     (0),
	   `endif // NDS_IO_CLUSTER









       .STLB_WAY      (4),
       .STLB_RAM_AW   (`NDS_STLB_RAM_AW),
       .STLB_RAM_DW   (`NDS_STLB_RAM_DW),
       .STLB_TAG_RAM_DW   (`NDS_STLB_TAG_RAM_DW),
       .STLB_DATA_RAM_DW   (`NDS_STLB_DATA_RAM_DW),
       .STLB_RAM_WEW  (1),
       .STLB_RAM_WUNIT(`NDS_STLB_RAM_DW),
       .STLB_TAG_RAM_WUNIT(`NDS_STLB_TAG_RAM_DW),
       .STLB_DATA_RAM_WUNIT(`NDS_STLB_DATA_RAM_DW),
       .STLB_ECC_TYPE  (`NDS_STLB_ECC_TYPE)
) core1_mem_checker (.clk(core_clk), .ilm_clk(ilm_clk), .dlm_clk(dlm_clk), .*);
always @(`NDS_CORE1_TOP.core1_mem_checker.e_fail) flg_fail = 1;
initial force `NDS_CORE1_TOP.`NDS_CORE_NAME.core_reset_n = 1'b0;
initial begin
	force `NDS_CORE1_TOP.`NDS_CORE_NAME.lm_reset_n = 1'b0;
	#1;
	force `NDS_CORE1_TOP.`NDS_CORE_NAME.lm_reset_n = 1'b1;
end
`endif // NDS_IO_HART1
`ifdef NDS_IO_HART2
bind `NDS_CORE2_TOP core_mem_checker #(
       .ISA_BASE (`NDS_ISA_BASE),
       // LM INTERFACE
       .LM_INTERFACE (`NDS_LM_INTERFACE),
       // ILM
       // ECC handled by wrapper
       .ILM_RAM_AW   (`NDS_ILM_RAM_AW),
       .ILM_RAM_DW   (`NDS_ILM_RAM_DW),
       .ILM_RAM_WEW  (`NDS_ILM_RAM_BWEW),
       .ILM_RAM_WUNIT(8),
       .ILM_ECC_TYPE (`NDS_ILM_ECC_TYPE),
       .ILM_ECCW     (0),		// FIXME: ECC is not supported yet
       .ILM_WAIT_CYCLE (`NDS_ILM_WAIT_CYCLE),
       // DLM
       .NUM_DLM_BANKS(`NDS_NUM_DLM_BANKS),
       // ECC handled by wrapper
       .DLM_RAM_AW   (`NDS_DLM_RAM_AW),
       .DLM_RAM_DW   (`NDS_DLM_RAM_DW),
       .DLM_RAM_WEW  (`NDS_DLM_RAM_BWEW),
       .DLM_RAM_WUNIT(8),
       .DLM_ECC_TYPE (`NDS_DLM_ECC_TYPE),
       .DLM_ECCW     (0),		// FIXME: ECC is not supported yet
       .DLM_WAIT_CYCLE (`NDS_DLM_WAIT_CYCLE),
       // BTB (No ECC)
       .BTB_BANK     (2),
       .BTB_RAM_AW   (`NDS_BTB_RAM_ADDR_WIDTH),
       .BTB_RAM_DW   (`NDS_BTB_RAM_DATA_WIDTH),
       .BTB_RAM_WEW  (1),
       .BTB_RAM_WUNIT(`NDS_BTB_RAM_DATA_WIDTH),
       // ICACHE
       // Tag:  ECC handled by core
       // Data: ECC handled by core
       .ICACHE_WAY           (`NDS_ICACHE_WAY),
       .ICACHE_TAG_RAM_AW    (`NDS_ICACHE_TAG_RAM_AW),
       .ICACHE_TAG_RAM_DW    (`NDS_ICACHE_TAG_RAM_DW),
       .ICACHE_TAG_RAM_WEW   (1),
       .ICACHE_TAG_RAM_WUNIT (`NDS_ICACHE_TAG_RAM_DW),
       .ICACHE_DATA_RAM_AW   (`NDS_ICACHE_DATA_RAM_AW),
       .ICACHE_DATA_RAM_DW   (`NDS_ICACHE_DATA_RAM_DW),
       .ICACHE_DATA_RAM_WEW  (1),
       .ICACHE_DATA_RAM_WUNIT(`NDS_ICACHE_DATA_RAM_DW),
       .ICACHE_ECC_TYPE      (`NDS_ICACHE_ECC_TYPE),
       .ICACHE_TAG_ECCW      (0),
       .ICACHE_DATA_ECCW     (0),
       // DCACHE
       // Tag:  ECC handled by core
       // Data: ECC handled by wrapper
       .DCACHE_WAY           (`NDS_DCACHE_WAY),
       .DCACHE_TAG_RAM_AW    (`NDS_DCACHE_TAG_RAM_AW),
       .DCACHE_TAG_RAM_DW    (`NDS_DCACHE_TAG_RAM_DW),
       .DCACHE_TAG_RAM_WEW   (1			),
       .DCACHE_TAG_RAM_WUNIT (`NDS_DCACHE_TAG_RAM_DW),
       .DCACHE_DATA_RAM_AW   (`NDS_DCACHE_DATA_RAM_AW),
       .DCACHE_DATA_RAM_DW   (`NDS_DCACHE_DATA_RAM_DW),
       .DCACHE_DATA_RAM_WEW  (`NDS_DCACHE_DATA_RAM_BWEW),
       .DCACHE_DATA_RAM_WUNIT(8),
       .DCACHE_ECC_TYPE      (`NDS_DCACHE_ECC_TYPE),
       .DCACHE_TAG_ECCW      (0),      // ECC is not handled in mem wrapper
       .DCACHE_DATA_ECCW     (0),		// FIXME: ECC is not supported yet
	   `ifdef NDS_IO_CLUSTER
	   // DCACHE WPT RAM
       .DCACHE_WPT_RAM_AW   (`NDS_DCACHE_WPT_RAM_AW),
       .DCACHE_WPT_RAM_DW   (`NDS_DCACHE_WPT_RAM_DW),
       .DCACHE_WPT_RAM_WEW  (`NDS_DCACHE_WPT_RAM_BWEW),
       .DCACHE_WPT_RAM_WUNIT(8),
       .DCACHE_WPT_ECCW     (0),
	   `endif // NDS_IO_CLUSTER









       .STLB_WAY      (4),
       .STLB_RAM_AW   (`NDS_STLB_RAM_AW),
       .STLB_RAM_DW   (`NDS_STLB_RAM_DW),
       .STLB_TAG_RAM_DW   (`NDS_STLB_TAG_RAM_DW),
       .STLB_DATA_RAM_DW   (`NDS_STLB_DATA_RAM_DW),
       .STLB_RAM_WEW  (1),
       .STLB_RAM_WUNIT(`NDS_STLB_RAM_DW),
       .STLB_TAG_RAM_WUNIT(`NDS_STLB_TAG_RAM_DW),
       .STLB_DATA_RAM_WUNIT(`NDS_STLB_DATA_RAM_DW),
       .STLB_ECC_TYPE  (`NDS_STLB_ECC_TYPE)
) core2_mem_checker (.clk(core_clk), .ilm_clk(ilm_clk), .dlm_clk(dlm_clk), .*);
always @(`NDS_CORE2_TOP.core2_mem_checker.e_fail) flg_fail = 1;
initial force `NDS_CORE2_TOP.`NDS_CORE_NAME.core_reset_n = 1'b0;
initial begin
	force `NDS_CORE2_TOP.`NDS_CORE_NAME.lm_reset_n = 1'b0;
	#1;
	force `NDS_CORE2_TOP.`NDS_CORE_NAME.lm_reset_n = 1'b1;
end
`endif // NDS_IO_HART2
`ifdef NDS_IO_HART3
bind `NDS_CORE3_TOP core_mem_checker #(
       .ISA_BASE (`NDS_ISA_BASE),
       // LM INTERFACE
       .LM_INTERFACE (`NDS_LM_INTERFACE),
       // ILM
       // ECC handled by wrapper
       .ILM_RAM_AW   (`NDS_ILM_RAM_AW),
       .ILM_RAM_DW   (`NDS_ILM_RAM_DW),
       .ILM_RAM_WEW  (`NDS_ILM_RAM_BWEW),
       .ILM_RAM_WUNIT(8),
       .ILM_ECC_TYPE (`NDS_ILM_ECC_TYPE),
       .ILM_ECCW     (0),		// FIXME: ECC is not supported yet
       .ILM_WAIT_CYCLE (`NDS_ILM_WAIT_CYCLE),
       // DLM
       .NUM_DLM_BANKS(`NDS_NUM_DLM_BANKS),
       // ECC handled by wrapper
       .DLM_RAM_AW   (`NDS_DLM_RAM_AW),
       .DLM_RAM_DW   (`NDS_DLM_RAM_DW),
       .DLM_RAM_WEW  (`NDS_DLM_RAM_BWEW),
       .DLM_RAM_WUNIT(8),
       .DLM_ECC_TYPE (`NDS_DLM_ECC_TYPE),
       .DLM_ECCW     (0),		// FIXME: ECC is not supported yet
       .DLM_WAIT_CYCLE (`NDS_DLM_WAIT_CYCLE),
       // BTB (No ECC)
       .BTB_BANK     (2),
       .BTB_RAM_AW   (`NDS_BTB_RAM_ADDR_WIDTH),
       .BTB_RAM_DW   (`NDS_BTB_RAM_DATA_WIDTH),
       .BTB_RAM_WEW  (1),
       .BTB_RAM_WUNIT(`NDS_BTB_RAM_DATA_WIDTH),
       // ICACHE
       // Tag:  ECC handled by core
       // Data: ECC handled by core
       .ICACHE_WAY           (`NDS_ICACHE_WAY),
       .ICACHE_TAG_RAM_AW    (`NDS_ICACHE_TAG_RAM_AW),
       .ICACHE_TAG_RAM_DW    (`NDS_ICACHE_TAG_RAM_DW),
       .ICACHE_TAG_RAM_WEW   (1),
       .ICACHE_TAG_RAM_WUNIT (`NDS_ICACHE_TAG_RAM_DW),
       .ICACHE_DATA_RAM_AW   (`NDS_ICACHE_DATA_RAM_AW),
       .ICACHE_DATA_RAM_DW   (`NDS_ICACHE_DATA_RAM_DW),
       .ICACHE_DATA_RAM_WEW  (1),
       .ICACHE_DATA_RAM_WUNIT(`NDS_ICACHE_DATA_RAM_DW),
       .ICACHE_ECC_TYPE      (`NDS_ICACHE_ECC_TYPE),
       .ICACHE_TAG_ECCW      (0),
       .ICACHE_DATA_ECCW     (0),
       // DCACHE
       // Tag:  ECC handled by core
       // Data: ECC handled by wrapper
       .DCACHE_WAY           (`NDS_DCACHE_WAY),
       .DCACHE_TAG_RAM_AW    (`NDS_DCACHE_TAG_RAM_AW),
       .DCACHE_TAG_RAM_DW    (`NDS_DCACHE_TAG_RAM_DW),
       .DCACHE_TAG_RAM_WEW   (1			),
       .DCACHE_TAG_RAM_WUNIT (`NDS_DCACHE_TAG_RAM_DW),
       .DCACHE_DATA_RAM_AW   (`NDS_DCACHE_DATA_RAM_AW),
       .DCACHE_DATA_RAM_DW   (`NDS_DCACHE_DATA_RAM_DW),
       .DCACHE_DATA_RAM_WEW  (`NDS_DCACHE_DATA_RAM_BWEW),
       .DCACHE_DATA_RAM_WUNIT(8),
       .DCACHE_ECC_TYPE      (`NDS_DCACHE_ECC_TYPE),
       .DCACHE_TAG_ECCW      (0),      // ECC is not handled in mem wrapper
       .DCACHE_DATA_ECCW     (0),		// FIXME: ECC is not supported yet
	   `ifdef NDS_IO_CLUSTER
	   // DCACHE WPT RAM
       .DCACHE_WPT_RAM_AW   (`NDS_DCACHE_WPT_RAM_AW),
       .DCACHE_WPT_RAM_DW   (`NDS_DCACHE_WPT_RAM_DW),
       .DCACHE_WPT_RAM_WEW  (`NDS_DCACHE_WPT_RAM_BWEW),
       .DCACHE_WPT_RAM_WUNIT(8),
       .DCACHE_WPT_ECCW     (0),
	   `endif // NDS_IO_CLUSTER









       .STLB_WAY      (4),
       .STLB_RAM_AW   (`NDS_STLB_RAM_AW),
       .STLB_RAM_DW   (`NDS_STLB_RAM_DW),
       .STLB_TAG_RAM_DW   (`NDS_STLB_TAG_RAM_DW),
       .STLB_DATA_RAM_DW   (`NDS_STLB_DATA_RAM_DW),
       .STLB_RAM_WEW  (1),
       .STLB_RAM_WUNIT(`NDS_STLB_RAM_DW),
       .STLB_TAG_RAM_WUNIT(`NDS_STLB_TAG_RAM_DW),
       .STLB_DATA_RAM_WUNIT(`NDS_STLB_DATA_RAM_DW),
       .STLB_ECC_TYPE  (`NDS_STLB_ECC_TYPE)
) core3_mem_checker (.clk(core_clk), .ilm_clk(ilm_clk), .dlm_clk(dlm_clk), .*);
always @(`NDS_CORE3_TOP.core3_mem_checker.e_fail) flg_fail = 1;
initial force `NDS_CORE3_TOP.`NDS_CORE_NAME.core_reset_n = 1'b0;
initial begin
	force `NDS_CORE3_TOP.`NDS_CORE_NAME.lm_reset_n = 1'b0;
	#1;
	force `NDS_CORE3_TOP.`NDS_CORE_NAME.lm_reset_n = 1'b1;
end
`endif // NDS_IO_HART3
`ifdef NDS_IO_HART4
bind `NDS_CORE4_TOP core_mem_checker #(
       .ISA_BASE (`NDS_ISA_BASE),
       // LM INTERFACE
       .LM_INTERFACE (`NDS_LM_INTERFACE),
       // ILM
       // ECC handled by wrapper
       .ILM_RAM_AW   (`NDS_ILM_RAM_AW),
       .ILM_RAM_DW   (`NDS_ILM_RAM_DW),
       .ILM_RAM_WEW  (`NDS_ILM_RAM_BWEW),
       .ILM_RAM_WUNIT(8),
       .ILM_ECC_TYPE (`NDS_ILM_ECC_TYPE),
       .ILM_ECCW     (0),		// FIXME: ECC is not supported yet
       .ILM_WAIT_CYCLE (`NDS_ILM_WAIT_CYCLE),
       // DLM
       .NUM_DLM_BANKS(`NDS_NUM_DLM_BANKS),
       // ECC handled by wrapper
       .DLM_RAM_AW   (`NDS_DLM_RAM_AW),
       .DLM_RAM_DW   (`NDS_DLM_RAM_DW),
       .DLM_RAM_WEW  (`NDS_DLM_RAM_BWEW),
       .DLM_RAM_WUNIT(8),
       .DLM_ECC_TYPE (`NDS_DLM_ECC_TYPE),
       .DLM_ECCW     (0),		// FIXME: ECC is not supported yet
       .DLM_WAIT_CYCLE (`NDS_DLM_WAIT_CYCLE),
       // BTB (No ECC)
       .BTB_BANK     (2),
       .BTB_RAM_AW   (`NDS_BTB_RAM_ADDR_WIDTH),
       .BTB_RAM_DW   (`NDS_BTB_RAM_DATA_WIDTH),
       .BTB_RAM_WEW  (1),
       .BTB_RAM_WUNIT(`NDS_BTB_RAM_DATA_WIDTH),
       // ICACHE
       // Tag:  ECC handled by core
       // Data: ECC handled by core
       .ICACHE_WAY           (`NDS_ICACHE_WAY),
       .ICACHE_TAG_RAM_AW    (`NDS_ICACHE_TAG_RAM_AW),
       .ICACHE_TAG_RAM_DW    (`NDS_ICACHE_TAG_RAM_DW),
       .ICACHE_TAG_RAM_WEW   (1),
       .ICACHE_TAG_RAM_WUNIT (`NDS_ICACHE_TAG_RAM_DW),
       .ICACHE_DATA_RAM_AW   (`NDS_ICACHE_DATA_RAM_AW),
       .ICACHE_DATA_RAM_DW   (`NDS_ICACHE_DATA_RAM_DW),
       .ICACHE_DATA_RAM_WEW  (1),
       .ICACHE_DATA_RAM_WUNIT(`NDS_ICACHE_DATA_RAM_DW),
       .ICACHE_ECC_TYPE      (`NDS_ICACHE_ECC_TYPE),
       .ICACHE_TAG_ECCW      (0),
       .ICACHE_DATA_ECCW     (0),
       // DCACHE
       // Tag:  ECC handled by core
       // Data: ECC handled by wrapper
       .DCACHE_WAY           (`NDS_DCACHE_WAY),
       .DCACHE_TAG_RAM_AW    (`NDS_DCACHE_TAG_RAM_AW),
       .DCACHE_TAG_RAM_DW    (`NDS_DCACHE_TAG_RAM_DW),
       .DCACHE_TAG_RAM_WEW   (1			),
       .DCACHE_TAG_RAM_WUNIT (`NDS_DCACHE_TAG_RAM_DW),
       .DCACHE_DATA_RAM_AW   (`NDS_DCACHE_DATA_RAM_AW),
       .DCACHE_DATA_RAM_DW   (`NDS_DCACHE_DATA_RAM_DW),
       .DCACHE_DATA_RAM_WEW  (`NDS_DCACHE_DATA_RAM_BWEW),
       .DCACHE_DATA_RAM_WUNIT(8),
       .DCACHE_ECC_TYPE      (`NDS_DCACHE_ECC_TYPE),
       .DCACHE_TAG_ECCW      (0),      // ECC is not handled in mem wrapper
       .DCACHE_DATA_ECCW     (0),		// FIXME: ECC is not supported yet
	   `ifdef NDS_IO_CLUSTER
	   // DCACHE WPT RAM
       .DCACHE_WPT_RAM_AW   (`NDS_DCACHE_WPT_RAM_AW),
       .DCACHE_WPT_RAM_DW   (`NDS_DCACHE_WPT_RAM_DW),
       .DCACHE_WPT_RAM_WEW  (`NDS_DCACHE_WPT_RAM_BWEW),
       .DCACHE_WPT_RAM_WUNIT(8),
       .DCACHE_WPT_ECCW     (0),
	   `endif // NDS_IO_CLUSTER









       .STLB_WAY      (4),
       .STLB_RAM_AW   (`NDS_STLB_RAM_AW),
       .STLB_RAM_DW   (`NDS_STLB_RAM_DW),
       .STLB_TAG_RAM_DW   (`NDS_STLB_TAG_RAM_DW),
       .STLB_DATA_RAM_DW   (`NDS_STLB_DATA_RAM_DW),
       .STLB_RAM_WEW  (1),
       .STLB_RAM_WUNIT(`NDS_STLB_RAM_DW),
       .STLB_TAG_RAM_WUNIT(`NDS_STLB_TAG_RAM_DW),
       .STLB_DATA_RAM_WUNIT(`NDS_STLB_DATA_RAM_DW),
       .STLB_ECC_TYPE  (`NDS_STLB_ECC_TYPE)
) core4_mem_checker (.clk(core_clk), .ilm_clk(ilm_clk), .dlm_clk(dlm_clk), .*);
always @(`NDS_CORE4_TOP.core4_mem_checker.e_fail) flg_fail = 1;
initial force `NDS_CORE4_TOP.`NDS_CORE_NAME.core_reset_n = 1'b0;
initial begin
	force `NDS_CORE4_TOP.`NDS_CORE_NAME.lm_reset_n = 1'b0;
	#1;
	force `NDS_CORE4_TOP.`NDS_CORE_NAME.lm_reset_n = 1'b1;
end
`endif // NDS_IO_HART4
`ifdef NDS_IO_HART5
bind `NDS_CORE5_TOP core_mem_checker #(
       .ISA_BASE (`NDS_ISA_BASE),
       // LM INTERFACE
       .LM_INTERFACE (`NDS_LM_INTERFACE),
       // ILM
       // ECC handled by wrapper
       .ILM_RAM_AW   (`NDS_ILM_RAM_AW),
       .ILM_RAM_DW   (`NDS_ILM_RAM_DW),
       .ILM_RAM_WEW  (`NDS_ILM_RAM_BWEW),
       .ILM_RAM_WUNIT(8),
       .ILM_ECC_TYPE (`NDS_ILM_ECC_TYPE),
       .ILM_ECCW     (0),		// FIXME: ECC is not supported yet
       .ILM_WAIT_CYCLE (`NDS_ILM_WAIT_CYCLE),
       // DLM
       .NUM_DLM_BANKS(`NDS_NUM_DLM_BANKS),
       // ECC handled by wrapper
       .DLM_RAM_AW   (`NDS_DLM_RAM_AW),
       .DLM_RAM_DW   (`NDS_DLM_RAM_DW),
       .DLM_RAM_WEW  (`NDS_DLM_RAM_BWEW),
       .DLM_RAM_WUNIT(8),
       .DLM_ECC_TYPE (`NDS_DLM_ECC_TYPE),
       .DLM_ECCW     (0),		// FIXME: ECC is not supported yet
       .DLM_WAIT_CYCLE (`NDS_DLM_WAIT_CYCLE),
       // BTB (No ECC)
       .BTB_BANK     (2),
       .BTB_RAM_AW   (`NDS_BTB_RAM_ADDR_WIDTH),
       .BTB_RAM_DW   (`NDS_BTB_RAM_DATA_WIDTH),
       .BTB_RAM_WEW  (1),
       .BTB_RAM_WUNIT(`NDS_BTB_RAM_DATA_WIDTH),
       // ICACHE
       // Tag:  ECC handled by core
       // Data: ECC handled by core
       .ICACHE_WAY           (`NDS_ICACHE_WAY),
       .ICACHE_TAG_RAM_AW    (`NDS_ICACHE_TAG_RAM_AW),
       .ICACHE_TAG_RAM_DW    (`NDS_ICACHE_TAG_RAM_DW),
       .ICACHE_TAG_RAM_WEW   (1),
       .ICACHE_TAG_RAM_WUNIT (`NDS_ICACHE_TAG_RAM_DW),
       .ICACHE_DATA_RAM_AW   (`NDS_ICACHE_DATA_RAM_AW),
       .ICACHE_DATA_RAM_DW   (`NDS_ICACHE_DATA_RAM_DW),
       .ICACHE_DATA_RAM_WEW  (1),
       .ICACHE_DATA_RAM_WUNIT(`NDS_ICACHE_DATA_RAM_DW),
       .ICACHE_ECC_TYPE      (`NDS_ICACHE_ECC_TYPE),
       .ICACHE_TAG_ECCW      (0),
       .ICACHE_DATA_ECCW     (0),
       // DCACHE
       // Tag:  ECC handled by core
       // Data: ECC handled by wrapper
       .DCACHE_WAY           (`NDS_DCACHE_WAY),
       .DCACHE_TAG_RAM_AW    (`NDS_DCACHE_TAG_RAM_AW),
       .DCACHE_TAG_RAM_DW    (`NDS_DCACHE_TAG_RAM_DW),
       .DCACHE_TAG_RAM_WEW   (1			),
       .DCACHE_TAG_RAM_WUNIT (`NDS_DCACHE_TAG_RAM_DW),
       .DCACHE_DATA_RAM_AW   (`NDS_DCACHE_DATA_RAM_AW),
       .DCACHE_DATA_RAM_DW   (`NDS_DCACHE_DATA_RAM_DW),
       .DCACHE_DATA_RAM_WEW  (`NDS_DCACHE_DATA_RAM_BWEW),
       .DCACHE_DATA_RAM_WUNIT(8),
       .DCACHE_ECC_TYPE      (`NDS_DCACHE_ECC_TYPE),
       .DCACHE_TAG_ECCW      (0),      // ECC is not handled in mem wrapper
       .DCACHE_DATA_ECCW     (0),		// FIXME: ECC is not supported yet
	   `ifdef NDS_IO_CLUSTER
	   // DCACHE WPT RAM
       .DCACHE_WPT_RAM_AW   (`NDS_DCACHE_WPT_RAM_AW),
       .DCACHE_WPT_RAM_DW   (`NDS_DCACHE_WPT_RAM_DW),
       .DCACHE_WPT_RAM_WEW  (`NDS_DCACHE_WPT_RAM_BWEW),
       .DCACHE_WPT_RAM_WUNIT(8),
       .DCACHE_WPT_ECCW     (0),
	   `endif // NDS_IO_CLUSTER









       .STLB_WAY      (4),
       .STLB_RAM_AW   (`NDS_STLB_RAM_AW),
       .STLB_RAM_DW   (`NDS_STLB_RAM_DW),
       .STLB_TAG_RAM_DW   (`NDS_STLB_TAG_RAM_DW),
       .STLB_DATA_RAM_DW   (`NDS_STLB_DATA_RAM_DW),
       .STLB_RAM_WEW  (1),
       .STLB_RAM_WUNIT(`NDS_STLB_RAM_DW),
       .STLB_TAG_RAM_WUNIT(`NDS_STLB_TAG_RAM_DW),
       .STLB_DATA_RAM_WUNIT(`NDS_STLB_DATA_RAM_DW),
       .STLB_ECC_TYPE  (`NDS_STLB_ECC_TYPE)
) core5_mem_checker (.clk(core_clk), .ilm_clk(ilm_clk), .dlm_clk(dlm_clk), .*);
always @(`NDS_CORE5_TOP.core5_mem_checker.e_fail) flg_fail = 1;
initial force `NDS_CORE5_TOP.`NDS_CORE_NAME.core_reset_n = 1'b0;
initial begin
	force `NDS_CORE5_TOP.`NDS_CORE_NAME.lm_reset_n = 1'b0;
	#1;
	force `NDS_CORE5_TOP.`NDS_CORE_NAME.lm_reset_n = 1'b1;
end
`endif // NDS_IO_HART5
`ifdef NDS_IO_HART6
bind `NDS_CORE6_TOP core_mem_checker #(
       .ISA_BASE (`NDS_ISA_BASE),
       // LM INTERFACE
       .LM_INTERFACE (`NDS_LM_INTERFACE),
       // ILM
       // ECC handled by wrapper
       .ILM_RAM_AW   (`NDS_ILM_RAM_AW),
       .ILM_RAM_DW   (`NDS_ILM_RAM_DW),
       .ILM_RAM_WEW  (`NDS_ILM_RAM_BWEW),
       .ILM_RAM_WUNIT(8),
       .ILM_ECC_TYPE (`NDS_ILM_ECC_TYPE),
       .ILM_ECCW     (0),		// FIXME: ECC is not supported yet
       .ILM_WAIT_CYCLE (`NDS_ILM_WAIT_CYCLE),
       // DLM
       .NUM_DLM_BANKS(`NDS_NUM_DLM_BANKS),
       // ECC handled by wrapper
       .DLM_RAM_AW   (`NDS_DLM_RAM_AW),
       .DLM_RAM_DW   (`NDS_DLM_RAM_DW),
       .DLM_RAM_WEW  (`NDS_DLM_RAM_BWEW),
       .DLM_RAM_WUNIT(8),
       .DLM_ECC_TYPE (`NDS_DLM_ECC_TYPE),
       .DLM_ECCW     (0),		// FIXME: ECC is not supported yet
       .DLM_WAIT_CYCLE (`NDS_DLM_WAIT_CYCLE),
       // BTB (No ECC)
       .BTB_BANK     (2),
       .BTB_RAM_AW   (`NDS_BTB_RAM_ADDR_WIDTH),
       .BTB_RAM_DW   (`NDS_BTB_RAM_DATA_WIDTH),
       .BTB_RAM_WEW  (1),
       .BTB_RAM_WUNIT(`NDS_BTB_RAM_DATA_WIDTH),
       // ICACHE
       // Tag:  ECC handled by core
       // Data: ECC handled by core
       .ICACHE_WAY           (`NDS_ICACHE_WAY),
       .ICACHE_TAG_RAM_AW    (`NDS_ICACHE_TAG_RAM_AW),
       .ICACHE_TAG_RAM_DW    (`NDS_ICACHE_TAG_RAM_DW),
       .ICACHE_TAG_RAM_WEW   (1),
       .ICACHE_TAG_RAM_WUNIT (`NDS_ICACHE_TAG_RAM_DW),
       .ICACHE_DATA_RAM_AW   (`NDS_ICACHE_DATA_RAM_AW),
       .ICACHE_DATA_RAM_DW   (`NDS_ICACHE_DATA_RAM_DW),
       .ICACHE_DATA_RAM_WEW  (1),
       .ICACHE_DATA_RAM_WUNIT(`NDS_ICACHE_DATA_RAM_DW),
       .ICACHE_ECC_TYPE      (`NDS_ICACHE_ECC_TYPE),
       .ICACHE_TAG_ECCW      (0),
       .ICACHE_DATA_ECCW     (0),
       // DCACHE
       // Tag:  ECC handled by core
       // Data: ECC handled by wrapper
       .DCACHE_WAY           (`NDS_DCACHE_WAY),
       .DCACHE_TAG_RAM_AW    (`NDS_DCACHE_TAG_RAM_AW),
       .DCACHE_TAG_RAM_DW    (`NDS_DCACHE_TAG_RAM_DW),
       .DCACHE_TAG_RAM_WEW   (1			),
       .DCACHE_TAG_RAM_WUNIT (`NDS_DCACHE_TAG_RAM_DW),
       .DCACHE_DATA_RAM_AW   (`NDS_DCACHE_DATA_RAM_AW),
       .DCACHE_DATA_RAM_DW   (`NDS_DCACHE_DATA_RAM_DW),
       .DCACHE_DATA_RAM_WEW  (`NDS_DCACHE_DATA_RAM_BWEW),
       .DCACHE_DATA_RAM_WUNIT(8),
       .DCACHE_ECC_TYPE      (`NDS_DCACHE_ECC_TYPE),
       .DCACHE_TAG_ECCW      (0),      // ECC is not handled in mem wrapper
       .DCACHE_DATA_ECCW     (0),		// FIXME: ECC is not supported yet
	   `ifdef NDS_IO_CLUSTER
	   // DCACHE WPT RAM
       .DCACHE_WPT_RAM_AW   (`NDS_DCACHE_WPT_RAM_AW),
       .DCACHE_WPT_RAM_DW   (`NDS_DCACHE_WPT_RAM_DW),
       .DCACHE_WPT_RAM_WEW  (`NDS_DCACHE_WPT_RAM_BWEW),
       .DCACHE_WPT_RAM_WUNIT(8),
       .DCACHE_WPT_ECCW     (0),
	   `endif // NDS_IO_CLUSTER









       .STLB_WAY      (4),
       .STLB_RAM_AW   (`NDS_STLB_RAM_AW),
       .STLB_RAM_DW   (`NDS_STLB_RAM_DW),
       .STLB_TAG_RAM_DW   (`NDS_STLB_TAG_RAM_DW),
       .STLB_DATA_RAM_DW   (`NDS_STLB_DATA_RAM_DW),
       .STLB_RAM_WEW  (1),
       .STLB_RAM_WUNIT(`NDS_STLB_RAM_DW),
       .STLB_TAG_RAM_WUNIT(`NDS_STLB_TAG_RAM_DW),
       .STLB_DATA_RAM_WUNIT(`NDS_STLB_DATA_RAM_DW),
       .STLB_ECC_TYPE  (`NDS_STLB_ECC_TYPE)
) core6_mem_checker (.clk(core_clk), .ilm_clk(ilm_clk), .dlm_clk(dlm_clk), .*);
always @(`NDS_CORE6_TOP.core6_mem_checker.e_fail) flg_fail = 1;
initial force `NDS_CORE6_TOP.`NDS_CORE_NAME.core_reset_n = 1'b0;
initial begin
	force `NDS_CORE6_TOP.`NDS_CORE_NAME.lm_reset_n = 1'b0;
	#1;
	force `NDS_CORE6_TOP.`NDS_CORE_NAME.lm_reset_n = 1'b1;
end
`endif // NDS_IO_HART6
`ifdef NDS_IO_HART7
bind `NDS_CORE7_TOP core_mem_checker #(
       .ISA_BASE (`NDS_ISA_BASE),
       // LM INTERFACE
       .LM_INTERFACE (`NDS_LM_INTERFACE),
       // ILM
       // ECC handled by wrapper
       .ILM_RAM_AW   (`NDS_ILM_RAM_AW),
       .ILM_RAM_DW   (`NDS_ILM_RAM_DW),
       .ILM_RAM_WEW  (`NDS_ILM_RAM_BWEW),
       .ILM_RAM_WUNIT(8),
       .ILM_ECC_TYPE (`NDS_ILM_ECC_TYPE),
       .ILM_ECCW     (0),		// FIXME: ECC is not supported yet
       .ILM_WAIT_CYCLE (`NDS_ILM_WAIT_CYCLE),
       // DLM
       .NUM_DLM_BANKS(`NDS_NUM_DLM_BANKS),
       // ECC handled by wrapper
       .DLM_RAM_AW   (`NDS_DLM_RAM_AW),
       .DLM_RAM_DW   (`NDS_DLM_RAM_DW),
       .DLM_RAM_WEW  (`NDS_DLM_RAM_BWEW),
       .DLM_RAM_WUNIT(8),
       .DLM_ECC_TYPE (`NDS_DLM_ECC_TYPE),
       .DLM_ECCW     (0),		// FIXME: ECC is not supported yet
       .DLM_WAIT_CYCLE (`NDS_DLM_WAIT_CYCLE),
       // BTB (No ECC)
       .BTB_BANK     (2),
       .BTB_RAM_AW   (`NDS_BTB_RAM_ADDR_WIDTH),
       .BTB_RAM_DW   (`NDS_BTB_RAM_DATA_WIDTH),
       .BTB_RAM_WEW  (1),
       .BTB_RAM_WUNIT(`NDS_BTB_RAM_DATA_WIDTH),
       // ICACHE
       // Tag:  ECC handled by core
       // Data: ECC handled by core
       .ICACHE_WAY           (`NDS_ICACHE_WAY),
       .ICACHE_TAG_RAM_AW    (`NDS_ICACHE_TAG_RAM_AW),
       .ICACHE_TAG_RAM_DW    (`NDS_ICACHE_TAG_RAM_DW),
       .ICACHE_TAG_RAM_WEW   (1),
       .ICACHE_TAG_RAM_WUNIT (`NDS_ICACHE_TAG_RAM_DW),
       .ICACHE_DATA_RAM_AW   (`NDS_ICACHE_DATA_RAM_AW),
       .ICACHE_DATA_RAM_DW   (`NDS_ICACHE_DATA_RAM_DW),
       .ICACHE_DATA_RAM_WEW  (1),
       .ICACHE_DATA_RAM_WUNIT(`NDS_ICACHE_DATA_RAM_DW),
       .ICACHE_ECC_TYPE      (`NDS_ICACHE_ECC_TYPE),
       .ICACHE_TAG_ECCW      (0),
       .ICACHE_DATA_ECCW     (0),
       // DCACHE
       // Tag:  ECC handled by core
       // Data: ECC handled by wrapper
       .DCACHE_WAY           (`NDS_DCACHE_WAY),
       .DCACHE_TAG_RAM_AW    (`NDS_DCACHE_TAG_RAM_AW),
       .DCACHE_TAG_RAM_DW    (`NDS_DCACHE_TAG_RAM_DW),
       .DCACHE_TAG_RAM_WEW   (1			),
       .DCACHE_TAG_RAM_WUNIT (`NDS_DCACHE_TAG_RAM_DW),
       .DCACHE_DATA_RAM_AW   (`NDS_DCACHE_DATA_RAM_AW),
       .DCACHE_DATA_RAM_DW   (`NDS_DCACHE_DATA_RAM_DW),
       .DCACHE_DATA_RAM_WEW  (`NDS_DCACHE_DATA_RAM_BWEW),
       .DCACHE_DATA_RAM_WUNIT(8),
       .DCACHE_ECC_TYPE      (`NDS_DCACHE_ECC_TYPE),
       .DCACHE_TAG_ECCW      (0),      // ECC is not handled in mem wrapper
       .DCACHE_DATA_ECCW     (0),		// FIXME: ECC is not supported yet
	   `ifdef NDS_IO_CLUSTER
	   // DCACHE WPT RAM
       .DCACHE_WPT_RAM_AW   (`NDS_DCACHE_WPT_RAM_AW),
       .DCACHE_WPT_RAM_DW   (`NDS_DCACHE_WPT_RAM_DW),
       .DCACHE_WPT_RAM_WEW  (`NDS_DCACHE_WPT_RAM_BWEW),
       .DCACHE_WPT_RAM_WUNIT(8),
       .DCACHE_WPT_ECCW     (0),
	   `endif // NDS_IO_CLUSTER









       .STLB_WAY      (4),
       .STLB_RAM_AW   (`NDS_STLB_RAM_AW),
       .STLB_RAM_DW   (`NDS_STLB_RAM_DW),
       .STLB_TAG_RAM_DW   (`NDS_STLB_TAG_RAM_DW),
       .STLB_DATA_RAM_DW   (`NDS_STLB_DATA_RAM_DW),
       .STLB_RAM_WEW  (1),
       .STLB_RAM_WUNIT(`NDS_STLB_RAM_DW),
       .STLB_TAG_RAM_WUNIT(`NDS_STLB_TAG_RAM_DW),
       .STLB_DATA_RAM_WUNIT(`NDS_STLB_DATA_RAM_DW),
       .STLB_ECC_TYPE  (`NDS_STLB_ECC_TYPE)
) core7_mem_checker (.clk(core_clk), .ilm_clk(ilm_clk), .dlm_clk(dlm_clk), .*);
always @(`NDS_CORE7_TOP.core7_mem_checker.e_fail) flg_fail = 1;
initial force `NDS_CORE7_TOP.`NDS_CORE_NAME.core_reset_n = 1'b0;
initial begin
	force `NDS_CORE7_TOP.`NDS_CORE_NAME.lm_reset_n = 1'b0;
	#1;
	force `NDS_CORE7_TOP.`NDS_CORE_NAME.lm_reset_n = 1'b1;
end
`endif // NDS_IO_HART7

// VPERL_GENERATED_END

`ifdef NDS_IO_ILM_TL_UL
bind `NDS_CPU_SUBSYSTEM ext_lm_mem_checker #(
	.LM_INTERFACE	(`NDS_LM_INTERFACE),
	.ILM_RAM_AW	(`NDS_CPU_SUBSYSTEM.ILM_TL_UL_RAM_AW),
	.ILM_RAM_DW	(`NDS_CPU_SUBSYSTEM.ILM_TL_UL_RAM_DW),
	.ILM_RAM_WEW	(`NDS_CPU_SUBSYSTEM.ILM_TL_UL_RAM_BWEW),
        .ILM_RAM_WUNIT	(8),
	.ILM_ECC_TYPE	(`NDS_ILM_ECC_TYPE),
	.ILM_ECCW	(0),		// FIXME: ECC is not supported yet
	.ILM_WAIT_CYCLE (`NDS_ILM_WAIT_CYCLE),
	.ILM_TL_UL_RAM_NUM (`NDS_CPU_SUBSYSTEM.ILM_TL_UL_RAM_NUM)
) ext_ilm_mem_checker (.*);

always @(`NDS_CPU_SUBSYSTEM.ext_ilm_mem_checker.e_fail) flg_fail = 1;
`endif // NDS_IO_ILM_TL_UL


`ifdef NDS_IO_DLM_TL_UL
	`ifdef NDS_NHART
		bind `NDS_CPU_SUBSYSTEM ext_dlm_mem_checker #(
			.LM_INTERFACE	(`NDS_LM_INTERFACE),
			.DLM_RAM_AW	(`NDS_CPU_SUBSYSTEM.u_core0_dlm_ram0.DLM_RAM_AW),
			.DLM_RAM_DW	(`NDS_CPU_SUBSYSTEM.u_core0_dlm_ram0.DLM_RAM_DW),
			.DLM_RAM_WEW	(`NDS_CPU_SUBSYSTEM.u_core0_dlm_ram0.DLM_RAM_BWEW),
		        .DLM_RAM_WUNIT	(8),
			.DLM_ECC_TYPE	(`NDS_DLM_ECC_TYPE),
			.DLM_ECCW	(0),		// FIXME: ECC is not supported yet
			.DLM_WAIT_CYCLE (`NDS_DLM_WAIT_CYCLE),
			.DLM_TL_UL_RAM_NUM (`NDS_NHART)
		) ext_dlm_mem_checker ();
		always @(`NDS_CPU_SUBSYSTEM.ext_dlm_mem_checker.e_fail) flg_fail = 1;
	`else // NHART
		bind `NDS_CPU_SUBSYSTEM ext_dlm_mem_checker #(
			.LM_INTERFACE	(`NDS_LM_INTERFACE),
			.DLM_RAM_AW	(`NDS_CPU_SUBSYSTEM.u_dlm_ram0.DLM_RAM_AW),
			.DLM_RAM_DW	(`NDS_CPU_SUBSYSTEM.u_dlm_ram0.DLM_RAM_DW),
			.DLM_RAM_WEW	(`NDS_CPU_SUBSYSTEM.u_dlm_ram0.DLM_RAM_BWEW),
		        .DLM_RAM_WUNIT	(8),
			.DLM_ECC_TYPE	(`NDS_DLM_ECC_TYPE),
			.DLM_ECCW	(0),		// FIXME: ECC is not supported yet
			.DLM_WAIT_CYCLE (`NDS_DLM_WAIT_CYCLE),
			.DLM_TL_UL_RAM_NUM (1)
		) ext_dlm_mem_checker ();
		always @(`NDS_CPU_SUBSYSTEM.ext_dlm_mem_checker.e_fail) flg_fail = 1;
	`endif
`endif // NDS_IO_DLM_TL_UL

`ifdef NDS_IO_CLUSTER
bind `NDS_CLUSTER_TOP l2c_mem_checker #(
       .L2C_CACHE_SIZE_KB (`NDS_L2C_CACHE_SIZE_KB),
       .L2C_TAG_RAM_INSTS (`NDS_L2C_BANK_TAG_RAM_INSTS),
       .L2C_TAG_RAM_AW    (`NDS_L2C_TAG_RAM_AW),
       .L2C_TAG_RAM_DW    (`NDS_L2C_TAG_RAM_DW),
       .L2C_TAG_RAM_WEW   (1),
       .L2C_TAG_RAM_WUNIT (`NDS_L2C_TAG_RAM_DW),
       .L2C_DATA_RAM_INSTS(`NDS_L2C_BANK_DATA_RAM_INSTS),
       .L2C_DATA_RAM_AW   (`NDS_L2C_DATA_RAM_AW),
       .L2C_DATA_RAM_DW   (`NDS_L2C_DATA_RAM_DW),
       .L2C_DATA_RAM_BWEW (`NDS_L2C_DATA_RAM_BWEW),
       .L2C_DATA_RAM_WUNIT(8)
) l2c_mem_checker (.*);

always @(`NDS_CLUSTER_TOP.l2c_mem_checker.e_fail) flg_fail = 1;
`endif // NDS_IO_CLUSTER

// Bind a default program to finish the simulation when there is no mem instance
dummy_program dummy_program(.*);

initial begin
        flg_fail = 0;
end

final begin
        if (flg_fail) 
                $display("%0t:%m: ---- SIMULATION FAILED ----", $time);
        else 
                $display("%0t:%m: ---- SIMULATION PASSED ----", $time);
end
