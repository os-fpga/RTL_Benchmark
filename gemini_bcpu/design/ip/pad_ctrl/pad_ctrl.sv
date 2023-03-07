`ifndef PAD_CTRL
	`define PAD_CTRL

module pad_ctrl #(
	parameter                     AWIDTH    = 16,
// pads parameters
	parameter                     C_PADS    = 32,
	parameter                     C_FUNC    =  2,
	// register map by default
	parameter [32*C_PADS-1:0]     RESET_MAP = '0,
	parameter [C_FUNC*C_PADS-1:0] INACTIVE  = '0
)(
// APB config interface
	// master
	input  wire                pclk,
	input  wire                prst_n,
	input  wire [AWIDTH -1:0]  paddr,
	input  wire                psel,
	input  wire                penable,
	input  wire                pwrite,
	input  wire [31:0]         pwdata,
	input  wire [4-1:0]        pstrb,
	// slave
	output reg  [31:0]         prdata,
	output reg                 pready,
	output reg                 perr,
// PADs control interface
	input  wire [C_PADS-1:0]   pad_c,
	output wire [C_PADS-1:0]   pad_st,
	output wire [C_PADS-1:0]   pad_pull_en,
	output wire [C_PADS-1:0]   pad_pull_dir,
	output reg  [C_PADS-1:0]   pad_i,
	output reg  [C_PADS-1:0]   pad_ie,
	output reg  [C_PADS-1:0]   pad_oen,
	output wire [C_PADS-1:0]   pad_ds0,
	output wire [C_PADS-1:0]   pad_ds1,
	output wire [C_PADS-1:0]   pad_ds2,
 // signal mux interface
 	input  wire[C_PADS-1:0]   inp_mux [C_FUNC-1:0],
 	input  wire[C_PADS-1:0]   dir_mux [C_FUNC-1:0],
 	output wire[C_PADS-1:0]   out_mux [C_FUNC-1:0]
);
// pus register command
localparam CMD_PUSH        = 32'h2A6;
// enable all  command
localparam CMD_ENABLE_ALL  = 32'h54C;
// disable all command
localparam CMD_DISABLE_ALL = 32'h193;

localparam W_DATA = 32;

localparam OFFSET   = W_DATA/8;
localparam C_REGS   = C_PADS + 1;
localparam REGS_LSB = $clog2(OFFSET);
localparam REGS_MSB = $clog2(OFFSET * C_REGS) - 1;

// register access
wire regs_acc;
wire regs_write, regs_read;
wire regs_miss;
wire regs_hit;

assign regs_acc   = psel & ~penable;

assign regs_miss  = psel & ~(paddr < C_REGS*(OFFSET));
assign regs_hit   = regs_acc & (paddr < C_REGS*(OFFSET));

assign regs_write = regs_hit &  pwrite;
assign regs_read  = regs_hit & ~pwrite;

// command register
reg  push;
wire cmd_reg_sel;
assign cmd_reg_sel = ~|paddr[REGS_MSB:REGS_LSB];

wire dis_all, enb_all;
assign dis_all = cmd_reg_sel & regs_write & (pwdata == CMD_DISABLE_ALL);
assign enb_all = cmd_reg_sel & regs_write & (pwdata == CMD_ENABLE_ALL );

wire push_acc;
assign push_acc = (pwdata == CMD_PUSH);

always_ff @(posedge pclk, negedge prst_n)
	if (~prst_n)                                  push <= 1'b1;
	else if (cmd_reg_sel & regs_write & push_acc) push <= 1'b1;
  else if (regs_write  & ~cmd_reg_sel)          push <= 1'b0;

// pad control register
localparam EN      = 0;
localparam DS_LSB  = EN     + 1;
localparam DS_MSB  = DS_LSB + 2;
localparam ST      = DS_MSB + 1;
localparam PUDE    = ST     + 1;
localparam PUDD    = PUDE   + 1;
localparam MUX_LSB = PUDD   + 1;
localparam MUX_MBS = $clog2(C_FUNC) + MUX_LSB -1;

localparam W_MUX = MUX_MBS - MUX_LSB + 1;
localparam W_DS  = DS_MSB  - DS_LSB  + 1;

// registers for APB access
reg [W_DATA-1:0] tmp [C_PADS-1:0];
// register for muxing control
reg [W_MUX -1:0] mux_control [C_PADS-1:0];
// pull_up enable
reg [C_PADS-1:0] pull_updn_en;
// pull down enable
reg [C_PADS-1:0] pull_updn_dr;
// schmitt trigger enable
reg [C_PADS-1:0] schmitt_en;
// driving strength control
reg [W_DS-1:0]   ds_control [C_PADS-1:0];
// pad enable
reg [C_PADS-1:0] pad_en;

reg [W_DATA-1:0] regs_array [C_PADS:0];

wire [W_DATA-1:0] wmask;
logic [W_DATA-1:0] rdata;

