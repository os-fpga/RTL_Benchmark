/*##########################################################################################
  Copyright (c) 2022 Dolphin Technology, Inc.
  This verilog is proprietary and confidential information of
  Dolphin Technology, Inc. and can only be used or viewed
  under license or with written permission from Dolphin Technology, Inc.
  Date:    6/1/2022 18:11:13
##########################################################################################*/
`timescale 1ns/1ps

module dti_tm16ffc_18ud15_lpd4_comp_jme (
TSTIO_PCTLH,  
TSTIO_NCTLH,  
BYP_P,  
BYP_N,  
IO_MODE,
CLK,  
CLKG,
UPDT_C,  
BYP_EN,  
NBC,  
COMP_IN,  
MVG_EN,  
EN,  
PBC,  
POR,  
UPDATE_EN,  
PD,  
SEL,
NCTLH,  
PCTLH,  
PWDNH,  
REF,  
VDD, 
VSS, 
VDDO 
); 

output	[11:0] 	TSTIO_PCTLH; 
output	[11:0] 	TSTIO_NCTLH; 
input	[3:0] 	BYP_P;
input	[3:0] 	BYP_N; 
input 		CLK; 
output 		CLKG;
output 		SEL;
input	[2:0]	IO_MODE;
output 		UPDT_C; 
input 		BYP_EN; 
output	[3:0] 	NBC; 
input 		COMP_IN; 
input 		MVG_EN; 
input 		EN; 
output	[3:0] 	PBC; 
input 		POR; 
input 		UPDATE_EN; 
output 		PD; 
output	[11:0] 	NCTLH; 
output	[11:0] 	PCTLH; 
input 		PWDNH; 
input 		REF; 
input 		VDDO; 
input 		VDD; 
input 		VSS; 

wire	[15:0] 	BypVal_p;
wire	[15:0] 	BypVal_n;
wire	[15:0]  pctl16, nctl16;
reg	[15:0]  pctl16_int, nctl16_int;
wire	[15:0]  int_tstio_pctlh, int_tstio_nctlh;
wire 		PD;
reg 		pd_int;

wire 		reset;
reg 		ck_en;
wire 		int_clock;
reg 		clock32;
reg 		ddr4, ddr3, lpddr4;
reg 	[3:0] 	counter_p, counter_n;
reg 	[3:0] 	pctl, nctl;
reg 		updt_p, updt_n;
reg 	[5:0] 	ck_div;
reg		POR_delayed;

initial begin
  POR_delayed = 1'b0;
end

always @ (POR)
  POR_delayed = #(1) POR;

assign PD = pd_int;

assign reset = POR & ~POR_delayed;

always @ (CLK or EN) begin
  if (!CLK)
  ck_en <= EN;
end

assign int_clock = CLK & ck_en;

always @ (posedge int_clock or posedge reset) begin
  if(reset) begin
    ck_div  <= 0;
    clock32 <= 0;
  end
  else begin
    if(ck_div == 6'd16) begin
      clock32 <= ~clock32;
      ck_div  <= 0;
    end
    else
      ck_div <= ck_div + 1;
  end
end


always @ (posedge clock32 or posedge reset) begin
  if(reset) begin
    pd_int <= 1;
    counter_p <= 0;
    counter_n <= 0;
    updt_p    <= 1'b0;
    updt_n    <= 1'b0;
    nctl      <= 0;
    pctl      <= 0;
    pctl16_int    <= 0;
    nctl16_int    <= 0;
  end
  else begin
    pd_int <= (COMP_IN ^ PD) ? pd_int : ~pd_int; 
    if (PD) begin
      if (COMP_IN == 1'b1) begin
	nctl      <= counter_n;
	counter_n <= 4'b0;
	updt_n    <= 1'b1;
	updt_p    <= 1'b0;
      end
      else begin
	counter_n <= counter_n + 1;
	updt_n    <= 1'b0;
	updt_p    <= 1'b0;
      end
    end
    else begin
      if (COMP_IN == 1'b0) begin
	pctl      <= counter_p;
	counter_p <= 4'b0;
	updt_p    <= 1'b1;
	updt_n    <= 1'b0;
      end
      else begin
	counter_p <= counter_p + 1;
	updt_p    <= 1'b0;
	updt_n    <= 1'b0;
      end
    end
    pctl16_int <= UPDATE_EN ? pctl16 : pctl16_int;
    nctl16_int <= UPDATE_EN ? nctl16 : nctl16_int;
  end
end

assign UPDT_C = PD ? updt_p : updt_n;


assign NBC = nctl;
assign PBC = pctl;

conv4b216b x_BYP_P (.IN(BYP_P), .OUT(BypVal_p));
conv4b216b x_BYP_N (.IN(BYP_N), .OUT(BypVal_n));
conv4b216b x_out_p (.IN(pctl), .OUT(pctl16));
conv4b216b x_out_n (.IN(nctl), .OUT(nctl16));
conv4b216b x_counter_p (.IN(counter_p), .OUT(int_tstio_pctlh));
conv4b216b x_counter_n (.IN(counter_n), .OUT(int_tstio_nctlh));

assign TSTIO_NCTLH = PWDNH ? 12'b0 : int_tstio_nctlh[11:0];
assign TSTIO_PCTLH = PWDNH ? 12'b0 : int_tstio_pctlh[11:0];
assign PCTLH = PWDNH ? 12'b0 : (BYP_EN ? BypVal_p[11:0] : pctl16_int[11:0]);
assign NCTLH = PWDNH ? 12'b0 : (BYP_EN ? BypVal_n[11:0] : nctl16_int[11:0]);

assign CLKG = clock32;
assign SEL = 1;


endmodule 

module conv4b216b (IN, OUT);
input   [3:0]   IN;
output  [15:0]  OUT;

reg     [15:0]  out_r;
integer p;

always @ (IN) begin
  for (p=0; p<=IN; p=p+1)
    out_r[p]= 1'b1;
  for (p=(IN+1); p<16; p=p+1)
    out_r[p]= 1'b0;
end

assign OUT = out_r;

endmodule
