// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`timescale 1ns/1ps

module ext_lm_mem_checker(

	ilm_ram_clk

);

parameter  LM_INTERFACE = "ram";

parameter  ILM_RAM_AW = 1;
parameter  ILM_RAM_DW = 0;
parameter  ILM_RAM_CSW = 1;
parameter  ILM_RAM_WEW = 0;
parameter  ILM_RAM_WUNIT = 1;
parameter  ILM_ECC_TYPE = "none";
parameter  ILM_ECCW = 0;
parameter  ILM_WAIT_CYCLE = 0;
parameter  ILM_TL_UL_RAM_NUM = 0;

localparam ILM_RAM_EXIST =    (LM_INTERFACE == "ram" && ILM_RAM_AW > 1 && ILM_WAIT_CYCLE == 1)? "yes" : "no";

localparam ILM_ECW = (ILM_ECC_TYPE == "none")? 0 : ILM_ECCW;
localparam ILM_NWE_UEC = (ILM_ECC_TYPE == "ecc")? ILM_RAM_WEW : 1;


	input	ilm_ram_clk;


event   e_fail;

generate


if ((ILM_RAM_EXIST == "yes") && (ILM_ECC_TYPE == "ecc") && (ILM_TL_UL_RAM_NUM >= 1)) begin : gen_ilm0_ecc_mem_checker
       bit     flg_fail;
       bit     flg_finish;
       mem_checker #(
               .RAM_AW(ILM_RAM_AW),
               .RAM_WEW(1),
               .RAM_CSW(ILM_RAM_CSW),
               .RAM_WUNIT(ILM_RAM_DW),
               .RAM_ECW(ILM_ECW),
               .RAM_NWE_UEC(ILM_NWE_UEC),
		.RAM_UNIT_WRITE_SUPPORT(0)
       ) mem_checker (
               .clk       (ilm_ram_clk),
               .ram_cs    (gen_tl_ul_ram0.u_ilm_tl_ul_ram0.ilm_cs),
               .ram_we    (gen_tl_ul_ram0.u_ilm_tl_ul_ram0.ilm_we),
               .ram_addr  (gen_tl_ul_ram0.u_ilm_tl_ul_ram0.ilm_addr),
               .ram_wdata (gen_tl_ul_ram0.u_ilm_tl_ul_ram0.ilm_wdata),
               .ram_rdata (gen_tl_ul_ram0.u_ilm_tl_ul_ram0.ilm_rdata),
               .flg_fail  (flg_fail),
               .flg_finish(flg_finish)
       );
       always @* if (flg_fail) -> e_fail;
end
if ((ILM_RAM_EXIST == "yes") && (ILM_ECC_TYPE != "ecc") && (ILM_TL_UL_RAM_NUM >= 1)) begin : gen_ilm0_mem_checker
       bit     flg_fail;
       bit     flg_finish;
       mem_checker #(
               .RAM_AW(ILM_RAM_AW),
               .RAM_WEW(ILM_RAM_WEW),
               .RAM_CSW(ILM_RAM_CSW),
               .RAM_WUNIT(ILM_RAM_WUNIT),
               .RAM_ECW(ILM_ECW),
               .RAM_NWE_UEC(ILM_NWE_UEC)
       ) mem_checker (
               .clk       (ilm_ram_clk),
               .ram_cs    (gen_tl_ul_ram0.u_ilm_tl_ul_ram0.ilm_cs),
               .ram_we_en (gen_tl_ul_ram0.u_ilm_tl_ul_ram0.ilm_we),
               .ram_we    (gen_tl_ul_ram0.u_ilm_tl_ul_ram0.ilm_byte_we),
               .ram_addr  (gen_tl_ul_ram0.u_ilm_tl_ul_ram0.ilm_addr),
               .ram_wdata (gen_tl_ul_ram0.u_ilm_tl_ul_ram0.ilm_wdata),
               .ram_rdata (gen_tl_ul_ram0.u_ilm_tl_ul_ram0.ilm_rdata),
               .flg_fail  (flg_fail),
               .flg_finish(flg_finish)
       );
       always @* if (flg_fail) -> e_fail;
end
if ((ILM_RAM_EXIST == "yes") && (ILM_ECC_TYPE == "ecc") && (ILM_TL_UL_RAM_NUM >= 2)) begin : gen_ilm1_ecc_mem_checker
       bit     flg_fail;
       bit     flg_finish;
       mem_checker #(
               .RAM_AW(ILM_RAM_AW),
               .RAM_WEW(1),
               .RAM_CSW(ILM_RAM_CSW),
               .RAM_WUNIT(ILM_RAM_DW),
               .RAM_ECW(ILM_ECW),
               .RAM_NWE_UEC(ILM_NWE_UEC),
		.RAM_UNIT_WRITE_SUPPORT(0)
       ) mem_checker (
               .clk       (ilm_ram_clk),
               .ram_cs    (gen_tl_ul_ram1.u_ilm_tl_ul_ram1.ilm_cs),
               .ram_we    (gen_tl_ul_ram1.u_ilm_tl_ul_ram1.ilm_we),
               .ram_addr  (gen_tl_ul_ram1.u_ilm_tl_ul_ram1.ilm_addr),
               .ram_wdata (gen_tl_ul_ram1.u_ilm_tl_ul_ram1.ilm_wdata),
               .ram_rdata (gen_tl_ul_ram1.u_ilm_tl_ul_ram1.ilm_rdata),
               .flg_fail  (flg_fail),
               .flg_finish(flg_finish)
       );
       always @* if (flg_fail) -> e_fail;
end
if ((ILM_RAM_EXIST == "yes") && (ILM_ECC_TYPE != "ecc") && (ILM_TL_UL_RAM_NUM >= 2)) begin : gen_ilm1_mem_checker
       bit     flg_fail;
       bit     flg_finish;
       mem_checker #(
               .RAM_AW(ILM_RAM_AW),
               .RAM_WEW(ILM_RAM_WEW),
               .RAM_CSW(ILM_RAM_CSW),
               .RAM_WUNIT(ILM_RAM_WUNIT),
               .RAM_ECW(ILM_ECW),
               .RAM_NWE_UEC(ILM_NWE_UEC)
       ) mem_checker (
               .clk       (ilm_ram_clk),
               .ram_cs    (gen_tl_ul_ram1.u_ilm_tl_ul_ram1.ilm_cs),
               .ram_we_en (gen_tl_ul_ram1.u_ilm_tl_ul_ram1.ilm_we),
               .ram_we    (gen_tl_ul_ram1.u_ilm_tl_ul_ram1.ilm_byte_we),
               .ram_addr  (gen_tl_ul_ram1.u_ilm_tl_ul_ram1.ilm_addr),
               .ram_wdata (gen_tl_ul_ram1.u_ilm_tl_ul_ram1.ilm_wdata),
               .ram_rdata (gen_tl_ul_ram1.u_ilm_tl_ul_ram1.ilm_rdata),
               .flg_fail  (flg_fail),
               .flg_finish(flg_finish)
       );
       always @* if (flg_fail) -> e_fail;
end


endgenerate

endmodule
