// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`timescale 1ns/1ps

module ext_dlm_mem_checker();

parameter  LM_INTERFACE = "ram";

parameter  DLM_RAM_AW = 1;
parameter  DLM_RAM_DW = 0;
parameter  DLM_RAM_CSW = 1;
parameter  DLM_RAM_WEW = 0;
parameter  DLM_RAM_WUNIT = 1;
parameter  DLM_ECC_TYPE = "none";
parameter  DLM_ECCW = 0;
parameter  DLM_WAIT_CYCLE = 0;
parameter  DLM_TL_UL_RAM_NUM = 0;

localparam DLM_RAM_EXIST =    (LM_INTERFACE == "ram" && DLM_RAM_AW > 1 && DLM_WAIT_CYCLE == 1)? "yes" : "no";

localparam DLM_ECW = (DLM_ECC_TYPE == "none")? 0 : DLM_ECCW;
localparam DLM_NWE_UEC = (DLM_ECC_TYPE == "ecc")? DLM_RAM_WEW : 1;

event   e_fail;


if ((DLM_RAM_EXIST == "yes") && (DLM_ECC_TYPE == "ecc") && (DLM_TL_UL_RAM_NUM >= 1)) begin : gen_dlm0_ecc_mem_checker
       bit     flg_fail;
       bit     flg_finish;
       mem_checker #(
               .RAM_AW(DLM_RAM_AW),
               .RAM_WEW(1),
               .RAM_CSW(DLM_RAM_CSW),
               .RAM_WUNIT(DLM_RAM_DW),
               .RAM_ECW(DLM_ECW),
               .RAM_NWE_UEC(DLM_NWE_UEC),
		.RAM_UNIT_WRITE_SUPPORT(0)
       ) mem_checker (
               .clk       (u_dlm_ram0.lm_clk),
               .ram_cs    (u_dlm_ram0.ram_cs),
               .ram_we    (u_dlm_ram0.ram_we),
               .ram_addr  (u_dlm_ram0.ram_addr),
               .ram_wdata (u_dlm_ram0.ram_wdata),
               .ram_rdata (u_dlm_ram0.ram_rdata),
               .flg_fail  (flg_fail),
               .flg_finish(flg_finish)
       );

       always @* if (flg_fail) -> e_fail;
end

if ((DLM_RAM_EXIST == "yes") && (DLM_ECC_TYPE != "ecc") && (DLM_TL_UL_RAM_NUM >= 1)) begin : gen_dlm0_mem_checker
       bit     flg_fail;
       bit     flg_finish;
       mem_checker #(
               .RAM_AW(DLM_RAM_AW),
               .RAM_WEW(DLM_RAM_WEW),
               .RAM_CSW(DLM_RAM_CSW),
               .RAM_WUNIT(DLM_RAM_WUNIT),
               .RAM_ECW(DLM_ECW),
               .RAM_NWE_UEC(DLM_NWE_UEC)
       ) mem_checker (
               .clk       (u_dlm_ram0.lm_clk),
               .ram_cs    (u_dlm_ram0.ram_cs),
               .ram_we_en (u_dlm_ram0.ram_we),
               .ram_we    (u_dlm_ram0.ram_bwe),
               .ram_addr  (u_dlm_ram0.ram_addr),
               .ram_wdata (u_dlm_ram0.ram_wdata),
               .ram_rdata (u_dlm_ram0.ram_rdata),
               .flg_fail  (flg_fail),
               .flg_finish(flg_finish)
       );

       always @* if (flg_fail) -> e_fail;
end

if ((DLM_RAM_EXIST == "yes") && (DLM_ECC_TYPE == "ecc") && (DLM_TL_UL_RAM_NUM >= 2)) begin : gen_dlm1_ecc_mem_checker
       bit     flg_fail;
       bit     flg_finish;
       always @* if (flg_fail) -> e_fail;
end

if ((DLM_RAM_EXIST == "yes") && (DLM_ECC_TYPE != "ecc") && (DLM_TL_UL_RAM_NUM >= 2)) begin : gen_dlm1_mem_checker
       bit     flg_fail;
       bit     flg_finish;
       always @* if (flg_fail) -> e_fail;
