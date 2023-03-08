module pscc_scan_mux(
output      [ 1:0]   rtl_pam,
output      [ 3:0]   rtl_pams,
output               rtl_pdet,

input       [38:0]   rtl_ppa,
input       [ 4:0]   rtl_paio,
input       [31:0]   rtl_pdin,
output      [31:0]   rtl_pdout,
output      [15:0]   rtl_pdout_dummy,
output               rtl_pvprrdy,
input                rtl_pwe,
input                rtl_pprog,
input                rtl_pclk,
input                rtl_pce,
input                rtl_pdstb,
input                rtl_pldo,
input                rtl_pen_osc,
input                rtl_penclk,
output               rtl_pclkout,
input                rtl_pclkin,
input                rtl_penvdd2_vdd,

output               rtl_auth_req,
input                rtl_auth_ack,
input                rtl_auth_dat,
output               rtl_auth_set,
output               rtl_auth_cde,

output               rtl_rng_entropy,

input       [ 1:0]   hmc_pam,
input       [ 3:0]   hmc_pams,
input                hmc_pdet,

output      [38:0]   hmc_ppa,
output      [ 4:0]   hmc_paio,
output      [31:0]   hmc_pdin,
input       [31:0]   hmc_pdout,
input       [15:0]   hmc_pdout_dummy,
input                hmc_pvprrdy,
output               hmc_pwe,
output               hmc_pprog,
output               hmc_pclk,
output               hmc_pce,
output               hmc_pdstb,
output               hmc_pldo,
output               hmc_pen_osc,
output               hmc_penclk,
input                hmc_pclkout,
output               hmc_pclkin,
output               hmc_penvdd2_vdd,

input                hmc_auth_req,
output               hmc_auth_ack,
output               hmc_auth_dat,
input                hmc_auth_set,
input                hmc_auth_cde,

input                hmc_rng_entropy,

input                scan_mode,
input                scan_clk,
input                rst_n
);
//regiters to improve scan coverage
reg         [59:0]   scan_reg;

always@(posedge scan_clk or negedge rst_n) begin
   if(~rst_n) scan_reg <= {15{4'hA}};
   else if(scan_mode) scan_reg <= {scan_reg[58:0],scan_reg[59]};
end

//digital part
assign      rtl_pdout      = (scan_mode)? scan_reg[ 0+:32]  : hmc_pdout;
assign      rtl_pdout_dummy= (scan_mode)? scan_reg[32+:16]  : hmc_pdout_dummy;
assign      rtl_pam        = (scan_mode)? scan_reg[48+: 2]  : hmc_pam;
assign      rtl_pams       = (scan_mode)? scan_reg[50+: 4]  : hmc_pams;
assign      rtl_pdet       = (scan_mode)? scan_reg[54]      : hmc_pdet;
assign      rtl_pvprrdy    = (scan_mode)? scan_reg[55]      : hmc_pvprrdy;
assign      rtl_auth_req   = (scan_mode)? scan_reg[56]      : hmc_auth_req;
assign      rtl_auth_set   = (scan_mode)? scan_reg[57]      : hmc_auth_set;
assign      rtl_auth_cde   = (scan_mode)? scan_reg[58]      : hmc_auth_cde;
assign      rtl_rng_entropy= (scan_mode)? scan_reg[59]      : hmc_rng_entropy;

//hard-macro part
assign      hmc_ppa        = (scan_mode)? 39'h0             : rtl_ppa;
assign      hmc_paio       = (scan_mode)?  5'h0             : rtl_paio;
assign      hmc_pdin       = (scan_mode)? 32'h0             : rtl_pdin;
assign      hmc_pwe        = (scan_mode)?  1'h0             : rtl_pwe;
assign      hmc_pprog      = (scan_mode)?  1'h0             : rtl_pprog;
assign      hmc_pclk       = (scan_mode)?  1'h0             : rtl_pclk;
assign      hmc_pce        = (scan_mode)?  1'h0             : rtl_pce;
assign      hmc_pdstb      = (scan_mode)?  1'h0             : rtl_pdstb;
assign      hmc_pldo       = (scan_mode)?  1'h0             : rtl_pldo;
assign      hmc_pen_osc    = (scan_mode)?  1'h0             : rtl_pen_osc;
assign      hmc_penclk     = (scan_mode)?  1'h0             : rtl_penclk;
assign      hmc_pclkin     = (scan_mode)?  1'h0             : rtl_pclkin;
assign      hmc_penvdd2_vdd= (scan_mode)?  1'h0             : rtl_penvdd2_vdd;
assign      hmc_auth_ack   = (scan_mode)?  1'h0             : rtl_auth_ack;
assign      hmc_auth_dat   = (scan_mode)?  1'h0             : rtl_auth_dat;

//clock part
pscc_clksw_mux       I_CLKSWMUX(
   .Z                (rtl_pclkout),
   .A                (hmc_pclkout),
   .B                (scan_clk),
   .S                (scan_mode)
);
endmodule

