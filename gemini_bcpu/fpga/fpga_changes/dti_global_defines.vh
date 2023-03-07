// dti_global_defines.vh

//  Dynamo Configuration
//`define CFG_ECC_ENABLE                                                          //  ECC support
//`define CFG_ECC_BUFF

`define CFG_ARB_PIPELINE_ENABLE     1
`define CFG_FREQUENCY_RATIO         4                                           //  Frequency Ratio Support: 1-Matching, 2-1:2, 4-1:4
`define CFG_DRAM_CHAN_NUM           2                                           //  Number of supporting channel in the system
`define CFG_DIMM_PER_CHAN           1                                           //  Number of DIMM in one channel
`define CFG_RANK_PER_DIMM           2                                           //  Number of rank in one DIMM
`define CFG_DRAM_DIMM_NUM           (`CFG_DRAM_CHAN_NUM * `CFG_DIMM_PER_CHAN)   //  Number of DIMM in the system [Don't change]
`define CFG_CHAN_RANK_NUM           (`CFG_DIMM_PER_CHAN * `CFG_RANK_PER_DIMM)   //  Number of rank in one channel [Don't change]
`define CFG_DRAM_RANK_NUM           (`CFG_DRAM_DIMM_NUM * `CFG_RANK_PER_DIMM)   //  Number of rank in the system [Don't change]
`define CFG_DIMM_CA_SHARE                                                       //  Share Control-Address bus between DIMMs
`define CFG_FREQ_RATIO_WIDTH        2                                           //  Frequency ratio burst width

`define CFG_DRAM_BG_NUM             4                                           //  Number of bank groups
`define CFG_BANK_PER_BG             4                                           //  Number of banks per bank group
`define CFG_DRAM_BA_NUM             `CFG_BANK_PER_BG * `CFG_DRAM_BG_NUM         //  Total number of banks one channel
`define CFG_DRAM_CHAN_WIDTH         1                                           //  Channel address bus width
`define CFG_DRAM_CTRL_WIDTH         1                                           //  DRAM control bus width
`define CFG_DRAM_RANK_WIDTH         1                                           //  Rank address bus width

//  DRAM Configuration
`define CFG_DRAM_BG_WIDTH           $clog2(`CFG_DRAM_BG_NUM)                    //  Bank Group bus width
`define CFG_DRAM_BA_WIDTH           $clog2(`CFG_DRAM_BA_NUM)                    //  Bank address bus width
`define CFG_DRAM_ROW_WIDTH          17                                          //  Row address bus width
`define CFG_DRAM_COL_WIDTH          11                                          //  Column address bus width

`define CFG_DRAM_ADDR_WIDTH         18                                          //  Address bus width  
`define CFG_DRAM_MR_WIDTH           18

`define CFG_DFI_CA_WIDTH            20                                          //  CA bus width in DFI Bridge
`define CFG_PHY_CA_WIDTH            19                                          //  CA bus width
`define CFG_DRAM_LP4_CA_WIDTH       6                                           //  CA bus width of LPDDR4
`define CFG_DRAM_LP3_CA_WIDTH       10                                          //  CA bus width of LPDDR3
// `define CFG_DRAM_DDR4_CA_WIDTH      10                                          //  CA bus width of DDR4
// `define CFG_DRAM_DDR3_CA_WIDTH      10                                          //  CA bus width of DDR3
`define CFG_LP4_PHASE_NUM           4                                           //  LPDDR4 CA phase number
`define CFG_PHY_LP3_CALVL_PAT_WIDTH 2*`CFG_DRAM_LP3_CA_WIDTH                    //  LPDDR3 CALVL Pattern Width
`define CFG_PHY_CA_SET_WIDTH        2*`CFG_DRAM_LP4_CA_WIDTH                    //  Maximum number of CA bits trained on 1 control block

//  PHY Configuration
`define CFG_PHY_CLK_WIDTH           2         //  Clock bus width
`define CFG_DFI_SLICE_WIDTH         8
`define CFG_PHY_SLICE_NUM           4
`define CFG_DFI_DATA_WIDTH          (`CFG_PHY_SLICE_NUM * `CFG_DFI_SLICE_WIDTH)
`define CFG_DFI_DATA_BYTE           ((`CFG_PHY_SLICE_NUM * `CFG_DFI_SLICE_WIDTH) / 8)