end

if ((DLM_RAM_EXIST == "yes") && (DLM_ECC_TYPE == "ecc") && (DLM_TL_UL_RAM_NUM >= 3)) begin : gen_dlm2_ecc_mem_checker
       bit     flg_fail;
       bit     flg_finish;
       always @* if (flg_fail) -> e_fail;
end

if ((DLM_RAM_EXIST == "yes") && (DLM_ECC_TYPE != "ecc") && (DLM_TL_UL_RAM_NUM >= 3)) begin : gen_dlm2_mem_checker
       bit     flg_fail;
       bit     flg_finish;
       always @* if (flg_fail) -> e_fail;
end

if ((DLM_RAM_EXIST == "yes") && (DLM_ECC_TYPE == "ecc") && (DLM_TL_UL_RAM_NUM >= 4)) begin : gen_dlm3_ecc_mem_checker
       bit     flg_fail;
       bit     flg_finish;
       always @* if (flg_fail) -> e_fail;
end

if ((DLM_RAM_EXIST == "yes") && (DLM_ECC_TYPE != "ecc") && (DLM_TL_UL_RAM_NUM >= 4)) begin : gen_dlm3_mem_checker
       bit     flg_fail;
       bit     flg_finish;
       always @* if (flg_fail) -> e_fail;
end

if ((DLM_RAM_EXIST == "yes") && (DLM_ECC_TYPE == "ecc") && (DLM_TL_UL_RAM_NUM >= 5)) begin : gen_dlm4_ecc_mem_checker
       bit     flg_fail;
       bit     flg_finish;
       always @* if (flg_fail) -> e_fail;
end

if ((DLM_RAM_EXIST == "yes") && (DLM_ECC_TYPE != "ecc") && (DLM_TL_UL_RAM_NUM >= 5)) begin : gen_dlm4_mem_checker
       bit     flg_fail;
       bit     flg_finish;
       always @* if (flg_fail) -> e_fail;
end

if ((DLM_RAM_EXIST == "yes") && (DLM_ECC_TYPE == "ecc") && (DLM_TL_UL_RAM_NUM >= 6)) begin : gen_dlm5_ecc_mem_checker
       bit     flg_fail;
       bit     flg_finish;
       always @* if (flg_fail) -> e_fail;
end

if ((DLM_RAM_EXIST == "yes") && (DLM_ECC_TYPE != "ecc") && (DLM_TL_UL_RAM_NUM >= 6)) begin : gen_dlm5_mem_checker
       bit     flg_fail;
       bit     flg_finish;
       always @* if (flg_fail) -> e_fail;
end

if ((DLM_RAM_EXIST == "yes") && (DLM_ECC_TYPE == "ecc") && (DLM_TL_UL_RAM_NUM >= 7)) begin : gen_dlm6_ecc_mem_checker
       bit     flg_fail;
       bit     flg_finish;
       always @* if (flg_fail) -> e_fail;
end

if ((DLM_RAM_EXIST == "yes") && (DLM_ECC_TYPE != "ecc") && (DLM_TL_UL_RAM_NUM >= 7)) begin : gen_dlm6_mem_checker
       bit     flg_fail;
       bit     flg_finish;
       always @* if (flg_fail) -> e_fail;
end

if ((DLM_RAM_EXIST == "yes") && (DLM_ECC_TYPE == "ecc") && (DLM_TL_UL_RAM_NUM >= 8)) begin : gen_dlm7_ecc_mem_checker
       bit     flg_fail;
       bit     flg_finish;
       always @* if (flg_fail) -> e_fail;
end

if ((DLM_RAM_EXIST == "yes") && (DLM_ECC_TYPE != "ecc") && (DLM_TL_UL_RAM_NUM >= 8)) begin : gen_dlm7_mem_checker
       bit     flg_fail;
       bit     flg_finish;
       always @* if (flg_fail) -> e_fail;
end

endmodule
