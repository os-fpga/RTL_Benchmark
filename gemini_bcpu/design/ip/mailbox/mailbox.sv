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

//---------------------------
// MBOX and SEMAPHORE muxing
//---------------------------

// byte access is not allowed
assign werr = |wreq && ~(&wstr);

assign sem_rreq =  rreq[SEM_NUM_OF_CPUS-1:0];
assign sem_wreq =  wreq[SEM_NUM_OF_CPUS*2-1:SEM_NUM_OF_CPUS];

assign mbox_wreq = wreq[MBOX_REGS_NUM-1:SEM_NUM_OF_CPUS*2];
assign mbox_rreq = rreq[MBOX_REGS_NUM-1:SEM_NUM_OF_CPUS*2];

assign rack = (|sem_rreq)? sem_rack : mbox_rack;
assign rdat = (|sem_rreq)? sem_rdat : mbox_rdat;
assign wack = (|sem_wreq)? sem_wack : mbox_wack;

//------------------------------
// Instances
//------------------------------

apb_manager #(
	.AWIDTH  ( MBOX_AWIDTH   ),
	.REGS_NUM( MBOX_REGS_NUM ),
	.DWIDTH  ( MBOX_DWIDTH   ),
	.MAP     ( MBOX_MAP      ))
apb_manager_u (
	.clk      ( pclk     ),
	.rst_n    ( presetn  ),

	.apb_addr ( paddr    ),
	.apb_sel  ( psel     ),
	.apb_en   ( penable  ),
	.apb_wr   ( pwrite   ),
	.apb_wdata( pwdata   ),
	.apb_strb ( pstrb    ),
	.apb_rdata( prdata   ),
	.apb_ready( pready   ),
	.apb_err  ( pslverr  ),

	.rack     ( rack     ),
	.rerr     ( 1'b0     ),
	.rdat     ( rdat     ),
	.rreq     ( rreq     ),
	.wack     ( wack     ),
	.werr     ( werr     ),
	.wdat     ( wdat     ),
	.wreq     ( wreq     ),
	.wstr     ( wstr     )
  );

soc_semaphore#(.NUM_OF_CPUS (SEM_NUM_OF_CPUS))
soc_semaphore_u (
	.clk         ( pclk     ),
	.rst_n       ( presetn  ),
	.rack_o      ( sem_rack ),
	.rdat_o      ( sem_rdat ),
	.rreq_i      ( sem_rreq ),
	.wack_o      ( sem_wack ),
	.wdat_i      ( wdat     ),
	.wreq_i      ( sem_wreq )
);


mbox #(
    .NUM_OF_CPUS      ( MBOX_NUM_OF_CPUS      ),
    .REQ_WIDTH        ( MBOX_REQ_WIDTH        ),
    .NUM_OF_MAILBOXES ( MBOX_NUM_OF_MAILBOXES ))
mailbox_u (
	.clk    ( pclk       ),
	.rst_n  ( presetn    ),
	.rack_o ( mbox_rack  ),
	.rdat_o ( mbox_rdat  ),
	.rreq_i ( mbox_rreq  ),
	.wack_o ( mbox_wack  ),
	.wdat_i ( wdat       ),
	.wreq_i ( mbox_wreq  ),
	.irq_o  ( irq_o      )
);


endmodule



//==============================================================================
//                                SEMAPHORE MODULE
//==============================================================================


module soc_semaphore #( parameter NUM_OF_CPUS =  4 )
(
	input logic                      clk     ,
	input logic                      rst_n   ,
	// read apb_manager
	output logic                     rack_o  ,
	output logic [MBOX_DWIDTH-1:0]   rdat_o  ,
	input  logic [NUM_OF_CPUS-1:0]   rreq_i  ,
	// write apb_manager
	output logic                     wack_o  ,
	input  logic [MBOX_DWIDTH-1:0]   wdat_i  ,
	input  logic [NUM_OF_CPUS-1:0]   wreq_i
);

//---------------------------
// Declarations
//---------------------------

logic [15:0]       rdat_comb                        ;
logic [15:0]       sem_ctrl_r     [NUM_OF_CPUS-1:0] ;
logic [15:0]       ctrl_wr_en     [NUM_OF_CPUS-1:0] ;
logic [15:0]       sem_ctrl_other [NUM_OF_CPUS-1:0] ;

//------------------------
// WRITE LOGIC
//------------------------

