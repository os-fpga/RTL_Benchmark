
`include "global.inc"

module n22_pmon_csr(

  input m_mode,

  input dbg_mode,
  input dbg_stopcount,
  input ebreak4dbg_stopcount,

  input csr_ena,
  input csr_wr_en,
  input csr_rd_en,
  input [12-1:0] csr_idx,
  input wbck_csr_wen,
  input  [`N22_XLEN-1:0] wbck_csr_dat,
  output [`N22_XLEN-1:0] read_csr_dat,

  output csr_addr_legal,

  output csr_umode_sel_legal,

  output csr_umode_prv_ilgl,
  output csr_umode_wro_ilgl,

  input  cmt_instret_ena,
`ifdef N22_HAS_PMONITOR
  input [31:0] pmon_evts,
`endif

  output pmon_pmovf_irq,

  input  clk,
  input  clk_aon,
  input  rst_n

  );


  wire mcounterwen_cy   ;
  wire mcounterwen_ir   ;
  wire mcounterwen_hpm3 ;
  wire mcounterwen_hpm4 ;
  wire mcounterwen_hpm5 ;
  wire mcounterwen_hpm6 ;

  wire mcountermask_m_cy   ;
  wire mcountermask_m_ir   ;
  wire mcountermask_m_hpm3 ;
  wire mcountermask_m_hpm4 ;
  wire mcountermask_m_hpm5 ;
  wire mcountermask_m_hpm6 ;

  wire mcountermask_u_cy   ;
  wire mcountermask_u_ir   ;
  wire mcountermask_u_hpm3 ;
  wire mcountermask_u_hpm4 ;
  wire mcountermask_u_hpm5 ;
  wire mcountermask_u_hpm6 ;


`ifndef N22_HAS_UMODE
  wire sel_cycle          = 1'b0;
  wire sel_instret        = 1'b0;
  wire sel_cycleh         = 1'b0;
  wire sel_instreth       = 1'b0;
  wire sel_mcounteren     = 1'b0;
  wire sel_mcounterwen    = 1'b0;
  wire sel_hpmcounter3    = 1'b0;
  wire sel_hpmcounter4    = 1'b0;
  wire sel_hpmcounter5    = 1'b0;
  wire sel_hpmcounter6    = 1'b0;
  wire sel_hpmcounter7    = 1'b0;
  wire sel_hpmcounter8    = 1'b0;
  wire sel_hpmcounter9    = 1'b0;
  wire sel_hpmcounter10    = 1'b0;
  wire sel_hpmcounter11    = 1'b0;
  wire sel_hpmcounter12    = 1'b0;
  wire sel_hpmcounter13    = 1'b0;
  wire sel_hpmcounter14    = 1'b0;
  wire sel_hpmcounter15    = 1'b0;
  wire sel_hpmcounter16    = 1'b0;
  wire sel_hpmcounter17    = 1'b0;
  wire sel_hpmcounter18    = 1'b0;
  wire sel_hpmcounter19    = 1'b0;
  wire sel_hpmcounter20    = 1'b0;
  wire sel_hpmcounter21    = 1'b0;
  wire sel_hpmcounter22    = 1'b0;
  wire sel_hpmcounter23    = 1'b0;
  wire sel_hpmcounter24    = 1'b0;
  wire sel_hpmcounter25    = 1'b0;
  wire sel_hpmcounter26    = 1'b0;
  wire sel_hpmcounter27    = 1'b0;
  wire sel_hpmcounter28    = 1'b0;
  wire sel_hpmcounter29    = 1'b0;
  wire sel_hpmcounter30    = 1'b0;
  wire sel_hpmcounter31    = 1'b0;
  wire sel_hpmcounter3h   = 1'b0;
  wire sel_hpmcounter4h   = 1'b0;
  wire sel_hpmcounter5h   = 1'b0;
  wire sel_hpmcounter6h   = 1'b0;
  wire sel_hpmcounter7h   = 1'b0;
  wire sel_hpmcounter8h   = 1'b0;
  wire sel_hpmcounter9h   = 1'b0;
  wire sel_hpmcounter10h   = 1'b0;
  wire sel_hpmcounter11h   = 1'b0;
  wire sel_hpmcounter12h   = 1'b0;
  wire sel_hpmcounter13h   = 1'b0;
  wire sel_hpmcounter14h   = 1'b0;
  wire sel_hpmcounter15h   = 1'b0;
  wire sel_hpmcounter16h   = 1'b0;
  wire sel_hpmcounter17h   = 1'b0;
  wire sel_hpmcounter18h   = 1'b0;
  wire sel_hpmcounter19h   = 1'b0;
  wire sel_hpmcounter20h   = 1'b0;
  wire sel_hpmcounter21h   = 1'b0;
  wire sel_hpmcounter22h   = 1'b0;
  wire sel_hpmcounter23h   = 1'b0;
  wire sel_hpmcounter24h   = 1'b0;
  wire sel_hpmcounter25h   = 1'b0;
  wire sel_hpmcounter26h   = 1'b0;
  wire sel_hpmcounter27h   = 1'b0;
  wire sel_hpmcounter28h   = 1'b0;
  wire sel_hpmcounter29h   = 1'b0;
  wire sel_hpmcounter30h   = 1'b0;
  wire sel_hpmcounter31h   = 1'b0;
  wire sel_mcountermask_m = 1'b0;
  wire sel_mcountermask_u = 1'b0;

`endif

  wire [31:0] csr_mcountermask_m;
  wire [31:0] csr_mcountermask_u;
  wire [31:0] csr_mcounteren    ;
  wire [31:0] csr_mcounterwen   ;

`ifdef N22_HAS_UMODE
  wire sel_cycle       = (csr_idx == 12'hc00);
  wire sel_instret     = (csr_idx == 12'hc02);
  wire sel_cycleh      = (csr_idx == 12'hc80);
  wire sel_instreth    = (csr_idx == 12'hc82);
  wire sel_mcounteren  = (csr_idx == 12'h306);
  wire sel_mcounterwen = (csr_idx == 12'h7ce);
  wire sel_hpmcounter3   = (csr_idx == 12'hc03);
  wire sel_hpmcounter4   = (csr_idx == 12'hc04);
  wire sel_hpmcounter5   = (csr_idx == 12'hc05);
  wire sel_hpmcounter6   = (csr_idx == 12'hc06);
  wire sel_hpmcounter7   = (csr_idx == 12'hc07);
  wire sel_hpmcounter8   = (csr_idx == 12'hc08);
  wire sel_hpmcounter9   = (csr_idx == 12'hc09);
  wire sel_hpmcounter10  = (csr_idx == 12'hc0a);
  wire sel_hpmcounter11  = (csr_idx == 12'hc0b);
  wire sel_hpmcounter12  = (csr_idx == 12'hc0c);
  wire sel_hpmcounter13  = (csr_idx == 12'hc0d);
  wire sel_hpmcounter14  = (csr_idx == 12'hc0e);
  wire sel_hpmcounter15  = (csr_idx == 12'hc0f);
  wire sel_hpmcounter16  = (csr_idx == 12'hc10);
  wire sel_hpmcounter17  = (csr_idx == 12'hc11);
  wire sel_hpmcounter18  = (csr_idx == 12'hc12);
  wire sel_hpmcounter19  = (csr_idx == 12'hc13);
  wire sel_hpmcounter20  = (csr_idx == 12'hc14);
  wire sel_hpmcounter21  = (csr_idx == 12'hc15);
  wire sel_hpmcounter22  = (csr_idx == 12'hc16);
  wire sel_hpmcounter23  = (csr_idx == 12'hc17);
  wire sel_hpmcounter24  = (csr_idx == 12'hc18);
  wire sel_hpmcounter25  = (csr_idx == 12'hc19);
  wire sel_hpmcounter26  = (csr_idx == 12'hc1a);
  wire sel_hpmcounter27  = (csr_idx == 12'hc1b);
  wire sel_hpmcounter28  = (csr_idx == 12'hc1c);
  wire sel_hpmcounter29  = (csr_idx == 12'hc1d);
  wire sel_hpmcounter30  = (csr_idx == 12'hc1e);
  wire sel_hpmcounter31  = (csr_idx == 12'hc1f);

  wire sel_hpmcounter3h  = (csr_idx == 12'hc83);
  wire sel_hpmcounter4h  = (csr_idx == 12'hc84);
  wire sel_hpmcounter5h  = (csr_idx == 12'hc85);
  wire sel_hpmcounter6h  = (csr_idx == 12'hc86);
  wire sel_hpmcounter7h  = (csr_idx == 12'hc87);
  wire sel_hpmcounter8h  = (csr_idx == 12'hc88);
  wire sel_hpmcounter9h  = (csr_idx == 12'hc89);
  wire sel_hpmcounter10h = (csr_idx == 12'hc8a);
  wire sel_hpmcounter11h = (csr_idx == 12'hc8b);
  wire sel_hpmcounter12h = (csr_idx == 12'hc8c);
  wire sel_hpmcounter13h = (csr_idx == 12'hc8d);
  wire sel_hpmcounter14h = (csr_idx == 12'hc8e);
  wire sel_hpmcounter15h = (csr_idx == 12'hc8f);
  wire sel_hpmcounter16h = (csr_idx == 12'hc90);
  wire sel_hpmcounter17h = (csr_idx == 12'hc91);
  wire sel_hpmcounter18h = (csr_idx == 12'hc92);
  wire sel_hpmcounter19h = (csr_idx == 12'hc93);
  wire sel_hpmcounter20h = (csr_idx == 12'hc94);
  wire sel_hpmcounter21h = (csr_idx == 12'hc95);
  wire sel_hpmcounter22h = (csr_idx == 12'hc96);
  wire sel_hpmcounter23h = (csr_idx == 12'hc97);
  wire sel_hpmcounter24h = (csr_idx == 12'hc98);
  wire sel_hpmcounter25h = (csr_idx == 12'hc99);
  wire sel_hpmcounter26h = (csr_idx == 12'hc9a);
  wire sel_hpmcounter27h = (csr_idx == 12'hc9b);
  wire sel_hpmcounter28h = (csr_idx == 12'hc9c);
  wire sel_hpmcounter29h = (csr_idx == 12'hc9d);
  wire sel_hpmcounter30h = (csr_idx == 12'hc9e);
  wire sel_hpmcounter31h = (csr_idx == 12'hc9f);

  wire sel_mcountermask_m = (csr_idx == 12'h7d1);
  wire sel_mcountermask_u = (csr_idx == 12'h7d3);

  wire rd_cycle       = csr_rd_en & sel_cycle   ;
  wire rd_cycleh      = csr_rd_en & sel_cycleh  ;
  wire rd_instret     = csr_rd_en & sel_instret ;
  wire rd_instreth    = csr_rd_en & sel_instreth;
  wire rd_mcounteren  = csr_rd_en & sel_mcounteren;
  wire rd_mcounterwen = csr_rd_en & sel_mcounterwen;
  wire rd_hpmcounter3   = sel_hpmcounter3   & csr_rd_en;
  wire rd_hpmcounter4   = sel_hpmcounter4   & csr_rd_en;
  wire rd_hpmcounter5   = sel_hpmcounter5   & csr_rd_en;
  wire rd_hpmcounter6   = sel_hpmcounter6   & csr_rd_en;
  wire rd_hpmcounter7   = sel_hpmcounter7   & csr_rd_en;
  wire rd_hpmcounter8   = sel_hpmcounter8   & csr_rd_en;
  wire rd_hpmcounter9   = sel_hpmcounter9   & csr_rd_en;
  wire rd_hpmcounter10  = sel_hpmcounter10  & csr_rd_en;
  wire rd_hpmcounter11  = sel_hpmcounter11  & csr_rd_en;
  wire rd_hpmcounter12  = sel_hpmcounter12  & csr_rd_en;
  wire rd_hpmcounter13  = sel_hpmcounter13  & csr_rd_en;
  wire rd_hpmcounter14  = sel_hpmcounter14  & csr_rd_en;
  wire rd_hpmcounter15  = sel_hpmcounter15  & csr_rd_en;
  wire rd_hpmcounter16  = sel_hpmcounter16  & csr_rd_en;
  wire rd_hpmcounter17  = sel_hpmcounter17  & csr_rd_en;
  wire rd_hpmcounter18  = sel_hpmcounter18  & csr_rd_en;
  wire rd_hpmcounter19  = sel_hpmcounter19  & csr_rd_en;
  wire rd_hpmcounter20  = sel_hpmcounter20  & csr_rd_en;
  wire rd_hpmcounter21  = sel_hpmcounter21  & csr_rd_en;
  wire rd_hpmcounter22  = sel_hpmcounter22  & csr_rd_en;
  wire rd_hpmcounter23  = sel_hpmcounter23  & csr_rd_en;
  wire rd_hpmcounter24  = sel_hpmcounter24  & csr_rd_en;
  wire rd_hpmcounter25  = sel_hpmcounter25  & csr_rd_en;
  wire rd_hpmcounter26  = sel_hpmcounter26  & csr_rd_en;
  wire rd_hpmcounter27  = sel_hpmcounter27  & csr_rd_en;
  wire rd_hpmcounter28  = sel_hpmcounter28  & csr_rd_en;
  wire rd_hpmcounter29  = sel_hpmcounter29  & csr_rd_en;
  wire rd_hpmcounter30  = sel_hpmcounter30  & csr_rd_en;
  wire rd_hpmcounter31  = sel_hpmcounter31  & csr_rd_en;

  wire rd_hpmcounter3h  = sel_hpmcounter3h  & csr_rd_en;
  wire rd_hpmcounter4h  = sel_hpmcounter4h  & csr_rd_en;
  wire rd_hpmcounter5h  = sel_hpmcounter5h  & csr_rd_en;
  wire rd_hpmcounter6h  = sel_hpmcounter6h  & csr_rd_en;
  wire rd_hpmcounter7h = sel_hpmcounter7h  & csr_rd_en;
  wire rd_hpmcounter8h = sel_hpmcounter8h  & csr_rd_en;
  wire rd_hpmcounter9h = sel_hpmcounter9h  & csr_rd_en;
  wire rd_hpmcounter10h= sel_hpmcounter10h & csr_rd_en;
  wire rd_hpmcounter11h= sel_hpmcounter11h & csr_rd_en;
  wire rd_hpmcounter12h= sel_hpmcounter12h & csr_rd_en;
  wire rd_hpmcounter13h= sel_hpmcounter13h & csr_rd_en;
  wire rd_hpmcounter14h= sel_hpmcounter14h & csr_rd_en;
  wire rd_hpmcounter15h= sel_hpmcounter15h & csr_rd_en;
  wire rd_hpmcounter16h= sel_hpmcounter16h & csr_rd_en;
  wire rd_hpmcounter17h= sel_hpmcounter17h & csr_rd_en;
  wire rd_hpmcounter18h= sel_hpmcounter18h & csr_rd_en;
  wire rd_hpmcounter19h= sel_hpmcounter19h & csr_rd_en;
  wire rd_hpmcounter20h= sel_hpmcounter20h & csr_rd_en;
  wire rd_hpmcounter21h= sel_hpmcounter21h & csr_rd_en;
  wire rd_hpmcounter22h= sel_hpmcounter22h & csr_rd_en;
  wire rd_hpmcounter23h= sel_hpmcounter23h & csr_rd_en;
  wire rd_hpmcounter24h= sel_hpmcounter24h & csr_rd_en;
  wire rd_hpmcounter25h= sel_hpmcounter25h & csr_rd_en;
  wire rd_hpmcounter26h= sel_hpmcounter26h & csr_rd_en;
  wire rd_hpmcounter27h= sel_hpmcounter27h & csr_rd_en;
  wire rd_hpmcounter28h= sel_hpmcounter28h & csr_rd_en;
  wire rd_hpmcounter29h= sel_hpmcounter29h & csr_rd_en;
  wire rd_hpmcounter30h= sel_hpmcounter30h & csr_rd_en;
  wire rd_hpmcounter31h= sel_hpmcounter31h & csr_rd_en;

  wire rd_mcountermask_m = sel_mcountermask_m & csr_rd_en;
  wire rd_mcountermask_u = sel_mcountermask_u & csr_rd_en;

  wire wr_cycle       = sel_cycle       & wbck_csr_wen;
  wire wr_cycleh      = sel_cycleh      & wbck_csr_wen;
  wire wr_instret     = sel_instret     & wbck_csr_wen;
  wire wr_instreth    = sel_instreth    & wbck_csr_wen;
  wire wr_mcounteren  = sel_mcounteren  & wbck_csr_wen;
  wire wr_mcounterwen = sel_mcounterwen & wbck_csr_wen;
  wire wr_hpmcounter3   = sel_hpmcounter3   & wbck_csr_wen;
  wire wr_hpmcounter4   = sel_hpmcounter4   & wbck_csr_wen;
  wire wr_hpmcounter5   = sel_hpmcounter5   & wbck_csr_wen;
  wire wr_hpmcounter6   = sel_hpmcounter6   & wbck_csr_wen;
  wire wr_hpmcounter3h  = sel_hpmcounter3h  & wbck_csr_wen;
  wire wr_hpmcounter4h  = sel_hpmcounter4h  & wbck_csr_wen;
  wire wr_hpmcounter5h  = sel_hpmcounter5h  & wbck_csr_wen;
  wire wr_hpmcounter6h  = sel_hpmcounter6h  & wbck_csr_wen;
  wire wr_mcountermask_m = sel_mcountermask_m & wbck_csr_wen;
  wire wr_mcountermask_u = sel_mcountermask_u & wbck_csr_wen;

`endif


  wire sel_mcycle         = (csr_idx == 12'hB00);
  wire sel_mcycleh        = (csr_idx == 12'hB80);
  wire sel_minstret       = (csr_idx == 12'hB02);
  wire sel_minstreth      = (csr_idx == 12'hB82);
  wire sel_mhpmcounter3   = (csr_idx == 12'hb03);
  wire sel_mhpmcounter4   = (csr_idx == 12'hb04);
  wire sel_mhpmcounter5   = (csr_idx == 12'hb05);
  wire sel_mhpmcounter6   = (csr_idx == 12'hb06);
  wire sel_mhpmcounter7   = (csr_idx == 12'hb07);
  wire sel_mhpmcounter8   = (csr_idx == 12'hb08);
  wire sel_mhpmcounter9   = (csr_idx == 12'hb09);
  wire sel_mhpmcounter10  = (csr_idx == 12'hb0a);
  wire sel_mhpmcounter11  = (csr_idx == 12'hb0b);
  wire sel_mhpmcounter12  = (csr_idx == 12'hb0c);
  wire sel_mhpmcounter13  = (csr_idx == 12'hb0d);
  wire sel_mhpmcounter14  = (csr_idx == 12'hb0e);
  wire sel_mhpmcounter15  = (csr_idx == 12'hb0f);
  wire sel_mhpmcounter16  = (csr_idx == 12'hb10);
  wire sel_mhpmcounter17  = (csr_idx == 12'hb11);
  wire sel_mhpmcounter18  = (csr_idx == 12'hb12);
  wire sel_mhpmcounter19  = (csr_idx == 12'hb13);
  wire sel_mhpmcounter20  = (csr_idx == 12'hb14);
  wire sel_mhpmcounter21  = (csr_idx == 12'hb15);
  wire sel_mhpmcounter22  = (csr_idx == 12'hb16);
  wire sel_mhpmcounter23  = (csr_idx == 12'hb17);
  wire sel_mhpmcounter24  = (csr_idx == 12'hb18);
  wire sel_mhpmcounter25  = (csr_idx == 12'hb19);
  wire sel_mhpmcounter26  = (csr_idx == 12'hb1a);
  wire sel_mhpmcounter27  = (csr_idx == 12'hb1b);
  wire sel_mhpmcounter28  = (csr_idx == 12'hb1c);
  wire sel_mhpmcounter29  = (csr_idx == 12'hb1d);
  wire sel_mhpmcounter30  = (csr_idx == 12'hb1e);
  wire sel_mhpmcounter31  = (csr_idx == 12'hb1f);



  wire sel_mhpmcounter3h  = (csr_idx == 12'hb83);
  wire sel_mhpmcounter4h  = (csr_idx == 12'hb84);
  wire sel_mhpmcounter5h  = (csr_idx == 12'hb85);
  wire sel_mhpmcounter6h  = (csr_idx == 12'hb86);
  wire sel_mhpmcounter7h  = (csr_idx == 12'hb87);
  wire sel_mhpmcounter8h  = (csr_idx == 12'hb88);
  wire sel_mhpmcounter9h  = (csr_idx == 12'hb89);
  wire sel_mhpmcounter10h = (csr_idx == 12'hb8a);
  wire sel_mhpmcounter11h = (csr_idx == 12'hb8b);
  wire sel_mhpmcounter12h = (csr_idx == 12'hb8c);
  wire sel_mhpmcounter13h = (csr_idx == 12'hb8d);
  wire sel_mhpmcounter14h = (csr_idx == 12'hb8e);
  wire sel_mhpmcounter15h = (csr_idx == 12'hb8f);
  wire sel_mhpmcounter16h = (csr_idx == 12'hb90);
  wire sel_mhpmcounter17h = (csr_idx == 12'hb91);
  wire sel_mhpmcounter18h = (csr_idx == 12'hb92);
  wire sel_mhpmcounter19h = (csr_idx == 12'hb93);
  wire sel_mhpmcounter20h = (csr_idx == 12'hb94);
  wire sel_mhpmcounter21h = (csr_idx == 12'hb95);
  wire sel_mhpmcounter22h = (csr_idx == 12'hb96);
  wire sel_mhpmcounter23h = (csr_idx == 12'hb97);
  wire sel_mhpmcounter24h = (csr_idx == 12'hb98);
  wire sel_mhpmcounter25h = (csr_idx == 12'hb99);
  wire sel_mhpmcounter26h = (csr_idx == 12'hb9a);
  wire sel_mhpmcounter27h = (csr_idx == 12'hb9b);
  wire sel_mhpmcounter28h = (csr_idx == 12'hb9c);
  wire sel_mhpmcounter29h = (csr_idx == 12'hb9d);
  wire sel_mhpmcounter30h = (csr_idx == 12'hb9e);
  wire sel_mhpmcounter31h = (csr_idx == 12'hb9f);

  wire sel_mhpmevent3     = (csr_idx == 12'h323);
  wire sel_mhpmevent4     = (csr_idx == 12'h324);
  wire sel_mhpmevent5     = (csr_idx == 12'h325);
  wire sel_mhpmevent6     = (csr_idx == 12'h326);
  wire sel_mcounterinten  = (csr_idx == 12'h7cf);
  wire sel_mcountinhibit  = (csr_idx == 12'h320);
  wire sel_mcounterovf    = (csr_idx == 12'h7d4);

  wire rd_mcycle         = sel_mcycle         & csr_rd_en;
  wire rd_mcycleh        = sel_mcycleh        & csr_rd_en;
  wire rd_minstret       = sel_minstret       & csr_rd_en;
  wire rd_minstreth      = sel_minstreth      & csr_rd_en;
  wire rd_mhpmcounter3   = sel_mhpmcounter3   & csr_rd_en;
  wire rd_mhpmcounter4   = sel_mhpmcounter4   & csr_rd_en;
  wire rd_mhpmcounter5   = sel_mhpmcounter5   & csr_rd_en;
  wire rd_mhpmcounter6   = sel_mhpmcounter6   & csr_rd_en;
  wire rd_mhpmcounter7   = sel_mhpmcounter7   & csr_rd_en;
  wire rd_mhpmcounter8   = sel_mhpmcounter8   & csr_rd_en;
  wire rd_mhpmcounter9   = sel_mhpmcounter9   & csr_rd_en;
  wire rd_mhpmcounter10  = sel_mhpmcounter10  & csr_rd_en;
  wire rd_mhpmcounter11  = sel_mhpmcounter11  & csr_rd_en;
  wire rd_mhpmcounter12  = sel_mhpmcounter12  & csr_rd_en;
  wire rd_mhpmcounter13  = sel_mhpmcounter13  & csr_rd_en;
  wire rd_mhpmcounter14  = sel_mhpmcounter14  & csr_rd_en;
  wire rd_mhpmcounter15  = sel_mhpmcounter15  & csr_rd_en;
  wire rd_mhpmcounter16  = sel_mhpmcounter16  & csr_rd_en;
  wire rd_mhpmcounter17  = sel_mhpmcounter17  & csr_rd_en;
  wire rd_mhpmcounter18  = sel_mhpmcounter18  & csr_rd_en;
  wire rd_mhpmcounter19  = sel_mhpmcounter19  & csr_rd_en;
  wire rd_mhpmcounter20  = sel_mhpmcounter20  & csr_rd_en;
  wire rd_mhpmcounter21  = sel_mhpmcounter21  & csr_rd_en;
  wire rd_mhpmcounter22  = sel_mhpmcounter22  & csr_rd_en;
  wire rd_mhpmcounter23  = sel_mhpmcounter23  & csr_rd_en;
  wire rd_mhpmcounter24  = sel_mhpmcounter24  & csr_rd_en;
  wire rd_mhpmcounter25  = sel_mhpmcounter25  & csr_rd_en;
  wire rd_mhpmcounter26  = sel_mhpmcounter26  & csr_rd_en;
  wire rd_mhpmcounter27  = sel_mhpmcounter27  & csr_rd_en;
  wire rd_mhpmcounter28  = sel_mhpmcounter28  & csr_rd_en;
  wire rd_mhpmcounter29  = sel_mhpmcounter29  & csr_rd_en;
  wire rd_mhpmcounter30  = sel_mhpmcounter30  & csr_rd_en;
  wire rd_mhpmcounter31  = sel_mhpmcounter31  & csr_rd_en;

  wire rd_mhpmcounter3h  = sel_mhpmcounter3h  & csr_rd_en;
  wire rd_mhpmcounter4h  = sel_mhpmcounter4h  & csr_rd_en;
  wire rd_mhpmcounter5h  = sel_mhpmcounter5h  & csr_rd_en;
  wire rd_mhpmcounter6h  = sel_mhpmcounter6h  & csr_rd_en;
  wire rd_mhpmcounter7h  = sel_mhpmcounter7h  & csr_rd_en;
  wire rd_mhpmcounter8h  = sel_mhpmcounter8h  & csr_rd_en;
  wire rd_mhpmcounter9h  = sel_mhpmcounter9h  & csr_rd_en;
  wire rd_mhpmcounter10h = sel_mhpmcounter10h & csr_rd_en;
  wire rd_mhpmcounter11h = sel_mhpmcounter11h & csr_rd_en;
  wire rd_mhpmcounter12h = sel_mhpmcounter12h & csr_rd_en;
  wire rd_mhpmcounter13h = sel_mhpmcounter13h & csr_rd_en;
  wire rd_mhpmcounter14h = sel_mhpmcounter14h & csr_rd_en;
  wire rd_mhpmcounter15h = sel_mhpmcounter15h & csr_rd_en;
  wire rd_mhpmcounter16h = sel_mhpmcounter16h & csr_rd_en;
  wire rd_mhpmcounter17h = sel_mhpmcounter17h & csr_rd_en;
  wire rd_mhpmcounter18h = sel_mhpmcounter18h & csr_rd_en;
  wire rd_mhpmcounter19h = sel_mhpmcounter19h & csr_rd_en;
  wire rd_mhpmcounter20h = sel_mhpmcounter20h & csr_rd_en;
  wire rd_mhpmcounter21h = sel_mhpmcounter21h & csr_rd_en;
  wire rd_mhpmcounter22h = sel_mhpmcounter22h & csr_rd_en;
  wire rd_mhpmcounter23h = sel_mhpmcounter23h & csr_rd_en;
  wire rd_mhpmcounter24h = sel_mhpmcounter24h & csr_rd_en;
  wire rd_mhpmcounter25h = sel_mhpmcounter25h & csr_rd_en;
  wire rd_mhpmcounter26h = sel_mhpmcounter26h & csr_rd_en;
  wire rd_mhpmcounter27h = sel_mhpmcounter27h & csr_rd_en;
  wire rd_mhpmcounter28h = sel_mhpmcounter28h & csr_rd_en;
  wire rd_mhpmcounter29h = sel_mhpmcounter29h & csr_rd_en;
  wire rd_mhpmcounter30h = sel_mhpmcounter30h & csr_rd_en;
  wire rd_mhpmcounter31h = sel_mhpmcounter31h & csr_rd_en;


  wire rd_mhpmevent3     = sel_mhpmevent3     & csr_rd_en;
  wire rd_mhpmevent4     = sel_mhpmevent4     & csr_rd_en;
  wire rd_mhpmevent5     = sel_mhpmevent5     & csr_rd_en;
  wire rd_mhpmevent6     = sel_mhpmevent6     & csr_rd_en;
  wire rd_mcounterinten  = sel_mcounterinten  & csr_rd_en;
  wire rd_mcountinhibit  = sel_mcountinhibit  & csr_rd_en;
  wire rd_mcounterovf    = sel_mcounterovf    & csr_rd_en;

  wire wr_mcycle         = (sel_mcycle        | (sel_cycle        & mcounterwen_cy  )) & wbck_csr_wen;
  wire wr_mcycleh        = (sel_mcycleh       | (sel_cycleh       & mcounterwen_cy  )) & wbck_csr_wen;
  wire wr_minstret       = (sel_minstret      | (sel_instret      & mcounterwen_ir  )) & wbck_csr_wen;
  wire wr_minstreth      = (sel_minstreth     | (sel_instreth     & mcounterwen_ir  )) & wbck_csr_wen;
  wire wr_mhpmcounter3   = (sel_mhpmcounter3  | (sel_hpmcounter3  & mcounterwen_hpm3)) & wbck_csr_wen;
  wire wr_mhpmcounter4   = (sel_mhpmcounter4  | (sel_hpmcounter4  & mcounterwen_hpm4)) & wbck_csr_wen;
  wire wr_mhpmcounter5   = (sel_mhpmcounter5  | (sel_hpmcounter5  & mcounterwen_hpm5)) & wbck_csr_wen;
  wire wr_mhpmcounter6   = (sel_mhpmcounter6  | (sel_hpmcounter6  & mcounterwen_hpm6)) & wbck_csr_wen;
  wire wr_mhpmcounter3h  = (sel_mhpmcounter3h | (sel_hpmcounter3h & mcounterwen_hpm3)) & wbck_csr_wen;
  wire wr_mhpmcounter4h  = (sel_mhpmcounter4h | (sel_hpmcounter4h & mcounterwen_hpm4)) & wbck_csr_wen;
  wire wr_mhpmcounter5h  = (sel_mhpmcounter5h | (sel_hpmcounter5h & mcounterwen_hpm5)) & wbck_csr_wen;
  wire wr_mhpmcounter6h  = (sel_mhpmcounter6h | (sel_hpmcounter6h & mcounterwen_hpm6)) & wbck_csr_wen;

  wire wr_mhpmevent3     = sel_mhpmevent3     & wbck_csr_wen;
  wire wr_mhpmevent4     = sel_mhpmevent4     & wbck_csr_wen;
  wire wr_mhpmevent5     = sel_mhpmevent5     & wbck_csr_wen;
  wire wr_mhpmevent6     = sel_mhpmevent6     & wbck_csr_wen;
  wire wr_mcounterinten  = sel_mcounterinten  & wbck_csr_wen;
  wire wr_mcountinhibit  = sel_mcountinhibit  & wbck_csr_wen;
  wire wr_mcounterovf    = sel_mcounterovf    & wbck_csr_wen;


  wire u_mode = (~m_mode) & (~dbg_mode);


`ifdef N22_HAS_PMONITOR
  wire [31:0] csr_mcycle       ;
  wire [31:0] csr_mcycleh      ;
  wire [31:0] csr_minstret     ;
  wire [31:0] csr_minstreth    ;
  wire [31:0] csr_mhpmcounter3 ;
  wire [31:0] csr_mhpmcounter4 ;
  wire [31:0] csr_mhpmcounter5 ;
  wire [31:0] csr_mhpmcounter6 ;
  wire [31:0] csr_mhpmcounter3h;
  wire [31:0] csr_mhpmcounter4h;
  wire [31:0] csr_mhpmcounter5h;
  wire [31:0] csr_mhpmcounter6h;
  wire [31:0] csr_mhpmevent3 ;
  wire [31:0] csr_mhpmevent4 ;
  wire [31:0] csr_mhpmevent5 ;
  wire [31:0] csr_mhpmevent6 ;
  wire [31:0] csr_mcounterinten ;
  wire [31:0] csr_mcountinhibit ;
  wire [31:0] csr_mcounterovf;
  wire [31:0] csr_mcounterovf_set;





  wire mcountinhibit_cy  ;
  wire mcountinhibit_ir  ;
  wire mcountinhibit_hpm3;
  wire mcountinhibit_hpm4;
  wire mcountinhibit_hpm5;
  wire mcountinhibit_hpm6;

  wire stopcount = dbg_mode ? (dbg_stopcount | ebreak4dbg_stopcount): 1'b0;

  wire stop_cy   = stopcount | mcountinhibit_cy   | ((~u_mode) & mcountermask_m_cy  ) | (u_mode & mcountermask_u_cy  );
  wire stop_ir   = stopcount | mcountinhibit_ir   | ((~u_mode) & mcountermask_m_ir  ) | (u_mode & mcountermask_u_ir  );
  wire stop_hpm3 = stopcount | mcountinhibit_hpm3 | ((~u_mode) & mcountermask_m_hpm3) | (u_mode & mcountermask_u_hpm3);
  wire stop_hpm4 = stopcount | mcountinhibit_hpm4 | ((~u_mode) & mcountermask_m_hpm4) | (u_mode & mcountermask_u_hpm4);
  wire stop_hpm5 = stopcount | mcountinhibit_hpm5 | ((~u_mode) & mcountermask_m_hpm5) | (u_mode & mcountermask_u_hpm5);
  wire stop_hpm6 = stopcount | mcountinhibit_hpm6 | ((~u_mode) & mcountermask_m_hpm6) | (u_mode & mcountermask_u_hpm6);

  wire mcycle_ovf;
  wire minstret_ovf;

  n22_pmon_cycle u_n22_pmon_mcycle(
    .count_wr_ena   (wr_mcycle),
    .counth_wr_ena  (wr_mcycleh),
    .wbck_csr_dat   (wbck_csr_dat),

    .count_stop     (stop_cy),
    .csr_count      (csr_mcycle),
    .csr_counth     (csr_mcycleh),

    .count_ovf      (mcycle_ovf),

    .clk_aon        (clk_aon ),
    .rst_n          (rst_n)
    );

  n22_pmon_count u_n22_pmon_minstret(
    .count_wr_ena   (wr_minstret),
    .counth_wr_ena  (wr_minstreth),
    .event_wr_ena   (1'b0),
    .wbck_csr_dat   (wbck_csr_dat),

    .evt_idx        (5'b0),
    .evt_bus        ({31'b0,cmt_instret_ena}),
    .count_stop     (stop_ir),
    .csr_count      (csr_minstret),
    .csr_counth     (csr_minstreth),
    .csr_event      (),

    .count_ovf      (minstret_ovf),

    .clk_aon        (clk    ),
    .clk            (clk    ),
    .rst_n          (rst_n)
    );

  wire [4:0] mhpmcounter3_evt_idx = csr_mhpmevent3[8:4];
  wire [4:0] mhpmcounter4_evt_idx = csr_mhpmevent4[8:4];
  wire [4:0] mhpmcounter5_evt_idx = csr_mhpmevent5[8:4];
  wire [4:0] mhpmcounter6_evt_idx = csr_mhpmevent6[8:4];

  wire mhpmcounter3_ovf;
  wire mhpmcounter4_ovf;
  wire mhpmcounter5_ovf;
  wire mhpmcounter6_ovf;

  `ifdef N22_PMON_NUM_IS_4
  n22_pmon_count u_n22_pmon_mhpmcounter3(
    .count_wr_ena   (wr_mhpmcounter3),
    .counth_wr_ena  (wr_mhpmcounter3h),
    .event_wr_ena   (wr_mhpmevent3),
    .wbck_csr_dat   (wbck_csr_dat),

    .evt_idx        (mhpmcounter3_evt_idx),
    .evt_bus        (pmon_evts),
    .count_stop     (stop_hpm3),
    .csr_count      (csr_mhpmcounter3),
    .csr_counth     (csr_mhpmcounter3h ),
    .csr_event      (csr_mhpmevent3 ),

    .count_ovf      (mhpmcounter3_ovf),

    .clk_aon        (clk_aon    ),
    .clk            (clk    ),
    .rst_n          (rst_n)
    );




  n22_pmon_count u_n22_pmon_mhpmcounter4(
    .count_wr_ena   (wr_mhpmcounter4),
    .counth_wr_ena  (wr_mhpmcounter4h),
    .event_wr_ena   (wr_mhpmevent4),
    .wbck_csr_dat   (wbck_csr_dat),

    .evt_idx        (mhpmcounter4_evt_idx),
    .evt_bus        (pmon_evts),
    .count_stop     (stop_hpm4),
    .csr_count      (csr_mhpmcounter4),
    .csr_counth     (csr_mhpmcounter4h ),
    .csr_event      (csr_mhpmevent4 ),

    .count_ovf      (mhpmcounter4_ovf),

    .clk_aon        (clk_aon    ),
    .clk            (clk    ),
    .rst_n          (rst_n)
    );

  n22_pmon_count u_n22_pmon_mhpmcounter5(
    .count_wr_ena   (wr_mhpmcounter5),
    .counth_wr_ena  (wr_mhpmcounter5h),
    .event_wr_ena   (wr_mhpmevent5),
    .wbck_csr_dat   (wbck_csr_dat),

    .evt_idx        (mhpmcounter5_evt_idx),
    .evt_bus        (pmon_evts),
    .count_stop     (stop_hpm5),
    .csr_count      (csr_mhpmcounter5),
    .csr_counth     (csr_mhpmcounter5h ),
    .csr_event      (csr_mhpmevent5 ),

    .count_ovf      (mhpmcounter5_ovf),

    .clk_aon        (clk_aon    ),
    .clk            (clk    ),
    .rst_n          (rst_n)
    );

  n22_pmon_count u_n22_pmon_mhpmcounter6(
    .count_wr_ena   (wr_mhpmcounter6),
    .counth_wr_ena  (wr_mhpmcounter6h),
    .event_wr_ena   (wr_mhpmevent6),
    .wbck_csr_dat   (wbck_csr_dat),

    .evt_idx        (mhpmcounter6_evt_idx),
    .evt_bus        (pmon_evts),
    .count_stop     (stop_hpm6),
    .csr_count      (csr_mhpmcounter6),
    .csr_counth     (csr_mhpmcounter6h ),
    .csr_event      (csr_mhpmevent6 ),

    .count_ovf      (mhpmcounter6_ovf),

    .clk_aon        (clk_aon    ),
    .clk            (clk    ),
    .rst_n          (rst_n)
    );

  `else

   assign csr_mhpmcounter3   = `N22_XLEN'b0;
   assign csr_mhpmcounter3h  = `N22_XLEN'b0;
   assign csr_mhpmevent3     = `N22_XLEN'b0;
   assign mhpmcounter3_ovf   = 1'b0;

   assign csr_mhpmcounter4   = `N22_XLEN'b0;
   assign csr_mhpmcounter4h  = `N22_XLEN'b0;
   assign csr_mhpmevent4     = `N22_XLEN'b0;
   assign mhpmcounter4_ovf   = 1'b0;

   assign csr_mhpmcounter5   = `N22_XLEN'b0;
   assign csr_mhpmcounter5h  = `N22_XLEN'b0;
   assign csr_mhpmevent5     = `N22_XLEN'b0;
   assign mhpmcounter5_ovf   = 1'b0;

   assign csr_mhpmcounter6   = `N22_XLEN'b0;
   assign csr_mhpmcounter6h  = `N22_XLEN'b0;
   assign csr_mhpmevent6     = `N22_XLEN'b0;
   assign mhpmcounter6_ovf   = 1'b0;

  `endif

  wire mcounterinten_ena = wr_mcounterinten;
  wire [`N22_XLEN-1:0] mcounterinten_r;
  `ifdef N22_PMON_NUM_IS_4
  wire [`N22_XLEN-1:0] mcounterinten_nxt = {25'b0,wbck_csr_dat[6:2],1'b0,wbck_csr_dat[0]};
  `else
  wire [`N22_XLEN-1:0] mcounterinten_nxt = {29'b0,wbck_csr_dat[2],1'b0,wbck_csr_dat[0]};
  `endif
  n22_gnrl_dfflr #(`N22_XLEN) mcounterinten_dfflr (mcounterinten_ena, mcounterinten_nxt, mcounterinten_r, clk, rst_n);
  assign csr_mcounterinten = mcounterinten_r;

  wire mcountinhibit_ena = wr_mcountinhibit;
  wire [`N22_XLEN-1:0] mcountinhibit_r;
  `ifdef N22_PMON_NUM_IS_4
  wire [`N22_XLEN-1:0] mcountinhibit_nxt = {25'b0,wbck_csr_dat[6:2],1'b0,wbck_csr_dat[0]};
  `else
  wire [`N22_XLEN-1:0] mcountinhibit_nxt = {29'b0,wbck_csr_dat[2],1'b0,wbck_csr_dat[0]};
  `endif
  n22_gnrl_dfflr #(`N22_XLEN) mcountinhibit_dfflr (mcountinhibit_ena, mcountinhibit_nxt, mcountinhibit_r, clk, rst_n);
  assign csr_mcountinhibit = mcountinhibit_r;

  assign mcountinhibit_cy   = mcountinhibit_r[0];
  assign mcountinhibit_ir   = mcountinhibit_r[2];
  assign mcountinhibit_hpm3 = mcountinhibit_r[3];
  assign mcountinhibit_hpm4 = mcountinhibit_r[4];
  assign mcountinhibit_hpm5 = mcountinhibit_r[5];
  assign mcountinhibit_hpm6 = mcountinhibit_r[6];

  wire mhpmcounter6_ovf_r;
  wire mhpmcounter6_ovf_set = mhpmcounter6_ovf;
  wire mhpmcounter6_ovf_clr = wr_mcounterovf & wbck_csr_dat[6];
  wire mhpmcounter6_ovf_ena = mhpmcounter6_ovf_set | mhpmcounter6_ovf_clr;
  wire mhpmcounter6_ovf_nxt = mhpmcounter6_ovf_set & (~mhpmcounter6_ovf_clr);
  n22_gnrl_dfflr #(1) mhpmcounter6_ovf_dfflr (mhpmcounter6_ovf_ena, mhpmcounter6_ovf_nxt, mhpmcounter6_ovf_r, clk_aon, rst_n);
  assign csr_mcounterovf[6] = mhpmcounter6_ovf_r;
  assign csr_mcounterovf_set[6] = mhpmcounter6_ovf_set;

  wire mhpmcounter5_ovf_r;
  wire mhpmcounter5_ovf_set = mhpmcounter5_ovf;
  wire mhpmcounter5_ovf_clr = wr_mcounterovf & wbck_csr_dat[5];
  wire mhpmcounter5_ovf_ena = mhpmcounter5_ovf_set | mhpmcounter5_ovf_clr;
  wire mhpmcounter5_ovf_nxt = mhpmcounter5_ovf_set & (~mhpmcounter5_ovf_clr);
  n22_gnrl_dfflr #(1) mhpmcounter5_ovf_dfflr (mhpmcounter5_ovf_ena, mhpmcounter5_ovf_nxt, mhpmcounter5_ovf_r, clk_aon, rst_n);
  assign csr_mcounterovf[5] = mhpmcounter5_ovf_r;
  assign csr_mcounterovf_set[5] = mhpmcounter5_ovf_set;

  wire mhpmcounter4_ovf_r;
  wire mhpmcounter4_ovf_set = mhpmcounter4_ovf;
  wire mhpmcounter4_ovf_clr = wr_mcounterovf & wbck_csr_dat[4];
  wire mhpmcounter4_ovf_ena = mhpmcounter4_ovf_set | mhpmcounter4_ovf_clr;
  wire mhpmcounter4_ovf_nxt = mhpmcounter4_ovf_set & (~mhpmcounter4_ovf_clr);
  n22_gnrl_dfflr #(1) mhpmcounter4_ovf_dfflr (mhpmcounter4_ovf_ena, mhpmcounter4_ovf_nxt, mhpmcounter4_ovf_r, clk_aon, rst_n);
  assign csr_mcounterovf[4] = mhpmcounter4_ovf_r;
  assign csr_mcounterovf_set[4] = mhpmcounter4_ovf_set;

  wire mhpmcounter3_ovf_r;
  wire mhpmcounter3_ovf_set = mhpmcounter3_ovf;
  wire mhpmcounter3_ovf_clr = wr_mcounterovf & wbck_csr_dat[3];
  wire mhpmcounter3_ovf_ena = mhpmcounter3_ovf_set | mhpmcounter3_ovf_clr;
  wire mhpmcounter3_ovf_nxt = mhpmcounter3_ovf_set & (~mhpmcounter3_ovf_clr);
  n22_gnrl_dfflr #(1) mhpmcounter3_ovf_dfflr (mhpmcounter3_ovf_ena, mhpmcounter3_ovf_nxt, mhpmcounter3_ovf_r, clk_aon, rst_n);
  assign csr_mcounterovf[3] = mhpmcounter3_ovf_r;
  assign csr_mcounterovf_set[3] = mhpmcounter3_ovf_set;

  wire minstret_ovf_r;
  wire minstret_ovf_set = minstret_ovf;
  wire minstret_ovf_clr = wr_mcounterovf & wbck_csr_dat[2];
  wire minstret_ovf_ena = minstret_ovf_set | minstret_ovf_clr;
  wire minstret_ovf_nxt = minstret_ovf_set & (~minstret_ovf_clr);
  n22_gnrl_dfflr #(1) minstret_ovf_dfflr (minstret_ovf_ena, minstret_ovf_nxt, minstret_ovf_r, clk, rst_n);
  assign csr_mcounterovf[2] = minstret_ovf_r;
  assign csr_mcounterovf_set[2] = minstret_ovf_set;

  wire mcycle_ovf_r;
  wire mcycle_ovf_set = mcycle_ovf;
  wire mcycle_ovf_clr = wr_mcounterovf & wbck_csr_dat[0];
  wire mcycle_ovf_ena = mcycle_ovf_set | mcycle_ovf_clr;
  wire mcycle_ovf_nxt = mcycle_ovf_set & (~mcycle_ovf_clr);
  n22_gnrl_dfflr #(1) mcycle_ovf_dfflr (mcycle_ovf_ena, mcycle_ovf_nxt, mcycle_ovf_r, clk_aon, rst_n);
  assign csr_mcounterovf[0] = mcycle_ovf_r;
  assign csr_mcounterovf_set[0] = mcycle_ovf_set;

  assign csr_mcounterovf[31:7] = 25'b0;
  assign csr_mcounterovf[1] = 1'b0;

  assign csr_mcounterovf_set[31:7] = 25'b0;
  assign csr_mcounterovf_set[1] = 1'b0;


  `ifdef N22_HAS_UMODE
  wire [`N22_XLEN-1:0] csr_cycle        = csr_mcycle;
  wire [`N22_XLEN-1:0] csr_cycleh       = csr_mcycleh;
  wire [`N22_XLEN-1:0] csr_instret      = csr_minstret;
  wire [`N22_XLEN-1:0] csr_instreth     = csr_minstreth;
  wire [`N22_XLEN-1:0] csr_hpmcounter3  = csr_mhpmcounter3 ;
  wire [`N22_XLEN-1:0] csr_hpmcounter4  = csr_mhpmcounter4 ;
  wire [`N22_XLEN-1:0] csr_hpmcounter5  = csr_mhpmcounter5 ;
  wire [`N22_XLEN-1:0] csr_hpmcounter6  = csr_mhpmcounter6 ;
  wire [`N22_XLEN-1:0] csr_hpmcounter3h = csr_mhpmcounter3h;
  wire [`N22_XLEN-1:0] csr_hpmcounter4h = csr_mhpmcounter4h;
  wire [`N22_XLEN-1:0] csr_hpmcounter5h = csr_mhpmcounter5h;
  wire [`N22_XLEN-1:0] csr_hpmcounter6h = csr_mhpmcounter6h;

  wire mcounteren_ena = wr_mcounteren;
  wire [`N22_XLEN-1:0] mcounteren_r;
  `ifdef N22_PMON_NUM_IS_4
  wire [`N22_XLEN-1:0] mcounteren_nxt = {25'b0,wbck_csr_dat[6:0]};
  `else
  wire [`N22_XLEN-1:0] mcounteren_nxt = {29'b0,wbck_csr_dat[2:0]};
  `endif
  n22_gnrl_dfflr #(`N22_XLEN) mcounteren_dfflr (mcounteren_ena, mcounteren_nxt, mcounteren_r, clk, rst_n);
  assign csr_mcounteren = mcounteren_r;

  wire mcounterwen_ena = wr_mcounterwen;
  wire [`N22_XLEN-1:0] mcounterwen_r;
  `ifdef N22_PMON_NUM_IS_4
  wire [`N22_XLEN-1:0] mcounterwen_nxt = {25'b0,wbck_csr_dat[6:2],1'b0,wbck_csr_dat[0]};
  `else
  wire [`N22_XLEN-1:0] mcounterwen_nxt = {29'b0,wbck_csr_dat[2],1'b0,wbck_csr_dat[0]};
  `endif
  n22_gnrl_dfflr #(`N22_XLEN) mcounterwen_dfflr (mcounterwen_ena, mcounterwen_nxt, mcounterwen_r, clk, rst_n);
  assign csr_mcounterwen = mcounterwen_r;


  wire mcountermask_m_ena = wr_mcountermask_m;
  wire [`N22_XLEN-1:0] mcountermask_m_r;
  `ifdef N22_PMON_NUM_IS_4
  wire [`N22_XLEN-1:0] mcountermask_m_nxt = {25'b0,wbck_csr_dat[6:2],1'b0,wbck_csr_dat[0]};
  `else
  wire [`N22_XLEN-1:0] mcountermask_m_nxt = {29'b0,wbck_csr_dat[2],1'b0,wbck_csr_dat[0]};
  `endif
  n22_gnrl_dfflr #(`N22_XLEN) mcountermask_m_dfflr (mcountermask_m_ena, mcountermask_m_nxt, mcountermask_m_r, clk, rst_n);
  assign csr_mcountermask_m = mcountermask_m_r;

  wire mcountermask_u_ena = wr_mcountermask_u;
  wire [`N22_XLEN-1:0] mcountermask_u_r;
  `ifdef N22_PMON_NUM_IS_4
  wire [`N22_XLEN-1:0] mcountermask_u_nxt = {25'b0,wbck_csr_dat[6:2],1'b0,wbck_csr_dat[0]};
  `else
  wire [`N22_XLEN-1:0] mcountermask_u_nxt = {29'b0,wbck_csr_dat[2],1'b0,wbck_csr_dat[0]};
  `endif
  n22_gnrl_dfflr #(`N22_XLEN) mcountermask_u_dfflr (mcountermask_u_ena, mcountermask_u_nxt, mcountermask_u_r, clk, rst_n);
  assign csr_mcountermask_u = mcountermask_u_r;

  `endif

  `ifndef N22_HAS_UMODE
  assign csr_mcounteren     = `N22_XLEN'b0;
  assign csr_mcounterwen    = `N22_XLEN'b0;
  assign csr_mcountermask_m = `N22_XLEN'b0;
  assign csr_mcountermask_u = `N22_XLEN'b0;
  `endif


  `else
  wire [`N22_XLEN-1:0] csr_mcycle         = `N22_XLEN'b0;
  wire [`N22_XLEN-1:0] csr_mcycleh        = `N22_XLEN'b0;
  wire [`N22_XLEN-1:0] csr_minstret       = `N22_XLEN'b0;
  wire [`N22_XLEN-1:0] csr_minstreth      = `N22_XLEN'b0;
  wire [`N22_XLEN-1:0] csr_mhpmcounter3   = `N22_XLEN'b0;
  wire [`N22_XLEN-1:0] csr_mhpmcounter4   = `N22_XLEN'b0;
  wire [`N22_XLEN-1:0] csr_mhpmcounter5   = `N22_XLEN'b0;
  wire [`N22_XLEN-1:0] csr_mhpmcounter6   = `N22_XLEN'b0;
  wire [`N22_XLEN-1:0] csr_mhpmcounter3h  = `N22_XLEN'b0;
  wire [`N22_XLEN-1:0] csr_mhpmcounter4h  = `N22_XLEN'b0;
  wire [`N22_XLEN-1:0] csr_mhpmcounter5h  = `N22_XLEN'b0;
  wire [`N22_XLEN-1:0] csr_mhpmcounter6h  = `N22_XLEN'b0;
  wire [`N22_XLEN-1:0] csr_mhpmevent3     = `N22_XLEN'b0;
  wire [`N22_XLEN-1:0] csr_mhpmevent4     = `N22_XLEN'b0;
  wire [`N22_XLEN-1:0] csr_mhpmevent5     = `N22_XLEN'b0;
  wire [`N22_XLEN-1:0] csr_mhpmevent6     = `N22_XLEN'b0;
  wire [`N22_XLEN-1:0] csr_mcountinhibit  = `N22_XLEN'b0;
  wire [`N22_XLEN-1:0] csr_mcounterinten  = `N22_XLEN'b0;
  wire [`N22_XLEN-1:0] csr_mcounterovf    = `N22_XLEN'b0;
  wire [`N22_XLEN-1:0] csr_mcounterovf_set    = `N22_XLEN'b0;

  assign csr_mcounteren     = `N22_XLEN'b0;
  assign csr_mcounterwen    = `N22_XLEN'b0;
  assign csr_mcountermask_m = `N22_XLEN'b0;
  assign csr_mcountermask_u = `N22_XLEN'b0;

  wire [`N22_XLEN-1:0] csr_cycle          = `N22_XLEN'b0;
  wire [`N22_XLEN-1:0] csr_cycleh         = `N22_XLEN'b0;
  wire [`N22_XLEN-1:0] csr_instret        = `N22_XLEN'b0;
  wire [`N22_XLEN-1:0] csr_instreth       = `N22_XLEN'b0;
  wire [`N22_XLEN-1:0] csr_hpmcounter3    = `N22_XLEN'b0;
  wire [`N22_XLEN-1:0] csr_hpmcounter4    = `N22_XLEN'b0;
  wire [`N22_XLEN-1:0] csr_hpmcounter5    = `N22_XLEN'b0;
  wire [`N22_XLEN-1:0] csr_hpmcounter6    = `N22_XLEN'b0;
  wire [`N22_XLEN-1:0] csr_hpmcounter3h   = `N22_XLEN'b0;
  wire [`N22_XLEN-1:0] csr_hpmcounter4h   = `N22_XLEN'b0;
  wire [`N22_XLEN-1:0] csr_hpmcounter5h   = `N22_XLEN'b0;
  wire [`N22_XLEN-1:0] csr_hpmcounter6h   = `N22_XLEN'b0;

  `endif

  assign mcounterwen_cy   = csr_mcounterwen[0];
  assign mcounterwen_ir   = csr_mcounterwen[2];
  assign mcounterwen_hpm3 = csr_mcounterwen[3];
  assign mcounterwen_hpm4 = csr_mcounterwen[4];
  assign mcounterwen_hpm5 = csr_mcounterwen[5];
  assign mcounterwen_hpm6 = csr_mcounterwen[6];

  assign mcountermask_m_cy   = csr_mcountermask_m[0];
  assign mcountermask_m_ir   = csr_mcountermask_m[2];
  assign mcountermask_m_hpm3 = csr_mcountermask_m[3];
  assign mcountermask_m_hpm4 = csr_mcountermask_m[4];
  assign mcountermask_m_hpm5 = csr_mcountermask_m[5];
  assign mcountermask_m_hpm6 = csr_mcountermask_m[6];

  assign mcountermask_u_cy   = csr_mcountermask_u[0];
  assign mcountermask_u_ir   = csr_mcountermask_u[2];
  assign mcountermask_u_hpm3 = csr_mcountermask_u[3];
  assign mcountermask_u_hpm4 = csr_mcountermask_u[4];
  assign mcountermask_u_hpm5 = csr_mcountermask_u[5];
  assign mcountermask_u_hpm6 = csr_mcountermask_u[6];

  assign pmon_pmovf_irq = |(csr_mcounterinten & csr_mcounterovf_set);

  wire mcounteren_cy   = csr_mcounteren[0];
  wire mcounteren_tm   = csr_mcounteren[1];
  wire mcounteren_ir   = csr_mcounteren[2];
  wire mcounteren_hpm3 = csr_mcounteren[3];
  wire mcounteren_hpm4 = csr_mcounteren[4];
  wire mcounteren_hpm5 = csr_mcounteren[5];
  wire mcounteren_hpm6 = csr_mcounteren[6];





  assign {csr_addr_legal, read_csr_dat} = {1'b0,`N22_XLEN'b0}
                 | {sel_mcycle       , ({`N22_XLEN{rd_mcycle    }} & csr_mcycle    )}
                 | {sel_mcycleh      , ({`N22_XLEN{rd_mcycleh   }} & csr_mcycleh   )}
                 | {sel_minstret     , ({`N22_XLEN{rd_minstret  }} & csr_minstret  )}
                 | {sel_minstreth    , ({`N22_XLEN{rd_minstreth }} & csr_minstreth )}
                 | {sel_mhpmcounter3 , ({`N22_XLEN{rd_mhpmcounter3 }} & csr_mhpmcounter3 )}
                 | {sel_mhpmcounter4 , ({`N22_XLEN{rd_mhpmcounter4 }} & csr_mhpmcounter4 )}
                 | {sel_mhpmcounter5 , ({`N22_XLEN{rd_mhpmcounter5 }} & csr_mhpmcounter5 )}
                 | {sel_mhpmcounter6 , ({`N22_XLEN{rd_mhpmcounter6 }} & csr_mhpmcounter6 )}
                 | {sel_mhpmcounter3h, ({`N22_XLEN{rd_mhpmcounter3h}} & csr_mhpmcounter3h)}
                 | {sel_mhpmcounter4h, ({`N22_XLEN{rd_mhpmcounter4h}} & csr_mhpmcounter4h)}
                 | {sel_mhpmcounter5h, ({`N22_XLEN{rd_mhpmcounter5h}} & csr_mhpmcounter5h)}
                 | {sel_mhpmcounter6h, ({`N22_XLEN{rd_mhpmcounter6h}} & csr_mhpmcounter6h)}

                 | {sel_mhpmcounter7   , ({`N22_XLEN{rd_mhpmcounter7  }} & 32'b0 )}
                 | {sel_mhpmcounter8   , ({`N22_XLEN{rd_mhpmcounter8  }} & 32'b0 )}
                 | {sel_mhpmcounter9   , ({`N22_XLEN{rd_mhpmcounter9  }} & 32'b0 )}
                 | {sel_mhpmcounter10  , ({`N22_XLEN{rd_mhpmcounter10 }} & 32'b0 )}
                 | {sel_mhpmcounter11  , ({`N22_XLEN{rd_mhpmcounter11 }} & 32'b0 )}
                 | {sel_mhpmcounter12  , ({`N22_XLEN{rd_mhpmcounter12 }} & 32'b0 )}
                 | {sel_mhpmcounter13  , ({`N22_XLEN{rd_mhpmcounter13 }} & 32'b0 )}
                 | {sel_mhpmcounter14  , ({`N22_XLEN{rd_mhpmcounter14 }} & 32'b0 )}
                 | {sel_mhpmcounter15  , ({`N22_XLEN{rd_mhpmcounter15 }} & 32'b0 )}
                 | {sel_mhpmcounter16  , ({`N22_XLEN{rd_mhpmcounter16 }} & 32'b0 )}
                 | {sel_mhpmcounter17  , ({`N22_XLEN{rd_mhpmcounter17 }} & 32'b0 )}
                 | {sel_mhpmcounter18  , ({`N22_XLEN{rd_mhpmcounter18 }} & 32'b0 )}
                 | {sel_mhpmcounter19  , ({`N22_XLEN{rd_mhpmcounter19 }} & 32'b0 )}
                 | {sel_mhpmcounter20  , ({`N22_XLEN{rd_mhpmcounter20 }} & 32'b0 )}
                 | {sel_mhpmcounter21  , ({`N22_XLEN{rd_mhpmcounter21 }} & 32'b0 )}
                 | {sel_mhpmcounter22  , ({`N22_XLEN{rd_mhpmcounter22 }} & 32'b0 )}
                 | {sel_mhpmcounter23  , ({`N22_XLEN{rd_mhpmcounter23 }} & 32'b0 )}
                 | {sel_mhpmcounter24  , ({`N22_XLEN{rd_mhpmcounter24 }} & 32'b0 )}
                 | {sel_mhpmcounter25  , ({`N22_XLEN{rd_mhpmcounter25 }} & 32'b0 )}
                 | {sel_mhpmcounter26  , ({`N22_XLEN{rd_mhpmcounter26 }} & 32'b0 )}
                 | {sel_mhpmcounter27  , ({`N22_XLEN{rd_mhpmcounter27 }} & 32'b0 )}
                 | {sel_mhpmcounter28  , ({`N22_XLEN{rd_mhpmcounter28 }} & 32'b0 )}
                 | {sel_mhpmcounter29  , ({`N22_XLEN{rd_mhpmcounter29 }} & 32'b0 )}
                 | {sel_mhpmcounter30  , ({`N22_XLEN{rd_mhpmcounter30 }} & 32'b0 )}
                 | {sel_mhpmcounter31  , ({`N22_XLEN{rd_mhpmcounter31 }} & 32'b0 )}

                 | {sel_mhpmcounter7h  , ({`N22_XLEN{rd_mhpmcounter7h }} & 32'b0 )}
                 | {sel_mhpmcounter8h  , ({`N22_XLEN{rd_mhpmcounter8h }} & 32'b0 )}
                 | {sel_mhpmcounter9h  , ({`N22_XLEN{rd_mhpmcounter9h }} & 32'b0 )}
                 | {sel_mhpmcounter10h , ({`N22_XLEN{rd_mhpmcounter10h}} & 32'b0 )}
                 | {sel_mhpmcounter11h , ({`N22_XLEN{rd_mhpmcounter11h}} & 32'b0 )}
                 | {sel_mhpmcounter12h , ({`N22_XLEN{rd_mhpmcounter12h}} & 32'b0 )}
                 | {sel_mhpmcounter13h , ({`N22_XLEN{rd_mhpmcounter13h}} & 32'b0 )}
                 | {sel_mhpmcounter14h , ({`N22_XLEN{rd_mhpmcounter14h}} & 32'b0 )}
                 | {sel_mhpmcounter15h , ({`N22_XLEN{rd_mhpmcounter15h}} & 32'b0 )}
                 | {sel_mhpmcounter16h , ({`N22_XLEN{rd_mhpmcounter16h}} & 32'b0 )}
                 | {sel_mhpmcounter17h , ({`N22_XLEN{rd_mhpmcounter17h}} & 32'b0 )}
                 | {sel_mhpmcounter18h , ({`N22_XLEN{rd_mhpmcounter18h}} & 32'b0 )}
                 | {sel_mhpmcounter19h , ({`N22_XLEN{rd_mhpmcounter19h}} & 32'b0 )}
                 | {sel_mhpmcounter20h , ({`N22_XLEN{rd_mhpmcounter20h}} & 32'b0 )}
                 | {sel_mhpmcounter21h , ({`N22_XLEN{rd_mhpmcounter21h}} & 32'b0 )}
                 | {sel_mhpmcounter22h , ({`N22_XLEN{rd_mhpmcounter22h}} & 32'b0 )}
                 | {sel_mhpmcounter23h , ({`N22_XLEN{rd_mhpmcounter23h}} & 32'b0 )}
                 | {sel_mhpmcounter24h , ({`N22_XLEN{rd_mhpmcounter24h}} & 32'b0 )}
                 | {sel_mhpmcounter25h , ({`N22_XLEN{rd_mhpmcounter25h}} & 32'b0 )}
                 | {sel_mhpmcounter26h , ({`N22_XLEN{rd_mhpmcounter26h}} & 32'b0 )}
                 | {sel_mhpmcounter27h , ({`N22_XLEN{rd_mhpmcounter27h}} & 32'b0 )}
                 | {sel_mhpmcounter28h , ({`N22_XLEN{rd_mhpmcounter28h}} & 32'b0 )}
                 | {sel_mhpmcounter29h , ({`N22_XLEN{rd_mhpmcounter29h}} & 32'b0 )}
                 | {sel_mhpmcounter30h , ({`N22_XLEN{rd_mhpmcounter30h}} & 32'b0 )}
                 | {sel_mhpmcounter31h , ({`N22_XLEN{rd_mhpmcounter31h}} & 32'b0 )}

                 | {sel_mhpmevent3   , ({`N22_XLEN{rd_mhpmevent3   }} & csr_mhpmevent3   )}
                 | {sel_mhpmevent4   , ({`N22_XLEN{rd_mhpmevent4   }} & csr_mhpmevent4   )}
                 | {sel_mhpmevent5   , ({`N22_XLEN{rd_mhpmevent5   }} & csr_mhpmevent5   )}
                 | {sel_mhpmevent6   , ({`N22_XLEN{rd_mhpmevent6   }} & csr_mhpmevent6   )}
              `ifdef N22_HAS_PMONITOR
                 | {sel_mcounterinten, ({`N22_XLEN{rd_mcounterinten}} & csr_mcounterinten)}
                 | {sel_mcounterovf  , ({`N22_XLEN{rd_mcounterovf  }} & csr_mcounterovf  )}
              `endif
                 | {sel_mcountinhibit, ({`N22_XLEN{rd_mcountinhibit}} & csr_mcountinhibit)}
              `ifdef N22_HAS_UMODE
                 | {sel_mcounteren , ({`N22_XLEN{rd_mcounteren }} & csr_mcounteren )   }
                 | {sel_mcounterwen, ({`N22_XLEN{rd_mcounterwen }} & csr_mcounterwen )   }
                 | {sel_mcountermask_m, ({`N22_XLEN{rd_mcountermask_m}} & csr_mcountermask_m)}
                 | {sel_mcountermask_u, ({`N22_XLEN{rd_mcountermask_u}} & csr_mcountermask_u)}
                 | {sel_cycle      , ({`N22_XLEN{rd_cycle      }} & csr_cycle   )      }
                 | {sel_cycleh     , ({`N22_XLEN{rd_cycleh     }} & csr_cycleh  )      }
                 | {sel_instret    , ({`N22_XLEN{rd_instret    }} & csr_instret )      }
                 | {sel_instreth   , ({`N22_XLEN{rd_instreth   }} & csr_instreth)      }
                 | {sel_hpmcounter3 , ({`N22_XLEN{rd_hpmcounter3 }} & csr_hpmcounter3 )}
                 | {sel_hpmcounter4 , ({`N22_XLEN{rd_hpmcounter4 }} & csr_hpmcounter4 )}
                 | {sel_hpmcounter5 , ({`N22_XLEN{rd_hpmcounter5 }} & csr_hpmcounter5 )}
                 | {sel_hpmcounter6 , ({`N22_XLEN{rd_hpmcounter6 }} & csr_hpmcounter6 )}

                 | {sel_hpmcounter3h, ({`N22_XLEN{rd_hpmcounter3h}} & csr_hpmcounter3h)}
                 | {sel_hpmcounter4h, ({`N22_XLEN{rd_hpmcounter4h}} & csr_hpmcounter4h)}
                 | {sel_hpmcounter5h, ({`N22_XLEN{rd_hpmcounter5h}} & csr_hpmcounter5h)}
                 | {sel_hpmcounter6h, ({`N22_XLEN{rd_hpmcounter6h}} & csr_hpmcounter6h)}

                 | {sel_hpmcounter7   , ({`N22_XLEN{rd_hpmcounter7  }} & 32'b0 )}
                 | {sel_hpmcounter8   , ({`N22_XLEN{rd_hpmcounter8  }} & 32'b0 )}
                 | {sel_hpmcounter9   , ({`N22_XLEN{rd_hpmcounter9  }} & 32'b0 )}
                 | {sel_hpmcounter10  , ({`N22_XLEN{rd_hpmcounter10 }} & 32'b0 )}
                 | {sel_hpmcounter11  , ({`N22_XLEN{rd_hpmcounter11 }} & 32'b0 )}
                 | {sel_hpmcounter12  , ({`N22_XLEN{rd_hpmcounter12 }} & 32'b0 )}
                 | {sel_hpmcounter13  , ({`N22_XLEN{rd_hpmcounter13 }} & 32'b0 )}
                 | {sel_hpmcounter14  , ({`N22_XLEN{rd_hpmcounter14 }} & 32'b0 )}
                 | {sel_hpmcounter15  , ({`N22_XLEN{rd_hpmcounter15 }} & 32'b0 )}
                 | {sel_hpmcounter16  , ({`N22_XLEN{rd_hpmcounter16 }} & 32'b0 )}
                 | {sel_hpmcounter17  , ({`N22_XLEN{rd_hpmcounter17 }} & 32'b0 )}
                 | {sel_hpmcounter18  , ({`N22_XLEN{rd_hpmcounter18 }} & 32'b0 )}
                 | {sel_hpmcounter19  , ({`N22_XLEN{rd_hpmcounter19 }} & 32'b0 )}
                 | {sel_hpmcounter20  , ({`N22_XLEN{rd_hpmcounter20 }} & 32'b0 )}
                 | {sel_hpmcounter21  , ({`N22_XLEN{rd_hpmcounter21 }} & 32'b0 )}
                 | {sel_hpmcounter22  , ({`N22_XLEN{rd_hpmcounter22 }} & 32'b0 )}
                 | {sel_hpmcounter23  , ({`N22_XLEN{rd_hpmcounter23 }} & 32'b0 )}
                 | {sel_hpmcounter24  , ({`N22_XLEN{rd_hpmcounter24 }} & 32'b0 )}
                 | {sel_hpmcounter25  , ({`N22_XLEN{rd_hpmcounter25 }} & 32'b0 )}
                 | {sel_hpmcounter26  , ({`N22_XLEN{rd_hpmcounter26 }} & 32'b0 )}
                 | {sel_hpmcounter27  , ({`N22_XLEN{rd_hpmcounter27 }} & 32'b0 )}
                 | {sel_hpmcounter28  , ({`N22_XLEN{rd_hpmcounter28 }} & 32'b0 )}
                 | {sel_hpmcounter29  , ({`N22_XLEN{rd_hpmcounter29 }} & 32'b0 )}
                 | {sel_hpmcounter30  , ({`N22_XLEN{rd_hpmcounter30 }} & 32'b0 )}
                 | {sel_hpmcounter31  , ({`N22_XLEN{rd_hpmcounter31 }} & 32'b0 )}

                 | {sel_hpmcounter7h  , ({`N22_XLEN{rd_hpmcounter7h }} & 32'b0 )}
                 | {sel_hpmcounter8h  , ({`N22_XLEN{rd_hpmcounter8h }} & 32'b0 )}
                 | {sel_hpmcounter9h  , ({`N22_XLEN{rd_hpmcounter9h }} & 32'b0 )}
                 | {sel_hpmcounter10h , ({`N22_XLEN{rd_hpmcounter10h}} & 32'b0 )}
                 | {sel_hpmcounter11h , ({`N22_XLEN{rd_hpmcounter11h}} & 32'b0 )}
                 | {sel_hpmcounter12h , ({`N22_XLEN{rd_hpmcounter12h}} & 32'b0 )}
                 | {sel_hpmcounter13h , ({`N22_XLEN{rd_hpmcounter13h}} & 32'b0 )}
                 | {sel_hpmcounter14h , ({`N22_XLEN{rd_hpmcounter14h}} & 32'b0 )}
                 | {sel_hpmcounter15h , ({`N22_XLEN{rd_hpmcounter15h}} & 32'b0 )}
                 | {sel_hpmcounter16h , ({`N22_XLEN{rd_hpmcounter16h}} & 32'b0 )}
                 | {sel_hpmcounter17h , ({`N22_XLEN{rd_hpmcounter17h}} & 32'b0 )}
                 | {sel_hpmcounter18h , ({`N22_XLEN{rd_hpmcounter18h}} & 32'b0 )}
                 | {sel_hpmcounter19h , ({`N22_XLEN{rd_hpmcounter19h}} & 32'b0 )}
                 | {sel_hpmcounter20h , ({`N22_XLEN{rd_hpmcounter20h}} & 32'b0 )}
                 | {sel_hpmcounter21h , ({`N22_XLEN{rd_hpmcounter21h}} & 32'b0 )}
                 | {sel_hpmcounter22h , ({`N22_XLEN{rd_hpmcounter22h}} & 32'b0 )}
                 | {sel_hpmcounter23h , ({`N22_XLEN{rd_hpmcounter23h}} & 32'b0 )}
                 | {sel_hpmcounter24h , ({`N22_XLEN{rd_hpmcounter24h}} & 32'b0 )}
                 | {sel_hpmcounter25h , ({`N22_XLEN{rd_hpmcounter25h}} & 32'b0 )}
                 | {sel_hpmcounter26h , ({`N22_XLEN{rd_hpmcounter26h}} & 32'b0 )}
                 | {sel_hpmcounter27h , ({`N22_XLEN{rd_hpmcounter27h}} & 32'b0 )}
                 | {sel_hpmcounter28h , ({`N22_XLEN{rd_hpmcounter28h}} & 32'b0 )}
                 | {sel_hpmcounter29h , ({`N22_XLEN{rd_hpmcounter29h}} & 32'b0 )}
                 | {sel_hpmcounter30h , ({`N22_XLEN{rd_hpmcounter30h}} & 32'b0 )}
                 | {sel_hpmcounter31h , ({`N22_XLEN{rd_hpmcounter31h}} & 32'b0 )}

              `endif
              ;

`ifdef N22_HAS_UMODE


    wire sel_hpmcounter_7_31 =
                   sel_hpmcounter7
                 | sel_hpmcounter8
                 | sel_hpmcounter9
                 | sel_hpmcounter10
                 | sel_hpmcounter11
                 | sel_hpmcounter12
                 | sel_hpmcounter13
                 | sel_hpmcounter14
                 | sel_hpmcounter15
                 | sel_hpmcounter16
                 | sel_hpmcounter17
                 | sel_hpmcounter18
                 | sel_hpmcounter19
                 | sel_hpmcounter20
                 | sel_hpmcounter21
                 | sel_hpmcounter22
                 | sel_hpmcounter23
                 | sel_hpmcounter24
                 | sel_hpmcounter25
                 | sel_hpmcounter26
                 | sel_hpmcounter27
                 | sel_hpmcounter28
                 | sel_hpmcounter29
                 | sel_hpmcounter30
                 | sel_hpmcounter31

                 | sel_hpmcounter7h
                 | sel_hpmcounter8h
                 | sel_hpmcounter9h
                 | sel_hpmcounter10h
                 | sel_hpmcounter11h
                 | sel_hpmcounter12h
                 | sel_hpmcounter13h
                 | sel_hpmcounter14h
                 | sel_hpmcounter15h
                 | sel_hpmcounter16h
                 | sel_hpmcounter17h
                 | sel_hpmcounter18h
                 | sel_hpmcounter19h
                 | sel_hpmcounter20h
                 | sel_hpmcounter21h
                 | sel_hpmcounter22h
                 | sel_hpmcounter23h
                 | sel_hpmcounter24h
                 | sel_hpmcounter25h
                 | sel_hpmcounter26h
                 | sel_hpmcounter27h
                 | sel_hpmcounter28h
                 | sel_hpmcounter29h
                 | sel_hpmcounter30h
                 | sel_hpmcounter31h;

  assign csr_umode_sel_legal = (
                    sel_cycle
                  | sel_cycleh
                  | sel_instret
                  | sel_instreth
                  | sel_hpmcounter3
                  | sel_hpmcounter4
                  | sel_hpmcounter5
                  | sel_hpmcounter6

                  | sel_hpmcounter3h
                  | sel_hpmcounter4h
                  | sel_hpmcounter5h
                  | sel_hpmcounter6h

                  | sel_hpmcounter_7_31
                 )
               ;

  assign csr_umode_wro_ilgl =
                     csr_wr_en &
               (
                    ((~mcounterwen_cy) & sel_cycle        )
                  | ((~mcounterwen_cy) & sel_cycleh       )
                  | ((~mcounterwen_ir) & sel_instret      )
                  | ((~mcounterwen_ir) & sel_instreth     )
                  | ((~mcounterwen_hpm3)  & sel_hpmcounter3  )
                  | ((~mcounterwen_hpm3)  & sel_hpmcounter3h )
                  | ((~mcounterwen_hpm4)  & sel_hpmcounter4  )
                  | ((~mcounterwen_hpm4)  & sel_hpmcounter4h )
                  | ((~mcounterwen_hpm5)  & sel_hpmcounter5  )
                  | ((~mcounterwen_hpm5)  & sel_hpmcounter5h )
                  | ((~mcounterwen_hpm6)  & sel_hpmcounter6  )
                  | ((~mcounterwen_hpm6)  & sel_hpmcounter6h )

                  | sel_hpmcounter_7_31
                 )
               ;

  assign csr_umode_prv_ilgl = u_mode & csr_rd_en &
               (
                    ((~mcounteren_cy) & sel_cycle        )
                  | ((~mcounteren_cy) & sel_cycleh       )
                  | ((~mcounteren_ir) & sel_instret      )
                  | ((~mcounteren_ir) & sel_instreth     )
                  | ((~mcounteren_hpm3)  & sel_hpmcounter3  )
                  | ((~mcounteren_hpm3)  & sel_hpmcounter3h )
                  | ((~mcounteren_hpm4)  & sel_hpmcounter4  )
                  | ((~mcounteren_hpm4)  & sel_hpmcounter4h )
                  | ((~mcounteren_hpm5)  & sel_hpmcounter5  )
                  | ((~mcounteren_hpm5)  & sel_hpmcounter5h )
                  | ((~mcounteren_hpm6)  & sel_hpmcounter6  )
                  | ((~mcounteren_hpm6)  & sel_hpmcounter6h )

                  | sel_hpmcounter_7_31
                 )
               ;


`endif

`ifndef N22_HAS_UMODE
  assign csr_umode_sel_legal = 1'b1;
  assign csr_umode_prv_ilgl = 1'b0;
  assign csr_umode_wro_ilgl = 1'b0;
`endif

endmodule

