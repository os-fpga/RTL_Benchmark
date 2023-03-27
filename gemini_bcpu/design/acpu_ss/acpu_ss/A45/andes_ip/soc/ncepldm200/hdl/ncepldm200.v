// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary


module ncepldm200(
		  debugint,
		  resethaltreq,
		  dmactive,
		  ndmreset,
		  clk,
		  dmi_resetn,
		  hart_unavail,
		  hart_under_reset,
		  bus_resetn,
		  rv_haddr,
		  rv_htrans,
		  rv_hwrite,
		  rv_hsize,
		  rv_hburst,
		  rv_hprot,
		  rv_hwdata,
		  rv_hsel,
		  rv_hready,
		  rv_hrdata,
		  rv_hreadyout,
		  rv_hresp,
		  rv_awid,
		  rv_awaddr,
		  rv_awlen,
		  rv_awsize,
		  rv_awburst,
		  rv_awlock,
		  rv_awcache,
		  rv_awprot,
		  rv_awvalid,
		  rv_awready,
		  rv_wdata,
		  rv_wstrb,
		  rv_wlast,
		  rv_wvalid,
		  rv_wready,
		  rv_bid,
		  rv_bresp,
		  rv_bvalid,
		  rv_bready,
		  rv_arid,
		  rv_araddr,
		  rv_arlen,
		  rv_arsize,
		  rv_arburst,
		  rv_arlock,
		  rv_arcache,
		  rv_arprot,
		  rv_arvalid,
		  rv_arready,
		  rv_rid,
		  rv_rdata,
		  rv_rresp,
		  rv_rlast,
		  rv_rvalid,
		  rv_rready,
		  sys_awid,
		  sys_awaddr,
		  sys_awlen,
		  sys_awsize,
		  sys_awburst,
		  sys_awlock,
		  sys_awcache,
		  sys_awprot,
		  sys_awvalid,
		  sys_awready,
		  sys_wdata,
		  sys_wstrb,
		  sys_wlast,
		  sys_wvalid,
		  sys_wready,
		  sys_bid,
		  sys_bresp,
		  sys_bvalid,
		  sys_bready,
		  sys_arid,
		  sys_araddr,
		  sys_arlen,
		  sys_arsize,
		  sys_arburst,
		  sys_arlock,
		  sys_arcache,
		  sys_arprot,
		  sys_arvalid,
		  sys_arready,
		  sys_rid,
		  sys_rdata,
		  sys_rresp,
		  sys_rlast,
		  sys_rvalid,
		  sys_rready,
		  sys_haddr,
		  sys_htrans,
		  sys_hwrite,
		  sys_hsize,
		  sys_hburst,
		  sys_hprot,
		  sys_hwdata,
		  sys_hbusreq,
		  sys_hrdata,
		  sys_hready,
		  sys_hresp,
		  sys_hgrant,
		  dmi_haddr,
		  dmi_htrans,
		  dmi_hwrite,
		  dmi_hsize,
		  dmi_hburst,
		  dmi_hprot,
		  dmi_hwdata,
		  dmi_hsel,
		  dmi_hready,
		  dmi_hrdata,
		  dmi_hreadyout,
		  dmi_hresp
);

parameter ADDR_WIDTH = 32;
parameter DATA_WIDTH = 32;
parameter SYS_ADDR_WIDTH = 32;
parameter SYS_DATA_WIDTH = 32;
parameter NHART = 1;
parameter DTM_ADDR_WIDTH = 9;

parameter SYSTEM_BUS_ACCESS_SUPPORT = "no";
parameter RV_BUS_TYPE  = "ahb";
parameter SYS_BUS_TYPE = "ahb";
parameter RV_ID_WIDTH  = 4;
parameter SYS_ID_WIDTH = 4;

parameter SYNC_STAGE   = 2;

parameter SERIAL_COUNT = 0;
parameter SERIAL0      = 0;

parameter  PROGBUF_SIZE	   = 2;
localparam ABS_DATA_COUNT  = 4;
parameter  HALTGROUP_COUNT = 0;
parameter  HASEL_SUPPORT   = "yes";
localparam HAWINDOW_NUM = (NHART+31)/32;
localparam HAWINDOWSEL_WIDTH = $clog2(HAWINDOW_NUM);
localparam HARTID_WIDTH = (NHART > 1) ? $clog2(NHART) : 1;
localparam HARTID_MASK  = (NHART > 1) ? {{(32-HARTID_WIDTH){1'b0}}, {HARTID_WIDTH{1'b1}}} : 32'd0;

localparam VERSION         = {2'd0, 10'd1, 10'd0, 10'd0};

output [NHART-1:0]		debugint;
output [NHART-1:0]		resethaltreq;
output				dmactive;
output				ndmreset;
input				clk;
input				dmi_resetn;
input [NHART-1:0]		hart_unavail;
input [NHART-1:0]		hart_under_reset;
input				bus_resetn;

input	[ADDR_WIDTH-1:0]	rv_haddr;
input	[1:0]			rv_htrans;
input				rv_hwrite;
input	[2:0]			rv_hsize;
input	[2:0]			rv_hburst;
input	[3:0]			rv_hprot;
input	[DATA_WIDTH-1:0]	rv_hwdata;
input				rv_hsel;
input				rv_hready;

output	[DATA_WIDTH-1:0]	rv_hrdata;
output				rv_hreadyout;
output	[1:0]			rv_hresp;

input	[RV_ID_WIDTH-1:0]	rv_awid;
input	[ADDR_WIDTH-1:0]	rv_awaddr;
input	[7:0]			rv_awlen;
input	[2:0]			rv_awsize;
input	[1:0]			rv_awburst;
input				rv_awlock;
input	[3:0]			rv_awcache;
input	[2:0]			rv_awprot;
input				rv_awvalid;
output				rv_awready;
input	[DATA_WIDTH-1:0]	rv_wdata;
input	[(DATA_WIDTH/8)-1:0]	rv_wstrb;
input				rv_wlast;
input				rv_wvalid;
output				rv_wready;
output	[RV_ID_WIDTH-1:0]	rv_bid;
output	[1:0]			rv_bresp;
output				rv_bvalid;
input				rv_bready;
input	[RV_ID_WIDTH-1:0]	rv_arid;
input	[ADDR_WIDTH-1:0]	rv_araddr;
input	[7:0]			rv_arlen;
input	[2:0]			rv_arsize;
input	[1:0]			rv_arburst;
input				rv_arlock;
input	[3:0]			rv_arcache;
input	[2:0]			rv_arprot;
input				rv_arvalid;
output				rv_arready;
output	[RV_ID_WIDTH-1:0]	rv_rid;
output	[DATA_WIDTH-1:0]	rv_rdata;
output	[1:0]			rv_rresp;
output				rv_rlast;
output				rv_rvalid;
input				rv_rready;

output	[SYS_ID_WIDTH-1:0]	sys_awid;
output	[SYS_ADDR_WIDTH-1:0]	sys_awaddr;
output	[7:0]			sys_awlen;
output	[2:0]			sys_awsize;
output	[1:0]			sys_awburst;
output				sys_awlock;
output	[3:0]			sys_awcache;
output	[2:0]			sys_awprot;
output				sys_awvalid;
input				sys_awready;
output	[SYS_DATA_WIDTH-1:0]	sys_wdata;
output	[(SYS_DATA_WIDTH/8)-1:0] sys_wstrb;
output				sys_wlast;
output				sys_wvalid;
input				sys_wready;
input	[SYS_ID_WIDTH-1:0]	sys_bid;
input	[1:0]			sys_bresp;
input				sys_bvalid;
output				sys_bready;
output	[SYS_ID_WIDTH-1:0]	sys_arid;
output	[SYS_ADDR_WIDTH-1:0]	sys_araddr;
output	[7:0]			sys_arlen;
output	[2:0]			sys_arsize;
output	[1:0]			sys_arburst;
output				sys_arlock;
output	[3:0]			sys_arcache;
output	[2:0]			sys_arprot;
output				sys_arvalid;
input				sys_arready;
input	[SYS_ID_WIDTH-1:0]	sys_rid;
input	[SYS_DATA_WIDTH-1:0]	sys_rdata;
input	[1:0]			sys_rresp;
input				sys_rlast;
input				sys_rvalid;
output				sys_rready;

output	[SYS_ADDR_WIDTH-1:0]	sys_haddr;
output	[1:0]			sys_htrans;
output				sys_hwrite;
output	[2:0]			sys_hsize;
output	[2:0]			sys_hburst;
output	[3:0]			sys_hprot;
output	[SYS_DATA_WIDTH-1:0]	sys_hwdata;
output				sys_hbusreq;

input	[SYS_DATA_WIDTH-1:0]	sys_hrdata;
input				sys_hready;
input	[1:0]			sys_hresp;
input				sys_hgrant;

input	[DTM_ADDR_WIDTH-1:0]	dmi_haddr;
input	[1:0]			dmi_htrans;
input				dmi_hwrite;
input	[2:0]			dmi_hsize;
input	[2:0]			dmi_hburst;
input	[3:0]			dmi_hprot;
input	[31:0]			dmi_hwdata;
input				dmi_hsel;
input				dmi_hready;

output	[31:0]			dmi_hrdata;
output				dmi_hreadyout;
output	[1:0]			dmi_hresp;

localparam DMI_ADDR_DMCONTROL    = 7'h10;
localparam DMI_ADDR_DMSTATUS     = 7'h11;
localparam DMI_ADDR_HARTINFO     = 7'h12;
localparam DMI_ADDR_HALTSUM1     = 7'h13;
localparam DMI_ADDR_HAWINDOWSEL  = 7'h14;
localparam DMI_ADDR_HAWINDOW     = 7'h15;
localparam DMI_ADDR_ABSTRACTCS   = 7'h16;
localparam DMI_ADDR_COMMAND      = 7'h17;
localparam DMI_ADDR_ABSTRACTAUTO = 7'h18;
localparam DMI_ADDR_DEVTREEADDR0 = 7'h19;
localparam DMI_ADDR_DEVTREEADDR1 = 7'h1a;
localparam DMI_ADDR_DEVTREEADDR2 = 7'h1b;
localparam DMI_ADDR_DEVTREEADDR3 = 7'h1c;

localparam DMI_ADDR_DATA0        = 7'h04;
localparam DMI_ADDR_DATA1        = 7'h05;
localparam DMI_ADDR_DATA2        = 7'h06;
localparam DMI_ADDR_DATA3        = 7'h07;

localparam DMI_ADDR_DATA4        = 7'h08;
localparam DMI_ADDR_DATA5        = 7'h09;
localparam DMI_ADDR_DATA6        = 7'h0a;
localparam DMI_ADDR_DATA7        = 7'h0b;
localparam DMI_ADDR_DATA8        = 7'h0c;
localparam DMI_ADDR_DATA9        = 7'h0d;
localparam DMI_ADDR_DATA10       = 7'h0e;
localparam DMI_ADDR_DATA11       = 7'h0f;
localparam DMI_ADDR_PROGBUF0     = 7'h20;
localparam DMI_ADDR_PROGBUF1     = 7'h21;
localparam DMI_ADDR_PROGBUF2     = 7'h22;
localparam DMI_ADDR_PROGBUF3     = 7'h23;
localparam DMI_ADDR_PROGBUF4     = 7'h24;
localparam DMI_ADDR_PROGBUF5     = 7'h25;
localparam DMI_ADDR_PROGBUF6     = 7'h26;
localparam DMI_ADDR_PROGBUF7     = 7'h27;
localparam DMI_ADDR_PROGBUF8     = 7'h28;
localparam DMI_ADDR_PROGBUF9     = 7'h29;
localparam DMI_ADDR_PROGBUF10    = 7'h2a;
localparam DMI_ADDR_PROGBUF11    = 7'h2b;
localparam DMI_ADDR_PROGBUF12    = 7'h2c;
localparam DMI_ADDR_PROGBUF13    = 7'h2d;
localparam DMI_ADDR_PROGBUF14    = 7'h2e;
localparam DMI_ADDR_PROGBUF15    = 7'h2f;
localparam DMI_ADDR_AUTHDATA     = 7'h30;
localparam DMI_ADDR_DMCS2        = 7'h32;
localparam DMI_ADDR_SERCS        = 7'h34;
localparam DMI_ADDR_SERTX        = 7'h35;
localparam DMI_ADDR_SERRX        = 7'h36;
localparam DMI_ADDR_SBCS         = 7'h38;
localparam DMI_ADDR_SBADDRESS0   = 7'h39;
localparam DMI_ADDR_SBADDRESS1   = 7'h3a;
localparam DMI_ADDR_SBADDRESS2   = 7'h3b;
localparam DMI_ADDR_SBADDRESS3   = 7'h37;
localparam DMI_ADDR_SBDATA0      = 7'h3c;
localparam DMI_ADDR_SBDATA1      = 7'h3d;
localparam DMI_ADDR_SBDATA2      = 7'h3e;
localparam DMI_ADDR_SBDATA3      = 7'h3f;
localparam DMI_ADDR_HALTSUM0     = 7'h40;
localparam DMI_ADDR_CUSTOM_VERSION = 7'h1f;

localparam DMI_ADDR_POWER_CONTROL = 7'h70;
localparam DMI_ADDR_POWER_STATE   = 7'h71;
localparam ABS_CMD_TYPE_REG_ACCESS   = 8'd0;
localparam ABS_CMD_TYPE_QUICK_ACCESS = 8'd1;
localparam ABS_CMD_TYPE_MEM_ACCESS   = 8'd2;

localparam ABS_CMD_SIZE_8            = 3'd0;
localparam ABS_CMD_SIZE_16           = 3'd1;
localparam ABS_CMD_SIZE_32           = 3'd2;
localparam ABS_CMD_SIZE_64           = 3'd3;
localparam ABS_CMD_SIZE_128          = 3'd4;

localparam ABS_J_PROGBUF0_0    = 32'hf81ff06f;
localparam ABS_J_PROGBUF0_1    = 32'hf7dff06f;
localparam ABS_J_PROGBUF0_2    = 32'hf79ff06f;
localparam ABS_J_PROGBUF0_3    = 32'hf75ff06f;
localparam ABS_J_PROGBUF0_4    = 32'hf71ff06f;

localparam ABS_READ_GPR_0_32   = 32'h0c002023;
localparam ABS_READ_GPR_0_64   = 32'h0c003023;
localparam ABS_READ_GPR_1      = 32'h00100073;
localparam ABS_READ_GPR_2      = 32'h00100073;
localparam ABS_READ_GPR_3      = 32'h00100073;
localparam ABS_READ_GPR_4      = 32'h00100073;
localparam ABS_WRITE_GPR_0_32  = 32'h0c002003;
localparam ABS_WRITE_GPR_0_64  = 32'h0c003003;
localparam ABS_WRITE_GPR_1     = 32'h00100073;
localparam ABS_WRITE_GPR_2     = 32'h00100073;
localparam ABS_WRITE_GPR_3     = 32'h00100073;
localparam ABS_WRITE_GPR_4     = 32'h00100073;
localparam ABS_READ_CSR_0      = 32'h7b241073;
localparam ABS_READ_CSR_1      = 32'h00002473;
localparam ABS_READ_CSR_2_32   = 32'h0c802023;
localparam ABS_READ_CSR_2_64   = 32'h0c803023;
localparam ABS_READ_CSR_3      = 32'h7b202473;
localparam ABS_READ_CSR_4      = 32'h00100073;
localparam ABS_WRITE_CSR_0     = 32'h7b241073;
localparam ABS_WRITE_CSR_1_32  = 32'h0c002403;
localparam ABS_WRITE_CSR_1_64  = 32'h0c003403;
localparam ABS_WRITE_CSR_2     = 32'h00041073;
localparam ABS_WRITE_CSR_3     = 32'h7b202473;
localparam ABS_WRITE_CSR_4     = 32'h00100073;

localparam ABS_READ_FPR_0_32   = 32'h0c002027;
localparam ABS_READ_FPR_0_64   = 32'h0c003027;
localparam ABS_READ_FPR_1      = 32'h00100073;
localparam ABS_READ_FPR_2      = 32'h00100073;
localparam ABS_READ_FPR_3      = 32'h00100073;
localparam ABS_READ_FPR_4      = 32'h00100073;
localparam ABS_WRITE_FPR_0_32  = 32'h0c002007;
localparam ABS_WRITE_FPR_0_64  = 32'h0c003007;
localparam ABS_WRITE_FPR_1     = 32'h00100073;
localparam ABS_WRITE_FPR_2     = 32'h00100073;
localparam ABS_WRITE_FPR_3     = 32'h00100073;
localparam ABS_WRITE_FPR_4     = 32'h00100073;

localparam ABS_MEM_ACCESS_0 = 32'h7b349073;
localparam ABS_MEM_ACCESS_1 = 32'h7b241073;
localparam ABS_MEM_ACCESS_2 = 32'h30102473;
localparam ABS_MEM_ACCESS_3 = 32'h00044663;
localparam ABS_MEM_ACCESS_4 = 32'h0c402403;
localparam ABS_MEM_ACCESS_5 = 32'h0080006f;
localparam ABS_MEM_ACCESS_6 = 32'h0c803403;
localparam ABS_MEM_ACCESS_7_LD = 32'h00040483;
localparam ABS_MEM_ACCESS_7_ST = 32'h0c000483;
localparam ABS_MEM_ACCESS_8_LD = 32'h0c900023;
localparam ABS_MEM_ACCESS_8_ST = 32'h00940023;
localparam ABS_MEM_ACCESS_9 = 32'h0180006f;
localparam ABS_MEM_ACCESS_POSTINCR_9  = 32'h00040413;
localparam ABS_MEM_ACCESS_POSTINCR_10 = 32'h301024f3;
localparam ABS_MEM_ACCESS_POSTINCR_11 = 32'h0004c663;
localparam ABS_MEM_ACCESS_POSTINCR_12 = 32'h0c802223;
localparam ABS_MEM_ACCESS_POSTINCR_13 = 32'h0080006f;
localparam ABS_MEM_ACCESS_POSTINCR_14 = 32'h0c803423;
localparam ABS_MEM_ACCESS_POSTINCR_15 = 32'h7b3024f3;
localparam ABS_MEM_ACCESS_POSTINCR_16 = 32'h7b202473;
localparam ABS_MEM_ACCESS_POSTINCR_17 = 32'h00100073;

localparam INSN_NOP  = 32'h00000023;

localparam ABS_SIZE_32   = 3'd2;
localparam ABS_SIZE_64   = 3'd3;

localparam RV_ADDR_PROGBUF0	= 7'h20;
localparam RV_ADDR_PROGBUF1	= 7'h21;
localparam RV_ADDR_PROGBUF2	= 7'h22;
localparam RV_ADDR_PROGBUF3	= 7'h23;
localparam RV_ADDR_PROGBUF4	= 7'h24;
localparam RV_ADDR_PROGBUF5	= 7'h25;
localparam RV_ADDR_PROGBUF6	= 7'h26;
localparam RV_ADDR_PROGBUF7	= 7'h27;
localparam RV_ADDR_PROGBUF8	= 7'h28;
localparam RV_ADDR_PROGBUF9	= 7'h29;
localparam RV_ADDR_PROGBUF10 = 7'h2a;
localparam RV_ADDR_PROGBUF11 = 7'h2b;
localparam RV_ADDR_PROGBUF12 = 7'h2c;
localparam RV_ADDR_PROGBUF13 = 7'h2d;
localparam RV_ADDR_PROGBUF14 = 7'h2e;
localparam RV_ADDR_PROGBUF15 = 7'h2f;

localparam RV_ADDR_DATA0	= 7'h30;
localparam RV_ADDR_DATA1	= 7'h31;
localparam RV_ADDR_DATA2	= 7'h32;
localparam RV_ADDR_DATA3	= 7'h33;
localparam RV_ADDR_DATA4	= 7'h34;
localparam RV_ADDR_DATA5	= 7'h35;
localparam RV_ADDR_DATA6	= 7'h36;
localparam RV_ADDR_DATA7	= 7'h37;

localparam RV_ADDR_ABSPROG0	= 7'h40;
localparam RV_ADDR_ABSPROG1	= 7'h41;
localparam RV_ADDR_ABSPROG2	= 7'h42;
localparam RV_ADDR_ABSPROG3	= 7'h43;
localparam RV_ADDR_ABSPROG4	= 7'h44;
localparam RV_ADDR_ABSPROG5	= 7'h45;
localparam RV_ADDR_ABSPROG6	= 7'h46;
localparam RV_ADDR_ABSPROG7	= 7'h47;
localparam RV_ADDR_ABSPROG8	= 7'h48;
localparam RV_ADDR_ABSPROG9	= 7'h49;
localparam RV_ADDR_ABSPROG10	= 7'h4a;
localparam RV_ADDR_ABSPROG11	= 7'h4b;
localparam RV_ADDR_ABSPROG12	= 7'h4c;
localparam RV_ADDR_ABSPROG13	= 7'h4d;
localparam RV_ADDR_ABSPROG14	= 7'h4e;
localparam RV_ADDR_ABSPROG15	= 7'h4f;
localparam RV_ADDR_ABSPROG16	= 7'h50;
localparam RV_ADDR_ABSPROG17	= 7'h51;

localparam RV_ADDR_COMMAND	= 7'h60;
localparam RV_ADDR_NOTIFY	= 7'h61;
localparam RV_ADDR_RESUME	= 7'h62;
localparam RV_ADDR_EXCEPTION	= 7'h63;
localparam RV_ADDR_SERIAL0	= 7'h64;

localparam INSN_EBREAK	= 32'h00100073;

localparam ABS_STATE_IDLE    = 3'b000;
localparam ABS_STATE_CHECK   = 3'b001;
localparam ABS_STATE_CMD     = 3'b011;
localparam ABS_STATE_EXE     = 3'b010;
localparam ABS_STATE_RESUME  = 3'b110;

localparam HART_STATE_RUNNING    = 1'b0;
localparam HART_STATE_HALTED     = 1'b1;

localparam SYS_BUS_ASIZE_8BIT    = 3'd0;
localparam SYS_BUS_ASIZE_16BIT   = 3'd1;
localparam SYS_BUS_ASIZE_32BIT   = 3'd2;
localparam SYS_BUS_ASIZE_64BIT   = 3'd3;
localparam SYS_BUS_ASIZE_128BIT  = 3'd4;

localparam SYS_BUS_SBERROR_NONE             = 3'd0;
localparam SYS_BUS_SBERROR_TIMEOUT          = 3'd1;
localparam SYS_BUS_SBERROR_BADADDR          = 3'd2;
localparam SYS_BUS_SBERROR_ALIGN_ERROR      = 3'd3;
localparam SYS_BUS_SBERROR_SIZE_UNSUPPORTED = 3'd4;
localparam SYS_BUS_SBERROR_OTHER            = 3'd7;
localparam SYS_BUS_SBERROR_MASK             = 3'd7;

localparam NDS_HRESP_OKAY        = 2'b00;
localparam NDS_HRESP_ERROR       = 2'b01;
localparam NDS_HRESP_RETRY       = 2'b10;
localparam NDS_HRESP_SPLIT       = 2'b11;
localparam NDS_ARESP_OK		 = 2'b00;
localparam NDS_ARESP_SLVERR      = 2'b10;
localparam NDS_ARESP_DECERR      = 2'b11;
localparam NDS_ABURST_FIXED      = 2'b00;
localparam NDS_ALOCK_NORMAL      = 1'b0;
localparam NDS_ALOCK_EXCLUSIVE   = 1'b1;
localparam NDS_HBURST_SINGLE     = 3'b000;

wire	[1023:0] param_one = 1024'd1;

wire	   [NHART-1:0] hart_unavail_sync;
wire	   [NHART-1:0] hart_under_reset_sync;

reg              [0:0] hart_cs [0:NHART-1];
reg              [0:0] hart_ns [0:NHART-1];

wire     [(NHART-1):0] hart_halted_event;
wire     [(NHART-1):0] hart_resume_event;

wire        dmi_req_valid;

wire [31:0] dmi_dmstatus;
wire [31:0] dmi_dmcontrol;
wire [31:0] dmi_dmcs2;
wire [31:0] dmi_hartinfo;
reg  [31:0] dmi_haltsum0;
wire [31:0] dmi_haltsum1;
wire [31:0] dmi_hawindowsel;
wire [31:0] dmi_hawindow;
wire [31:0] dmi_abstractcs;
reg  [31:0] dmi_command;
wire [31:0] dmi_abstractauto;
wire [11:0] dmi_autoexecdata;
wire [15:0] dmi_autoexecprogbuf;

reg  [2:0] abs_cmderr;
wire [2:0] abs_cmderr_nx;
wire       abs_cmderr_wen;

wire [31:0] dmi_devtreeaddr0;
wire [31:0] dmi_devtreeaddr1;
wire [31:0] dmi_devtreeaddr2;
wire [31:0] dmi_devtreeaddr3;

