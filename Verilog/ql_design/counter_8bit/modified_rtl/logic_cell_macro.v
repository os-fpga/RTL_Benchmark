module logic_cell_macro (
    input  BA1,
    input  BA2,
    input  BAB,
    input  BAS1,
    input  BAS2,
    input  BB1,
    input  BB2,
    input  BBS1,
    input  BBS2,
    input  BSL,
    input  F1,
    input  F2,
    input  FS,
    input  QCK,
    input  QCKS,
    input  QDI,
    input  QDS,
    input  QEN,
    input  QRT,
    input  QST,
    input  TA1,
    input  TA2,
    input  TAB,
    input  TAS1,
    input  TAS2,
    input  TB1,
    input  TB2,
    input  TBS,
    input  TBS1,
    input  TBS2,
    input  TSL,
    output CZ,
    output FZ,
    output QZ,
    output TZ
);

  wire TAP1, TAP2, TBP1, TBP2, BAP1, BAP2, BBP1, BBP2, QCKP, TAI, TBI, BAI, BBI, TZI, BZI, CZI, QZI;
  reg QZ_r,QZ_r1;

  initial begin
    QZ_r = 1'b0;
  end
  assign QZ   = (~QRT && ~QST) ? QZ_r : QZ_r1;
  assign TAP1 = TAS1 ? ~TA1 : TA1;
  assign TAP2 = TAS2 ? ~TA2 : TA2;
  assign TBP1 = TBS1 ? ~TB1 : TB1;
  assign TBP2 = TBS2 ? ~TB2 : TB2;
  assign BAP1 = BAS1 ? ~BA1 : BA1;
  assign BAP2 = BAS2 ? ~BA2 : BA2;
  assign BBP1 = BBS1 ? ~BB1 : BB1;
  assign BBP2 = BBS2 ? ~BB2 : BB2;

  assign TAI  = TSL ? TAP2 : TAP1;
  assign TBI  = TSL ? TBP2 : TBP1;
  assign BAI  = BSL ? BAP2 : BAP1;
  assign BBI  = BSL ? BBP2 : BBP1;
  assign TZI  = TAB ? TBI : TAI;
  assign BZI  = BAB ? BBI : BAI;
  assign CZI  = TBS ? BZI : TZI;
  assign QZI  = QDS ? QDI : CZI;
  assign FZ   = FS ? F2 : F1;
  assign TZ   = TZI;
  assign CZ   = CZI;
  assign QCKP = QCKS ? QCK : ~QCK;


  always @(posedge QCKP) if (~QRT && ~QST) if (QEN) QZ_r = QZI;
  always @(QRT or QST)
    if (QRT) QZ_r = 1'b0;
    else if (QST) QZ_r = 1'b1;

endmodule
