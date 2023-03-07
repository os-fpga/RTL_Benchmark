//------------------------------------------------------------------------------
// Copyright (c) 2018 Cadence Design Systems, Inc.
//
// The information herein (Cadence IP) contains confidential and proprietary
// information of Cadence Design Systems, Inc. Cadence IP may not be modified,
// copied, reproduced, distributed, or disclosed to third parties in any manner,
// medium, or form, in whole or in part, without the prior written consent of
// Cadence Design Systems Inc. Cadence IP is for use by Cadence Design Systems,
// Inc. customers only. Cadence Design Systems, Inc. reserves the right to make
// changes to Cadence IP at any time and without notice.
//------------------------------------------------------------------------------
//
//   Filename:           usb2_pma_top.sv
//   Module Name:        usb2_pma_top
//
//   Release Revision:   1p3
//   Release SVN Tag:    
//
//   IP Name:            cdn_sd1000_t16ffc_01_vc176_2xa1xd3xe2y2r
//   IP Part Number:     
//
//   Product Type:       Off-the-shelf
//   IP Type:            Hard IP
//   IP Family:          USB2
//   Technology:         16FFC
//   Protocol:           USB2
//   Architecture:       
//   Licensable IP:      
//
//------------------------------------------------------------------------------
//   Description: This is an behavioural Verilog source for analog design in IP
//------------------------------------------------------------------------------