reg  [31:0] dmi_data0;
reg  [31:0] dmi_data1;
reg  [31:0] dmi_data2;
reg  [31:0] dmi_data3;


wire [31:0] dmi_progbuf0;
wire [31:0] dmi_progbuf1;
wire [31:0] dmi_progbuf2;
wire [31:0] dmi_progbuf3;
wire [31:0] dmi_progbuf4;
wire [31:0] dmi_progbuf5;
wire [31:0] dmi_progbuf6;
wire [31:0] dmi_progbuf7;
wire [31:0] dmi_progbuf8;
wire [31:0] dmi_progbuf9;
wire [31:0] dmi_progbuf10;
wire [31:0] dmi_progbuf11;
wire [31:0] dmi_progbuf12;
wire [31:0] dmi_progbuf13;
wire [31:0] dmi_progbuf14;
wire [31:0] dmi_progbuf15;

wire [31:0] dmi_sercs;
wire [31:0] dmi_sertx;
wire [31:0] dmi_serrx;
wire        dmi_sercs_full0;
wire        dmi_sercs_valid0;
wire        dmi_sercs_error0;

wire        serial0_tx_may_overflow;
wire        serial0_tx_will_overflow;
wire        serial0_rx_will_underflow;


wire  [31:0] dmi_sbcs;
wire  [31:0] dmi_sbaddress0;
wire  [31:0] dmi_sbaddress1;
wire  [31:0] dmi_sbaddress2;
wire  [31:0] dmi_sbaddress3;
wire  [31:0] dmi_sbdata0;
wire  [31:0] dmi_sbdata1;
wire  [31:0] dmi_sbdata2;
wire  [31:0] dmi_sbdata3;

wire        dmi_dmcontrol_wen;
reg         dmi_dmcontrol_wen_d1;
wire        dmi_hawindow_wen;

wire        ackhavereset_nx;
reg	    ackhavereset;

wire [31:0] dmi_command_nx;

wire [31:0] dmi_data0_nx;
wire [31:0] dmi_data1_nx;
wire [31:0] dmi_data2_nx;
wire [31:0] dmi_data3_nx;

reg	      sys_rst;
reg     [2:0] abs_cs;
reg	[2:0] abs_ns;
wire          abs_busy = (abs_cs != ABS_STATE_IDLE);
reg     [9:0] abs_hartsel;
wire [(NHART-1):0] abs_hartsel_onehot = param_one[(NHART-1):0] << abs_hartsel;


wire [31:0] dmi_progbuf0_nx;
wire [31:0] dmi_progbuf1_nx;
wire [31:0] dmi_progbuf2_nx;
wire [31:0] dmi_progbuf3_nx;
wire [31:0] dmi_progbuf4_nx;
wire [31:0] dmi_progbuf5_nx;
wire [31:0] dmi_progbuf6_nx;
wire [31:0] dmi_progbuf7_nx;
wire [31:0] dmi_progbuf8_nx;
wire [31:0] dmi_progbuf9_nx;
wire [31:0] dmi_progbuf10_nx;
wire [31:0] dmi_progbuf11_nx;
wire [31:0] dmi_progbuf12_nx;
wire [31:0] dmi_progbuf13_nx;
wire [31:0] dmi_progbuf14_nx;
wire [31:0] dmi_progbuf15_nx;

wire [31:0] dmi_authdata_nx;

wire [31:0] dmi_serrx_nx;

reg           dmi_haltreq;
reg           dmi_resumereq;
reg     [9:0] dmi_hartsel;
wire	      dmi_hasel;

wire [1023:0] dmi_hartsel_onehot;

wire [1023:0] dmi_hart_halted;
wire [1023:0] dmi_hart_running;
wire [1023:0] dmi_hart_unavail;
wire [1023:0] dmi_hart_havereset;
wire [1023:0] dmi_hart_resumeack;
wire [1023:0] dmi_hart_nonexistent;
reg           dmi_ndmreset;
reg           dmi_dmactive;

reg [31:0] dmi_hrdata;
reg [31:0] dmi_hrdata_nx;
wire dmi_read_ready;
wire dmi_hrdata_wen;

wire	[63:0]			rv_wr_data;
wire	[8:2]			rv_wr_addr;
wire	[8:2]			rv_rd_addr;
reg	[63:0]			rv_rd_data;
wire	[DATA_WIDTH-1:0]	rv_hrdata;

wire 		rv_hreadyout;

wire abs_cs_check  = (abs_cs == ABS_STATE_CHECK);
wire abs_cs_cmd    = (abs_cs == ABS_STATE_CMD);
wire abs_cs_exe    = (abs_cs == ABS_STATE_EXE);
wire abs_cs_resume = (abs_cs == ABS_STATE_RESUME);

reg	in_abs_xcpt;
wire	set_in_abs_xcpt;
wire	clr_in_abs_xcpt;
wire	in_abs_xcpt_nx;

wire	rv_write_cmd_valid;
wire	rv_write_req_valid;
wire	rv_read_req_valid;
wire	rv_write_high_part;
wire	rv_write_low_part;

wire  [9:0] rv_command_hartsel;
wire        rv_command_resume;
wire        rv_command_valid;
wire [31:0] rv_command = {21'd0, rv_command_resume, rv_command_hartsel} | {in_abs_xcpt, {31{~rv_command_valid}}};
wire [31:0] rv_notify = 32'd0;
wire [31:0] rv_resume = 32'd0;
wire [31:0] rv_exception = 32'd0;
wire [31:0] rv_serrx;

wire        rv_data0_wen;
wire        rv_data1_wen;
wire        rv_data2_wen;
wire        rv_data3_wen;
wire        rv_cmd_wen;
wire        rv_notify_wen;
wire        rv_resume_wen;
wire        rv_exception_wen;
wire        rv_serial0_tx_wen;
wire        rv_serial0_rx_ren;
wire        rv_serial0_tx_wen_nx;

wire [7:0]  abs_cmd_type    = dmi_command[31:24];
wire [2:0]  abs_size        = dmi_command[22:20];
wire        abs_postexec    = dmi_command[18];
wire        abs_transfer    = dmi_command[17];
wire        abs_write       = dmi_command[16];
wire [15:0] abs_regno       = dmi_command[15:0];
wire        abs_aamvirtual  = dmi_command[23];
wire [2:0]  abs_aamsize     = dmi_command[22:20];
wire        abs_aampostincr = dmi_command[19];

wire        abs_cmd_reg_access      = (abs_cmd_type    == ABS_CMD_TYPE_REG_ACCESS);
wire        abs_cmd_quick_access    = (abs_cmd_type    == ABS_CMD_TYPE_QUICK_ACCESS);
wire        abs_cmd_mem_access      = (abs_cmd_type    == ABS_CMD_TYPE_MEM_ACCESS);
wire        abs_supported_command   = (abs_cmd_reg_access & ~abs_transfer) |
                                      (abs_cmd_reg_access &  abs_transfer & (abs_size == ABS_SIZE_32 || abs_size == ABS_SIZE_64)) |
                                      (abs_cmd_mem_access & !abs_aamvirtual & (abs_aamsize < ABS_CMD_SIZE_128))   |
                                       abs_cmd_quick_access ;
wire        abs_expected_state;
wire        abs_cmd_unexpected_resume;
wire        abs_valid_command = abs_supported_command & abs_expected_state & ~abs_cmd_unexpected_resume;
wire        abs_hartsel_halted;
wire        abs_hartsel_running;
wire        abs_hartsel_unavail;
wire        abs_hartsel_resuming;

wire [31:0] abs_prog0;
wire [31:0] abs_prog1;
wire [31:0] abs_prog2;
wire [31:0] abs_prog3;
wire [31:0] abs_prog4;
wire [31:0] abs_prog5;
wire [31:0] abs_prog6;
wire [31:0] abs_prog7;
wire [31:0] abs_prog8;
wire [31:0] abs_prog9;
wire [31:0] abs_prog10;
wire [31:0] abs_prog11;
wire [31:0] abs_prog12;
wire [31:0] abs_prog13;
wire [31:0] abs_prog14;
wire [31:0] abs_prog15;
wire [31:0] abs_prog16;
wire [31:0] abs_prog17;
reg  [31:0] _abs_reg_access_prog0;
reg  [31:0] _abs_reg_access_prog1;
reg  [31:0] _abs_reg_access_prog2;
reg  [31:0] _abs_reg_access_prog3;
reg  [31:0] _abs_reg_access_prog4;
wire [31:0] abs_mem_access_prog0;
wire [31:0] abs_mem_access_prog1;
wire [31:0] abs_mem_access_prog2;
wire [31:0] abs_mem_access_prog3;
wire [31:0] abs_mem_access_prog4;
wire [31:0] abs_mem_access_prog5;
wire [31:0] abs_mem_access_prog6;
wire [31:0] abs_mem_access_prog7;
wire [31:0] abs_mem_access_prog8;
wire [31:0] abs_mem_access_prog9;
wire [31:0] abs_mem_access_prog10;
wire [31:0] abs_mem_access_prog11;
wire [31:0] abs_mem_access_prog12;
wire [31:0] abs_mem_access_prog13;
wire [31:0] abs_mem_access_prog14;
wire [31:0] abs_mem_access_prog15;
wire [31:0] abs_mem_access_prog16;
wire [31:0] abs_mem_access_prog17;

wire [31:0] abs_write_gpr_0 = (abs_size == ABS_SIZE_32) ? ABS_WRITE_GPR_0_32 : ABS_WRITE_GPR_0_64;
wire [31:0] abs_read_gpr_0  = (abs_size == ABS_SIZE_32) ? ABS_READ_GPR_0_32  : ABS_READ_GPR_0_64;
wire [31:0] abs_write_fpr_0 = (abs_size == ABS_SIZE_32) ? ABS_WRITE_FPR_0_32 : ABS_WRITE_FPR_0_64;
wire [31:0] abs_read_fpr_0  = (abs_size == ABS_SIZE_32) ? ABS_READ_FPR_0_32  : ABS_READ_FPR_0_64;

always @* begin
	case({abs_write,abs_regno[12],abs_regno[5]})
	3'b000,
        3'b001:  _abs_reg_access_prog0 = ABS_READ_CSR_0;
	3'b010:  _abs_reg_access_prog0 = abs_read_gpr_0 | {7'd0, abs_regno[4:0], 20'd0};
        3'b011:  _abs_reg_access_prog0 = abs_read_fpr_0 | {7'd0, abs_regno[4:0], 20'd0};
	3'b100,
        3'b101:  _abs_reg_access_prog0 = ABS_WRITE_CSR_0;
	3'b110:  _abs_reg_access_prog0 = abs_write_gpr_0 | {20'd0, abs_regno[4:0], 7'd0};
        3'b111:  _abs_reg_access_prog0 = abs_write_fpr_0 | {20'd0, abs_regno[4:0], 7'd0};
	default: _abs_reg_access_prog0 = 32'h0;
	endcase
end

wire [31:0] abs_write_csr_1 = (abs_size == ABS_SIZE_32) ? ABS_WRITE_CSR_1_32 : ABS_WRITE_CSR_1_64;

always @* begin
	case({abs_write,abs_regno[12],abs_regno[5]})
	3'b000,
	3'b001:  _abs_reg_access_prog1 = ABS_READ_CSR_1 | {abs_regno[11:0],20'd0};
	3'b010:  _abs_reg_access_prog1 = abs_postexec ? ABS_J_PROGBUF0_1 : ABS_READ_GPR_1;
	3'b011:  _abs_reg_access_prog1 = abs_postexec ? ABS_J_PROGBUF0_1 : ABS_READ_FPR_1;
	3'b100,
	3'b101:  _abs_reg_access_prog1 = abs_write_csr_1;
	3'b110:  _abs_reg_access_prog1 = abs_postexec ? ABS_J_PROGBUF0_1 : ABS_WRITE_GPR_1;
	3'b111:  _abs_reg_access_prog1 = abs_postexec ? ABS_J_PROGBUF0_1 : ABS_WRITE_FPR_1;
	default: _abs_reg_access_prog1 = 32'h0;
	endcase
end

wire [31:0] abs_read_csr_2  = (abs_size == ABS_SIZE_32) ? ABS_READ_CSR_2_32  : ABS_READ_CSR_2_64;

always @* begin
	case({abs_write,abs_regno[12],abs_regno[5]})
	3'b000,
	3'b001:  _abs_reg_access_prog2 = abs_read_csr_2;
	3'b010:  _abs_reg_access_prog2 = ABS_READ_GPR_2;
	3'b011:  _abs_reg_access_prog2 = ABS_READ_FPR_2;
	3'b100,
	3'b101:  _abs_reg_access_prog2 = ABS_WRITE_CSR_2 | {abs_regno[11:0],20'd0};
	3'b110:  _abs_reg_access_prog2 = ABS_WRITE_GPR_2;
	3'b111:  _abs_reg_access_prog2 = ABS_WRITE_FPR_2;
	default: _abs_reg_access_prog2 = 32'h0;
	endcase
end

always @* begin
	case({abs_write,abs_regno[12],abs_regno[5]})
	3'b000,
	3'b001:  _abs_reg_access_prog3 = ABS_READ_CSR_3;
	3'b010:  _abs_reg_access_prog3 = ABS_READ_GPR_3;
	3'b011:  _abs_reg_access_prog3 = ABS_READ_FPR_3;
	3'b100,
	3'b101:  _abs_reg_access_prog3 = ABS_WRITE_CSR_3;
	3'b110:  _abs_reg_access_prog3 = ABS_WRITE_GPR_3;
	3'b111:  _abs_reg_access_prog3 = ABS_WRITE_FPR_3;
	default: _abs_reg_access_prog3 = 32'h0;
	endcase
end

always @* begin
	case({abs_write,abs_regno[12],abs_regno[5]})
	3'b000,
	3'b001:  _abs_reg_access_prog4 = abs_postexec ? ABS_J_PROGBUF0_4 : ABS_READ_CSR_4;
	3'b010:  _abs_reg_access_prog4 = ABS_READ_GPR_4;
	3'b011:  _abs_reg_access_prog4 = ABS_READ_FPR_4;
	3'b100,
	3'b101:  _abs_reg_access_prog4 = abs_postexec ? ABS_J_PROGBUF0_4 : ABS_WRITE_CSR_4;
	3'b110:  _abs_reg_access_prog4 = ABS_WRITE_GPR_4;
	3'b111:  _abs_reg_access_prog4 = ABS_WRITE_FPR_4;
	default: _abs_reg_access_prog4 = 32'h0;
	endcase
end

assign abs_mem_access_prog0  = ABS_MEM_ACCESS_0;
assign abs_mem_access_prog1  = ABS_MEM_ACCESS_1;
assign abs_mem_access_prog2  = ABS_MEM_ACCESS_2;
assign abs_mem_access_prog3  = ABS_MEM_ACCESS_3;
assign abs_mem_access_prog4  = ABS_MEM_ACCESS_4;
assign abs_mem_access_prog5  = ABS_MEM_ACCESS_5;
assign abs_mem_access_prog6  = ABS_MEM_ACCESS_6;
assign abs_mem_access_prog7  = (abs_write)? ABS_MEM_ACCESS_7_ST | {17'd0, abs_aamsize, 12'd0} :
                                           ABS_MEM_ACCESS_7_LD | {17'd0, abs_aamsize, 12'd0} ;
assign abs_mem_access_prog8  = (abs_write)? ABS_MEM_ACCESS_8_ST | {17'd0, abs_aamsize, 12'd0} :
                                           ABS_MEM_ACCESS_8_LD | {17'd0, abs_aamsize, 12'd0} ;
assign abs_mem_access_prog9  = (abs_aampostincr)? (ABS_MEM_ACCESS_POSTINCR_9 | (32'h00100000 << abs_aamsize)) : ABS_MEM_ACCESS_9;
assign abs_mem_access_prog10 = ABS_MEM_ACCESS_POSTINCR_10;
assign abs_mem_access_prog11 = ABS_MEM_ACCESS_POSTINCR_11;
assign abs_mem_access_prog12 = ABS_MEM_ACCESS_POSTINCR_12;
assign abs_mem_access_prog13 = ABS_MEM_ACCESS_POSTINCR_13;
assign abs_mem_access_prog14 = ABS_MEM_ACCESS_POSTINCR_14;
assign abs_mem_access_prog15 = ABS_MEM_ACCESS_POSTINCR_15;
assign abs_mem_access_prog16 = ABS_MEM_ACCESS_POSTINCR_16;
assign abs_mem_access_prog17 = ABS_MEM_ACCESS_POSTINCR_17;

assign abs_prog0 = abs_cmd_mem_access ? abs_mem_access_prog0 :
                   abs_cmd_reg_access ? (abs_transfer ? _abs_reg_access_prog0 :
					(abs_postexec ? ABS_J_PROGBUF0_0 : INSN_EBREAK)) :
		                        ABS_J_PROGBUF0_0;
assign abs_prog1  = abs_cmd_mem_access ? abs_mem_access_prog1 : _abs_reg_access_prog1;
assign abs_prog2  = abs_cmd_mem_access ? abs_mem_access_prog2 : _abs_reg_access_prog2;
assign abs_prog3  = abs_cmd_mem_access ? abs_mem_access_prog3 : _abs_reg_access_prog3;
assign abs_prog4  = abs_cmd_mem_access ? abs_mem_access_prog4 : _abs_reg_access_prog4;
assign abs_prog5  = abs_cmd_mem_access ? abs_mem_access_prog5 : INSN_EBREAK;
assign abs_prog6  = abs_mem_access_prog6;
assign abs_prog7  = abs_mem_access_prog7;
assign abs_prog8  = abs_mem_access_prog8;
assign abs_prog9  = abs_mem_access_prog9;
assign abs_prog10 = abs_mem_access_prog10;
assign abs_prog11 = abs_mem_access_prog11;
assign abs_prog12 = abs_mem_access_prog12;
assign abs_prog13 = abs_mem_access_prog13;
assign abs_prog14 = abs_mem_access_prog14;
assign abs_prog15 = abs_mem_access_prog15;
assign abs_prog16 = abs_mem_access_prog16;
assign abs_prog17 = abs_mem_access_prog17;

generate
genvar i_hart;
for (i_hart = 0; i_hart < NHART; i_hart = i_hart + 1) begin : gen_hart_state_machine
        always @(posedge clk or negedge dmi_resetn) begin
                if (!dmi_resetn) begin
                        hart_cs[i_hart] <= HART_STATE_RUNNING;
                end
                else begin
                        hart_cs[i_hart] <= hart_ns[i_hart];
                end
        end

        always @* begin
                case(hart_cs[i_hart])
                        HART_STATE_RUNNING:
                                hart_ns[i_hart] = (hart_halted_event[i_hart]) ? HART_STATE_HALTED  : HART_STATE_RUNNING;
                        HART_STATE_HALTED:
                                hart_ns[i_hart] = (hart_resume_event[i_hart] || hart_under_reset_sync[i_hart]) ? HART_STATE_RUNNING : HART_STATE_HALTED;
			default:
				hart_ns[i_hart] = 1'b0;
                endcase
        end
end
endgenerate


localparam HTRANS_IDLE = 2'b00;
localparam HTRANS_BUSY = 2'b01;
localparam HRESP_OKAY = 2'b00;
assign dmi_req_valid = dmi_hsel & dmi_htrans[1] & dmi_hready;
reg dmi_req_valid_dp;
reg dmi_hwrite_dp;
reg [8:2] dmi_haddr_dp;

always @(posedge clk or negedge dmi_resetn) begin
	if (!dmi_resetn) begin
		dmi_req_valid_dp <= 1'b0;
	end
	else if (dmi_hready) begin
		dmi_req_valid_dp <= dmi_req_valid;
	end
end

reg dmi_hreadyout;
wire dmi_hreadyout_nx;

wire dmi_htrans_idle_or_busy = (dmi_htrans[1]==1'b0);
wire dmi_ahb_write_read_turnaround = dmi_hwrite_dp & dmi_req_valid_dp & !dmi_hwrite;
assign dmi_hreadyout_nx = dmi_htrans_idle_or_busy | !(dmi_ahb_write_read_turnaround);
always @(posedge clk or negedge dmi_resetn) begin
	if (!dmi_resetn) begin
		dmi_hreadyout <= 1'b1;
	end
	else begin
		dmi_hreadyout <= dmi_hreadyout_nx;
	end
end

assign dmi_hresp = HRESP_OKAY;

assign dmi_devtreeaddr0 = 32'd0;
assign dmi_devtreeaddr1 = 32'd0;
assign dmi_devtreeaddr2 = 32'd0;
assign dmi_devtreeaddr3 = 32'd0;

always @(posedge clk or negedge dmi_resetn) begin
	if (!dmi_resetn) begin
		dmi_hwrite_dp <= 1'b0;
		dmi_haddr_dp <= 7'd0;
	end
	else if (dmi_hready) begin
		dmi_hwrite_dp <= dmi_hwrite;
		dmi_haddr_dp <= dmi_haddr[8:2];
	end
end

assign dmi_dmcontrol_wen    = dmi_req_valid_dp & dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_DMCONTROL);
assign dmi_hawindow_wen     = dmi_req_valid_dp & dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_HAWINDOW);

wire   dmi_abstractcs_wen   = dmi_req_valid_dp & dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_ABSTRACTCS);
wire   valid_dmi_abstractcs_wen   = ~abs_busy & dmi_abstractcs_wen;
wire   dmi_command_wen      = dmi_req_valid_dp & dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_COMMAND);
wire   dmi_data_access      = dmi_req_valid_dp & ((dmi_haddr_dp == DMI_ADDR_DATA0) |
                                                  (dmi_haddr_dp == DMI_ADDR_DATA1) |
						  (dmi_haddr_dp == DMI_ADDR_DATA2) |
						  (dmi_haddr_dp == DMI_ADDR_DATA3) |
						  (dmi_haddr_dp == DMI_ADDR_DATA4) |
						  (dmi_haddr_dp == DMI_ADDR_DATA5) |
						  (dmi_haddr_dp == DMI_ADDR_DATA6) |
						  (dmi_haddr_dp == DMI_ADDR_DATA7) |
						  (dmi_haddr_dp == DMI_ADDR_DATA8) |
						  (dmi_haddr_dp == DMI_ADDR_DATA9) |
						  (dmi_haddr_dp == DMI_ADDR_DATA10)|
						  (dmi_haddr_dp == DMI_ADDR_DATA11));

wire   valid_dmi_command_wen;
wire   dmi_abstractauto_wen = dmi_req_valid_dp & dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_ABSTRACTAUTO);
wire   valid_dmi_abstractauto_wen = ~abs_busy & dmi_abstractauto_wen;

wire   dmi_data0_wen        = ~abs_busy & dmi_req_valid_dp & dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_DATA0) | rv_data0_wen;
wire   dmi_data1_wen        = ~abs_busy & dmi_req_valid_dp & dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_DATA1) | rv_data1_wen;
wire   dmi_data2_wen        = ~abs_busy & dmi_req_valid_dp & dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_DATA2) | rv_data2_wen;
wire   dmi_data3_wen        = ~abs_busy & dmi_req_valid_dp & dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_DATA3) | rv_data3_wen;

