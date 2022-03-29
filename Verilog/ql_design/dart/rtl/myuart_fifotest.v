`timescale 1ns / 1ps
/* Test the UART rx and tx modules by first receiving 100 words
 * from UART, store into RAM and send them back
 */
module myuart_fifotest (
    input   SYSTEM_CLOCK,
    input   SW_0,
    input   SW_1,
    input   SW_3,
    input   RS232_RX_DATA,
    output  RS232_TX_DATA,
    output  LED_0,
    output  LED_1,
    output  LED_2,
    output  LED_3
);
    wire clock_fb;
    wire dcm_locked;
    wire clock;
    wire reset;
    wire error;
    wire rx_error;
    wire tx_error;
    
    reg [3:0] led_out;
    
    wire [15:0] to_fifo_data;
    wire        to_fifo_valid;
    
    wire [15:0] from_fifo_data;
    wire        fifo_empty;
    wire        fifo_read;
    
    assign {LED_3, LED_2, LED_1, LED_0} = ~led_out;
    
    always @(*)
    begin
        case ({SW_1, SW_0})
            2'b00:  led_out = {reset, rx_error, tx_error, dcm_locked};
            2'b01:  led_out = {2'b00, ~RS232_RX_DATA, ~RS232_TX_DATA};
            default: led_out = 4'b0000;
        endcase
    end
    
    assign reset = SW_3;
    
    DCM #(
        .SIM_MODE("SAFE"),  // Simulation: "SAFE" vs. "FAST", see "Synthesis and Simulation Design Guide" for details
        .CLKDV_DIVIDE(2.0), // Divide by: 1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0,5.5,6.0,6.5
                            //   7.0,7.5,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0 or 16.0
        .CLKFX_DIVIDE(1),   // Can be any integer from 1 to 32
        .CLKFX_MULTIPLY(4), // Can be any integer from 2 to 32
        .CLKIN_DIVIDE_BY_2("FALSE"), // TRUE/FALSE to enable CLKIN divide by two feature
        .CLKIN_PERIOD(0.0), // Specify period of input clock
        .CLKOUT_PHASE_SHIFT("NONE"), // Specify phase shift of NONE, FIXED or VARIABLE
        .CLK_FEEDBACK("1X"),// Specify clock feedback of NONE, 1X or 2X
        .DESKEW_ADJUST("SYSTEM_SYNCHRONOUS"), // SOURCE_SYNCHRONOUS, SYSTEM_SYNCHRONOUS or
                                            //   an integer from 0 to 15
        .DFS_FREQUENCY_MODE("LOW"),  // HIGH or LOW frequency mode for frequency synthesis
        .DLL_FREQUENCY_MODE("LOW"),  // HIGH or LOW frequency mode for DLL
        .DUTY_CYCLE_CORRECTION("TRUE"), // Duty cycle correction, TRUE or FALSE
        .FACTORY_JF(16'hC080),   // FACTORY JF values
        .PHASE_SHIFT(0),     // Amount of fixed phase shift from -255 to 255
        .STARTUP_WAIT("FALSE")   // Delay configuration DONE until DCM LOCK, TRUE/FALSE
    ) DCM_inst (
        .CLK0(clock_fb),    // 0 degree DCM CLK output
        .CLK180(),          // 180 degree DCM CLK output
        .CLK270(),          // 270 degree DCM CLK output
        .CLK2X(),           // 2X DCM CLK output
        .CLK2X180(),        // 2X, 180 degree DCM CLK out
        .CLK90(),           // 90 degree DCM CLK output
        .CLKDV(clock),      // Divided DCM CLK out (CLKDV_DIVIDE)
        .CLKFX(),           // DCM CLK synthesis out (M/D)
        .CLKFX180(),        // 180 degree CLK synthesis out
        .LOCKED(dcm_locked), // DCM LOCK status output
        .PSDONE(),          // Dynamic phase adjust done output
        .STATUS(),          // 8-bit DCM status bits output
        .CLKFB(clock_fb),      // DCM clock feedback
        .CLKIN(SYSTEM_CLOCK),   // Clock input (from IBUFG, BUFG or DCM)
        .PSCLK(1'b0),       // Dynamic phase adjust clock input
        .PSEN(1'b0),        // Dynamic phase adjust enable input
        .PSINCDEC(0),       // Dynamic phase adjust increment/decrement
        .RST(reset)         // DCM asynchronous reset input
   );
    
    // DART UART port (user data width = 16)
    dartport #(.WIDTH(16)) dartio (
        .clock (clock),
        .reset (reset),
        .enable (dcm_locked),
        .rx_error (rx_error),
        .tx_error (tx_error),
        .RS232_RX_DATA (RS232_RX_DATA),
        .RS232_TX_DATA (RS232_TX_DATA),
        .rx_data (to_fifo_data),
        .rx_valid (to_fifo_valid),
        .tx_data (from_fifo_data),
        .tx_valid (~fifo_empty),
        .tx_ack (fifo_read));
        
    // Data FIFO
    fifo buffer (
        .clk (clock),
        .rst (reset),
        .din (to_fifo_data),
        .wr_en (to_fifo_valid & dcm_locked),
        .dout (from_fifo_data),
        .rd_en (fifo_read & dcm_locked),
        .empty (fifo_empty),
        .full ());
endmodule
