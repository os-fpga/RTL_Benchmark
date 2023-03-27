// Command encoding
// MC Commands (DRAM Commands Encoded)
parameter MC_CMD_IDLE         = 5'b00001;      // Idle
parameter MC_CMD_PDE          = 5'b00010;      // Power Down Entry
parameter MC_CMD_PDX          = 5'b00011;      // Power Down Exit
parameter MC_CMD_DES          = 5'b11111;      // Device De-select
parameter MC_CMD_ZQRS         = 5'b00101;      // ZQ Calibration Reset
parameter MC_CMD_SRE          = 5'b00110;      // Self-Refresh Entry
parameter MC_CMD_SRX          = 5'b00111;      // Self-Refresh Exit
parameter MC_CMD_REFA         = 5'b01000;      // Refresh All Bank
parameter MC_CMD_MRW          = 5'b01001;      // Mode Register Write - LPDDR
parameter MC_CMD_MRR          = 5'b01010;      // Mode Register Read - LPDDR
parameter MC_CMD_ACT          = 5'b01011;      // Activate
parameter MC_CMD_WR           = 5'b01100;      // Write
parameter MC_CMD_WM           = 5'b01101;      // Write Masked
parameter MC_CMD_RD           = 5'b01110;      // Read
parameter MC_CMD_PRE          = 5'b01111;      // Precharge
parameter MC_CMD_NOP          = 5'b10000;      // NOP
parameter MC_CMD_ZQSTART      = 5'b10001;      // ZQSTART - LPDDR4
parameter MC_CMD_ZQLAT        = 5'b10010;      // ZQLATCH - LPDDR4
parameter MC_CMD_RDFIFO       = 5'b10011;      // Read FIFO - LPDDR4
parameter MC_CMD_WRFIFO       = 5'b10100;      // Write FIFO - LPDDR4
parameter MC_CMD_DQSOSC_START = 5'b10101;      // Start DQS Oscillator
parameter MC_CMD_DQSOSC_STOP  = 5'b10110;      // Stop DQS Oscillator
parameter MC_CMD_NVR          = 5'b10111;      // NVR
parameter MC_CMD_MRS          = 5'b11000;      // Mode Register Set - DDR3/4
parameter MC_CMD_MPSE         = 5'b11001;      // Maximum Power Saving Entry - DDR4
parameter MC_CMD_MPSX         = 5'b11010;      // Maximum Power Saving Exit  - DDR4
parameter MC_CMD_ZQCL         = 5'b11011;      // ZQ Calibration Long
parameter MC_CMD_ZQCS         = 5'b11100;      // ZQ Calibration Short
parameter MC_CMD_DPDE         = 5'b11101;      // Deep Power Down Entry
parameter MC_CMD_DPDX         = 5'b11110;      // Deep Power Down Exit
// DDR Commands
parameter DRAM_CMD_DES      = 6'b011111,   //  Device De-select
          DRAM_CMD_IDLE     = 6'b001111,   //  Idle
          DRAM_CMD_NOP      = 6'b010111,   //  No Operation
          DRAM_CMD_PRE      = 6'b010010,   //  Precharge (A10 - High for all ddr2_banks)
          DRAM_CMD_MRS      = 6'b010000,   //  Mode Register Set
          DRAM_CMD_REF      = 6'b010001,   //  Refresh
          DRAM_CMD_ZQCAL    = 6'b010110,   //  ZQ Calibration
          DRAM_CMD_PDE      = 6'b001111,   //  Power Down Entry
          DRAM_CMD_PDX      = 6'b010111,   //  Power Down Exit
          DRAM_CMD_SRE      = 6'b000001,   //  Self Refresh Entry
          DRAM_CMD_SRX      = 6'b010111,   //  Self Refresh Exit
          DRAM_CMD_ACT      = 6'b010011,   //  Activate
          DRAM_CMD_RD       = 6'b010101,   //  Read
          DRAM_CMD_WR       = 6'b010100,   //  Write
          DRAM_CMD_MPSX     = 6'b010111;   //  MPS Exit