genvar ii, jj;
generate
for (ii=0; ii < NUM_OF_CPUS; ii++) begin: gen_cpu
	for (jj=0; jj < 16; jj++) begin: gen_mbox


	always_comb begin
		sem_ctrl_other[ii][jj] ={1'b0};
		for (int k = 0; k < NUM_OF_CPUS; k++) if(k!=ii) sem_ctrl_other[ii][jj] |= sem_ctrl_r[k][jj];
	end

	//when wr req and bit is not owned by other cpu
	assign ctrl_wr_en[ii][jj]  = wreq_i[ii] && ~sem_ctrl_other[ii][jj];


	always @(posedge clk or negedge rst_n) begin
		if(!rst_n)                   sem_ctrl_r[ii][jj] <= 1'b0;
		else if (ctrl_wr_en[ii][jj]) sem_ctrl_r[ii][jj] <= (wdat_i[jj+16])? sem_ctrl_r[ii][jj] : wdat_i[jj];
	end


	end
end
endgenerate

assign wack_o = |wreq_i;

//------------------------
// READ LOGIC
//------------------------

always_comb begin
	rdat_comb = {MBOX_DWIDTH{1'b0}};
	for (int i = 0; i < NUM_OF_CPUS; i++) if (rreq_i[i]) rdat_comb = sem_ctrl_r[i];
end

assign rack_o = |rreq_i;
assign rdat_o = {16'b0, rdat_comb};

endmodule



//==============================================================================
//                                  MAILBOX MODULE
//==============================================================================


module mbox #( parameter NUM_OF_CPUS      = 4,
               parameter NUM_OF_MAILBOXES = 12,
               parameter REQ_WIDTH        = 20)
(
	input logic                     clk    ,
	input logic                     rst_n  ,
	// read apb_manager
	output logic                    rack_o ,
	output logic [MBOX_DWIDTH-1:0]  rdat_o ,
	input  logic   [REQ_WIDTH-1:0]  rreq_i ,
	// write apb_manager
	output logic                    wack_o ,
	input  logic [MBOX_DWIDTH-1:0]  wdat_i ,
	input  logic   [REQ_WIDTH-1:0]  wreq_i ,
	//irq
	output logic [NUM_OF_CPUS-1:0]  irq_o
);

//------------------------------
// Params
//------------------------------

localparam MBOX_EMPTY   = 2'b00;
localparam MBOX_BUSY    = 2'b01;
localparam MBOX_OWNED   = 2'b10;
localparam MBOX_ACTIVE  = 2'b11;
localparam MBOX_RELEASE = 2'b11;

//------------------------------
// Declarations
//------------------------------

logic [MBOX_DWIDTH-1:0]      rdat_stat                                     ;
logic [MBOX_DWIDTH-1:0]      rdat_msg                                      ;
logic [MBOX_DWIDTH-1:0]      mbox_status         [NUM_OF_CPUS-1:0]         ;
logic [23:0]                 mbox_ctrl_r         [NUM_OF_CPUS-1:0]         ;
logic [23:0]                 mbox_ctrl_or                                  ;

logic [NUM_OF_MAILBOXES-1:0] mbox_own_set        [NUM_OF_CPUS-1:0]         ;
logic [NUM_OF_MAILBOXES-1:0] mbox_own_set_or                               ;
logic [NUM_OF_MAILBOXES-1:0] mbox_own_rst_all    [NUM_OF_CPUS-1:0]         ;
logic [NUM_OF_MAILBOXES-1:0] mbox_own_rst        [NUM_OF_CPUS-1:0]         ;
logic [NUM_OF_MAILBOXES-1:0] mbox_busy_set       [NUM_OF_CPUS-1:0]         ;
logic [NUM_OF_MAILBOXES-1:0] mbox_msg_set        [NUM_OF_CPUS-1:0]         ;

logic [MBOX_DWIDTH-1:0]      mbox_msg_r          [NUM_OF_MAILBOXES-1:0]    ;
logic [3:0]                  mbox_dst_r          [NUM_OF_MAILBOXES-1:0]    ;
logic [3:0]                  mbox_src_r          [NUM_OF_MAILBOXES-1:0]    ;
logic [3:0]                  irq_mask_r          [NUM_OF_MAILBOXES-1:0]    ;
logic [NUM_OF_MAILBOXES-1:0] dst_set                                       ;
logic [NUM_OF_MAILBOXES-1:0] dst_rst                                       ;

logic [NUM_OF_CPUS-1:0]      irq_r                                         ;

logic [11:0]                 msg_wreq                                      ;
logic [11:0]                 msg_rreq                                      ;
logic [3:0]                  ctrl_wreq                                     ;
logic [3:0]                  ctrl_rreq                                     ;

//------------------------------
//     ctrl/msg requests
//------------------------------

assign msg_wreq  = wreq_i[11:0];
assign ctrl_wreq = wreq_i[19:16];

assign msg_rreq  = rreq_i[11:0];
assign ctrl_rreq = rreq_i[15:12];

//------------------------------
//      CTRL, IRQ WRITE
//------------------------------

always_comb begin
	mbox_ctrl_or ='b0;
	mbox_own_set_or = 'b0;
	for (int k = 0; k < NUM_OF_CPUS; k++) begin
		mbox_ctrl_or    |= mbox_ctrl_r[k];
		mbox_own_set_or |= mbox_own_set[k];
	end
end


genvar ii, jj;
generate
for (ii=0; ii < NUM_OF_CPUS; ii++) begin: gen_cpu_wr
	for (jj=0; jj < NUM_OF_MAILBOXES; jj++) begin: gen_mboxs


// try to set ownership when cmd(own) and mbox not busy
	assign mbox_own_set[ii][jj]  = ctrl_wreq[ii] && (wdat_i[jj*2+:2]==MBOX_OWNED) && (mbox_ctrl_or[jj*2+:2] == MBOX_EMPTY);
// release ownership when cmd(rel) and you owner (?? wrong!, when dst==you)
	assign mbox_own_rst[ii][jj]  = ctrl_wreq[ii] && (wdat_i[jj*2+:2]==MBOX_RELEASE) && (mbox_ctrl_r[ii][jj*2+:2] == MBOX_ACTIVE);
// set busy for current CPU when owned by other
	assign mbox_busy_set[ii][jj] = ctrl_wreq[ii] && (mbox_own_set_or[jj] && !mbox_own_set[ii][jj]);
// set msg flag when msg write to mbox
	assign mbox_msg_set[ii][jj]  = msg_wreq[jj] && (mbox_dst_r[jj] == ii);


	always @(posedge clk or negedge rst_n) begin
		if(!rst_n)                      mbox_ctrl_r[ii][jj*2+:2] <= MBOX_EMPTY  ;
		else if (mbox_own_rst[ii][jj])  mbox_ctrl_r[ii][jj*2+:2] <= MBOX_EMPTY  ;
		else if (mbox_busy_set[ii][jj]) mbox_ctrl_r[ii][jj*2+:2] <= MBOX_BUSY   ;
		else if (mbox_own_set[ii][jj])  mbox_ctrl_r[ii][jj*2+:2] <= MBOX_OWNED  ;
		else if (mbox_msg_set[ii][jj])  mbox_ctrl_r[ii][jj*2+:2] <= MBOX_ACTIVE ;
	end

		end
	end
endgenerate

generate
for (ii=0; ii < NUM_OF_CPUS; ii++) begin: gen_irq

	always @(posedge clk or negedge rst_n) begin
		if(!rst_n)               irq_mask_r[ii] <= 4'b0          ;
		else if (ctrl_wreq[ii])  irq_mask_r[ii] <= wdat_i[31:28] ;
	end

// reset condition for IRQ ??
	always @(posedge clk or negedge rst_n) begin
		if(!rst_n)                  irq_r[ii] <= 1'b0                 ;
		else if (|mbox_msg_set[ii]) irq_r[ii] <= !irq_mask_r[ii][ii]  ;
		//else if (irq_rst) irq_r[ii] <= 1'b0                ;
	end

end
endgenerate


assign irq_o = irq_r;

assign wack_o = |{msg_wreq, ctrl_wreq};

//------------------------------
//         CTRL READ
//------------------------------

generate
	for (ii=0; ii < NUM_OF_CPUS; ii++) begin: gen_cpu_rd

	assign mbox_status[ii] = {irq_mask_r[ii], mbox_src_r[ii], mbox_ctrl_r[ii]};

	end
endgenerate


always_comb begin
	rdat_stat = {MBOX_DWIDTH{1'b0}};
	for (int i = 0; i < NUM_OF_CPUS; i++) if (ctrl_rreq[i]) rdat_stat = mbox_status[i];
end

always_comb begin
	rdat_msg = {MBOX_DWIDTH{1'b0}};
	for (int i = 0; i < NUM_OF_MAILBOXES; i++) if (msg_rreq[i]) rdat_msg = mbox_msg_r[i];
end

assign rack_o = |{ctrl_rreq, msg_rreq};
assign rdat_o = (|msg_rreq)? rdat_msg : rdat_stat;

//------------------------------
// MESSAGE, DST, SRC WRITE
//------------------------------

generate
	for (jj=0; jj < NUM_OF_MAILBOXES; jj++) begin: gen_mbox

	always @(posedge clk or negedge rst_n) begin
		if(!rst_n)              mbox_msg_r[jj] <= 32'b0  ;
		else if (msg_wreq[jj])  mbox_msg_r[jj] <= wdat_i ;
	end

	always_comb begin
		dst_set[jj] ='b0;
		for (int k = 0; k < NUM_OF_CPUS; k++) dst_set[jj] |= mbox_own_set[k][jj];
	end

	always_comb begin
		dst_rst[jj] ='b0;
		for (int k = 0; k < NUM_OF_CPUS; k++) dst_rst[jj] |= mbox_own_rst[k][jj];
	end

	always @(posedge clk or negedge rst_n) begin
		if(!rst_n)             mbox_dst_r[jj] <= 4'b0          ;
		else if (dst_set[jj])  mbox_dst_r[jj] <= wdat_i[27:24] ;
		else if (dst_rst[jj])  mbox_dst_r[jj] <= 4'b0          ;
	end

	always @(posedge clk or negedge rst_n) begin
		if(!rst_n)             mbox_src_r[jj] <= 4'b0          ;
		else if (dst_set[jj])  mbox_src_r[jj] <= ctrl_wreq     ;
		else if (dst_rst[jj])  mbox_src_r[jj] <= 4'b0          ;
	end

	end
endgenerate

endmodule