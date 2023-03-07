localparam              AWIDTH                       = 16   ;
localparam              DWIDTH                       = 32  ;

localparam [AWIDTH-1:0] ADDR_IDREV                   = 'h0 ;
localparam [AWIDTH-1:0] ADDR_SW_RST_CONTROL          = 'h4 ;
localparam [AWIDTH-1:0] ADDR_PLL_CONFIG_0            = 'h8 ;
localparam [AWIDTH-1:0] ADDR_PLL_CONFIG_1            = 'hC ;
localparam [AWIDTH-1:0] ADDR_PLL_CONFIG_2            = 'h10;
localparam [AWIDTH-1:0] ADDR_PLL_CONFIG_3            = 'h14;
localparam [AWIDTH-1:0] ADDR_PLL_CONFIG_4            = 'h18;
localparam [AWIDTH-1:0] ADDR_PLL_STATUS              = 'h1C;
localparam [AWIDTH-1:0] ADDR_DIVIDER_CONTROL         = 'h20;
localparam [AWIDTH-1:0] ADDR_GATING_CONTROL          = 'h24;
localparam [AWIDTH-1:0] ADDR_DEBUG_CONTROL           = 'h28;
localparam [AWIDTH-1:0] ADDR_IRQ_MASK_MAP_CONTROL_0  = 'h2C;
localparam [AWIDTH-1:0] ADDR_IRQ_MASK_MAP_CONTROL_1  = 'h30;
localparam [AWIDTH-1:0] ADDR_IRQ_MASK_MAP_CONTROL_2  = 'h34;
localparam [AWIDTH-1:0] ADDR_IRQ_MASK_MAP_CONTROL_3  = 'h38;
localparam [AWIDTH-1:0] ADDR_IRQ_MASK_MAP_CONTROL_4  = 'h3C;
localparam [AWIDTH-1:0] ADDR_IRQ_MASK_MAP_CONTROL_5  = 'h40;
localparam [AWIDTH-1:0] ADDR_IRQ_MASK_MAP_CONTROL_6  = 'h44;
localparam [AWIDTH-1:0] ADDR_IRQ_MASK_MAP_CONTROL_7  = 'h48;
localparam [AWIDTH-1:0] ADDR_IRQ_MASK_MAP_CONTROL_8  = 'h4C;
localparam [AWIDTH-1:0] ADDR_IRQ_MASK_MAP_CONTROL_9  = 'h50;
localparam [AWIDTH-1:0] ADDR_IRQ_MASK_MAP_CONTROL_10 = 'h54;
localparam [AWIDTH-1:0] ADDR_IRQ_MASK_MAP_CONTROL_11 = 'h58;
localparam [AWIDTH-1:0] ADDR_IRQ_MASK_MAP_CONTROL_12 = 'h5C;
localparam [AWIDTH-1:0] ADDR_IRQ_MASK_MAP_CONTROL_13 = 'h60;
localparam [AWIDTH-1:0] ADDR_IRQ_MASK_MAP_CONTROL_14 = 'h64;
localparam [AWIDTH-1:0] ADDR_IRQ_MASK_MAP_CONTROL_15 = 'h68;
localparam [AWIDTH-1:0] ADDR_IRQ_MASK_MAP_CONTROL_16 = 'h6C;
localparam [AWIDTH-1:0] ADDR_IRQ_MASK_MAP_CONTROL_17 = 'h70;
localparam [AWIDTH-1:0] ADDR_IRQ_MASK_MAP_CONTROL_18 = 'h74;
localparam [AWIDTH-1:0] ADDR_IRQ_MASK_MAP_CONTROL_19 = 'h78;
localparam [AWIDTH-1:0] ADDR_IRQ_MASK_MAP_CONTROL_20 = 'h7C;
localparam [AWIDTH-1:0] ADDR_IRQ_MASK_MAP_CONTROL_21 = 'h80;
localparam [AWIDTH-1:0] ADDR_IRQ_MASK_MAP_CONTROL_22 = 'h84;
localparam [AWIDTH-1:0] ADDR_IRQ_MASK_MAP_CONTROL_23 = 'h88;
localparam [AWIDTH-1:0] ADDR_IRQ_MASK_MAP_CONTROL_24 = 'h8C;
localparam [AWIDTH-1:0] ADDR_IRQ_MASK_MAP_CONTROL_25 = 'h90;
localparam [AWIDTH-1:0] ADDR_IRQ_MASK_MAP_CONTROL_26 = 'h94;
localparam [AWIDTH-1:0] ADDR_IRQ_MASK_MAP_CONTROL_27 = 'h98;
localparam [AWIDTH-1:0] ADDR_IRQ_MASK_MAP_CONTROL_28 = 'h9C;
localparam [AWIDTH-1:0] ADDR_IRQ_MASK_MAP_CONTROL_29 = 'hA0;
localparam [AWIDTH-1:0] ADDR_IRQ_MASK_MAP_CONTROL_30 = 'hA4;
localparam [AWIDTH-1:0] ADDR_IRQ_MASK_MAP_CONTROL_31 = 'hA8;
localparam [AWIDTH-1:0] ADDR_ISOLATION_CONTROL       = 'hAC;
localparam [AWIDTH-1:0] ADDR_CLOCK_SELECT_STATUS     = 'hB0;
localparam [AWIDTH-1:0] ADDR_MAIN_DIVIDER_CONTROL    = 'hB4;
localparam [AWIDTH-1:0] ADDR_PUFCC_CONTROL           = 'hB8;
localparam [AWIDTH-1:0] ADDR_USB_CONTROL             = 'hBC;
localparam [AWIDTH-1:0] ADDR_FPGA_PLL_CLK_SEL        = 'hC0;
localparam [AWIDTH-1:0] ADDR_WDT_PAUSE               = 'hC4;