// LPDDR Commands
parameter LP_DRAM_CMD_IDLE         = 6'b0_1_1111;   // Idle, Maintain PD/SREF/DPD
parameter LP_DRAM_CMD_MRW          = 6'b1_0_0000;   // Mode Register Write
parameter LP_DRAM_CMD_MRR          = 6'b1_0_0001;   // Mode Register Read
parameter LP_DRAM_CMD_REFP         = 6'b1_0_0010;   // Refresh per bank
parameter LP_DRAM_CMD_REFA         = 6'b1_0_0011;   // Refresh all bank
parameter LP_DRAM_CMD_SRE          = 6'b1_0_0100;   // Enter Self Refresh 
parameter LP_DRAM_CMD_SRE_LP4      = 6'b1_1_1000;   // Enter Self Refresh - LPDDR4, Don't care value
parameter LP_DRAM_CMD_SRX          = 6'b1_0_0101;   // Exit Self Refresh
parameter LP_DRAM_CMD_ACT          = 6'b1_0_0110;   // Active
parameter LP_DRAM_CMD_WR           = 6'b1_0_0111;   // Write
parameter LP_DRAM_CMD_WM           = 6'b1_0_1000;   // Write Masked
parameter LP_DRAM_CMD_RD           = 6'b1_0_1001;   // Read
parameter LP_DRAM_CMD_PRE          = 6'b1_0_1010;   // Precharge
parameter LP_DRAM_CMD_NVR          = 6'b1_0_1011;   // NVR
parameter LP_DRAM_CMD_NOP          = 6'b1_1_1111;   // NOP
parameter LP_DRAM_CMD_PDE          = 6'b0_1_0001;   // Enter Power-Down
parameter LP_DRAM_CMD_PDX          = 6'b1_1_0001;   // Exit Power-Down
parameter LP_DRAM_CMD_ZQSTART      = 6'b1_1_0010;   // ZQSTART - LPDDR4, Don't care value
parameter LP_DRAM_CMD_ZQLAT        = 6'b1_1_0011;   // ZQLATCH - LPDDR4, Don't care value
parameter LP_DRAM_CMD_RDFIFO       = 6'b1_1_0100;   // Read FIFO - LPDDR4, Don't care value
parameter LP_DRAM_CMD_WRFIFO       = 6'b1_1_0101;   // Write FIFO - LPDDR4, Don't care value
parameter LP_DRAM_CMD_DQSOSC_START = 6'b1_1_0110;   // Start DQS Oscillator, Don't care value
parameter LP_DRAM_CMD_DQSOSC_STOP  = 6'b1_1_0111;   // Stop DQS Oscillator, Don't care value
parameter LP_DRAM_CMD_DPDE         = 6'b1_1_1001;   // Enter Deep Power-Down
parameter LP_DRAM_CMD_DPDX         = 6'b1_1_1010;   // Exit Deep Power-Down
parameter LP_DRAM_CMD_BST          = 6'b1_0_1100; // Burst Terminate

parameter LP_DRAM_CMD_IDX_CKE      = 5;
parameter LP_DRAM_CMD_IDX_CS       = 4;
parameter LP_DRAM_CMD_IDX_CA0      = 3;
parameter LP_DRAM_CMD_IDX_CA1      = 2;
parameter LP_DRAM_CMD_IDX_CA2      = 1;
parameter LP_DRAM_CMD_IDX_CA3      = 0;

