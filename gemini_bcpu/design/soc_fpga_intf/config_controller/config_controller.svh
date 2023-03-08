`ifndef CONFIG_CONTROLLER_PARAMS
`define CONFIG_CONTROLLER_PARAMS
localparam CC_AWIDTH = 16;
localparam CC_DWIDTH = 32;

localparam [CC_AWIDTH-1:0] OFE_BASE_ADDR = 'h0   ;
localparam [CC_AWIDTH-1:0] FCB_BASE_ADDR = 'h2000;
localparam [CC_AWIDTH-1:0] CCB_BASE_ADDR = 'h4000;
localparam [CC_AWIDTH-1:0] ICB_BASE_ADDR = 'h6000;
localparam [CC_AWIDTH-1:0] PCB_BASE_ADDR = 'h8000;

localparam FCB_CHAIN_LENGTH_NUM = 16 ;
localparam FCB_CHAIN_NUM        = 128;
localparam ICB_CHAIN_LENGTH_NUM = 1  ;
localparam ICB_CHAIN_NUM        = 1  ;
localparam OFE_REG_NUM          = 1  ;
localparam FCB_REG_NUM          = 44 ;
localparam CCB_REG_NUM          = 20 ;
localparam ICB_REG_NUM          = 14 ;

// OFE regs
localparam [CC_AWIDTH-1:0] ADDR_OFE_CFG_DONE = OFE_BASE_ADDR + 'h0;

