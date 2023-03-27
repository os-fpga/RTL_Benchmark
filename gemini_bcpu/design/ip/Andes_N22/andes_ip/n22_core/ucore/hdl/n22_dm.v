
// Copyright (C) 2018, Andes Technology Corp. Confidential Proprietary


module n22_dm(
		  debugint,
		  resethaltreq,
		  dmactive,
		  ndmreset,
		  clk_aon,
		  clk,
		  reset_n,
		  hart_unavail,
		  hart_halted,
		  hart_under_reset,
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
parameter NHART = 4;
parameter DTM_ADDR_WIDTH = 9;

parameter SYSTEM_BUS_ACCESS_SUPPORT = "no";
parameter RV_BUS_TYPE  = "ahb";
parameter SYS_BUS_TYPE = "ahb";
parameter RV_ID_WIDTH  = 4;
parameter SYS_ID_WIDTH = 4;

parameter SERIAL_COUNT = 0;
parameter SERIAL0      = 0;

parameter  PROGBUF_SIZE	  = 1;
localparam ABS_DATA_COUNT = 4;

output [NHART-1:0]		debugint;
output [NHART-1:0]		resethaltreq;
output				dmactive;
output				ndmreset;
input				clk_aon;
input				clk;
input				reset_n;
input [NHART-1:0]		hart_unavail;
input [NHART-1:0]		hart_halted;
input [NHART-1:0]		hart_under_reset;

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
localparam DBG_ROM_ADDR_H00 = 7'h00;
localparam DBG_ROM_ADDR_H01 = 7'h01;
localparam DBG_ROM_ADDR_H02 = 7'h02;
localparam DBG_ROM_ADDR_H03 = 7'h03;
localparam DBG_ROM_ADDR_H04 = 7'h04;
localparam DBG_ROM_ADDR_H05 = 7'h05;
localparam DBG_ROM_ADDR_H06 = 7'h06;
localparam DBG_ROM_ADDR_H07 = 7'h07;
localparam DBG_ROM_ADDR_H08 = 7'h08;
localparam DBG_ROM_ADDR_H09 = 7'h09;
localparam DBG_ROM_ADDR_H0A = 7'h0a;
localparam DBG_ROM_ADDR_H0B = 7'h0b;
localparam DBG_ROM_ADDR_H0C = 7'h0c;
localparam DBG_ROM_ADDR_H0D = 7'h0d;
localparam DBG_ROM_ADDR_H0E = 7'h0e;
localparam DBG_ROM_ADDR_H0F = 7'h0f;
localparam DBG_ROM_ADDR_H10 = 7'h10;
localparam DBG_ROM_ADDR_H11 = 7'h11;
localparam DBG_ROM_ADDR_H12 = 7'h12;
localparam DBG_ROM_ADDR_H13 = 7'h13;
localparam DBG_ROM_ADDR_H14 = 7'h14;
localparam DBG_ROM_ADDR_H15 = 7'h15;
localparam DBG_ROM_ADDR_H16 = 7'h16;
localparam DBG_ROM_ADDR_H17 = 7'h17;

localparam DBG_ROM_INST_H00 = 32'h0080006f;
localparam DBG_ROM_INST_H01 = 32'h12802623;
localparam DBG_ROM_INST_H02 = 32'h7b349073;
localparam DBG_ROM_INST_H03 = 32'h12002483;
localparam DBG_ROM_INST_H04 = 32'h00905463;
localparam DBG_ROM_INST_H05 = 32'h7b241073;
localparam DBG_ROM_INST_H06 = 32'hf1402473;
localparam DBG_ROM_INST_H07 = 32'h12802223;
localparam DBG_ROM_INST_H08 = 32'h02848263;
localparam DBG_ROM_INST_H09 = 32'h4004c493;
localparam DBG_ROM_INST_H0A = 32'h00848663;
localparam DBG_ROM_INST_H0B = 32'h12002483;
localparam DBG_ROM_INST_H0C = 32'hff1ff06f;
localparam DBG_ROM_INST_H0D = 32'h12802423;
localparam DBG_ROM_INST_H0E = 32'h7b202473;
localparam DBG_ROM_INST_H0F = 32'h7b3024f3;
localparam DBG_ROM_INST_H10 = 32'h7b200073;
localparam DBG_ROM_INST_H11 = 32'h12902023;
localparam DBG_ROM_INST_H12 = 32'h7b202473;
localparam DBG_ROM_INST_H13 = 32'h7b3024f3;
localparam DBG_ROM_INST_H14 = 32'h10000067;
localparam DBG_ROM_INST_H15 = 32'h7b3024f3;
localparam DBG_ROM_INST_H16 = 32'h7b202473;
localparam DBG_ROM_INST_H17 = 32'h00100073;


localparam DMI_ADDR_DMCONTROL    = 7'h10;
localparam DMI_ADDR_DMSTATUS     = 7'h11;
localparam DMI_ADDR_HARTINFO     = 7'h12;
localparam DMI_ADDR_HALTSUM      = 7'h13;
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

localparam DMI_ADDR_HALTREGION0  = 7'h40;
localparam DMI_ADDR_HALTREGION1  = 7'h41;
localparam DMI_ADDR_HALTREGION2  = 7'h42;
localparam DMI_ADDR_HALTREGION3  = 7'h43;
localparam DMI_ADDR_HALTREGION4  = 7'h44;
localparam DMI_ADDR_HALTREGION5  = 7'h45;
localparam DMI_ADDR_HALTREGION6  = 7'h46;
localparam DMI_ADDR_HALTREGION7  = 7'h47;
localparam DMI_ADDR_HALTREGION8  = 7'h48;
localparam DMI_ADDR_HALTREGION9  = 7'h49;
localparam DMI_ADDR_HALTREGION10  = 7'h4a;
localparam DMI_ADDR_HALTREGION11  = 7'h4b;
localparam DMI_ADDR_HALTREGION12  = 7'h4c;
localparam DMI_ADDR_HALTREGION13  = 7'h4d;
localparam DMI_ADDR_HALTREGION14  = 7'h4e;
localparam DMI_ADDR_HALTREGION15  = 7'h4f;
localparam DMI_ADDR_HALTREGION16  = 7'h50;
localparam DMI_ADDR_HALTREGION17  = 7'h51;
localparam DMI_ADDR_HALTREGION18  = 7'h52;
localparam DMI_ADDR_HALTREGION19  = 7'h53;
localparam DMI_ADDR_HALTREGION20  = 7'h54;
localparam DMI_ADDR_HALTREGION21  = 7'h55;
localparam DMI_ADDR_HALTREGION22  = 7'h56;
localparam DMI_ADDR_HALTREGION23  = 7'h57;
localparam DMI_ADDR_HALTREGION24  = 7'h58;
localparam DMI_ADDR_HALTREGION25  = 7'h59;
localparam DMI_ADDR_HALTREGION26  = 7'h5a;
localparam DMI_ADDR_HALTREGION27  = 7'h5b;
localparam DMI_ADDR_HALTREGION28  = 7'h5c;
localparam DMI_ADDR_HALTREGION29  = 7'h5d;
localparam DMI_ADDR_HALTREGION30  = 7'h5e;
localparam DMI_ADDR_HALTREGION31  = 7'h5f;
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

localparam ABS_MEM_ACCESS_0             = 32'h7b241073;
localparam ABS_MEM_ACCESS_1             = 32'h7b349073;
localparam ABS_MEM_ACCESS_2_32          = 32'h0c402403;
localparam ABS_MEM_ACCESS_2_64          = 32'h0c803403;
localparam ABS_MEM_ACCESS_3_LD          = 32'h00040483;
localparam ABS_MEM_ACCESS_3_ST          = 32'h0c000483;
localparam ABS_MEM_ACCESS_4_LD          = 32'h0c900023;
localparam ABS_MEM_ACCESS_4_ST          = 32'h00940023;
localparam ABS_MEM_ACCESS_5             = 32'h05400067;
localparam ABS_MEM_ACCESS_POSTINCR_5    = 32'h00040413;
localparam ABS_MEM_ACCESS_POSTINCR_6_32 = 32'h0c802223;
localparam ABS_MEM_ACCESS_POSTINCR_6_64 = 32'h0c803423;
localparam ABS_MEM_ACCESS_POSTINCR_7    = 32'h05400067;

localparam INSN_NOP  = 32'h00000023;

localparam ABS_SIZE_32   = 3'd2;

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

localparam RV_ADDR_COMMAND	= 7'h48;
localparam RV_ADDR_NOTIFY	= 7'h49;
localparam RV_ADDR_RESUME	= 7'h4a;
localparam RV_ADDR_EXCEPTION	= 7'h4b;
localparam RV_ADDR_SERIAL0	= 7'h4e;

localparam INSN_EBREAK	= 32'h00100073;

localparam ABS_STATE_IDLE    = 3'b000;
localparam ABS_STATE_CHECK   = 3'b001;
localparam ABS_STATE_CMD     = 3'b011;
localparam ABS_STATE_EXE     = 3'b010;
localparam ABS_STATE_RESUME  = 3'b110;

localparam NDS_HRESP_ERROR       = 2'b01;
localparam NDS_ARESP_OK		 = 2'b00;
localparam NDS_ARESP_SLVERR      = 2'b10;
localparam NDS_ARESP_DECERR      = 2'b11;
localparam NDS_ABURST_FIXED      = 2'b00;
localparam NDS_ALOCK_NORMAL      = 1'b0;
localparam NDS_ALOCK_EXCLUSIVE   = 1'b1;
localparam NDS_HBURST_SINGLE     = 3'b000;

wire		s0;

reg	   [NHART-1:0] s1;
reg	   [NHART-1:0] s2;
reg	   [NHART-1:0] s3;
reg	   [NHART-1:0] s4;
reg	   [NHART-1:0] s5;
reg	   [NHART-1:0] s6;

wire        s7;

wire [31:0] s8;
wire [31:0] s9;
wire [31:0] s10;
wire [31:0] s11;
wire [31:0] s12;
wire [31:0] s13;
wire [31:0] s14;
reg  [31:0] s15;
wire [31:0] s16;
wire [11:0] s17;
wire [15:0] s18;

reg  [2:0] s19;
wire [2:0] s20;
wire       s21;

wire [31:0] s22;
wire [31:0] s23;
wire [31:0] s24;
wire [31:0] s25;

reg  [31:0] s26;
reg  [31:0] s27;
reg  [31:0] s28;
reg  [31:0] s29;


wire [31:0] s30;
wire [31:0] s31;
wire [31:0] s32;
wire [31:0] s33;
wire [31:0] s34;
wire [31:0] s35;
wire [31:0] s36;
wire [31:0] s37;
wire [31:0] s38;
wire [31:0] s39;
wire [31:0] s40;
wire [31:0] s41;
wire [31:0] s42;
wire [31:0] s43;
wire [31:0] s44;
wire [31:0] s45;

wire [31:0] s46;
wire [31:0] s47;
wire [31:0] s48;
wire        s49;
wire        s50;
wire        s51;

wire        s52;
wire        s53;
wire        s54;


wire  [31:0] s55;
wire  [31:0] s56;
wire  [31:0] s57;
wire  [31:0] s58;
wire  [31:0] s59;
wire  [31:0] s60;
wire  [31:0] s61;
wire  [31:0] s62;
wire  [31:0] s63;

wire        s64;
wire        s65;
reg         s66;
wire        s67;

wire        s68;
reg	    s69;

wire [31:0] s70;

wire [31:0] s71;
wire [31:0] s72;
wire [31:0] s73;
wire [31:0] s74;

reg     [2:0] s75;
reg	[2:0] s76;
wire	[2:0] s77;
wire          s78 = s75 != ABS_STATE_IDLE;
reg     [9:0] s79;
wire [1023:0] s80 = 1024'd1 << s79;



wire [31:0] s81;
wire [31:0] s82;
wire [31:0] s83;
wire [31:0] s84;
wire [31:0] s85;
wire [31:0] s86;
wire [31:0] s87;
wire [31:0] s88;
wire [31:0] s89;
wire [31:0] s90;
wire [31:0] s91;
wire [31:0] s92;
wire [31:0] s93;
wire [31:0] s94;
wire [31:0] s95;
wire [31:0] s96;

wire [31:0] s97;

wire [31:0] s98;

reg           s99;
reg           s100;
reg     [9:0] s101;
wire [1023:0] s102 = 1024'd1 << s101;
wire [1023:0] s103;
wire [1023:0] s104;
wire [1023:0] s105;
wire [1023:0] s106;
reg           s107;
reg           s108;


wire [31:0] s109 = s103[31:0];
wire [31:0] s110 = s103[63:32];
wire [31:0] s111 = s103[95:64];
wire [31:0] s112 = s103[127:96];
wire [31:0] s113 = s103[159:128];
wire [31:0] s114 = s103[191:160];
wire [31:0] s115 = s103[223:192];
wire [31:0] s116 = s103[255:224];
wire [31:0] s117 = s103[287:256];
wire [31:0] s118 = s103[319:288];
wire [31:0] s119 = s103[351:320];
wire [31:0] s120 = s103[383:352];
wire [31:0] s121 = s103[415:384];
wire [31:0] s122 = s103[447:416];
wire [31:0] s123 = s103[479:448];
wire [31:0] s124 = s103[511:480];
wire [31:0] s125 = s103[543:512];
wire [31:0] s126 = s103[575:544];
wire [31:0] s127 = s103[607:576];
wire [31:0] s128 = s103[639:608];
wire [31:0] s129 = s103[671:640];
wire [31:0] s130 = s103[703:672];
wire [31:0] s131 = s103[735:704];
wire [31:0] s132 = s103[767:736];
wire [31:0] s133 = s103[799:768];
wire [31:0] s134 = s103[831:800];
wire [31:0] s135 = s103[863:832];
wire [31:0] s136 = s103[895:864];
wire [31:0] s137 = s103[927:896];
wire [31:0] s138 = s103[959:928];
wire [31:0] s139 = s103[991:960];
wire [31:0] s140 = s103[1023:992];
reg [31:0] dmi_hrdata;
reg [31:0] s141;
wire s142;
wire s143;

wire	[63:0]			s144;
wire	[8:2]			s145;
wire	[8:2]			s146;
reg	[63:0]			s147;
wire	[DATA_WIDTH-1:0]	rv_hrdata;

wire 		rv_hreadyout;

wire s148   = (s75 == ABS_STATE_IDLE);
wire s149  = (s75 == ABS_STATE_CHECK);
wire s150    = (s75 == ABS_STATE_CMD);
wire s151    = (s75 == ABS_STATE_EXE);
wire s152 = (s75 == ABS_STATE_RESUME);

reg	s153;
wire	s154;
wire	s155;
wire	s156;

wire	s157;
wire	s158;
wire	s159;
wire	s160;
wire	s161;

wire  [9:0] s162;
wire        s163;
wire        s164;
wire [31:0] s165 = {21'd0, s163, s162} | {s153, {31{~s164}}};
wire [31:0] s166 = 32'd0;
wire [31:0] s167 = 32'd0;
wire [31:0] s168 = 32'd0;
wire [31:0] s169;

wire        s170;
wire        s171;
wire        s172;
wire        s173;
wire        s174;
wire        s175;
wire        s176;
wire        s177;
wire        s178;
wire        s179;
wire        s180;

wire [7:0]  s181    = s15[31:24];
wire [2:0]  s182        = s15[22:20];
wire        s183    = s15[18];
wire        s184    = s15[17];
wire        s185       = s15[16];
wire [15:0] s186       = s15[15:0];
wire        s187  = s15[23];
wire [2:0]  s188     = s15[22:20];
wire        s189 = s15[19];

wire [7:0]  s190 = s70[31:24];
wire        s191      = (s181    == ABS_CMD_TYPE_REG_ACCESS);
wire        s192    = (s181    == ABS_CMD_TYPE_QUICK_ACCESS);
wire        s193 = (s190 == ABS_CMD_TYPE_QUICK_ACCESS);
wire        s194      = (s181    == ABS_CMD_TYPE_MEM_ACCESS);
wire        s195   = s191 | s192 |
                                      (s194 & !s187 & (s188 < ABS_CMD_SIZE_128));
wire        s196;
wire        s197 = s195 & s196;
wire        s198;

wire [31:0] s199;
wire [31:0] s200;
wire [31:0] s201;
wire [31:0] s202;
wire [31:0] s203;
wire [31:0] s204;
wire [31:0] s205;
wire [31:0] s206;
reg  [31:0] s207;
reg  [31:0] s208;
reg  [31:0] s209;
reg  [31:0] s210;
reg  [31:0] s211;
wire [31:0] s212;
wire [31:0] s213;
wire [31:0] s214;
wire [31:0] s215;
wire [31:0] s216;
wire [31:0] s217;
wire [31:0] s218;
wire [31:0] s219;

wire [31:0] s220 = (s182 == ABS_SIZE_32) ? ABS_WRITE_GPR_0_32 : ABS_WRITE_GPR_0_64;
wire [31:0] s221  = (s182 == ABS_SIZE_32) ? ABS_READ_GPR_0_32  : ABS_READ_GPR_0_64;
wire [31:0] s222 = (s182 == ABS_SIZE_32) ? ABS_WRITE_FPR_0_32 : ABS_WRITE_FPR_0_64;
wire [31:0] s223  = (s182 == ABS_SIZE_32) ? ABS_READ_FPR_0_32  : ABS_READ_FPR_0_64;

always @* begin
	casez({s185,s186[12],s186[5]})
	3'b00?:  s207 = ABS_READ_CSR_0;
	3'b010:  s207 = s221 | {7'd0, s186[4:0], 20'd0};
        3'b011:  s207 = s223 | {7'd0, s186[4:0], 20'd0};
	3'b10?:  s207 = ABS_WRITE_CSR_0;
	3'b110:  s207 = s220 | {20'd0, s186[4:0], 7'd0};
        3'b111:  s207 = s222 | {20'd0, s186[4:0], 7'd0};
	default: s207 = 32'hxxxxxxxx;
	endcase
end

wire [31:0] s224 = (s182 == ABS_SIZE_32) ? ABS_WRITE_CSR_1_32 : ABS_WRITE_CSR_1_64;

always @* begin
	casez({s185,s186[12],s186[5]})
	3'b00?:  s208 = ABS_READ_CSR_1 | {s186[11:0],20'd0};
	3'b010:  s208 = s183 ? ABS_J_PROGBUF0_1 : ABS_READ_GPR_1;
	3'b011:  s208 = s183 ? ABS_J_PROGBUF0_1 : ABS_READ_FPR_1;
	3'b10?:  s208 = s224;
	3'b110:  s208 = s183 ? ABS_J_PROGBUF0_1 : ABS_WRITE_GPR_1;
	3'b111:  s208 = s183 ? ABS_J_PROGBUF0_1 : ABS_WRITE_FPR_1;
	default: s208 = 32'hxxxxxxxx;
	endcase
end

wire [31:0] s225  = (s182 == ABS_SIZE_32) ? ABS_READ_CSR_2_32  : ABS_READ_CSR_2_64;

always @* begin
	casez({s185,s186[12],s186[5]})
	3'b00?:  s209 = s225;
	3'b010:  s209 = ABS_READ_GPR_2;
	3'b011:  s209 = ABS_READ_FPR_2;
	3'b10?:  s209 = ABS_WRITE_CSR_2 | {s186[11:0],20'd0};
	3'b110:  s209 = ABS_WRITE_GPR_2;
	3'b111:  s209 = ABS_WRITE_FPR_2;
	default: s209 = 32'hxxxxxxxx;
	endcase
