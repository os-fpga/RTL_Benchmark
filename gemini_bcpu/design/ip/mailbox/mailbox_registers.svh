
localparam              MBOX_AWIDTH             = 8   ;
localparam              MBOX_DWIDTH             = 32  ;

localparam              MBOX_REGS_NUM           = 28  ;

localparam [MBOX_AWIDTH-1:0] ADDR_SEM_STAT_0    =    'h00;
localparam [MBOX_AWIDTH-1:0] ADDR_SEM_STAT_1    =    'h04;
localparam [MBOX_AWIDTH-1:0] ADDR_SEM_STAT_2    =    'h08;
localparam [MBOX_AWIDTH-1:0] ADDR_SEM_STAT_3    =    'h0C;

localparam [MBOX_AWIDTH-1:0] ADDR_SEM_CTRL_0    =    'h10;
localparam [MBOX_AWIDTH-1:0] ADDR_SEM_CTRL_1    =    'h14;
localparam [MBOX_AWIDTH-1:0] ADDR_SEM_CTRL_2    =    'h18;
localparam [MBOX_AWIDTH-1:0] ADDR_SEM_CTRL_3    =    'h1C;

localparam [MBOX_AWIDTH-1:0] ADDR_MBOX_DAT_0    =    'h20;
localparam [MBOX_AWIDTH-1:0] ADDR_MBOX_DAT_1    =    'h24;
localparam [MBOX_AWIDTH-1:0] ADDR_MBOX_DAT_2    =    'h28;
localparam [MBOX_AWIDTH-1:0] ADDR_MBOX_DAT_3    =    'h2C;
localparam [MBOX_AWIDTH-1:0] ADDR_MBOX_DAT_4    =    'h30;
localparam [MBOX_AWIDTH-1:0] ADDR_MBOX_DAT_5    =    'h34;
localparam [MBOX_AWIDTH-1:0] ADDR_MBOX_DAT_6    =    'h38;
localparam [MBOX_AWIDTH-1:0] ADDR_MBOX_DAT_7    =    'h3C;
localparam [MBOX_AWIDTH-1:0] ADDR_MBOX_DAT_8    =    'h40;
localparam [MBOX_AWIDTH-1:0] ADDR_MBOX_DAT_9    =    'h44;
localparam [MBOX_AWIDTH-1:0] ADDR_MBOX_DAT_10   =    'h48;
localparam [MBOX_AWIDTH-1:0] ADDR_MBOX_DAT_11   =    'h4C;

localparam [MBOX_AWIDTH-1:0] ADDR_MBOX_STAT_0   =    'h50;
localparam [MBOX_AWIDTH-1:0] ADDR_MBOX_STAT_1   =    'h54;
localparam [MBOX_AWIDTH-1:0] ADDR_MBOX_STAT_2   =    'h58;
localparam [MBOX_AWIDTH-1:0] ADDR_MBOX_STAT_3   =    'h5C;

localparam [MBOX_AWIDTH-1:0] ADDR_MBOX_CNTRL_0  =    'h60;
localparam [MBOX_AWIDTH-1:0] ADDR_MBOX_CNTRL_1  =    'h64;
localparam [MBOX_AWIDTH-1:0] ADDR_MBOX_CNTRL_2  =    'h68;
localparam [MBOX_AWIDTH-1:0] ADDR_MBOX_CNTRL_3  =    'h6C;

localparam [MBOX_AWIDTH * MBOX_REGS_NUM-1:0] MBOX_MAP ={
                                            ADDR_MBOX_CNTRL_3 ,
                                            ADDR_MBOX_CNTRL_2 ,
                                            ADDR_MBOX_CNTRL_1 ,
                                            ADDR_MBOX_CNTRL_0 ,
                                            ADDR_MBOX_STAT_3  ,
                                            ADDR_MBOX_STAT_2  ,
                                            ADDR_MBOX_STAT_1  ,
                                            ADDR_MBOX_STAT_0  ,
                                            ADDR_MBOX_DAT_11  ,
                                            ADDR_MBOX_DAT_10  ,
                                            ADDR_MBOX_DAT_9   ,
                                            ADDR_MBOX_DAT_8   ,
                                            ADDR_MBOX_DAT_7   ,
                                            ADDR_MBOX_DAT_6   ,
                                            ADDR_MBOX_DAT_5   ,
                                            ADDR_MBOX_DAT_4   ,
                                            ADDR_MBOX_DAT_3   ,
                                            ADDR_MBOX_DAT_2   ,
                                            ADDR_MBOX_DAT_1   ,
                                            ADDR_MBOX_DAT_0   ,
                                            ADDR_SEM_CTRL_3   ,
                                            ADDR_SEM_CTRL_2   ,
                                            ADDR_SEM_CTRL_1   ,
                                            ADDR_SEM_CTRL_0   ,
                                            ADDR_SEM_STAT_3   ,
                                            ADDR_SEM_STAT_2   ,
                                            ADDR_SEM_STAT_1   ,
                                            ADDR_SEM_STAT_0
                                        };