`ifndef _PLDM_DEFINE_VH_
`define _PLDM_DEFINE_VH_
parameter  DMI_ABITS        = 7;

localparam DMI_JTAG_NOP     = 2'h0;
localparam DMI_JTAG_READ    = 2'h1;
localparam DMI_JTAG_WRITE   = 2'h2;

localparam DMI_DMCONTROL    = 7'h10;
localparam DMI_DMSTATUS     = 7'h11;
localparam DMI_HARTINFO     = 7'h12;
localparam DMI_HALTSUM      = 7'h13;
localparam DMI_HAWINDOWSEL  = 7'h14;
localparam DMI_HAWINDOW     = 7'h15;
localparam DMI_ABSTRACTCS   = 7'h16;
localparam DMI_COMMAND      = 7'h17;
localparam DMI_ABSTRACTAUTO = 7'h18;
localparam DMI_CFGSTRADDR0  = 7'h19;
localparam DMI_CFGSTRADDR1  = 7'h1a;
localparam DMI_CFGSTRADDR2  = 7'h1b;
localparam DMI_CFGSTRADDR3  = 7'h1c;

localparam DMI_DATA0        = 7'h04;
localparam DMI_DATA1        = 7'h05;
localparam DMI_DATA2        = 7'h06;
localparam DMI_DATA3        = 7'h07;
localparam DMI_DATA4        = 7'h08;
localparam DMI_DATA5        = 7'h09;
localparam DMI_DATA6        = 7'h0a;
localparam DMI_DATA7        = 7'h0b;
localparam DMI_DATA8        = 7'h0c;
localparam DMI_DATA9        = 7'h0d;
localparam DMI_DATA10       = 7'h0e;
localparam DMI_DATA11       = 7'h0f;
localparam DMI_CUSTOM       = 7'h1f;
localparam DMI_PROGBUF0     = 7'h20;
localparam DMI_PROGBUF1     = 7'h21;
localparam DMI_PROGBUF2     = 7'h22;
localparam DMI_PROGBUF3     = 7'h23;
localparam DMI_PROGBUF4     = 7'h24;
localparam DMI_PROGBUF5     = 7'h25;
localparam DMI_PROGBUF6     = 7'h26;
localparam DMI_PROGBUF7     = 7'h27;
localparam DMI_PROGBUF8     = 7'h28;
localparam DMI_PROGBUF9     = 7'h29;
localparam DMI_PROGBUF10    = 7'h2a;
localparam DMI_PROGBUF11    = 7'h2b;
localparam DMI_PROGBUF12    = 7'h2c;
localparam DMI_PROGBUF13    = 7'h2d;
localparam DMI_PROGBUF14    = 7'h2e;
localparam DMI_PROGBUF15    = 7'h2f;
localparam DMI_AUTHDATA     = 7'h30;
localparam DMI_DMCS2        = 7'h32;
localparam DMI_SERCS        = 7'h34;
localparam DMI_SERTX        = 7'h35;
localparam DMI_SERRX        = 7'h36;
localparam DMI_SBADDRESS3   = 7'h37;
localparam DMI_SBCS         = 7'h38;
localparam DMI_SBADDRESS0   = 7'h39;
localparam DMI_SBADDRESS1   = 7'h3a;
localparam DMI_SBADDRESS2   = 7'h3b;
localparam DMI_SBDATA0      = 7'h3c;
localparam DMI_SBDATA1      = 7'h3d;
localparam DMI_SBDATA2      = 7'h3e;
localparam DMI_SBDATA3      = 7'h3f;
localparam DMI_HALTREGION_BASE	= 7'h40;
localparam DMI_HALTREGION0  	= 7'h40;
localparam DMI_HALTREGION1  	= 7'h41;
localparam DMI_HALTREGION2  	= 7'h42;
localparam DMI_HALTREGION3  	= 7'h43;
localparam DMI_HALTREGION4  	= 7'h44;
localparam DMI_HALTREGION5  	= 7'h45;
localparam DMI_HALTREGION6  	= 7'h46;
localparam DMI_HALTREGION7  	= 7'h47;
localparam DMI_HALTREGION8  	= 7'h48;
localparam DMI_HALTREGION9  	= 7'h49;
localparam DMI_HALTREGION10 	= 7'h4a;
localparam DMI_HALTREGION11 	= 7'h4b;
localparam DMI_HALTREGION12 	= 7'h4c;
localparam DMI_HALTREGION13 	= 7'h4d;
localparam DMI_HALTREGION14 	= 7'h4e;
localparam DMI_HALTREGION15 	= 7'h4f;
localparam DMI_HALTREGION16 	= 7'h50;
localparam DMI_HALTREGION17 	= 7'h51;
localparam DMI_HALTREGION18 	= 7'h52;
localparam DMI_HALTREGION19 	= 7'h53;
localparam DMI_HALTREGION20 	= 7'h54;
localparam DMI_HALTREGION21 	= 7'h55;
localparam DMI_HALTREGION22 	= 7'h56;
localparam DMI_HALTREGION23 	= 7'h57;
localparam DMI_HALTREGION24 	= 7'h58;
localparam DMI_HALTREGION25 	= 7'h59;
localparam DMI_HALTREGION26 	= 7'h5a;
localparam DMI_HALTREGION27 	= 7'h5b;
localparam DMI_HALTREGION28 	= 7'h5c;
localparam DMI_HALTREGION29 	= 7'h5d;
localparam DMI_HALTREGION30 	= 7'h5e;
localparam DMI_HALTREGION31 	= 7'h5f;

localparam CMD_ACCESS_REG   = 8'b0;
localparam CMD_QUICK_ACCESS = 8'b1;
localparam CMD_QUICK_MEM    = 8'h2;

localparam CMD_INSTFEED     = 1'b0;
localparam CMD_ABSCMD       = 1'b1;

localparam CMD_SIZE_32      = 3'd2;
localparam CMD_SIZE_64      = 3'd3;
localparam CMD_SIZE_128     = 3'd4;

localparam CMD_NOPOSTEXEC   = 1'b0;
localparam CMD_POSTEXEC     = 1'b1;

localparam CMD_READ         = 1'b0;
localparam CMD_WRITE        = 1'b1;

localparam SB_VER_DRAFT17       = 3'd0;
localparam SB_VER_DRAFT18       = 3'd1;

localparam SB_KEEPBUSYERROR 	= 1'b0;
localparam SB_CLEARBUSYERROR	= 1'b1;

localparam SB_NOSINGLEREAD	= 1'b0;
localparam SB_SINGLEREAD	= 1'b1;

localparam SB_NOREADONADDR      = 1'b0;
localparam SB_READONADDR        = 1'b1;

localparam SB_SIZE_8		= 3'd0;
localparam SB_SIZE_16		= 3'd1;
localparam SB_SIZE_32		= 3'd2;
localparam SB_SIZE_64		= 3'd3;
localparam SB_SIZE_128		= 3'd4;

localparam SB_NOAUTOINCREMENT	= 1'b0;
localparam SB_AUTOINCREMENT	= 1'b1;

localparam SB_NOAUTOREAD	= 1'b0;
localparam SB_AUTOREAD		= 1'b1;

localparam SB_NOREADONDATA      = 1'b0;
localparam SB_READONDATA        = 1'b1;

localparam SB_KEEPERROR 	= 3'b000;
localparam SB_CLEARERROR	= 3'b111;

localparam BUS_ACCESS           = 1'b1;
localparam FORCE_CHECK_BUSY     = 1'b1;
localparam MAYBE_CHECK_BUSY     = 1'b0;
`endif