end

always @* begin
	casez({s185,s186[12],s186[5]})
	3'b00?:  s210 = ABS_READ_CSR_3;
	3'b010:  s210 = ABS_READ_GPR_3;
	3'b011:  s210 = ABS_READ_FPR_3;
	3'b10?:  s210 = ABS_WRITE_CSR_3;
	3'b110:  s210 = ABS_WRITE_GPR_3;
	3'b111:  s210 = ABS_WRITE_FPR_3;
	default: s210 = 32'hxxxxxxxx;
	endcase
end

always @* begin
	casez({s185,s186[12],s186[5]})
	3'b00?:  s211 = s183 ? ABS_J_PROGBUF0_4 : ABS_READ_CSR_4;
	3'b010:  s211 = ABS_READ_GPR_4;
	3'b011:  s211 = ABS_READ_FPR_4;
	3'b10?:  s211 = s183 ? ABS_J_PROGBUF0_4 : ABS_WRITE_CSR_4;
	3'b110:  s211 = ABS_WRITE_GPR_4;
	3'b111:  s211 = ABS_WRITE_FPR_4;
	default: s211 = 32'hxxxxxxxx;
	endcase
end

assign s212 = ABS_MEM_ACCESS_0;
assign s213 = ABS_MEM_ACCESS_1;
assign s214 = (s188 ==  ABS_CMD_SIZE_64)? ABS_MEM_ACCESS_2_64 : ABS_MEM_ACCESS_2_32;
assign s215 = (s185)? ABS_MEM_ACCESS_3_ST | {17'd0, s188, 12'd0} :
                                            ABS_MEM_ACCESS_3_LD | {17'd0, s188, 12'd0} ;
assign s216 = (s185)? ABS_MEM_ACCESS_4_ST | {17'd0, s188, 12'd0} :
                                            ABS_MEM_ACCESS_4_LD | {17'd0, s188, 12'd0} ;
