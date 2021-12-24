// -----------------------------------------------------------------------------
// title          : IR Emitter Interface Modulator Module
// project        : IR Hub
// -----------------------------------------------------------------------------
// file           : IR_Emitter_Modulator.v
// author         : Glen Gomes 
// company        : QuickLogic Corp
// created        : 2014/02/04	
// last update    : 2014/02/04
// platform       : PolarPro III
// standard       : Verilog 2001
// -----------------------------------------------------------------------------
// description: The IR Hub provides a way to control an external IR LED to act
//              as an IR TV remote, and as a way to transfer Bar Code
//              information to a Point-Of-Sale termainal.
//
//              The IR Emitter Modulator generates the key operations to generate
//              the output signal to the external IR LED.
// -----------------------------------------------------------------------------
// copyright (c) 2014
// -----------------------------------------------------------------------------
// revisions  :
// date            version    author         description
// 2014/02/04      1.0        Glen Gomes     created
// -----------------------------------------------------------------------------
// Comments: This solution is specifically for use with the QuickLogic
//           PolarPro III device.
// -----------------------------------------------------------------------------

`timescale 1ns/10ps

module IR_Emitter_Modulator (

                Clock_i,
                Reset_i,

                IR_Emitter_Carrier_Cycle_Enable_i,
                IR_Emitter_Carrier_Signal_i,

                IR_Emitter_Run_Modulator_i,
		        IR_Emitter_Mode_Modulator_i,

		        IR_Emitter_MemRd_Start_i,
		        IR_Emitter_MemRd_Stop_i,

				IR_Emitter_MemData_i,

                IR_LED_Gpio_Polarity_i,
		        IR_LED_Gpio_i,

                IR_Emitter_Carrier_Enable_o,

                IR_Emitter_Busy_Modulator_o,
                IR_Emitter_MemAddr_Modulator_o,
                IR_Emitter_MemRd_Stb_Modulator_o,

		        IR_LED_En_o

                );


//-----Port Parameters-----------------
//

parameter       HOST_DATA_OUT_BITS   =  8;

parameter       MEM_BLOCK_DATA_BITS  =  9;

parameter       MEM_ADR_BUS_BITS     = 13;
parameter       MEM_MAX_PHYS_SIZE    = 8191;
	
parameter       MODULATOR_PULSE_BITS = 16;
parameter       MODULATOR_STATE_BITS =  3;

//-----Port Signals--------------------
//

input                            Clock_i;
input                            Reset_i;

input                            IR_Emitter_Carrier_Cycle_Enable_i;
input                            IR_Emitter_Carrier_Signal_i;

input                            IR_Emitter_Run_Modulator_i;          // IR Emitter Statemachine Run Command
input                      [1:0] IR_Emitter_Mode_Modulator_i;         // IR Emitter Statemachine Operating Mode

input     [MEM_ADR_BUS_BITS-1:0] IR_Emitter_MemRd_Start_i;
input     [MEM_ADR_BUS_BITS-1:0] IR_Emitter_MemRd_Stop_i;

input   [HOST_DATA_OUT_BITS-1:0] IR_Emitter_MemData_i;

input                            IR_LED_Gpio_Polarity_i;              // IR LED Controlled via "General Purpose I/O" polarity
input                            IR_LED_Gpio_i;                       // IR LED Controlled via "General Purpose I/O"

output                           IR_Emitter_Carrier_Enable_o;

output                           IR_Emitter_Busy_Modulator_o;         // IR Emitter Statemachine is busy generating IR waveforms
output    [MEM_ADR_BUS_BITS-1:0] IR_Emitter_MemAddr_Modulator_o;      // IR Emitter Statemachine controlled memory read address
output                           IR_Emitter_MemRd_Stb_Modulator_o;    // IR Emitter Statemachine controlled memory read strobe

output                           IR_LED_En_o;


wire                             Clock_i;
wire                             Reset_i;

wire                             IR_Emitter_Carrier_Cycle_Enable_i;
wire                             IR_Emitter_Carrier_Signal_i;

wire                             IR_Emitter_Run_Modulator_i;          // IR Emitter Statemachine Run Command
wire                       [1:0] IR_Emitter_Mode_Modulator_i;         // IR Emitter Statemachine Operating Mode

wire      [MEM_ADR_BUS_BITS-1:0] IR_Emitter_MemRd_Start_i;
wire      [MEM_ADR_BUS_BITS-1:0] IR_Emitter_MemRd_Stop_i;

wire    [HOST_DATA_OUT_BITS-1:0] IR_Emitter_MemData_i;

wire                             IR_LED_Gpio_Polarity_i;              // IR LED Controlled via "General Purpose I/O" polarity
wire                             IR_LED_Gpio_i;                       // IR LED Controlled via "General Purpose I/O"

reg                              IR_Emitter_Carrier_Enable_o;

reg                              IR_Emitter_Busy_Modulator_o;         // IR Emitter Statemachine is busy generating IR waveforms
reg       [MEM_ADR_BUS_BITS-1:0] IR_Emitter_MemAddr_Modulator_o;      // IR Emitter Statemachine controlled memory read address
reg                              IR_Emitter_MemRd_Stb_Modulator_o;    // IR Emitter Statemachine controlled memory read strobe

reg                              IR_LED_En_o;


//------Internal Signals-------------------
//

reg                              IR_Emitter_Carrier_Enable_o_nxt;

reg                              IR_Emitter_Busy_Modulator_o_nxt;

reg       [MEM_ADR_BUS_BITS-1:0] IR_Emitter_MemAddr_Modulator_o_nxt;

reg                              IR_Emitter_MemAddr_Modulator_o_ce;
reg                              IR_Emitter_MemAddr_Modulator_o_ce_nxt;

reg                              IR_Emitter_MemAddr_Modulator_o_ld;
reg                              IR_Emitter_MemAddr_Modulator_o_ld_nxt;

wire                             IR_Emitter_MemAddr_Modulator_o_tc_nxt;

reg                              IR_Emitter_MemAddr_Modulator_o_tc_lwr; 
reg                              IR_Emitter_MemAddr_Modulator_o_tc_upr; 

reg                              IR_Emitter_MemRd_Stb_Modulator_o_nxt;


reg   [MODULATOR_PULSE_BITS-1:0] IR_Emitter_Pulse_Modulator_o;
reg   [MODULATOR_PULSE_BITS-1:0] IR_Emitter_Pulse_Modulator_o_nxt;

reg                              IR_Emitter_Pulse_Modulator_o_ld_lwr;
reg                              IR_Emitter_Pulse_Modulator_o_ld_lwr_nxt;

reg                              IR_Emitter_Pulse_Modulator_o_ld_upr;
reg                              IR_Emitter_Pulse_Modulator_o_ld_upr_nxt;

reg                              IR_Emitter_Pulse_Modulator_o_tc;
reg                              IR_Emitter_Pulse_Modulator_o_tc_nxt;

reg    [MEM_BLOCK_DATA_BITS-2:0] IR_Emitter_MemData_lwr;

reg                              IR_Emitter_Pulse_Modulator_Signal;
reg                              IR_Emitter_Pulse_Modulator_Signal_nxt;

wire                             IR_LED_En_o_nxt;
reg                              IR_LED_En_o_sel;


reg   [MODULATOR_STATE_BITS-1:0] IR_Emitter_Modulator_State;
reg   [MODULATOR_STATE_BITS-1:0] IR_Emitter_Modulator_State_nxt;


//------Define Parameters------------------
//

parameter MODULATOR_STATE_IDLE           = 3'h0;
parameter MODULATOR_STATE_INIT_LOAD1     = 3'h1;
parameter MODULATOR_STATE_INIT_LOAD2     = 3'h2;
parameter MODULATOR_STATE_NEW_MOD_VALUE  = 3'h3;
parameter MODULATOR_STATE_WAIT_MOD_TERMC = 3'h4;


//------Logic Operations-------------------
//


// Define the IR Emitter's Registers
//
always @(posedge Clock_i or posedge Reset_i) 
begin
    if (Reset_i)
    begin
        IR_Emitter_Carrier_Enable_o           <= 1'b0;

        IR_Emitter_Busy_Modulator_o           <= 0;

        IR_Emitter_MemAddr_Modulator_o        <= 0;
        IR_Emitter_MemAddr_Modulator_o_ce     <= 1'b0;
        IR_Emitter_MemAddr_Modulator_o_ld     <= 1'b0;
        IR_Emitter_MemAddr_Modulator_o_tc_lwr <= 1'b0; 
        IR_Emitter_MemAddr_Modulator_o_tc_upr <= 1'b0; 

        IR_Emitter_Pulse_Modulator_o          <= 0;

        IR_Emitter_Pulse_Modulator_o_ld_lwr   <= 1'b0;
        IR_Emitter_Pulse_Modulator_o_ld_upr   <= 1'b0;
        IR_Emitter_Pulse_Modulator_o_tc       <= 1'b0;

		IR_Emitter_MemData_lwr                <= 0;

        IR_Emitter_MemRd_Stb_Modulator_o      <= 1'b0;
        IR_Emitter_Carrier_Enable_o           <= 1'b0;

        IR_Emitter_Pulse_Modulator_Signal     <= 1'b0;

        IR_LED_En_o                           <= 1'b0;

        IR_Emitter_Modulator_State            <= MODULATOR_STATE_IDLE;

    end
    else 
    begin  
        IR_Emitter_Busy_Modulator_o           <= IR_Emitter_Busy_Modulator_o_nxt;

        IR_Emitter_MemAddr_Modulator_o        <= IR_Emitter_MemAddr_Modulator_o_nxt;
        IR_Emitter_MemAddr_Modulator_o_ce     <= IR_Emitter_MemAddr_Modulator_o_ce_nxt;
        IR_Emitter_MemAddr_Modulator_o_ld     <= IR_Emitter_MemAddr_Modulator_o_ld_nxt;

        IR_Emitter_Pulse_Modulator_o          <= IR_Emitter_Pulse_Modulator_o_nxt;
        IR_Emitter_Pulse_Modulator_o_ld_lwr   <= IR_Emitter_Pulse_Modulator_o_ld_lwr_nxt;
        IR_Emitter_Pulse_Modulator_o_ld_upr   <= IR_Emitter_Pulse_Modulator_o_ld_upr_nxt;
        IR_Emitter_Pulse_Modulator_o_tc       <= IR_Emitter_Pulse_Modulator_o_tc_nxt;

		// Save the lower byte and address terminal count during the memory pre-fetch
		//
		if (IR_Emitter_Pulse_Modulator_o_ld_lwr)
		begin
		    IR_Emitter_MemData_lwr                <= IR_Emitter_MemData_i;
            IR_Emitter_MemAddr_Modulator_o_tc_lwr <= IR_Emitter_MemAddr_Modulator_o_tc_nxt;
        end

		// Output the address terminal count when the pre-fetched memory value is used.
		//
		if (IR_Emitter_Pulse_Modulator_o_ld_upr)
            IR_Emitter_MemAddr_Modulator_o_tc_upr <= IR_Emitter_MemAddr_Modulator_o_tc_lwr;

        IR_Emitter_MemRd_Stb_Modulator_o      <= IR_Emitter_MemRd_Stb_Modulator_o_nxt;
        IR_Emitter_Carrier_Enable_o           <= IR_Emitter_Carrier_Enable_o_nxt;

        IR_Emitter_Pulse_Modulator_Signal     <= IR_Emitter_Pulse_Modulator_Signal_nxt;

        IR_LED_En_o                           <= IR_LED_En_o_nxt;

        IR_Emitter_Modulator_State            <= IR_Emitter_Modulator_State_nxt;
	end
end


// Determine the type of output
// 
// Note: IR Remote operation does     require a carrier signal
//       Bar Code  operation does not require a carrier signal
//       GPIO      operation does not require a         signal
//
always@(
		IR_Emitter_Mode_Modulator_i       or
		IR_LED_Gpio_i                     or
        IR_Emitter_Pulse_Modulator_Signal or
		IR_Emitter_Carrier_Signal_i
       )
begin
    case(IR_Emitter_Mode_Modulator_i)
	2'b00:   IR_LED_En_o_sel <= 1'b0;
	2'b01:   IR_LED_En_o_sel <= IR_Emitter_Pulse_Modulator_Signal & IR_Emitter_Carrier_Signal_i ;
	2'b10:   IR_LED_En_o_sel <= IR_Emitter_Pulse_Modulator_Signal ;
	2'b11:   IR_LED_En_o_sel <= IR_LED_Gpio_i ;
	default: IR_LED_En_o_sel <= 1'b0 ;
	endcase

end

assign IR_LED_En_o_nxt = IR_LED_Gpio_Polarity_i ? IR_LED_En_o_sel : ~IR_LED_En_o_sel;


// Define the Modulator's Statemachine
//
// Note: This statemachine assumes that the Modulator Pulse values are:
//
//       -             a "ON"  code,
//       - followed by a "OFF" code, 
//       - followed by a "ON"  code,
//       - followed by a "OFF" code, etc.
//
always @(
		 IR_Emitter_Modulator_State            or
         IR_Emitter_Run_Modulator_i            or
		 IR_Emitter_Pulse_Modulator_o_tc       or
         IR_Emitter_MemAddr_Modulator_o_tc_upr or
         IR_Emitter_Pulse_Modulator_Signal     or
         IR_Emitter_Carrier_Cycle_Enable_i
        )
begin
    case(IR_Emitter_Modulator_State)
    MODULATOR_STATE_IDLE:
    begin
        IR_Emitter_Carrier_Enable_o_nxt             <= 1'b0;

        IR_Emitter_Pulse_Modulator_o_ld_lwr_nxt     <= 1'b0;
        IR_Emitter_Pulse_Modulator_o_ld_upr_nxt     <= 1'b0;

        IR_Emitter_Pulse_Modulator_Signal_nxt       <= 1'b0;

		case(IR_Emitter_Run_Modulator_i)
		1'b0:
		begin
            IR_Emitter_Modulator_State_nxt          <= MODULATOR_STATE_IDLE;

            IR_Emitter_Busy_Modulator_o_nxt         <= 1'b0;
            IR_Emitter_MemRd_Stb_Modulator_o_nxt    <= 1'b0;

            IR_Emitter_MemAddr_Modulator_o_ce_nxt   <= 1'b0;
            IR_Emitter_MemAddr_Modulator_o_ld_nxt   <= 1'b1;
		end
		1'b1:
		begin
            IR_Emitter_Modulator_State_nxt          <= MODULATOR_STATE_INIT_LOAD1;

            IR_Emitter_Busy_Modulator_o_nxt         <= 1'b1;
            IR_Emitter_MemRd_Stb_Modulator_o_nxt    <= 1'b1;

            IR_Emitter_MemAddr_Modulator_o_ce_nxt   <= 1'b1;
            IR_Emitter_MemAddr_Modulator_o_ld_nxt   <= 1'b0;
		end
        endcase
    end
    MODULATOR_STATE_INIT_LOAD1:
    begin
        IR_Emitter_Modulator_State_nxt              <= MODULATOR_STATE_INIT_LOAD2;
        IR_Emitter_Busy_Modulator_o_nxt             <= 1'b1;

        IR_Emitter_MemRd_Stb_Modulator_o_nxt        <= 1'b1;
        IR_Emitter_Carrier_Enable_o_nxt             <= 1'b1;

        IR_Emitter_MemAddr_Modulator_o_ce_nxt       <= 1'b1;
        IR_Emitter_MemAddr_Modulator_o_ld_nxt       <= 1'b0;

        IR_Emitter_Pulse_Modulator_o_ld_lwr_nxt     <= 1'b1;
        IR_Emitter_Pulse_Modulator_o_ld_upr_nxt     <= 1'b0;

        IR_Emitter_Pulse_Modulator_Signal_nxt       <= 1'b0;
    end
    MODULATOR_STATE_INIT_LOAD2:
    begin
        IR_Emitter_Modulator_State_nxt              <= MODULATOR_STATE_NEW_MOD_VALUE;
        IR_Emitter_Busy_Modulator_o_nxt             <= 1'b1;

        IR_Emitter_MemRd_Stb_Modulator_o_nxt        <= 1'b1;
        IR_Emitter_Carrier_Enable_o_nxt             <= 1'b1;

        IR_Emitter_MemAddr_Modulator_o_ce_nxt       <= 1'b1;
        IR_Emitter_MemAddr_Modulator_o_ld_nxt       <= 1'b0;

        IR_Emitter_Pulse_Modulator_o_ld_lwr_nxt     <= 1'b0;
        IR_Emitter_Pulse_Modulator_o_ld_upr_nxt     <= 1'b1;

        IR_Emitter_Pulse_Modulator_Signal_nxt       <= 1'b1;
    end
    MODULATOR_STATE_NEW_MOD_VALUE:
    begin
        IR_Emitter_Modulator_State_nxt              <= MODULATOR_STATE_WAIT_MOD_TERMC;
        IR_Emitter_Busy_Modulator_o_nxt             <= 1'b1;

        IR_Emitter_MemRd_Stb_Modulator_o_nxt        <= 1'b1;
        IR_Emitter_Carrier_Enable_o_nxt             <= 1'b1;

        IR_Emitter_MemAddr_Modulator_o_ce_nxt       <= 1'b1;
        IR_Emitter_MemAddr_Modulator_o_ld_nxt       <= 1'b0;

        IR_Emitter_Pulse_Modulator_o_ld_lwr_nxt     <= 1'b1;
        IR_Emitter_Pulse_Modulator_o_ld_upr_nxt     <= 1'b0;

        IR_Emitter_Pulse_Modulator_Signal_nxt       <= IR_Emitter_Pulse_Modulator_Signal;
    end
    MODULATOR_STATE_WAIT_MOD_TERMC:
    begin
        case({(IR_Emitter_Pulse_Modulator_o_tc      && 
               IR_Emitter_Carrier_Cycle_Enable_i    ),
               IR_Emitter_MemAddr_Modulator_o_tc_upr})
		default:
		begin
            IR_Emitter_Modulator_State_nxt          <= MODULATOR_STATE_WAIT_MOD_TERMC;
            IR_Emitter_Busy_Modulator_o_nxt         <= 1'b1;

            IR_Emitter_MemRd_Stb_Modulator_o_nxt    <= 1'b0;
            IR_Emitter_Carrier_Enable_o_nxt         <= 1'b1;

            IR_Emitter_MemAddr_Modulator_o_ce_nxt   <= 1'b0;
            IR_Emitter_MemAddr_Modulator_o_ld_nxt   <= 1'b0;

            IR_Emitter_Pulse_Modulator_o_ld_lwr_nxt <= 1'b0;
            IR_Emitter_Pulse_Modulator_o_ld_upr_nxt <= 1'b0;

            IR_Emitter_Pulse_Modulator_Signal_nxt   <= IR_Emitter_Pulse_Modulator_Signal;
        end
		2'b10:
		begin
            IR_Emitter_Modulator_State_nxt          <= MODULATOR_STATE_NEW_MOD_VALUE;
            IR_Emitter_Busy_Modulator_o_nxt         <= 1'b1;

            IR_Emitter_MemRd_Stb_Modulator_o_nxt    <= 1'b1;
            IR_Emitter_Carrier_Enable_o_nxt         <= 1'b1;

            IR_Emitter_MemAddr_Modulator_o_ce_nxt   <= 1'b1;
            IR_Emitter_MemAddr_Modulator_o_ld_nxt   <= 1'b0;

            IR_Emitter_Pulse_Modulator_o_ld_lwr_nxt <= 1'b0;
            IR_Emitter_Pulse_Modulator_o_ld_upr_nxt <= 1'b1;

            IR_Emitter_Pulse_Modulator_Signal_nxt   <= ~IR_Emitter_Pulse_Modulator_Signal;
        end
		2'b11:
		begin
            IR_Emitter_Modulator_State_nxt          <= MODULATOR_STATE_IDLE;
            IR_Emitter_Busy_Modulator_o_nxt         <= 1'b0;

            IR_Emitter_MemRd_Stb_Modulator_o_nxt    <= 1'b0;
            IR_Emitter_Carrier_Enable_o_nxt         <= 1'b0;

            IR_Emitter_MemAddr_Modulator_o_ce_nxt   <= 1'b0;
            IR_Emitter_MemAddr_Modulator_o_ld_nxt   <= 1'b1;

            IR_Emitter_Pulse_Modulator_o_ld_lwr_nxt <= 1'b0;
            IR_Emitter_Pulse_Modulator_o_ld_upr_nxt <= 1'b0;

            IR_Emitter_Pulse_Modulator_Signal_nxt   <= 1'b0;
        end
        endcase
    end
	default: 
    begin
        IR_Emitter_Modulator_State_nxt              <= MODULATOR_STATE_IDLE;
        IR_Emitter_Busy_Modulator_o_nxt             <= 1'b0;

        IR_Emitter_MemRd_Stb_Modulator_o_nxt        <= 1'b0;
        IR_Emitter_Carrier_Enable_o_nxt             <= 1'b0;

        IR_Emitter_MemAddr_Modulator_o_ce_nxt       <= 1'b0;
        IR_Emitter_MemAddr_Modulator_o_ld_nxt       <= 1'b1;

        IR_Emitter_Pulse_Modulator_o_ld_lwr_nxt     <= 1'b0;
        IR_Emitter_Pulse_Modulator_o_ld_upr_nxt     <= 1'b0;

        IR_Emitter_Pulse_Modulator_Signal_nxt       <= 1'b0;
    end
	endcase
end


// Define the Memory Address Pointer
//
// Note: The address pointer executes from a "start" point to a "stop" point.
//
always@(
        IR_Emitter_MemRd_Start_i          or
        IR_Emitter_MemAddr_Modulator_o    or
        IR_Emitter_MemAddr_Modulator_o_ce or
        IR_Emitter_MemAddr_Modulator_o_ld
       )
begin
    case({   IR_Emitter_MemAddr_Modulator_o_ce,
             IR_Emitter_MemAddr_Modulator_o_ld})
    2'b01:   IR_Emitter_MemAddr_Modulator_o_nxt <= IR_Emitter_MemRd_Start_i;
    2'b10:   IR_Emitter_MemAddr_Modulator_o_nxt <= IR_Emitter_MemAddr_Modulator_o + 1;
    default: IR_Emitter_MemAddr_Modulator_o_nxt <= IR_Emitter_MemAddr_Modulator_o;
	endcase
end


// Define the Memory Address Pointer terminal count
//
// Note: The address pointer executes from a "start" point to a "stop" point.
//
//       The Memory Address pointer should not go past the end of physcal memory. 
//       This will result in memory aliasing with unpredictable results.
//
assign IR_Emitter_MemAddr_Modulator_o_tc_nxt = (IR_Emitter_MemAddr_Modulator_o == (MEM_MAX_PHYS_SIZE-1))
                                             | (IR_Emitter_MemAddr_Modulator_o == (IR_Emitter_MemRd_Stop_i));


// Define the Modulator's Pulse Period
//
always@(
		IR_Emitter_MemData_i                or
		IR_Emitter_MemData_lwr              or
        IR_Emitter_Pulse_Modulator_o        or
        IR_Emitter_Carrier_Cycle_Enable_i   or
        IR_Emitter_Pulse_Modulator_o_ld_upr
       )
begin
    case({   IR_Emitter_Carrier_Cycle_Enable_i,
             IR_Emitter_Pulse_Modulator_o_ld_upr})
    2'b01:   IR_Emitter_Pulse_Modulator_o_nxt <= {IR_Emitter_MemData_i, IR_Emitter_MemData_lwr};
    2'b10:   IR_Emitter_Pulse_Modulator_o_nxt <=  IR_Emitter_Pulse_Modulator_o - 1;
    default: IR_Emitter_Pulse_Modulator_o_nxt <=  IR_Emitter_Pulse_Modulator_o;
	endcase
end


// Define the Modulator's Pulse Period Terminal Count
//
always@(
		IR_Emitter_MemData_i                or
		IR_Emitter_MemData_lwr              or
        IR_Emitter_Pulse_Modulator_o        or
        IR_Emitter_Carrier_Cycle_Enable_i   or
        IR_Emitter_Pulse_Modulator_o_ld_upr or
        IR_Emitter_Pulse_Modulator_o_tc
       )
begin
    case({   IR_Emitter_Carrier_Cycle_Enable_i,
             IR_Emitter_Pulse_Modulator_o_ld_upr})
    2'b01:   IR_Emitter_Pulse_Modulator_o_tc_nxt <= ({IR_Emitter_MemData_i, IR_Emitter_MemData_lwr} == 0)
                                                  | ({IR_Emitter_MemData_i, IR_Emitter_MemData_lwr} == 1);
    2'b10:   IR_Emitter_Pulse_Modulator_o_tc_nxt <= ( IR_Emitter_Pulse_Modulator_o == 2);
    default: IR_Emitter_Pulse_Modulator_o_tc_nxt <=   IR_Emitter_Pulse_Modulator_o_tc;
	endcase

end


//------Instantiate Modules----------------
//



endmodule
