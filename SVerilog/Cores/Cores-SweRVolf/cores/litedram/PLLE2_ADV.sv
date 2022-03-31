module PLLE2_ADV #(
  parameter         BANDWIDTH = "OPTIMIZED",
  parameter         COMPENSATION = "ZHOLD",
  parameter         STARTUP_WAIT = "FALSE",
  parameter integer CLKOUT0_DIVIDE = 1,
  parameter integer CLKOUT1_DIVIDE = 1,
  parameter integer CLKOUT2_DIVIDE = 1,
  parameter integer CLKOUT3_DIVIDE = 1,
  parameter integer CLKOUT4_DIVIDE = 1,
  parameter integer CLKOUT5_DIVIDE = 1,
  parameter integer DIVCLK_DIVIDE = 1,
  parameter integer CLKFBOUT_MULT = 5,
  parameter real    CLKFBOUT_PHASE = 0.000,
  parameter real    CLKIN1_PERIOD = 0.000,
  parameter real    CLKIN2_PERIOD = 0.000,
  parameter real    CLKOUT0_DUTY_CYCLE = 0.500,
  parameter real    CLKOUT1_DUTY_CYCLE = 0.500,
  parameter real    CLKOUT2_DUTY_CYCLE = 0.500,
  parameter real    CLKOUT3_DUTY_CYCLE = 0.500,
  parameter real    CLKOUT4_DUTY_CYCLE = 0.500,
  parameter real    CLKOUT5_DUTY_CYCLE = 0.500,
  parameter real    CLKOUT0_PHASE = 0.000,
  parameter real    CLKOUT1_PHASE = 0.000,
  parameter real    CLKOUT2_PHASE = 0.000,
  parameter real    CLKOUT3_PHASE = 0.000,
  parameter real    CLKOUT4_PHASE = 0.000,
  parameter real    CLKOUT5_PHASE = 0.000,
  parameter real    REF_JITTER1 = 0.010,
  parameter real    REF_JITTER2 = 0.010
) (
  input  wire         CLKIN1,
  input  wire         CLKIN2,
  input  wire         CLKINSEL,

  input  wire         CLKFBIN,
  output wire         CLKFBOUT,

  output wire         CLKOUT0,
  output wire         CLKOUT1,
  output wire         CLKOUT2,
  output wire         CLKOUT3,
  output wire         CLKOUT4,
  output wire         CLKOUT5,

  input  wire [6:0]   DADDR,
  input  wire         DCLK,
  input  wire         DEN,
  input  wire [15:0]  DI,
  output wire [15:0]  DO,
  output wire         DRDY,
  input  wire         DWE,

  output wire         LOCKED,
  input  wire         PWRDWN,
  input  wire         RST
);

endmodule