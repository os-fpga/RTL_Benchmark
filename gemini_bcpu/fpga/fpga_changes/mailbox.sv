// `include "mailbox_registers.svh"


module soc_mbox #( parameter SEM_NUM_OF_CPUS       = 4,
                   parameter MBOX_NUM_OF_CPUS      = 4,
                   parameter MBOX_NUM_OF_MAILBOXES = 12 )
	(
	input  logic                         pclk    ,
	input  logic                         presetn ,
	input  logic [MBOX_AWIDTH-1:0]       paddr   ,
	input  logic                         psel    ,
	input  logic                         penable ,
	input  logic                         pwrite  ,
	input  logic [MBOX_DWIDTH-1:0]       pwdata  ,
	input  logic [MBOX_DWIDTH/8-1:0]     pstrb   ,
	output logic [MBOX_DWIDTH-1:0]       prdata  ,
	output logic                         pready  ,
	output logic                         pslverr ,
	output logic [MBOX_NUM_OF_CPUS-1:0]  irq_o
);

localparam MBOX_REQ_WIDTH = MBOX_REGS_NUM-SEM_NUM_OF_CPUS*2;

//---------------------------
// Declarations
//---------------------------


logic [MBOX_DWIDTH-1:0]   rdat ;
logic [MBOX_DWIDTH-1:0]   wdat ;
logic                     rack ;
logic [MBOX_REGS_NUM-1:0] rreq ;
logic [MBOX_REGS_NUM-1:0] wreq ;
logic                     wack ;
logic                     werr ;
logic [3:0]               wstr ;

logic  [MBOX_DWIDTH-1:0]       sem_rdat ;
logic                          sem_rack ;
logic  [SEM_NUM_OF_CPUS-1:0]   sem_rreq ;
logic  [SEM_NUM_OF_CPUS-1:0]   sem_wreq ;
logic                          sem_wack ;

logic [MBOX_DWIDTH-1:0]        mbox_rdat ;
logic                          mbox_rack ;
logic [MBOX_REQ_WIDTH-1:0]     mbox_rreq ;
logic [MBOX_REQ_WIDTH-1:0]     mbox_wreq ;
logic                          mbox_wack ;


assign /*	output logic [MBOX_DWIDTH-1:0]      */ prdata  ='d0;
assign /*	output logic                        */ pready  ='d0;
assign /*	output logic                        */ pslverr ='d0;
assign /*	output logic [MBOX_NUM_OF_CPUS-1:0] */ irq_o 	='d0;


endmodule
