generate
// VPERL_BEGIN
// for (0..7) {
//:if ((NHART > ${_}) && (MMU_SCHEME != "bare")) begin: gen_hart${_}_dtlb_miss
//:	always @ (posedge `NDS_CORE${_}_TOP.core_clk)
//:		if (!`NDS_CORE${_}_TOP.core_reset_n) begin
//:			release `NDS_CORE${_}_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_req;
//:			release `NDS_CORE${_}_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_mode_flush_all;
//:		end
//:		else if((\$urandom_range(0, 9) != 0) && `NDS_CORE${_}_TOP.a45_core.kv_core.kv_dtlb.dtlb_miss_resp) begin
//:			force `NDS_CORE${_}_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_req = 1'b1;
//:			force `NDS_CORE${_}_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_mode_flush_all = 1'b1;
//:		end
//:		else begin
//:			release `NDS_CORE${_}_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_req;
//:			release `NDS_CORE${_}_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_mode_flush_all;
//:		end
//:end
//}
// VPERL_END

// VPERL_GENERATED_BEGIN
if ((NHART > 0) && (MMU_SCHEME != "bare")) begin: gen_hart0_dtlb_miss
	always @ (posedge `NDS_CORE0_TOP.core_clk)
		if (!`NDS_CORE0_TOP.core_reset_n) begin
			release `NDS_CORE0_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_req;
			release `NDS_CORE0_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_mode_flush_all;
		end
		else if(($urandom_range(0, 9) != 0) && `NDS_CORE0_TOP.a45_core.kv_core.kv_dtlb.dtlb_miss_resp) begin
			force `NDS_CORE0_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_req = 1'b1;
			force `NDS_CORE0_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_mode_flush_all = 1'b1;
		end
		else begin
			release `NDS_CORE0_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_req;
			release `NDS_CORE0_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_mode_flush_all;
		end
end
if ((NHART > 1) && (MMU_SCHEME != "bare")) begin: gen_hart1_dtlb_miss
	always @ (posedge `NDS_CORE1_TOP.core_clk)
		if (!`NDS_CORE1_TOP.core_reset_n) begin
			release `NDS_CORE1_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_req;
			release `NDS_CORE1_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_mode_flush_all;
		end
		else if(($urandom_range(0, 9) != 0) && `NDS_CORE1_TOP.a45_core.kv_core.kv_dtlb.dtlb_miss_resp) begin
			force `NDS_CORE1_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_req = 1'b1;
			force `NDS_CORE1_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_mode_flush_all = 1'b1;
		end
		else begin
			release `NDS_CORE1_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_req;
			release `NDS_CORE1_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_mode_flush_all;
		end
end
if ((NHART > 2) && (MMU_SCHEME != "bare")) begin: gen_hart2_dtlb_miss
	always @ (posedge `NDS_CORE2_TOP.core_clk)
		if (!`NDS_CORE2_TOP.core_reset_n) begin
			release `NDS_CORE2_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_req;
			release `NDS_CORE2_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_mode_flush_all;
		end
		else if(($urandom_range(0, 9) != 0) && `NDS_CORE2_TOP.a45_core.kv_core.kv_dtlb.dtlb_miss_resp) begin
			force `NDS_CORE2_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_req = 1'b1;
			force `NDS_CORE2_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_mode_flush_all = 1'b1;
		end
		else begin
			release `NDS_CORE2_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_req;
			release `NDS_CORE2_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_mode_flush_all;
		end
end
if ((NHART > 3) && (MMU_SCHEME != "bare")) begin: gen_hart3_dtlb_miss
	always @ (posedge `NDS_CORE3_TOP.core_clk)
		if (!`NDS_CORE3_TOP.core_reset_n) begin
			release `NDS_CORE3_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_req;
			release `NDS_CORE3_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_mode_flush_all;
		end
		else if(($urandom_range(0, 9) != 0) && `NDS_CORE3_TOP.a45_core.kv_core.kv_dtlb.dtlb_miss_resp) begin
			force `NDS_CORE3_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_req = 1'b1;
			force `NDS_CORE3_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_mode_flush_all = 1'b1;
		end
		else begin
			release `NDS_CORE3_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_req;
			release `NDS_CORE3_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_mode_flush_all;
		end
end
if ((NHART > 4) && (MMU_SCHEME != "bare")) begin: gen_hart4_dtlb_miss
	always @ (posedge `NDS_CORE4_TOP.core_clk)
		if (!`NDS_CORE4_TOP.core_reset_n) begin
			release `NDS_CORE4_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_req;
			release `NDS_CORE4_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_mode_flush_all;
		end
		else if(($urandom_range(0, 9) != 0) && `NDS_CORE4_TOP.a45_core.kv_core.kv_dtlb.dtlb_miss_resp) begin
			force `NDS_CORE4_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_req = 1'b1;
			force `NDS_CORE4_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_mode_flush_all = 1'b1;
		end
		else begin
			release `NDS_CORE4_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_req;
			release `NDS_CORE4_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_mode_flush_all;
		end
end
if ((NHART > 5) && (MMU_SCHEME != "bare")) begin: gen_hart5_dtlb_miss
	always @ (posedge `NDS_CORE5_TOP.core_clk)
		if (!`NDS_CORE5_TOP.core_reset_n) begin
			release `NDS_CORE5_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_req;
			release `NDS_CORE5_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_mode_flush_all;
		end
		else if(($urandom_range(0, 9) != 0) && `NDS_CORE5_TOP.a45_core.kv_core.kv_dtlb.dtlb_miss_resp) begin
			force `NDS_CORE5_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_req = 1'b1;
			force `NDS_CORE5_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_mode_flush_all = 1'b1;
		end
		else begin
			release `NDS_CORE5_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_req;
			release `NDS_CORE5_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_mode_flush_all;
		end
end
if ((NHART > 6) && (MMU_SCHEME != "bare")) begin: gen_hart6_dtlb_miss
	always @ (posedge `NDS_CORE6_TOP.core_clk)
		if (!`NDS_CORE6_TOP.core_reset_n) begin
			release `NDS_CORE6_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_req;
			release `NDS_CORE6_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_mode_flush_all;
		end
		else if(($urandom_range(0, 9) != 0) && `NDS_CORE6_TOP.a45_core.kv_core.kv_dtlb.dtlb_miss_resp) begin
			force `NDS_CORE6_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_req = 1'b1;
			force `NDS_CORE6_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_mode_flush_all = 1'b1;
		end
		else begin
			release `NDS_CORE6_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_req;
			release `NDS_CORE6_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_mode_flush_all;
		end
end
if ((NHART > 7) && (MMU_SCHEME != "bare")) begin: gen_hart7_dtlb_miss
	always @ (posedge `NDS_CORE7_TOP.core_clk)
		if (!`NDS_CORE7_TOP.core_reset_n) begin
			release `NDS_CORE7_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_req;
			release `NDS_CORE7_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_mode_flush_all;
		end
		else if(($urandom_range(0, 9) != 0) && `NDS_CORE7_TOP.a45_core.kv_core.kv_dtlb.dtlb_miss_resp) begin
			force `NDS_CORE7_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_req = 1'b1;
			force `NDS_CORE7_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_mode_flush_all = 1'b1;
		end
		else begin
			release `NDS_CORE7_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_req;
			release `NDS_CORE7_TOP.a45_core.kv_core.kv_dtlb.dtlb_sfence_mode_flush_all;
		end
end
// VPERL_GENERATED_END
endgenerate