wire   dmi_auto_exec = dmi_req_valid_dp &
	(
		(                         (dmi_haddr_dp == DMI_ADDR_DATA0    ) & dmi_autoexecdata[0]    ) |
		(                         (dmi_haddr_dp == DMI_ADDR_DATA1    ) & dmi_autoexecdata[1]    ) |
		(                         (dmi_haddr_dp == DMI_ADDR_DATA2    ) & dmi_autoexecdata[2]    ) |
		(                         (dmi_haddr_dp == DMI_ADDR_DATA3    ) & dmi_autoexecdata[3]    ) |
		((PROGBUF_SIZE > 0 ) & (dmi_haddr_dp == DMI_ADDR_PROGBUF0 ) & dmi_autoexecprogbuf[0] ) |
		((PROGBUF_SIZE > 1 ) & (dmi_haddr_dp == DMI_ADDR_PROGBUF1 ) & dmi_autoexecprogbuf[1] ) |
		((PROGBUF_SIZE > 2 ) & (dmi_haddr_dp == DMI_ADDR_PROGBUF2 ) & dmi_autoexecprogbuf[2] ) |
		((PROGBUF_SIZE > 3 ) & (dmi_haddr_dp == DMI_ADDR_PROGBUF3 ) & dmi_autoexecprogbuf[3] ) |
		((PROGBUF_SIZE > 4 ) & (dmi_haddr_dp == DMI_ADDR_PROGBUF4 ) & dmi_autoexecprogbuf[4] ) |
		((PROGBUF_SIZE > 5 ) & (dmi_haddr_dp == DMI_ADDR_PROGBUF5 ) & dmi_autoexecprogbuf[5] ) |
		((PROGBUF_SIZE > 6 ) & (dmi_haddr_dp == DMI_ADDR_PROGBUF6 ) & dmi_autoexecprogbuf[6] ) |
		((PROGBUF_SIZE > 7 ) & (dmi_haddr_dp == DMI_ADDR_PROGBUF7 ) & dmi_autoexecprogbuf[7] ) |
		((PROGBUF_SIZE > 8 ) & (dmi_haddr_dp == DMI_ADDR_PROGBUF8 ) & dmi_autoexecprogbuf[8] ) |
		((PROGBUF_SIZE > 9 ) & (dmi_haddr_dp == DMI_ADDR_PROGBUF9 ) & dmi_autoexecprogbuf[9] ) |
		((PROGBUF_SIZE > 10) & (dmi_haddr_dp == DMI_ADDR_PROGBUF10) & dmi_autoexecprogbuf[10]) |
		((PROGBUF_SIZE > 11) & (dmi_haddr_dp == DMI_ADDR_PROGBUF11) & dmi_autoexecprogbuf[11]) |
		((PROGBUF_SIZE > 12) & (dmi_haddr_dp == DMI_ADDR_PROGBUF12) & dmi_autoexecprogbuf[12]) |
		((PROGBUF_SIZE > 13) & (dmi_haddr_dp == DMI_ADDR_PROGBUF13) & dmi_autoexecprogbuf[13]) |
		((PROGBUF_SIZE > 14) & (dmi_haddr_dp == DMI_ADDR_PROGBUF14) & dmi_autoexecprogbuf[14]) |
		((PROGBUF_SIZE > 15) & (dmi_haddr_dp == DMI_ADDR_PROGBUF15) & dmi_autoexecprogbuf[15])
	)
	& !abs_busy & (abs_cmderr == 3'd0);


wire   dmi_progbuf0_wen     = ~abs_busy & dmi_req_valid_dp & dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_PROGBUF0);
wire   dmi_progbuf1_wen     = ~abs_busy & dmi_req_valid_dp & dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_PROGBUF1);
wire   dmi_progbuf2_wen     = ~abs_busy & dmi_req_valid_dp & dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_PROGBUF2);
wire   dmi_progbuf3_wen     = ~abs_busy & dmi_req_valid_dp & dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_PROGBUF3);
wire   dmi_progbuf4_wen     = ~abs_busy & dmi_req_valid_dp & dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_PROGBUF4);
wire   dmi_progbuf5_wen     = ~abs_busy & dmi_req_valid_dp & dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_PROGBUF5);
wire   dmi_progbuf6_wen     = ~abs_busy & dmi_req_valid_dp & dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_PROGBUF6);
wire   dmi_progbuf7_wen     = ~abs_busy & dmi_req_valid_dp & dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_PROGBUF7);
wire   dmi_progbuf8_wen     = ~abs_busy & dmi_req_valid_dp & dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_PROGBUF8);
wire   dmi_progbuf9_wen     = ~abs_busy & dmi_req_valid_dp & dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_PROGBUF9);
wire   dmi_progbuf10_wen     = ~abs_busy & dmi_req_valid_dp & dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_PROGBUF10);
wire   dmi_progbuf11_wen     = ~abs_busy & dmi_req_valid_dp & dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_PROGBUF11);
wire   dmi_progbuf12_wen     = ~abs_busy & dmi_req_valid_dp & dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_PROGBUF12);
wire   dmi_progbuf13_wen     = ~abs_busy & dmi_req_valid_dp & dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_PROGBUF13);
wire   dmi_progbuf14_wen     = ~abs_busy & dmi_req_valid_dp & dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_PROGBUF14);
wire   dmi_progbuf15_wen     = ~abs_busy & dmi_req_valid_dp & dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_PROGBUF15);

wire   dmi_progbuf_access    = dmi_req_valid_dp & ( (dmi_haddr_dp == DMI_ADDR_PROGBUF0)
                                                  | (dmi_haddr_dp == DMI_ADDR_PROGBUF1)
                                                  | (dmi_haddr_dp == DMI_ADDR_PROGBUF2)
                                                  | (dmi_haddr_dp == DMI_ADDR_PROGBUF3)
                                                  | (dmi_haddr_dp == DMI_ADDR_PROGBUF4)
                                                  | (dmi_haddr_dp == DMI_ADDR_PROGBUF5)
                                                  | (dmi_haddr_dp == DMI_ADDR_PROGBUF6)
                                                  | (dmi_haddr_dp == DMI_ADDR_PROGBUF7)
                                                  | (dmi_haddr_dp == DMI_ADDR_PROGBUF8)
                                                  | (dmi_haddr_dp == DMI_ADDR_PROGBUF9)
                                                  | (dmi_haddr_dp == DMI_ADDR_PROGBUF10)
                                                  | (dmi_haddr_dp == DMI_ADDR_PROGBUF11)
                                                  | (dmi_haddr_dp == DMI_ADDR_PROGBUF12)
                                                  | (dmi_haddr_dp == DMI_ADDR_PROGBUF13)
                                                  | (dmi_haddr_dp == DMI_ADDR_PROGBUF14)
                                                  | (dmi_haddr_dp == DMI_ADDR_PROGBUF15)
                                                  );

wire   rv_progbuf0_wen;
wire   rv_progbuf1_wen;
wire   rv_progbuf2_wen;
wire   rv_progbuf3_wen;
wire   rv_progbuf4_wen;
wire   rv_progbuf5_wen;
wire   rv_progbuf6_wen;
wire   rv_progbuf7_wen;
wire   rv_progbuf8_wen;
wire   rv_progbuf9_wen;
wire   rv_progbuf10_wen;
wire   rv_progbuf11_wen;
wire   rv_progbuf12_wen;
wire   rv_progbuf13_wen;
wire   rv_progbuf14_wen;
wire   rv_progbuf15_wen;

wire   progbuf0_wen = dmi_progbuf0_wen | rv_progbuf0_wen;
wire   progbuf1_wen = dmi_progbuf1_wen | rv_progbuf1_wen;
wire   progbuf2_wen = dmi_progbuf2_wen | rv_progbuf2_wen;
wire   progbuf3_wen = dmi_progbuf3_wen | rv_progbuf3_wen;
wire   progbuf4_wen = dmi_progbuf4_wen | rv_progbuf4_wen;
wire   progbuf5_wen = dmi_progbuf5_wen | rv_progbuf5_wen;
wire   progbuf6_wen = dmi_progbuf6_wen | rv_progbuf6_wen;
wire   progbuf7_wen = dmi_progbuf7_wen | rv_progbuf7_wen;
wire   progbuf8_wen = dmi_progbuf8_wen | rv_progbuf8_wen;
wire   progbuf9_wen = dmi_progbuf9_wen | rv_progbuf9_wen;
wire   progbuf10_wen = dmi_progbuf10_wen | rv_progbuf10_wen;
wire   progbuf11_wen = dmi_progbuf11_wen | rv_progbuf11_wen;
wire   progbuf12_wen = dmi_progbuf12_wen | rv_progbuf12_wen;
wire   progbuf13_wen = dmi_progbuf13_wen | rv_progbuf13_wen;
wire   progbuf14_wen = dmi_progbuf14_wen | rv_progbuf14_wen;
wire   progbuf15_wen = dmi_progbuf15_wen | rv_progbuf15_wen;

wire   dmi_authdata_wen     = dmi_req_valid_dp & dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_AUTHDATA);

wire   dmi_dmcs2_wen        = dmi_req_valid_dp & dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_DMCS2);

wire   dmi_sercs_wen        = dmi_req_valid_dp & dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_SERCS);
wire   dmi_serrx_wen        = dmi_req_valid_dp & dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_SERRX);

wire   dmi_sbcs_wen;
wire   dmi_sbaddress0_wen;
wire   dmi_sbaddress1_wen;
wire   dmi_sbaddress2_wen;
wire   dmi_sbaddress3_wen;
wire   dmi_sbdata0_wen;
wire   dmi_sbdata1_wen;
wire   dmi_sbdata2_wen;
wire   dmi_sbdata3_wen;
wire   dmi_sbdata0_ren;


assign ackhavereset_nx      = dmi_dmcontrol_wen & dmi_hwdata[28];

assign dmi_command_nx      = dmi_hwdata;

assign dmi_data0_nx        = rv_data0_wen ? rv_wr_data[31:0] : dmi_hwdata;
assign dmi_data1_nx        = rv_data1_wen ? (rv_write_high_part ? rv_wr_data[DATA_WIDTH-1:DATA_WIDTH-32] : rv_wr_data[31:0]) : dmi_hwdata;
assign dmi_data2_nx        = rv_data2_wen ? rv_wr_data[31:0] : dmi_hwdata;
assign dmi_data3_nx        = rv_data3_wen ? (rv_write_high_part ? rv_wr_data[DATA_WIDTH-1:DATA_WIDTH-32] : rv_wr_data[31:0]) : dmi_hwdata;


assign dmi_progbuf0_nx     = rv_progbuf0_wen ? rv_wr_data[31:0] : dmi_hwdata;
assign dmi_progbuf1_nx     = rv_progbuf1_wen ? (rv_write_high_part ? rv_wr_data[DATA_WIDTH-1:DATA_WIDTH-32] : rv_wr_data[31:0]) : dmi_hwdata;
assign dmi_progbuf2_nx     = rv_progbuf2_wen ? rv_wr_data[31:0] : dmi_hwdata;
assign dmi_progbuf3_nx     = rv_progbuf3_wen ? (rv_write_high_part ? rv_wr_data[DATA_WIDTH-1:DATA_WIDTH-32] : rv_wr_data[31:0]) : dmi_hwdata;
assign dmi_progbuf4_nx     = rv_progbuf4_wen ? rv_wr_data[31:0] : dmi_hwdata;
assign dmi_progbuf5_nx     = rv_progbuf5_wen ? (rv_write_high_part ? rv_wr_data[DATA_WIDTH-1:DATA_WIDTH-32] : rv_wr_data[31:0]) : dmi_hwdata;
assign dmi_progbuf6_nx     = rv_progbuf6_wen ? rv_wr_data[31:0] : dmi_hwdata;
assign dmi_progbuf7_nx     = rv_progbuf7_wen ? (rv_write_high_part ? rv_wr_data[DATA_WIDTH-1:DATA_WIDTH-32] : rv_wr_data[31:0]) : dmi_hwdata;

assign dmi_progbuf8_nx     = rv_progbuf8_wen ? rv_wr_data[31:0] : dmi_hwdata;
assign dmi_progbuf9_nx     = rv_progbuf9_wen ? (rv_write_high_part ? rv_wr_data[DATA_WIDTH-1:DATA_WIDTH-32] : rv_wr_data[31:0]) : dmi_hwdata;
assign dmi_progbuf10_nx     = rv_progbuf10_wen ? rv_wr_data[31:0] : dmi_hwdata;
assign dmi_progbuf11_nx     = rv_progbuf11_wen ? (rv_write_high_part ? rv_wr_data[DATA_WIDTH-1:DATA_WIDTH-32] : rv_wr_data[31:0]) : dmi_hwdata;
assign dmi_progbuf12_nx     = rv_progbuf12_wen ? rv_wr_data[31:0] : dmi_hwdata;
assign dmi_progbuf13_nx     = rv_progbuf13_wen ? (rv_write_high_part ? rv_wr_data[DATA_WIDTH-1:DATA_WIDTH-32] : rv_wr_data[31:0]) : dmi_hwdata;
assign dmi_progbuf14_nx     = rv_progbuf14_wen ? rv_wr_data[31:0] : dmi_hwdata;
assign dmi_progbuf15_nx     = rv_progbuf15_wen ? (rv_write_high_part ? rv_wr_data[DATA_WIDTH-1:DATA_WIDTH-32] : rv_wr_data[31:0]) : dmi_hwdata;


assign dmi_authdata_nx     = dmi_hwdata;

assign dmi_serrx_nx        = dmi_hwdata;

localparam DMI_VERSION_V0P13 = 4'd2;

wire       dmi_allhavereset;
wire       dmi_anyhavereset;
wire       dmi_allresumeack;
wire       dmi_anyresumeack;
wire       dmi_allnonexistent;
wire       dmi_anynonexistent;
wire       dmi_allunavail;
wire       dmi_anyunavail;
wire       dmi_allrunning;
wire       dmi_anyrunning;
wire       dmi_allhalted;
wire       dmi_anyhalted;
wire       dmi_authenticated = 1'b1;
wire       dmi_authbusy = 1'b0;
wire       dmi_hasresethaltreq = 1'b1;
wire       dmi_devtreevalid = 1'b0;
wire [3:0] dmi_version = DMI_VERSION_V0P13;

reg	   [NHART-1:0] hart_havereset;
wire	   [NHART-1:0] hart_havereset_nx;
wire	   [NHART-1:0] hart_havereset_clr;
wire	   [NHART-1:0] hart_havereset_set;

reg        [NHART-1:0] debugint;
wire       [NHART-1:0] debugint_nx;
reg	   [NHART-1:0] hart_haltreq;
wire	   [NHART-1:0] hart_haltreq_nx;
wire	   [NHART-1:0] hart_haltreq_en;

reg	   [NHART-1:0] hart_resumereq;
wire	   [NHART-1:0] hart_resumereq_set;
wire	   [NHART-1:0] hart_resumereq_clr;
wire	   [NHART-1:0] hart_resumereq_nx;

reg	   [NHART-1:0] hart_resumeack;
wire	   [NHART-1:0] hart_resumeack_nx;
wire	   [NHART-1:0] hart_resumeack_set;
wire	   [NHART-1:0] hart_resumeack_clr;

wire       [NHART-1:0] quick_access_haltreq;
wire       [NHART-1:0] group_halt_haltreq;

wire		       abs_resumeack;
wire		       abs_notify;
wire		 [9:0] notify_hartid;
wire		 [9:0] resume_hartid;

wire                   resumereq_hartsel_en;
reg              [9:0] resumereq_hartsel;
wire             [9:0] resumereq_hartsel_add_one = resumereq_hartsel + 10'd1;
wire             [9:0] resumereq_hartsel_nx;
wire                   resumereq_valid;


wire       [NHART-1:0] nds_unused_under_rst_b_rise;
wire       [NHART-1:0] nds_unused_under_rst_b_fall;
wire       [NHART-1:0] nds_unused_under_rst_b_edge;

wire       [NHART-1:0] nds_unused_unavail_b_rise;
wire       [NHART-1:0] nds_unused_unavail_b_fall;
wire       [NHART-1:0] nds_unused_unavail_b_edge;

wire    nds_unused_wire;
assign nds_unused_wire = (|nds_unused_under_rst_b_rise) | (|nds_unused_under_rst_b_fall) | (|nds_unused_under_rst_b_edge)
                       | (|nds_unused_unavail_b_rise  ) | (|nds_unused_unavail_b_fall  ) | (|nds_unused_unavail_b_edge  );

genvar i_sync;
generate
for (i_sync=0; i_sync<NHART; i_sync=i_sync+1) begin: gen_sync_hart_under_reset
        nds_sync_l2l #(
        	.RESET_VALUE     (1'b0            ),
        	.SYNC_STAGE      (SYNC_STAGE      )
        ) hart_under_reset_sync_l2l (
        	.b_reset_n                  (dmi_resetn                          ),
        	.b_clk                      (clk                                 ),
        	.a_signal                   (hart_under_reset[i_sync]            ),
        	.b_signal                   (hart_under_reset_sync[i_sync]       ),
        	.b_signal_rising_edge_pulse (nds_unused_under_rst_b_rise[i_sync] ),
        	.b_signal_falling_edge_pulse(nds_unused_under_rst_b_fall[i_sync] ),
        	.b_signal_edge_pulse        (nds_unused_under_rst_b_edge[i_sync] )
        );

        nds_sync_l2l #(
        	.RESET_VALUE     (1'b0            ),
        	.SYNC_STAGE      (SYNC_STAGE      )
        ) hart_unavail_sync_l2l (
        	.b_reset_n                  (dmi_resetn                        ),
        	.b_clk                      (clk                               ),
        	.a_signal                   (hart_unavail[i_sync]              ),
        	.b_signal                   (hart_unavail_sync[i_sync]         ),
        	.b_signal_rising_edge_pulse (nds_unused_unavail_b_rise[i_sync] ),
        	.b_signal_falling_edge_pulse(nds_unused_unavail_b_fall[i_sync] ),
        	.b_signal_edge_pulse        (nds_unused_unavail_b_edge[i_sync] )
        );

end
endgenerate