//FCB regs
localparam [CC_AWIDTH-1:0] ADDR_FCB_CFG_CMD              = FCB_BASE_ADDR + 'h0 ;
localparam [CC_AWIDTH-1:0] ADDR_FCB_CFG_KICKOFF          = FCB_BASE_ADDR + 'h4 ;
localparam [CC_AWIDTH-1:0] ADDR_FCB_CFG_DONE             = FCB_BASE_ADDR + 'h8 ;
localparam [CC_AWIDTH-1:0] ADDR_FCB_CHKSUM_WORD          = FCB_BASE_ADDR + 'hC ;
localparam [CC_AWIDTH-1:0] ADDR_FCB_CHKSUM_STATUS        = FCB_BASE_ADDR + 'h10;
localparam [CC_AWIDTH-1:0] ADDR_FCB_SOFT_RESET           = FCB_BASE_ADDR + 'h14;
localparam [CC_AWIDTH-1:0] ADDR_FCB_CMD_CONTROL          = FCB_BASE_ADDR + 'h18;
localparam [CC_AWIDTH-1:0] ADDR_FCB_OP_CONFIG            = FCB_BASE_ADDR + 'h1C;
localparam [CC_AWIDTH-1:0] ADDR_FCB_SHIFT_STATUS         = FCB_BASE_ADDR + 'h20;
localparam [CC_AWIDTH-1:0] ADDR_FCB_BITSTREAM_WDATA      = FCB_BASE_ADDR + 'h24;
localparam [CC_AWIDTH-1:0] ADDR_FCB_BITSTREAM_RDATA      = FCB_BASE_ADDR + 'h28;
localparam [CC_AWIDTH-1:0] ADDR_FCB_SWITCH_CHAIN_TIME    = FCB_BASE_ADDR + 'h2C;
localparam [CC_AWIDTH-1:0] ADDR_FCB_CHAIN_LENGTH_0       = FCB_BASE_ADDR + 'h30;
localparam [CC_AWIDTH-1:0] ADDR_FCB_CHAIN_LENGTH_1       = FCB_BASE_ADDR + 'h34;
localparam [CC_AWIDTH-1:0] ADDR_FCB_CHAIN_LENGTH_2       = FCB_BASE_ADDR + 'h38;
localparam [CC_AWIDTH-1:0] ADDR_FCB_CHAIN_LENGTH_3       = FCB_BASE_ADDR + 'h3C;
localparam [CC_AWIDTH-1:0] ADDR_FCB_CHAIN_LENGTH_4       = FCB_BASE_ADDR + 'h40;
localparam [CC_AWIDTH-1:0] ADDR_FCB_CHAIN_LENGTH_5       = FCB_BASE_ADDR + 'h44;
localparam [CC_AWIDTH-1:0] ADDR_FCB_CHAIN_LENGTH_6       = FCB_BASE_ADDR + 'h48;
localparam [CC_AWIDTH-1:0] ADDR_FCB_CHAIN_LENGTH_7       = FCB_BASE_ADDR + 'h4C;
localparam [CC_AWIDTH-1:0] ADDR_FCB_CHAIN_LENGTH_8       = FCB_BASE_ADDR + 'h50;
localparam [CC_AWIDTH-1:0] ADDR_FCB_CHAIN_LENGTH_9       = FCB_BASE_ADDR + 'h54;
localparam [CC_AWIDTH-1:0] ADDR_FCB_CHAIN_LENGTH_10      = FCB_BASE_ADDR + 'h58;
localparam [CC_AWIDTH-1:0] ADDR_FCB_CHAIN_LENGTH_11      = FCB_BASE_ADDR + 'h5c;
localparam [CC_AWIDTH-1:0] ADDR_FCB_CHAIN_LENGTH_12      = FCB_BASE_ADDR + 'h60;
localparam [CC_AWIDTH-1:0] ADDR_FCB_CHAIN_LENGTH_13      = FCB_BASE_ADDR + 'h64;
localparam [CC_AWIDTH-1:0] ADDR_FCB_CHAIN_LENGTH_14      = FCB_BASE_ADDR + 'h68;
localparam [CC_AWIDTH-1:0] ADDR_FCB_CHAIN_LENGTH_15      = FCB_BASE_ADDR + 'h6C;
localparam [CC_AWIDTH-1:0] ADDR_FCB_CHAINS_LENGTH_MAP_0  = FCB_BASE_ADDR + 'h70;
localparam [CC_AWIDTH-1:0] ADDR_FCB_CHAINS_LENGTH_MAP_1  = FCB_BASE_ADDR + 'h74;
localparam [CC_AWIDTH-1:0] ADDR_FCB_CHAINS_LENGTH_MAP_2  = FCB_BASE_ADDR + 'h78;
localparam [CC_AWIDTH-1:0] ADDR_FCB_CHAINS_LENGTH_MAP_3  = FCB_BASE_ADDR + 'h7C;
localparam [CC_AWIDTH-1:0] ADDR_FCB_CHAINS_LENGTH_MAP_4  = FCB_BASE_ADDR + 'h80;
localparam [CC_AWIDTH-1:0] ADDR_FCB_CHAINS_LENGTH_MAP_5  = FCB_BASE_ADDR + 'h84;
localparam [CC_AWIDTH-1:0] ADDR_FCB_CHAINS_LENGTH_MAP_6  = FCB_BASE_ADDR + 'h88;
localparam [CC_AWIDTH-1:0] ADDR_FCB_CHAINS_LENGTH_MAP_7  = FCB_BASE_ADDR + 'h8C;
localparam [CC_AWIDTH-1:0] ADDR_FCB_CHAINS_LENGTH_MAP_8  = FCB_BASE_ADDR + 'h90;
localparam [CC_AWIDTH-1:0] ADDR_FCB_CHAINS_LENGTH_MAP_9  = FCB_BASE_ADDR + 'h94;
localparam [CC_AWIDTH-1:0] ADDR_FCB_CHAINS_LENGTH_MAP_10 = FCB_BASE_ADDR + 'h98;
localparam [CC_AWIDTH-1:0] ADDR_FCB_CHAINS_LENGTH_MAP_11 = FCB_BASE_ADDR + 'h9C;
localparam [CC_AWIDTH-1:0] ADDR_FCB_CHAINS_LENGTH_MAP_12 = FCB_BASE_ADDR + 'hA0;
localparam [CC_AWIDTH-1:0] ADDR_FCB_CHAINS_LENGTH_MAP_13 = FCB_BASE_ADDR + 'hA4;
localparam [CC_AWIDTH-1:0] ADDR_FCB_CHAINS_LENGTH_MAP_14 = FCB_BASE_ADDR + 'hA8;
localparam [CC_AWIDTH-1:0] ADDR_FCB_CHAINS_LENGTH_MAP_15 = FCB_BASE_ADDR + 'hAC;