// User Command Encoded
parameter USER_CMD_INIT         = 5'b00000,   //  Start Device Initialization
          USER_CMD_STOP         = 5'b00001,   //  Stop Normal Operation
          USER_CMD_RUN          = 5'b00010,   //  Start Normal Operation
          USER_CMD_MRS          = 5'b00011,   //  Execute MRW/MRS to DRAM (Mode Register Write/Set - DDR4/3/2)
          USER_CMD_MPRR         = 5'b00100,   //  Execute MPR Read to DRAM (Mode Register Read - DDR4 only).
          USER_CMD_MPRW         = 5'b00101,   //  Execute MPR Write to DRAM (Mode Register Write - DDR4 only)
          USER_CMD_SRE          = 5'b00110,   //  Self-Refresh Mode Entry
          USER_CMD_SRX          = 5'b00111,   //  Self-Refresh Mode Exit
          USER_CMD_PDE          = 5'b01000,   //  Power-Down Mode Entry
          USER_CMD_PDX          = 5'b01001,   //  Power-Down Mode Exit
          USER_CMD_MPSE         = 5'b01010,   //  Maximum Power Saving Mode Entry - DDR4 only
          USER_CMD_MPSX         = 5'b01011,   //  Maximum Power Saving Mode Exit - DDR4 only
          USER_CMD_ZQCS         = 5'b01100,   //  ZQ Calibration Short
          USER_CMD_ZQCL         = 5'b01101,   //  ZQ Calibration Long
          USER_CMD_ZQRS         = 5'b01110,   //  ZQ Calibration Reset – LPDDR2/3
          USER_CMD_DFIOP        = 5'b01111,   //  DFI Training Operation
          USER_CMD_PHYOP        = 5'b10000,   //  PHY Startup Operation
          USER_CMD_MRR          = 5'b10001,   //  Mode Register Read – LPDDR2/3/4
          USER_CMD_MRW          = 5'b10010,   //  Mode Register Write – LPDDR2/3/4
          USER_CMD_DPDE         = 5'b10011,   //  Deep Power-Down Mode Entry – LPDDR3
          USER_CMD_DPDX         = 5'b10100,   //  Deep Power-Down Mode Exit – LPDDR3
          USER_CMD_BIST         = 5'b10101,   //  BIST
          USER_CMD_ZQSTART      = 5'b10110,   //  ZQSTART - LPDDR4
          USER_CMD_ZQLAT        = 5'b10111,   //  ZQLAT - LPDDR4
          USER_CMD_DQSOSC_START = 5'b11000,   //  Start DQS Oscillator - LPDDR4
          USER_CMD_DQSOSC_STOP  = 5'b11001,         
          USER_CMD_PHYOPE       = 5'b11010,         
          USER_CMD_PHYOPX       = 5'b11011;   

////ceil of the log base 2
//function integer ceil_log2 (input integer data);
//  integer i;
//  ceil_log2 = 1;
//  for (i = 0; 2**i < data; i = i + 1)
//    ceil_log2 = i + 1;
//endfunction
//
//function integer last_one(input integer data, input integer end_bit);
//  integer i;
//  last_one = 0;
//  for (i = 0; i <= end_bit; i = i + 1) begin
//    if ((data >> i) % 2) last_one = i + 1;
//  end
//endfunction
//
////floor of the log base 2
//function automatic integer floor_log2 (input integer value_int_i);
//  integer ceil_log2;
//
//  for (ceil_log2 = 0; (1 << ceil_log2) < value_int_i; ceil_log2 = ceil_log2 + 1)
//    floor_log2 = ceil_log2;
//  if ((1 << ceil_log2) == value_int_i)
//    floor_log2 = ceil_log2;
//  else
//    floor_log2 = ceil_log2 - 1;
//endfunction
//
//function integer is_onethot (input integer N);
//  integer i;
//  is_onethot = 0;
//  for(i = 0; i < N; i=i+1) begin
//    if(N == 2**i) begin
//      is_onethot = 1;
//    end
//  end
//endfunction
//
//function integer ecc_width (input integer data_width);
//  integer i;
//  ecc_width = 0;
//  for(i = 0; i <= data_width; i=i+1) begin
//    if(is_onethot(i)) begin
//      ecc_width = ecc_width + 1;
//    end
//  end
//endfunction
