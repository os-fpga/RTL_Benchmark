// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module kv_stacksafe_alu (
    csr_mhsp_bound,
    csr_mhsp_base,
    csr_mhsp_ctl_ovf_en,
    csr_mhsp_ctl_udf_en,
    csr_mhsp_ctl_schm,
    sp_alu_valid,
    sp_check_data,
    status
);
input [31:0] csr_mhsp_bound;
input [31:0] csr_mhsp_base;
input csr_mhsp_ctl_ovf_en;
input csr_mhsp_ctl_udf_en;
input csr_mhsp_ctl_schm;
input [31:0] sp_check_data;
input sp_alu_valid;
output [2:0] status;


wire s0;
wire s1;
wire s2;
wire s3 = (sp_check_data < csr_mhsp_bound);
wire s4 = (sp_check_data > csr_mhsp_base);
assign s0 = sp_alu_valid & csr_mhsp_ctl_ovf_en & ~csr_mhsp_ctl_schm;
assign s1 = sp_alu_valid & csr_mhsp_ctl_udf_en & ~csr_mhsp_ctl_schm;
assign status[0] = s3 & s0;
assign status[1] = s4 & s1;
assign s2 = sp_alu_valid & csr_mhsp_ctl_schm & csr_mhsp_ctl_ovf_en;
assign status[2] = s3 & s2;
endmodule