// `define CFG_APB_ADDR_WIDTH          12                        //  APB address bus width
// `define CFG_APB_DATA_WIDTH          32                        //  APB data bus width
//  AXI4-Lite Interface Definitions
`define CFG_AXI4LITE_ADDR_WIDTH     12                        //  AXI4-Lite address bus width
`define CFG_AXI4LITE_DATA_WIDTH     32                        //  AXI4-Lite data bus width
`define CFG_AXI4LITE_RESP_WIDTH     2                         //  AXI4-Lite response bus width [Fixed]

//  AXI4 Interface Definitions
`define CFG_AXI_PORT_NUM            4                         //  Number of AXI Ports in the Current Configuration
`define CFG_AXI4_ID_WIDTH           10                        //  AXI4 ID bus width
`define CFG_AXI4_ADDR_WIDTH         31                        //  AXI4 address bus width
`define CFG_AXI4_LEN_WIDTH          4                         //  AXI4 burst length bus width
`define CFG_AXI4_QOS_WIDTH          4                         //  AXI4 QoS burst width
`define CFG_AXI4_BURST_WIDTH        2                         //  AXI4 burst type bus width
`define CFG_AXI4_PROT_WIDTH         3                         //  AXI4 protection bus width
`define CFG_AXI4_SIZE_WIDTH         3                         //  AXI4 burst size bus width
`define CFG_AXI4_RESP_WIDTH         2                         //  AXI4 response bus width
`define CFG_AXI4_CACHE_WIDTH        4                         //  AXI4 cache bus width
`define CFG_AXI4_RESP_OK            2'b00                     //  AXI4 OK response code
`define CFG_AXI4_SLVERR             2'b10                     //  AXI4 Slave Error Code
`define CFG_AXI4_BURST_INCR         2'b01                     //  AXI4 incremental burst code
`define CFG_AXI4_BURST_WRAP         2'b10                     //  AXI4 wrapping burst code
`define CFG_AXI4_BURST_FIXED        2'b00                     //  AXI4 fixed burst code - Read/Write FIFO
`define CFG_AXI4_STRB_WIDTH         (`CFG_FREQUENCY_RATIO * 2 * `CFG_DFI_DATA_BYTE)   //  AXI4 write strobe bus width
`define CFG_AXI4_DATA_WIDTH         (`CFG_FREQUENCY_RATIO * 2 * `CFG_DFI_DATA_WIDTH)  //  AXI4 data bus width
`define CFG_AXI4_DATA_SIZE          $clog2(`CFG_AXI4_STRB_WIDTH)
`define CFG_AXI_PORT_WIDTH          (`CFG_AXI_PORT_NUM == 1 ? 1 : $clog2(`CFG_AXI_PORT_NUM))  //  Maximum Width of the PORT ID Field

`define CFG_AXI4_MASTER_SIZE        5
`define CFG_AXI4_SLAVE_SIZE         `CFG_AXI4_DATA_SIZE

`define CFG_AXI4_MASTER_STRB_WIDTH  2**`CFG_AXI4_MASTER_SIZE
`define CFG_AXI4_MASTER_DATA_WIDTH  `CFG_AXI4_MASTER_STRB_WIDTH*8

`define CFG_NARROW_SUPPORT          1                         //  Narrow transfer support
`define CFG_DOWNSIZE_SUPPORT        ((`CFG_NARROW_SUPPORT == 0) && (`CFG_AXI4_MASTER_SIZE > `CFG_AXI4_SLAVE_SIZE)) ? 1 : 0
`define CFG_UPSIZE_SUPPORT          ((`CFG_NARROW_SUPPORT == 0) && (`CFG_AXI4_MASTER_SIZE < `CFG_AXI4_SLAVE_SIZE)) ? 1 : 0

//  DataFlow Controller Definitions
`define CFG_DC_ROUTE_NUM            (`CFG_AXI_PORT_NUM)         //  Route Number in the Dataflow Controller
`define CFG_DC_ROUTE_WIDTH          (`CFG_DC_ROUTE_NUM == 1 ? 1: $clog2(`CFG_DC_ROUTE_NUM))   //  Route ID Width in the Dataflow Controller
`define CFG_DRAM_ADDR_MAP_WIDTH     5                           //  Address mapping field width
`define CFG_AW                      1'b0                        //  Write channel code
`define CFG_AR                      1'b1                        //  Read channel code

`define CFG_CMDADDR_MODE            0         //  Command/address mode
`define CFG_RDIMM_SUPPORT           0         //  RDIMM support mode
`define CFG_CMDADDR_BUS             1         //  Command/address bus number: 1 or CFG_DIMM_PER_CHAN
`define CFG_ODT_COUNT_WIDTH         8

`define CFG_DRAM_BL_ENC_WIDTH       2         //  DRAM burst length encoding width
`define CFG_DRAM_BL_WIDTH           6         //  DRAM burst length Width (1-based)

`define CFG_ECC_LOCAL_BUFF_DEPTH    16
//`define CFG_PROT_MEM_SIZE_WIDTH     `CFG_AXI4_ADDR_WIDTH
`define CFG_ECC_ZONE_WIDTH          `CFG_AXI4_ADDR_WIDTH - 8
`define CFG_ECC_CHK_BIT_WIDTH       8         //  For 64-bit data
`define CFG_ECC_DATA_WIDTH          8 * (`CFG_AXI4_DATA_WIDTH/64)
`define CFG_MA_WORD_PER_BL16        32/(2**`CFG_AXI4_MASTER_SIZE)
`define CFG_ECC_MA_BLEN_MAX         `CFG_MA_WORD_PER_BL16      // AXI4 Burst Lengh corresponding to 32 Bytes Data
`define CFG_ECC_SL_BLEN_MAX         `CFG_ECC_MA_BLEN_MAX/2 + 1
`define CFG_ECC_MC_CYCLE            ((2**`CFG_AXI4_MASTER_SIZE)*`CFG_ECC_MA_BLEN_MAX)/(2**`CFG_AXI4_SLAVE_SIZE)
                                    // Number of MC Clock Cycles per one DRAM burst
`define CFG_ECC_ERR_BUFF_DEPTH      16        // ECC ERROR Buffer Depth = 16
`define CFG_ECC_ERR_ADDR            12'hEA4   // Address of ECC Address Register
`define CFG_ECC_ERR_SYNDROME        12'hEA8   // Address of ECC Syndrome Register
`define CFG_ECC_ERR_SEC_DED         12'hEAC   // Address of ECC Address Register
`define CFG_ERR_CNT_WIDTH           16
`define CFG_DC_PORT_ECC             4'b0001   // Port supports Inline ECC
`define CFG_DC_PORT_WRAP            4'b0001   // Port supports WRAP burst

//`define CFG_ECC_FIFO_DEPTH          8         //  ECC buffer depth
//`define CFG_ECC_REG_ADDR            12'hE7C   //  Address of ECC code (Semper Ultra)

//  Address Mapping
`define CFG_POLICY_BICTR_WIDTH      10        //  Inter-bank timer binary counters width

// Protocol Controller/User IF Definitions
`define CFG_MC_CMD_WIDTH            5         //  MC command bus width
`define CFG_DRAM_CMD_WIDTH          6         //  DRAM command bus width
`define CFG_USER_CMD_WIDTH          5         //  User command bus width
`define CFG_USER_MRS_SEL_WIDTH      6         //  User MRS command select width
`define CFG_USER_CMD_RANK_WIDTH     2         //  User command Rank width    - Maximum 2**`CFG_USER_CMD_RANK_WIDTH ranks per channel
`define CFG_USER_CMD_CHAN_WIDTH     2         //  User command Channel width



`define CFG_MRR_DATA_WIDTH          8         //  Mode Register Read Data Width - LPDDR4/3
`define CFG_MRR_ADDR_WIDTH          `CFG_USER_MRS_SEL_WIDTH                   //  Mode Register Read Address Width - LPDDR4/3
`define CFG_DMR_DATA_WIDTH          18        //  Mode Register Width DDR4/3

`define CFG_MC_ZQ_COUNTER_WIDTH     28        //  MC Counter Width
`define CFG_MC_COUNTER_WIDTH        8         //  MC Counter Width
`define CFG_MC_W_COUNTER_WIDTH      14        //  MC Counter Width
`define CFG_MC_SW_COUNTER_WIDTH     20        //  MC Counter Width
`define CFG_PHY_COUNTER_WIDTH       8         //  PHY Counter Width
`define CFG_PHY_WIDE_COUNTER_WIDTH  22        //  PHY Counter Width

`define CFG_DRAM_CL_MAX             24        //  Maximum Value of CL for Supported Devices
`define CFG_DRAM_CWL_MAX            18        //  Maximum Value of CWL for Supported Devices
`define CFG_DRAM_RL_MAX             ((`CFG_DRAM_CL_MAX)*2-1)                    //  Maximum Value of Read Latency (RL) for Supported Devices (CL+AL, where AL=CL-1)
`define CFG_DRAM_WL_MAX             ((`CFG_DRAM_CWL_MAX)+(`CFG_DRAM_CL_MAX)-1)  //  Maximum Value of Write Latency (WL) for Supported Devices (CWL+AL)

// PHY/DFI Controller Definitions
`define CFG_PHY_DELAY_WIDTH         4         //  PHY Delay Width
`define CFG_T_PHY_WRDATA            1         //  Number of DFI PHY clock cycles between the dfi_wrdata_en signal and the associated write data is driven on the dfi_wrdata signal
`define CFG_T_PHY_RDLAT             15        //  Maximum number of DFI PHY clock cycles allowed from the assertion of the dfi_rddata_en signal to the assertion of the dfi_rddata_valid signal
`define CFG_T_CTRL_DELAY            2         //  Control delay through the PHY
`define CFG_T_WRDATA_DELAY_MIN      2         //  Minimum Write Data delay through the PHY
`define CFG_USER_CMDOP_WIDTH        2         //  User command opcode with (For MRW/MRR/MPC)
`define CFG_LPDDR_MA_WIDTH          6         //  LPDRAM Mode Register Address Width
`define CFG_LPDDR_MR_OPCODE_WIDTH   8         //  LPDRAM Mode Register Opcode Width
`define CFG_SYNC_TRAINING_SIGNALS   1       
`define CFG_PHY_DLL_STEP            128          
`define CFG_GTPH_WIDTH              4         //  Width of GTPH bus not include 2 LSB bits
`define CFG_HOLD_WIDTH              2         //  Width of GTPH bus not include 2 LSB bits
`define CFG_DATAEN_REG_WIDTH        6       
`define CFG_DATAEN_SHIFT_WIDTH      12          

// DataPath Definitions
`define CFG_MAX_AXI_BURST_LEN       16
// `define CFG_UPSIZE_MAX_LEN          ((`CFG_MAX_AXI_BURST_LEN/(2**(`CFG_AXI4_SLAVE_SIZE-`CFG_AXI4_MASTER_SIZE)))+1)
`define CFG_UPSIZE_MAX_LEN          `CFG_MAX_AXI_BURST_LEN
`define CFG_SRAM_RWM_WIDTH          3
`define CFG_ACQ_BUF_DEPTH           16        // Read/Write Address Channel Buffer Depth (2,4,8,16)
`define CFG_WCB_WBUF_DEPTH          36        // Write Channel Data Management Buffer Depth
`define CFG_RCB_RBUF_DEPTH          36        // Read Channel Data Management Buffer Depth
`define CFG_BCB_BUF_DEPTH           36        // Write Response Channel Buffer Depth
`define CFG_WCB_BUF_DEPTH           (`CFG_WCB_WBUF_DEPTH*`CFG_UPSIZE_MAX_LEN)  // Write Channel Data Buffer Depth
`define CFG_RCB_BUF_DEPTH           (`CFG_RCB_RBUF_DEPTH*`CFG_UPSIZE_MAX_LEN)  // Read Channel Data Buffer Depth

`define CFG_UPSIZE_RD_ADDR_Q_DEPTH  (`CFG_RCB_RBUF_DEPTH /*+ 10*/)
`define CFG_UPSIZE_RD_PTR_WIDTH     ($clog2(`CFG_UPSIZE_RD_ADDR_Q_DEPTH))

`define CFG_NROW_RBUF_DEPTH         (`CFG_RCB_RBUF_DEPTH /*+ 10*/)
`define CFG_NROW_PTR_WIDTH          ($clog2(`CFG_NROW_RBUF_DEPTH))
`define CFG_ACQ_PTR_WIDTH           ($clog2(`CFG_ACQ_BUF_DEPTH))     // Command Buffer Address Width
`define CFG_RCB_PTR_WIDTH           ($clog2(`CFG_RCB_RBUF_DEPTH))    // Read  Data Buffer Pointer Width
`define CFG_WCB_PTR_WIDTH           ($clog2(`CFG_WCB_WBUF_DEPTH))    // Write Data Buffer Pointer Width
`define CFG_BCB_PTR_WIDTH           ($clog2(`CFG_BCB_BUF_DEPTH))     // Write Response Buffer Address Width
`define CFG_WCB_ADDR_WIDTH          ($clog2(`CFG_WCB_BUF_DEPTH))     // Write Data Buffer Address Width
`define CFG_RCB_ADDR_WIDTH          ($clog2(`CFG_RCB_BUF_DEPTH))     // Write Data Buffer Address Width
`define CFG_RCB_RESP_WIDTH          (`CFG_RCB_PTR_WIDTH+`CFG_AXI4_LEN_WIDTH+`CFG_BCB_PTR_WIDTH)
`define CFG_WCB_RESP_WIDTH          (`CFG_WCB_PTR_WIDTH+`CFG_AXI4_LEN_WIDTH+`CFG_BCB_PTR_WIDTH)
`define CFG_RCB_DATA_WIDTH          (`CFG_AXI4_DATA_WIDTH)
`define CFG_WCB_DATA_WIDTH          (`CFG_AXI4_DATA_WIDTH)