assign s217 = (s189)? (ABS_MEM_ACCESS_POSTINCR_5 | (32'h100000 << s188)) : ABS_MEM_ACCESS_5;
assign s218 = (s188 ==  ABS_CMD_SIZE_64)? ABS_MEM_ACCESS_POSTINCR_6_64 : ABS_MEM_ACCESS_POSTINCR_6_32;
assign s219 = ABS_MEM_ACCESS_POSTINCR_7;

assign s199 = s194 ? s212 :
                   s191 ? (s184 ? s207 :
	                                (s183 ? ABS_J_PROGBUF0_0 : INSN_EBREAK)) :
		                        ABS_J_PROGBUF0_0;
assign s200 = s194 ? s213 : s208;
assign s201 = s194 ? s214 : s209;
assign s202 = s194 ? s215 : s210;
assign s203 = s194 ? s216 : s211;
assign s204 = s194 ? s217 : INSN_EBREAK;
assign s205 = s194 ? s218 : INSN_EBREAK;
assign s206 = s194 ? s219 : INSN_EBREAK;

localparam HTRANS_IDLE = 2'b00;
localparam HTRANS_BUSY = 2'b01;
localparam HRESP_OKAY = 2'b00;
assign s7 = dmi_hsel & dmi_htrans[1] & dmi_hready;
reg s226;
reg s227;
reg [8:2] s228;

always @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		s226 <= 1'b0;
	end
	else if (dmi_hready) begin
		s226 <= s7;
	end
end

reg dmi_hreadyout;
wire s229;

wire s230 = (dmi_htrans[1]==1'b0);
wire s231 = s227 & s226 & !dmi_hwrite;
assign s229 = s230 | !s231;
always @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		dmi_hreadyout <= 1'b1;
	end
	else begin
		dmi_hreadyout <= s229;
	end
end

assign dmi_hresp = HRESP_OKAY;

assign s22 = 32'd0;
assign s23 = 32'd0;
assign s24 = 32'd0;
assign s25 = 32'd0;

always @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		s227 <= 1'b0;
		s228 <= 7'd0;
	end
	else if (dmi_hready) begin
		s227 <= dmi_hwrite;
		s228 <= dmi_haddr[8:2];
	end
end

assign s65    = s226 & s227 & (s228 == DMI_ADDR_DMCONTROL);
assign s67     = s226 & s227 & (s228 == DMI_ADDR_DMSTATUS);

wire   s232   = s226 & s227 & (s228 == DMI_ADDR_ABSTRACTCS);
wire   s233   = ~s78 & s232;
wire   s234      = s226 & s227 & (s228 == DMI_ADDR_COMMAND);
wire   s235      = s226 & ((s228 == DMI_ADDR_DATA0) |
                                                  (s228 == DMI_ADDR_DATA1) |
						  (s228 == DMI_ADDR_DATA2) |
						  (s228 == DMI_ADDR_DATA3) |
						  (s228 == DMI_ADDR_DATA4) |
						  (s228 == DMI_ADDR_DATA5) |
						  (s228 == DMI_ADDR_DATA6) |
						  (s228 == DMI_ADDR_DATA7) |
						  (s228 == DMI_ADDR_DATA8) |
						  (s228 == DMI_ADDR_DATA9) |
						  (s228 == DMI_ADDR_DATA10)|
						  (s228 == DMI_ADDR_DATA11));

wire   s236;
wire   s237 = s226 & s227 & (s228 == DMI_ADDR_ABSTRACTAUTO);
wire   s238 = ~s78 & s237;

wire   s239        = ~s78 & s226 & s227 & (s228 == DMI_ADDR_DATA0) | s170;
wire   s240        = ~s78 & s226 & s227 & (s228 == DMI_ADDR_DATA1) | s171;
wire   s241        = ~s78 & s226 & s227 & (s228 == DMI_ADDR_DATA2) | s172;
wire   s242        = ~s78 & s226 & s227 & (s228 == DMI_ADDR_DATA3) | s173;

assign s64 = ((s228 == DMI_ADDR_DATA0       ) & (ABS_DATA_COUNT > 0 ))
                            | ((s228 == DMI_ADDR_DATA1       ) & (ABS_DATA_COUNT > 1 ))
                            | ((s228 == DMI_ADDR_DATA2       ) & (ABS_DATA_COUNT > 2 ))
                            | ((s228 == DMI_ADDR_DATA3       ) & (ABS_DATA_COUNT > 3 ))
                            | ((s228 == DMI_ADDR_DATA4       ) & (ABS_DATA_COUNT > 4 ))
                            | ((s228 == DMI_ADDR_DATA5       ) & (ABS_DATA_COUNT > 5 ))
                            | ((s228 == DMI_ADDR_DATA6       ) & (ABS_DATA_COUNT > 6 ))
                            | ((s228 == DMI_ADDR_DATA7       ) & (ABS_DATA_COUNT > 7 ))
                            | ((s228 == DMI_ADDR_DATA8       ) & (ABS_DATA_COUNT > 8 ))
                            | ((s228 == DMI_ADDR_DATA9       ) & (ABS_DATA_COUNT > 9 ))
                            | ((s228 == DMI_ADDR_DATA10      ) & (ABS_DATA_COUNT > 10))
                            | ((s228 == DMI_ADDR_DATA11      ) & (ABS_DATA_COUNT > 11))
                            |  (s228 == DMI_ADDR_DMCONTROL   )
                            |  (s228 == DMI_ADDR_DMSTATUS    )
                            |  (s228 == DMI_ADDR_HARTINFO    )
	                    |  (s228 == DMI_ADDR_HALTSUM     )
	                    |  (s228 == DMI_ADDR_ABSTRACTCS  )
	                    |  (s228 == DMI_ADDR_COMMAND     )
	                    |  (s228 == DMI_ADDR_ABSTRACTAUTO)
	                    |  (s228 == DMI_ADDR_DEVTREEADDR0)
	                    |  (s228 == DMI_ADDR_DEVTREEADDR1)
	                    |  (s228 == DMI_ADDR_DEVTREEADDR2)
	                    |  (s228 == DMI_ADDR_DEVTREEADDR3)
	                    | ((s228 == DMI_ADDR_PROGBUF0    ) & (PROGBUF_SIZE >  0))
	                    | ((s228 == DMI_ADDR_PROGBUF1    ) & (PROGBUF_SIZE >  1))
	                    | ((s228 == DMI_ADDR_PROGBUF2    ) & (PROGBUF_SIZE >  2))
	                    | ((s228 == DMI_ADDR_PROGBUF3    ) & (PROGBUF_SIZE >  3))
	                    | ((s228 == DMI_ADDR_PROGBUF4    ) & (PROGBUF_SIZE >  4))
	                    | ((s228 == DMI_ADDR_PROGBUF5    ) & (PROGBUF_SIZE >  5))
	                    | ((s228 == DMI_ADDR_PROGBUF6    ) & (PROGBUF_SIZE >  6))
	                    | ((s228 == DMI_ADDR_PROGBUF7    ) & (PROGBUF_SIZE >  7))
	                    | ((s228 == DMI_ADDR_PROGBUF8    ) & (PROGBUF_SIZE >  8))
	                    | ((s228 == DMI_ADDR_PROGBUF9    ) & (PROGBUF_SIZE >  9))
	                    | ((s228 == DMI_ADDR_PROGBUF10   ) & (PROGBUF_SIZE > 10))
	                    | ((s228 == DMI_ADDR_PROGBUF11   ) & (PROGBUF_SIZE > 11))
	                    | ((s228 == DMI_ADDR_PROGBUF12   ) & (PROGBUF_SIZE > 12))
	                    | ((s228 == DMI_ADDR_PROGBUF13   ) & (PROGBUF_SIZE > 13))
	                    | ((s228 == DMI_ADDR_PROGBUF14   ) & (PROGBUF_SIZE > 14))
	                    | ((s228 == DMI_ADDR_PROGBUF15   ) & (PROGBUF_SIZE > 15))
			    ;

wire   s243 = s226 &
	(
		(                         (s228 == DMI_ADDR_DATA0    ) & s17[0]    ) |
		(                         (s228 == DMI_ADDR_DATA1    ) & s17[1]    ) |
		(                         (s228 == DMI_ADDR_DATA2    ) & s17[2]    ) |
		(                         (s228 == DMI_ADDR_DATA3    ) & s17[3]    ) |
		((PROGBUF_SIZE > 0 ) & (s228 == DMI_ADDR_PROGBUF0 ) & s18[0] ) |
		((PROGBUF_SIZE > 1 ) & (s228 == DMI_ADDR_PROGBUF1 ) & s18[1] ) |
		((PROGBUF_SIZE > 2 ) & (s228 == DMI_ADDR_PROGBUF2 ) & s18[2] ) |
		((PROGBUF_SIZE > 3 ) & (s228 == DMI_ADDR_PROGBUF3 ) & s18[3] ) |
		((PROGBUF_SIZE > 4 ) & (s228 == DMI_ADDR_PROGBUF4 ) & s18[4] ) |
		((PROGBUF_SIZE > 5 ) & (s228 == DMI_ADDR_PROGBUF5 ) & s18[5] ) |
		((PROGBUF_SIZE > 6 ) & (s228 == DMI_ADDR_PROGBUF6 ) & s18[6] ) |
		((PROGBUF_SIZE > 7 ) & (s228 == DMI_ADDR_PROGBUF7 ) & s18[7] ) |
		((PROGBUF_SIZE > 8 ) & (s228 == DMI_ADDR_PROGBUF8 ) & s18[8] ) |
		((PROGBUF_SIZE > 9 ) & (s228 == DMI_ADDR_PROGBUF9 ) & s18[9] ) |
		((PROGBUF_SIZE > 10) & (s228 == DMI_ADDR_PROGBUF10) & s18[10]) |
		((PROGBUF_SIZE > 11) & (s228 == DMI_ADDR_PROGBUF11) & s18[11]) |
		((PROGBUF_SIZE > 12) & (s228 == DMI_ADDR_PROGBUF12) & s18[12]) |
		((PROGBUF_SIZE > 13) & (s228 == DMI_ADDR_PROGBUF13) & s18[13]) |
		((PROGBUF_SIZE > 14) & (s228 == DMI_ADDR_PROGBUF14) & s18[14]) |
		((PROGBUF_SIZE > 15) & (s228 == DMI_ADDR_PROGBUF15) & s18[15])
	)
	& !s78 & (s19 == 3'd0);


wire   s244     = ~s78 & s226 & s227 & (s228 == DMI_ADDR_PROGBUF0);
wire   s245     = ~s78 & s226 & s227 & (s228 == DMI_ADDR_PROGBUF1);
wire   s246     = ~s78 & s226 & s227 & (s228 == DMI_ADDR_PROGBUF2);
wire   s247     = ~s78 & s226 & s227 & (s228 == DMI_ADDR_PROGBUF3);
wire   s248     = ~s78 & s226 & s227 & (s228 == DMI_ADDR_PROGBUF4);
wire   s249     = ~s78 & s226 & s227 & (s228 == DMI_ADDR_PROGBUF5);
wire   s250     = ~s78 & s226 & s227 & (s228 == DMI_ADDR_PROGBUF6);
wire   s251     = ~s78 & s226 & s227 & (s228 == DMI_ADDR_PROGBUF7);
wire   s252     = ~s78 & s226 & s227 & (s228 == DMI_ADDR_PROGBUF8);
wire   s253     = ~s78 & s226 & s227 & (s228 == DMI_ADDR_PROGBUF9);
wire   s254     = ~s78 & s226 & s227 & (s228 == DMI_ADDR_PROGBUF10);
wire   s255     = ~s78 & s226 & s227 & (s228 == DMI_ADDR_PROGBUF11);
wire   s256     = ~s78 & s226 & s227 & (s228 == DMI_ADDR_PROGBUF12);
wire   s257     = ~s78 & s226 & s227 & (s228 == DMI_ADDR_PROGBUF13);
wire   s258     = ~s78 & s226 & s227 & (s228 == DMI_ADDR_PROGBUF14);
wire   s259     = ~s78 & s226 & s227 & (s228 == DMI_ADDR_PROGBUF15);

wire   s260    = s226 & ( (s228 == DMI_ADDR_PROGBUF0)
                                                  | (s228 == DMI_ADDR_PROGBUF1)
                                                  | (s228 == DMI_ADDR_PROGBUF2)
                                                  | (s228 == DMI_ADDR_PROGBUF3)
                                                  | (s228 == DMI_ADDR_PROGBUF4)
                                                  | (s228 == DMI_ADDR_PROGBUF5)
                                                  | (s228 == DMI_ADDR_PROGBUF6)
                                                  | (s228 == DMI_ADDR_PROGBUF7)
                                                  | (s228 == DMI_ADDR_PROGBUF8)
                                                  | (s228 == DMI_ADDR_PROGBUF9)
                                                  | (s228 == DMI_ADDR_PROGBUF10)
                                                  | (s228 == DMI_ADDR_PROGBUF11)
                                                  | (s228 == DMI_ADDR_PROGBUF12)
                                                  | (s228 == DMI_ADDR_PROGBUF13)
                                                  | (s228 == DMI_ADDR_PROGBUF14)
                                                  | (s228 == DMI_ADDR_PROGBUF15)
                                                  );

wire   s261;
wire   s262;
wire   s263;
wire   s264;
wire   s265;
wire   s266;
wire   s267;
wire   s268;
wire   s269;
wire   s270;
wire   s271;
wire   s272;
wire   s273;
wire   s274;
wire   s275;
wire   s276;

wire   s277 = s244 | s261;
wire   s278 = s245 | s262;
wire   s279 = s246 | s263;
wire   s280 = s247 | s264;
wire   s281 = s248 | s265;
wire   s282 = s249 | s266;
wire   s283 = s250 | s267;
wire   s284 = s251 | s268;
wire   s285 = s252 | s269;
wire   s286 = s253 | s270;
wire   s287 = s254 | s271;
wire   s288 = s255 | s272;
wire   s289 = s256 | s273;
wire   s290 = s257 | s274;
wire   s291 = s258 | s275;
wire   s292 = s259 | s276;


wire   s293     = s226 & s227 & (s228 == DMI_ADDR_AUTHDATA);

wire   s294        = s226 & s227 & (s228 == DMI_ADDR_SERCS);
wire   s295        = s226 & s227 & (s228 == DMI_ADDR_SERRX);

wire   s296         = s226 & s227 & (s228 == DMI_ADDR_SBCS);
wire   s297   = s226 & s227 & (s228 == DMI_ADDR_SBADDRESS0);
wire   s298   = s226 & s227 & (s228 == DMI_ADDR_SBADDRESS1);
wire   s299   = s226 & s227 & (s228 == DMI_ADDR_SBADDRESS2);
wire   s300   = s226 & s227 & (s228 == DMI_ADDR_SBADDRESS3);
wire   s301      = s226 & s227 & (s228 == DMI_ADDR_SBDATA0);
wire   s302      = s226 & s227 & (s228 == DMI_ADDR_SBDATA1);
wire   s303      = s226 & s227 & (s228 == DMI_ADDR_SBDATA2);
wire   s304      = s226 & s227 & (s228 == DMI_ADDR_SBDATA3);
wire   s305      = s7    & ~dmi_hwrite   & (dmi_haddr[8:2] == DMI_ADDR_SBDATA0);

assign s68      = s65 & dmi_hwdata[28];

assign s70      = dmi_hwdata;

assign s71        = s170 ? s144[31:0] : dmi_hwdata;
assign s72        = s171 ? (s160 ? s144[DATA_WIDTH-1:DATA_WIDTH-32] : s144[31:0]) : dmi_hwdata;
assign s73        = s172 ? s144[31:0] : dmi_hwdata;
assign s74        = s173 ? (s160 ? s144[DATA_WIDTH-1:DATA_WIDTH-32] : s144[31:0]) : dmi_hwdata;


assign s81     = s261 ? s144[31:0] : dmi_hwdata;
assign s82     = s262 ? (s160 ? s144[DATA_WIDTH-1:DATA_WIDTH-32] : s144[31:0]) : dmi_hwdata;
assign s83     = s263 ? s144[31:0] : dmi_hwdata;
assign s84     = s264 ? (s160 ? s144[DATA_WIDTH-1:DATA_WIDTH-32] : s144[31:0]) : dmi_hwdata;
assign s85     = s265 ? s144[31:0] : dmi_hwdata;
assign s86     = s266 ? (s160 ? s144[DATA_WIDTH-1:DATA_WIDTH-32] : s144[31:0]) : dmi_hwdata;
assign s87     = s267 ? s144[31:0] : dmi_hwdata;
assign s88     = s268 ? (s160 ? s144[DATA_WIDTH-1:DATA_WIDTH-32] : s144[31:0]) : dmi_hwdata;

assign s89     = s269 ? s144[31:0] : dmi_hwdata;
assign s90     = s270 ? (s160 ? s144[DATA_WIDTH-1:DATA_WIDTH-32] : s144[31:0]) : dmi_hwdata;
assign s91     = s271 ? s144[31:0] : dmi_hwdata;
assign s92     = s272 ? (s160 ? s144[DATA_WIDTH-1:DATA_WIDTH-32] : s144[31:0]) : dmi_hwdata;
assign s93     = s273 ? s144[31:0] : dmi_hwdata;
assign s94     = s274 ? (s160 ? s144[DATA_WIDTH-1:DATA_WIDTH-32] : s144[31:0]) : dmi_hwdata;
assign s95     = s275 ? s144[31:0] : dmi_hwdata;
assign s96     = s276 ? (s160 ? s144[DATA_WIDTH-1:DATA_WIDTH-32] : s144[31:0]) : dmi_hwdata;


assign s97     = dmi_hwdata;

assign s98        = dmi_hwdata;

localparam DMI_VERSION_V0P13 = 4'd2;

wire       s306;
wire       s307;
wire       s308;
wire       s309;
reg        s310;
wire       s311;
reg        s312;
wire       s313;
reg        s314;
wire       s315;
reg        s316;
wire       s317;
wire       s318 = 1'b1;
wire       s319 = 1'b0;
wire       s320 = 1'b1;
wire       s321 = 1'b0;
wire [3:0] s322 = DMI_VERSION_V0P13;

reg	   [NHART-1:0] s323;
wire	   [NHART-1:0] s324;
wire	   [NHART-1:0] s325;
wire	   [NHART-1:0] s326;

reg        [NHART-1:0] debugint;
wire       [NHART-1:0] s327;
reg	   [NHART-1:0] s328;
wire	   [NHART-1:0] s329;
wire	               s330;

reg	   [NHART-1:0] s331;
wire	   [NHART-1:0] s332;
wire	               s333;

reg	   [NHART-1:0] s334;
wire	   [NHART-1:0] s335;
wire	   [NHART-1:0] s336;
wire	   [NHART-1:0] s337;

wire       [NHART-1:0] s338;


wire                   s339;
reg              [9:0] s340;
wire             [9:0] s341 = s340 + 10'd1;
wire             [9:0] s342;
wire                   s343;

always @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		s1 <= {NHART{1'b0}};
		s2 <= {NHART{1'b0}};
	end
	else begin
		s1 <= hart_unavail;
		s2 <= s1;
	end
end

always @(posedge clk_aon or negedge reset_n) begin
	if (!reset_n) begin
		s5 <= {NHART{1'b0}};
		s6 <= {NHART{1'b0}};
	end
	else begin
		s5 <= hart_under_reset;
		s6 <= s5;
	end
end

always @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		s3 <= {NHART{1'b0}};
		s4 <= {NHART{1'b0}};
	end
	else begin
		s3 <= hart_halted;
		s4 <= s3;
	end
end

always @(posedge clk_aon or negedge reset_n) begin
	if (!reset_n) begin
		s323 <= {NHART{1'b0}};
	end
	else begin
		s323 <= s324;
	end
end

assign s103[NHART-1:0]  = s4[NHART-1:0];
assign s104[NHART-1:0] = s2[NHART-1:0];
assign s105[NHART-1:0] = s323[NHART-1:0];
assign s106[NHART-1:0] = s334[NHART-1:0];

generate
if (NHART < 1024) begin : gen_dmi_hart_hardwired
	assign s103[1023:NHART]    = {(1024-NHART){1'b0}};
	assign s104[1023:NHART]   = {(1024-NHART){1'b0}};
	assign s105[1023:NHART] = {(1024-NHART){1'b0}};
	assign s106[1023:NHART] = {(1024-NHART){1'b0}};
end
endgenerate

wire   s344   = |s2;

assign s324  = s326 | (~s325 & s323);
assign s326 = s6;
assign s325 = {NHART{s69}} &  s102[NHART-1:0];

assign s307  = s306;
assign s309   = s308;
assign s311 = s310;
assign s313     = s312;
assign s315     = s314;
assign s317      = s316;

assign s306      = s105[s101];
assign s308      = s106[s101];
wire   s345 = (s101 >= NHART[9:0]);
wire   s346     = s104[s101];
wire   s347     = ~s103[s101];
wire   s348      =  s103[s101];

always @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		s310 <= 1'b0;
	end
	else begin
		s310 <= s345;
	end
end

always @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		s312 <= 1'b0;
	end
	else begin
		s312 <= s346;
	end
end

always @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		s314 <= 1'b0;
	end
	else begin
		s314 <= s347;
	end
end

always @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		s316 <= 1'b0;
	end
	else begin
		s316 <= s348;
	end
end

assign s8[31:27] = 5'd0;
assign s8[26:24] = 3'd0;
assign s8[23]    = 1'd0;
assign s8[22]    = 1'b1;
assign s8[21:20] = 2'd0;
assign s8[19]    = s306;
assign s8[18]    = s307;
assign s8[17]    = s308;
assign s8[16]    = s309;
assign s8[15]    = s310;
assign s8[14]    = s311;
assign s8[13]    = s312;
assign s8[12]    = s313;
assign s8[11]    = s314;
assign s8[10]    = s315;
assign s8[9]     = s316;
assign s8[8]     = s317;
assign s8[7]     = s318;
assign s8[6]     = s319;
assign s8[5]     = s320;
assign s8[4]     = s321;
assign s8[3:0]   = s322;


assign s9[31]    = 1'b0;
assign s9[30]    = 1'b0;
assign s9[29]    = 1'b0;
assign s9[28]    = 1'b0;
assign s9[27]    = 1'b0;
assign s9[26]    = 1'b0;
assign s9[25:16] = s101;
assign s9[15:2]  = 14'd0;
assign s9[1]     = s107;
assign s9[0]     = s108;

assign dmactive = s108;
assign ndmreset = s107;

reg			s349;
wire			s350;
reg			s351;
wire			s352;
reg        [NHART-1:0]	resethaltreq;
wire       [NHART-1:0]	s353;

assign s353 =   ({NHART{s349}} & s102[NHART-1:0])
		       | (~({NHART{s351}} & s102[NHART-1:0]) & resethaltreq);

assign s350 = dmi_hwdata[3] & s65;
assign s352 = dmi_hwdata[2] & s65;

always @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		resethaltreq	    <= {NHART{1'b0}};
		s349 <= 1'b0;
		s351 <= 1'b0;
	end
	else begin
		resethaltreq	    <= s353;
		s349 <= s350;
		s351 <= s352;
	end
end

always @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		s108  <=  1'b0;
	end
	else if (s65) begin
		s108  <= dmi_hwdata[0];
	end
end

always @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		s99   <=  1'b0;
		s100 <=  1'b0;
		s101   <= 10'd0;
		s107  <=  1'b0;
	end
	else if (s65) begin
		s99   <= dmi_hwdata[31] & dmi_hwdata[0];
		s100 <= dmi_hwdata[30] & dmi_hwdata[0];
		s101   <= dmi_hwdata[25:16] & {10{dmi_hwdata[0]}};
		s107  <= dmi_hwdata[1] & dmi_hwdata[0];
	end
end


always @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		s69 <= 1'b0;
	end
	else begin
		s69 <= s68;
	end
end

always @(posedge clk or negedge reset_n) begin
	if (!reset_n)
		s66 <= 1'b0;
	else
		s66 <= s65;
end

always @(posedge clk or negedge reset_n) begin
	if (!reset_n)
		s328   <= {NHART{1'b0}};
	else if (s330)
		s328   <= s329;
end

always @(posedge clk or negedge reset_n) begin
	if (!reset_n)
		s331 <= {NHART{1'b0}};
	else if (s333)
		s331 <= s332;
end

always @(posedge clk or negedge reset_n) begin
	if (!reset_n)
		s334 <= {NHART{1'b1}};
	else
		s334 <= s335;
end

always @(posedge clk or negedge reset_n) begin
	if (!reset_n)
		debugint <= {NHART{1'b0}};
	else
		debugint <= s327;
end

assign s330    = s66 | ~s108;
assign s329    = ( s102[NHART-1:0] & {NHART{s99}}   & {NHART{s108}})
                          | (~s102[NHART-1:0] & s328           & {NHART{s108}})
			  ;
assign s333  = s66 | ~s108;
assign s332  = ( s102[NHART-1:0] & {NHART{s100}} & {NHART{s108}})
                          | (~s102[NHART-1:0] & s331         & {NHART{s108}})
			  ;


wire  [1023:0] s354 = 1024'd1 << s144[9:0];

assign s336 = s354[NHART-1:0] & s331[NHART-1:0] & {NHART{s176}};
assign s337 = (s102[NHART-1:0] & {NHART{s100 & s66}})
                          | {NHART{~s108}};
assign s335  = ~s337 & (s334 |  s336);

assign s327 = s328 | s338;

always @(posedge clk or negedge reset_n) begin
	if (!reset_n)
		s340 <= 10'd0;
	else if (s339)
		s340 <= s342;
end

wire [1023:0] s355;
assign s355[NHART-1:0] =  s331[NHART-1:0] & ~s328[NHART-1:0] & ~s334[NHART-1:0];

generate
if (NHART < 1024) begin : hart_resumereq_active_zero_extend
	assign s355[1023:NHART] = {(1024-NHART){1'b0}};
end
endgenerate

assign s343 = s355[s340];

assign s339 = ~s108 | (~s343 & |s355);
assign s342 = (s108 & (s341 != NHART[9:0])) ?  s341 : 10'd0;


assign s10[31:24] = 8'd0;
assign s10[23:20] = 4'd2;
assign s10[19:17] = 3'd0;
assign s10[16]    = 1'b1;
assign s10[15:12] = 4'd4;
assign s10[11:0]  = {3'b000, RV_ADDR_DATA0,2'b00};

assign s0 = |s4;
assign s11 = {31'd0,s0};

assign s12 = 32'd0;
assign s13 = 32'd0;


wire	[31:0]	s356   = PROGBUF_SIZE;
wire	[31:0]	s357 = ABS_DATA_COUNT;

assign s14[31:29] = 3'd0;
assign s14[28:24] = s356[4:0];
assign s14[23:13] = 11'd0;
assign s14[12]    = s78;
assign s14[11]    = 1'b0;
assign s14[10:8]  = s19;
assign s14[7:5]  = 3'd0;
assign s14[4:0]  = s357[4:0];

always @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		s19 <= 3'd0;
	end
	else if (!s108) begin
		s19 <= 3'd0;
	end
	else if (s21) begin
		s19 <= s20;
	end
end

always @(posedge clk or negedge reset_n) begin
	if (!reset_n)
		s75 <= ABS_STATE_IDLE;
	else
		s75 <= s77;
end
assign s77 = s107 ? ABS_STATE_IDLE : s76;

wire s358 = s176 & (s144[9:0] == s79[9:0]);
wire s359    = s175 & ((s160 ? s144[DATA_WIDTH-23:DATA_WIDTH-32] : s144[9:0]) == s79[9:0]);

always @* begin
	case (s75)
	ABS_STATE_IDLE:   s76 = (s236 | s243) ? ABS_STATE_CHECK : ABS_STATE_IDLE;
	ABS_STATE_CHECK:  s76 = s197 ? ABS_STATE_CMD : ABS_STATE_IDLE;
	ABS_STATE_CMD:    s76 = s174 ? ABS_STATE_EXE : ABS_STATE_CMD;
	ABS_STATE_EXE:    s76 = s359 ? (s192 ? ABS_STATE_RESUME : ABS_STATE_IDLE) : ABS_STATE_EXE;
	ABS_STATE_RESUME: s76 = s358 ? ABS_STATE_IDLE : ABS_STATE_RESUME;
	default:           s76 = 3'bx;
	endcase
end

assign s154 = s151 & s177;
assign s155 = s359 | s107;
assign s156  = s154 | (~s155 & s153);

always @(posedge clk) begin
	if (!s108) begin
		s153 <= 1'b0;
	end
	else begin
		s153 <= s156;
	end
end

assign s236 = s234 & !s78 & (s19 == 3'd0);
always @(posedge clk) begin
	if (!s108) begin
		s15 <= 32'd0;
		s79 <= 10'd0;
	end
	else if (s236) begin
		s15 <= s70;
		s79 <= s101;
	end
end

localparam CMDERR_NONE        = 3'd0;
localparam CMDERR_BUSY        = 3'd1;
localparam CMDERR_UNSUPPORTED = 3'd2;
localparam CMDERR_EXCEPTION   = 3'd3;
localparam CMDERR_HALTRESUME  = 3'd4;
localparam CMDERR_OTHER       = 3'd7;

wire s360        = (s234 | s243 | s235 | s260 | s232 | s237) & s78;

assign s196 = (s191   &  s198)
                          | (s192 & ~s198)
                          | (s194   &  s198);

wire s361 = s149 & ~s197;
wire s362 = s177;

wire [2:0] s363 = s19[2:0] & ~dmi_hwdata[10:8];

assign s21 = s233 | s360 | s361 | s362;
assign s20 = s233     ? s363     :
		       (s19 != 3'd0)   ? s19         :
		       s360        ? CMDERR_BUSY        :
		       s362   ? CMDERR_EXCEPTION   :
		       ~s195 ? CMDERR_UNSUPPORTED :
		       ~s196    ? CMDERR_HALTRESUME  :
						CMDERR_OTHER;

assign s338 = s80[NHART-1:0] & {NHART{(s75 == ABS_STATE_CMD) & s192}};

assign s198 = |(s4[NHART-1:0] & s80[NHART-1:0]);

assign s164   = s150 | s152 | s343;
assign s162 = (s150 | s152) ?  s79 : s340;
assign s163  = ~s150;

assign s16[11:0]  = s17;
assign s16[15:12] = 4'd0;
assign s16[31:16] = s18;

generate
if (ABS_DATA_COUNT > 0) begin : gen_autoexecdata
        reg  [ABS_DATA_COUNT-1:0] s364;
        always @(posedge clk) begin
                if (!s108) begin
                        s364 <= {ABS_DATA_COUNT{1'b0}};
                end
                else if (s238) begin
                        s364 <= dmi_hwdata[ABS_DATA_COUNT-1:0];
                end
        end
        assign s17[ABS_DATA_COUNT-1:0]   = s364;
end
if (ABS_DATA_COUNT < 12) begin : gen_autoexecdata_harwired
	assign s17[11:ABS_DATA_COUNT] = {(12-ABS_DATA_COUNT){1'b0}};
end
endgenerate

generate
if (PROGBUF_SIZE > 0) begin : gen_autoexecprogbuf
        reg  [PROGBUF_SIZE-1:0]  s365;
        always @(posedge clk) begin
                if (!s108) begin
                        s365 <= {PROGBUF_SIZE{1'b0}};
                end
                else if (s238) begin
                        s365 <= dmi_hwdata[(PROGBUF_SIZE+16-1):16];
                end
        end
        assign s18[PROGBUF_SIZE-1:0] = s365;
end
if (PROGBUF_SIZE < 16) begin : gen_autoexecprogbuf_harwired
	assign s18[15:PROGBUF_SIZE] = {(16-PROGBUF_SIZE){1'b0}};
end
endgenerate


always @(posedge clk) begin
	if (!s108) begin
		s26 <= 32'd0;
	end
	else if (s239) begin
		s26 <= s71;
	end
end

always @(posedge clk) begin
	if (!s108) begin
		s27 <= 32'd0;
	end
	else if (s240) begin
		s27 <= s72;
	end
end

always @(posedge clk) begin
	if (!s108) begin
		s28 <= 32'd0;
	end
	else if (s241) begin
		s28 <= s73;
	end
end

always @(posedge clk) begin
	if (!s108) begin
		s29 <= 32'd0;
	end
	else if (s242) begin
		s29 <= s74;
	end
end


generate
if (PROGBUF_SIZE > 0) begin : gen_progbuf0
	reg  [31:0] s366;
	always @(posedge clk) begin
		if (!s108) begin
			s366 <= 32'd0;
		end
		else if (s277) begin
			s366 <= s81;
		end
	end
	assign s30 = s366;
end
else begin : gen_progbuf0_hardwired
	assign s30 = INSN_EBREAK;
end
endgenerate

generate
if (PROGBUF_SIZE > 1) begin : gen_progbuf1
	reg  [31:0] s367;
	always @(posedge clk) begin
		if (!s108) begin
			s367 <= 32'd0;
		end
		else if (s278) begin
			s367 <= s82;
		end
	end
	assign s31 = s367;
end
else begin : gen_progbuf1_hardwired
	assign s31 = INSN_EBREAK;
end
endgenerate

generate
if (PROGBUF_SIZE > 2) begin : gen_progbuf2
	reg  [31:0] s368;
	always @(posedge clk) begin
		if (!s108) begin
			s368 <= 32'd0;
		end
		else if (s279) begin
			s368 <= s83;
		end
	end
	assign s32 = s368;
end
else begin : gen_progbuf2_hardwired
	assign s32 = INSN_EBREAK;
end
endgenerate

generate
if (PROGBUF_SIZE > 3) begin : gen_progbuf3
	reg  [31:0] s369;
	always @(posedge clk) begin
		if (!s108) begin
			s369 <= 32'd0;
		end
		else if (s280) begin
			s369 <= s84;
		end
	end
	assign s33 = s369;
end
else begin : gen_progbuf3_hardwired
	assign s33 = INSN_EBREAK;
end
endgenerate

generate
if (PROGBUF_SIZE > 4) begin : gen_progbuf4
	reg  [31:0] s370;
	always @(posedge clk) begin
		if (!s108) begin
			s370 <= 32'd0;
		end
		else if (s281) begin
			s370 <= s85;
		end
	end
	assign s34 = s370;
end
else begin : gen_progbuf4_hardwired
	assign s34 = INSN_EBREAK;
end
endgenerate

generate
if (PROGBUF_SIZE > 5) begin : gen_progbuf5
	reg  [31:0] s371;
	always @(posedge clk) begin
		if (!s108) begin
			s371 <= 32'd0;
		end
		else if (s282) begin
			s371 <= s86;
		end
	end
	assign s35 = s371;
end
else begin : gen_progbuf5_hardwired
	assign s35 = INSN_EBREAK;
end
endgenerate

generate
if (PROGBUF_SIZE > 6) begin : gen_progbuf6
	reg  [31:0] s372;
	always @(posedge clk) begin
		if (!s108) begin
			s372 <= 32'd0;
		end
		else if (s283) begin
			s372 <= s87;
		end
	end
	assign s36 = s372;
end
else begin : gen_progbuf6_hardwired
	assign s36 = INSN_EBREAK;
end
endgenerate

generate
if (PROGBUF_SIZE > 7) begin : gen_progbuf7
	reg  [31:0] s373;
	always @(posedge clk) begin
		if (!s108) begin
			s373 <= 32'd0;
		end
		else if (s284) begin
			s373 <= s88;
		end
	end
	assign s37 = s373;
end
else begin : gen_progbuf7_hardwired
	assign s37 = INSN_EBREAK;
end
endgenerate

generate
if (PROGBUF_SIZE > 8) begin : gen_progbuf8
	reg  [31:0] s374;
	always @(posedge clk) begin
		if (!s108) begin
			s374 <= 32'd0;
		end
		else if (s285) begin
			s374 <= s89;
		end
	end
	assign s38 = s374;
end
else begin : gen_progbuf8_hardwired
	assign s38 = INSN_EBREAK;
end
endgenerate

generate
if (PROGBUF_SIZE > 9) begin : gen_progbuf9
	reg  [31:0] s375;
	always @(posedge clk) begin
		if (!s108) begin
			s375 <= 32'd0;
		end
		else if (s286) begin
			s375 <= s90;
		end
	end
	assign s39 = s375;
end
else begin : gen_progbuf9_hardwired
	assign s39 = INSN_EBREAK;
end
endgenerate

generate
if (PROGBUF_SIZE > 10) begin : gen_progbuf10
	reg  [31:0] s376;
	always @(posedge clk) begin
		if (!s108) begin
			s376 <= 32'd0;
		end
		else if (s287) begin
			s376 <= s91;
		end
	end
	assign s40 = s376;
end
else begin : gen_progbuf10_hardwired
	assign s40 = INSN_EBREAK;
end
endgenerate

generate
if (PROGBUF_SIZE > 11) begin : gen_progbuf11
	reg  [31:0] s377;
	always @(posedge clk) begin
		if (!s108) begin
			s377 <= 32'd0;
		end
		else if (s288) begin
			s377 <= s92;
		end
	end
	assign s41 = s377;
end
else begin : gen_progbuf11_hardwired
	assign s41 = INSN_EBREAK;
end
endgenerate

generate
if (PROGBUF_SIZE > 12) begin : gen_progbuf12
	reg  [31:0] s378;
	always @(posedge clk) begin
		if (!s108) begin
			s378 <= 32'd0;
		end
		else if (s289) begin
			s378 <= s93;
		end
	end
	assign s42 = s378;
end
else begin : gen_progbuf12_hardwired
	assign s42 = INSN_EBREAK;
end
endgenerate

generate
if (PROGBUF_SIZE > 13) begin : gen_progbuf13
	reg  [31:0] s379;
	always @(posedge clk) begin
		if (!s108) begin
			s379 <= 32'd0;
		end
		else if (s290) begin
			s379 <= s94;
		end
	end
	assign s43 = s379;
end
else begin : gen_progbuf13_hardwired
	assign s43 = INSN_EBREAK;
end
endgenerate

generate
if (PROGBUF_SIZE > 14) begin : gen_progbuf14
	reg  [31:0] s380;
	always @(posedge clk) begin
		if (!s108) begin
			s380 <= 32'd0;
		end
		else if (s291) begin
			s380 <= s95;
		end
	end
	assign s44 = s380;
end
else begin : gen_progbuf14_hardwired
	assign s44 = INSN_EBREAK;
end
endgenerate

generate
if (PROGBUF_SIZE > 15) begin : gen_progbuf15
	reg  [31:0] s381;
	always @(posedge clk) begin
		if (!s108) begin
			s381 <= 32'd0;
		end
		else if (s292) begin
			s381 <= s96;
		end
	end
	assign s45 = s381;
end
else begin : gen_progbuf15_hardwired
	assign s45 = INSN_EBREAK;
end
endgenerate



wire	[31:0] s382 = SERIAL_COUNT;
wire	[31:0] s383      = SERIAL0;

assign s46 = {s382[3:0],1'b0,s383[2:0],21'd0,s51,s50,s49};
assign s48 = 32'd0;



generate if (SERIAL_COUNT > 0) begin : gen_serial0
	reg  [2:0]  s384;
	reg  [2:0]  s385;
	wire        s386;
	wire        s387;
	wire        s388;
	wire        s389;
	wire        s390;
	wire        s391;
	reg  [31:0] s392[0:3];

	reg  [2:0]  s393;
	reg  [2:0]  s394;
	wire        s395;
	wire        s396;
	wire        s397;
	wire        s398;
	wire        s399;
	reg  [31:0] s400[0:3];

	reg         s401;

	wire s402  = s143 & (dmi_haddr[8:2] == DMI_ADDR_SERTX);

	wire s403 = s294 & dmi_hwdata[2];
	wire s404 = s388 | s397;
	wire s405 = ~s403 & (s404 | s401);
	always @(posedge clk) begin
		if (!s108) begin
			s401 <= 1'b0;
		end
		else begin
			s401 <= s405;
		end
	end

	wire [2:0] s406 = s384 + 3'd1;
	wire [2:0] s407 = s385 + 3'd1;

	wire [2:0] s408 = s393 + 3'd1;
	wire [2:0] s409 = s394 + 3'd1;

	assign     s389        = (s384 == s385);
	assign     s390         = (s384 == (s385 ^ 3'b100));
	assign     s391  = (s384 == (s407 ^ 3'b100));

	assign     s398 = (s393 == s394);
	assign     s399  = (s393 == (s394 ^ 3'b100));

	assign s49 = s399;
	assign s50 = !s389;

	assign s386       = s402 & !s389;
	assign s387       = s178 & !s390;
	assign s388 = s402 & s389;

	assign s395       = s179 & !s398;
	assign s396       = s295 & !s399;
	assign s397  = s295 & s399;

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			s384 <= 3'd0;
		end
		else if (s386) begin
			s384 <= s406;
		end
	end

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			s385 <= 3'd0;
		end
		else if (s387) begin
			s385 <= s407;
		end
	end

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			s393 <= 3'd0;
		end
		else if (s395) begin
			s393 <= s408;
		end
	end

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			s394 <= 3'd0;
		end
		else if (s396) begin
			s394 <= s409;
		end
	end

	assign s47 = s392[s384[1:0]];
	assign s169  = s400[s393[1:0]];

	integer s410, s411;
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			for (s410 = 0; s410 < 4; s410 = s410 + 1) begin
				s392[s410] <= 32'd0;
			end
		end
		else if (s387) begin
			s392[s385[1:0]] <= s144[31:0];
		end
	end
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			for (s411 = 0; s411 < 4; s411 = s411 + 1) begin
				s400[s411] <= 32'd0;
			end
		end
		else if (s396) begin
			s400[s394[1:0]] <= s98;
		end
	end

	assign s51          = s401;
	assign s52   = s178    & s391;
	assign s53  = s180 & s390;
	assign s54 = s179    & s398;

end
else begin : gen_serial0_no
	assign s51 = 1'b0;
	assign s50 = 1'b0;
	assign s49 = 1'b0;

	assign s47       = 32'b0;

	assign s169        = 32'd0;

	assign s52 = 1'b0;
	assign s53 = 1'b0;
	assign s54 = 1'b0;
end
endgenerate

localparam SBCS_8BIT_SUPPORT   = ((SYSTEM_BUS_ACCESS_SUPPORT == "yes") && (SYS_DATA_WIDTH >=8));
localparam SBCS_16BIT_SUPPORT  = ((SYSTEM_BUS_ACCESS_SUPPORT == "yes") && (SYS_DATA_WIDTH >=16));
localparam SBCS_32BIT_SUPPORT  = ((SYSTEM_BUS_ACCESS_SUPPORT == "yes") && (SYS_DATA_WIDTH >=32));
localparam SBCS_64BIT_SUPPORT  = ((SYSTEM_BUS_ACCESS_SUPPORT == "yes") && (SYS_DATA_WIDTH >=64));
localparam SBCS_128BIT_SUPPORT = ((SYSTEM_BUS_ACCESS_SUPPORT == "yes") && (SYS_DATA_WIDTH >=128));
localparam SBCS_SBASIZE = (SYSTEM_BUS_ACCESS_SUPPORT == "no") ? 7'd0 : SYS_ADDR_WIDTH;

localparam SBCS_SBACCESS_8BIT   = 3'd0;
localparam SBCS_SBACCESS_16BIT  = 3'd1;
localparam SBCS_SBACCESS_32BIT  = 3'd2;
localparam SBCS_SBACCESS_64BIT  = 3'd3;
localparam SBCS_SBACCESS_128BIT = 3'd4;

wire		s412;
wire		s413;
wire	[2:0]	s414;

wire		s415;
wire		s416;
wire	[127:0]	s417;
wire	[127:0]	s418;
wire	[127:0]	s419;
wire		s420;
wire		s421;
wire		s422;
wire		s423;
wire		s424;
wire		s425;
wire		s426;

assign s412    = s55[20];
assign s413    = s55[15];
assign s414	 = s55[19:17];
assign s423	 = s413 & s305;
assign s422	 = s412 & s297;
assign s424	 = s301 & ~s426;
assign s425	 = (s423 | s422) & ~s426;
assign s426	 = (|s55[14:12]) | s55[22];

assign s419  = {s59, s58, s57, s56};

generate
if (SYSTEM_BUS_ACCESS_SUPPORT == "no") begin : gen_no_sys_bus_surrpot
	assign s417  = 128'd0;
	assign s418 = 128'd0;
	assign s415    = 1'b0;
	assign s416      = 1'b0;
	assign s420    = 1'b0;
	assign s421	  = 1'b0;
end
endgenerate

genvar i_aw, i_w, i_ar, i_r, i_hr, i_ha, i_hw, i_hr_w, i_r_w;
generate
if ((SYSTEM_BUS_ACCESS_SUPPORT == "yes") && (SYS_BUS_TYPE == "axi")) begin : gen_sys_bus_axi_mst
	wire		s427;
	wire		s428;
	wire		s429;
	wire		s430;
	wire		s431;

	wire	[1:0]	s432;

	reg		s433;
	wire		s434;
	wire		s435;
	wire		s436;

	reg		s437;
	wire		s438;
	wire		s439;
	wire		s440;
	reg	[15:0]	s441;
	reg	[15:0]	s442;
	reg	[15:0]	s443;

	reg		s444;
	wire		s445;
	wire		s446;
	wire		s447;

	wire	[127:0] s448;

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			s433 <= 1'b0;
			s437  <= 1'b0;
			s444 <= 1'b0;
		end
		else begin
			s433 <= s436;
			s437  <= s440;
			s444 <= s447;
		end
	end

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			s441 <= 16'd0;
		end
		else if (s424) begin
			s441 <= s443;
		end
	end

	assign s427 = sys_awvalid & sys_awready;
	assign s428  = sys_wvalid  & sys_wready;
	assign s429  = sys_bvalid  & sys_bready;
	assign s430 = sys_arvalid & sys_arready;
	assign s431  = sys_rvalid  & sys_rready;

	assign s415 = s429 | s431;
	assign s432	       = ({2{s429}} & sys_bresp) | ({2{s431}} & sys_rresp);
	assign s416   = (s432 == NDS_ARESP_SLVERR) | (s432 == NDS_ARESP_DECERR);
	assign s420 = s431;
	assign s421   = s429;

	assign s434 = s424;
	assign s435 = s427 | s107;
	assign s436  = s434 | (~s435 & s433);

	for (i_aw = 0; i_aw < SYS_ADDR_WIDTH; i_aw = i_aw+32) begin: gen_sys_awaddr_by_sbaddress_128
		if ((i_aw+32) > SYS_ADDR_WIDTH) begin: gen_sys_awaddr_to_MSB
			assign sys_awaddr[SYS_ADDR_WIDTH-1:i_aw] = s419[SYS_ADDR_WIDTH-1:i_aw];
		end
		else begin: gen_sys_awaddr_32bit
			assign sys_awaddr[(i_aw+31):i_aw] = s419[(i_aw+31):i_aw];
		end
	end

	assign sys_awsize  = s414;
	assign sys_awvalid = s433;
	assign sys_awid	   = {SYS_ID_WIDTH{1'b0}};
	assign sys_awlen   = 8'd0;
	assign sys_awburst = NDS_ABURST_FIXED;
	assign sys_awlock  = NDS_ALOCK_NORMAL;
	assign sys_awcache = 4'd0;
	assign sys_awprot  = 3'd0;

	assign s438 = s424;
	assign s439 = s428 | s107;
	assign s440  = s438 | (~s439 & s437);

	for (i_w = 0; i_w < SYS_DATA_WIDTH; i_w = i_w+32) begin: gen_sys_wdata_by_write_data_128
		assign sys_wdata[(i_w+31):i_w] = s418[(i_w+31):i_w];
	end

	always @* begin
		case (s414)
		3'b000: s442 = (16'h0001 <<  s419[3:0]);
		3'b001: s442 = (16'h0003 << {s419[3:1], 1'b0});
		3'b010: s442 = (16'h000f << {s419[3:1], 1'b0});
		3'b011: s442 = (16'h00ff << {s419[3],   2'b0});
		3'b100: s442 =  16'hffff;
		default: s442 = 16'd0;
		endcase
	end

	always @* begin
		case ({s55[4], s55[3]})
		2'b00: s443 = {12'd0, (s442[15:12] | s442[11:8] | s442[7:4] | s442[3:0])};
		2'b01: s443 = {8'd0,  (s442[15:8]  | s442[7:0])};
		2'b11: s443 =  s442;
		default: s443 = 16'd0;
		endcase
	end


	assign sys_wstrb[(SYS_DATA_WIDTH/8)-1:0] = s441[(SYS_DATA_WIDTH/8)-1:0];
	assign sys_wlast  = 1'd1;
	assign sys_wvalid = s437;

	assign sys_bready = 1'b1;

	assign s445 = s425;
	assign s446 = s430 | s107;
	assign s447  = s445 | (~s446 & s444);

	for (i_ar = 0; i_ar < SYS_ADDR_WIDTH; i_ar=i_ar+32) begin: gen_araddr_by_sys_address_128
		if ((i_ar+32) > SYS_ADDR_WIDTH) begin: gen_sys_araddr_to_MSB
			assign sys_araddr[SYS_ADDR_WIDTH-1:i_ar] = s419[SYS_ADDR_WIDTH-1:i_ar];
		end
		else begin: gen_sys_araddr_32bit
			assign sys_araddr[(i_ar+31):i_ar] = s419[(i_ar+31):i_ar];
		end
	end
	assign sys_arsize  = s414;
	assign sys_arvalid = s444;
	assign sys_arid	  = {SYS_ID_WIDTH{1'b0}};
	assign sys_arlen   = 8'd0;
	assign sys_arburst = NDS_ABURST_FIXED;
	assign sys_arlock  = NDS_ALOCK_NORMAL;
	assign sys_arcache = 4'd0;
	assign sys_arprot  = 3'd0;

	assign sys_rready = 1'b1;

	for (i_r = 0; i_r < 128; i_r=i_r+32) begin: gen_read_rdata_128_by_sys_rdata
		if (i_r < SYS_DATA_WIDTH) begin: gen_valid_rdata_from_rdata
			assign s448[(i_r+31):i_r] = sys_rdata[(i_r+31):i_r];
		end
		else begin: gen_axi_unused_rdata_by_word0
			assign s448[(i_r+31):i_r] = sys_rdata[31:0];
		end
	end
	assign s417[31:0]   = s448[31:0];
	assign s417[63:32]  = s448[63:32];
	assign s417[95:64]  = s448[95:64];
	assign s417[127:96] = (SYS_DATA_WIDTH == 64) ? s448[63:32] : s448[127:96];


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
	reg	s449;
	wire	s450;
	wire	s451;
	wire	s452;
	wire	s453;
	reg	s454;
	wire	s455;
	wire	s456;
	wire	s457;
	reg	s458;

	wire	s459;
	reg	s460;
	reg	s461;
	wire	s462;
	wire	s463;

	wire	[127:0] s464;

	always @(posedge clk or negedge reset_n) begin
		if (~reset_n) begin
			s449  <= 1'b0;
			s460       <= 1'b0;
			s461       <= 1'b0;
			s454   <= 1'b0;
			s458    <= 1'b0;
		end
		else if (sys_hready) begin
			s449  <= s453;
			s460       <= s462;
			s461       <= s463;
			s454   <= s457;
			s458    <= s454;
		end
	end

	assign s459 = s7 & dmi_hwrite & (dmi_haddr[8:2] == DMI_ADDR_SBDATA0);

	assign s415 = s461 & sys_hready;
	assign s416   = (sys_hresp == NDS_HRESP_ERROR);
	assign s420 = s461 & sys_hready & ~s458;

	assign s450 = (s459 | s425) & ~s426;
	assign s451 = s449 & sys_hgrant;
	assign s453  = s450 | (~s451 & s449);

	assign s462 = sys_hbusreq & sys_hgrant;
	assign s463 = s460;
	assign s452  = s460;

	assign s455 = s424 & sys_hbusreq;
	assign s456 = s460 & s454;
	assign s457  = s455 | (~s456 & s454);


	for (i_ha = 0; i_ha < SYS_ADDR_WIDTH; i_ha=i_ha+32) begin: gen_sys_haddr_by_sys_address_128
		if ((i_ha+32) > SYS_ADDR_WIDTH) begin: gen_haddr_to_MSB
			assign sys_haddr[SYS_ADDR_WIDTH-1:i_ha] = s419[SYS_ADDR_WIDTH-1:i_ha];
		end
		else begin: gen_haddr_32bit
			assign sys_haddr[(i_ha+31):i_ha] = s419[(i_ha+31):i_ha];
		end
	end

	for (i_hw = 0; i_hw < SYS_DATA_WIDTH; i_hw = i_hw+32) begin: gen_sys_hwdata_by_write_data_128
		assign sys_hwdata[(i_hw+31):i_hw] = s418[(i_hw+31):i_hw];
	end

	for (i_hr = 0; i_hr < 128; i_hr=i_hr+32) begin: gen_read_data_128_by_hrdata
		if (i_hr < SYS_DATA_WIDTH) begin: gen_valid_rdata_from_hrdata
			assign s464[(i_hr+31):i_hr] = sys_hrdata[(i_hr+31):i_hr];
		end
		else begin: gen_ahb_unused_rdata_by_word0
			assign s464[(i_hr+31):i_hr] = sys_hrdata[31:0];
		end
	end
	assign s417[31:0]   = s464[31:0];
	assign s417[63:32]  = s464[63:32];
	assign s417[95:64]  = s464[95:64];
	assign s417[127:96] = (SYS_DATA_WIDTH == 64) ? s464[63:32] : s464[127:96];

	assign sys_htrans  = {s452, 1'b0};
	assign sys_hwrite  = s454;
	assign sys_hsize   = s414;
	assign sys_hburst  = NDS_HBURST_SINGLE;
	assign sys_hprot   = 0;
	assign sys_hbusreq = s449;

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

generate if (SYSTEM_BUS_ACCESS_SUPPORT == "yes") begin : gen_sys_bus_ctrl
	reg  [31:0] s465;
	reg  [31:0] s466;
	reg  [31:0] s467;
	reg  [31:0] s468;
	reg  [31:0] s469;
	reg  [31:0] s470;
	reg  [31:0] s471;
	reg  [31:0] s472;

	wire [31:0] s473;
	wire [31:0] s474;
	wire [31:0] s475;
	wire [31:0] s476;
	wire [31:0] s477;
	wire [31:0] s478;
	wire [31:0] s479;
	wire [31:0] s480;
	wire [31:0] s481;
	wire [31:0] s482;
	wire [31:0] s483;
	wire [31:0] s484;
	reg  [31:0] s485;
	wire [31:0] s486;
	wire [31:0] s487;
	wire [31:0] s488;

	wire	[2:0]	s489 = 3'd1;
	reg		s490;
	reg		s491;
	reg		s492;
	reg	[2:0]	s493;
	reg		s494;
	reg		s495;
	reg	[2:0]	s496;
	wire	[6:0]	s497     = SBCS_SBASIZE;
	wire		s498 = SBCS_128BIT_SUPPORT;
	wire		s499  = SBCS_64BIT_SUPPORT;
	wire		s500  = SBCS_32BIT_SUPPORT;
	wire		s501  = SBCS_16BIT_SUPPORT;
	wire		s502   = SBCS_8BIT_SUPPORT;

	wire		s503;
	wire		s504;
	wire		s505;
	wire	[2:0]	s506;
	wire		s507;
	wire		s508;
	wire		s509;
	wire		s510;
	wire		s511;
	wire		s512;
	wire		s513;
	wire		s514;
	wire		s515;
	wire	[4:0]	s516;

	wire	[2:0]	s517;
	wire		s518;

	wire		s519;

	wire		s520;
	wire		s521;
	wire		s522;
	wire		s523;

	wire	[127:0]	s524;
	wire	[127:0]	s525;
	wire	[31:0]	s526;
	wire		s527;
	wire		s528;
	wire		s529;
	wire		s530;
	wire		s531;
	wire		s532;
	wire		s533;
	wire		s534;
	wire		s535;
	wire		s536;
	wire		s537;
	wire		s538;

	reg	[15:0]	s539;
	wire	[15:0]	s540;
	reg		s541;
	reg		s542;
	reg		s543;
	reg		s544;
	wire		s545;
	wire		s546;
	wire		s547;
	wire		s548;
	wire		s549;
	wire	[31:0]	s550;
	wire	[31:0]	s551;
	wire	[31:0]	s552;
	wire	[31:0]	s553;

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			s491	 <= 1'b0;
			s490 <= 1'b0;
		end
		else begin
			s491	 <= s504;
			s490 <= s503;
		end
	end

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			s496	 <= 3'd0;
		end
		else if (s518) begin
			s496	 <= s517;
		end
	end

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			s492    <= 1'b0;
			s493	     <= SBCS_SBACCESS_32BIT;
			s494 <= 1'b0;
			s495    <= 1'b0;
			s542	     <= 1'b0;
			s543	     <= 1'b0;
			s541	     <= 1'b0;
			s544	     <= 1'b0;
		end
		else if (s296) begin
			s492    <= s505;
			s493	     <= s506;
			s494 <= s507;
			s495    <= s508;
			s542	     <= s546;
			s543	     <= s547;
			s541	     <= s545;
			s544	     <= s548;
		end
	end

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			s465 <= 32'd0;
		end
		else if (s527) begin
			s465 <= s473;
		end
	end

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			s466 <= 32'd0;
		end
		else if (s528) begin
			s466 <= s474;
		end
	end

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			s467 <= 32'd0;
		end
		else if (s529) begin
			s467 <= s475;
		end
	end

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			s468 <= 32'd0;
		end
		else if (s530) begin
			s468 <= s476;
		end
	end

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			s539 <= 32'd0;
		end
		else if (s549) begin
			s539 <= s540;
		end
	end

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			s469 <= 32'd0;
		end
		else if (s531) begin
			s469 <= s477;
		end
	end

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			s470 <= 32'd0;
		end
		else if (s532) begin
			s470 <= s478;
		end
	end

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			s471 <= 32'd0;
		end
		else if (s533) begin
			s471 <= s479;
		end
	end

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			s472 <= 32'd0;
		end
		else if (s534) begin
			s472 <= s480;
		end
	end

	assign s520 = s297 & s492;
	assign s521 = s305    & s495;
	assign s522 = s301 | s520 | s521;
	assign s523 = s415;
	assign s504  = s522 | (~s523 & s491);

	assign s519 = s491 & (s520 | s521);
	assign s503     = dmi_hwdata[22]  ? 1'b0 :
					 s519 ? 1'b1 :
							   s490;
	assign s505    = dmi_hwdata[20];
	assign s506	       = dmi_hwdata[19:17];
	assign s507 = dmi_hwdata[16];
	assign s508    = dmi_hwdata[15];

	assign s516  = {s498, s499, s500, s501, s502};
	assign s509 = (dmi_hwdata[14:12] == 3'd1);
	assign s510 = s415 & s416;

	assign s511    = (s493 == SBCS_SBACCESS_16BIT) &   s56[0];
	assign s512    = (s493 == SBCS_SBACCESS_32BIT) & (|s56[1:0]);
	assign s513    = (s493 == SBCS_SBACCESS_64BIT) & (|s56[2:0]);
	assign s514 = ~s515 & (s511 | s512 | s513);
	assign s515 = ~|((5'b00001 << s493) & s516);
	assign s518 = s415 | s296;
	assign s517	= ({3{s509}} & 3'd0)
				| ({3{s510}} & 3'd2)
				| ({3{s514}} & 3'd3)
				| ({3{s515}} & 3'd4);

	assign s527 = s297 | (s494 & s415);
	assign s528 = s298 | (s494 & s415);
	assign s529 = s299 | (s494 & s415);
	assign s530 = s300 | (s494 & s415);

	assign s526 = (32'd1 << s493);
	assign s524 = {s59, s58, s57, s56};
	assign s525  = s524 + {96'd0, s526};

	assign s473 = s297 ? dmi_hwdata : s525[31:0];
	assign s474 = s298 ? dmi_hwdata : s525[63:32];
	assign s475 = s299 ? dmi_hwdata : s525[95:64];
	assign s476 = s300 ? dmi_hwdata : s525[127:96];

	assign s481 = dmi_hwdata;
	assign s482 = dmi_hwdata;
	assign s483 = dmi_hwdata;
	assign s484 = dmi_hwdata;

	assign s546  = (s506 == SBCS_SBACCESS_32BIT) & s499;
	assign s547  = (s506 == SBCS_SBACCESS_64BIT) & s498;
	assign s545 = (s506 <  SBCS_SBACCESS_32BIT);
	assign s549       = s301 & s541;
	assign s540  = s493[0] ? dmi_hwdata[15:0] : {dmi_hwdata[7:0], dmi_hwdata[7:0]};
	assign s548	 = ~(s545 | s546 | s547);

	assign s550 = ({32{ s541}} & {s539, s539})
			    | ({32{~s541}} & s469);

	assign s551 = ({32{s541}} & {s539, s539})
			    | ({32{s542}}  & s469)
			    | ({32{(s544 | s543)}} & s470);

	assign s552 = ({32{s541}} & {s539, s539})
			    | ({32{s544}}	    & s471)
			    | ({32{(s542 | s543)}} & s469);

	assign s553 = ({32{s541}} & {s539, s539})
			    | ({32{s542}}  & s469)
			    | ({32{s543}}  & s470)
			    | ({32{s544}}	    & s472);

	assign s418[31:0]   = s550;
	assign s418[63:32]  = s551;
    	assign s418[95:64]  = s552;
	assign s418[127:96] = s553;

	always @* begin
		case (s493[2:0])
		3'b000:
			case ({(s56[3] & s498), (s56[2] & s499), s56[1:0]})
				4'b0000: s485 = {24'd0, s417[7:0]};
				4'b0001: s485 = {24'd0, s417[15:8]};
				4'b0010: s485 = {24'd0, s417[23:16]};
				4'b0011: s485 = {24'd0, s417[31:24]};
				4'b0100: s485 = {24'd0, s417[39:32]};
				4'b0101: s485 = {24'd0, s417[47:40]};
				4'b0110: s485 = {24'd0, s417[55:48]};
				4'b0111: s485 = {24'd0, s417[63:56]};
				4'b1000: s485 = {24'd0, s417[71:64]};
				4'b1001: s485 = {24'd0, s417[79:72]};
				4'b1010: s485 = {24'd0, s417[87:80]};
				4'b1011: s485 = {24'd0, s417[95:88]};
				4'b1100: s485 = {24'd0, s417[103:96]};
				4'b1101: s485 = {24'd0, s417[111:104]};
				4'b1110: s485 = {24'd0, s417[119:112]};
				4'b1111: s485 = {24'd0, s417[127:120]};
				default: s485 = 32'dx;
			endcase
		3'b001:
			case (s56[3:1])
				3'b000: s485 = {16'd0, s417[15:0]};
				3'b001: s485 = {16'd0, s417[31:16]};
				3'b010: s485 = {16'd0, s417[47:32]};
				3'b011: s485 = {16'd0, s417[63:48]};
				3'b100: s485 = {16'd0, s417[79:64]};
				3'b101: s485 = {16'd0, s417[95:80]};
				3'b110: s485 = {16'd0, s417[111:96]};
				3'b111: s485 = {16'd0, s417[127:112]};
				default: s485 = 32'dx;
			endcase
		3'b010:
			case (s56[3:2])
				2'b00: s485 = s417[31:0];
				2'b01: s485 = s417[63:32];
				2'b10: s485 = s417[95:64];
				2'b11: s485 = s417[127:96];
			endcase
		3'b011:	s485 = s56[3] ? s417[95:64] : s417[31:0];
		3'b100:	s485 = s417[31:0];
		default: s485 = s417[31:0];
		endcase
	end
	assign s486 = s56[3] ? s417[127:96] : s417[63:32];
	assign s487 = s417[95:64];
	assign s488 = s417[127:96];

	assign s535 = s420;
	assign s536 = s420 & (s493 >= SBCS_SBACCESS_64BIT);
	assign s537 = s420 & (s493 >= SBCS_SBACCESS_128BIT);
	assign s538 = s420 & (s493 >= SBCS_SBACCESS_128BIT);

	assign s477 = s301 ? s481 : s485;
	assign s478 = s302 ? s482 : s486;
	assign s479 = s303 ? s483 : s487;
	assign s480 = s304 ? s484 : s488;

	assign s531 =  s301 | s535;
	assign s532 = (s302 | s536) & s499;
	assign s533 = (s303 | s537) & s498;
	assign s534 = (s304 | s538) & s498;

	assign s55 = {s489, 6'd0, s490, s491, s492, s493,
			   s494, s495, s496, s497, s498,
			   s499, s500, s501, s502};
	assign s56 = s465;
	assign s57 = s466;
	assign s58 = s467;
	assign s59 = s468;
	assign s60    = s469;
	assign s61    = s470;
	assign s62    = s471;
	assign s63    = s472;
end
else begin : gen_system_bus_access_reg_0
	assign s55       = 32'd0;
	assign s56 = 32'd0;
	assign s57 = 32'd0;
	assign s58 = 32'd0;
	assign s59 = 32'd0;
	assign s60    = 32'd0;
	assign s61    = 32'd0;
	assign s62    = 32'd0;
	assign s63    = 32'd0;
end
endgenerate


assign s142     = dmi_hready;
assign s143     = s142 & s7 & !dmi_hwrite;

always @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		dmi_hrdata <= 32'd0;
	end
	else if (s143) begin
		dmi_hrdata <= s141;
	end
end
always @* begin
	case(dmi_haddr[8:2])
	DMI_ADDR_DMSTATUS:     s141 = s8;
	DMI_ADDR_DMCONTROL:    s141 = s9;
	DMI_ADDR_HARTINFO:     s141 = s10;
	DMI_ADDR_HALTSUM:      s141 = s11;
	DMI_ADDR_HAWINDOWSEL:  s141 = s12;
	DMI_ADDR_HAWINDOW:     s141 = s13;
	DMI_ADDR_ABSTRACTCS:   s141 = s14;
	DMI_ADDR_COMMAND:      s141 = s15;
	DMI_ADDR_ABSTRACTAUTO: s141 = s16;
	DMI_ADDR_DEVTREEADDR0: s141 = s22;
	DMI_ADDR_DEVTREEADDR1: s141 = s23;
	DMI_ADDR_DEVTREEADDR2: s141 = s24;
	DMI_ADDR_DEVTREEADDR3: s141 = s25;
	DMI_ADDR_DATA0:        s141 = s26;
	DMI_ADDR_DATA1:        s141 = s27;
	DMI_ADDR_DATA2:        s141 = s28;
	DMI_ADDR_DATA3:        s141 = s29;
	DMI_ADDR_DATA4:        s141 = 32'd0;
	DMI_ADDR_DATA5:        s141 = 32'd0;
	DMI_ADDR_DATA6:        s141 = 32'd0;
	DMI_ADDR_DATA7:        s141 = 32'd0;
	DMI_ADDR_DATA8:        s141 = 32'd0;
	DMI_ADDR_DATA9:        s141 = 32'd0;
	DMI_ADDR_DATA10:       s141 = 32'd0;
	DMI_ADDR_DATA11:       s141 = 32'd0;
	DMI_ADDR_PROGBUF0:     s141 = s30;
	DMI_ADDR_PROGBUF1:     s141 = s31;
	DMI_ADDR_PROGBUF2:     s141 = s32;
	DMI_ADDR_PROGBUF3:     s141 = s33;
	DMI_ADDR_PROGBUF4:     s141 = s34;
	DMI_ADDR_PROGBUF5:     s141 = s35;
	DMI_ADDR_PROGBUF6:     s141 = s36;
	DMI_ADDR_PROGBUF7:     s141 = s37;
	DMI_ADDR_PROGBUF8:     s141 = s38;
	DMI_ADDR_PROGBUF9:     s141 = s39;
	DMI_ADDR_PROGBUF10:    s141 = s40;
	DMI_ADDR_PROGBUF11:    s141 = s41;
	DMI_ADDR_PROGBUF12:    s141 = s42;
	DMI_ADDR_PROGBUF13:    s141 = s43;
	DMI_ADDR_PROGBUF14:    s141 = s44;
	DMI_ADDR_PROGBUF15:    s141 = s45;
	DMI_ADDR_SERCS:        s141 = s46;
	DMI_ADDR_SERTX:        s141 = s47;
	DMI_ADDR_SERRX:        s141 = s48;
	DMI_ADDR_SBCS:         s141 = s55;
	DMI_ADDR_SBADDRESS0:   s141 = s56;
	DMI_ADDR_SBADDRESS1:   s141 = s57;
	DMI_ADDR_SBADDRESS2:   s141 = s58;
	DMI_ADDR_SBADDRESS3:   s141 = s59;
	DMI_ADDR_SBDATA0:      s141 = s60;
	DMI_ADDR_SBDATA1:      s141 = s61;
	DMI_ADDR_SBDATA2:      s141 = s62;
	DMI_ADDR_SBDATA3:      s141 = s63;

	DMI_ADDR_HALTREGION0:  s141 = s109;
	DMI_ADDR_HALTREGION1:  s141 = s110;
	DMI_ADDR_HALTREGION2:  s141 = s111;
	DMI_ADDR_HALTREGION3:  s141 = s112;
	DMI_ADDR_HALTREGION4:  s141 = s113;
	DMI_ADDR_HALTREGION5:  s141 = s114;
	DMI_ADDR_HALTREGION6:  s141 = s115;
	DMI_ADDR_HALTREGION7:  s141 = s116;
	DMI_ADDR_HALTREGION8:  s141 = s117;
	DMI_ADDR_HALTREGION9:  s141 = s118;
	DMI_ADDR_HALTREGION10:  s141 = s119;
	DMI_ADDR_HALTREGION11:  s141 = s120;
	DMI_ADDR_HALTREGION12:  s141 = s121;
	DMI_ADDR_HALTREGION13:  s141 = s122;
	DMI_ADDR_HALTREGION14:  s141 = s123;
	DMI_ADDR_HALTREGION15:  s141 = s124;
	DMI_ADDR_HALTREGION16:  s141 = s125;
	DMI_ADDR_HALTREGION17:  s141 = s126;
	DMI_ADDR_HALTREGION18:  s141 = s127;
	DMI_ADDR_HALTREGION19:  s141 = s128;
	DMI_ADDR_HALTREGION20:  s141 = s129;
	DMI_ADDR_HALTREGION21:  s141 = s130;
	DMI_ADDR_HALTREGION22:  s141 = s131;
	DMI_ADDR_HALTREGION23:  s141 = s132;
	DMI_ADDR_HALTREGION24:  s141 = s133;
	DMI_ADDR_HALTREGION25:  s141 = s134;
	DMI_ADDR_HALTREGION26:  s141 = s135;
	DMI_ADDR_HALTREGION27:  s141 = s136;
	DMI_ADDR_HALTREGION28:  s141 = s137;
	DMI_ADDR_HALTREGION29:  s141 = s138;
	DMI_ADDR_HALTREGION30:  s141 = s139;
	DMI_ADDR_HALTREGION31:  s141 = s140;
	default:               s141 = 32'h0;
	endcase
end

genvar i_rv_hrd;
generate
if (RV_BUS_TYPE == "ahb") begin : rv_interface_ahb
	reg				s554;
	reg	[8:2]			s555;
	reg	[2:0]			s556;
	reg				s557;
	wire	[63:0]			s558;
	wire	[DATA_WIDTH-1:0]	s559;
	reg	[DATA_WIDTH-1:0]	s560;
	wire				s561;

	wire				s562;

	reg				s563;
	wire				s564;
	wire 				s565;

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			s563 <= 1'b1;
		end
		else begin
			s563 <= s564;
		end
	end

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			s555	      <= 7'h0;
			s556	      <= 3'h0;
			s557	      <= 1'b0;
			s554 <= 1'b0;
		end
		else if (rv_hready) begin
			s555	      <= rv_haddr[8:2];
			s556	      <= rv_hsize;
			s557	      <= rv_hwrite;
			s554 <= s157;
		end
	end

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			s560 <= {DATA_WIDTH{1'b0}};
		end
		else if (s159) begin
			s560 <= s559;
		end
	end

	assign s562 = rv_hsel & rv_htrans[1] & rv_hready;
	assign s157 = s562 & rv_hwrite;
	assign s158 = s554;
	assign s160 = (s556 == 3'h3) | ((s556 == 3'h2) &  s145[2]);
	assign s161  = (s556 == 3'h3) | ((s556 == 3'h2) & ~s145[2]);

	assign s565 = (rv_htrans[1]==1'b0);
	assign s564    =  s565 |
				       !(s157 | s52 | s53 | s54);

	assign rv_hreadyout = s563;

	assign s561 = (DATA_WIDTH == 32) & s146[2];

	for (i_rv_hrd = 0; i_rv_hrd<DATA_WIDTH; i_rv_hrd=i_rv_hrd+32) begin: gen_rv_hrdata_nx
		if (i_rv_hrd == 32) begin: gen_rv_hrdata_63_32
			assign s559[(i_rv_hrd+31):i_rv_hrd] = s147[(i_rv_hrd+31):i_rv_hrd];
		end
		else begin: gen_rv_hrdata_31_0
			assign s559[(i_rv_hrd+31):i_rv_hrd] = s561 ? s147[63:32] : s147[31:0];
		end
	end

	assign s159 = s562 & !rv_hwrite;

	assign s558[63:32] = rv_hwdata[(DATA_WIDTH-1):(DATA_WIDTH-32)];
	assign s558[31:0]  = rv_hwdata[31:0];

	assign s145 = s555;
	assign s144[63:32] = rv_hwdata[(DATA_WIDTH-1):(DATA_WIDTH-32)];
	assign s144[31:0]  = rv_hwdata[31:0];
	assign s146 = rv_haddr[8:2];

	assign rv_hrdata  = s560;
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

genvar i_rv_rd;
generate
if (RV_BUS_TYPE == "axi") begin : rv_interface_axi
	reg	[8:2]			s566;
	reg	[3:0]			s567;
	reg	[(DATA_WIDTH/8)-1:0]	s568;
	wire	[(DATA_WIDTH/8)-1:0]	s569;
	reg				s570;
	reg				 s571;
	reg				s572;

	wire 				s573;
	wire 				 s574;
	wire 				 s575;

	wire				s576;
	wire				s577;
	wire				s578;

	wire				s579;
	wire				s580;
	wire				s581;

	wire				s582;
	wire				s583;
	wire				s584;

	reg	[DATA_WIDTH-1:0]	s585;
	wire	[DATA_WIDTH-1:0]	s586;
	wire				s587;
	wire				s588;

	reg				s589;
	reg	[RV_ID_WIDTH-1:0]	s590;
	wire	[RV_ID_WIDTH-1:0]	s591;
	wire				s592;
	wire				s593;
	wire				s594;
	wire				s595;

	reg				s596;
	wire				s597;
	wire				s598;
	wire				s599;
	wire				s600;

	reg	[RV_ID_WIDTH-1:0]	s601;
	wire	[RV_ID_WIDTH-1:0]	s602;
	reg	[DATA_WIDTH-1:0]	s603;
	wire 	[DATA_WIDTH-1:0] 	s604;
	wire				s605;

	wire 				s606;
	wire 		 		s607;

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			s566 <= 7'h0;
			s567   <= {RV_ID_WIDTH{1'b0}};
		end
		else if (s573) begin
			s566 <= rv_awaddr[8:2];
			s567   <= rv_awid;
		end
	end

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			s585 <= {DATA_WIDTH{1'b0}};
			s568 <= {(DATA_WIDTH/8){1'b0}};
		end
		else if (s574) begin
			s585 <= s586;
			s568 <= rv_wstrb;
		end
	end

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			s603 <= {DATA_WIDTH{1'b0}};
		end
		else if (s606) begin
			s603 <= s604;
		end
	end

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			s570 <= 1'b0;
			 s571 <= 1'b0;
			s572 <= 1'b0;
			s596 <= 1'b0;
			s589 <= 1'b0;
		end
		else begin
			s570 <= s578;
			 s571 <=  s581;
			s572 <= s584;
			s589 <= s594;
			s596 <= s599;
		end
	end

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			s590    <= {RV_ID_WIDTH{1'b0}};
		end
		else if (s595) begin
			s590    <= s591;
		end
	end

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			s601    <= {RV_ID_WIDTH{1'b0}};
		end
		else if (s605) begin
			s601    <= s602;
		end
	end

	assign s573 = rv_awvalid & rv_awready;
	assign  s574 = rv_wvalid  & rv_wready;

	assign s576 =  s573   & ~s574 & ~s571;
	assign s577 = (s570 &  s574 & ~s573) | s107;
	assign s578  = s576 | (s570 & ~s577);

	assign s579 =  s574   & ~s573 & ~s570;
	assign s580 = (s571 &  s573 & ~s574) | s107;
	assign  s581 = s579 | (s571 & ~s580);

	assign s569 = s571 ? s568 : rv_wstrb;
	assign s588 = |s569;
	assign s587  = (s573 & s574) | (s574 & s570) | (s573 & s571);
	assign s157 = s587 & s588;
	assign s158 = s587 & s588;
	assign s160 = (DATA_WIDTH == 64) & (&s569[((DATA_WIDTH/8)-1):((DATA_WIDTH/8)-4)]);
	assign s161 = &s569[3:0];

	assign s586 = rv_wdata;

	assign s145 = s570 ? s566 : rv_awaddr[8:2];
	assign s144[63:32] = s571 ? s585[(DATA_WIDTH-1):(DATA_WIDTH-32)] : rv_wdata[(DATA_WIDTH-1):(DATA_WIDTH-32)];
	assign s144[31:0]  = s571 ? s585[31:0] : rv_wdata[31:0];

	assign rv_awready = ~s570;
	assign rv_wready  = ~s571;

	assign s575 = rv_bvalid & rv_bready;
	assign s592 = s587;
	assign s593 = s575 | s107;
	assign s594  = s592 | (~s593 & s589);
	assign s591 = s570 ? s567 : rv_awid;
	assign s595 = s573;

	assign rv_bvalid = s589;
	assign rv_bid    = s590;
	assign rv_bresp  = NDS_ARESP_OK;


	assign s606 = rv_arvalid & rv_arready;
	assign  s607 = rv_rvalid  & rv_rready;

	assign s159 = rv_arvalid & rv_arready;

	assign s582 = s606;
	assign s583 = (s607 & s572) | s107;
	assign s584  = s582 | (s572 & ~s583);

	assign rv_arready = ~s572;

	assign s597 = s606;
	assign s598 = s607 | s107;
	assign s599  = s597 | (~s598 & s596);

	assign s600 = (DATA_WIDTH == 32) & rv_araddr[2];

	for (i_rv_rd = 0; i_rv_rd<DATA_WIDTH; i_rv_rd=i_rv_rd+32) begin: gen_rv_rdata_nx
		if (i_rv_rd == 32) begin: gen_rv_rdata_63_32
			assign s604[(i_rv_rd+31):i_rv_rd] = s147[(i_rv_rd+31):i_rv_rd];
		end
		else begin: gen_rv_rdata_31_0
			assign s604[(i_rv_rd+31):i_rv_rd] = s600 ? s147[63:32] : s147[31:0];
		end
	end

	assign s605    = s606;
	assign s602 = rv_arid;

	assign s146 = rv_araddr[8:2];

	assign rv_rid	 = s601;
	assign rv_rresp  = NDS_ARESP_OK;
	assign rv_rdata  = s603;
	assign rv_rvalid = s596;
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
	assign s261 = s158 & ( s145             == RV_ADDR_PROGBUF0) &  s161;
	assign s262 = s158 & ({s145[8:3], 1'b0} == RV_ADDR_PROGBUF0) & (s145[2] | s160);
	assign s263 = s158 & ( s145             == RV_ADDR_PROGBUF2) &  s161;
	assign s264 = s158 & ({s145[8:3], 1'b0} == RV_ADDR_PROGBUF2) & (s145[2] | s160);
	assign s265 = s158 & ( s145             == RV_ADDR_PROGBUF4) &  s161;
	assign s266 = s158 & ({s145[8:3], 1'b0} == RV_ADDR_PROGBUF4) & (s145[2] | s160);
	assign s267 = s158 & ( s145             == RV_ADDR_PROGBUF6) &  s161;
	assign s268 = s158 & ({s145[8:3], 1'b0} == RV_ADDR_PROGBUF6) & (s145[2] | s160);
	assign s269 = s158 & ( s145             == RV_ADDR_PROGBUF8) &  s161;
	assign s270 = s158 & ({s145[8:3], 1'b0} == RV_ADDR_PROGBUF8) & (s145[2] | s160);
	assign s271 = s158 & ( s145             == RV_ADDR_PROGBUF10) &  s161;
	assign s272 = s158 & ({s145[8:3], 1'b0} == RV_ADDR_PROGBUF10) & (s145[2] | s160);
	assign s273 = s158 & ( s145             == RV_ADDR_PROGBUF12) &  s161;
	assign s274 = s158 & ({s145[8:3], 1'b0} == RV_ADDR_PROGBUF12) & (s145[2] | s160);
	assign s275 = s158 & ( s145             == RV_ADDR_PROGBUF14) &  s161;
	assign s276 = s158 & ({s145[8:3], 1'b0} == RV_ADDR_PROGBUF14) & (s145[2] | s160);

	assign s170      = s158 & ( s145             == RV_ADDR_DATA0) &  s161;
	assign s171      = s158 & ({s145[8:3], 1'b0} == RV_ADDR_DATA0) & (s145[2] | s160);
	assign s172      = s158 & ( s145             == RV_ADDR_DATA2) &  s161;
	assign s173      = s158 & ({s145[8:3], 1'b0} == RV_ADDR_DATA2) & (s145[2] | s160);

	assign s174        = s158 & ( s145             == RV_ADDR_COMMAND) &  s161;
	assign s175     = s158 & ({s145[8:3], 1'b0} == RV_ADDR_COMMAND) & (s145[2] | s160);
	assign s176     = s158 & ( s145             == RV_ADDR_RESUME)  &  s161;
	assign s177  = s158 & ({s145[8:3], 1'b0} == RV_ADDR_RESUME)  & (s145[2] | s160);
end
else begin: gen_write_enable_for_32bit_bus
	assign s261 = s158 & (s145 == RV_ADDR_PROGBUF0);
	assign s262 = s158 & (s145 == RV_ADDR_PROGBUF1);
	assign s263 = s158 & (s145 == RV_ADDR_PROGBUF2);
	assign s264 = s158 & (s145 == RV_ADDR_PROGBUF3);
	assign s265 = s158 & (s145 == RV_ADDR_PROGBUF4);
	assign s266 = s158 & (s145 == RV_ADDR_PROGBUF5);
	assign s267 = s158 & (s145 == RV_ADDR_PROGBUF6);
	assign s268 = s158 & (s145 == RV_ADDR_PROGBUF7);
	assign s269 = s158 & (s145 == RV_ADDR_PROGBUF8);
	assign s270 = s158 & (s145 == RV_ADDR_PROGBUF9);
	assign s271 = s158 & (s145 == RV_ADDR_PROGBUF10);
	assign s272 = s158 & (s145 == RV_ADDR_PROGBUF11);
	assign s273 = s158 & (s145 == RV_ADDR_PROGBUF12);
	assign s274 = s158 & (s145 == RV_ADDR_PROGBUF13);
	assign s275 = s158 & (s145 == RV_ADDR_PROGBUF14);
	assign s276 = s158 & (s145 == RV_ADDR_PROGBUF15);
	assign s170      = s158 & (s145 == RV_ADDR_DATA0);
	assign s171      = s158 & (s145 == RV_ADDR_DATA1);
	assign s172      = s158 & (s145 == RV_ADDR_DATA2);
	assign s173      = s158 & (s145 == RV_ADDR_DATA3);

	assign s174        = s158 & (s145 == RV_ADDR_COMMAND);
	assign s175     = s158 & (s145 == RV_ADDR_NOTIFY);
	assign s176     = s158 & (s145 == RV_ADDR_RESUME);
	assign s177  = s158 & (s145 == RV_ADDR_EXCEPTION);
end
endgenerate

assign s178 = s158 & (s145 == RV_ADDR_SERIAL0);

assign s180 = s157 & (s145 == RV_ADDR_SERIAL0);

assign s179 = s159 & (s146 == RV_ADDR_SERIAL0);

always @* begin
	case({s146[8:3], 1'b0})
	7'h00:			s147 = {32'h00c0006f, 32'h0180006f};
	7'h02:			s147 = {32'h00c0006f, 32'h0080006f};
	7'h04:			s147 = {32'h00c0006f, 32'h12802623};
	7'h06:			s147 = {32'h7b349073, 32'h7b241073};
	7'h08:			s147 = {32'hf1402473, 32'h12002483};
	7'h0a:			s147 = {32'h02848a63, 32'h12802223};
	7'h0c:			s147 = {32'h00848663, 32'h4004c493};
	7'h0e:			s147 = {32'hff1ff06f, 32'h12002483};
	7'h10:			s147 = {32'h7b202473, 32'h12802423};
	7'h12:			s147 = {32'h7b200073, 32'h7b3024f3};
	7'h14:			s147 = {32'h7b3024f3, 32'h00000013};
	7'h16:			s147 = {32'h00100073, 32'h7b202473};
	7'h18:			s147 = {32'h7b202473, 32'h12902023};
	7'h1a:			s147 = {32'h10000067, 32'h7b3024f3};
	RV_ADDR_PROGBUF0:	s147 = {s31, s30};
	RV_ADDR_PROGBUF2:	s147 = {s33, s32};
	RV_ADDR_PROGBUF4:	s147 = {s35, s34};
	RV_ADDR_PROGBUF6:	s147 = {s37, s36};
	RV_ADDR_PROGBUF8:	s147 = {s39, s38};
	RV_ADDR_PROGBUF10:	s147 = {s41, s40};
	RV_ADDR_PROGBUF12:	s147 = {s43, s42};
	RV_ADDR_PROGBUF14:	s147 = {s45, s44};
	RV_ADDR_DATA0:		s147 = {s27, s26};
	RV_ADDR_DATA2:		s147 = {s29, s28};
	RV_ADDR_DATA4:		s147 = 64'd0;
	RV_ADDR_DATA6:		s147 = 64'd0;

	RV_ADDR_ABSPROG0:	s147 = {s200, s199};
	RV_ADDR_ABSPROG2:	s147 = {s202, s201};
	RV_ADDR_ABSPROG4:	s147 = {s204, s203};
	RV_ADDR_ABSPROG6:	s147 = {s206, s205};

	RV_ADDR_COMMAND:	s147 = {s166,    s165};
	RV_ADDR_RESUME:		s147 = {s168, s167};
	RV_ADDR_SERIAL0:	s147 = {32'h0,        s169};
	default:		s147 = 64'h0;
	endcase
end

wire s608 = (|dmi_haddr) | (|rv_haddr) | (|s186);

wire s609 = (|dmi_hprot) | (|rv_hprot) |
		    (|dmi_hsize) | (|rv_hsize) |
		    (|dmi_hburst) | (|rv_hburst) |
		    dmi_htrans[0] | rv_htrans[0] | s608;


`ifdef PLDM_ILA_DEBUG
(* mark_debug = "true" *) wire	[31:0] s610 = {20'd0, rv_arvalid, rv_arready, rv_rvalid, rv_rready, s194, s191, s19 ,s75};
(* mark_debug = "true" *) wire	[31:0] s611 = {21'd0, s174, s175, s177, s176, ndmreset,
						 s153, s359, s358, s197, s236, s243};
(* mark_debug = "true" *) wire	[31:0] s612 = {2'd0, s144[9:0], s79, s101};
(* mark_debug = "true" *) wire	[31:0] s613 = s15;
(* mark_debug = "true" *) wire	s614;
(* mark_debug = "true" *) wire	s615 = 1'b0;
(* mark_debug = "true" *) wire	s616 = 1'b0;
(* mark_debug = "true" *) wire	s617;
ila16384_4x32b ila16384_4x32b(clk, s614, s615, s616, s617, s610, s611, s612, s613);
`endif

endmodule