`timescale 1ns/1fs
module usb2_pma_top (
`ifdef CDNS_PHY_PWR_AWARE
inout           DVDD_CORE,
inout           AVDD_IO,
inout           AVDD_IO_HV,
inout           AVSS,
inout           AVDD_CORE,
`else
`endif
inout           DM,
inout           DP,
inout           ID,
inout           VBUS,
inout           RTRIM,
inout           TM_ANAMUX_0,
input           vbus_sel,
output          avdd_core_powergood,
output          dvdd_core_powergood,
input           i_refclk_for_pll,
input           i_pll_fb_clk,
input           i_pll_div_refclk,
input           i_rx_calib_rstn,
output          o_pll_480m_clk,
output          o_sampler_clk,
input           i_lane_reverse,
input           i_option_n,
input           i_option_cv,
input   [3:0]   usb2_phy_spare_in,
output  [3:0]   usb2_phy_spare_out,
input           i_dmrpd_en,
input           i_dmrpu1_en,
input           i_dmrpu2_en,
input           i_dprpd_en,
input           i_dprpu1_en,
input           i_dprpu2_en,
input           i_hsrx_calib_active,
input   [5:0]   i_hsrx_calib_code,
input           i_hsrx_clk_gate,
input           i_ana_hsrx_enable,
input           i_ana_hsrx_enable_delayed,
input           i_hsrx_en_clipper,
input           i_afe_suspendm_rx,
output  reg     o_hsrx_calib_comp_out,
output  reg     o_sampler_data,
input           i_hsddi,
input           i_hsdrv_en,
input           i_hspredrv_en,
input           i_hstx_en,
input           i_hstx_en_delayed,
input           i_chirp_mode_en,
input           i_afe_suspendm_tx,
input           i_hstx_boost_deemp_off,
input           i_fs_edge_sel,
input           i_lsfs_ddi,
input           i_lsfsdrv_en,
input           i_lsfstx_en,
input           i_afe_clipper_en,
input           i_assert_sezero,
input   [4:0]   i_afe_bccalib_code,
input   [4:0]   i_afe_fscalib_code,
input   [4:0]   i_afe_hscalib_code,
input           i_lsfsrx_en,
output  reg     o_afe_lsfsrx_ana,
input           i_serx_en,
input           i_serx_bias_en,
output          o_afe_rxdm_ana,
output          o_afe_rxdp_ana,
input           i_adp_en,
input           i_adp_probe_en,
input           i_adp_sense_en,
input           i_adp_sink_current_en,
input           i_adp_source_current_en,
output          o_adp_probe_ana,
output          o_adp_sense_ana,
input           i_pll_bypass_mode,
input           i_pll_pd,
input           i_pll_pso,
input           i_pll_pso_delay,
input           i_pll_standby,
input   [8:0]   i_pll_coarse_code,
input           i_pll_pfd_pd,
input           i_pll_startloop,
input           i_pll_ldo_core_en,
input           i_pll_ldo_core_en_tx,
input           i_pll_ldo_ref_en,
input   [5:0]   i_pll_ldo_ref_core,
input           i_otgc_absvalid_en,
input           i_otgc_id_pullup_en,
input           i_otgc_vbusvalid_en,
output          o_otgc_id_ana,
output          o_otgc_sessvalid_ana,
output          o_otgc_vbusvalid_ana,
input           i_idm_sink_en,
input           i_idm_src_en,
input           i_idp_sink_en,
input           i_idp_src_en,
input           i_vdm_src_en,
input           i_vdp_src_en,
input           i_dm_vdat_ref_comp_en,
input           i_dp_vdat_ref_comp_en,
input           i_rid_a_ref_en,
input           i_rid_b_c_comp_en,
input           i_rid_b_ref_en,
input           i_rid_c_ref_en,
input           i_rid_float_a_comp_en,
input           i_rid_float_ref_en,
input           i_rid_float_src_en,
input           i_rid_nonfloat_src_en,
output          o_dm_vdat_ref_comp_sts,
output          o_dp_vdat_ref_comp_sts,
output          o_rid_b_c_comp_sts,
output          o_rid_float_a_comp_sts,
input           i_ed_en,
input           i_ted_en,
input   [3:0]   i_ted_calib_code_up,
input   [3:0]   i_ted_calib_code_down,
input           i_ted_calib_mode_up,
input           i_ted_calib_mode_down,
output  reg     o_ded_ana,
output  reg     o_ted_comp_out_up  ,
output  reg     o_ted_comp_out_down,
output          o_ted_squelch_ana,
input           i_bg_pd,
input           i_bg_pd_bg_ok,
output  wire    o_bg_powergood,
input           i_calib_pd_bias_comp  ,
input     [4:0] i_res_calib_code,
output    reg   o_res_calib_comp_out,
input   [7:0]   i_afe_tx_reg0,
input   [7:0]   i_afe_tx_reg1,
input   [7:0]   i_afe_tx_reg2,
input   [7:0]   i_afe_tx_reg3,
input   [7:0]   i_afe_tx_reg4,
input   [7:0]   i_afe_tx_reg5,
input   [7:0]   i_afe_tx_reg6,
input   [7:0]   i_afe_tx_reg7,
input   [7:0]   i_afe_tx_reg8,
input   [7:0]   i_afe_tx_reg9,
input   [7:0]   i_afe_tx_reg10,
input   [7:0]   i_afe_tx_reg11,
input   [7:0]   i_afe_tx_reg12,
input   [7:0]   i_afe_rx_reg0,
input   [7:0]   i_afe_rx_reg1,
input   [7:0]   i_afe_rx_reg2,
input   [7:0]   i_afe_rx_reg3,
input   [7:0]   i_afe_rx_reg4,
input   [7:0]   i_afe_rx_reg5,
input   [7:0]   i_afe_rx_reg6,
input   [7:0]   i_afe_pll_reg0,
input   [7:0]   i_afe_pll_reg1,
input   [7:0]   i_afe_pll_reg2,
input   [7:0]   i_afe_pll_reg3,
input   [7:0]   i_afe_pll_reg4,
input   [7:0]   i_afe_pll_reg5,
input   [7:0]   i_afe_bc_reg0,
input   [7:0]   i_afe_bc_reg1,
input   [7:0]   i_afe_bc_reg2,
input   [7:0]   i_afe_bc_reg3,
input   [7:0]   i_afe_bc_reg4,
input   [7:0]   i_afe_bc_reg5,
input   [7:0]   i_afe_bc_reg6,
input   [7:0]   i_afe_bg_reg0,
input   [7:0]   i_afe_bg_reg1,
input   [7:0]   i_afe_bg_reg2,
input   [7:0]   i_afe_bg_reg3,
input   [7:0]   i_afe_calib_reg0,
input           i_tie_low
);
reg  IRCONST_PMOS_5U, IRCONST_PMOS_10U;
wire clkout_rx;
wire bg_pd_bg_ok_del,bg_current_del,w_bg_pd_bg_ok,w_bg_current;
`ifdef CDNS_PHY_PWR_AWARE
`else
assign           DVDD_CORE = 1'b1;
assign 		 AVDD_IO = 1'b1;
assign  	 AVDD_IO_HV = 1'b1;
assign  	 AVSS = 1'b0;
assign  	 AVDD_CORE = 1'b1;
`endif
assign dvdd_core_powergood = AVDD_CORE ? DVDD_CORE : 1'bx;
assign avdd_core_powergood = DVDD_CORE ? AVDD_CORE : 1'bx;
assign usb2_phy_spare_out = 4'd0;
wire    pullup_pg, pulldown_pg;
reg o_dprpu_en_delayed, o_dmrpu_en_delayed, o_dprpd_en_delayed,
o_dmrpd_en_delayed;
parameter pullup_delay = 28.47;
parameter pulldown_delay = 434.8;
assign pullup_pg = AVDD_IO_HV && !AVSS && AVDD_IO && o_bg_powergood && DVDD_CORE;
assign pulldown_pg = AVDD_IO && !AVSS && DVDD_CORE;
always_comb
begin
o_dprpu_en_delayed  <=  #pullup_delay (pullup_pg == 1'b1) ? (i_dprpu1_en || i_dprpu2_en) : ((pullup_pg == 1'b0) ? 1'b0 : 1'bx);
o_dmrpu_en_delayed  <=  #pullup_delay (pullup_pg == 1'b1) ? (i_dmrpu1_en || i_dmrpu2_en) : ((pullup_pg == 1'b0) ? 1'b0 : 1'bx);
o_dprpd_en_delayed  <=  #pulldown_delay (pulldown_pg == 1'b1) ? i_dprpd_en : ((pulldown_pg == 1'b0) ? 1'b0 : 1'bx);
o_dmrpd_en_delayed  <=  #pulldown_delay (pulldown_pg == 1'b1) ? i_dmrpd_en : ((pulldown_pg == 1'b0) ? 1'b0 : 1'bx);
end
wire hstx_pg;
reg hstx_tristate, hstx_data_flop, LDO_VDD, hstx_480m_clock, hstx_rstn,
o_hstx_dp, o_hstx_dm, o_fstx_dp, o_fstx_dm, vbus_result;
wire drive_pg;
parameter hstx_clk_delay = 0.3;
parameter hstx_rstn_delay = 0.2;
parameter hstx_drive_delay = 0.5;
assign hstx_pg = AVDD_IO && DVDD_CORE && !AVSS;
always_comb
begin
if(hstx_pg && LDO_VDD)
    hstx_480m_clock <= #hstx_clk_delay o_pll_480m_clk;
else
    hstx_480m_clock <= 1'bx;
if(hstx_pg)
    hstx_rstn <= #hstx_rstn_delay i_hstx_en_delayed;
else
    hstx_rstn <= 1'bx;
end
always@(posedge hstx_480m_clock or negedge hstx_rstn)
begin
    if(!hstx_rstn)
    begin
            hstx_tristate <= 1'b1;
            hstx_data_flop <= 1'b0;
    end
    else
    begin
            hstx_tristate <= !i_hsdrv_en;
            hstx_data_flop <= i_hsddi;
    end
end
assign drive_pg = (AVDD_CORE) && (~AVSS) && AVDD_IO;
assign o_hstx_drive_supply = (drive_pg) && (o_hstx_dp ^ o_hstx_dm) ;
assign o_hstx_drive_strong = (drive_pg && DVDD_CORE) && (~o_hstx_dp && ~o_hstx_dm) ;
assign o_hstx_drive_supply1 = (drive_pg) && (o_hstx_dp && o_hstx_dm) ;
always_comb
begin
o_hstx_dp <= #hstx_drive_delay  (!hstx_pg)? 1'bx :(hstx_tristate ? 1'b0: hstx_data_flop);
o_hstx_dm <= #hstx_drive_delay  (!hstx_pg)? 1'bx :(hstx_tristate ? 1'b0: !hstx_data_flop);
end
wire fstx_pg, fstx_pullup_dp, fstx_pulldown_dp, fstx_drive_dp, bg_sus_pg;
parameter fstx_drive_delay = 0.4;
parameter fstx_pg_delay = 0.6;
assign bg_sus_pg= !(o_bg_powergood & i_afe_suspendm_tx);
assign #fstx_pg_delay fstx_pg = (!AVSS) && AVDD_IO_HV && AVDD_IO ;
assign #fstx_drive_delay fstx_pullup_dp = (i_lsfs_ddi & !i_assert_sezero & i_lsfsdrv_en) & !bg_sus_pg && IRCONST_PMOS_5U && IRCONST_PMOS_10U && i_lsfstx_en&& !i_chirp_mode_en;
assign #fstx_drive_delay fstx_pulldown_dp = (!i_lsfs_ddi && i_lsfstx_en && i_lsfsdrv_en) || (i_lsfstx_en && i_lsfsdrv_en && i_assert_sezero) || (i_lsfstx_en && !i_lsfsdrv_en && i_assert_sezero && !i_hspredrv_en) || (!i_lsfstx_en && !i_hspredrv_en && i_assert_sezero) ||  (!i_lsfstx_en && i_chirp_mode_en && i_assert_sezero);
assign #0.001 o_fstx_drive_dp = fstx_pg && (fstx_pullup_dp || fstx_pulldown_dp);  
assign #fstx_drive_delay fstx_pullup_dm = (!i_lsfs_ddi & !i_assert_sezero & i_lsfsdrv_en) & !bg_sus_pg && IRCONST_PMOS_5U && IRCONST_PMOS_10U && i_lsfstx_en&& !i_chirp_mode_en;
assign #fstx_drive_delay fstx_pulldown_dm = (i_lsfs_ddi && i_lsfstx_en && i_lsfsdrv_en) || (i_lsfstx_en && i_lsfsdrv_en && i_assert_sezero) || (i_lsfstx_en && !i_lsfsdrv_en && i_assert_sezero && !i_hspredrv_en) || (!i_lsfstx_en && !i_hspredrv_en && i_assert_sezero) ||  (!i_lsfstx_en && i_chirp_mode_en && i_assert_sezero);
assign #0.001 o_fstx_drive_dm = fstx_pg && (fstx_pullup_dm || fstx_pulldown_dm);  
initial
begin
o_fstx_dp =1'bz; 
o_fstx_dm =1'bz;
end
always @(*)
begin
if(fstx_pullup_dp)
   o_fstx_dp <= 1'b1;
else if(fstx_pulldown_dp)
   o_fstx_dp <= 1'b0;
if(fstx_pullup_dm)
    o_fstx_dm <= 1'b1;
else if(fstx_pulldown_dm)
    o_fstx_dm <= 1'b0;
end
wire clipper_pg, clipper_en_delayed;
reg clipped_dn, clipped_dp;
parameter clipper_delay = 0.8;
assign clipper_pg = AVDD_IO && AVDD_IO_HV && (~AVSS);
assign #clipper_delay clipper_en_delayed = i_afe_clipper_en;
always_comb
begin
if(clipper_pg)
begin
if(clipper_en_delayed && IRCONST_PMOS_5U)
begin
clipped_dn <= DM;
clipped_dp <= DP;
end
else
begin
clipped_dn <= 1'b0;
clipped_dp <= 1'b0;
end
end
else
begin
clipped_dn <= 1'bz;
clipped_dp <= 1'bz;
end
end
wire hsrx_pg, outp, outm;
reg hsrx_en_delayed;
reg clk_gate_sync,clk_en ;
wire [5:0] hsrx_calib_ref = 6'b101111;
parameter hsrx_en_delay = 1000;
parameter sampler_delay = 0.05;
assign hsrx_pg = AVDD_CORE && AVDD_IO & !AVSS && IRCONST_PMOS_5U && LDO_VDD;
assign #0.145 o_sampler_clk = (clk_en & clkout_rx);
assign {outp, outm} = hsrx_en_delayed ? {clipped_dp, clipped_dn} : 2'd0;
always @(posedge clkout_rx or negedge i_rx_calib_rstn)
if (!i_rx_calib_rstn) 
clk_gate_sync <= 1'b0;
else
clk_gate_sync <= i_hsrx_clk_gate;
always @(negedge clkout_rx or negedge i_rx_calib_rstn)
if (!i_rx_calib_rstn) 
clk_en <= 1'b1;
else
clk_en <= !clk_gate_sync;
always @(*)
if(!hsrx_pg)
hsrx_en_delayed = 1'd z ;
else if(i_ana_hsrx_enable)
hsrx_en_delayed <= #hsrx_en_delay 1'd 1 ;
else
hsrx_en_delayed <= 1'd 0 ;
  always@(posedge o_sampler_clk)
  if(~i_hsrx_calib_active)
  begin
        if(outp ^ outm)
        begin
        o_sampler_data <= #0.040 outp;
        o_hsrx_calib_comp_out <= #0.040 outm;
        end
        else
        begin
        o_sampler_data <= #0.040 1'b0;
        o_hsrx_calib_comp_out <= #0.040 1'b1;
        end
  end
  else
  begin
        if(i_hsrx_calib_code < hsrx_calib_ref)
        begin
        o_sampler_data <= #0.040 1'b0;
        o_hsrx_calib_comp_out <= #0.040 1'b1;
        end
        else
        begin
        o_sampler_data <= #0.040 1'b1;
        o_hsrx_calib_comp_out <= #0.040 1'b0;
        end
  end
wire fsrx_pg;
parameter lsfsrx_delay = 4;
assign fsrx_pg= (~AVSS) && AVDD_IO_HV && AVDD_IO && DVDD_CORE;
always_comb
begin
if(fsrx_pg)
 if(i_lsfsrx_en && !bg_sus_pg)
  if(~(clipped_dn^clipped_dp))
     o_afe_lsfsrx_ana<=($random)%2 ;
  else
     o_afe_lsfsrx_ana<= #lsfsrx_delay clipped_dp;
 else
    o_afe_lsfsrx_ana<=1'b0;
else
   o_afe_lsfsrx_ana<=1'bx;
end
wire serx_pg;
reg serx_delayed;
parameter serx_pwrup_delay = 150;
parameter serx_pwrdn_delay = 0.4;
assign serx_pg = DVDD_CORE && AVDD_IO && (~AVSS);
always @*
if(~i_serx_en)
serx_delayed<= 1'b0;
else
serx_delayed <= #serx_pwrup_delay i_serx_en;
assign o_afe_rxdp_ana = serx_pg ? (serx_delayed) ? clipped_dp : 1'b0 : 1'bx;
assign o_afe_rxdm_ana = serx_pg ? (serx_delayed) ? clipped_dn : 1'b0 : 1'bx;
wire ted_pg = AVDD_IO_HV && AVDD_IO && AVDD_CORE;
wire bias_ok_ted = i_ted_en && i_ed_en && IRCONST_PMOS_5U;
wire bias_ok_ded = i_ted_en && IRCONST_PMOS_5U;
wire ted_calib = i_ted_calib_mode_up | i_ted_calib_mode_down;  
wire [3:0] calib_up_ref   = $urandom_range('d1,'d14);  
wire [3:0] calib_down_ref = $urandom_range('d1,'d14);  


always_comb begin
 if(ted_pg) begin
  if(bias_ok_ted) begin
   if(~ted_calib) begin
    o_ted_comp_out_up = 1'b0;
    o_ted_comp_out_down = 1'b0;
   end
   else begin
     o_ted_comp_out_up = (i_ted_calib_code_up>=calib_up_ref)?1'b0:1'b1;  
     o_ted_comp_out_down = (i_ted_calib_code_down>=calib_down_ref)?1'b0:1'b1;  
   end
  end  
  else begin
    o_ted_comp_out_up = 1'b0;
    o_ted_comp_out_down = 1'b0;
  end
 end
 else begin
   o_ted_comp_out_up = 1'bz;
   o_ted_comp_out_down = 1'bz;
 end
end
reg o_ted_squelch_ana_loc;
always@(*) begin
 if(ted_pg) begin
  if(bias_ok_ted) begin
  if(clipped_dn ^ clipped_dp) begin
   o_ted_squelch_ana_loc <=  1'b0;
   end 
 else  begin
   o_ted_squelch_ana_loc <=  1'b1;
   o_ded_ana <= 1'b0;
   end
  end
  else begin
   o_ted_squelch_ana_loc <= 1'b1;
  end             
 end
 else begin
  o_ted_squelch_ana_loc <= 1'bz;
 end
end
// Added the delay to support GLS
assign #2 o_ted_squelch_ana = o_ted_squelch_ana_loc;

wire [4:0] calib_ref = 5'b11011;
wire   calib_pg;
assign calib_pg = DVDD_CORE & AVDD_IO & ~AVSS & IRCONST_PMOS_5U;
always@(*)
begin
if(~i_calib_pd_bias_comp)
begin
 if(i_res_calib_code > calib_ref)
         o_res_calib_comp_out = calib_pg ? 1'b0 : 1'bz;
 else
         o_res_calib_comp_out = calib_pg ? 1'b1 : 1'bz;
end
else
         o_res_calib_comp_out = 1'b0;
end
reg comp_vld, VREF, INMOS_2P5U, PCAS_BIAS;
wire en_dac, en_10ucurr;
parameter adp_pwrup_delay = 200;
parameter comp_delay = 1000;
parameter VREF_delay = 1000;
parameter NMOS_delay = 300;
parameter adp_output_delay = 0.2;
parameter vbus_drive_delay = 5;
parameter vbus_result_delay = 500000;
assign adp_pg = !AVSS && AVDD_IO && DVDD_CORE;
assign id_pg =  AVDD_IO_HV && (~AVSS) && AVDD_IO && IRCONST_PMOS_5U;
assign en_dac   =       (i_adp_en && i_adp_probe_en) || i_otgc_id_pullup_en || i_rid_nonfloat_src_en || 
                        i_rid_float_src_en || i_idm_sink_en || i_idp_sink_en || i_idm_src_en
                        || i_idp_src_en || i_hstx_en || i_lsfstx_en;
always_comb
begin
if(adp_pg)
if(en_dac && IRCONST_PMOS_5U)
PCAS_BIAS <= #adp_pwrup_delay 1'b1;
else
PCAS_BIAS <= 1'b0;
else
PCAS_BIAS <= 1'bx;
end
always_comb
begin
if(adp_pg)
if(en_dac && IRCONST_PMOS_5U)
IRCONST_PMOS_10U <= #adp_pwrup_delay 1'b1;
else
IRCONST_PMOS_10U <= 1'b0;
else
IRCONST_PMOS_10U <= 1'bx;
end
always @(VBUS)
begin
comp_vld  <= 1'b 0 ;
if(VBUS)
comp_vld  <= #comp_delay adp_pg ;
end
always @(o_bg_powergood)
begin
VREF       <= 1'b 0 ;
INMOS_2P5U <= 1'd 0 ;
if(IRCONST_PMOS_5U)
begin
VREF       <= #VREF_delay adp_pg && o_bg_powergood ;
INMOS_2P5U <= #NMOS_delay adp_pg && o_bg_powergood ;
end
end
assign id_drive = (i_rid_float_src_en | i_otgc_id_pullup_en | i_rid_nonfloat_src_en) && (i_rid_float_src_en |
                i_otgc_id_pullup_en) && PCAS_BIAS && id_pg;
assign id_clipped = ( id_pg && ID ); 
assign v_adpp =INMOS_2P5U ? (i_adp_en && i_adp_probe_en && VREF ? comp_vld : 1'b0 ): 1'b0;
assign v_adps =INMOS_2P5U ? (i_adp_en && i_adp_sense_en && VREF ? comp_vld : 1'b0 ) :1'b0;
assign v_iddig = INMOS_2P5U ? (i_otgc_id_pullup_en && VREF  ? id_clipped : 1'b0) :1'b0 ;
assign v_sess_vld = INMOS_2P5U ? (i_otgc_absvalid_en && VREF  ? comp_vld : 1'b0) :1'b0 ;
assign v_vbus_vld = INMOS_2P5U ? (i_otgc_vbusvalid_en && VREF  ? comp_vld : 1'b0) :1'b0 ;
assign dp_vdat_sts = INMOS_2P5U ? (i_dp_vdat_ref_comp_en && VREF  ? DP : 1'b0) :1'b0 ;
assign dm_vdat_sts = INMOS_2P5U ? (i_dm_vdat_ref_comp_en && VREF  ? DM : 1'b0) :1'b0 ;
assign rid_b_c_sts = INMOS_2P5U ? (i_rid_b_c_comp_en && VREF  ? id_clipped : 1'b0) :1'b0 ;
assign rid_float_a_sts = INMOS_2P5U ? (i_rid_float_a_comp_en && VREF  ? id_clipped : 1'b0) :1'b0 ;
assign #adp_output_delay  o_adp_probe_ana       = adp_pg ?      v_adpp          & o_bg_powergood : 1'bz;
assign #adp_output_delay  o_adp_sense_ana       = adp_pg ?      v_adps          & o_bg_powergood : 1'bz;
assign #adp_output_delay  o_otgc_id_ana         = adp_pg ?      v_iddig         & o_bg_powergood: 1'bz;
assign #adp_output_delay  o_otgc_sessvalid_ana  = adp_pg ?      v_sess_vld      & o_bg_powergood: 1'bz;
assign #adp_output_delay  o_otgc_vbusvalid_ana  = adp_pg ?      v_vbus_vld      & o_bg_powergood: 1'bz;
assign #adp_output_delay  o_dp_vdat_ref_comp_sts = adp_pg ?     dp_vdat_sts: 1'bz;
assign #adp_output_delay  o_dm_vdat_ref_comp_sts = adp_pg ?     dm_vdat_sts: 1'bz;
assign #adp_output_delay  o_rid_b_c_comp_sts    = adp_pg ?      rid_b_c_sts: 1'bz;
assign #adp_output_delay  o_rid_float_a_comp_sts = adp_pg ?     rid_float_a_sts: 1'bz;
assign vbus_pg = AVDD_IO && AVDD_IO_HV && (! AVSS)&& i_adp_en & i_adp_probe_en ;
assign #vbus_drive_delay charge = i_adp_source_current_en && vbus_pg;
assign #vbus_drive_delay discharge= i_adp_sink_current_en && vbus_pg;
assign vbus_drive = charge || discharge;
always_comb
begin
   if(charge && discharge)
      vbus_result<=#1 1'bx;
   else if(charge)
      vbus_result<=#vbus_result_delay 1'b1;
   else if(discharge)
      vbus_result<=#vbus_result_delay 1'b0;
   else
      vbus_result<=1'bz;
end
assign DP_adp = adp_pg && AVDD_IO_HV ? (  i_idp_src_en ? 1'b1 : ( ( i_idp_sink_en ) ? 1'b0 : 1'bz ) ) : 1'bx ;
assign DM_adp = adp_pg && AVDD_IO_HV ? (  i_idm_src_en ? 1'b1 : ( ( i_idm_sink_en ) ? 1'b0 : 1'bz ) ) : 1'bx ;
reg  PMOS_CURRENT_BG_OK;
reg bg_ok_int;
reg bg_pg_del ;
wire bg_pg;
parameter bg_pg_delay = 5000;
assign bg_pg = (!AVSS) && (AVDD_IO) && (DVDD_CORE);
assign bg_current = (IRCONST_PMOS_5U) && (PMOS_CURRENT_BG_OK);
assign o_bg_powergood = bg_ok_int;
initial
bg_pg_del = 1'b 0 ;
always @(bg_pg)
if (bg_pg === 1'b 1)
#bg_pg_delay bg_pg_del = 1'b 1 ;
else
bg_pg_del = 1'b 0 ;
always_comb
 begin
  if(bg_pg === 1'b1 && i_bg_pd === 1'b0 )
   begin
          if (!bg_pg_del)
              IRCONST_PMOS_5U = 1'b0;
          else
              IRCONST_PMOS_5U = 1'b1;
         PMOS_CURRENT_BG_OK = 1'b1;
   end
  else if(bg_pg === 1'bx && i_bg_pd === 1'bx)
   begin
         PMOS_CURRENT_BG_OK = 1'bx;
         IRCONST_PMOS_5U = 1'bx;
   end
  else
   begin
         PMOS_CURRENT_BG_OK = 1'b0;
         IRCONST_PMOS_5U = 1'b0;
    end
end
assign #5500 bg_pd_bg_ok_del = i_bg_pd_bg_ok;
assign #5500 bg_current_del = bg_current;
assign w_bg_pd_bg_ok = bg_pd_bg_ok_del |i_bg_pd_bg_ok;
assign w_bg_current = bg_current_del & bg_current;
always_comb
 begin
  if(bg_pg === 1'b1 && w_bg_pd_bg_ok === 1'b0 && w_bg_current === 1'b1)
             bg_ok_int = 1'b1;
  else if(bg_pg === 1'bx && i_bg_pd_bg_ok === 1'bx && bg_current === 1'bx)
             bg_ok_int = 1'bx;
  else
             bg_ok_int = 1'b0;
 end
wire ldo_pg;
wire ldo_core_en, ldo_ref_en;
parameter ldo_pwrup_delay = 5000;
parameter ldo_lvlshft_delay = 0.2;
assign ldo_pg = AVDD_IO && !AVSS && AVDD_CORE;
assign ref_ok = IRCONST_PMOS_5U && VREF;
assign #ldo_lvlshft_delay ldo_core_en= i_pll_ldo_core_en;
assign #ldo_lvlshft_delay ldo_ref_en= i_pll_ldo_ref_en;
reg reg_ldo_out;
always_comb
 begin
    if((ldo_pg && ref_ok && ldo_core_en) === 1'b1)
              reg_ldo_out = ldo_ref_en;
    else if((ldo_pg && ref_ok && ldo_core_en) === 1'bx)
               reg_ldo_out = 1'bx;
            else
               reg_ldo_out = 1'b0;
 end
always_comb
LDO_VDD <= #ldo_pwrup_delay reg_ldo_out;
wire pso_io_pg, pso_bar_io, AVDD_IO_SW, AVDD_CORE_SW;
reg pso_bar_core, io_sw_ctrl, core_sw_ctrl;
parameter p_coarse_code_len = 5 ;
parameter p_fine_code_len = 4 ;
parameter coarse_code_lsb = 188.5e6;    
parameter v2i_code_lsb = 9.425e6;       
parameter fine_code_lsb = 28.275e6;     
parameter p_timescale = 1e-9;           
wire pll_pg, pll_pg_int, pll_pg_del;
wire pll_bias_ok;
wire [p_coarse_code_len -1:0] pll_coarse;
wire [p_coarse_code_len -1:0] pll_v2i;
wire [p_fine_code_len -1:0] pll_fine;
reg w_clkout_rx;
reg [2:0] count_pll ; 
real vco_freq = 3.36e9;
real w_vco_freq = 3.36e9;
real vco_per_by2 = 0.148809523809523;
always @(*)
 if (i_pll_pso === 1'bx)
   pso_bar_core = 1'b0;
 else
   pso_bar_core = ~i_pll_pso;
assign pso_io_pg = AVDD_IO && DVDD_CORE && !AVSS;
assign #0.2 pso_bar_io = pso_io_pg ? pso_bar_core : 1'bx;
always @(*)
 if (pso_bar_io === 1'b0)
   io_sw_ctrl = AVDD_IO;
 else if((pso_bar_io === 1'b1))
   io_sw_ctrl = AVSS;
 else if (DVDD_CORE === 1'b 0 )
   io_sw_ctrl = AVDD_CORE;
always @(*)
 if (pso_bar_core === 1'b0)
   core_sw_ctrl = AVDD_CORE;
 else if((pso_bar_core === 1'b1))
   core_sw_ctrl = AVSS;
 else if (DVDD_CORE === 1'b 0 )
   core_sw_ctrl = AVDD_IO;
assign AVDD_IO_SW = io_sw_ctrl ? 1'bz :AVDD_IO;
assign AVDD_CORE_SW = core_sw_ctrl ? 1'bz :  AVDD_CORE;
assign pll_pg_int = 
       (DVDD_CORE === 1'b1) &&
       (AVDD_CORE === 1'b1) && (AVSS === 1'b0) &&
       (AVDD_CORE_SW === 1'b1) && (AVDD_IO === 1'b1) && 
       (AVDD_IO_SW === 1'b1) && (i_pll_pd === 1'b0) &&
       (i_pll_pso ===1'b0) && (i_pll_standby === 1'b0);
assign #100 pll_pg_del = pll_pg_int;
assign pll_pg = pll_pg_del && pll_pg_int;
assign pll_bias_ok = (IRCONST_PMOS_5U == 1'b1) ;
assign pll_coarse = i_pll_coarse_code[p_coarse_code_len+p_fine_code_len -1:p_fine_code_len];
assign pll_v2i = i_pll_coarse_code[p_coarse_code_len+p_fine_code_len -1:p_fine_code_len];
assign pll_fine = ~i_pll_coarse_code[p_fine_code_len:0];   
always @(*)
     begin
     w_vco_freq = (4.0 + pll_coarse)*coarse_code_lsb - pll_v2i*v2i_code_lsb - pll_fine*fine_code_lsb;
    end
always @(*)
begin
   if (~i_pll_startloop)
     begin
        if(i_pll_pd !== 1'b0)
        begin
          vco_freq = w_vco_freq;
          if(!i_afe_pll_reg1[0])
          vco_per_by2 = 0.148809523809523;
          else
          vco_per_by2 = 0.83333;
          end
        else
        begin 
          vco_freq = w_vco_freq;
          if(!i_afe_pll_reg1[0])
          vco_per_by2 = 0.148809523809523;
          else
          vco_per_by2 = 0.83333;
        end
     end
end  
always 
begin
   #(vco_per_by2);
   if (pll_pg & pll_bias_ok)
     w_clkout_rx = ~clkout_rx;
   else
     w_clkout_rx = 1'b0;
end  
assign clkout_rx_bypass = i_pll_bypass_mode ? i_refclk_for_pll : w_clkout_rx; 
initial
count_pll = 3'd 0 ;
   always @(posedge clkout_rx_bypass ) 
        if (count_pll == 3'd 6)
        count_pll = 3'd 0 ;
        else
        count_pll = count_pll + 3'd 1 ;
  assign o_pll_480m_clk = (i_pll_pso_delay | i_pll_standby) ? 1'b0 : count_pll < 3'd 3 ;
  assign clkout_rx = (i_pll_pso_delay | i_pll_standby) ? 1'b0 : clkout_rx_bypass ;
usb2_afe_sm_cdn_sd1000_t16ffc_01_vc176_2xa1xd3xe2y2r afe_sm(
.i_dprpu_en_delayed     (o_dprpu_en_delayed     ),
.i_dmrpu_en_delayed     (o_dmrpu_en_delayed     ),
.i_dprpd_en_delayed     (o_dprpd_en_delayed     ),
.i_dmrpd_en_delayed     (o_dmrpd_en_delayed     ),
.i_hstx_drive_supply    (o_hstx_drive_supply    ),
.i_hstx_drive_supply1   (o_hstx_drive_supply1   ),
.i_hstx_drive_strong    (o_hstx_drive_strong    ),
.i_hstx_dp              (o_hstx_dp),
.i_hstx_dm              (o_hstx_dm),
.i_idm_src_en           (i_idm_src_en),
.i_idp_src_en           (i_idp_src_en),
.i_idm_sink_en          (i_idm_sink_en),
.i_idp_sink_en          (i_idp_sink_en),
.i_fstx_drive_dp        (o_fstx_drive_dp   ),
.i_fstx_drive_dm        (o_fstx_drive_dm    ),
.i_fstx_dp              (o_fstx_dp),
.i_fstx_dm              (o_fstx_dm),
.vbus_drive             (vbus_drive),
.vbus_result            (vbus_result),
.id_drive               (id_drive),
.DP_adp                 (DP_adp),
.DM_adp                 (DM_adp),
.VBUS                   (VBUS),
.ID                     (ID),
.DP                     (DP),
.DM                     (DM)
);
endmodule

`timescale 1ns/1ps
module usb2_afe_sm_cdn_sd1000_t16ffc_01_vc176_2xa1xd3xe2y2r(
input	i_dprpu_en_delayed,
input	i_dmrpu_en_delayed,
input	i_dprpd_en_delayed,
input	i_dmrpd_en_delayed,
input	i_hstx_drive_supply,
input	i_hstx_drive_supply1,
input	i_hstx_drive_strong,
input	i_hstx_dp,
input	i_hstx_dm,
input	i_idm_src_en,
input	i_idp_src_en,
input	i_idm_sink_en,
input	i_idp_sink_en,
input	      	vbus_drive,
input	      	vbus_result,
input	      	id_drive,
input	      	DP_adp,
input	      	DM_adp,
input	      	i_fstx_drive_dp,
input	      	i_fstx_drive_dm,
input  		i_fstx_dp,
input  		i_fstx_dm,
inout	DP,
inout	VBUS,
inout	ID,
inout	DM
);
wire DP_cc, DM_cc;
bufif1 (pull1,pull0) b1(DP,1'b1,i_dprpu_en_delayed);
bufif1 (pull1,pull0) b2(DM,1'b1,i_dmrpu_en_delayed);
bufif1 (pull1,pull0) b1_cc(DP_1c,1'b1,i_dprpu_en_delayed);
bufif1 (pull1,pull0) b2_cc(DM_1c,1'b1,i_dmrpu_en_delayed);
bufif1 (weak1,weak0) b3(DP,1'b0,i_dprpd_en_delayed);
bufif1 (weak1,weak0) b4(DM,1'b0,i_dmrpd_en_delayed);
bufif1 (weak1,weak0) b3_cc(DP_2c,1'b0,i_dprpd_en_delayed);
bufif1 (weak1,weak0) b4_cc(DM_2c,1'b0,i_dmrpd_en_delayed);
bufif1 (supply1,supply0) b5 (DP,i_hstx_dp,i_hstx_drive_supply);
bufif1 (supply1,supply0) b6 (DM,i_hstx_dm,i_hstx_drive_supply);
bufif1 (supply1,supply0) b5_cc (DP_3c,i_hstx_dp,i_hstx_drive_supply);
bufif1 (supply1,supply0) b6_cc (DM_3c,i_hstx_dm,i_hstx_drive_supply);
bufif1 (strong1,strong0) b7 (DP,1'b1,(i_hstx_drive_strong && i_idm_src_en));
bufif1 (strong1,strong0) b8 (DM,1'b1,(i_hstx_drive_strong && i_idp_src_en));
bufif1 (strong1,strong0) b7_cc (DP_4c,1'b1,(i_hstx_drive_strong && i_idm_src_en));
bufif1 (strong1,strong0) b8_cc (DM_4c,1'b1,(i_hstx_drive_strong && i_idp_src_en));
bufif1 (supply1,supply0) b9 (DP,1'bx,i_hstx_drive_supply1);
bufif1 (supply1,supply0) b10 (DM,1'bx,i_hstx_drive_supply1);
bufif1 (supply1,supply0) b9_cc (DP_5c,1'bx,i_hstx_drive_supply1);
bufif1 (supply1,supply0) b10_cc (DM_5c,1'bx,i_hstx_drive_supply1);
bufif1 b15 (VBUS, vbus_result, vbus_drive);
bufif1 (pull1, weak0) b16 (ID, 1'b1, id_drive);
bufif1 (weak1, weak0) b17 (DP, DP_adp, (i_idp_src_en | i_idp_sink_en));
bufif1 (weak1, weak0) b18 (DM, DM_adp, (i_idm_src_en | i_idm_sink_en));
bufif1 (weak1, weak0) b17_cc (DP_7c, DP_adp, (i_idp_src_en | i_idp_sink_en));
bufif1 (weak1, weak0) b18_cc (DM_7c, DM_adp, (i_idm_src_en | i_idm_sink_en));
bufif1 (strong1,strong0) b13 (DP,i_fstx_dp,i_fstx_drive_dp);
bufif1 (strong1,strong0) b14 (DM,i_fstx_dm,i_fstx_drive_dm);
bufif1 (strong1,strong0) b13_cc (DP_6c,i_fstx_dp,i_fstx_drive_dp);
bufif1 (strong1,strong0) b14_cc (DM_6c,i_fstx_dm,i_fstx_drive_dm);
endmodule