// CCB regs
localparam [CC_AWIDTH-1:0] ADDR_FPGA_PLL0_CONFIG_0 = CCB_BASE_ADDR + 'h0 ;
localparam [CC_AWIDTH-1:0] ADDR_FPGA_PLL0_CONFIG_1 = CCB_BASE_ADDR + 'h4 ;
localparam [CC_AWIDTH-1:0] ADDR_FPGA_PLL0_CONFIG_2 = CCB_BASE_ADDR + 'h8 ;
localparam [CC_AWIDTH-1:0] ADDR_FPGA_PLL0_CONFIG_3 = CCB_BASE_ADDR + 'hC ;
localparam [CC_AWIDTH-1:0] ADDR_FPGA_PLL0_STATUS   = CCB_BASE_ADDR + 'h10;
localparam [CC_AWIDTH-1:0] ADDR_FPGA_PLL1_CONFIG_0 = CCB_BASE_ADDR + 'h0  + 'h14 ;
localparam [CC_AWIDTH-1:0] ADDR_FPGA_PLL1_CONFIG_1 = CCB_BASE_ADDR + 'h4  + 'h14 ;
localparam [CC_AWIDTH-1:0] ADDR_FPGA_PLL1_CONFIG_2 = CCB_BASE_ADDR + 'h8  + 'h14 ;
localparam [CC_AWIDTH-1:0] ADDR_FPGA_PLL1_CONFIG_3 = CCB_BASE_ADDR + 'hC  + 'h14 ;
localparam [CC_AWIDTH-1:0] ADDR_FPGA_PLL1_STATUS   = CCB_BASE_ADDR + 'h10 + 'h14;
localparam [CC_AWIDTH-1:0] ADDR_FPGA_PLL2_CONFIG_0 = CCB_BASE_ADDR + 'h0  + 'h28;
localparam [CC_AWIDTH-1:0] ADDR_FPGA_PLL2_CONFIG_1 = CCB_BASE_ADDR + 'h4  + 'h28;
localparam [CC_AWIDTH-1:0] ADDR_FPGA_PLL2_CONFIG_2 = CCB_BASE_ADDR + 'h8  + 'h28;
localparam [CC_AWIDTH-1:0] ADDR_FPGA_PLL2_CONFIG_3 = CCB_BASE_ADDR + 'hC  + 'h28;
localparam [CC_AWIDTH-1:0] ADDR_FPGA_PLL2_STATUS   = CCB_BASE_ADDR + 'h10 + 'h28;
localparam [CC_AWIDTH-1:0] ADDR_FPGA_PLL3_CONFIG_0 = CCB_BASE_ADDR + 'h0  + 'h3C;
localparam [CC_AWIDTH-1:0] ADDR_FPGA_PLL3_CONFIG_1 = CCB_BASE_ADDR + 'h4  + 'h3C;
localparam [CC_AWIDTH-1:0] ADDR_FPGA_PLL3_CONFIG_2 = CCB_BASE_ADDR + 'h8  + 'h3C;
localparam [CC_AWIDTH-1:0] ADDR_FPGA_PLL3_CONFIG_3 = CCB_BASE_ADDR + 'hC  + 'h3C;
localparam [CC_AWIDTH-1:0] ADDR_FPGA_PLL3_STATUS   = CCB_BASE_ADDR + 'h10 + 'h3C;

