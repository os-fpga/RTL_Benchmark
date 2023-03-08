/*##########################################################################################
  Copyright (c) 2022 Dolphin Technology, Inc.
  This verilog is proprietary and confidential information of
  Dolphin Technology, Inc. and can only be used or viewed
  under license or with written permission from Dolphin Technology, Inc.
  Date:    4/13/2022 16:56:55
##########################################################################################*/
`timescale 1ns/1ps

module tm16_pvt (
  CK,
  C_TS,
  C_VM,
  DIV,
  DONE,
  E,
  MEAS,
  PM_C,
  RN,
  TRIM,
  TSTEN,
  TSTOUT,
  TS_OUT,
  VDD,
  VDDO,
  VIN,
  VMRANGE,
  VM_OUT,
  VSS
);

  input			CK;
  input		[8:0]	C_TS;
  input		[8:0]	C_VM;
  input		[3:0]	DIV;
  output		DONE;
  input			E;
  input			MEAS;
  output	[9:0]	PM_C;
  input			RN;
  input		[3:0]	TRIM;
  input		[3:0]	TSTEN;
  output		TSTOUT;
  output		TS_OUT;
  input			VDD;
  input			VDDO;
  input			VIN;
  input			VMRANGE;
  output		VM_OUT;
  input			VSS;

  wire			inet1;
  wire			inet2;
  wire			inet3;
  wire			inet4;
  wire			inet5;
  wire			inet6;
  wire			inet7;
  wire			inet8;
  wire			inet9;
  wire			inet10;
  wire			inet11;
  wire			inet12;
  wire			inet13;
  wire			inet14;
  wire			inet15;
  wire			inet16;
  wire			inet17;
  wire			inet18;
  wire			inet19;
  wire			inet20;
  wire			inet21;
  wire			inet22;
  wire			inet23;
  wire			inet24;
  wire			inet25;
  wire			inet26;
  wire			inet27;
  wire			inet28;
  wire			inet29;
  wire			inet30;
  wire			inet31;
  wire			inet32;
  wire			inet33;
  wire			inet34;
  wire			inet35;
  wire			inet36;
  wire			inet37;
  wire			inet38;
  wire			inet39;
  wire			inet40;
  wire			inet41;
  wire			inet42;
  wire			inet43;
  wire			inet44;
  wire			inet45;
  wire			inet46;
  wire			inet47;
  wire			inet48;
  wire			inet49;
  wire			inet50;
  wire			inet51;
  wire			inet52;
  wire			inet53;
  wire			inet54;
  wire			inet55;
  wire			inet56;
  wire			inet57;
  wire			inet58;
  wire			inet59;
  wire			inet60;
  wire			inet61;
  wire			inet62;
  wire			inet63;
  wire			inet64;
  wire			inet65;
  wire			inet66;
  wire			inet67;
  wire			inet68;
  wire			inet69;
  wire			inet70;
  wire			inet71;
  wire			inet72;
  wire			inet73;
  wire			inet74;
  wire			inet75;
  wire			inet76;
  wire			inet77;
  wire			inet78;
  wire			inet79;
  wire			inet80;
  wire			inet81;
  wire			inet82;
  wire			inet83;
  wire			inet84;
  wire			inet85;
  wire			inet86;
  wire			inet87;
  wire			inet88;
  wire			inet89;
  wire			inet90;
  wire			inet91;
  wire			inet92;
  wire			inet93;
  wire			inet94;
  wire			inet95;
  wire			inet96;
  wire			inet97;
  wire			inet98;
  wire			inet99;
  wire			inet100;
  wire			inet101;
  wire			inet102;
  wire			inet103;
  wire			inet104;
  wire			inet105;
  wire			inet106;
  wire			inet107;
  wire			inet108;
  wire			inet109;
  wire			inet110;
  wire			inet111;
  wire			inet112;
  wire			inet113;
  wire			inet114;
  wire			inet115;
  wire			inet116;
  wire			inet117;
  wire			inet118;
  wire			inet119;
  wire			inet120;
  wire			inet121;
  wire			inet122;
  wire			inet123;
  wire			inet124;
  wire			inet125;
  wire			inet126;
  wire			inet127;
  wire			inet128;
  wire			inet129;
  wire			inet130;
  wire			inet131;
  wire			inet132;
  wire			inet133;
  wire			inet134;
  wire			inet135;
  wire			inet136;
  wire			inet137;
  wire			inet138;
  wire			inet139;
  wire			inet140;
  wire			inet141;
  wire			inet142;
  wire			inet143;
  wire			inet144;
  wire			inet145;
  wire			inet146;
  wire			inet147;
  wire			inet148;
  wire			inet149;

  dti_16f_9t_96_xnor2x1 xinst1 (
    .A(inet1 ),
    .B(inet2 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet3 )
  );

  dti_16f_9t_96_xnor2x1 xinst2 (
    .A(inet4 ),
    .B(DIV[1] ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet5 )
  );

  dti_16f_9t_96_nor2i1x1 xinst3 (
    .A(inet6 ),
    .B(inet7 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet8 )
  );

  dti_16f_9t_96_bufx2 xinst4 (
    .A(inet9 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(PM_C[3] )
  );

  dti_16f_9t_96_xor2x1 xinst5 (
    .A(inet10 ),
    .B(inet11 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet12 )
  );

  dti_16f_9t_96_soffqena01x1 xinst6 (
    .CE(inet13 ),
    .CK(inet14 ),
    .D(inet15 ),
    .Q(inet16 ),
    .RN(inet17 ),
    .SD(inet18 ),
    .SE(inet19 ),
    .SO(inet20 ),
    .VDD(VDD ),
    .VSS(VSS )
  );

  dti_16f_9t_96_bufx2 xinst7 (
    .A(inet21 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(PM_C[5] )
  );

  dti_16f_9t_96_soffqa01x1 xinst8 (
    .CK(CK ),
    .D(inet22 ),
    .Q(inet23 ),
    .RN(RN ),
    .SD(inet24 ),
    .SE(inet25 ),
    .SO(inet26 ),
    .VDD(VDD ),
    .VSS(VSS )
  );

  dti_16f_9t_96_bufx2 xinst9 (
    .A(inet27 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet28 )
  );

  dti_16f_9t_96_ckbufx2 xinst10 (
    .A(CK ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet14 )
  );

  dti_16f_9t_96_nand2x1 xinst11 (
    .A(inet29 ),
    .B(inet21 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet1 )
  );

  dti_16f_9t_96_bufx2 xinst12 (
    .A(inet30 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(PM_C[2] )
  );

  dti_16f_9t_96_invx1 xinst13 (
    .A(inet31 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet32 )
  );

  dti_16f_9t_96_bufx2 xinst14 (
    .A(inet33 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(PM_C[9] )
  );

  tm16_pmon_lvlsh xinst15 (
    .IN(inet22 ),
    .OUT(inet34 ),
    .VDDIN(VDD ),
    .VDDOUT(inet35 ),
    .VSS(VSS )
  );

  dti_16f_9t_96_soffqena01x1 xinst16 (
    .CE(inet28 ),
    .CK(inet36 ),
    .D(inet37 ),
    .Q(inet33 ),
    .RN(inet38 ),
    .SD(inet39 ),
    .SE(inet40 ),
    .SO(inet41 ),
    .VDD(VDD ),
    .VSS(VSS )
  );

  dti_16f_9t_96_soffqa01x1 xinst17 (
    .CK(inet42 ),
    .D(inet43 ),
    .Q(inet44 ),
    .RN(inet45 ),
    .SD(inet46 ),
    .SE(inet25 ),
    .SO(inet47 ),
    .VDD(VDD ),
    .VSS(VSS )
  );

  dti_16f_9t_96_bufx2 xinst18 (
    .A(inet48 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(PM_C[0] )
  );

  dti_16f_9t_96_xnor2x1 xinst19 (
    .A(inet49 ),
    .B(inet50 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet51 )
  );

  dti_16f_9t_96_invx1 xinst20 (
    .A(inet52 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet53 )
  );

  dti_16f_9t_96_xor2x1 xinst21 (
    .A(inet54 ),
    .B(inet33 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet37 )
  );

  dti_16f_9t_96_invx1 xinst22 (
    .A(inet55 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet56 )
  );

  dti_16f_9t_96_nor2x1 xinst23 (
    .A(inet57 ),
    .B(inet58 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet59 )
  );

  dti_16f_9t_96_soffqena01x1 xinst24 (
    .CE(inet13 ),
    .CK(inet14 ),
    .D(inet60 ),
    .Q(inet6 ),
    .RN(inet17 ),
    .SD(inet61 ),
    .SE(inet19 ),
    .SO(inet62 ),
    .VDD(VDD ),
    .VSS(VSS )
  );

  dti_16f_9t_96_soffqa01x1 xinst25 (
    .CK(inet42 ),
    .D(inet59 ),
    .Q(inet63 ),
    .RN(inet45 ),
    .SD(inet64 ),
    .SE(inet25 ),
    .SO(inet65 ),
    .VDD(VDD ),
    .VSS(VSS )
  );

  dti_16f_9t_96_nor2x1 xinst26 (
    .A(inet44 ),
    .B(inet58 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet43 )
  );

  dti_16f_9t_96_nand2x1 xinst27 (
    .A(inet66 ),
    .B(inet9 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet67 )
  );

  dti_16f_9t_96_soffqena01x1 xinst28 (
    .CE(inet13 ),
    .CK(inet14 ),
    .D(inet51 ),
    .Q(inet50 ),
    .RN(inet17 ),
    .SD(inet68 ),
    .SE(inet19 ),
    .SO(inet69 ),
    .VDD(VDD ),
    .VSS(VSS )
  );

  dti_16f_9t_96_xnor2x1 xinst29 (
    .A(inet44 ),
    .B(DIV[0] ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet70 )
  );

  dti_16f_9t_96_nor2i1x1 xinst30 (
    .A(inet30 ),
    .B(inet71 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet66 )
  );

  tm16_pmon_ckout xinst31 (
    .IN(inet72 ),
    .OUT(inet73 ),
    .VDD(VDD ),
    .VDDIN(inet35 ),
    .VSS(VSS )
  );

  dti_16f_9t_96_soffqena01x1 xinst32 (
    .CE(inet28 ),
    .CK(inet36 ),
    .D(inet74 ),
    .Q(inet48 ),
    .RN(inet38 ),
    .SD(inet25 ),
    .SE(inet40 ),
    .SO(inet75 ),
    .VDD(VDD ),
    .VSS(VSS )
  );

  dti_16f_9t_96_nor2x1 xinst33 (
    .A(inet76 ),
    .B(inet58 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet77 )
  );

  dti_16f_9t_96_bufx2 xinst34 (
    .A(inet78 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet79 )
  );

  dti_16f_9t_96_soffqa10x1 xinst35 (
    .CK(inet73 ),
    .D(inet56 ),
    .Q(inet80 ),
    .SD(inet25 ),
    .SE(inet25 ),
    .SN(inet45 ),
    .SO(inet81 ),
    .VDD(VDD ),
    .VSS(VSS )
  );

  dti_16f_9t_96_bufx2 xinst36 (
    .A(inet82 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(PM_C[4] )
  );

  dti_16f_9t_96_nor2i1x1 xinst37 (
    .A(inet83 ),
    .B(inet84 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet85 )
  );

  dti_16f_9t_96_soffqa01x1 xinst38 (
    .CK(CK ),
    .D(inet86 ),
    .Q(inet87 ),
    .RN(RN ),
    .SD(inet88 ),
    .SE(inet25 ),
    .SO(inet89 ),
    .VDD(VDD ),
    .VSS(VSS )
  );

  dti_16f_9t_96_nand2i1x1 xinst39 (
    .A(inet90 ),
    .B(inet22 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet45 )
  );

  dti_16f_9t_96_tierailx1 xinst40 (
    .HI(inet27 ),
    .LO(inet25 ),
    .VDD(VDD ),
    .VSS(VSS )
  );

  dti_16f_9t_96_invx1 xinst41 (
    .A(inet48 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet74 )
  );

  dti_16f_9t_96_soffqena01x1 xinst42 (
    .CE(inet13 ),
    .CK(inet14 ),
    .D(inet91 ),
    .Q(inet92 ),
    .RN(inet17 ),
    .SD(inet20 ),
    .SE(inet19 ),
    .SO(inet78 ),
    .VDD(VDD ),
    .VSS(VSS )
  );

  dti_16f_9t_96_soffqena01x1 xinst43 (
    .CE(inet28 ),
    .CK(inet36 ),
    .D(inet3 ),
    .Q(inet2 ),
    .RN(inet38 ),
    .SD(inet93 ),
    .SE(inet40 ),
    .SO(inet94 ),
    .VDD(VDD ),
    .VSS(VSS )
  );

  dti_16f_9t_96_soffqena01x1 xinst44 (
    .CE(inet13 ),
    .CK(inet14 ),
    .D(inet95 ),
    .Q(inet31 ),
    .RN(inet17 ),
    .SD(inet62 ),
    .SE(inet19 ),
    .SO(inet68 ),
    .VDD(VDD ),
    .VSS(VSS )
  );

  dti_16f_9t_96_soffqena01x1 xinst45 (
    .CE(inet13 ),
    .CK(inet14 ),
    .D(inet53 ),
    .Q(inet52 ),
    .RN(inet17 ),
    .SD(inet25 ),
    .SE(inet19 ),
    .SO(inet96 ),
    .VDD(VDD ),
    .VSS(VSS )
  );

  dti_16f_9t_96_nor2i1x1 xinst46 (
    .A(inet16 ),
    .B(inet97 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet98 )
  );

  dti_16f_9t_96_xor2x1 xinst47 (
    .A(inet48 ),
    .B(inet99 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet100 )
  );

  dti_16f_9t_96_invx1 xinst48 (
    .A(inet50 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet101 )
  );

  dti_16f_9t_96_soffqena01x1 xinst49 (
    .CE(inet28 ),
    .CK(inet36 ),
    .D(inet102 ),
    .Q(inet30 ),
    .RN(inet38 ),
    .SD(inet103 ),
    .SE(inet40 ),
    .SO(inet104 ),
    .VDD(VDD ),
    .VSS(VSS )
  );

  dti_16f_9t_96_soffqa01x1 xinst50 (
    .CK(inet42 ),
    .D(inet77 ),
    .Q(inet4 ),
    .RN(inet45 ),
    .SD(inet47 ),
    .SE(inet25 ),
    .SO(inet105 ),
    .VDD(VDD ),
    .VSS(VSS )
  );

  dti_16f_9t_96_bufx4 xinst51 (
    .A(inet55 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(DONE )
  );

  dti_16f_9t_96_nand2x1 xinst52 (
    .A(inet8 ),
    .B(inet31 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet49 )
  );

  dti_16f_9t_96_soffqena01x1 xinst53 (
    .CE(inet13 ),
    .CK(inet14 ),
    .D(inet106 ),
    .Q(inet107 ),
    .RN(inet17 ),
    .SD(inet96 ),
    .SE(inet19 ),
    .SO(inet61 ),
    .VDD(VDD ),
    .VSS(VSS )
  );

  dti_16f_9t_96_bufx2 xinst54 (
    .A(inet65 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet108 )
  );

  dti_16f_9t_96_nor2x1 xinst55 (
    .A(inet109 ),
    .B(inet58 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet110 )
  );

  dti_16f_9t_96_bufx1 xinst56 (
    .A(inet111 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet46 )
  );

  dti_16f_9t_96_soffqa01x1 xinst57 (
    .CK(CK ),
    .D(inet87 ),
    .Q(inet90 ),
    .RN(RN ),
    .SD(inet89 ),
    .SE(inet25 ),
    .SO(inet112 ),
    .VDD(VDD ),
    .VSS(VSS )
  );

  dti_16f_9t_96_invx1 xinst58 (
    .A(inet6 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet113 )
  );

  dti_16f_9t_96_soffqena01x1 xinst59 (
    .CE(inet28 ),
    .CK(inet36 ),
    .D(inet114 ),
    .Q(inet82 ),
    .RN(inet38 ),
    .SD(inet115 ),
    .SE(inet40 ),
    .SO(inet116 ),
    .VDD(VDD ),
    .VSS(VSS )
  );

  dti_16f_9t_96_and2x1 xinst60 (
    .A(inet117 ),
    .B(inet118 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet119 )
  );

  dti_16f_9t_96_nand2x1 xinst61 (
    .A(inet44 ),
    .B(inet4 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet84 )
  );

  dti_16f_9t_96_soffqena01x1 xinst62 (
    .CE(inet28 ),
    .CK(inet36 ),
    .D(inet120 ),
    .Q(inet9 ),
    .RN(inet38 ),
    .SD(inet104 ),
    .SE(inet40 ),
    .SO(inet115 ),
    .VDD(VDD ),
    .VSS(VSS )
  );

  tm16_pmon_reg xinst63 (
    .NB1(inet121 ),
    .NB2(inet122 ),
    .PB1(inet123 ),
    .REF(inet124 ),
    .TSTEN(TSTEN[3] ),
    .TSTOUT(TSTOUT ),
    .VDD(VDD ),
    .VDDO(VDDO ),
    .VDDR(inet35 ),
    .VSS(VSS )
  );

  dti_16f_9t_96_soffqa01x1 xinst64 (
    .CK(CK ),
    .D(inet45 ),
    .Q(inet125 ),
    .RN(RN ),
    .SD(inet112 ),
    .SE(inet25 ),
    .SO(inet126 ),
    .VDD(VDD ),
    .VSS(VSS )
  );

  dti_16f_9t_96_soffqena01x1 xinst65 (
    .CE(inet28 ),
    .CK(inet36 ),
    .D(inet127 ),
    .Q(inet128 ),
    .RN(inet38 ),
    .SD(inet129 ),
    .SE(inet40 ),
    .SO(inet39 ),
    .VDD(VDD ),
    .VSS(VSS )
  );

  dti_16f_9t_96_xor2x1 xinst66 (
    .A(inet98 ),
    .B(inet92 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet91 )
  );

  dti_16f_9t_96_soffqa01x1 xinst67 (
    .CK(CK ),
    .D(inet23 ),
    .Q(inet86 ),
    .RN(RN ),
    .SD(inet26 ),
    .SE(inet25 ),
    .SO(inet88 ),
    .VDD(VDD ),
    .VSS(VSS )
  );

  dti_16f_9t_96_bufx2 xinst68 (
    .A(inet128 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(PM_C[8] )
  );

  dti_16f_9t_96_bufx2 xinst69 (
    .A(inet2 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(PM_C[6] )
  );

  dti_16f_9t_96_soffqa01x1 xinst70 (
    .CK(inet42 ),
    .D(inet110 ),
    .Q(inet83 ),
    .RN(inet45 ),
    .SD(inet105 ),
    .SE(inet25 ),
    .SO(inet64 ),
    .VDD(VDD ),
    .VSS(VSS )
  );

  dti_16f_9t_96_bufx2 xinst71 (
    .A(inet45 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet38 )
  );

  dti_16f_9t_96_xnor2x1 xinst72 (
    .A(inet130 ),
    .B(inet128 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet127 )
  );

  dti_16f_9t_96_soffqena01x1 xinst73 (
    .CE(inet28 ),
    .CK(inet36 ),
    .D(inet100 ),
    .Q(inet99 ),
    .RN(inet38 ),
    .SD(inet75 ),
    .SE(inet40 ),
    .SO(inet103 ),
    .VDD(VDD ),
    .VSS(VSS )
  );

  dti_16f_9t_96_xnor2x1 xinst74 (
    .A(inet85 ),
    .B(inet63 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet57 )
  );

  dti_16f_9t_96_xnor2x1 xinst75 (
    .A(inet63 ),
    .B(DIV[3] ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet131 )
  );

  dti_16f_9t_96_tierailx1 xinst76 (
    .HI(inet132 ),
    .LO(inet133 ),
    .VDD(VDD ),
    .VSS(VSS )
  );

  dti_16f_9t_96_nor2i1x1 xinst77 (
    .A(inet2 ),
    .B(inet1 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet10 )
  );

  dti_16f_9t_96_xnor2x1 xinst78 (
    .A(inet71 ),
    .B(inet30 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet102 )
  );

  dti_16f_9t_96_xor2x1 xinst79 (
    .A(inet84 ),
    .B(inet83 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet109 )
  );

  dti_16f_9t_96_bufx2 xinst80 (
    .A(inet11 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(PM_C[7] )
  );

  dti_16f_9t_96_xor2x1 xinst81 (
    .A(inet134 ),
    .B(inet135 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet136 )
  );

  dti_16f_9t_96_bufx2 xinst82 (
    .A(inet25 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet40 )
  );

  dti_16f_9t_96_xnor2x1 xinst83 (
    .A(inet7 ),
    .B(inet6 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet60 )
  );

  dti_16f_9t_96_nand2x1 xinst84 (
    .A(inet10 ),
    .B(inet11 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet130 )
  );

  dti_16f_9t_96_soffqa01x1 xinst85 (
    .CK(CK ),
    .D(MEAS ),
    .Q(inet22 ),
    .RN(RN ),
    .SD(inet25 ),
    .SE(inet25 ),
    .SO(inet24 ),
    .VDD(VDD ),
    .VSS(VSS )
  );

  dti_16f_9t_96_gcklbufsx2 xinst86 (
    .CK(inet42 ),
    .CKOUT(inet137 ),
    .EN(inet138 ),
    .SE(inet25 ),
    .VDD(VDD ),
    .VSS(VSS )
  );

  dti_16f_9t_96_soffqena01x1 xinst87 (
    .CE(inet13 ),
    .CK(inet14 ),
    .D(inet136 ),
    .Q(inet135 ),
    .RN(inet17 ),
    .SD(inet69 ),
    .SE(inet19 ),
    .SO(inet18 ),
    .VDD(VDD ),
    .VSS(VSS )
  );

  dti_16f_9t_96_gcklbufsx2 xinst88 (
    .CK(inet73 ),
    .CKOUT(inet42 ),
    .EN(inet119 ),
    .SE(inet25 ),
    .VDD(VDD ),
    .VSS(VSS )
  );

  dti_16f_9t_96_xnor2x1 xinst89 (
    .A(inet44 ),
    .B(inet4 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet76 )
  );

  dti_16f_9t_96_invx1 xinst90 (
    .A(inet117 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet139 )
  );

  dti_16f_9t_96_and8x1 xinst91 (
    .A(inet101 ),
    .B(inet16 ),
    .C(inet135 ),
    .D(inet132 ),
    .E(inet32 ),
    .F(inet113 ),
    .G(inet107 ),
    .H(inet52 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet140 )
  );

  dti_16f_9t_96_ckbufx2 xinst92 (
    .A(inet137 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet36 )
  );

  dti_16f_9t_96_bufx2 xinst93 (
    .A(inet99 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(PM_C[1] )
  );

  dti_16f_9t_96_bufx2 xinst94 (
    .A(inet25 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet19 )
  );

  dti_16f_9t_96_xnor2x1 xinst95 (
    .A(inet83 ),
    .B(DIV[2] ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet141 )
  );

  dti_16f_9t_96_xor2x1 xinst96 (
    .A(inet8 ),
    .B(inet31 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet95 )
  );

  tm16_pmon_rosc xinst97 (
    .EN(inet34 ),
    .OUT(inet72 ),
    .VDDR(inet35 ),
    .VSS(VSS )
  );

  dti_16f_9t_96_bufx1 xinst98 (
    .A(inet142 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet111 )
  );

  dti_16f_9t_96_soffqena01x1 xinst99 (
    .CE(inet28 ),
    .CK(inet36 ),
    .D(inet143 ),
    .Q(inet21 ),
    .RN(inet38 ),
    .SD(inet116 ),
    .SE(inet40 ),
    .SO(inet93 ),
    .VDD(VDD ),
    .VSS(VSS )
  );

  dti_16f_9t_96_soffqa10x1 xinst100 (
    .CK(inet73 ),
    .D(inet80 ),
    .Q(inet118 ),
    .SD(inet81 ),
    .SE(inet25 ),
    .SN(inet45 ),
    .SO(inet144 ),
    .VDD(VDD ),
    .VSS(VSS )
  );

  dti_16f_9t_96_xor2x1 xinst101 (
    .A(inet66 ),
    .B(inet9 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet120 )
  );

  tm16_vmon_adc xinst102 (
    .BIAS(inet145 ),
    .C({C_VM[8],C_VM[7],C_VM[6],C_VM[5],C_VM[4],C_VM[3],C_VM[2],C_VM[1],C_VM[0] }),
    .CMPOUT(VM_OUT ),
    .E(E ),
    .NB1(inet121 ),
    .NB2(inet122 ),
    .PB1(inet123 ),
    .PB2(inet146 ),
    .TSTEN(TSTEN[2] ),
    .TSTOUT(TSTOUT ),
    .VDD(VDD ),
    .VDDO(VDDO ),
    .VIN(VIN ),
    .VMRANGE(VMRANGE ),
    .VSS(VSS )
  );

  tm16_pvt_bias xinst103 (
    .B(inet147 ),
    .BIAS(inet145 ),
    .E(E ),
    .EH(inet148 ),
    .NB1(inet121 ),
    .NB2(inet122 ),
    .PB1(inet123 ),
    .PB2(inet146 ),
    .REF(inet124 ),
    .TRIM({TRIM[3],TRIM[2],TRIM[1],TRIM[0] }),
    .TSTEN(TSTEN[0] ),
    .TSTOUT(TSTOUT ),
    .VDD(VDD ),
    .VDDO(VDDO ),
    .VSS(VSS )
  );

  tm16_ts_adc xinst104 (
    .BG(inet147 ),
    .BIAS(inet145 ),
    .C({C_TS[8],C_TS[7],C_TS[6],C_TS[5],C_TS[4],C_TS[3],C_TS[2],C_TS[1],C_TS[0] }),
    .CMPOUT(TS_OUT ),
    .E(E ),
    .EH(inet148 ),
    .NB1(inet121 ),
    .NB2(inet122 ),
    .PB1(inet123 ),
    .PB2(inet146 ),
    .TSTEN(TSTEN[1] ),
    .TSTOUT(TSTOUT ),
    .VDD(VDD ),
    .VDDO(VDDO ),
    .VSS(VSS )
  );

  dti_16f_9t_96_soffqena01x1 xinst105 (
    .CE(inet28 ),
    .CK(inet36 ),
    .D(inet12 ),
    .Q(inet11 ),
    .RN(inet38 ),
    .SD(inet94 ),
    .SE(inet40 ),
    .SO(inet129 ),
    .VDD(VDD ),
    .VSS(VSS )
  );

  dti_16f_9t_96_xor2x1 xinst106 (
    .A(inet29 ),
    .B(inet21 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet143 )
  );

  dti_16f_9t_96_and4x1 xinst107 (
    .A(inet131 ),
    .B(inet141 ),
    .C(inet5 ),
    .D(inet70 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet138 )
  );

  dti_16f_9t_96_xnor2x1 xinst108 (
    .A(inet67 ),
    .B(inet82 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet114 )
  );

  dti_16f_9t_96_xor2x1 xinst109 (
    .A(inet52 ),
    .B(inet107 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet106 )
  );

  dti_16f_9t_96_nor2i1x1 xinst110 (
    .A(inet50 ),
    .B(inet49 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet134 )
  );

  dti_16f_9t_96_xnor2x1 xinst111 (
    .A(inet97 ),
    .B(inet16 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet15 )
  );

  dti_16f_9t_96_nor2i1x2 xinst112 (
    .A(inet125 ),
    .B(inet140 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet13 )
  );

  dti_16f_9t_96_nand2x1 xinst113 (
    .A(inet52 ),
    .B(inet107 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet7 )
  );

  dti_16f_9t_96_nand2x1 xinst114 (
    .A(inet134 ),
    .B(inet135 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet97 )
  );

  dti_16f_9t_96_soffqa10x1 xinst115 (
    .CK(inet73 ),
    .D(inet139 ),
    .Q(inet117 ),
    .SD(inet144 ),
    .SE(inet25 ),
    .SN(inet45 ),
    .SO(inet142 ),
    .VDD(VDD ),
    .VSS(VSS )
  );

  dti_16f_9t_96_bufx2 xinst116 (
    .A(inet140 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet55 )
  );

  dti_16f_9t_96_bufx2 xinst117 (
    .A(inet138 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet58 )
  );

  dti_16f_9t_96_nor2i1x1 xinst118 (
    .A(inet128 ),
    .B(inet130 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet54 )
  );

  dti_16f_9t_96_nand2x1 xinst119 (
    .A(inet48 ),
    .B(inet99 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet71 )
  );

  dti_16f_9t_96_bufx2 xinst120 (
    .A(inet45 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet17 )
  );

  dti_16f_9t_96_bufx2 xinst121 (
    .A(inet41 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet149 )
  );

  dti_16f_9t_96_nor2i1x1 xinst122 (
    .A(inet82 ),
    .B(inet67 ),
    .VDD(VDD ),
    .VSS(VSS ),
    .Z(inet29 )
  );

endmodule
