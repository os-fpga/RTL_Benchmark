`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Ampleon
// Engineer: John Clayton
// 
// Create Date: 05/20/2016
// Design Name: MMC Tester
// Module Name: arty_main
// Project Name: Sango X7
// Target Devices: XC7A35T
// Tool Versions: 
// Description: 10ns CLK
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`define CLOCK_FREQ 100000000

module top(
  input         CLK,
  input         ck_rst,
  input  [ 3:0] SW,
  input  [ 3:0] BTN,
  input         UART_CMD_i,
  output        UART_RSP_o,
  output        RGB0_Blue,
  output        RGB0_Green,
  output        RGB0_Red,
  output        RGB1_Blue,
  output        RGB1_Green,
  output        RGB1_Red,
  output        RGB2_Blue,
  output        RGB2_Green,
  output        RGB2_Red,
  output        RGB3_Blue,
  output        RGB3_Green,
  output        RGB3_Red,
  output [ 3:0] LED,
  inout  [ 7:0] ja,
  inout  [ 7:0] jb,
  inout  [ 7:0] jc,
  inout  [ 7:0] jd
);

//------------------------------------------------------------------------
// Local signals
reg  [39:0] count1;
wire        sys_clk;
wire        sys_rst_n;
wire [15:0] led_l;

// MMC tester
wire        mmc_clk;
wire        mmc_clk_oe;
wire        mmc_cmd;
wire        mmc_cmd_oe;
wire        mmc_cmd_zzz;
wire        mmc_cmd_choice;
wire  [7:0] mmc_dat;
wire  [7:0] mmc_dat_zzz;
wire  [7:0] mmc_dat_choice1;
wire  [7:0] mmc_dat_choice2;
reg   [7:0] mmc_dat_choice3;
wire        mmc_od_mode;
wire        mmc_dat_oe;
wire  [1:0] mmc_dat_siz;
wire  [7:0] switch;
wire        mmc_tlm;
wire        syscon_rsp;

// MMC card I/O proxy signals
// (They are mapped to jb and jc ports)
wire        MMC_CLK_io;
wire        MMC_CMD_io;
wire  [7:0] MMC_DAT_io;
wire        MMC_CLK_i;
wire        MMC_CMD_i;
wire  [7:0] MMC_DAT_i;

//------------------------------------------------------------------------
// Start of logic

assign sys_clk = CLK;
assign sys_rst_n = ck_rst;

// Create a counter to display on the LEDs
always @(posedge sys_clk)
  if (!sys_rst_n) begin
    count1 <= 0;
  end
  else begin
    count1 <= count1+1;
  end

