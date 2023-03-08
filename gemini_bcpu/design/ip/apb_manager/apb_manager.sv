module apb_manager 
#(
parameter                         AWIDTH   =  8 ,
parameter                         REGS_NUM =  1 ,
parameter                         DWIDTH   =  32,
parameter [AWIDTH * REGS_NUM-1:0] MAP      =  {AWIDTH*REGS_NUM{1'b0}}
 )

(  // system
input  logic                clk      ,
input  logic                rst_n    ,
  // APB
input  logic [AWIDTH-1:0]   apb_addr ,
input  logic                apb_sel  ,
input  logic                apb_en   , 
input  logic                apb_wr   ,
input  logic [DWIDTH-1:0]   apb_wdata,
input  logic [DWIDTH/8-1:0] apb_strb ,

output logic [DWIDTH-1:0]   apb_rdata,
output logic                apb_ready,
output logic                apb_err  ,  
  // read apb_manager
input  logic                rack     ,
input  logic                rerr     ,
input  logic [DWIDTH-1:0]   rdat     , 

output logic [REGS_NUM-1:0] rreq     ,
  // write apb_manager
input  logic                wack     ,
input  logic                werr     ,

output logic [DWIDTH-1:0]   wdat     ,
output logic [REGS_NUM-1:0] wreq     ,
output logic [DWIDTH/8-1:0] wstr 
);
//////////////////////////////////////////////////////////////////////////
//                              Declarations
//////////////////////////////////////////////////////////////////////////
logic wval         ;
logic rval         ;
logic wfail        ;
logic wdone        ;
logic rdone        ;
logic rfail        ;
logic hit          ;
logic set_apb_err  ;
logic set_apb_ready;

logic [DWIDTH-1:0]   apb_rdata_r;
logic [REGS_NUM-1:0] cmp        ;
logic                apb_sel_d  ;
logic                apb_err_r  ;
logic                apb_ready_r;
//////////////////////////////////////////////////////////////////////////
//                              End declarations 
//////////////////////////////////////////////////////////////////////////
always @ (posedge clk or negedge rst_n)
  if (!rst_n) apb_sel_d <= 1'b0   ;
  else                         apb_sel_d <= apb_sel;

// write and read enable
assign wval = apb_sel & (!apb_sel_d & !apb_en | apb_en) &  apb_wr;
assign rval = apb_sel & (!apb_sel_d & !apb_en | apb_en) & !apb_wr;

// сomparison of the input address apb_addr with register addresses from the MAP
always @*
  for (integer i = 0; i < REGS_NUM; i = i + 1)
  cmp[i] = apb_sel && (MAP[AWIDTH*i+:AWIDTH] == apb_addr);

// hit: To form an errors wfail and rfail
assign hit = |cmp;
// wdone, rdone
assign wdone = wval & wack;
assign rdone = rval & rack;

// wfail, rfail
assign wfail = wval & (!hit | werr);
assign rfail = rval & (!hit | rerr);

// wreq, rreq - requests for individual 
//              interfaces for access to 
//              registers for reading and writing.
assign wreq = (wval & !apb_ready) ? cmp : {REGS_NUM{1'b0}};
assign rreq = (rval & !apb_ready) ? cmp : {REGS_NUM{1'b0}};

assign set_apb_err = wfail | rfail;

always @ (posedge clk or negedge rst_n)
  if (!rst_n)            apb_err_r <= 1'b0;
  else if (apb_ready_r) apb_err_r <= 1'b0;
  else if (set_apb_err) apb_err_r <= 1'b1;

assign apb_err = apb_err_r;

assign set_apb_ready =  wval & (wdone | wfail) | rval & (rdone | rfail);

always @ (posedge clk or negedge rst_n)
  if (!rst_n)              apb_ready_r <= 1'b0;
  else if (apb_ready_r)   apb_ready_r <= 1'b0;
  else if (set_apb_ready) apb_ready_r <= 1'b1;

assign apb_ready = apb_ready_r;

always @ (posedge clk or negedge rst_n)
  if (!rst_n) apb_rdata_r <= {DWIDTH{1'b0}};
  else       apb_rdata_r <= rdat          ;

assign apb_rdata = apb_rdata_r;

assign wstr = apb_strb;

assign wdat = apb_wdata;

endmodule