always_comb begin : set_prdata
  integer regn;
  rdata = 32'h0;
  for (regn = 0; regn < C_REGS; regn++) begin
    if (paddr[REGS_MSB:REGS_LSB] == regn) rdata = regs_array[regn];
  end
end

always_ff @(posedge pclk, negedge prst_n) begin
	if(~prst_n)         prdata <= 'b0;
	else if (regs_read) prdata <= rdata;
end

always_ff @(posedge pclk, negedge prst_n)
	if(~prst_n) perr <= 1'b0;
	else        perr <= regs_miss;

always_ff @(posedge pclk, negedge prst_n)
	if(~prst_n) pready <= 1'b0;
	else        pready <= regs_acc;

generate
	if(W_DATA/8 == 4)
		assign wmask = {{8{pstrb[3]}}, {8{pstrb[2]}}, {8{pstrb[1]}}, {8{pstrb[0]}}};
	else if(W_DATA/8 == 2)
		assign wmask = {{8{pstrb[1]}}, {8{pstrb[0]}}};
	else
		assign wmask = '1;
endgenerate

genvar i,j;

assign regs_array[0] = {{(W_DATA-1){1'b0}}, push};

generate
	for(i = 1; i < C_REGS; i = i + 1) begin: tmp_regs
		always_ff @(posedge pclk, negedge prst_n)
			if(~prst_n)          tmp[i-1] <= RESET_MAP[W_DATA*(i-1)+:W_DATA];
			else if (enb_all)    tmp[i-1] <= {tmp[i-1][W_DATA-1:1],1'b1};
			else if (dis_all)    tmp[i-1] <= {tmp[i-1][W_DATA-1:1],1'b0};
			else if (regs_write) tmp[i-1] <= (paddr[REGS_MSB:REGS_LSB] == i) ? ((wmask & pwdata) | (~wmask &  tmp[i-1])) : tmp[i-1];
	end
endgenerate

generate
	for(i = 1; i < C_REGS; i = i + 1) begin: acc
		assign regs_array [i] = {
			{(W_DATA-1 - MUX_MBS){1'b0}},
			mux_control[i-1] ,
			pull_updn_dr[i-1],
			pull_updn_en[i-1],
			schmitt_en[i-1]  ,
			ds_control[i-1]  ,
			pad_en[i-1]
			};
	end
endgenerate

generate
	for(i = 0; i < C_PADS; i = i + 1) begin: pad_regs

		always_ff @(posedge pclk, negedge prst_n)
			if (~prst_n) begin
				mux_control[i]  <= RESET_MAP [MUX_MBS + (i*W_DATA): MUX_LSB + (i*W_DATA)];
				pull_updn_en[i] <= RESET_MAP [PUDE    + (i*W_DATA)];
				pull_updn_dr[i] <= RESET_MAP [PUDD    + (i*W_DATA)];
				schmitt_en[i]   <= RESET_MAP [ST      + (i*W_DATA)];
				ds_control[i]   <= RESET_MAP [DS_MSB  + (i*W_DATA): DS_LSB + (i*W_DATA)];
				pad_en[i]       <= RESET_MAP [EN      + (i*W_DATA)];
			end else if (push) begin
				mux_control[i]  <= tmp [i][MUX_MBS: MUX_LSB];
				pull_updn_en[i] <= tmp [i][PUDE];
				pull_updn_dr[i] <= tmp [i][PUDD];
				schmitt_en[i]   <= tmp [i][ST];
				ds_control[i]   <= tmp [i][DS_MSB: DS_LSB];
				pad_en[i]       <= tmp [i][EN];
			end
	end
endgenerate

generate
	for(i = 0; i < C_PADS; i = i + 1) begin : pad_ctrl
		assign pad_st[i]       = schmitt_en[i]   ;
		assign pad_pull_dir[i] = pull_updn_dr[i] ;
		assign pad_pull_en[i]  = pull_updn_en[i] ;
		assign pad_ds0[i]      = ds_control[i][0];
		assign pad_ds1[i]      = ds_control[i][1];
		assign pad_ds2[i]      = ds_control[i][2];

		for(j = 0; j < C_FUNC; j = j + 1)
			assign out_mux[j][i] = (pad_en[i] & mux_control[i] == j) ?  pad_c[i] : INACTIVE[j*C_PADS + i];
	end
endgenerate

generate
	for(i = 0; i < C_PADS; i = i + 1) begin : pad_mx
		assign pad_ie[i]  = (mux_control[i] < C_FUNC) ? pad_en[i] : 1'b0;
		assign pad_i[i]   = (mux_control[i] < C_FUNC) ? inp_mux[mux_control[i]][i] : inp_mux[0][i];
		assign pad_oen[i] = (mux_control[i] < C_FUNC) ? (~pad_en[i] | ~dir_mux[mux_control[i]][i]) : 1'b1;
	end
endgenerate

endmodule//pad_ctrl

`endif// PAD_CTRL