localparam                         REGS_NUM =  50;


localparam [AWIDTH * REGS_NUM-1:0] MAP      ={
                                              ADDR_WDT_PAUSE,
                                              ADDR_FPGA_PLL_CLK_SEL,
                                              ADDR_USB_CONTROL,
                                              ADDR_PUFCC_CONTROL,
                                              ADDR_MAIN_DIVIDER_CONTROL,
                                              ADDR_CLOCK_SELECT_STATUS,                  
                                              ADDR_ISOLATION_CONTROL,
                                              ADDR_IRQ_MASK_MAP_CONTROL_31,
                                              ADDR_IRQ_MASK_MAP_CONTROL_30,
                                              ADDR_IRQ_MASK_MAP_CONTROL_29,
                                              ADDR_IRQ_MASK_MAP_CONTROL_28,
                                              ADDR_IRQ_MASK_MAP_CONTROL_27,
                                              ADDR_IRQ_MASK_MAP_CONTROL_26,
                                              ADDR_IRQ_MASK_MAP_CONTROL_25,
                                              ADDR_IRQ_MASK_MAP_CONTROL_24,
                                              ADDR_IRQ_MASK_MAP_CONTROL_23,
                                              ADDR_IRQ_MASK_MAP_CONTROL_22,
                                              ADDR_IRQ_MASK_MAP_CONTROL_21,
                                              ADDR_IRQ_MASK_MAP_CONTROL_20,
                                              ADDR_IRQ_MASK_MAP_CONTROL_19,
                                              ADDR_IRQ_MASK_MAP_CONTROL_18,
                                              ADDR_IRQ_MASK_MAP_CONTROL_17,
                                              ADDR_IRQ_MASK_MAP_CONTROL_16,
                                              ADDR_IRQ_MASK_MAP_CONTROL_15,
                                              ADDR_IRQ_MASK_MAP_CONTROL_14,
                                              ADDR_IRQ_MASK_MAP_CONTROL_13,
                                              ADDR_IRQ_MASK_MAP_CONTROL_12,
                                              ADDR_IRQ_MASK_MAP_CONTROL_11,
                                              ADDR_IRQ_MASK_MAP_CONTROL_10,
                                              ADDR_IRQ_MASK_MAP_CONTROL_9,
                                              ADDR_IRQ_MASK_MAP_CONTROL_8,
                                              ADDR_IRQ_MASK_MAP_CONTROL_7,
                                              ADDR_IRQ_MASK_MAP_CONTROL_6,
                                              ADDR_IRQ_MASK_MAP_CONTROL_5,
                                              ADDR_IRQ_MASK_MAP_CONTROL_4,
                                              ADDR_IRQ_MASK_MAP_CONTROL_3,
                                              ADDR_IRQ_MASK_MAP_CONTROL_2,
                                              ADDR_IRQ_MASK_MAP_CONTROL_1,
                                              ADDR_IRQ_MASK_MAP_CONTROL_0,
                                              ADDR_DEBUG_CONTROL,
                                              ADDR_GATING_CONTROL,
                                              ADDR_DIVIDER_CONTROL,
                                              ADDR_PLL_STATUS,
                                              ADDR_PLL_CONFIG_4,
                                              ADDR_PLL_CONFIG_3,
                                              ADDR_PLL_CONFIG_2,
                                              ADDR_PLL_CONFIG_1,
                                              ADDR_PLL_CONFIG_0,
                                              ADDR_SW_RST_CONTROL,
                                              ADDR_IDREV
                                              };