// IOB regs
localparam [CC_AWIDTH-1:0] ADDR_ICB_CFG_CMD              = ICB_BASE_ADDR + 'h0 ;
localparam [CC_AWIDTH-1:0] ADDR_ICB_CFG_KICKOFF          = ICB_BASE_ADDR + 'h4 ;
localparam [CC_AWIDTH-1:0] ADDR_ICB_CFG_DONE             = ICB_BASE_ADDR + 'h8 ;
localparam [CC_AWIDTH-1:0] ADDR_ICB_CHKSUM_WORD          = ICB_BASE_ADDR + 'hC ;
localparam [CC_AWIDTH-1:0] ADDR_ICB_CHKSUM_STATUS        = ICB_BASE_ADDR + 'h10;
localparam [CC_AWIDTH-1:0] ADDR_ICB_SOFT_RESET           = ICB_BASE_ADDR + 'h14;
localparam [CC_AWIDTH-1:0] ADDR_ICB_CMD_CONTROL          = ICB_BASE_ADDR + 'h18;
localparam [CC_AWIDTH-1:0] ADDR_ICB_OP_CONFIG            = ICB_BASE_ADDR + 'h1C;
localparam [CC_AWIDTH-1:0] ADDR_ICB_SHIFT_STATUS         = ICB_BASE_ADDR + 'h20;
localparam [CC_AWIDTH-1:0] ADDR_ICB_BITSTREAM_WDATA      = ICB_BASE_ADDR + 'h24;
localparam [CC_AWIDTH-1:0] ADDR_ICB_BITSTREAM_RDATA      = ICB_BASE_ADDR + 'h28;
localparam [CC_AWIDTH-1:0] ADDR_ICB_SWITCH_CHAIN_TIME    = ICB_BASE_ADDR + 'h2C;
localparam [CC_AWIDTH-1:0] ADDR_ICB_CHAIN_LENGTH_0       = ICB_BASE_ADDR + 'h30;
localparam [CC_AWIDTH-1:0] ADDR_ICB_CHAINS_LENGTH_MAP_0  = ICB_BASE_ADDR + 'h34;



// PCB regs, apb manager tmporary not used for PCB
localparam [CC_AWIDTH-1:0] ADDR_PL_CTL    = 'h40;
localparam [CC_AWIDTH-1:0] ADDR_PL_STAT   = 'h44;
localparam [CC_AWIDTH-1:0] ADDR_PL_CFG    = 'h48;
localparam [CC_AWIDTH-1:0] ADDR_PL_SELECT = 'h4C;
localparam [CC_AWIDTH-1:0] ADDR_PL_EXTRA  = 'h54;
localparam [CC_AWIDTH-1:0] ADDR_PL_ROW    = 'h58;
localparam [CC_AWIDTH-1:0] ADDR_PL_COL    = 'h5C;
localparam [CC_AWIDTH-1:0] ADDR_PL_TARG   = 'h60;
localparam [CC_AWIDTH-1:0] ADDR_PL_DATA   = 'h64;


localparam CC_REGS_NUM = OFE_REG_NUM + FCB_REG_NUM + CCB_REG_NUM + ICB_REG_NUM;