// Assign outputs
assign RGB0_Blue  = SW[3]?count1[39]:led_l[15];
assign RGB0_Green = SW[3]?count1[38]:led_l[14];
assign RGB0_Red   = SW[3]?count1[37]:led_l[13];
assign RGB1_Blue  = SW[3]?count1[36]:led_l[12];
assign RGB1_Green = SW[3]?count1[35]:led_l[11];
assign RGB1_Red   = SW[3]?count1[34]:led_l[10];
assign RGB2_Blue  = SW[3]?count1[33]:led_l[9];
assign RGB2_Green = SW[3]?count1[32]:led_l[8];
assign RGB2_Red   = SW[3]?count1[31]:led_l[7];
assign RGB3_Blue  = SW[3]?count1[30]:led_l[6];
assign RGB3_Green = SW[3]?count1[29]:led_l[5];
assign RGB3_Red   = SW[3]?count1[28]:led_l[4];
assign LED        = SW[3]?(count1[27:24] ^ SW):led_l[3:0];

  mmc_tester #(
    .SYS_CLK_RATE         (100000000.0),    // Fast I/O read/write (app specific)
    .SYS_LEDS             (16),
    .SYS_SWITCHES         (8),
    .EXT_CSD_INIT_FILE    ("ext_csd_init.txt"), // Initial contents of EXT_CSD
    .HOST_RAM_ADR_BITS    (14), // Determines amount of BRAM in MMC host
    .MMC_FIFO_DEPTH       (2048),
    .MMC_FILL_LEVEL_BITS  (14),
    .MMC_RAM_ADR_BITS     (17)
  ) mmc_tester_0 (

    // Asynchronous reset
    .sys_rst_n     (sys_rst_n),
    .sys_clk       (sys_clk),

    // Asynchronous serial interface
    .cmd_i         (UART_CMD_i),
    .resp_o        (syscon_rsp),

    // Board related
    .switch_i      (switch),
    .led_o         (led_l),

    // Interface for SD/MMC traffic logging
    // via asynchronous serial transmission
    .tlm_send_i    (SW[3]),
    .tlm_o         (mmc_tlm),

    // Tester Function Enables
    .slave_en_i    (SW[2]),
    .host_en_i     (SW[1]),

    // SD/MMC card signals
    .mmc_clk_i     (MMC_CLK_i),
    .mmc_clk_o     (mmc_clk),
    .mmc_clk_oe_o  (mmc_clk_oe),
    .mmc_cmd_i     (MMC_CMD_i),
    .mmc_cmd_o     (mmc_cmd),
    .mmc_cmd_oe_o  (mmc_cmd_oe),
    .mmc_dat_i     (MMC_DAT_i),
    .mmc_dat_o     (mmc_dat),
    .mmc_dat_oe_o  (mmc_dat_oe),
    .mmc_od_mode_o (mmc_od_mode),  // open drain mode, applies to sd_cmd_o and sd_dat_o
    .mmc_dat_siz_o (mmc_dat_siz)

  );
  assign switch = {BTN, SW};

  assign UART_RSP_o = SW[3]?mmc_tlm:syscon_rsp;


  // Implement MMC card tri-state drivers at the top level
    // Drive the clock output when needed
  assign MMC_CLK_io = mmc_clk_oe?mmc_clk:1'bZ;
    // Select which data vector to use
  assign mmc_dat_choice1 = mmc_od_mode?mmc_dat_zzz:mmc_dat;
  assign mmc_dat_choice2 = mmc_dat_oe?mmc_dat_choice1:8'bZ;
    // Create mmc command signals
  assign mmc_cmd_zzz    = mmc_cmd?1'bZ:1'b0;
  assign mmc_cmd_choice = mmc_od_mode?mmc_cmd_zzz:mmc_cmd;
  assign MMC_CMD_io = mmc_cmd_oe?mmc_cmd_choice:1'bZ;
    // Create "open drain" data vector
  genvar j;
  for(j=0;j<8;j=j+1) begin
    assign mmc_dat_zzz[j] = mmc_dat[j]?1'bZ:1'b0;
  end
    // Select which data vector to use
  assign mmc_dat_choice1 = mmc_od_mode?mmc_dat_zzz:mmc_dat;
  assign mmc_dat_choice2 = mmc_dat_oe?mmc_dat_choice1:8'bZ;
    // Use always block for readability
  always @(mmc_dat_siz, mmc_dat_choice2)
         if (mmc_dat_siz==0) mmc_dat_choice3 <= {7'bZ,mmc_dat_choice2[0]};
    else if (mmc_dat_siz==1) mmc_dat_choice3 <= {4'bZ,mmc_dat_choice2[3:0]};
    else                     mmc_dat_choice3 <= mmc_dat_choice2;

  assign MMC_DAT_io = mmc_dat_choice3;

  // Map the MMC I/O proxies to actual I/O signals
  assign jb[6] = MMC_CLK_io;
  assign jb[2] = MMC_CMD_io;
  assign jc[4] = MMC_DAT_io[0];
  assign jc[0] = MMC_DAT_io[1];
  assign jc[7] = MMC_DAT_io[2];
  assign jc[3] = MMC_DAT_io[3];
  assign jc[6] = MMC_DAT_io[4];
  assign jc[2] = MMC_DAT_io[5];
  assign jc[5] = MMC_DAT_io[6];
  assign jc[1] = MMC_DAT_io[7];

  // Map the MMC input proxies to actual I/O signals
  assign MMC_CLK_i = jb[6];
  assign MMC_CMD_i = jb[2];
  assign MMC_DAT_i = {jc[1], jc[5], jc[2], jc[6], jc[3], jc[7], jc[0], jc[4]};

endmodule
