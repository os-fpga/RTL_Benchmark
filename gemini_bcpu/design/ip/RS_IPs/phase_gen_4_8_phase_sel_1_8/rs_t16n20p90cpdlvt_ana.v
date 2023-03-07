////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`timescale 1ns/1ps
module RS_CKND4BWP20P90CPDLVT (I, ZN, VDD, VSS, VPP, VBB);
    inout VDD;
    inout VSS;
    inout VPP;
    inout VBB;
    input I;
    output ZN;
    not (ZN_pwr_net, I);
    rs_u_power_down_sum iZN (ZN, ZN_pwr_net, Vsum);
    not (nVSS, VSS);
    not (nVBB, VBB);
    and (Vsum, VDD, nVSS, VPP, nVBB);

  specify
    (I => ZN) = (0, 0);
  endspecify
endmodule
module RS_MUX2D1BWP20P90CPDLVT (I0, I1, S, Z, VDD, VSS, VPP, VBB);
    inout VDD;
    inout VSS;
    inout VPP;
    inout VBB;
    input I0, I1, S;
    output Z;
    rs_mux (Z_pwr_net, I0, I1, S);
    rs_u_power_down_sum iZ (Z, Z_pwr_net, Vsum);
    not (nVSS, VSS);
    not (nVBB, VBB);
    and (Vsum, VDD, nVSS, VPP, nVBB);

  specify
    if (I1 == 1'b1 && S == 1'b0)
    (I0 => Z) = (0, 0);
    if (I1 == 1'b0 && S == 1'b0)
    (I0 => Z) = (0, 0);
    if (I0 == 1'b1 && S == 1'b1)
    (I1 => Z) = (0, 0);
    if (I0 == 1'b0 && S == 1'b1)
    (I1 => Z) = (0, 0);
    if (I0 == 1'b0 && I1 == 1'b1)
    (S => Z) = (0, 0);
    if (I0 == 1'b1 && I1 == 1'b0)
    (S => Z) = (0, 0);
  endspecify