localparam [CC_AWIDTH * CC_REGS_NUM-1:0] CC_MAP      ={
                                              ADDR_ICB_CHAINS_LENGTH_MAP_0, //ICB
                                              ADDR_ICB_CHAIN_LENGTH_0, //ICB
                                              ADDR_ICB_SWITCH_CHAIN_TIME, //ICB
                                              ADDR_ICB_BITSTREAM_RDATA, // ICB
                                              ADDR_ICB_BITSTREAM_WDATA, // ICB
                                              ADDR_ICB_SHIFT_STATUS, // ICB
                                              ADDR_ICB_OP_CONFIG, // ICB
                                              ADDR_ICB_CMD_CONTROL, // ICB
                                              ADDR_ICB_SOFT_RESET, // ICB
                                              ADDR_ICB_CHKSUM_STATUS, // ICB
                                              ADDR_ICB_CHKSUM_WORD, // ICB
                                              ADDR_ICB_CFG_DONE, // ICB
                                              ADDR_ICB_CFG_KICKOFF, // ICB
                                              ADDR_ICB_CFG_CMD, // ICB
                                              ADDR_FPGA_PLL3_STATUS, //PLL
                                              ADDR_FPGA_PLL3_CONFIG_3, //PLL
                                              ADDR_FPGA_PLL3_CONFIG_2, //PLL
                                              ADDR_FPGA_PLL3_CONFIG_1, //PLL
                                              ADDR_FPGA_PLL3_CONFIG_0, //PLL
                                              ADDR_FPGA_PLL2_STATUS, //PLL
                                              ADDR_FPGA_PLL2_CONFIG_3, //PLL
                                              ADDR_FPGA_PLL2_CONFIG_2, //PLL
                                              ADDR_FPGA_PLL2_CONFIG_1, //PLL
                                              ADDR_FPGA_PLL2_CONFIG_0, //PLL
                                              ADDR_FPGA_PLL1_STATUS, //PLL
                                              ADDR_FPGA_PLL1_CONFIG_3, //PLL
                                              ADDR_FPGA_PLL1_CONFIG_2, //PLL
                                              ADDR_FPGA_PLL1_CONFIG_1, //PLL
                                              ADDR_FPGA_PLL1_CONFIG_0, //PLL
                                              ADDR_FPGA_PLL0_STATUS, //PLL
                                              ADDR_FPGA_PLL0_CONFIG_3, //PLL
                                              ADDR_FPGA_PLL0_CONFIG_2, //PLL
                                              ADDR_FPGA_PLL0_CONFIG_1, //PLL
                                              ADDR_FPGA_PLL0_CONFIG_0, //PLL
                                              ADDR_FCB_CHAINS_LENGTH_MAP_15, //FCB
                                              ADDR_FCB_CHAINS_LENGTH_MAP_14, //FCB
                                              ADDR_FCB_CHAINS_LENGTH_MAP_13, //FCB
                                              ADDR_FCB_CHAINS_LENGTH_MAP_12, //FCB
                                              ADDR_FCB_CHAINS_LENGTH_MAP_11, //FCB
                                              ADDR_FCB_CHAINS_LENGTH_MAP_10, //FCB
                                              ADDR_FCB_CHAINS_LENGTH_MAP_9, //FCB
                                              ADDR_FCB_CHAINS_LENGTH_MAP_8, //FCB
                                              ADDR_FCB_CHAINS_LENGTH_MAP_7, //FCB
                                              ADDR_FCB_CHAINS_LENGTH_MAP_6, //FCB
                                              ADDR_FCB_CHAINS_LENGTH_MAP_5, //FCB
                                              ADDR_FCB_CHAINS_LENGTH_MAP_4, //FCB
                                              ADDR_FCB_CHAINS_LENGTH_MAP_3, //FCB
                                              ADDR_FCB_CHAINS_LENGTH_MAP_2, //FCB
                                              ADDR_FCB_CHAINS_LENGTH_MAP_1, //FCB
                                              ADDR_FCB_CHAINS_LENGTH_MAP_0, //FCB
                                              ADDR_FCB_CHAIN_LENGTH_15, //FCB
                                              ADDR_FCB_CHAIN_LENGTH_14, //FCB
                                              ADDR_FCB_CHAIN_LENGTH_13, //FCB
                                              ADDR_FCB_CHAIN_LENGTH_12, //FCB
                                              ADDR_FCB_CHAIN_LENGTH_11, //FCB
                                              ADDR_FCB_CHAIN_LENGTH_10, //FCB
                                              ADDR_FCB_CHAIN_LENGTH_9, //FCB
                                              ADDR_FCB_CHAIN_LENGTH_8, //FCB
                                              ADDR_FCB_CHAIN_LENGTH_7, //FCB
                                              ADDR_FCB_CHAIN_LENGTH_6, //FCB
                                              ADDR_FCB_CHAIN_LENGTH_5, //FCB
                                              ADDR_FCB_CHAIN_LENGTH_4, //FCB
                                              ADDR_FCB_CHAIN_LENGTH_3, //FCB
                                              ADDR_FCB_CHAIN_LENGTH_2, //FCB
                                              ADDR_FCB_CHAIN_LENGTH_1, //FCB
                                              ADDR_FCB_CHAIN_LENGTH_0, //FCB
                                              ADDR_FCB_SWITCH_CHAIN_TIME, //FCB                                              
                                              ADDR_FCB_BITSTREAM_RDATA, //FCB
                                              ADDR_FCB_BITSTREAM_WDATA, //FCB
                                              ADDR_FCB_SHIFT_STATUS, //FCB
                                              ADDR_FCB_OP_CONFIG, //FCB
                                              ADDR_FCB_CMD_CONTROL, //FCB
                                              ADDR_FCB_SOFT_RESET, //FCB
                                              ADDR_FCB_CHKSUM_STATUS, //FCB
                                              ADDR_FCB_CHKSUM_WORD, //FCB
                                              ADDR_FCB_CFG_DONE, //FCB
                                              ADDR_FCB_CFG_KICKOFF, //FCB
                                              ADDR_FCB_CFG_CMD, //FCB
                                              ADDR_OFE_CFG_DONE //OFE
                                              };

`endif