always @(posedge clk or negedge dmi_resetn) begin
	if (!dmi_resetn) begin
		hart_havereset <= {NHART{1'b0}};
	end
	else begin
		hart_havereset <= hart_havereset_nx;
	end
end




generate
genvar gv_hart;
for (gv_hart = 0; gv_hart < NHART; gv_hart = gv_hart + 1) begin : gen_hart_resume_halt_state
        assign hart_halted_event[gv_hart] = rv_notify_wen & (notify_hartid == gv_hart[9:0]) & dmi_hart_running[gv_hart];
        assign hart_resume_event[gv_hart] = rv_resume_wen & (resume_hartid == gv_hart[9:0]) & dmi_hart_halted[gv_hart];
        assign dmi_hart_halted[gv_hart]   = (hart_cs[gv_hart] == HART_STATE_HALTED);
        assign dmi_hart_running[gv_hart]  = (hart_cs[gv_hart] == HART_STATE_RUNNING) & ~hart_unavail_sync[gv_hart];
end
endgenerate


assign dmi_hart_unavail[NHART-1:0] = hart_unavail_sync[NHART-1:0];
assign dmi_hart_havereset[NHART-1:0] = hart_havereset[NHART-1:0];
assign dmi_hart_resumeack[NHART-1:0] = hart_resumeack[NHART-1:0];
assign dmi_hart_nonexistent[NHART-1:0] = {NHART{1'b0}};

generate
if (NHART < 1024) begin : gen_dmi_hart_hardwired
	assign dmi_hart_halted[1023:NHART]      = {(1024-NHART){1'b0}};
        assign dmi_hart_running[1023:NHART]     = {(1024-NHART){1'b0}};
	assign dmi_hart_unavail[1023:NHART]     = {(1024-NHART){1'b0}};
	assign dmi_hart_havereset[1023:NHART]   = {(1024-NHART){1'b0}};
	assign dmi_hart_resumeack[1023:NHART]   = {(1024-NHART){1'b0}};
	assign dmi_hart_nonexistent[1023:NHART] = {(1024-NHART){1'b1}};
end
endgenerate

assign hart_havereset_nx  = hart_havereset_set | (~hart_havereset_clr & hart_havereset);
assign hart_havereset_set = hart_under_reset_sync;
assign hart_havereset_clr = {NHART{ackhavereset}} &  dmi_hartsel_onehot[NHART-1:0];

assign dmi_anyhavereset   = |(dmi_hart_havereset   & dmi_hartsel_onehot);
assign dmi_anyresumeack   = |(dmi_hart_resumeack   & dmi_hartsel_onehot);
assign dmi_anynonexistent = |(dmi_hart_nonexistent & dmi_hartsel_onehot);
assign dmi_anyunavail     = |(dmi_hart_unavail     & dmi_hartsel_onehot);
assign dmi_anyrunning     = |(dmi_hart_running     & dmi_hartsel_onehot);
assign dmi_anyhalted      = |(dmi_hart_halted      & dmi_hartsel_onehot);

assign dmi_allhavereset      = &(dmi_hart_havereset   | ~dmi_hartsel_onehot);
assign dmi_allresumeack      = &(dmi_hart_resumeack   | ~dmi_hartsel_onehot);
assign dmi_allnonexistent    = &(dmi_hart_nonexistent | ~dmi_hartsel_onehot);
assign dmi_allunavail        = &(dmi_hart_unavail     | ~dmi_hartsel_onehot);
assign dmi_allrunning        = &(dmi_hart_running     | ~dmi_hartsel_onehot);
assign dmi_allhalted         = &(dmi_hart_halted      | ~dmi_hartsel_onehot);

assign dmi_dmstatus[31:27] = 5'd0;
assign dmi_dmstatus[26:24] = 3'd0;
assign dmi_dmstatus[23]    = 1'd0;
assign dmi_dmstatus[22]    = 1'b1;
assign dmi_dmstatus[21:20] = 2'd0;
assign dmi_dmstatus[19]    = dmi_allhavereset;
assign dmi_dmstatus[18]    = dmi_anyhavereset;
assign dmi_dmstatus[17]    = dmi_allresumeack;
assign dmi_dmstatus[16]    = dmi_anyresumeack;
assign dmi_dmstatus[15]    = dmi_allnonexistent;
assign dmi_dmstatus[14]    = dmi_anynonexistent;
assign dmi_dmstatus[13]    = dmi_allunavail;
assign dmi_dmstatus[12]    = dmi_anyunavail;
assign dmi_dmstatus[11]    = dmi_allrunning;
assign dmi_dmstatus[10]    = dmi_anyrunning;
assign dmi_dmstatus[9]     = dmi_allhalted;
assign dmi_dmstatus[8]     = dmi_anyhalted;
assign dmi_dmstatus[7]     = dmi_authenticated;
assign dmi_dmstatus[6]     = dmi_authbusy;
assign dmi_dmstatus[5]     = dmi_hasresethaltreq;
assign dmi_dmstatus[4]     = dmi_devtreevalid;
assign dmi_dmstatus[3:0]   = dmi_version;


assign dmi_dmcontrol[31]    = 1'b0;
assign dmi_dmcontrol[30]    = 1'b0;
assign dmi_dmcontrol[29]    = 1'b0;
assign dmi_dmcontrol[28]    = 1'b0;
assign dmi_dmcontrol[27]    = 1'b0;
assign dmi_dmcontrol[26]    = dmi_hasel;
assign dmi_dmcontrol[25:16] = dmi_hartsel;
assign dmi_dmcontrol[15:2]  = 14'd0;
assign dmi_dmcontrol[1]     = dmi_ndmreset;
assign dmi_dmcontrol[0]     = dmi_dmactive;

assign dmactive = dmi_dmactive;
assign ndmreset = dmi_ndmreset;

reg			dmi_setresethaltreq;
wire			dmi_setresethaltreq_nx;
reg			dmi_clrresethaltreq;
wire			dmi_clrresethaltreq_nx;
reg        [NHART-1:0]	resethaltreq;
wire       [NHART-1:0]	resethaltreq_nx;

assign resethaltreq_nx =   ({NHART{dmi_setresethaltreq}} & dmi_hartsel_onehot[NHART-1:0])
		       | (~({NHART{dmi_clrresethaltreq}} & dmi_hartsel_onehot[NHART-1:0]) & resethaltreq);

assign dmi_setresethaltreq_nx = dmi_hwdata[3] & dmi_dmcontrol_wen;
assign dmi_clrresethaltreq_nx = dmi_hwdata[2] & dmi_dmcontrol_wen;

always @(posedge clk or negedge dmi_resetn) begin
	if (!dmi_resetn) begin
		resethaltreq	    <= {NHART{1'b0}};
		dmi_setresethaltreq <= 1'b0;
		dmi_clrresethaltreq <= 1'b0;
	end
	else begin
		resethaltreq	    <= resethaltreq_nx;
		dmi_setresethaltreq <= dmi_setresethaltreq_nx;
		dmi_clrresethaltreq <= dmi_clrresethaltreq_nx;
	end
end

wire		dmi_haltreq_nx   = dmi_hwdata[31]    & dmi_hwdata[0];
wire		dmi_resumereq_nx = dmi_hwdata[30]    & dmi_hwdata[0];
wire	[9:0]	dmi_hartsel_nx   = dmi_hwdata[25:16] & {10{dmi_hwdata[0]}};
wire		dmi_ndmreset_nx  = dmi_hwdata[1]     & dmi_hwdata[0];
wire		dmi_dmactive_nx  = dmi_hwdata[0];

always @(posedge clk or negedge dmi_resetn) begin
	if (!dmi_resetn) begin
		dmi_haltreq   <=  1'b0;
		dmi_resumereq <=  1'b0;
		dmi_hartsel   <= 10'd0;
		dmi_ndmreset  <=  1'b0;
		dmi_dmactive  <=  1'b0;
	end
	else if (dmi_dmcontrol_wen) begin
		dmi_haltreq   <= dmi_haltreq_nx;
		dmi_resumereq <= dmi_resumereq_nx;
		dmi_hartsel   <= dmi_hartsel_nx;
		dmi_ndmreset  <= dmi_ndmreset_nx;
		dmi_dmactive  <= dmi_dmactive_nx;
	end
end

always @(posedge clk or negedge dmi_resetn) begin
	if (!dmi_resetn) begin
		ackhavereset <= 1'b0;
	end
	else begin
		ackhavereset <= ackhavereset_nx;
	end
end

always @(posedge clk or negedge dmi_resetn) begin
	if (!dmi_resetn) begin
		dmi_dmcontrol_wen_d1 <= 1'b0;
	end
	else begin
		dmi_dmcontrol_wen_d1 <= dmi_dmcontrol_wen;
	end
end

always @(posedge clk or negedge dmi_resetn) begin
	if (!dmi_resetn) begin
		hart_resumereq <= {NHART{1'b0}};
	end
	else begin
		hart_resumereq <= hart_resumereq_nx;
	end
end

always @(posedge clk or negedge dmi_resetn) begin
	if (!dmi_resetn) begin
		hart_resumeack <= {NHART{1'b1}};
	end
	else begin
		hart_resumeack <= hart_resumeack_nx;
	end
end

always @(posedge clk or negedge dmi_resetn) begin
	if (!dmi_resetn) begin
		debugint <= {NHART{1'b0}};
	end
	else begin
		debugint <= debugint_nx;
	end
end

generate
if (HASEL_SUPPORT == "yes") begin: gen_dmcontrol_hasel
	reg	reg_hasel;
	wire	reg_hasel_nx;

	assign reg_hasel_nx	= dmi_hwdata[26] & dmi_hwdata[0];

	always @(posedge clk or negedge dmi_resetn) begin
		if (!dmi_resetn) begin
			reg_hasel <= 1'b0;
		end
                else if (dmi_dmcontrol_wen) begin
                        reg_hasel <= reg_hasel_nx;
                end
	end

        assign  dmi_hasel = reg_hasel;
end
else begin : gen_dmcontrol_no_hasel
        assign  dmi_hasel = 1'b0;
end
endgenerate

wire    [NHART-1:0] hart_quick_access;

wire	[NHART-1:0] set_haltreq;
wire	[NHART-1:0] clr_haltreq;

generate
genvar i_hreq;
for (i_hreq = 0; i_hreq < NHART; i_hreq=i_hreq+1) begin: gen_hart_haltreq_nx
        wire debug_event;
        wire dmi_set_haltreq;
        wire dmi_set_resumereq;
        wire dmi_clr_haltreq;
        wire hart_resume_by_quick;
        wire hart_resume_by_dmi;
        wire cmd_done_notify;
        wire start_abs_cmd;

        assign hart_quick_access[i_hreq] = (i_hreq[9:0] == dmi_hartsel) & abs_cmd_quick_access & abs_busy;

        assign dmi_set_haltreq      = (dmi_hartsel_onehot[i_hreq])   & (dmi_dmcontrol_wen_d1 &  dmi_haltreq);
        assign dmi_set_resumereq    = (dmi_hartsel_onehot[i_hreq])   & (dmi_dmcontrol_wen_d1 &  dmi_resumereq);
        assign dmi_clr_haltreq      = (dmi_hartsel_onehot[i_hreq])   & (dmi_dmcontrol_wen_d1 & ~dmi_haltreq);

        assign cmd_done_notify      = (i_hreq[9:0] == notify_hartid) & ~abs_busy & rv_notify_wen & ~dmi_resumereq;
        assign start_abs_cmd        = (i_hreq[9:0] == dmi_hartsel)   & (abs_cs_check & abs_valid_command | dmi_auto_exec);

        assign hart_resume_by_quick = (i_hreq[9:0] == resume_hartid) & abs_cmd_quick_access & rv_resume_wen;
        assign hart_resume_by_dmi   = (i_hreq[9:0] == resume_hartid) & dmi_hartsel_onehot[i_hreq] & dmi_resumereq & rv_resume_wen;

        assign debug_event     = (dmi_set_haltreq   & ~dmi_hart_halted[i_hreq])
                               | (dmi_set_resumereq &  dmi_hart_halted[i_hreq])
                               | start_abs_cmd;

	always @(posedge clk or negedge dmi_resetn) begin
		if (!dmi_resetn) begin
			hart_haltreq[i_hreq] <= 1'b0;
		end
		else if (hart_haltreq_en[i_hreq]) begin
			hart_haltreq[i_hreq] <= hart_haltreq_nx[i_hreq];
		end
	end

        assign set_haltreq[i_hreq] = debug_event;
	assign clr_haltreq[i_hreq] =  cmd_done_notify
				   |  hart_resume_by_quick
				   |  hart_resume_by_dmi
				   |  dmi_clr_haltreq
				   | ~dmi_dmactive;

        assign hart_haltreq_nx[i_hreq] =  set_haltreq[i_hreq] | (~clr_haltreq[i_hreq] & hart_haltreq[i_hreq]);
        assign hart_haltreq_en[i_hreq] =  set_haltreq[i_hreq] | clr_haltreq[i_hreq];

end
endgenerate

wire  [NHART-1:0] rv_resume_onehot       = param_one[(NHART-1):0] << rv_wr_data[9:0];
wire  [NHART-1:0] hart_resumeack_notify = {NHART{rv_resume_wen}} & rv_resume_onehot[NHART-1:0];

assign hart_resumereq_set =  dmi_hartsel_onehot[NHART-1:0] & {NHART{dmi_dmcontrol_wen_d1 & dmi_resumereq & dmi_dmactive}} & dmi_hart_halted[NHART-1:0];
assign hart_resumereq_clr =  hart_resume_event | {NHART{~dmi_dmactive}};
assign hart_resumereq_nx  = ~hart_resumereq_clr & (hart_resumereq_set | hart_resumereq);

assign hart_resumeack_set = hart_resumereq & hart_resume_event;
assign hart_resumeack_clr = (dmi_hartsel_onehot[NHART-1:0] & {NHART{dmi_resumereq & dmi_dmcontrol_wen_d1}})
                          | {NHART{~dmi_dmactive}};
assign hart_resumeack_nx  = ~hart_resumeack_clr & (hart_resumeack |  hart_resumeack_set);

assign debugint_nx = hart_haltreq | quick_access_haltreq | group_halt_haltreq;

always @(posedge clk or negedge dmi_resetn) begin
	if (!dmi_resetn) begin
		resumereq_hartsel <= 10'd0;
	end
	else if (resumereq_hartsel_en) begin
		resumereq_hartsel <= resumereq_hartsel_nx;
	end
end

wire [(NHART-1):0] hart_resumereq_active;
assign hart_resumereq_active[(NHART-1):0] =  hart_resumereq[(NHART-1):0] & ~hart_resumeack[(NHART-1):0];

assign resumereq_valid = hart_resumereq_active[resumereq_hartsel[(HARTID_WIDTH-1):0]];

assign resumereq_hartsel_en = ~dmi_dmactive | (~resumereq_valid & |hart_resumereq_active[(NHART-1):0]);
assign resumereq_hartsel_nx = (dmi_dmactive && (resumereq_hartsel_add_one != NHART[9:0])) ?  resumereq_hartsel_add_one : 10'd0;

generate
genvar i, j;
if (HALTGROUP_COUNT > 0) begin : gen_halt_group
        reg  [4:0]         dmi_hart_halt_group [0:(NHART-1)];
        wire [(NHART-1):0] dmi_hart_halt_group_en;
        wire [4:0]         dmi_hart_halt_group_nx;

        wire               dmi_dmcs2_hgwrite   = dmi_hwdata[1];
        wire [4:0]         dmi_dmcs2_haltgroup = dmi_hwdata[6:2];

        assign dmi_hart_halt_group_nx = (dmactive & (dmi_dmcs2_haltgroup <= HALTGROUP_COUNT[4:0])) ? dmi_dmcs2_haltgroup : 5'h0;

        for (i = 0; i < NHART; i = i + 1) begin : gen_hart_halt_group
                assign dmi_hart_halt_group_en[i] = (dmi_dmcs2_wen & dmi_dmcs2_hgwrite & dmi_hartsel_onehot[i]) | ~dmactive;
                always @(posedge clk or negedge dmi_resetn) begin
                        if (!dmi_resetn)
                                dmi_hart_halt_group[i] <= 5'h0;
                        else if (dmi_hart_halt_group_en[i])
                                dmi_hart_halt_group[i] <= dmi_hart_halt_group_nx;
                end

                `ifdef DUMP_ENABLE
                        wire [4:0] dmi_hart_halt_group_probe = dmi_hart_halt_group[i];
                `endif
        end


        assign dmi_dmcs2[31:11] = 21'h0;
        assign dmi_dmcs2[10: 7] = 4'h0;
        assign dmi_dmcs2[ 6: 2] = dmi_hart_halt_group[dmi_hartsel];
        assign dmi_dmcs2[    1] = 1'b0;
        assign dmi_dmcs2[    0] = 1'b0;

        wire [(NHART-1):0] halt_group_onehot [1:HALTGROUP_COUNT];

        for (i = 1; i <= HALTGROUP_COUNT; i = i + 1) begin : gen_halt_group_onehot_per_group
                for (j = 0; j < NHART; j = j + 1) begin : gen_halt_group_onehot_per_hart
                        assign halt_group_onehot[i][j] = (dmi_hart_halt_group[j] == i[4:0]);
                end

                `ifdef DUMP_ENABLE
                        wire [(NHART-1):0] halt_group_onehot_probe = halt_group_onehot[i];
                `endif
        end


        wire [HALTGROUP_COUNT:1] group_halt_trig;
        reg  [(NHART-1):0]       group_halt_harts;

        for (i = 1; i <= HALTGROUP_COUNT; i = i + 1) begin : gen_group_halt_trig
                assign group_halt_trig[i] =  | (hart_halted_event & ~hart_quick_access & halt_group_onehot[i]);
        end

        integer k;
        always @* begin
                group_halt_harts = {NHART{1'b0}};
                for (k = 1; k <= HALTGROUP_COUNT; k = k + 1) begin
                        group_halt_harts = group_halt_harts | ({NHART{group_halt_trig[k]}} & halt_group_onehot[k]);
                end
        end

        wire [(NHART-1):0] reg_group_halt_haltreq_set;
        wire [(NHART-1):0] reg_group_halt_haltreq_clr;
        wire [(NHART-1):0] reg_group_halt_haltreq_nx;
        reg  [(NHART-1):0] reg_group_halt_haltreq;

        assign reg_group_halt_haltreq_set = group_halt_harts & (~dmi_hart_halted[(NHART-1):0] | hart_resumereq_active[(NHART-1):0] | hart_quick_access[(NHART-1):0]);
        assign reg_group_halt_haltreq_clr = hart_halted_event;
        assign reg_group_halt_haltreq_nx = ~reg_group_halt_haltreq_clr & (reg_group_halt_haltreq_set | reg_group_halt_haltreq);

        always @(posedge clk or negedge dmi_resetn) begin
                if (!dmi_resetn) begin
                        reg_group_halt_haltreq <= {NHART{1'b0}};
		end
                else begin
                        reg_group_halt_haltreq <= reg_group_halt_haltreq_nx;
		end
        end

        assign group_halt_haltreq = reg_group_halt_haltreq;


end
else begin : gen_no_halt_group
        assign dmi_dmcs2 = 32'd0;
        assign group_halt_haltreq = {NHART{1'b0}};
end
endgenerate


assign dmi_hartinfo[31:24] = 8'd0;
assign dmi_hartinfo[23:20] = 4'd2;
assign dmi_hartinfo[19:17] = 3'd0;
assign dmi_hartinfo[16]    = 1'b1;
assign dmi_hartinfo[15:12] = 4'd4;
assign dmi_hartinfo[11:0]  = {3'b000, RV_ADDR_DATA0,2'b00};

integer i_seg_base;
always @* begin
        dmi_haltsum0 = 32'd0;
        for (i_seg_base = 0; i_seg_base < NHART; i_seg_base = i_seg_base + 32) begin
                dmi_haltsum0 = dmi_haltsum0 | (dmi_hart_halted[i_seg_base +: 32] & {32{(dmi_hartsel[9:5] == i_seg_base[9:5])}});
        end
end

generate
genvar i_sum1_bit;
for (i_sum1_bit = 0; i_sum1_bit < 32; i_sum1_bit = i_sum1_bit + 1) begin : gen_haltsum1
        assign dmi_haltsum1[i_sum1_bit] = |dmi_hart_halted[(i_sum1_bit * 32) +: 32];
end
endgenerate

generate
if (HASEL_SUPPORT == "yes" && HAWINDOWSEL_WIDTH > 0) begin : gen_hawindowsel
	reg	[HAWINDOWSEL_WIDTH-1:0] reg_hawindowsel;
	wire	[HAWINDOWSEL_WIDTH-1:0] reg_hawindowsel_nx;
	wire	reg_hawindowsel_wen;

	assign reg_hawindowsel_wen = dmi_req_valid_dp & dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_HAWINDOWSEL);
        assign reg_hawindowsel_nx  = dmi_hwdata[HAWINDOWSEL_WIDTH-1:0];

	always @(posedge clk or negedge dmi_resetn) begin
		if (!dmi_resetn) begin
                        reg_hawindowsel <= {HAWINDOWSEL_WIDTH{1'b0}};
		end
		else if (!dmi_dmactive) begin
			reg_hawindowsel <= {HAWINDOWSEL_WIDTH{1'b0}};
		end
		else if (reg_hawindowsel_wen) begin
			reg_hawindowsel <= reg_hawindowsel_nx;
		end
	end

        assign dmi_hawindowsel = {{(32-HAWINDOWSEL_WIDTH){1'b0}}, reg_hawindowsel};
end
else begin : gen_no_hawindowsel
        assign dmi_hawindowsel = 32'd0;
end
endgenerate

generate
if (HASEL_SUPPORT == "yes") begin: gen_multiple_hartsel_onehot
        reg  [NHART-1:0]        reg_multiple_hartsel;
        wire [HAWINDOW_NUM:0]   reg_multiple_hartsel_srl_we_ext;
        wire [HAWINDOW_NUM-1:0] reg_multiple_hartsel_srl_we;
        wire [31:0]             reg_multiple_hartsel_srl_nx;
	wire [1023:0]           single_hartsel;
        wire [1024:0]           multiple_hartsel;
        wire [1024:0]           multiple_hartsel_srl;

        assign reg_multiple_hartsel_srl_we_ext = {{(HAWINDOW_NUM){1'b0}}, dmi_hawindow_wen} << dmi_hawindowsel;
        assign reg_multiple_hartsel_srl_we = reg_multiple_hartsel_srl_we_ext[HAWINDOW_NUM-1:0];
        assign reg_multiple_hartsel_srl_nx = dmi_hwdata;

        integer i_hart;
        always @(posedge clk or negedge dmi_resetn) begin
                if (!dmi_resetn) begin
                        reg_multiple_hartsel <= {NHART{1'b0}};
                end
                else if (!dmactive) begin
                        reg_multiple_hartsel <= {NHART{1'b0}};
                end
		else begin
			for (i_hart = 0; i_hart < NHART; i_hart = i_hart + 1) begin
				if (reg_multiple_hartsel_srl_we[i_hart/32]) begin
					reg_multiple_hartsel[i_hart] <= reg_multiple_hartsel_srl_nx[i_hart % 32];
				end
			end
                end
        end

	assign single_hartsel   = 1024'd1 << dmi_hartsel;
        assign multiple_hartsel = {{(1025-NHART){1'b0}}, reg_multiple_hartsel};
        assign multiple_hartsel_srl = multiple_hartsel >> {dmi_hawindowsel[9:5], 5'd0};

        assign dmi_hawindow     = multiple_hartsel_srl[31:0];
        assign dmi_hartsel_onehot = single_hartsel | (dmi_hasel ? multiple_hartsel[1023:0] : 1024'd0);
end
else begin: gen_single_hartsel_onehot
        assign dmi_hawindow       = 32'd0;
	assign dmi_hartsel_onehot = 1024'd1 << dmi_hartsel;
end
endgenerate


wire	[31:0]	progbuf_size_value   = PROGBUF_SIZE;
wire	[31:0]	abs_data_count_value = ABS_DATA_COUNT;

assign dmi_abstractcs[31:29] = 3'd0;
assign dmi_abstractcs[28:24] = progbuf_size_value[4:0];
assign dmi_abstractcs[23:13] = 11'd0;
assign dmi_abstractcs[12]    = abs_busy;
assign dmi_abstractcs[11]    = 1'b0;
assign dmi_abstractcs[10:8]  = abs_cmderr;
assign dmi_abstractcs[7:5]  = 3'd0;
assign dmi_abstractcs[4:0]  = abs_data_count_value[4:0];

always @(posedge clk or negedge dmi_resetn) begin
	if (!dmi_resetn) begin
		abs_cmderr <= 3'd0;
	end
	else if (!dmi_dmactive) begin
		abs_cmderr <= 3'd0;
	end
	else if (abs_cmderr_wen) begin
		abs_cmderr <= abs_cmderr_nx;
	end
end

always @(posedge clk or negedge bus_resetn) begin
	if (!bus_resetn) begin
		sys_rst <= 1'b1;
	end
	else begin
		sys_rst <= 1'b0;
	end
end

always @(posedge clk or negedge dmi_resetn) begin
	if (!dmi_resetn) begin
		abs_cs <= ABS_STATE_IDLE;
	end
	else begin
		abs_cs <= abs_ns;
	end
end

assign resume_hartid = rv_wr_data[9:0];
assign notify_hartid = rv_write_high_part ? rv_wr_data[DATA_WIDTH-23:DATA_WIDTH-32] : rv_wr_data[9:0];

assign abs_resumeack = |(hart_resume_event & abs_hartsel_onehot[NHART-1:0]);
assign abs_notify    = rv_notify_wen & (notify_hartid == abs_hartsel[9:0]);


always @* begin
	case (abs_cs)
	ABS_STATE_IDLE:   abs_ns = (valid_dmi_command_wen || dmi_auto_exec) ? ABS_STATE_CHECK : ABS_STATE_IDLE;
	ABS_STATE_CHECK:  abs_ns = abs_valid_command ? ABS_STATE_CMD : ABS_STATE_IDLE;
	ABS_STATE_CMD:    abs_ns = (sys_rst||abs_hartsel_unavail||abs_cmd_unexpected_resume) ? ABS_STATE_IDLE : (rv_cmd_wen ? ABS_STATE_EXE : ABS_STATE_CMD);
	ABS_STATE_EXE:    abs_ns = (sys_rst||abs_hartsel_unavail) ? ABS_STATE_IDLE : (abs_notify ? (abs_cmd_quick_access ? ABS_STATE_RESUME : ABS_STATE_IDLE) : ABS_STATE_EXE);
	ABS_STATE_RESUME: abs_ns = sys_rst ? ABS_STATE_IDLE : (abs_resumeack ? ABS_STATE_IDLE : ABS_STATE_RESUME);
	default:           abs_ns = 3'd0;
	endcase
end

assign set_in_abs_xcpt = abs_cs_exe & rv_exception_wen;
assign clr_in_abs_xcpt = abs_notify | dmi_ndmreset;
assign in_abs_xcpt_nx  = set_in_abs_xcpt | (~clr_in_abs_xcpt & in_abs_xcpt);

always @(posedge clk or negedge dmi_resetn) begin
	if (!dmi_resetn) begin
		in_abs_xcpt <= 1'b0;
	end
	else if (!dmi_dmactive) begin
		in_abs_xcpt <= 1'b0;
	end
	else begin
		in_abs_xcpt <= in_abs_xcpt_nx;
	end
end

assign valid_dmi_command_wen = dmi_command_wen & !abs_busy & (abs_cmderr == 3'd0);
always @(posedge clk or negedge dmi_resetn) begin
	if (!dmi_resetn) begin
		dmi_command <= 32'd0;
		abs_hartsel <= 10'd0;
	end
	else if (!dmi_dmactive) begin
		dmi_command <= 32'd0;
		abs_hartsel <= 10'd0;
	end
	else if (valid_dmi_command_wen) begin
		dmi_command <= dmi_command_nx;
		abs_hartsel <= dmi_hartsel;
	end
end

localparam CMDERR_NONE        = 3'd0;
localparam CMDERR_BUSY        = 3'd1;
localparam CMDERR_UNSUPPORTED = 3'd2;
localparam CMDERR_EXCEPTION   = 3'd3;
localparam CMDERR_HALTRESUME  = 3'd4;
localparam CMDERR_OTHER       = 3'd7;

wire abs_cmderr_busy        = (dmi_command_wen | dmi_auto_exec | dmi_data_access | dmi_progbuf_access | dmi_abstractcs_wen | dmi_abstractauto_wen) & abs_busy;

assign abs_expected_state = ( (abs_cmd_reg_access   & abs_hartsel_halted)
                            | (abs_cmd_quick_access & abs_hartsel_running)
                            | (abs_cmd_mem_access   & abs_hartsel_halted)
                            ) & ~sys_rst;

assign abs_cmd_unexpected_resume = ((abs_cs_check | abs_cs_cmd) & abs_cmd_reg_access & abs_hartsel_resuming)
                                 | ((abs_cs_check | abs_cs_cmd) & abs_cmd_mem_access & abs_hartsel_resuming);

wire  abs_cmd_hart_unavail = (abs_hartsel_unavail | sys_rst) & (abs_cs_cmd | abs_cs_exe);

wire abs_check_fail = abs_cs_check & ~abs_valid_command;
wire abs_cmderr_exception = rv_exception_wen;

wire [2:0] abs_cmderr_w1c = abs_cmderr[2:0] & ~dmi_hwdata[10:8];

assign abs_cmderr_wen = valid_dmi_abstractcs_wen | abs_cmderr_busy | abs_check_fail | abs_cmderr_exception | abs_cmd_hart_unavail;
assign abs_cmderr_nx = valid_dmi_abstractcs_wen     ? abs_cmderr_w1c     :
		       (abs_cmderr != 3'd0)     ? abs_cmderr         :
		       abs_cmderr_busy          ? CMDERR_BUSY        :
		       abs_cmderr_exception     ? CMDERR_EXCEPTION   :
		       !abs_supported_command   ? CMDERR_UNSUPPORTED :
		       !abs_expected_state      ? CMDERR_HALTRESUME  :
		       abs_cmd_hart_unavail     ? CMDERR_HALTRESUME  :
                       abs_cmd_unexpected_resume? CMDERR_HALTRESUME  :
						  CMDERR_OTHER;

assign quick_access_haltreq = abs_hartsel_onehot[NHART-1:0] & {NHART{(abs_cs == ABS_STATE_CMD) & abs_cmd_quick_access}};

assign abs_hartsel_halted  = |(dmi_hart_halted [NHART-1:0] & abs_hartsel_onehot[NHART-1:0]);
assign abs_hartsel_running = |(dmi_hart_running[NHART-1:0] & abs_hartsel_onehot[NHART-1:0]);
assign abs_hartsel_unavail = |(dmi_hart_unavail[NHART-1:0] & abs_hartsel_onehot[NHART-1:0]);
assign abs_hartsel_resuming= |(hart_resumereq_active[NHART-1:0] & abs_hartsel_onehot[NHART-1:0]);

assign rv_command_valid   = abs_cs_cmd | abs_cs_resume | resumereq_valid;
assign rv_command_hartsel = (abs_cs_cmd || abs_cs_resume) ?  abs_hartsel : resumereq_hartsel;
assign rv_command_resume  = ~abs_cs_cmd;

assign dmi_abstractauto[11:0]  = dmi_autoexecdata;
assign dmi_abstractauto[15:12] = 4'd0;
assign dmi_abstractauto[31:16] = dmi_autoexecprogbuf;

generate
if (ABS_DATA_COUNT > 0) begin : gen_autoexecdata
        reg  [ABS_DATA_COUNT-1:0] reg_dmi_autoexecdata;
        always @(posedge clk or negedge dmi_resetn) begin
                if (!dmi_resetn) begin
                        reg_dmi_autoexecdata <= {ABS_DATA_COUNT{1'b0}};
                end
                else if (!dmi_dmactive) begin
                        reg_dmi_autoexecdata <= {ABS_DATA_COUNT{1'b0}};
                end
                else if (valid_dmi_abstractauto_wen) begin
                        reg_dmi_autoexecdata <= dmi_hwdata[ABS_DATA_COUNT-1:0];
                end
        end
        assign dmi_autoexecdata[ABS_DATA_COUNT-1:0]   = reg_dmi_autoexecdata;
end
if (ABS_DATA_COUNT < 12) begin : gen_autoexecdata_harwired
	assign dmi_autoexecdata[11:ABS_DATA_COUNT] = {(12-ABS_DATA_COUNT){1'b0}};
end
endgenerate

generate
if (PROGBUF_SIZE > 0) begin : gen_autoexecprogbuf
        reg  [PROGBUF_SIZE-1:0]  reg_dmi_autoexecprogbuf;
        always @(posedge clk or negedge dmi_resetn) begin
                if (!dmi_resetn) begin
                        reg_dmi_autoexecprogbuf <= {PROGBUF_SIZE{1'b0}};
                end
                else if (!dmi_dmactive) begin
                        reg_dmi_autoexecprogbuf <= {PROGBUF_SIZE{1'b0}};
                end
                else if (valid_dmi_abstractauto_wen) begin
                        reg_dmi_autoexecprogbuf <= dmi_hwdata[(PROGBUF_SIZE+16-1):16];
                end
        end
        assign dmi_autoexecprogbuf[PROGBUF_SIZE-1:0] = reg_dmi_autoexecprogbuf;
end
if (PROGBUF_SIZE < 16) begin : gen_autoexecprogbuf_harwired
	assign dmi_autoexecprogbuf[15:PROGBUF_SIZE] = {(16-PROGBUF_SIZE){1'b0}};
end
endgenerate


always @(posedge clk) begin
	if (!dmi_dmactive) begin
		dmi_data0 <= 32'd0;
	end
	else if (dmi_data0_wen) begin
		dmi_data0 <= dmi_data0_nx;
	end
end

always @(posedge clk) begin
	if (!dmi_dmactive) begin
		dmi_data1 <= 32'd0;
	end
	else if (dmi_data1_wen) begin
		dmi_data1 <= dmi_data1_nx;
	end
end

always @(posedge clk) begin
	if (!dmi_dmactive) begin
		dmi_data2 <= 32'd0;
	end
	else if (dmi_data2_wen) begin
		dmi_data2 <= dmi_data2_nx;
	end
end

always @(posedge clk) begin
	if (!dmi_dmactive) begin
		dmi_data3 <= 32'd0;
	end
	else if (dmi_data3_wen) begin
		dmi_data3 <= dmi_data3_nx;
	end
end


generate
if (PROGBUF_SIZE > 0) begin : gen_progbuf0
	reg  [31:0] reg_dmi_progbuf0;
	always @(posedge clk) begin
		if (!dmi_dmactive) begin
			reg_dmi_progbuf0 <= 32'd0;
		end
		else if (progbuf0_wen) begin
			reg_dmi_progbuf0 <= dmi_progbuf0_nx;
		end
	end
	assign dmi_progbuf0 = reg_dmi_progbuf0;
end
else begin : gen_progbuf0_hardwired
	assign dmi_progbuf0 = INSN_EBREAK;
end
endgenerate

generate
if (PROGBUF_SIZE > 1) begin : gen_progbuf1
	reg  [31:0] reg_dmi_progbuf1;
	always @(posedge clk) begin
		if (!dmi_dmactive) begin
			reg_dmi_progbuf1 <= 32'd0;
		end
		else if (progbuf1_wen) begin
			reg_dmi_progbuf1 <= dmi_progbuf1_nx;
		end
	end
	assign dmi_progbuf1 = reg_dmi_progbuf1;
end
else begin : gen_progbuf1_hardwired
	assign dmi_progbuf1 = INSN_EBREAK;
end
endgenerate

generate
if (PROGBUF_SIZE > 2) begin : gen_progbuf2
	reg  [31:0] reg_dmi_progbuf2;
	always @(posedge clk) begin
		if (!dmi_dmactive) begin
			reg_dmi_progbuf2 <= 32'd0;
		end
		else if (progbuf2_wen) begin
			reg_dmi_progbuf2 <= dmi_progbuf2_nx;
		end
	end
	assign dmi_progbuf2 = reg_dmi_progbuf2;
end
else begin : gen_progbuf2_hardwired
	assign dmi_progbuf2 = INSN_EBREAK;
end
endgenerate

generate
if (PROGBUF_SIZE > 3) begin : gen_progbuf3
	reg  [31:0] reg_dmi_progbuf3;
	always @(posedge clk) begin
		if (!dmi_dmactive) begin
			reg_dmi_progbuf3 <= 32'd0;
		end
		else if (progbuf3_wen) begin
			reg_dmi_progbuf3 <= dmi_progbuf3_nx;
		end
	end
	assign dmi_progbuf3 = reg_dmi_progbuf3;
end
else begin : gen_progbuf3_hardwired
	assign dmi_progbuf3 = INSN_EBREAK;
end
endgenerate

generate
if (PROGBUF_SIZE > 4) begin : gen_progbuf4
	reg  [31:0] reg_dmi_progbuf4;
	always @(posedge clk) begin
		if (!dmi_dmactive) begin
			reg_dmi_progbuf4 <= 32'd0;
		end
		else if (progbuf4_wen) begin
			reg_dmi_progbuf4 <= dmi_progbuf4_nx;
		end
	end
	assign dmi_progbuf4 = reg_dmi_progbuf4;
end
else begin : gen_progbuf4_hardwired
	assign dmi_progbuf4 = INSN_EBREAK;
end
endgenerate

generate
if (PROGBUF_SIZE > 5) begin : gen_progbuf5
	reg  [31:0] reg_dmi_progbuf5;
	always @(posedge clk) begin
		if (!dmi_dmactive) begin
			reg_dmi_progbuf5 <= 32'd0;
		end
		else if (progbuf5_wen) begin
			reg_dmi_progbuf5 <= dmi_progbuf5_nx;
		end
	end
	assign dmi_progbuf5 = reg_dmi_progbuf5;
end
else begin : gen_progbuf5_hardwired
	assign dmi_progbuf5 = INSN_EBREAK;
end
endgenerate

generate
if (PROGBUF_SIZE > 6) begin : gen_progbuf6
	reg  [31:0] reg_dmi_progbuf6;
	always @(posedge clk) begin
		if (!dmi_dmactive) begin
			reg_dmi_progbuf6 <= 32'd0;
		end
		else if (progbuf6_wen) begin
			reg_dmi_progbuf6 <= dmi_progbuf6_nx;
		end
	end
	assign dmi_progbuf6 = reg_dmi_progbuf6;
end
else begin : gen_progbuf6_hardwired
	assign dmi_progbuf6 = INSN_EBREAK;
end
endgenerate

generate
if (PROGBUF_SIZE > 7) begin : gen_progbuf7
	reg  [31:0] reg_dmi_progbuf7;
	always @(posedge clk) begin
		if (!dmi_dmactive) begin
			reg_dmi_progbuf7 <= 32'd0;
		end
		else if (progbuf7_wen) begin
			reg_dmi_progbuf7 <= dmi_progbuf7_nx;
		end
	end
	assign dmi_progbuf7 = reg_dmi_progbuf7;
end
else begin : gen_progbuf7_hardwired
	assign dmi_progbuf7 = INSN_EBREAK;
end
endgenerate

generate
if (PROGBUF_SIZE > 8) begin : gen_progbuf8
	reg  [31:0] reg_dmi_progbuf8;
	always @(posedge clk) begin
		if (!dmi_dmactive) begin
			reg_dmi_progbuf8 <= 32'd0;
		end
		else if (progbuf8_wen) begin
			reg_dmi_progbuf8 <= dmi_progbuf8_nx;
		end
	end
	assign dmi_progbuf8 = reg_dmi_progbuf8;
end
else begin : gen_progbuf8_hardwired
	assign dmi_progbuf8 = INSN_EBREAK;
end
endgenerate

generate
if (PROGBUF_SIZE > 9) begin : gen_progbuf9
	reg  [31:0] reg_dmi_progbuf9;
	always @(posedge clk) begin
		if (!dmi_dmactive) begin
			reg_dmi_progbuf9 <= 32'd0;
		end
		else if (progbuf9_wen) begin
			reg_dmi_progbuf9 <= dmi_progbuf9_nx;
		end
	end
	assign dmi_progbuf9 = reg_dmi_progbuf9;
end
else begin : gen_progbuf9_hardwired
	assign dmi_progbuf9 = INSN_EBREAK;
end
endgenerate

generate
if (PROGBUF_SIZE > 10) begin : gen_progbuf10
	reg  [31:0] reg_dmi_progbuf10;
	always @(posedge clk) begin
		if (!dmi_dmactive) begin
			reg_dmi_progbuf10 <= 32'd0;
		end
		else if (progbuf10_wen) begin
			reg_dmi_progbuf10 <= dmi_progbuf10_nx;
		end
	end
	assign dmi_progbuf10 = reg_dmi_progbuf10;
end
else begin : gen_progbuf10_hardwired
	assign dmi_progbuf10 = INSN_EBREAK;
end
endgenerate

generate
if (PROGBUF_SIZE > 11) begin : gen_progbuf11
	reg  [31:0] reg_dmi_progbuf11;
	always @(posedge clk) begin
		if (!dmi_dmactive) begin
			reg_dmi_progbuf11 <= 32'd0;
		end
		else if (progbuf11_wen) begin
			reg_dmi_progbuf11 <= dmi_progbuf11_nx;
		end
	end
	assign dmi_progbuf11 = reg_dmi_progbuf11;
end
else begin : gen_progbuf11_hardwired
	assign dmi_progbuf11 = INSN_EBREAK;
end
endgenerate

generate
if (PROGBUF_SIZE > 12) begin : gen_progbuf12
	reg  [31:0] reg_dmi_progbuf12;
	always @(posedge clk) begin
		if (!dmi_dmactive) begin
			reg_dmi_progbuf12 <= 32'd0;
		end
		else if (progbuf12_wen) begin
			reg_dmi_progbuf12 <= dmi_progbuf12_nx;
		end
	end
	assign dmi_progbuf12 = reg_dmi_progbuf12;
end
else begin : gen_progbuf12_hardwired
	assign dmi_progbuf12 = INSN_EBREAK;
end
endgenerate

generate
if (PROGBUF_SIZE > 13) begin : gen_progbuf13
	reg  [31:0] reg_dmi_progbuf13;
	always @(posedge clk) begin
		if (!dmi_dmactive) begin
			reg_dmi_progbuf13 <= 32'd0;
		end
		else if (progbuf13_wen) begin
			reg_dmi_progbuf13 <= dmi_progbuf13_nx;
		end
	end
	assign dmi_progbuf13 = reg_dmi_progbuf13;
end
else begin : gen_progbuf13_hardwired
	assign dmi_progbuf13 = INSN_EBREAK;
end
endgenerate

generate
if (PROGBUF_SIZE > 14) begin : gen_progbuf14
	reg  [31:0] reg_dmi_progbuf14;
	always @(posedge clk) begin
		if (!dmi_dmactive) begin
			reg_dmi_progbuf14 <= 32'd0;
		end
		else if (progbuf14_wen) begin
			reg_dmi_progbuf14 <= dmi_progbuf14_nx;
		end
	end
	assign dmi_progbuf14 = reg_dmi_progbuf14;
end
else begin : gen_progbuf14_hardwired
	assign dmi_progbuf14 = INSN_EBREAK;
end
endgenerate

generate
if (PROGBUF_SIZE > 15) begin : gen_progbuf15
	reg  [31:0] reg_dmi_progbuf15;
	always @(posedge clk) begin
		if (!dmi_dmactive) begin
			reg_dmi_progbuf15 <= 32'd0;
		end
		else if (progbuf15_wen) begin
			reg_dmi_progbuf15 <= dmi_progbuf15_nx;
		end
	end
	assign dmi_progbuf15 = reg_dmi_progbuf15;
end
else begin : gen_progbuf15_hardwired
	assign dmi_progbuf15 = INSN_EBREAK;
end
endgenerate



wire	[31:0] serial_count_value = SERIAL_COUNT;
wire	[31:0] serial0_value      = SERIAL0;

assign dmi_sercs = {serial_count_value[3:0],1'b0,serial0_value[2:0],21'd0,dmi_sercs_error0,dmi_sercs_valid0,dmi_sercs_full0};
assign dmi_serrx = 32'd0;



generate
if (SERIAL_COUNT > 0) begin : gen_serial0
	reg  [2:0]  serial0_tx_rptr;
	reg  [2:0]  serial0_tx_wptr;
	wire        serial0_tx_ren;
	wire        serial0_tx_wen;
	wire        serial0_tx_underflow;
	wire        serial0_tx_empty;
	wire        serial0_tx_full;
	wire        serial0_tx_almost_full;
	reg  [31:0] serial0_tx_ram[0:3];

	reg  [2:0]  serial0_rx_rptr;
	reg  [2:0]  serial0_rx_wptr;
	wire        serial0_rx_ren;
	wire        serial0_rx_wen;
	wire        serial0_rx_overflow;
	wire        serial0_rx_empty;
	wire        serial0_rx_full;
	reg  [31:0] serial0_rx_ram[0:3];

	reg         reg_dmi_sercs_error0;

	wire dmi_serial0_tx_ren  = dmi_hrdata_wen & (dmi_haddr[8:2] == DMI_ADDR_SERTX);

	wire reg_dmi_sercs_error0_clr = dmi_sercs_wen & dmi_hwdata[2];
	wire reg_dmi_sercs_error0_set = serial0_tx_underflow | serial0_rx_overflow;
	wire reg_dmi_sercs_error0_nx = ~reg_dmi_sercs_error0_clr & (reg_dmi_sercs_error0_set | reg_dmi_sercs_error0);
	always @(posedge clk) begin
		if (!dmi_dmactive) begin
			reg_dmi_sercs_error0 <= 1'b0;
		end
		else begin
			reg_dmi_sercs_error0 <= reg_dmi_sercs_error0_nx;
		end
	end

	wire [2:0] serial0_tx_rptr_nx = serial0_tx_rptr + 3'd1;
	wire [2:0] serial0_tx_wptr_nx = serial0_tx_wptr + 3'd1;

	wire [2:0] serial0_rx_rptr_nx = serial0_rx_rptr + 3'd1;
	wire [2:0] serial0_rx_wptr_nx = serial0_rx_wptr + 3'd1;

	assign     serial0_tx_empty        = (serial0_tx_rptr == serial0_tx_wptr);
	assign     serial0_tx_full         = (serial0_tx_rptr == (serial0_tx_wptr ^ 3'b100));
	assign     serial0_tx_almost_full  = (serial0_tx_rptr == (serial0_tx_wptr_nx ^ 3'b100));

	assign     serial0_rx_empty = (serial0_rx_rptr == serial0_rx_wptr);
	assign     serial0_rx_full  = (serial0_rx_rptr == (serial0_rx_wptr ^ 3'b100));

	assign dmi_sercs_full0 = serial0_rx_full;
	assign dmi_sercs_valid0 = !serial0_tx_empty;

	assign serial0_tx_ren       = dmi_serial0_tx_ren & !serial0_tx_empty;
	assign serial0_tx_wen       = rv_serial0_tx_wen & !serial0_tx_full;
	assign serial0_tx_underflow = dmi_serial0_tx_ren & serial0_tx_empty;

	assign serial0_rx_ren       = rv_serial0_rx_ren & !serial0_rx_empty;
	assign serial0_rx_wen       = dmi_serrx_wen & !serial0_rx_full;
	assign serial0_rx_overflow  = dmi_serrx_wen & serial0_rx_full;

	always @(posedge clk or negedge dmi_resetn) begin
		if (!dmi_resetn) begin
			serial0_tx_rptr <= 3'd0;
		end
		else if (serial0_tx_ren) begin
			serial0_tx_rptr <= serial0_tx_rptr_nx;
		end
	end

	always @(posedge clk or negedge dmi_resetn) begin
		if (!dmi_resetn) begin
			serial0_tx_wptr <= 3'd0;
		end
		else if (serial0_tx_wen) begin
			serial0_tx_wptr <= serial0_tx_wptr_nx;
		end
	end

	always @(posedge clk or negedge dmi_resetn) begin
		if (!dmi_resetn) begin
			serial0_rx_rptr <= 3'd0;
		end
		else if (serial0_rx_ren) begin
			serial0_rx_rptr <= serial0_rx_rptr_nx;
		end
	end

	always @(posedge clk or negedge dmi_resetn) begin
		if (!dmi_resetn) begin
			serial0_rx_wptr <= 3'd0;
		end
		else if (serial0_rx_wen) begin
			serial0_rx_wptr <= serial0_rx_wptr_nx;
		end
	end

	assign dmi_sertx = serial0_tx_ram[serial0_tx_rptr[1:0]];
	assign rv_serrx  = serial0_rx_ram[serial0_rx_rptr[1:0]];

	integer i, j;
	always @(posedge clk or negedge dmi_resetn) begin
		if (!dmi_resetn) begin
			for (i = 0; i < 4; i = i + 1)
				serial0_tx_ram[i] <= 32'd0;
		end
		else if (serial0_tx_wen) begin
			serial0_tx_ram[serial0_tx_wptr[1:0]] <= rv_wr_data[31:0];
		end
	end
	always @(posedge clk or negedge dmi_resetn) begin
		if (!dmi_resetn) begin
			for (j = 0; j < 4; j = j + 1)
				serial0_rx_ram[j] <= 32'd0;
		end
		else if (serial0_rx_wen) begin
			serial0_rx_ram[serial0_rx_wptr[1:0]] <= dmi_serrx_nx;
		end
	end

	assign dmi_sercs_error0          = reg_dmi_sercs_error0;
	assign serial0_tx_may_overflow   = rv_serial0_tx_wen    & serial0_tx_almost_full;
	assign serial0_tx_will_overflow  = rv_serial0_tx_wen_nx & serial0_tx_full;
	assign serial0_rx_will_underflow = rv_serial0_rx_ren    & serial0_rx_empty;

end
else begin : gen_serial0_no
	assign dmi_sercs_error0 = 1'b0;
	assign dmi_sercs_valid0 = 1'b0;
	assign dmi_sercs_full0 = 1'b0;

	assign dmi_sertx       = 32'd0;

	assign rv_serrx        = 32'd0;

	assign serial0_tx_may_overflow = 1'b0;
	assign serial0_tx_will_overflow = 1'b0;
	assign serial0_rx_will_underflow = 1'b0;
end
endgenerate


localparam SBCS_SBACCESS_8BIT   = 3'd0;
localparam SBCS_SBACCESS_16BIT  = 3'd1;
localparam SBCS_SBACCESS_32BIT  = 3'd2;
localparam SBCS_SBACCESS_64BIT  = 3'd3;
localparam SBCS_SBACCESS_128BIT = 3'd4;

localparam SBCS_8BIT_SUPPORT   = ((SYSTEM_BUS_ACCESS_SUPPORT == "yes") && (SYS_DATA_WIDTH >=8));
localparam SBCS_16BIT_SUPPORT  = ((SYSTEM_BUS_ACCESS_SUPPORT == "yes") && (SYS_DATA_WIDTH >=16));
localparam SBCS_32BIT_SUPPORT  = ((SYSTEM_BUS_ACCESS_SUPPORT == "yes") && (SYS_DATA_WIDTH >=32));
localparam SBCS_64BIT_SUPPORT  = ((SYSTEM_BUS_ACCESS_SUPPORT == "yes") && (SYS_DATA_WIDTH >=64));
localparam SBCS_128BIT_SUPPORT = ((SYSTEM_BUS_ACCESS_SUPPORT == "yes") && (SYS_DATA_WIDTH >=128));
localparam SBCS_BUS_ADDR_WIDTH = (SYSTEM_BUS_ACCESS_SUPPORT == "no") ? 7'd0 : SYS_ADDR_WIDTH;

wire	[6:0]	sbcs_sbasize     = SBCS_BUS_ADDR_WIDTH;
wire		sbcs_sbaccess128 = SBCS_128BIT_SUPPORT;
wire		sbcs_sbaccess64  = SBCS_64BIT_SUPPORT;
wire		sbcs_sbaccess32  = SBCS_32BIT_SUPPORT;
wire		sbcs_sbaccess16  = SBCS_16BIT_SUPPORT;
wire		sbcs_sbaccess8   = SBCS_8BIT_SUPPORT;


wire            sys_mst_read_req_valid;
wire            sys_mst_write_req_valid;
wire      [2:0] sys_mst_req_size;
wire		bus_access_done;
wire            sys_bus_reset   = sys_rst;
wire		sys_bus_error;
wire	[127:0]	sys_read_data_128;
wire	[127:0]	sys_write_data_128;
wire	[127:0]	sys_sbaddress_128;
wire		sys_rdata_ready;

wire	[2:0]	dmi_sbcs_sbversion;
wire    	dmi_sbcs_sbbusyerror;
wire            dmi_sbcs_sbbusy;
wire    	dmi_sbcs_sbreadonaddr;
wire    [2:0]	dmi_sbcs_sbaccess;
wire	        dmi_sbcs_sbautoincrement;
wire	        dmi_sbcs_sbreadondata;
wire    [2:0]	dmi_sbcs_sberror;
wire    [6:0]	dmi_sbcs_sbasize;
wire	        dmi_sbcs_sbaccess128;
wire	        dmi_sbcs_sbaccess64;
wire	        dmi_sbcs_sbaccess32;
wire	        dmi_sbcs_sbaccess16;
wire	        dmi_sbcs_sbaccess8;

assign dmi_sbcs[31:29] = dmi_sbcs_sbversion;
assign dmi_sbcs[28:23] = 6'd0;
assign dmi_sbcs[22]    = dmi_sbcs_sbbusyerror;
assign dmi_sbcs[21]    = dmi_sbcs_sbbusy;
assign dmi_sbcs[20]    = dmi_sbcs_sbreadonaddr;
assign dmi_sbcs[19:17] = dmi_sbcs_sbaccess;
assign dmi_sbcs[16]    = dmi_sbcs_sbautoincrement;
assign dmi_sbcs[15]    = dmi_sbcs_sbreadondata;
assign dmi_sbcs[14:12] = dmi_sbcs_sberror;
assign dmi_sbcs[11:5]  = dmi_sbcs_sbasize;
assign dmi_sbcs[4]     = dmi_sbcs_sbaccess128;
assign dmi_sbcs[3]     = dmi_sbcs_sbaccess64;
assign dmi_sbcs[2]     = dmi_sbcs_sbaccess32;
assign dmi_sbcs[1]     = dmi_sbcs_sbaccess16;
assign dmi_sbcs[0]     = dmi_sbcs_sbaccess8;


generate
if (SYSTEM_BUS_ACCESS_SUPPORT == "yes") begin : gen_sys_bus_dmi_interface
        assign   dmi_sbcs_wen         = dmi_req_valid_dp &  dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_SBCS)       & (sbcs_sbasize > 7'd0);
        assign   dmi_sbaddress0_wen   = dmi_req_valid_dp &  dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_SBADDRESS0) & (sbcs_sbasize > 7'd0 );
        assign   dmi_sbaddress1_wen   = dmi_req_valid_dp &  dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_SBADDRESS1) & (sbcs_sbasize > 7'd32);
        assign   dmi_sbaddress2_wen   = dmi_req_valid_dp &  dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_SBADDRESS2) & (sbcs_sbasize > 7'd64);
        assign   dmi_sbaddress3_wen   = dmi_req_valid_dp &  dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_SBADDRESS3) & (sbcs_sbasize > 7'd96);
        assign   dmi_sbdata0_wen      = dmi_req_valid_dp &  dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_SBDATA0)    & (SYS_DATA_WIDTH > 0 );
        assign   dmi_sbdata1_wen      = dmi_req_valid_dp &  dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_SBDATA1)    & (SYS_DATA_WIDTH > 32);
        assign   dmi_sbdata2_wen      = dmi_req_valid_dp &  dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_SBDATA2)    & (SYS_DATA_WIDTH > 64);
        assign   dmi_sbdata3_wen      = dmi_req_valid_dp &  dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_SBDATA3)    & (SYS_DATA_WIDTH > 96);
        assign   dmi_sbdata0_ren      = dmi_req_valid_dp & ~dmi_hwrite_dp & (dmi_haddr_dp == DMI_ADDR_SBDATA0)    & (SYS_DATA_WIDTH > 0 );
end
else begin : gen_no_sys_bus_dmi_interface
        assign   dmi_sbcs_wen         = 1'b0;
        assign   dmi_sbaddress0_wen   = 1'b0;
        assign   dmi_sbaddress1_wen   = 1'b0;
        assign   dmi_sbaddress2_wen   = 1'b0;
        assign   dmi_sbaddress3_wen   = 1'b0;
        assign   dmi_sbdata0_wen      = 1'b0;
        assign   dmi_sbdata1_wen      = 1'b0;
        assign   dmi_sbdata2_wen      = 1'b0;
        assign   dmi_sbdata3_wen      = 1'b0;
        assign   dmi_sbdata0_ren      = 1'b0;
end
endgenerate

generate
genvar i_aw, i_w, i_ar, i_r, i_hr, i_ha, i_hw;
if ((SYSTEM_BUS_ACCESS_SUPPORT == "yes") && (SYS_BUS_TYPE == "axi")) begin : gen_sys_bus_axi_mst
	wire		sys_aw_ch_taken;
	wire		sys_w_ch_taken;
	wire		sys_b_ch_taken;
	wire		sys_ar_ch_taken;
	wire		sys_r_ch_taken;

	wire	[1:0]	axi_resp;

	reg		gen_sys_awvalid;
	wire		set_gen_sys_awvalid;
	wire		clr_gen_sys_awvalid;
	wire		gen_sys_awvalid_nx;

	reg		gen_sys_wvalid;
	wire		set_gen_sys_wvalid;
	wire		clr_gen_sys_wvalid;
	wire		gen_sys_wvalid_nx;
	reg	[15:0]	gen_sys_wstrb;
	reg	[15:0]	gen_sys_wstrb_128;
	reg	[15:0]	gen_sys_wstrb_nx;

	reg		gen_sys_arvalid;
	wire		set_gen_sys_arvalid;
	wire		clr_gen_sys_arvalid;
	wire		gen_sys_arvalid_nx;

	wire	[127:0] rdata_extend_128;

	always @(posedge clk or negedge bus_resetn) begin
		if (!bus_resetn) begin
			gen_sys_awvalid <= 1'b0;
			gen_sys_wvalid  <= 1'b0;
			gen_sys_arvalid <= 1'b0;
		end
		else begin
			gen_sys_awvalid <= gen_sys_awvalid_nx;
			gen_sys_wvalid  <= gen_sys_wvalid_nx;
			gen_sys_arvalid <= gen_sys_arvalid_nx;
		end
	end

	always @(posedge clk or negedge bus_resetn) begin
		if (!bus_resetn) begin
			gen_sys_wstrb <= 16'd0;
		end
		else if (sys_mst_write_req_valid) begin
			gen_sys_wstrb <= gen_sys_wstrb_nx;
		end
	end

	assign sys_aw_ch_taken = sys_awvalid & sys_awready;
	assign sys_w_ch_taken  = sys_wvalid  & sys_wready;
	assign sys_b_ch_taken  = sys_bvalid  & sys_bready;
	assign sys_ar_ch_taken = sys_arvalid & sys_arready;
	assign sys_r_ch_taken  = sys_rvalid  & sys_rready;

	assign bus_access_done = sys_b_ch_taken | sys_r_ch_taken;
	assign axi_resp	       = ({2{sys_b_ch_taken}} & sys_bresp) | ({2{sys_r_ch_taken}} & sys_rresp);
	assign sys_bus_error   = (axi_resp == NDS_ARESP_SLVERR) | (axi_resp == NDS_ARESP_DECERR);
	assign sys_rdata_ready = sys_r_ch_taken & ~sys_bus_error;

	assign set_gen_sys_awvalid = sys_mst_write_req_valid;
	assign clr_gen_sys_awvalid = sys_aw_ch_taken | sys_bus_reset;
	assign gen_sys_awvalid_nx  = set_gen_sys_awvalid | (~clr_gen_sys_awvalid & gen_sys_awvalid);

	for (i_aw = 0; i_aw < SYS_ADDR_WIDTH; i_aw = i_aw+32) begin: gen_sys_awaddr_by_sbaddress_128
		if ((i_aw+32) > SYS_ADDR_WIDTH) begin: gen_sys_awaddr_to_MSB
			assign sys_awaddr[SYS_ADDR_WIDTH-1:i_aw] = sys_sbaddress_128[SYS_ADDR_WIDTH-1:i_aw];
		end
		else begin: gen_sys_awaddr_32bit
			assign sys_awaddr[(i_aw+31):i_aw] = sys_sbaddress_128[(i_aw+31):i_aw];
		end
	end

	assign sys_awsize  = sys_mst_req_size;
	assign sys_awvalid = gen_sys_awvalid;
	assign sys_awid	   = {SYS_ID_WIDTH{1'b0}};
	assign sys_awlen   = 8'd0;
	assign sys_awburst = NDS_ABURST_FIXED;
	assign sys_awlock  = NDS_ALOCK_NORMAL;
	assign sys_awcache = 4'd0;
	assign sys_awprot  = 3'd0;

	assign set_gen_sys_wvalid = sys_mst_write_req_valid;
	assign clr_gen_sys_wvalid = sys_w_ch_taken | sys_bus_reset;
	assign gen_sys_wvalid_nx  = set_gen_sys_wvalid | (~clr_gen_sys_wvalid & gen_sys_wvalid);

	for (i_w = 0; i_w < SYS_DATA_WIDTH; i_w = i_w+32) begin: gen_sys_wdata_by_write_data_128
		assign sys_wdata[(i_w+31):i_w] = sys_write_data_128[(i_w+31):i_w];
	end

	always @* begin
		case (sys_mst_req_size)
		3'b000: gen_sys_wstrb_128 = (16'h0001 <<  sys_sbaddress_128[3:0]);
		3'b001: gen_sys_wstrb_128 = (16'h0003 << {sys_sbaddress_128[3:1], 1'b0});
		3'b010: gen_sys_wstrb_128 = (16'h000f << {sys_sbaddress_128[3:1], 1'b0});
		3'b011: gen_sys_wstrb_128 = (16'h00ff << {sys_sbaddress_128[3],   2'd0});
		3'b100: gen_sys_wstrb_128 =  16'hffff;
		default: gen_sys_wstrb_128 = 16'd0;
		endcase
	end

	always @* begin
		case ({dmi_sbcs[4], dmi_sbcs[3]})
		2'b00: gen_sys_wstrb_nx = {12'd0, (gen_sys_wstrb_128[15:12] | gen_sys_wstrb_128[11:8] | gen_sys_wstrb_128[7:4] | gen_sys_wstrb_128[3:0])};
		2'b01: gen_sys_wstrb_nx = {8'd0,  (gen_sys_wstrb_128[15:8]  | gen_sys_wstrb_128[7:0])};
		2'b11: gen_sys_wstrb_nx =  gen_sys_wstrb_128;
		default: gen_sys_wstrb_nx = 16'd0;
		endcase
	end


	assign sys_wstrb[(SYS_DATA_WIDTH/8)-1:0] = gen_sys_wstrb[(SYS_DATA_WIDTH/8)-1:0];
	assign sys_wlast  = 1'd1;
	assign sys_wvalid = gen_sys_wvalid;

	assign sys_bready = 1'b1;

        assign set_gen_sys_arvalid = sys_mst_read_req_valid;
	assign clr_gen_sys_arvalid = sys_ar_ch_taken | sys_bus_reset;
	assign gen_sys_arvalid_nx  = set_gen_sys_arvalid | (~clr_gen_sys_arvalid & gen_sys_arvalid);

	for (i_ar = 0; i_ar < SYS_ADDR_WIDTH; i_ar=i_ar+32) begin: gen_araddr_by_sys_address_128
		if ((i_ar+32) > SYS_ADDR_WIDTH) begin: gen_sys_araddr_to_MSB
			assign sys_araddr[SYS_ADDR_WIDTH-1:i_ar] = sys_sbaddress_128[SYS_ADDR_WIDTH-1:i_ar];
		end
		else begin: gen_sys_araddr_32bit
			assign sys_araddr[(i_ar+31):i_ar] = sys_sbaddress_128[(i_ar+31):i_ar];
		end
	end
	assign sys_arsize  = sys_mst_req_size;
	assign sys_arvalid = gen_sys_arvalid;
	assign sys_arid	  = {SYS_ID_WIDTH{1'b0}};
	assign sys_arlen   = 8'd0;
	assign sys_arburst = NDS_ABURST_FIXED;
	assign sys_arlock  = NDS_ALOCK_NORMAL;
	assign sys_arcache = 4'd0;
	assign sys_arprot  = 3'd0;

	assign sys_rready = 1'b1;

	for (i_r = 0; i_r < 128; i_r=i_r+32) begin: gen_read_rdata_128_by_sys_rdata
		if (i_r < SYS_DATA_WIDTH) begin: gen_valid_rdata_from_rdata
			assign rdata_extend_128[(i_r+31):i_r] = sys_rdata[(i_r+31):i_r];
		end
		else begin: gen_axi_unused_rdata_by_word0
			assign rdata_extend_128[(i_r+31):i_r] = sys_rdata[31:0];
		end
	end
	assign sys_read_data_128[31:0]   = rdata_extend_128[31:0];
	assign sys_read_data_128[63:32]  = rdata_extend_128[63:32];
	assign sys_read_data_128[95:64]  = rdata_extend_128[95:64];
	assign sys_read_data_128[127:96] = (SYS_DATA_WIDTH == 64) ? rdata_extend_128[63:32] : rdata_extend_128[127:96];


end
endgenerate

generate
if (((SYSTEM_BUS_ACCESS_SUPPORT == "yes") && (SYS_BUS_TYPE != "axi")) || (SYSTEM_BUS_ACCESS_SUPPORT == "no")) begin : gen_sys_bus_axi_dummy_output
	assign sys_awid    = {SYS_ID_WIDTH{1'b0}};
	assign sys_awaddr  = {SYS_ADDR_WIDTH{1'b0}};
	assign sys_awlen   = 8'd0;
	assign sys_awsize  = 3'd0;
	assign sys_awburst = 2'd0;
	assign sys_awlock  = 1'b0;
	assign sys_awcache = 4'd0;
	assign sys_awprot  = 3'd0;
	assign sys_awvalid = 1'b0;
	assign sys_wdata   = {SYS_DATA_WIDTH{1'b0}};
	assign sys_wstrb   = {(SYS_DATA_WIDTH/8){1'b0}};
	assign sys_wlast   = 1'b0;
	assign sys_wvalid  = 1'b0;
	assign sys_bready  = 1'b0;
	assign sys_arid    = {SYS_ID_WIDTH{1'b0}};
	assign sys_araddr  = {SYS_ADDR_WIDTH{1'b0}};
	assign sys_arlen   = 8'd0;
	assign sys_arsize  = 3'd0;
	assign sys_arburst = 2'd0;
	assign sys_arlock  = 1'b0;
	assign sys_arcache = 4'd0;
	assign sys_arprot  = 3'd0;
	assign sys_arvalid = 1'b0;
	assign sys_rready  = 1'b0;
end
endgenerate

generate
if ((SYSTEM_BUS_ACCESS_SUPPORT == "yes") && (SYS_BUS_TYPE == "ahb")) begin : gen_sys_bus_ahb_mst
	reg	gen_sys_hbusreq;
	wire	set_gen_sys_hbusreq;
	wire	clr_gen_sys_hbusreq;
	wire	sys_htrans_1;
	wire	gen_sys_hbusreq_nx;
	reg	sys_req_write;
        wire	sys_req_write_nx;
	wire	sys_req_valid;

	wire	dmi_sbdata0_wen_ap;
        wire    sys_ahb_granted;
	reg	sys_ahb_ap;
	reg	sys_ahb_dp;
	wire	sys_ahb_ap_nx;
	wire	sys_ahb_dp_nx;

	wire	[127:0] hrdata_extend_128;

        always @(posedge clk or negedge bus_resetn) begin
                if (!bus_resetn) begin
			gen_sys_hbusreq <= 1'b0;
                end
                else begin
			gen_sys_hbusreq  <= gen_sys_hbusreq_nx;
                end
        end

        always @(posedge clk or negedge bus_resetn) begin
                if (!bus_resetn) begin
                        sys_req_write   <= 1'b0;
                end
                else if (sys_req_valid) begin
                        sys_req_write   <= sys_req_write_nx;
                end
        end

	always @(posedge clk or negedge bus_resetn) begin
		if (!bus_resetn) begin
			sys_ahb_ap       <= 1'b0;
			sys_ahb_dp       <= 1'b0;
		end
		else if (sys_hready) begin
			sys_ahb_ap       <= sys_ahb_ap_nx;
			sys_ahb_dp       <= sys_ahb_dp_nx;
		end
	end

	assign dmi_sbdata0_wen_ap = dmi_req_valid & dmi_hwrite & (dmi_haddr[8:2] == DMI_ADDR_SBDATA0);

        assign bus_access_done = sys_ahb_dp & sys_hready & (sys_hresp == NDS_HRESP_OKAY | sys_hresp == NDS_HRESP_ERROR);
	assign sys_bus_error   = (sys_hresp == NDS_HRESP_ERROR);
	assign sys_rdata_ready = bus_access_done & ~sys_req_write & ~sys_bus_error;

        assign sys_ahb_granted = sys_hgrant & sys_hready;

        assign set_gen_sys_hbusreq = sys_mst_read_req_valid | sys_mst_write_req_valid
                                   | sys_ahb_dp & sys_hready & (sys_hresp == NDS_HRESP_RETRY | sys_hresp == NDS_HRESP_SPLIT);
        assign clr_gen_sys_hbusreq = sys_ahb_granted;
	assign gen_sys_hbusreq_nx  = set_gen_sys_hbusreq | (~clr_gen_sys_hbusreq & gen_sys_hbusreq);

	assign sys_ahb_ap_nx = gen_sys_hbusreq & sys_ahb_granted;
	assign sys_ahb_dp_nx = sys_ahb_ap;
	assign sys_htrans_1  = sys_ahb_ap;

        assign sys_req_valid     = sys_mst_read_req_valid | sys_mst_write_req_valid;
        assign sys_req_write_nx  = sys_mst_write_req_valid;

	for (i_ha = 0; i_ha < SYS_ADDR_WIDTH; i_ha=i_ha+32) begin: gen_sys_haddr_by_sys_address_128
		if ((i_ha+32) > SYS_ADDR_WIDTH) begin: gen_haddr_to_MSB
			assign sys_haddr[SYS_ADDR_WIDTH-1:i_ha] = sys_sbaddress_128[SYS_ADDR_WIDTH-1:i_ha];
		end
		else begin: gen_haddr_32bit
			assign sys_haddr[(i_ha+31):i_ha] = sys_sbaddress_128[(i_ha+31):i_ha];
		end
	end

	for (i_hw = 0; i_hw < SYS_DATA_WIDTH; i_hw = i_hw+32) begin: gen_sys_hwdata_by_write_data_128
		assign sys_hwdata[(i_hw+31):i_hw] = sys_write_data_128[(i_hw+31):i_hw];
	end

	for (i_hr = 0; i_hr < 128; i_hr=i_hr+32) begin: gen_read_data_128_by_hrdata
		if (i_hr < SYS_DATA_WIDTH) begin: gen_valid_rdata_from_hrdata
			assign hrdata_extend_128[(i_hr+31):i_hr] = sys_hrdata[(i_hr+31):i_hr];
		end
		else begin: gen_ahb_unused_rdata_by_word0
			assign hrdata_extend_128[(i_hr+31):i_hr] = sys_hrdata[31:0];
		end
	end
	assign sys_read_data_128[31:0]   = hrdata_extend_128[31:0];
	assign sys_read_data_128[63:32]  = hrdata_extend_128[63:32];
	assign sys_read_data_128[95:64]  = hrdata_extend_128[95:64];
	assign sys_read_data_128[127:96] = (SYS_DATA_WIDTH == 64) ? hrdata_extend_128[63:32] : hrdata_extend_128[127:96];

	assign sys_htrans  = {sys_htrans_1, 1'b0};
        assign sys_hwrite  = sys_ahb_ap & sys_req_write;
        assign sys_hsize   = {3{sys_ahb_ap}} & sys_mst_req_size;
	assign sys_hburst  = NDS_HBURST_SINGLE;
	assign sys_hprot   = 4'd0;
	assign sys_hbusreq = gen_sys_hbusreq;

end
endgenerate

generate
if (((SYSTEM_BUS_ACCESS_SUPPORT == "yes") && (SYS_BUS_TYPE != "ahb")) || (SYSTEM_BUS_ACCESS_SUPPORT == "no")) begin : gen_sys_bus_ahb_dummy_output
	assign sys_haddr   = {SYS_ADDR_WIDTH{1'd0}};
	assign sys_htrans  = 2'd0;
	assign sys_hwrite  = 1'd0;
	assign sys_hsize   = 3'd0;
	assign sys_hburst  = 3'd0;
	assign sys_hprot   = 4'd0;
	assign sys_hwdata  = {SYS_DATA_WIDTH{1'd0}};
	assign sys_hbusreq = 1'd0;
end
endgenerate

wire            sys_reg_acc_en;
generate
if (SYSTEM_BUS_ACCESS_SUPPORT == "yes") begin : gen_sys_bus_ctrl
        reg  [SYS_ADDR_WIDTH-1:0] reg_sbaddress;
        wire [SYS_ADDR_WIDTH-1:0] reg_sbaddress_nx;
        wire [SYS_ADDR_WIDTH-1:0] dmi_sbaddress_bit_we;
        wire [SYS_ADDR_WIDTH-1:0] reg_sbaddress_bit_we;
        wire [127:0]              dmi_sbaddress_bit_we_128;
        wire [127:0]              dmi_sbaddress_wdata_128;
        wire [128:0]              dmi_sbaddress_ext;

	reg  [31:0] reg_dmi_sbdata0;

	wire [31:0] dmi_sbdata0_nx;
	wire [31:0] sbdata0_wd_align;
	reg  [31:0] sbdata0_rd_align;

	reg		sbcs_sbbusyerror;
	reg             sbcs_sbbusy;
	reg		sbcs_sbreadonaddr;
	reg	[2:0]	sbcs_sbaccess;
	reg		sbcs_sbautoincrement;
	reg		sbcs_sbreadondata;
	reg	[2:0]	sbcs_sberror;


	wire		sbcs_sbbusyerror_nx;
	wire		sbcs_sbbusyerror_w1c;
	wire		sbcs_sbbusy_nx;
	wire		sbcs_sbreadonaddr_nx;
	wire	[2:0]	sbcs_sbaccess_nx;
	wire		sbcs_sbautoincrement_nx;
	wire		sbcs_sbreadondata_nx;
	wire	[2:0]	sbcs_sberror_w1c;
	wire		clr_sbcs_sberror;
	wire		sys_bus_resp_err;
        wire            sb_active_cmd_reset;
	wire		unalign_16bit;
	wire		unalign_32bit;
	wire		unalign_64bit;
	wire		unalign_128bit;
	wire		unalign_addr_err;
	wire		unsupported_size;
	wire	[4:0]	supported_size_mask;

        wire            sb_cmd_issue;
        wire    [2:0]   sb_cmd_error;
	wire	[2:0]	sbcs_sberror_nx;
	wire		sbcs_sberror_wen;

	wire		set_sbbusyerror;

	wire		set_sbcs_sbbusy;
	wire		clr_sbcs_sbbusy;

	wire	[127:0]	sbaddress_full;
	wire	[127:0]	sbaddress_add;
	wire	[31:0]	sbaddress_incr;
	wire		sbdata0_wen;
	wire		sbdata0_rd_wen;

	reg	[15:0]	partial_wdata;
	wire	[15:0]	partial_wdata_nx;
	wire		partial_access;
	wire		partial_32bit;
	wire		partial_64bit;
	wire            sel_sbdata;
	wire		partial_wen;
	wire	[31:0]	wrap_wdata_0;
	wire	[31:0]	wrap_wdata_1;
	wire	[31:0]	wrap_wdata_2;
        wire	[31:0]	wrap_wdata_3;

        wire		sys_readonaddr;
        wire		sys_readondata;
        wire	[2:0]	sbaccess_size;

        wire            sys_wcmd_req;
        wire            sys_rcmd_req;
        wire            sys_cmd_valid;
        wire            sys_reg_acc_kill;
        wire            sys_cmd_kill;
        wire            sys_cmd_en;
        wire    [3:0]   sys_cmd_sbaddress_3_0;

        assign sys_readonaddr    = dmi_sbcs[20];
        assign sys_readondata    = dmi_sbcs[15];
        assign sbaccess_size	 = dmi_sbcs[19:17];

        assign sys_reg_acc_kill  = sbcs_sbbusy | sbcs_sbbusyerror;
        assign sys_cmd_kill      = |sbcs_sberror;
        assign sys_reg_acc_en    = ~sys_reg_acc_kill;
        assign sys_cmd_en        = ~sys_reg_acc_kill & ~sys_cmd_kill;

        assign sys_wcmd_req      = dmi_sbdata0_wen;
        assign sys_rcmd_req      = (sys_readondata & dmi_sbdata0_ren | sys_readonaddr & dmi_sbaddress0_wen);
        assign sys_cmd_valid     = ~(unalign_addr_err | unsupported_size | sys_bus_reset);
        assign sys_cmd_sbaddress_3_0 = (dmi_sbaddress0_wen) ? dmi_hwdata[3:0] : dmi_sbaddress0[3:0];

        assign sys_mst_read_req_valid  = sys_rcmd_req & sys_cmd_valid & ~sys_reg_acc_kill & ~sys_cmd_kill;
        assign sys_mst_write_req_valid = sys_wcmd_req & sys_cmd_valid & ~sys_reg_acc_kill & ~sys_cmd_kill;
        assign sys_mst_req_size = sbaccess_size;

        assign sys_sbaddress_128  = {dmi_sbaddress3, dmi_sbaddress2, dmi_sbaddress1, dmi_sbaddress0};

	always @(posedge clk or negedge dmi_resetn) begin
		if (!dmi_resetn) begin
                        sbcs_sbbusy      <= 1'b0;
			sbcs_sbbusyerror <= 1'b0;
		end
		else begin
                        sbcs_sbbusy      <= sbcs_sbbusy_nx;
			sbcs_sbbusyerror <= sbcs_sbbusyerror_nx;
		end
	end

	always @(posedge clk or negedge dmi_resetn) begin
		if (!dmi_resetn) begin
			sbcs_sberror	 <= 3'd0;
		end
		else if (sbcs_sberror_wen) begin
			sbcs_sberror	 <= sbcs_sberror_nx;
		end
	end

	always @(posedge clk or negedge dmi_resetn) begin
		if (!dmi_resetn) begin
			sbcs_sbreadonaddr    <= 1'b0;
			sbcs_sbaccess	     <= SBCS_SBACCESS_32BIT;
			sbcs_sbautoincrement <= 1'b0;
			sbcs_sbreadondata    <= 1'b0;
		end
		else if (dmi_sbcs_wen) begin
			sbcs_sbreadonaddr    <= sbcs_sbreadonaddr_nx;
			sbcs_sbaccess	     <= sbcs_sbaccess_nx;
			sbcs_sbautoincrement <= sbcs_sbautoincrement_nx;
			sbcs_sbreadondata    <= sbcs_sbreadondata_nx;
		end
	end

        assign dmi_sbaddress_bit_we_128 = {{32{dmi_sbaddress3_wen}}, {32{dmi_sbaddress2_wen}}, {32{dmi_sbaddress1_wen}}, {32{dmi_sbaddress0_wen}}};
        assign dmi_sbaddress_wdata_128  = {4{dmi_hwdata}};
        assign dmi_sbaddress_bit_we = dmi_sbaddress_bit_we_128[SYS_ADDR_WIDTH-1:0] & {SYS_ADDR_WIDTH{sys_reg_acc_en}};

	assign sbaddress_incr = (32'd1 << sbcs_sbaccess);
	assign sbaddress_full = {dmi_sbaddress3, dmi_sbaddress2, dmi_sbaddress1, dmi_sbaddress0};
	assign sbaddress_add  = sbaddress_full + {96'd0, sbaddress_incr};

        assign reg_sbaddress_bit_we = dmi_sbaddress_bit_we | {SYS_ADDR_WIDTH{sbcs_sbautoincrement & bus_access_done & ~sys_bus_error}};
        assign reg_sbaddress_nx  = (|dmi_sbaddress_bit_we) ? dmi_sbaddress_wdata_128[SYS_ADDR_WIDTH-1:0] : sbaddress_add[SYS_ADDR_WIDTH-1:0];

        integer i_sba_bit;
        always @(posedge clk or negedge dmi_resetn) begin
                if (!dmi_resetn) begin
                        reg_sbaddress <= {SYS_ADDR_WIDTH{1'b0}};
                end
                else begin
                        for (i_sba_bit = 0; i_sba_bit < SYS_ADDR_WIDTH; i_sba_bit = i_sba_bit + 1) begin
                                if (reg_sbaddress_bit_we[i_sba_bit]) begin
                                        reg_sbaddress[i_sba_bit] <= reg_sbaddress_nx[i_sba_bit];
                                end
                        end
                end
        end

        assign dmi_sbaddress_ext = {{(129-SYS_ADDR_WIDTH){1'b0}}, reg_sbaddress};
        assign dmi_sbaddress3 = dmi_sbaddress_ext[127:96];
        assign dmi_sbaddress2 = dmi_sbaddress_ext[ 95:64];
        assign dmi_sbaddress1 = dmi_sbaddress_ext[ 63:32];
        assign dmi_sbaddress0 = dmi_sbaddress_ext[ 31: 0];

	always @(posedge clk or negedge dmi_resetn) begin
		if (!dmi_resetn) begin
			partial_wdata <= 16'd0;
		end
		else if (partial_wen) begin
			partial_wdata <= partial_wdata_nx;
		end
	end

	always @(posedge clk or negedge dmi_resetn) begin
		if (!dmi_resetn) begin
			reg_dmi_sbdata0 <= 32'd0;
		end
		else if (sbdata0_wen) begin
			reg_dmi_sbdata0 <= dmi_sbdata0_nx;
		end
	end

        assign set_sbcs_sbbusy   = (sys_rcmd_req | sys_wcmd_req) & sys_cmd_valid & sys_cmd_en;
        assign clr_sbcs_sbbusy   = bus_access_done | sys_bus_reset;
	assign sbcs_sbbusy_nx  = set_sbcs_sbbusy | (~clr_sbcs_sbbusy & sbcs_sbbusy);

        assign set_sbbusyerror = sbcs_sbbusy & (dmi_sbdata0_wen    | dmi_sbdata1_wen    | dmi_sbdata2_wen    | dmi_sbdata3_wen
                                             |  dmi_sbaddress0_wen | dmi_sbaddress1_wen | dmi_sbaddress2_wen | dmi_sbaddress3_wen
                                             |  sys_rcmd_req       | sys_wcmd_req);

	assign sbcs_sbbusyerror_w1c    = sbcs_sbbusyerror & ~dmi_hwdata[22];
	assign sbcs_sbbusyerror_nx     = dmi_sbcs_wen    ? sbcs_sbbusyerror_w1c :
					 set_sbbusyerror ? 1'b1 :
							   sbcs_sbbusyerror;
	assign sbcs_sbreadonaddr_nx    = dmi_hwdata[20];
	assign sbcs_sbaccess_nx	       = dmi_hwdata[19:17];
	assign sbcs_sbautoincrement_nx = dmi_hwdata[16];
	assign sbcs_sbreadondata_nx    = dmi_hwdata[15];

	assign supported_size_mask  = {sbcs_sbaccess128, sbcs_sbaccess64, sbcs_sbaccess32, sbcs_sbaccess16, sbcs_sbaccess8};
	assign clr_sbcs_sberror = dmi_sbcs_wen & (|sbcs_sberror);
	assign sbcs_sberror_w1c = sbcs_sberror & ~dmi_hwdata[14:12];
	assign sys_bus_resp_err = bus_access_done & sys_bus_error;
        assign sb_active_cmd_reset = sbcs_sbbusy & sys_bus_reset;

	assign unalign_16bit    = (sbcs_sbaccess == SBCS_SBACCESS_16BIT)  &   sys_cmd_sbaddress_3_0[0];
	assign unalign_32bit    = (sbcs_sbaccess == SBCS_SBACCESS_32BIT)  & (|sys_cmd_sbaddress_3_0[1:0]);
	assign unalign_64bit    = (sbcs_sbaccess == SBCS_SBACCESS_64BIT)  & (|sys_cmd_sbaddress_3_0[2:0]);
        assign unalign_128bit   = (sbcs_sbaccess == SBCS_SBACCESS_128BIT) & (|sys_cmd_sbaddress_3_0[3:0]);
	assign unalign_addr_err = (unalign_16bit | unalign_32bit | unalign_64bit | unalign_128bit);
	assign unsupported_size = ~|((5'b00001 << sbcs_sbaccess) & supported_size_mask);

        assign sb_cmd_issue     = ((sys_rcmd_req | sys_wcmd_req) & sys_cmd_en);
        assign sb_cmd_error     = unsupported_size ? SYS_BUS_SBERROR_SIZE_UNSUPPORTED :
                                  unalign_addr_err ? SYS_BUS_SBERROR_ALIGN_ERROR :
                                  sys_bus_reset    ? SYS_BUS_SBERROR_OTHER :
                                                     SYS_BUS_SBERROR_NONE ;

        assign sbcs_sberror_wen = sb_cmd_issue | bus_access_done | dmi_sbcs_wen | sb_active_cmd_reset;
	assign sbcs_sberror_nx	= clr_sbcs_sberror      ? sbcs_sberror_w1c :
                                 (sbcs_sberror != 3'd0) ? sbcs_sberror :
                                  sys_bus_resp_err      ? SYS_BUS_SBERROR_BADADDR :
                                  sb_cmd_issue          ? sb_cmd_error :
                                  sb_active_cmd_reset   ? SYS_BUS_SBERROR_OTHER :
                                                          SYS_BUS_SBERROR_NONE ;

	assign sbdata0_wd_align = dmi_hwdata;

        assign partial_wen       = (dmi_sbdata0_wen & sys_reg_acc_en) & partial_access;
	assign partial_wdata_nx  = sbcs_sbaccess[0] ? dmi_hwdata[15:0] : {dmi_hwdata[7:0], dmi_hwdata[7:0]};

        assign partial_32bit     = (sbcs_sbaccess == SBCS_SBACCESS_32BIT) & sbcs_sbaccess64;
        assign partial_64bit     = (sbcs_sbaccess == SBCS_SBACCESS_64BIT) & sbcs_sbaccess128;
        assign partial_access    = (sbcs_sbaccess <  SBCS_SBACCESS_32BIT);
        assign sel_sbdata        = ~(partial_access | partial_32bit | partial_64bit);

	assign wrap_wdata_0 = ({32{ partial_access}} & {partial_wdata, partial_wdata})
			    | ({32{~partial_access}} & dmi_sbdata0);

	assign wrap_wdata_1 = ({32{partial_access}} & {partial_wdata, partial_wdata})
			    | ({32{partial_32bit}}  & dmi_sbdata0)
			    | ({32{(sel_sbdata | partial_64bit)}} & dmi_sbdata1);

	assign wrap_wdata_2 = ({32{partial_access}} & {partial_wdata, partial_wdata})
			    | ({32{sel_sbdata}}	    & dmi_sbdata2)
			    | ({32{(partial_32bit | partial_64bit)}} & dmi_sbdata0);

	assign wrap_wdata_3 = ({32{partial_access}} & {partial_wdata, partial_wdata})
			    | ({32{partial_32bit}}  & dmi_sbdata0)
			    | ({32{partial_64bit}}  & dmi_sbdata1)
			    | ({32{sel_sbdata}}	    & dmi_sbdata3);

	assign sys_write_data_128[31:0]   = wrap_wdata_0;
	assign sys_write_data_128[63:32]  = wrap_wdata_1;
    	assign sys_write_data_128[95:64]  = wrap_wdata_2;
	assign sys_write_data_128[127:96] = wrap_wdata_3;

	always @* begin
		case (sbcs_sbaccess[2:0])
		3'b000:
			case ({(dmi_sbaddress0[3] & sbcs_sbaccess128), (dmi_sbaddress0[2] & sbcs_sbaccess64), dmi_sbaddress0[1:0]})
				4'b0000: sbdata0_rd_align = {24'd0, sys_read_data_128[7:0]};
				4'b0001: sbdata0_rd_align = {24'd0, sys_read_data_128[15:8]};
				4'b0010: sbdata0_rd_align = {24'd0, sys_read_data_128[23:16]};
				4'b0011: sbdata0_rd_align = {24'd0, sys_read_data_128[31:24]};
				4'b0100: sbdata0_rd_align = {24'd0, sys_read_data_128[39:32]};
				4'b0101: sbdata0_rd_align = {24'd0, sys_read_data_128[47:40]};
				4'b0110: sbdata0_rd_align = {24'd0, sys_read_data_128[55:48]};
				4'b0111: sbdata0_rd_align = {24'd0, sys_read_data_128[63:56]};
				4'b1000: sbdata0_rd_align = {24'd0, sys_read_data_128[71:64]};
				4'b1001: sbdata0_rd_align = {24'd0, sys_read_data_128[79:72]};
				4'b1010: sbdata0_rd_align = {24'd0, sys_read_data_128[87:80]};
				4'b1011: sbdata0_rd_align = {24'd0, sys_read_data_128[95:88]};
				4'b1100: sbdata0_rd_align = {24'd0, sys_read_data_128[103:96]};
				4'b1101: sbdata0_rd_align = {24'd0, sys_read_data_128[111:104]};
				4'b1110: sbdata0_rd_align = {24'd0, sys_read_data_128[119:112]};
				4'b1111: sbdata0_rd_align = {24'd0, sys_read_data_128[127:120]};
				default: sbdata0_rd_align = 32'd0;
			endcase
		3'b001:
			case (dmi_sbaddress0[3:1])
				3'b000: sbdata0_rd_align = {16'd0, sys_read_data_128[15:0]};
				3'b001: sbdata0_rd_align = {16'd0, sys_read_data_128[31:16]};
				3'b010: sbdata0_rd_align = {16'd0, sys_read_data_128[47:32]};
				3'b011: sbdata0_rd_align = {16'd0, sys_read_data_128[63:48]};
				3'b100: sbdata0_rd_align = {16'd0, sys_read_data_128[79:64]};
				3'b101: sbdata0_rd_align = {16'd0, sys_read_data_128[95:80]};
				3'b110: sbdata0_rd_align = {16'd0, sys_read_data_128[111:96]};
				3'b111: sbdata0_rd_align = {16'd0, sys_read_data_128[127:112]};
				default: sbdata0_rd_align = 32'd0;
			endcase
		3'b010:
			case (dmi_sbaddress0[3:2])
				2'b00: sbdata0_rd_align = sys_read_data_128[31:0];
				2'b01: sbdata0_rd_align = sys_read_data_128[63:32];
				2'b10: sbdata0_rd_align = sys_read_data_128[95:64];
				2'b11: sbdata0_rd_align = sys_read_data_128[127:96];
				default: sbdata0_rd_align = 32'd0;
			endcase
		3'b011:	sbdata0_rd_align = dmi_sbaddress0[3] ? sys_read_data_128[95:64] : sys_read_data_128[31:0];
		3'b100:	sbdata0_rd_align = sys_read_data_128[31:0];
		default: sbdata0_rd_align = sys_read_data_128[31:0];
		endcase
	end

	assign sbdata0_rd_wen = sys_rdata_ready;

	assign dmi_sbdata0_nx = dmi_sbdata0_wen ? sbdata0_wd_align : sbdata0_rd_align;

        assign sbdata0_wen = (dmi_sbdata0_wen & sys_reg_acc_en) | sbdata0_rd_wen;

        assign dmi_sbcs_sbversion       = 3'd1;
        assign dmi_sbcs_sbbusyerror     = sbcs_sbbusyerror;
        assign dmi_sbcs_sbbusy          = sbcs_sbbusy;
        assign dmi_sbcs_sbreadonaddr    = sbcs_sbreadonaddr;
        assign dmi_sbcs_sbaccess        = sbcs_sbaccess;
        assign dmi_sbcs_sbautoincrement = sbcs_sbautoincrement;
        assign dmi_sbcs_sbreadondata    = sbcs_sbreadondata;
        assign dmi_sbcs_sberror         = sbcs_sberror;
        assign dmi_sbcs_sbasize         = sbcs_sbasize;
        assign dmi_sbcs_sbaccess128     = sbcs_sbaccess128;
        assign dmi_sbcs_sbaccess64      = sbcs_sbaccess64;
        assign dmi_sbcs_sbaccess32      = sbcs_sbaccess32;
        assign dmi_sbcs_sbaccess16      = sbcs_sbaccess16;
        assign dmi_sbcs_sbaccess8       = sbcs_sbaccess8;

	assign dmi_sbdata0    = reg_dmi_sbdata0;
end
else begin : gen_no_system_bus_access_ctrl
	assign dmi_sbaddress0 = 32'd0;
	assign dmi_sbaddress1 = 32'd0;
	assign dmi_sbaddress2 = 32'd0;
	assign dmi_sbaddress3 = 32'd0;
	assign dmi_sbdata0    = 32'd0;

        assign dmi_sbcs_sbversion       = 3'd0;
        assign dmi_sbcs_sbbusyerror     = 1'b0;
        assign dmi_sbcs_sbbusy          = 1'b0;
        assign dmi_sbcs_sbreadonaddr    = 1'b0;
        assign dmi_sbcs_sbaccess        = 3'd0;
        assign dmi_sbcs_sbautoincrement = 1'b0;
        assign dmi_sbcs_sbreadondata    = 1'b0;
        assign dmi_sbcs_sberror         = 3'd0;
        assign dmi_sbcs_sbasize         = 7'd0;
        assign dmi_sbcs_sbaccess128     = 1'b0;
        assign dmi_sbcs_sbaccess64      = 1'b0;
        assign dmi_sbcs_sbaccess32      = 1'b0;
        assign dmi_sbcs_sbaccess16      = 1'b0;
        assign dmi_sbcs_sbaccess8       = 1'b0;

        assign sys_mst_read_req_valid  = 1'b0;
        assign sys_mst_write_req_valid = 1'b0;
        assign sys_mst_req_size = 3'd0;
        assign sys_sbaddress_128  = 128'd0;
	assign sys_read_data_128  = 128'd0;
	assign sys_write_data_128 = 128'd0;
	assign bus_access_done    = 1'b0;
	assign sys_bus_error      = 1'b0;
	assign sys_rdata_ready    = 1'b0;
        assign sys_reg_acc_en     = 1'b0;

        wire   unused_wire = sys_mst_read_req_valid
                           | sys_mst_write_req_valid
                           | (|sys_mst_req_size)
                           | bus_access_done
                           | sys_bus_error
                           | (|sys_read_data_128)
                           | (|sys_write_data_128)
                           | (|sys_sbaddress_128)
                           | sys_rdata_ready
                           | sys_reg_acc_en;
end
endgenerate

generate
if ((SYSTEM_BUS_ACCESS_SUPPORT == "yes") && (SYS_DATA_WIDTH > 32)) begin : gen_sys_bus_dmi_sbdata1
	reg     [31:0]  reg_dmi_sbdata1;
	wire    [31:0]  dmi_sbdata1_nx;
	wire    [31:0]  sbdata1_wd_align;
	wire    [31:0]  sbdata1_rd_align;
	wire            sbdata1_wen;
	wire		sbdata1_rd_wen;

	always @(posedge clk or negedge dmi_resetn) begin
		if (!dmi_resetn) begin
			reg_dmi_sbdata1 <= 32'd0;
		end
		else if (sbdata1_wen) begin
			reg_dmi_sbdata1 <= dmi_sbdata1_nx;
		end
	end

        assign sbdata1_rd_align = dmi_sbaddress0[3] ? sys_read_data_128[127:96] : sys_read_data_128[63:32];
	assign sbdata1_wd_align = dmi_hwdata;
	assign dmi_sbdata1_nx   = dmi_sbdata1_wen ? sbdata1_wd_align : sbdata1_rd_align;
	assign sbdata1_rd_wen   = sys_rdata_ready;
	assign sbdata1_wen      = (dmi_sbdata1_wen & sys_reg_acc_en) | sbdata1_rd_wen;
        assign dmi_sbdata1      = reg_dmi_sbdata1;
end
else begin: gen_no_sys_bus_dmi_sbdata1
        assign dmi_sbdata1 = 32'd0;
end
endgenerate

generate
if ((SYSTEM_BUS_ACCESS_SUPPORT == "yes") && (SYS_DATA_WIDTH > 64)) begin : gen_sys_bus_dmi_sbdata2
	reg     [31:0]  reg_dmi_sbdata2;
	wire    [31:0]  dmi_sbdata2_nx;
	wire    [31:0]  sbdata2_wd_align;
	wire    [31:0]  sbdata2_rd_align;
	wire            sbdata2_wen;
	wire		sbdata2_rd_wen;

        always @(posedge clk or negedge dmi_resetn) begin
		if (!dmi_resetn) begin
			reg_dmi_sbdata2 <= 32'd0;
		end
		else if (sbdata2_wen) begin
			reg_dmi_sbdata2 <= dmi_sbdata2_nx;
		end
	end

	assign sbdata2_rd_align = sys_read_data_128[95:64];
        assign sbdata2_wd_align = dmi_hwdata;
	assign dmi_sbdata2_nx   = dmi_sbdata2_wen ? sbdata2_wd_align : sbdata2_rd_align;
	assign sbdata2_rd_wen   = sys_rdata_ready;
	assign sbdata2_wen      = (dmi_sbdata2_wen & sys_reg_acc_en) | sbdata2_rd_wen;
        assign dmi_sbdata2      = reg_dmi_sbdata2;
end
else begin: gen_no_sys_bus_dmi_sbdata2
        assign dmi_sbdata2 = 32'd0;
end
endgenerate

generate
if ((SYSTEM_BUS_ACCESS_SUPPORT == "yes") && (SYS_DATA_WIDTH > 96)) begin : gen_sys_bus_dmi_sbdata3
	reg     [31:0]  reg_dmi_sbdata3;
	wire    [31:0]  dmi_sbdata3_nx;
	wire    [31:0]  sbdata3_wd_align;
	wire    [31:0]  sbdata3_rd_align;
	wire		sbdata3_wen;
	wire		sbdata3_rd_wen;

	always @(posedge clk or negedge dmi_resetn) begin
		if (!dmi_resetn) begin
			reg_dmi_sbdata3 <= 32'd0;
		end
		else if (sbdata3_wen) begin
			reg_dmi_sbdata3 <= dmi_sbdata3_nx;
		end
	end

	assign sbdata3_rd_align = sys_read_data_128[127:96];
	assign sbdata3_wd_align = dmi_hwdata;
	assign dmi_sbdata3_nx   = dmi_sbdata3_wen ? sbdata3_wd_align : sbdata3_rd_align;
	assign sbdata3_rd_wen   = sys_rdata_ready;
	assign sbdata3_wen      = (dmi_sbdata3_wen & sys_reg_acc_en) | sbdata3_rd_wen;
        assign dmi_sbdata3      = reg_dmi_sbdata3;
end
else begin: gen_no_sys_bus_dmi_sbdata3
        assign dmi_sbdata3 = 32'd0;
end
endgenerate

assign dmi_read_ready     = dmi_hready;
assign dmi_hrdata_wen     = dmi_read_ready & dmi_req_valid & !dmi_hwrite;

always @(posedge clk or negedge dmi_resetn) begin
	if (!dmi_resetn) begin
		dmi_hrdata <= 32'd0;
	end
	else if (dmi_hrdata_wen) begin
		dmi_hrdata <= dmi_hrdata_nx;
	end
end
always @* begin
	case(dmi_haddr[8:2])
	DMI_ADDR_DMSTATUS:     dmi_hrdata_nx = dmi_dmstatus;
	DMI_ADDR_DMCONTROL:    dmi_hrdata_nx = dmi_dmcontrol;
	DMI_ADDR_HARTINFO:     dmi_hrdata_nx = dmi_hartinfo;
	DMI_ADDR_HALTSUM1:     dmi_hrdata_nx = dmi_haltsum1;
	DMI_ADDR_HAWINDOWSEL:  dmi_hrdata_nx = dmi_hawindowsel;
	DMI_ADDR_HAWINDOW:     dmi_hrdata_nx = dmi_hawindow;
	DMI_ADDR_ABSTRACTCS:   dmi_hrdata_nx = dmi_abstractcs;
	DMI_ADDR_COMMAND:      dmi_hrdata_nx = dmi_command;
	DMI_ADDR_ABSTRACTAUTO: dmi_hrdata_nx = dmi_abstractauto;
	DMI_ADDR_DEVTREEADDR0: dmi_hrdata_nx = dmi_devtreeaddr0;
	DMI_ADDR_DEVTREEADDR1: dmi_hrdata_nx = dmi_devtreeaddr1;
	DMI_ADDR_DEVTREEADDR2: dmi_hrdata_nx = dmi_devtreeaddr2;
	DMI_ADDR_DEVTREEADDR3: dmi_hrdata_nx = dmi_devtreeaddr3;
	DMI_ADDR_DATA0:        dmi_hrdata_nx = dmi_data0;
	DMI_ADDR_DATA1:        dmi_hrdata_nx = dmi_data1;
	DMI_ADDR_DATA2:        dmi_hrdata_nx = dmi_data2;
	DMI_ADDR_DATA3:        dmi_hrdata_nx = dmi_data3;
	DMI_ADDR_DATA4:        dmi_hrdata_nx = 32'd0;
	DMI_ADDR_DATA5:        dmi_hrdata_nx = 32'd0;
	DMI_ADDR_DATA6:        dmi_hrdata_nx = 32'd0;
	DMI_ADDR_DATA7:        dmi_hrdata_nx = 32'd0;
	DMI_ADDR_DATA8:        dmi_hrdata_nx = 32'd0;
	DMI_ADDR_DATA9:        dmi_hrdata_nx = 32'd0;
	DMI_ADDR_DATA10:       dmi_hrdata_nx = 32'd0;
	DMI_ADDR_DATA11:       dmi_hrdata_nx = 32'd0;
	DMI_ADDR_PROGBUF0:     dmi_hrdata_nx = dmi_progbuf0;
	DMI_ADDR_PROGBUF1:     dmi_hrdata_nx = dmi_progbuf1;
	DMI_ADDR_PROGBUF2:     dmi_hrdata_nx = dmi_progbuf2;
	DMI_ADDR_PROGBUF3:     dmi_hrdata_nx = dmi_progbuf3;
	DMI_ADDR_PROGBUF4:     dmi_hrdata_nx = dmi_progbuf4;
	DMI_ADDR_PROGBUF5:     dmi_hrdata_nx = dmi_progbuf5;
	DMI_ADDR_PROGBUF6:     dmi_hrdata_nx = dmi_progbuf6;
	DMI_ADDR_PROGBUF7:     dmi_hrdata_nx = dmi_progbuf7;
	DMI_ADDR_PROGBUF8:     dmi_hrdata_nx = dmi_progbuf8;
	DMI_ADDR_PROGBUF9:     dmi_hrdata_nx = dmi_progbuf9;
	DMI_ADDR_PROGBUF10:    dmi_hrdata_nx = dmi_progbuf10;
	DMI_ADDR_PROGBUF11:    dmi_hrdata_nx = dmi_progbuf11;
	DMI_ADDR_PROGBUF12:    dmi_hrdata_nx = dmi_progbuf12;
	DMI_ADDR_PROGBUF13:    dmi_hrdata_nx = dmi_progbuf13;
	DMI_ADDR_PROGBUF14:    dmi_hrdata_nx = dmi_progbuf14;
	DMI_ADDR_PROGBUF15:    dmi_hrdata_nx = dmi_progbuf15;
        DMI_ADDR_DMCS2:        dmi_hrdata_nx = dmi_dmcs2;
	DMI_ADDR_SERCS:        dmi_hrdata_nx = dmi_sercs;
	DMI_ADDR_SERTX:        dmi_hrdata_nx = dmi_sertx;
	DMI_ADDR_SERRX:        dmi_hrdata_nx = dmi_serrx;
	DMI_ADDR_SBCS:         dmi_hrdata_nx = dmi_sbcs;
	DMI_ADDR_SBADDRESS0:   dmi_hrdata_nx = dmi_sbaddress0;
	DMI_ADDR_SBADDRESS1:   dmi_hrdata_nx = dmi_sbaddress1;
	DMI_ADDR_SBADDRESS2:   dmi_hrdata_nx = dmi_sbaddress2;
	DMI_ADDR_SBADDRESS3:   dmi_hrdata_nx = dmi_sbaddress3;
	DMI_ADDR_SBDATA0:      dmi_hrdata_nx = dmi_sbdata0;
	DMI_ADDR_SBDATA1:      dmi_hrdata_nx = dmi_sbdata1;
	DMI_ADDR_SBDATA2:      dmi_hrdata_nx = dmi_sbdata2;
	DMI_ADDR_SBDATA3:      dmi_hrdata_nx = dmi_sbdata3;
        DMI_ADDR_HALTSUM0:     dmi_hrdata_nx = dmi_haltsum0;
        DMI_ADDR_CUSTOM_VERSION:        dmi_hrdata_nx = VERSION;
	default:               dmi_hrdata_nx = 32'd0;
	endcase
end

generate
genvar i_rv_hrd;
if (RV_BUS_TYPE == "ahb") begin : gen_rv_interface_ahb
	reg				rv_write_cmd_valid_dp;
	reg	[8:2]			rv_haddr_dp;
	reg	[2:0]			rv_hsize_dp;
	wire	[63:0]			rv_hwdata_64bit;
	wire	[DATA_WIDTH-1:0]	reg_rv_hrdata_nx;
	reg	[DATA_WIDTH-1:0]	reg_rv_hrdata;
	wire				hrdata_sel_high_part;

	wire				rv_req_valid;

	reg				reg_rv_hreadyout;
	wire				reg_rv_hreadyout_nx;
	wire 				rv_htrans_idle_or_busy;

	always @(posedge clk or negedge bus_resetn) begin
		if (!bus_resetn) begin
			reg_rv_hreadyout <= 1'b1;
		end
		else begin
			reg_rv_hreadyout <= reg_rv_hreadyout_nx;
		end
	end

	always @(posedge clk or negedge bus_resetn) begin
		if (!bus_resetn) begin
			rv_haddr_dp	      <= 7'd0;
			rv_hsize_dp	      <= 3'd0;
			rv_write_cmd_valid_dp <= 1'b0;
		end
		else if (rv_hready) begin
			rv_haddr_dp	      <= rv_haddr[8:2];
			rv_hsize_dp	      <= rv_hsize;
			rv_write_cmd_valid_dp <= rv_write_cmd_valid;
		end
	end

	always @(posedge clk or negedge bus_resetn) begin
		if (!bus_resetn) begin
			reg_rv_hrdata <= {DATA_WIDTH{1'b0}};
		end
		else if (rv_read_req_valid) begin
			reg_rv_hrdata <= reg_rv_hrdata_nx;
		end
	end

	assign rv_req_valid = rv_hsel & rv_htrans[1] & rv_hready;
	assign rv_write_cmd_valid = rv_req_valid & rv_hwrite;
	assign rv_write_req_valid = rv_write_cmd_valid_dp;
	assign rv_write_high_part = (rv_hsize_dp == 3'h3) | ((rv_hsize_dp <= 3'h2) &  rv_wr_addr[2]);
	assign rv_write_low_part  = (rv_hsize_dp == 3'h3) | ((rv_hsize_dp <= 3'h2) & ~rv_wr_addr[2]);

	assign rv_htrans_idle_or_busy = (rv_htrans[1]==1'b0);
	assign reg_rv_hreadyout_nx    =  rv_htrans_idle_or_busy |
				       !(rv_write_cmd_valid | serial0_tx_may_overflow | serial0_tx_will_overflow | serial0_rx_will_underflow);

	assign rv_hreadyout = reg_rv_hreadyout;

	assign hrdata_sel_high_part = (DATA_WIDTH == 32) & rv_rd_addr[2];

	for (i_rv_hrd = 0; i_rv_hrd<DATA_WIDTH; i_rv_hrd=i_rv_hrd+32) begin: gen_rv_hrdata_nx
		if (i_rv_hrd == 32) begin: gen_rv_hrdata_63_32
			assign reg_rv_hrdata_nx[(i_rv_hrd+31):i_rv_hrd] = rv_rd_data[(i_rv_hrd+31):i_rv_hrd];
		end
		else begin: gen_rv_hrdata_31_0
			assign reg_rv_hrdata_nx[(i_rv_hrd+31):i_rv_hrd] = hrdata_sel_high_part ? rv_rd_data[63:32] : rv_rd_data[31:0];
		end
	end

	assign rv_read_req_valid = rv_req_valid & !rv_hwrite;

	assign rv_hwdata_64bit[63:32] = rv_hwdata[(DATA_WIDTH-1):(DATA_WIDTH-32)];
	assign rv_hwdata_64bit[31:0]  = rv_hwdata[31:0];

	assign rv_wr_addr = rv_haddr_dp;
	assign rv_wr_data[63:32] = rv_hwdata[(DATA_WIDTH-1):(DATA_WIDTH-32)];
	assign rv_wr_data[31:0]  = rv_hwdata[31:0];
	assign rv_rd_addr = rv_haddr[8:2];

	assign rv_hrdata  = reg_rv_hrdata;
	assign rv_hresp = HRESP_OKAY;

end
endgenerate

generate
if (RV_BUS_TYPE != "ahb") begin : gen_rv_interface_axi_dummy
	assign rv_hrdata    = {DATA_WIDTH{1'b0}};
	assign rv_hreadyout = 1'b1;
	assign rv_hresp     = 2'd0;
end
endgenerate

generate
genvar i_rv_rd;
if (RV_BUS_TYPE == "axi") begin : gen_rv_interface_axi
	reg	[8:2]			reg_rv_awaddr;
	reg	[(DATA_WIDTH/8)-1:0]	reg_rv_wstrb;
	wire	[(DATA_WIDTH/8)-1:0]	selected_wstrb;
	reg				aw_ch_pending;
	reg				 w_ch_pending;
	reg				ar_ch_pending;
        wire                             b_ch_pending;

	wire 				aw_ch_taken;
	wire 				 w_ch_taken;
	wire 				 b_ch_taken;

	wire				set_aw_ch_pending;
	wire				clr_aw_ch_pending;
	wire				aw_ch_pending_nx;

	wire				set_w_ch_pending;
	wire				clr_w_ch_pending;
	wire				w_ch_pending_nx;

	wire				set_ar_ch_pending;
	wire				clr_ar_ch_pending;
	wire				ar_ch_pending_nx;

	reg	[DATA_WIDTH-1:0]	reg_rv_wdata;
	wire	[DATA_WIDTH-1:0]	reg_rv_wdata_nx;
	wire				write_taken;
	wire				valid_wstrb;

	reg				reg_rv_bvalid;
	reg	[RV_ID_WIDTH-1:0]	reg_rv_bid;
	wire	[RV_ID_WIDTH-1:0]	reg_rv_bid_nx;
	wire				set_reg_rv_bvalid;
	wire				clr_reg_rv_bvalid;
	wire				reg_rv_bvalid_nx;
	wire				bid_update;

	reg				reg_rv_rvalid;
	wire				set_reg_rv_rvalid;
	wire				clr_reg_rv_rvalid;
	wire				reg_rv_rvalid_nx;
	wire				rdata_sel_high_part;

	reg	[RV_ID_WIDTH-1:0]	reg_rv_rid;
	wire	[RV_ID_WIDTH-1:0]	reg_rv_rid_nx;
	reg	[DATA_WIDTH-1:0]	reg_rv_rdata;
	wire 	[DATA_WIDTH-1:0] 	reg_rv_rdata_nx;
	wire				rid_update;

	wire 				ar_ch_taken;
	wire 		 		r_ch_taken;

	always @(posedge clk or negedge bus_resetn) begin
		if (!bus_resetn) begin
			reg_rv_awaddr <= 7'd0;
		end
		else if (aw_ch_taken) begin
			reg_rv_awaddr <= rv_awaddr[8:2];
		end
	end

	always @(posedge clk or negedge bus_resetn) begin
		if (!bus_resetn) begin
			reg_rv_wdata <= {DATA_WIDTH{1'b0}};
			reg_rv_wstrb <= {(DATA_WIDTH/8){1'b0}};
		end
		else if (w_ch_taken) begin
			reg_rv_wdata <= reg_rv_wdata_nx;
			reg_rv_wstrb <= rv_wstrb;
		end
	end

	always @(posedge clk or negedge bus_resetn) begin
		if (!bus_resetn) begin
			reg_rv_rdata <= {DATA_WIDTH{1'b0}};
		end
		else if (ar_ch_taken) begin
			reg_rv_rdata <= reg_rv_rdata_nx;
		end
	end

	always @(posedge clk or negedge bus_resetn) begin
		if (!bus_resetn) begin
			aw_ch_pending <= 1'b0;
			 w_ch_pending <= 1'b0;
			ar_ch_pending <= 1'b0;
			reg_rv_rvalid <= 1'b0;
			reg_rv_bvalid <= 1'b0;
		end
		else begin
			aw_ch_pending <= aw_ch_pending_nx;
			 w_ch_pending <=  w_ch_pending_nx;
			ar_ch_pending <= ar_ch_pending_nx;
			reg_rv_bvalid <= reg_rv_bvalid_nx;
			reg_rv_rvalid <= reg_rv_rvalid_nx;
		end
	end

	always @(posedge clk or negedge bus_resetn) begin
		if (!bus_resetn) begin
			reg_rv_bid    <= {RV_ID_WIDTH{1'b0}};
		end
		else if (bid_update) begin
			reg_rv_bid    <= reg_rv_bid_nx;
		end
	end

	always @(posedge clk or negedge bus_resetn) begin
		if (!bus_resetn) begin
			reg_rv_rid    <= {RV_ID_WIDTH{1'b0}};
		end
		else if (rid_update) begin
			reg_rv_rid    <= reg_rv_rid_nx;
		end
	end

	assign aw_ch_taken = rv_awvalid & rv_awready;
	assign  w_ch_taken = rv_wvalid  & rv_wready;

	assign set_aw_ch_pending =  aw_ch_taken   & ~w_ch_taken & ~w_ch_pending;
	assign clr_aw_ch_pending = (aw_ch_pending &  w_ch_taken & ~aw_ch_taken) | sys_bus_reset;
	assign aw_ch_pending_nx  = set_aw_ch_pending | (aw_ch_pending & ~clr_aw_ch_pending);

	assign set_w_ch_pending =  w_ch_taken   & ~aw_ch_taken & ~aw_ch_pending;
	assign clr_w_ch_pending = (w_ch_pending &  aw_ch_taken & ~w_ch_taken) | sys_bus_reset;
	assign  w_ch_pending_nx = set_w_ch_pending | (w_ch_pending & ~clr_w_ch_pending);

	assign selected_wstrb = w_ch_pending ? reg_rv_wstrb : rv_wstrb;
	assign valid_wstrb = |selected_wstrb;
	assign write_taken = (aw_ch_taken   & w_ch_taken)   |
                             (aw_ch_taken   & w_ch_pending) |
                             (aw_ch_pending & w_ch_taken)   ;

	assign rv_write_cmd_valid = write_taken & valid_wstrb;
	assign rv_write_req_valid = write_taken & valid_wstrb;
	assign rv_write_high_part = (DATA_WIDTH == 64) & (|selected_wstrb[((DATA_WIDTH/8)-1):((DATA_WIDTH/8)-4)]);
	assign rv_write_low_part = |selected_wstrb[3:0];

	assign reg_rv_wdata_nx = rv_wdata;

	assign rv_wr_addr = aw_ch_pending ? reg_rv_awaddr : rv_awaddr[8:2];
	assign rv_wr_data[63:32] = w_ch_pending ? reg_rv_wdata[(DATA_WIDTH-1):(DATA_WIDTH-32)] : rv_wdata[(DATA_WIDTH-1):(DATA_WIDTH-32)];
	assign rv_wr_data[31:0]  = w_ch_pending ? reg_rv_wdata[31:0] : rv_wdata[31:0];

	assign rv_awready = ~aw_ch_pending & ~b_ch_pending;
	assign rv_wready  = ~w_ch_pending  & ~b_ch_pending;

	assign b_ch_taken = rv_bvalid & rv_bready;
        assign b_ch_pending = rv_bvalid;
	assign set_reg_rv_bvalid = write_taken;
	assign clr_reg_rv_bvalid = b_ch_taken | sys_bus_reset;
	assign reg_rv_bvalid_nx  = set_reg_rv_bvalid | (~clr_reg_rv_bvalid & reg_rv_bvalid);
	assign reg_rv_bid_nx = rv_awid;
	assign bid_update = aw_ch_taken;

	assign rv_bvalid = reg_rv_bvalid;
	assign rv_bid    = reg_rv_bid;
	assign rv_bresp  = NDS_ARESP_OK;


	assign ar_ch_taken = rv_arvalid & rv_arready;
	assign  r_ch_taken = rv_rvalid  & rv_rready;

	assign rv_read_req_valid = rv_arvalid & rv_arready;

	assign set_ar_ch_pending = ar_ch_taken;
	assign clr_ar_ch_pending = (r_ch_taken & ar_ch_pending) | sys_bus_reset;
	assign ar_ch_pending_nx  = set_ar_ch_pending | (ar_ch_pending & ~clr_ar_ch_pending);

	assign rv_arready = ~ar_ch_pending;

	assign set_reg_rv_rvalid = ar_ch_taken;
	assign clr_reg_rv_rvalid = r_ch_taken | sys_bus_reset;
	assign reg_rv_rvalid_nx  = set_reg_rv_rvalid | (~clr_reg_rv_rvalid & reg_rv_rvalid);

	assign rdata_sel_high_part = (DATA_WIDTH == 32) & rv_araddr[2];

	for (i_rv_rd = 0; i_rv_rd<DATA_WIDTH; i_rv_rd=i_rv_rd+32) begin: gen_rv_rdata_nx
		if (i_rv_rd == 32) begin: gen_rv_rdata_63_32
			assign reg_rv_rdata_nx[(i_rv_rd+31):i_rv_rd] = rv_rd_data[(i_rv_rd+31):i_rv_rd];
		end
		else begin: gen_rv_rdata_31_0
			assign reg_rv_rdata_nx[(i_rv_rd+31):i_rv_rd] = rdata_sel_high_part ? rv_rd_data[63:32] : rv_rd_data[31:0];
		end
	end

	assign rid_update    = ar_ch_taken;
	assign reg_rv_rid_nx = rv_arid;

	assign rv_rd_addr = rv_araddr[8:2];

	assign rv_rid	 = reg_rv_rid;
	assign rv_rresp  = NDS_ARESP_OK;
	assign rv_rdata  = reg_rv_rdata;
	assign rv_rvalid = reg_rv_rvalid;
	assign rv_rlast  = 1'b1;

end
endgenerate

generate
if (RV_BUS_TYPE != "axi") begin : gen_rv_interface_ahb_dummy
	assign rv_awready = 1'b0;
	assign rv_wready  = 1'b0;
	assign rv_bid     = {RV_ID_WIDTH{1'b0}};
	assign rv_bresp   = 2'd0;
	assign rv_bvalid  = 1'b0;
	assign rv_arready = 1'b0;
	assign rv_rid     = {RV_ID_WIDTH{1'b0}};
	assign rv_rdata   = {DATA_WIDTH{1'b0}};
	assign rv_rresp   = 2'd0;
	assign rv_rlast   = 1'd0;
	assign rv_rvalid  = 1'd0;
end
endgenerate



generate
if (DATA_WIDTH == 64) begin: gen_write_enable_for_64bit_bus
	assign rv_progbuf0_wen = rv_write_req_valid & ( rv_wr_addr             == RV_ADDR_PROGBUF0) &  rv_write_low_part;
	assign rv_progbuf1_wen = rv_write_req_valid & ({rv_wr_addr[8:3], 1'b0} == RV_ADDR_PROGBUF0) & (rv_wr_addr[2] | rv_write_high_part);
	assign rv_progbuf2_wen = rv_write_req_valid & ( rv_wr_addr             == RV_ADDR_PROGBUF2) &  rv_write_low_part;
	assign rv_progbuf3_wen = rv_write_req_valid & ({rv_wr_addr[8:3], 1'b0} == RV_ADDR_PROGBUF2) & (rv_wr_addr[2] | rv_write_high_part);
	assign rv_progbuf4_wen = rv_write_req_valid & ( rv_wr_addr             == RV_ADDR_PROGBUF4) &  rv_write_low_part;
	assign rv_progbuf5_wen = rv_write_req_valid & ({rv_wr_addr[8:3], 1'b0} == RV_ADDR_PROGBUF4) & (rv_wr_addr[2] | rv_write_high_part);
	assign rv_progbuf6_wen = rv_write_req_valid & ( rv_wr_addr             == RV_ADDR_PROGBUF6) &  rv_write_low_part;
	assign rv_progbuf7_wen = rv_write_req_valid & ({rv_wr_addr[8:3], 1'b0} == RV_ADDR_PROGBUF6) & (rv_wr_addr[2] | rv_write_high_part);
	assign rv_progbuf8_wen = rv_write_req_valid & ( rv_wr_addr             == RV_ADDR_PROGBUF8) &  rv_write_low_part;
	assign rv_progbuf9_wen = rv_write_req_valid & ({rv_wr_addr[8:3], 1'b0} == RV_ADDR_PROGBUF8) & (rv_wr_addr[2] | rv_write_high_part);
	assign rv_progbuf10_wen = rv_write_req_valid & ( rv_wr_addr             == RV_ADDR_PROGBUF10) &  rv_write_low_part;
	assign rv_progbuf11_wen = rv_write_req_valid & ({rv_wr_addr[8:3], 1'b0} == RV_ADDR_PROGBUF10) & (rv_wr_addr[2] | rv_write_high_part);
	assign rv_progbuf12_wen = rv_write_req_valid & ( rv_wr_addr             == RV_ADDR_PROGBUF12) &  rv_write_low_part;
	assign rv_progbuf13_wen = rv_write_req_valid & ({rv_wr_addr[8:3], 1'b0} == RV_ADDR_PROGBUF12) & (rv_wr_addr[2] | rv_write_high_part);
	assign rv_progbuf14_wen = rv_write_req_valid & ( rv_wr_addr             == RV_ADDR_PROGBUF14) &  rv_write_low_part;
	assign rv_progbuf15_wen = rv_write_req_valid & ({rv_wr_addr[8:3], 1'b0} == RV_ADDR_PROGBUF14) & (rv_wr_addr[2] | rv_write_high_part);

	assign rv_data0_wen      = rv_write_req_valid & ( rv_wr_addr             == RV_ADDR_DATA0) &  rv_write_low_part;
	assign rv_data1_wen      = rv_write_req_valid & ({rv_wr_addr[8:3], 1'b0} == RV_ADDR_DATA0) & (rv_wr_addr[2] | rv_write_high_part);
	assign rv_data2_wen      = rv_write_req_valid & ( rv_wr_addr             == RV_ADDR_DATA2) &  rv_write_low_part;
	assign rv_data3_wen      = rv_write_req_valid & ({rv_wr_addr[8:3], 1'b0} == RV_ADDR_DATA2) & (rv_wr_addr[2] | rv_write_high_part);

	assign rv_cmd_wen        = rv_write_req_valid & ( rv_wr_addr             == RV_ADDR_COMMAND) &  rv_write_low_part;
	assign rv_notify_wen     = rv_write_req_valid & ({rv_wr_addr[8:3], 1'b0} == RV_ADDR_COMMAND) & (rv_wr_addr[2] | rv_write_high_part);
	assign rv_resume_wen     = rv_write_req_valid & ( rv_wr_addr             == RV_ADDR_RESUME)  &  rv_write_low_part;
	assign rv_exception_wen  = rv_write_req_valid & ({rv_wr_addr[8:3], 1'b0} == RV_ADDR_RESUME)  & (rv_wr_addr[2] | rv_write_high_part);
end
else begin: gen_write_enable_for_32bit_bus
	assign rv_progbuf0_wen = rv_write_req_valid & (rv_wr_addr == RV_ADDR_PROGBUF0);
	assign rv_progbuf1_wen = rv_write_req_valid & (rv_wr_addr == RV_ADDR_PROGBUF1);
	assign rv_progbuf2_wen = rv_write_req_valid & (rv_wr_addr == RV_ADDR_PROGBUF2);
	assign rv_progbuf3_wen = rv_write_req_valid & (rv_wr_addr == RV_ADDR_PROGBUF3);
	assign rv_progbuf4_wen = rv_write_req_valid & (rv_wr_addr == RV_ADDR_PROGBUF4);
	assign rv_progbuf5_wen = rv_write_req_valid & (rv_wr_addr == RV_ADDR_PROGBUF5);
	assign rv_progbuf6_wen = rv_write_req_valid & (rv_wr_addr == RV_ADDR_PROGBUF6);
	assign rv_progbuf7_wen = rv_write_req_valid & (rv_wr_addr == RV_ADDR_PROGBUF7);
	assign rv_progbuf8_wen = rv_write_req_valid & (rv_wr_addr == RV_ADDR_PROGBUF8);
	assign rv_progbuf9_wen = rv_write_req_valid & (rv_wr_addr == RV_ADDR_PROGBUF9);
	assign rv_progbuf10_wen = rv_write_req_valid & (rv_wr_addr == RV_ADDR_PROGBUF10);
	assign rv_progbuf11_wen = rv_write_req_valid & (rv_wr_addr == RV_ADDR_PROGBUF11);
	assign rv_progbuf12_wen = rv_write_req_valid & (rv_wr_addr == RV_ADDR_PROGBUF12);
	assign rv_progbuf13_wen = rv_write_req_valid & (rv_wr_addr == RV_ADDR_PROGBUF13);
	assign rv_progbuf14_wen = rv_write_req_valid & (rv_wr_addr == RV_ADDR_PROGBUF14);
	assign rv_progbuf15_wen = rv_write_req_valid & (rv_wr_addr == RV_ADDR_PROGBUF15);
	assign rv_data0_wen      = rv_write_req_valid & (rv_wr_addr == RV_ADDR_DATA0);
	assign rv_data1_wen      = rv_write_req_valid & (rv_wr_addr == RV_ADDR_DATA1);
	assign rv_data2_wen      = rv_write_req_valid & (rv_wr_addr == RV_ADDR_DATA2);
	assign rv_data3_wen      = rv_write_req_valid & (rv_wr_addr == RV_ADDR_DATA3);

	assign rv_cmd_wen        = rv_write_req_valid & (rv_wr_addr == RV_ADDR_COMMAND);
	assign rv_notify_wen     = rv_write_req_valid & (rv_wr_addr == RV_ADDR_NOTIFY);
	assign rv_resume_wen     = rv_write_req_valid & (rv_wr_addr == RV_ADDR_RESUME);
	assign rv_exception_wen  = rv_write_req_valid & (rv_wr_addr == RV_ADDR_EXCEPTION);
end
endgenerate

assign rv_serial0_tx_wen = rv_write_req_valid & (rv_wr_addr == RV_ADDR_SERIAL0);

assign rv_serial0_tx_wen_nx = rv_write_cmd_valid & (rv_wr_addr == RV_ADDR_SERIAL0);

assign rv_serial0_rx_ren = rv_read_req_valid & (rv_rd_addr == RV_ADDR_SERIAL0);

always @* begin
	case({rv_rd_addr[8:3], 1'b0})
	7'h00:			rv_rd_data = {32'h00c0006f,32'h0180006f};
	7'h02:			rv_rd_data = {32'h00c0006f,32'h0080006f};
	7'h04:			rv_rd_data = {32'h00c0006f,32'h18802623};
	7'h06:			rv_rd_data = {32'h7b349073,32'h7b241073};
	7'h08:			rv_rd_data = {32'hf1402473,32'h18002483};
	7'h0a:			rv_rd_data = {32'h18802223,32'h00047413 | (HARTID_MASK << 20)};
	7'h0c:			rv_rd_data = {32'h4004c493,32'h02848a63};
	7'h0e:			rv_rd_data = {32'h18002483,32'h00848c63};
	7'h10:			rv_rd_data = {32'h7b202473,32'h18802223};
	7'h12:			rv_rd_data = {32'h00100073,32'h7b3024f3};
	7'h14:			rv_rd_data = {32'h0ff0000f,32'h18802423};
	7'h16:			rv_rd_data = {32'h7b3024f3,32'h7b202473};
	7'h18:			rv_rd_data = {32'h18902023,32'h7b200073};
	7'h1a:			rv_rd_data = {32'h7b3024f3,32'h7b202473};
	7'h1c:			rv_rd_data = {32'h00100073,32'h10000067};
	RV_ADDR_PROGBUF0:	rv_rd_data = {dmi_progbuf1, dmi_progbuf0};
	RV_ADDR_PROGBUF2:	rv_rd_data = {dmi_progbuf3, dmi_progbuf2};
	RV_ADDR_PROGBUF4:	rv_rd_data = {dmi_progbuf5, dmi_progbuf4};
	RV_ADDR_PROGBUF6:	rv_rd_data = {dmi_progbuf7, dmi_progbuf6};
	RV_ADDR_PROGBUF8:	rv_rd_data = {dmi_progbuf9, dmi_progbuf8};
	RV_ADDR_PROGBUF10:	rv_rd_data = {dmi_progbuf11, dmi_progbuf10};
	RV_ADDR_PROGBUF12:	rv_rd_data = {dmi_progbuf13, dmi_progbuf12};
	RV_ADDR_PROGBUF14:	rv_rd_data = {dmi_progbuf15, dmi_progbuf14};
	RV_ADDR_DATA0:		rv_rd_data = {dmi_data1, dmi_data0};
	RV_ADDR_DATA2:		rv_rd_data = {dmi_data3, dmi_data2};
	RV_ADDR_DATA4:		rv_rd_data = 64'd0;
	RV_ADDR_DATA6:		rv_rd_data = 64'd0;

	RV_ADDR_ABSPROG0:	rv_rd_data = {abs_prog1,   abs_prog0};
	RV_ADDR_ABSPROG2:	rv_rd_data = {abs_prog3,   abs_prog2};
	RV_ADDR_ABSPROG4:	rv_rd_data = {abs_prog5,   abs_prog4};
	RV_ADDR_ABSPROG6:	rv_rd_data = {abs_prog7,   abs_prog6};
	RV_ADDR_ABSPROG8:	rv_rd_data = {abs_prog9,   abs_prog8};
	RV_ADDR_ABSPROG10:	rv_rd_data = {abs_prog11,  abs_prog10};
	RV_ADDR_ABSPROG12:	rv_rd_data = {abs_prog13,  abs_prog12};
	RV_ADDR_ABSPROG14:	rv_rd_data = {abs_prog15,  abs_prog14};
	RV_ADDR_ABSPROG16:	rv_rd_data = {abs_prog17,  abs_prog16};

	RV_ADDR_COMMAND:	rv_rd_data = {rv_notify,    rv_command};
	RV_ADDR_RESUME:		rv_rd_data = {rv_exception, rv_resume};
	RV_ADDR_SERIAL0:	rv_rd_data = {32'd0,        rv_serrx};
	default:		rv_rd_data = 64'd0;
	endcase
end

wire partially_used_wires = (|dmi_haddr) | (|rv_haddr) | (|abs_regno);

wire unused_wires = (|dmi_hprot) | (|rv_hprot) |
		    (|dmi_hsize) | (|rv_hsize) |
		    (|dmi_hburst) | (|rv_hburst) |
		    dmi_htrans[0] | rv_htrans[0] | partially_used_wires;



endmodule
