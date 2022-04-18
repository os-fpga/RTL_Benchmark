`timescale 1ns / 1ps
/* Top level module that communicates with the PC
 */
module dart (
    input   SYSTEM_CLOCK,
    input   clock_50,
    input   SW_0,
    input   SW_1,
    input   SW_2,
    input   SW_3,
    input   PB_ENTER,
    input   PB_UP,
    input   RS232_RX_DATA,
    output  RS232_TX_DATA,
    output  LED_0,
    output  LED_1,
    output  LED_2,
    output  LED_3
);

    wire            dcm_locked;
    wire            clock_100;
    wire            clock_50;
    wire            reset;
    wire            arst;
    wire            error;
    wire            rx_error;
    wire            tx_error;
    wire            control_error;
    
    wire    [15:0]  rx_word;
    wire            rx_word_valid;
    wire    [15:0]  tx_word;
    wire            tx_word_valid;
    wire            tx_ack;
    
    wire            sim_error;
    wire            sim_reset;
    wire            sim_enable;
    wire    [9:0]   sim_time;
    wire            sim_time_tick;
    
    wire    [15:0]  config_word;
    wire            config_valid;
    wire    [15:0]  stats_word;
    wire            stats_shift;
    
    wire            stop_injection;
    wire            measure;
    wire            sim_quiescent;
    
    
    wire     [7:0]  fdp_error;
    wire     [7:0]  cdp_error;
    wire     [7:0]  part_error;
    reg      [3:0]  dcm_r;
    
    
    reg      [4:0]  r_sync_reset;
    always @(posedge clock_50)
    begin
        r_sync_reset <= {r_sync_reset[3:0], ~PB_ENTER};
    end
    assign reset = r_sync_reset[4];
    //IBUF dcm_arst_buf (.O(arst), .I(~PB_UP));
    

    //
    // LEDs for debugging
    //
    reg [3:0] led_out;
   
    assign {LED_3, LED_2, LED_1, LED_0} = ~led_out;
    
    always @(*)
    begin
        case ({SW_3, SW_2, SW_1, SW_0})
            4'h0:   led_out = {reset, dcm_locked, rx_error, tx_error};
            4'h1:   led_out = {sim_reset, sim_error, ~RS232_RX_DATA, ~RS232_TX_DATA};
            4'h2:   led_out = {stop_injection, measure, sim_enable, sim_quiescent};
            4'h3:   led_out = part_error[3:0];
            4'h4:   led_out = part_error[7:4];
            4'h5:   led_out = fdp_error[3:0];
            4'h6:   led_out = fdp_error[7:4];
            4'h7:   led_out = cdp_error[3:0];
            4'h8:   led_out = cdp_error[7:4];
            4'h9:   led_out = {control_error, 3'b000};
            default:    led_out = 4'b0000;
        endcase
    end
    
    always @(posedge clock_50 or posedge reset) 
    begin
       if (reset) begin
          dcm_r <= 4'h0;
       end
       else begin
          dcm_r[0] <= 1'b1;
          dcm_r[1] <= dcm_r[0];
          dcm_r[2] <= dcm_r[1];
          dcm_r[3] <= dcm_r[2];
       end
    end
    assign dcm_locked = dcm_r[3];
    
    //
    // DCM
    //
/*
    wire dcm_sys_clk_in;
    wire dcm_clk_100;
    wire dcm_clk_50;
    
    IBUFG sys_clk_buf (.O(dcm_sys_clk_in), .I(SYSTEM_CLOCK));
    BUFG clk_100_buf (.O(clock_100), .I(dcm_clk_100));
    BUFG clk_50_buf (.O(clock_50), .I(dcm_clk_50));
    
    DCM #(
        .SIM_MODE("SAFE"),  // Simulation: "SAFE" vs. "FAST", see "Synthesis and Simulation Design Guide" for details
        .CLKDV_DIVIDE(4.0), // Divide by: 1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0,5.5,6.0,6.5
                            //   7.0,7.5,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0 or 16.0
        .CLKFX_DIVIDE(1),               // Can be any integer from 1 to 32
        .CLKFX_MULTIPLY(4),             // Can be any integer from 2 to 32
        .CLKIN_DIVIDE_BY_2("FALSE"),    // TRUE/FALSE to enable CLKIN divide by two feature
        .CLKIN_PERIOD(0.0),             // Specify period of input clock
        .CLKOUT_PHASE_SHIFT("NONE"),    // Specify phase shift of NONE, FIXED or VARIABLE
        .CLK_FEEDBACK("1X"),            // Specify clock feedback of NONE, 1X or 2X
        .DESKEW_ADJUST("SYSTEM_SYNCHRONOUS"),   // SOURCE_SYNCHRONOUS, SYSTEM_SYNCHRONOUS or
                                                //   an integer from 0 to 15
        .DFS_FREQUENCY_MODE("LOW"),     // HIGH or LOW frequency mode for frequency synthesis
        .DLL_FREQUENCY_MODE("LOW"),     // HIGH or LOW frequency mode for DLL
        .DUTY_CYCLE_CORRECTION("TRUE"), // Duty cycle correction, TRUE or FALSE
        .FACTORY_JF(16'hC080),          // FACTORY JF values
        .PHASE_SHIFT(0),                // Amount of fixed phase shift from -255 to 255
        .STARTUP_WAIT("FALSE")          // Delay configuration DONE until DCM LOCK, TRUE/FALSE
    ) DCM_inst (
        .CLK0(dcm_clk_100),     // 0 degree DCM CLK output
        .CLK180(),              // 180 degree DCM CLK output
        .CLK270(),              // 270 degree DCM CLK output
        .CLK2X(),               // 2X DCM CLK output
        .CLK2X180(),            // 2X, 180 degree DCM CLK out
        .CLK90(),               // 90 degree DCM CLK output
        .CLKDV(dcm_clk_50),     // Divided DCM CLK out (CLKDV_DIVIDE)
        .CLKFX(),               // DCM CLK synthesis out (M/D)
        .CLKFX180(),            // 180 degree CLK synthesis out
        .LOCKED(dcm_locked),    // DCM LOCK status output
        .PSDONE(),              // Dynamic phase adjust done output
        .STATUS(),              // 8-bit DCM status bits output
        .CLKFB(clock_100),      // DCM clock feedback
        .CLKIN(dcm_sys_clk_in), // Clock input (from IBUFG, BUFG or DCM)
        .PSCLK(1'b0),           // Dynamic phase adjust clock input
        .PSEN(1'b0),            // Dynamic phase adjust enable input
        .PSINCDEC(0),           // Dynamic phase adjust increment/decrement
        .RST(arst)             // DCM asynchronous reset input
    );
*/    
    //
    // DART UART port (user data width = 16)
    //
    dartport #(.WIDTH(16), .BAUD_RATE(9600)) dartio (
        .clock (clock_50),
        .reset (reset),
        .enable (dcm_locked),
        .rx_error (rx_error),
        .tx_error (tx_error),
        .RS232_RX_DATA (RS232_RX_DATA),
        .RS232_TX_DATA (RS232_TX_DATA),
        .rx_data (rx_word),
        .rx_valid (rx_word_valid),
        .tx_data (tx_word),
        .tx_valid (tx_word_valid),
        .tx_ack (tx_ack));
    
    //
    // Control Unit
    //
    Control controller (
        .clock (clock_50),
        .reset (reset),
        .enable (dcm_locked),
        .control_error (control_error),
        .rx_word (rx_word),
        .rx_word_valid (rx_word_valid),
        .tx_word (tx_word),
        .tx_word_valid (tx_word_valid),
        .tx_ack (tx_ack),
        .sim_reset (sim_reset),
        .sim_enable (sim_enable),
        .sim_error (sim_error),
        .stop_injection (stop_injection),
        .measure (measure),
        .sim_time (sim_time),
        .sim_time_tick (sim_time_tick),
        .sim_quiescent (sim_quiescent),
        .config_word (config_word),
        .config_valid (config_valid),
        .stats_shift (stats_shift),
        .stats_word (stats_word));
    
    //
    // Simulator
    //
    sim9_8x8 dart_sim (
        .clock (clock_50),
        //.clock_2x (clock_100),
        .reset (sim_reset),
        .enable (sim_enable),
        .stop_injection (stop_injection),
        .measure (measure),
        .sim_time (sim_time),
        .sim_time_tick (sim_time_tick),
        .error (sim_error),
        .fdp_error (fdp_error),
        .cdp_error (cdp_error),
        .part_error (part_error),
        .quiescent (sim_quiescent),
        .config_in (config_word),
        .config_in_valid (config_valid),
        .config_out (),
        .config_out_valid (),
        .stats_out (stats_word),
        .stats_shift (stats_shift));
    
endmodule