endmodule
module RS_DFNCNQD2BWP20P90CPDLVT (D, CPN, CDN, Q, VDD, VSS, VPP, VBB);
    inout VDD;
    inout VSS;
    inout VPP;
    inout VBB;
    input D, CPN, CDN;
    output Q;
    reg notifier;
    `ifdef NTC
        `ifdef RECREM
            wire CDN_d;
            buf (CDN_i, CDN_d);
        `else
            buf (CDN_i, CDN);
        `endif
        wire D_d, CPN_d;
        pullup (SDN);
        not (CP, CPN_d);
        rs_dff_pwr (Q_buf, D_d, CP, CDN_i, SDN, notifier, Vsum);
        buf (Q_pwr_net, Q_buf);
        rs_u_power_down_sum iQ (Q, Q_pwr_net, Vsum);
    `else
        buf (CDN_i, CDN);
        pullup (SDN);
        not (CP, CPN);
        rs_dff_pwr (Q_buf, D, CP, CDN_i, SDN, notifier, Vsum);
        buf (Q_pwr_net, Q_buf);
        rs_u_power_down_sum iQ (Q, Q_pwr_net, Vsum);
    `endif
    not (nVSS, VSS);
    not (nVBB, VBB);
    and (Vsum, VDD, nVSS, VPP, nVBB);

  `ifdef TETRAMAX
  `else
    rs_xbuf (CDN_SDFCHK, CDN, 1'b1);
    rs_xbuf (D_SDFCHK, D, 1'b1);
    rs_xbuf (CPN_D_SDFCHK, CPN_D, 1'b1);
    rs_xbuf (CPN_nD_SDFCHK, CPN_nD, 1'b1);
    rs_xbuf (nCPN_D_SDFCHK, nCPN_D, 1'b1);
    rs_xbuf (nCPN_nD_SDFCHK, nCPN_nD, 1'b1);
    rs_xbuf (CDN_D_SDFCHK, CDN_D, 1'b1);
    rs_xbuf (CDN_nD_SDFCHK, CDN_nD, 1'b1);
    not (nD, D);
    not (nCPN, CPN);
    and (CPN_D, CPN, D);
    and (CPN_nD, CPN, nD);
    and (nCPN_D, nCPN, D);
    and (nCPN_nD, nCPN, nD);
    and (CDN_D, CDN, D);
    and (CDN_nD, CDN, nD);


    buf  (CPN_check, CDN_i);
    buf  (D_check, CDN_i);
    rs_xbuf (CPN_DEFCHK, CPN_check, 1'b1);
    rs_xbuf (D_DEFCHK, D_check, 1'b1);

  specify
    if (CPN == 1'b1 && D == 1'b1)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CPN == 1'b1 && D == 1'b0)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CPN == 1'b0 && D == 1'b1)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CPN == 1'b0 && D == 1'b0)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    (negedge CPN => (Q+:D)) = (0, 0);
    $width (negedge CDN &&& CPN_D_SDFCHK, 0, 0, notifier);
    $width (negedge CDN &&& CPN_nD_SDFCHK, 0, 0, notifier);
    $width (negedge CDN &&& nCPN_D_SDFCHK, 0, 0, notifier);
    $width (negedge CDN &&& nCPN_nD_SDFCHK, 0, 0, notifier);
    $width (posedge CPN &&& CDN_D_SDFCHK, 0, 0, notifier);
    $width (negedge CPN &&& CDN_D_SDFCHK, 0, 0, notifier);
    $width (posedge CPN &&& CDN_nD_SDFCHK, 0, 0, notifier);
    $width (negedge CPN &&& CDN_nD_SDFCHK, 0, 0, notifier);
  `ifdef NTC
    `ifdef RECREM
      $setuphold (negedge CPN &&& CDN_SDFCHK, posedge D , 0, 0, notifier,,, CPN_d, D_d);
      $setuphold (negedge CPN &&& CDN_SDFCHK, negedge D , 0, 0, notifier,,, CPN_d, D_d);
      $recrem (posedge CDN &&& D_SDFCHK, negedge CPN &&& D_SDFCHK, 0,0, notifier, , , CDN_d, CPN_d);
    `else
      $setuphold (negedge CPN &&& CDN_SDFCHK, posedge D , 0, 0, notifier,,, CPN_d, D_d);
      $setuphold (negedge CPN &&& CDN_SDFCHK, negedge D , 0, 0, notifier,,, CPN_d, D_d);
      $recovery (posedge CDN &&& D_SDFCHK, negedge CPN &&& D_SDFCHK, 0, notifier);
      $hold (negedge CPN &&& D_SDFCHK, posedge CDN , 0, notifier);
    `endif
  `else
    $setuphold (negedge CPN &&& CDN_SDFCHK, posedge D , 0, 0, notifier);
    $setuphold (negedge CPN &&& CDN_SDFCHK, negedge D , 0, 0, notifier);
    $recovery (posedge CDN &&& D_SDFCHK, negedge CPN &&& D_SDFCHK, 0, notifier);
    $hold (negedge CPN &&& D_SDFCHK, posedge CDN , 0, notifier);
  `endif
  endspecify
  `endif
endmodule

module RS_DFCNQD2BWP20P90CPDLVT (D, CP, CDN, Q, VDD, VSS, VPP, VBB);
    inout VDD;
    inout VSS;
    inout VPP;
    inout VBB;
    input D, CP, CDN;
    output Q;
    reg notifier;
    `ifdef NTC
        `ifdef RECREM
            wire CDN_d;
            buf (CDN_i, CDN_d);
        `else
            buf (CDN_i, CDN);
        `endif
        wire D_d, CP_d;
        pullup (SDN);
        rs_dff_pwr (Q_buf, D_d, CP_d, CDN_i, SDN, notifier, Vsum);
        buf (Q_pwr_net, Q_buf);
        rs_u_power_down_sum iQ (Q, Q_pwr_net, Vsum);
    `else
        buf (CDN_i, CDN);
        pullup (SDN);
        rs_dff_pwr (Q_buf, D, CP, CDN_i, SDN, notifier, Vsum);
        buf (Q_pwr_net, Q_buf);
        rs_u_power_down_sum iQ (Q, Q_pwr_net, Vsum);
    `endif
    not (nVSS, VSS);
    not (nVBB, VBB);
    and (Vsum, VDD, nVSS, VPP, nVBB);

  `ifdef TETRAMAX
  `else
    rs_xbuf (CDN_SDFCHK, CDN, 1'b1);
    rs_xbuf (D_SDFCHK, D, 1'b1);
    rs_xbuf (CP_D_SDFCHK, CP_D, 1'b1);
    rs_xbuf (CP_nD_SDFCHK, CP_nD, 1'b1);
    rs_xbuf (nCP_D_SDFCHK, nCP_D, 1'b1);
    rs_xbuf (nCP_nD_SDFCHK, nCP_nD, 1'b1);
    rs_xbuf (CDN_D_SDFCHK, CDN_D, 1'b1);
    rs_xbuf (CDN_nD_SDFCHK, CDN_nD, 1'b1);
    not (nD, D);
    not (nCP, CP);
    and (CP_D, CP, D);
    and (CP_nD, CP, nD);
    and (nCP_D, nCP, D);
    and (nCP_nD, nCP, nD);
    and (CDN_D, CDN, D);
    and (CDN_nD, CDN, nD);


    buf  (CP_check, CDN_i);
    buf  (D_check, CDN_i);
    rs_xbuf (CP_DEFCHK, CP_check, 1'b1);
    rs_xbuf (D_DEFCHK, D_check, 1'b1);

  specify
    if (CP == 1'b1 && D == 1'b1)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CP == 1'b1 && D == 1'b0)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CP == 1'b0 && D == 1'b1)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    if (CP == 1'b0 && D == 1'b0)
    (negedge CDN => (Q+:1'b0)) = (0, 0);
    (posedge CP => (Q+:D)) = (0, 0);
    $width (negedge CDN &&& CP_D_SDFCHK, 0, 0, notifier);
    $width (negedge CDN &&& CP_nD_SDFCHK, 0, 0, notifier);
    $width (negedge CDN &&& nCP_D_SDFCHK, 0, 0, notifier);
    $width (negedge CDN &&& nCP_nD_SDFCHK, 0, 0, notifier);
    $width (posedge CP &&& CDN_D_SDFCHK, 0, 0, notifier);
    $width (negedge CP &&& CDN_D_SDFCHK, 0, 0, notifier);
    $width (posedge CP &&& CDN_nD_SDFCHK, 0, 0, notifier);
    $width (negedge CP &&& CDN_nD_SDFCHK, 0, 0, notifier);
  `ifdef NTC
    `ifdef RECREM
      $setuphold (posedge CP &&& CDN_SDFCHK, posedge D , 0, 0, notifier,,, CP_d, D_d);
      $setuphold (posedge CP &&& CDN_SDFCHK, negedge D , 0, 0, notifier,,, CP_d, D_d);
      $recrem (posedge CDN &&& D_SDFCHK, posedge CP &&& D_SDFCHK, 0,0, notifier, , , CDN_d, CP_d);
    `else
      $setuphold (posedge CP &&& CDN_SDFCHK, posedge D , 0, 0, notifier,,, CP_d, D_d);
      $setuphold (posedge CP &&& CDN_SDFCHK, negedge D , 0, 0, notifier,,, CP_d, D_d);
      $recovery (posedge CDN &&& D_SDFCHK, posedge CP &&& D_SDFCHK, 0, notifier);
      $hold (posedge CP &&& D_SDFCHK, posedge CDN , 0, notifier);
    `endif
  `else
    $setuphold (posedge CP &&& CDN_SDFCHK, posedge D , 0, 0, notifier);
    $setuphold (posedge CP &&& CDN_SDFCHK, negedge D , 0, 0, notifier);
    $recovery (posedge CDN &&& D_SDFCHK, posedge CP &&& D_SDFCHK, 0, notifier);
    $hold (posedge CP &&& D_SDFCHK, posedge CDN , 0, notifier);
  `endif
  endspecify
  `endif
endmodule

module RS_CKND2D1BWP20P90CPDLVT (A1, A2, ZN, VDD, VSS, VPP, VBB);
    inout VDD;
    inout VSS;
    inout VPP;
    inout VBB;
    input A1, A2;
    output ZN;
    and (I0_out, A1, A2);
    not (ZN_pwr_net, I0_out);
    rs_u_power_down_sum iZN (ZN, ZN_pwr_net, Vsum);
    not (nVSS, VSS);
    not (nVBB, VBB);
    and (Vsum, VDD, nVSS, VPP, nVBB);

  specify
    (A1 => ZN) = (0, 0);
    (A2 => ZN) = (0, 0);
  endspecify
endmodule

module RS_CKND1BWP20P90CPDLVT (I, ZN, VDD, VSS, VPP, VBB);
    inout VDD;
    inout VSS;
    inout VPP;
    inout VBB;
    input I;
    output ZN;
    not (ZN_pwr_net, I);
    rs_u_power_down_sum iZN (ZN, ZN_pwr_net, Vsum);
    not (nVSS, VSS);
    not (nVBB, VBB);
    and (Vsum, VDD, nVSS, VPP, nVBB);

  specify
    (I => ZN) = (0, 0);
  endspecify
endmodule


module RS_INVD3BWP20P90CPDLVT (I, ZN, VDD, VSS, VPP, VBB);
    inout VDD;
    inout VSS;
    inout VPP;
    inout VBB;
    input I;
    output ZN;
    not (ZN_pwr_net, I);
    rs_u_power_down_sum iZN (ZN, ZN_pwr_net, Vsum);
    not (nVSS, VSS);
    not (nVBB, VBB);
    and (Vsum, VDD, nVSS, VPP, nVBB);

  specify
    (I => ZN) = (0, 0);
  endspecify
endmodule
module RS_INVD2BWP20P90CPDLVT (I, ZN, VDD, VSS, VPP, VBB);
    inout VDD;
    inout VSS;
    inout VPP;
    inout VBB;
    input I;
    output ZN;
    not (ZN_pwr_net, I);
    rs_u_power_down_sum iZN (ZN, ZN_pwr_net, Vsum);
    not (nVSS, VSS);
    not (nVBB, VBB);
    and (Vsum, VDD, nVSS, VPP, nVBB);

  specify
    (I => ZN) = (0, 0);
  endspecify
endmodule
module RS_INVD1BWP20P90CPDLVT (I, ZN, VDD, VSS, VPP, VBB);
    inout VDD;
    inout VSS;
    inout VPP;
    inout VBB;
    input I;
    output ZN;
    not (ZN_pwr_net, I);
    rs_u_power_down_sum iZN (ZN, ZN_pwr_net, Vsum);
    not (nVSS, VSS);
    not (nVBB, VBB);
    and (Vsum, VDD, nVSS, VPP, nVBB);

  specify
    (I => ZN) = (0, 0);
  endspecify
endmodule

module RS_BUFFD1BWP20P90CPDLVT (I, Z, VDD, VSS, VPP, VBB);
    inout VDD;
    inout VSS;
    inout VPP;
    inout VBB;
    input I;
    output Z;
    buf (Z_pwr_net, I);
    rs_u_power_down_sum iZ (Z, Z_pwr_net, Vsum);
    not (nVSS, VSS);
    not (nVBB, VBB);
    and (Vsum, VDD, nVSS, VPP, nVBB);

  specify
    (I => Z) = (0, 0);
  endspecify
endmodule

module RS_BUFFD2BWP20P90CPDLVT (I, Z, VDD, VSS, VPP, VBB);
    inout VDD;
    inout VSS;
    inout VPP;
    inout VBB;
    input I;
    output Z;
    buf (Z_pwr_net, I);
    rs_u_power_down_sum iZ (Z, Z_pwr_net, Vsum);
    not (nVSS, VSS);
    not (nVBB, VBB);
    and (Vsum, VDD, nVSS, VPP, nVBB);

  specify
    (I => Z) = (0, 0);
  endspecify
endmodule


module RS_NR2D1BWP20P90CPDLVT (A1, A2, ZN, VDD, VSS, VPP, VBB);
    inout VDD;
    inout VSS;
    inout VPP;
    inout VBB;
    input A1, A2;
    output ZN;
    or (I0_out, A1, A2);
    not (ZN_pwr_net, I0_out);
    rs_u_power_down_sum iZN (ZN, ZN_pwr_net, Vsum);
    not (nVSS, VSS);
    not (nVBB, VBB);
    and (Vsum, VDD, nVSS, VPP, nVBB);

  specify
    (A1 => ZN) = (0, 0);
    (A2 => ZN) = (0, 0);
  endspecify
endmodule


primitive rs_u_power_down_sum (Z, Zint, vsum);
   output Z;
   input  Zint, vsum;
   table
     //  Zint vsum : Z
          0    1   : 0  ;
          1    1   : 1  ;
          ?    0   : x  ;
          ?    x   : x  ;
   endtable
endprimitive
primitive rs_dla_pwr (q, d, e, cdn, sdn, notifier, vsum);
   output q;
   reg q;
   input d, e, cdn, sdn, notifier, vsum;
   table
   ?  ?   ?   ?   ?  x  : ?  :  x  ; // invlaid  vdd/vss
   ?  ?   ?   ?   ?  0  : ?  :  x  ; // invlaid  vdd/vss
   1  1   1   ?   ?  1  : ?  :  1  ; // Latch 1
   0  1   ?   1   ?  1  : ?  :  0  ; // Latch 0
   0 (10) 1   1   ?  1  : ?  :  0  ; // Latch 0 after falling edge
   1 (10) 1   1   ?  1  : ?  :  1  ; // Latch 1 after falling edge
   *  0   ?   ?   ?  1  : ?  :  -  ; // no changes
   ?  ?   ?   0   ?  1  : ?  :  1  ; // preset to 1
   ?  0   1   *   ?  1  : 1  :  1  ;
   1  ?   1   *   ?  1  : 1  :  1  ;
   1  *   1   ?   ?  1  : 1  :  1  ;
   ?  ?   0   1   ?  1  : ?  :  0  ; // reset to 0
   ?  0   *   1   ?  1  : 0  :  0  ;
   0  ?   *   1   ?  1  : 0  :  0  ;
   0  *   ?   1   ?  1  : 0  :  0  ;
   ?  ?   ?   ?   *  1  : ?  :  x  ; // toggle notifier
   endtable
endprimitive
primitive rs_xbuf (o, i, dummy);
   output o;     
   input i, dummy;
   table         
   // i dummy : o
      0   1   : 0 ;
      1   1   : 1 ;
      x   1   : 1 ;
   endtable      
endprimitive 
primitive rs_mux (q, d0, d1, s);
   output q;
   input s, d0, d1;

   table
   // d0  d1  s   : q 
      0   ?   0   : 0 ;
      1   ?   0   : 1 ;
      ?   0   1   : 0 ;
      ?   1   1   : 1 ;
      0   0   x   : 0 ;
      1   1   x   : 1 ;
   endtable
endprimitive
primitive rs_dff_pwr (q, d, cp, cdn, sdn, notifier, vsum);
   output q;
   input d, cp, cdn, sdn, notifier, vsum;
   reg q;
   table
      ?   ?   ?   ?   ?  x : ? : x ; // unknown vsum
      ?   ?   ?   ?   ?  0 : ? : x ; // invalid vsum
      ?   ?   0   ?   ?  1 : ? : 0 ; // CDN dominate SDN
      ?   ?   1   0   ?  1 : ? : 1 ; // SDN is set   
      ?   ?   1   x   ?  1 : 0 : x ; // SDN affect Q
      ?   ?   1   x   ?  1 : 1 : 1 ; // Q=1,preset=X
      ?   ?   x   1   ?  1 : 0 : 0 ; // Q=0,clear=X
	  1   *   1   ?   ?  1 : 1 : 1 ; // reduce pessimism
	  0   *   ?   1   ?  1 : 0 : 0 ; // reduce pessimism
      0 (01)  ?   1   ?  1 : ? : 0 ; // Latch 0
      0 (0x)  1   1   ?  1 : 1 : x ; // Weak clock
      0 (0x)  1   1   ?  1 : x : x ; // Weak clock
      0   0   ?   1   ?  1 : 0 : 0 ; // Keep 0 (D==Q)
      1 (01)  1   ?   ?  1 : ? : 1 ; // Latch 1   
      1 (0x)  1   ?   ?  1 : 0 : x ; // Weak clock
      1 (0x)  1   ?   ?  1 : x : x ; // Weak clock
      1   0   1   ?   ?  1 : 1 : 1 ; // Keep 1 (D==Q)
      ? (1?)  1   1   ?  1 : ? : - ; // ignore negative edge of clock
      ?   0   1   1   ?  1 : ? : - ; // ignore low-level clock
      ?   ? (?1)  1   ?  1 : ? : - ; // ignore positive edge of CDN
      ?   ?   1 (?1)  ?  1 : ? : - ; // ignore posative edge of SDN
      *   ?   1   1   ?  1 : ? : - ; // ignore data change on steady clock
      ?   ?   ?   ?   *  1 : ? : x ; // timing check violation
   endtable
endprimitive