`define CFG_RCB_TAG_WIDTH           (`CFG_DC_ROUTE_WIDTH+`CFG_RCB_RESP_WIDTH )  // ecc, rmw, prot
`define CFG_WCB_TAG_WIDTH           (`CFG_DC_ROUTE_WIDTH+`CFG_WCB_RESP_WIDTH )      // ecc, prot
`define CFG_WCB_STRB_WIDTH          ((`CFG_WCB_DATA_WIDTH)/8)    // 8 bits

`define CFG_RCB_BUF_WIDTH           (`CFG_RCB_DATA_WIDTH)                         // 128 for double data bus
`define CFG_WCB_BUF_WIDTH           ((`CFG_WCB_DATA_WIDTH)+(`CFG_WCB_STRB_WIDTH)) // 144 for double data bus

`define CFG_CHAN_LAT_BARRIER_WIDTH  8      // Width of the registers defining the maximum latency barrier

// BRIF/Crossover Queue (XQ) Definitions
`define CFG_BRIF_QOS_WIDTH          2                                 //  BRIF QOS Width
`define CFG_BRIF_PRI_WIDTH          (`CFG_BRIF_QOS_WIDTH+1)           //  BRIF Priority Width, 1 bit for Real-time
`define CFG_BRIF_PRI_ONEHOT         (2**`CFG_BRIF_QOS_WIDTH+1)        //  BRIF Priority Width in One-hot Form
`define CFG_BRIF_TAGID_WIDTH        (`CFG_DC_ROUTE_WIDTH)

`define CFG_XQ_SHIFT_MASK_WIDTH     16       // Corresponds to the Current Maximum of 16 (double) Words of DRAM Access
`define CFG_XQR_DATA_WIDTH          ((`CFG_BRIF_TAGID_WIDTH)+(`CFG_RCB_RESP_WIDTH) +1)    // prot, ecc, rmw, last
`define CFG_XQR_FIFO_DEPTH          (((`CFG_XQR_SHIFT_REG_WIDTH)+(`CFG_T_PHY_RDLAT))/2)                // XQR Tag FIFO Depth
`define CFG_XQR_SHIFT_REG_WIDTH     ((`CFG_DRAM_RL_MAX)+(`CFG_XQ_SHIFT_MASK_WIDTH)+1)
`define CFG_XQR_SHIFT_DELAY_WIDTH   ($clog2(`CFG_XQR_SHIFT_REG_WIDTH))

`define CFG_XQW_DATA_WIDTH          ((`CFG_BRIF_TAGID_WIDTH)+(`CFG_WCB_RESP_WIDTH) +1)        // prot, ecc, rmw
`define CFG_XQW_FIFO_DEPTH          ((`CFG_XQW_SHIFT_REG_WIDTH)/2)            // XQR Tag FIFO Depth
`define CFG_XQW_SHIFT_REG_WIDTH     ((`CFG_DRAM_WL_MAX)+(`CFG_XQ_SHIFT_MASK_WIDTH)+1)
`define CFG_XQW_SHIFT_DELAY_WIDTH   ($clog2(`CFG_XQW_SHIFT_REG_WIDTH))

`define CFG_XQ_T_CAL_WIDTH          4

//  BUS Merge
`define CFG_CHAN_LAT_WIDTH          6
`define CFG_ACR_BUFF_DEPTH          8
`define CFG_ACR_PIPE_STAGE          2
`define CFG_ACR_REQ_THRESHOLD       ($clog2(`CFG_ACR_BUFF_DEPTH))
`define CFG_AXI_BURST_BYTES_WIDTH   10
`define CFG_AXI_WORD_PTR_WIDTH      ($clog2(`CFG_MAX_AXI_BURST_LEN))
`define CFG_DRAM_BANK_STATUS_WIDTH  (`CFG_DRAM_ROW_WIDTH+4+`CFG_DRAM_RANK_WIDTH)
//  0: dram_row_addr
//  1: dram_rank_addr
//  2: bank_status_ready
//  3: bank_status_idle
//  4: bank_status_cas_active
//  5: bank_status_cas_idle
`define CFG_AXI_INFO_WIDTH          (`CFG_AXI4_ID_WIDTH+`CFG_AXI4_ADDR_WIDTH+`CFG_AXI4_BURST_WIDTH+`CFG_AXI4_LEN_WIDTH+`CFG_AXI4_SIZE_WIDTH+`CFG_AXI4_QOS_WIDTH)
//  0:  axi_acqos_rt
//  1:  axi_acsize_rt
//  2:  axi_acburst_rt
//  3:  axi_aclen_rt
//  4:  axi_acaddr_rt
//  5:  axi_acid_rt
`define CFG_ACQ_INFO_WIDTH          (`CFG_AXI_INFO_WIDTH-`CFG_AXI4_BURST_WIDTH+1+1+`CFG_BCB_PTR_WIDTH+`CFG_WCB_PTR_WIDTH)
//  0:  axi_acqos_rt
//  1:  axi_acsize_rt
//  2:  axi_acburst_wrap
//  3:  axi_acburst_fixed
//  4:  axi_aclen_rt
//  5:  axi_acaddr_rt
//  6:  axi_acid_rt
//  7:  db_alloc_ptr
//  8:  bb_alloc_ptr
`define CFG_ACR_INFO_WIDTH          (`CFG_DRAM_COL_WIDTH+`CFG_DRAM_ROW_WIDTH+`CFG_DRAM_BA_WIDTH+`CFG_DRAM_RANK_WIDTH+`CFG_DRAM_CHAN_WIDTH+`CFG_WCB_PTR_WIDTH+`CFG_AXI_WORD_PTR_WIDTH+`CFG_DRAM_BL_WIDTH+`CFG_BCB_PTR_WIDTH+`CFG_BRIF_QOS_WIDTH+1+1+1)
//  0:  dram_col_addr
//  1:  dram_row_addr
//  2:  dram_bank_addr
//  3:  dram_rank_addr
//  4:  dram_channel_addr
//  5:  write_mask
//  6:  burst_fixed
//  7:  dram_burst_last
//  8:  db_alloc_ptr
//  9:  db_data_offset
// 10:  db_data_num
// 11:  bb_alloc_ptr
// 12:  acr_ext_qos

`define CFG_ACQ_STARV_WIDTH         8
`define CFG_ADDR_CONFIG_WIDTH       ((`CFG_DRAM_CHAN_WIDTH+`CFG_DRAM_RANK_WIDTH+`CFG_DRAM_BA_WIDTH+`CFG_DRAM_ROW_WIDTH+`CFG_DRAM_COL_WIDTH)*(`CFG_DRAM_ADDR_MAP_WIDTH))
`define CFG_COL_CONFIG_WIDTH        (`CFG_DRAM_COL_WIDTH*`CFG_DRAM_ADDR_MAP_WIDTH)
`define CFG_PRI_CONFIG_WIDTH        (1+1+1+1+`CFG_CHAN_LAT_BARRIER_WIDTH)
//  0:  reg_realtime_enable_rt
//  1:  reg_ext_priority_rt
//  2:  reg_max_priority_rt
//  3:  reg_latency_enable_rt
//  4:  reg_latency_barrier_rt
`define CFG_ACR_RAS_INFO_WIDTH      (`CFG_DRAM_CHAN_WIDTH+`CFG_DRAM_RANK_WIDTH+`CFG_DRAM_BA_WIDTH+`CFG_DRAM_ROW_WIDTH)
//  0:  dram_row_addr
//  1:  dram_bank_addr
//  2:  dram_rank_addr
//  3:  dram_channel_addr

`define CFG_ACR_CAS_INFO_WIDTH      (1+1+`CFG_DRAM_COL_WIDTH+1+`CFG_WCB_PTR_WIDTH+`CFG_AXI_WORD_PTR_WIDTH+`CFG_DRAM_BL_WIDTH+`CFG_BCB_PTR_WIDTH)
//  0:  write_mask
//  1:  burst_fixed
//  2:  dram_col_addr
//  3:  dram_burst_last
//  4:  db_alloc_ptr
//  5:  db_data_offset
//  6:  db_data_num
//  7:  bb_alloc_ptr
`define CFG_ACR_LAHEAD_INFO_WIDTH   (`CFG_ACR_RAS_INFO_WIDTH+1+`CFG_WCB_PTR_WIDTH+`CFG_AXI_WORD_PTR_WIDTH+`CFG_DRAM_BL_WIDTH+`CFG_BRIF_QOS_WIDTH+1+1+1)
//  0:  dram_row_addr
//  1:  dram_bank_addr
//  2:  dram_rank_addr
//  3:  dram_channel_addr
//  4:  dram_burst_last
//  5:  db_alloc_ptr
//  6:  db_data_offset
//  7:  db_data_num
//  8:  brif_qos
//  9:  write_mask
// 10:  burst_fixed
// 11:  info_valid

//    AXI4 Asynchronous Configuration
`define CFG_DC_PORT_ASYNC             8'b1111_1111
`define CFG_ASYNC_FIFO_DEPTH          8
`define CFG_ASYNC_FIFO_SRAM           0   //  0: FF, 1: SRAM
`define CFG_REG_BLOCK_ASYNC

//  DFI Controller Definitions
`define CFG_PHY_VREF_WIDTH            6  //  VREF bus width
`define CFG_PHY_WDQ_DLY_WIDTH         8
`define CFG_PHY_WDM_DLY_WIDTH         8
`define CFG_PHY_CMD_DLY_WIDTH         7
`define CFG_PHY_GATE_DLY_WIDTH        6  //  Gate training delay width
`define CFG_PHY_RDLVL_DLY_WIDTH       8  //  Data-eye training delay width
`define CFG_PHY_WRLVL_DLY_WIDTH       8  //  Write leveling delay width
`define CFG_PHY_WRLVL_RESP_WIDTH      8  //  Write leveling response width
`define CFG_PHY_CALVL_DLY_WIDTH       7
`define CFG_PHY_CALVL_SET_WIDTH       7
`define CFG_PHY_CALVL_DATA_WIDTH      7
`define CFG_PHY_CSLVL_DLY_WIDTH       7
`define CFG_PHY_CSLVL_SET_WIDTH       7
`define CFG_PHY_DQ_TRANS              5
`define CFG_PHY_DQEYE_WIDTH           7
`define CFG_PHY_CTRL_WIDTH            30

//  DLL Definitions
`define CFG_DLL_LIM_WIDTH             5
`define CFG_DLL_BYPC_WIDTH            8
`define CFG_CLK_DLY_WIDTH             6

// BIST default configurations 
`define CFG_BIST_ENABLE

// default March algorithm (MATS)
//`define CFG_BIST_MARCH_ELEMENT_0    32'b100_100_100_000_000_000_000_000_000_000_00 // up: w0, w0 
//`define CFG_BIST_MARCH_ELEMENT_1    32'b101_000_000_000_000_000_000_000_000_000_00 // up: nop (retention time)
//`define CFG_BIST_MARCH_ELEMENT_2    32'b110_010_101_000_000_000_000_000_000_000_00 // up: r0, w1 
//`define CFG_BIST_MARCH_ELEMENT_3    32'b001_000_000_000_000_000_000_000_000_000_00 // down: nop (retention time)
//`define CFG_BIST_MARCH_ELEMENT_4    32'b010_011_100_000_000_000_000_000_000_000_00 // down: r1, w0
//`define CFG_BIST_MARCH_ELEMENT_5    32'b000_000_000_000_000_000_000_000_000_000_00
//`define CFG_BIST_MARCH_ELEMENT_6    32'b000_000_000_000_000_000_000_000_000_000_00
//`define CFG_BIST_MARCH_ELEMENT_7    32'b000_000_000_000_000_000_000_000_000_000_00
//`define CFG_BIST_MARCH_ELEMENT_8    32'b000_000_000_000_000_000_000_000_000_000_00
//`define CFG_BIST_MARCH_ELEMENT_9    32'b000_000_000_000_000_000_000_000_000_000_00
//`define CFG_BIST_MARCH_ELEMENT_10   32'b000_000_000_000_000_000_000_000_000_000_00
//`define CFG_BIST_MARCH_ELEMENT_11   32'b000_000_000_000_000_000_000_000_000_000_00
//`define CFG_BIST_MARCH_ELEMENT_12   32'b000_000_000_000_000_000_000_000_000_000_00
//`define CFG_BIST_MARCH_ELEMENT_13   32'b000_000_000_000_000_000_000_000_000_000_00
//`define CFG_BIST_MARCH_ELEMENT_14   32'b000_000_000_000_000_000_000_000_000_000_00
//`define CFG_BIST_MARCH_ELEMENT_15   32'b000_000_000_000_000_000_000_000_000_000_00
//`define CFG_BIST_ELEMENT_NUMBER     5 
//`define CFG_BIST_OPERATION_NUMBER   2

// IFA13 March algorithm
//`define CFG_BIST_MARCH_ELEMENT_0    32'b100_100_100_100_100_100_100_000_000_000_00 // up: w0, w0, w0
//`define CFG_BIST_MARCH_ELEMENT_1    32'b100_010_101_011_100_010_101_000_000_000_00 // up: r0, w1, r1
//`define CFG_BIST_MARCH_ELEMENT_2    32'b110_011_100_101_101_101_101_000_000_000_00 // up: r1, w0, r0
//`define CFG_BIST_MARCH_ELEMENT_3    32'b000_011_100_101_100_100_100_000_000_000_00 // down: nop (retention time)
//`define CFG_BIST_MARCH_ELEMENT_4    32'b010_010_101_100_100_100_100_000_000_000_00 // down: r0, w1, r1
//`define CFG_BIST_MARCH_ELEMENT_5    32'b000_000_000_000_000_000_000_000_000_000_00 // down: nop (retention time)
//`define CFG_BIST_MARCH_ELEMENT_6    32'b000_000_000_000_000_000_000_000_000_000_00 // down: r1, w0, r0
//`define CFG_BIST_MARCH_ELEMENT_7    32'b000_000_000_000_000_000_000_000_000_000_00
//`define CFG_BIST_MARCH_ELEMENT_8    32'b000_000_000_000_000_000_000_000_000_000_00
//`define CFG_BIST_MARCH_ELEMENT_9    32'b000_000_000_000_000_000_000_000_000_000_00
//`define CFG_BIST_MARCH_ELEMENT_10   32'b000_000_000_000_000_000_000_000_000_000_00
//`define CFG_BIST_MARCH_ELEMENT_11   32'b000_000_000_000_000_000_000_000_000_000_00
//`define CFG_BIST_MARCH_ELEMENT_12   32'b000_000_000_000_000_000_000_000_000_000_00
//`define CFG_BIST_MARCH_ELEMENT_13   32'b000_000_000_000_000_000_000_000_000_000_00
//`define CFG_BIST_MARCH_ELEMENT_14   32'b000_000_000_000_000_000_000_000_000_000_00
//`define CFG_BIST_MARCH_ELEMENT_15   32'b000_000_000_000_000_000_000_000_000_000_00
//`define CFG_BIST_ELEMENT_NUMBER     5
//`define CFG_BIST_OPERATION_NUMBER   6
// primary data background number, (log2 (DQ_BITS) + 1)
//`define CFG_BIST_BACKGROUND_NUMBER  4

// `define CFG_BIST_END_RANK (`CFG_DRAM_RANK_NUM - 1)
// `define CFG_BIST_END_RANK           1
// `define CFG_BIST_END_BANK           (`CFG_DRAM_BANK_NUM - 1)
// `define CFG_BIST_END_BANK_GRP       (`CFG_DRAM_BG_NUM - 1)
// `define CFG_BIST_END_ROW_ADDR       4
// `define CFG_BIST_END_COL_ADDR       16
// `define CFG_BIST_END_BACKGROUND     (`CFG_BIST_BACKGROUND_NUMBER - 1)
// `define CFG_BIST_END_ELEMENT        (`CFG_BIST_ELEMENT_NUMBER - 1)
// `define CFG_BIST_END_OPERATION      (`CFG_BIST_OPERATION_NUMBER - 1)
// `define CFG_DRAM_BURST_LENGTH       8
// `define CFG_BIST_END_RETENTION      1

`ifdef  SIM
  `define   CLKQ_DLY  #50ps
`else
  `define   CLKQ_DLY
`endif

//_dti_global_defines_
