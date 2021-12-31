// -----------------------------------------------------------------------------
// title          : IR Emitter Carrier Generator Module
// project        : IR Hub
// -----------------------------------------------------------------------------
// file           : IR_Emitter_Carrier_Generator.v
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
//              The IR Emitter Carrier generates the carrier frequency used, in part,
//              to generate the output signal to the external IR LED.
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

module IR_Emitter_Carrier_Generator(

                Clock_i,
                Reset_i,

                IR_Emitter_Carrier_Enable_i,

		        IR_Emitter_Carrier_Cycle_Len_i,
                IR_Emitter_Carrier_Duty_Len_i,

				IR_Emitter_Carrier_Cycle_Enable_o,
		        IR_Emitter_Carrier_Signal_o

                );


//-----Port Parameters-----------------
//

parameter       CARRIER_CYCLE_BITS  = 16;
parameter       CARRIER_DUTY_BITS   = 16;
	
parameter       CARRIER_CYCLE_LSB_BITS =  8;
parameter       CARRIER_DUTY_LSB_BITS  =  8;

//-----Port Signals--------------------
//

input                                Clock_i;
input                                Reset_i;

input                                IR_Emitter_Carrier_Enable_i;

input       [CARRIER_CYCLE_BITS-1:0] IR_Emitter_Carrier_Cycle_Len_i; // Carrier Generator Cycle Length
input       [ CARRIER_DUTY_BITS-1:0] IR_Emitter_Carrier_Duty_Len_i;  // Carrier Duty      Cycle Length

output                               IR_Emitter_Carrier_Cycle_Enable_o;
output                               IR_Emitter_Carrier_Signal_o;


wire                                 Clock_i;
wire                                 Reset_i;

wire                                 IR_Emitter_Carrier_Enable_i;

wire        [CARRIER_CYCLE_BITS-1:0] IR_Emitter_Carrier_Cycle_Len_i; // Carrier Generator Cycle Length
wire        [ CARRIER_DUTY_BITS-1:0] IR_Emitter_Carrier_Duty_Len_i;  // Carrier Duty      Cycle Length

reg                                  IR_Emitter_Carrier_Cycle_Enable_o;

reg                                  IR_Emitter_Carrier_Signal_o;
reg                                  IR_Emitter_Carrier_Signal_o_nxt;


//------Internal Signals-------------------
//

// Define the Carrier Generator's Frequency Cycle Count logic
//
reg     [CARRIER_CYCLE_LSB_BITS-1:0] IR_Emitter_Carrier_Cycle_0_cntr;
reg     [CARRIER_CYCLE_LSB_BITS-1:0] IR_Emitter_Carrier_Cycle_0_cntr_nxt;

reg                                  IR_Emitter_Carrier_Cycle_0_cntr_tc;
reg                                  IR_Emitter_Carrier_Cycle_0_cntr_tc_nxt;

reg     [CARRIER_CYCLE_BITS-
		 CARRIER_CYCLE_LSB_BITS-1:0] IR_Emitter_Carrier_Cycle_1_cntr;

reg     [CARRIER_CYCLE_BITS- 
		 CARRIER_CYCLE_LSB_BITS-1:0] IR_Emitter_Carrier_Cycle_1_cntr_nxt;

reg                                  IR_Emitter_Carrier_Cycle_1_cntr_tc;
reg                                  IR_Emitter_Carrier_Cycle_1_cntr_tc_nxt;



// Define the Carrier Generator's Frequency Duty Cycle Count logic
//
reg     [ CARRIER_DUTY_LSB_BITS-1:0] IR_Emitter_Carrier_Duty_0_cntr;
reg     [ CARRIER_DUTY_LSB_BITS-1:0] IR_Emitter_Carrier_Duty_0_cntr_nxt;

reg                                  IR_Emitter_Carrier_Duty_0_cntr_tc;
reg                                  IR_Emitter_Carrier_Duty_0_cntr_tc_nxt;

reg     [ CARRIER_DUTY_BITS-
          CARRIER_DUTY_LSB_BITS-1:0] IR_Emitter_Carrier_Duty_1_cntr;

reg     [ CARRIER_DUTY_BITS-
          CARRIER_DUTY_LSB_BITS-1:0] IR_Emitter_Carrier_Duty_1_cntr_nxt;

reg                                  IR_Emitter_Carrier_Duty_1_cntr_tc;
reg                                  IR_Emitter_Carrier_Duty_1_cntr_tc_nxt;

reg                                  IR_Emitter_Carrier_Duty_cntr_ld;
reg                                  IR_Emitter_Carrier_Duty_cntr_ld_nxt;

reg                                  IR_Emitter_Carrier_Duty_cntr_tc;
wire                                 IR_Emitter_Carrier_Duty_cntr_tc_nxt;

reg                                  IR_Emitter_Carrier_Duty_ld_tc;
wire                                 IR_Emitter_Carrier_Duty_ld_tc_nxt;

reg		                      [1:0]  IR_Emitter_Carrier_Duty_State;
reg		                      [1:0]  IR_Emitter_Carrier_Duty_State_nxt;


//------Define Parameters------------------
//

// Define the Duty Cycle Counter's State bits
//
parameter  DUTY_IDLE_ST   = 2'h0;
parameter  DUTY_COUNT_ST  = 2'h1;
parameter  DUTY_WAIT_ST   = 2'h2;


//------Logic Operations-------------------
//


// Define the IR Emitter's Registers
//
always @(posedge Clock_i or posedge Reset_i) 
begin
    if (Reset_i)
    begin
        IR_Emitter_Carrier_Cycle_0_cntr        <= 0;
        IR_Emitter_Carrier_Cycle_0_cntr_tc     <= 1'b0;

        IR_Emitter_Carrier_Cycle_1_cntr        <= 0;
        IR_Emitter_Carrier_Cycle_1_cntr_tc     <= 1'b0;

        IR_Emitter_Carrier_Cycle_Enable_o      <= 1'b0;


        IR_Emitter_Carrier_Duty_0_cntr         <= 0;
        IR_Emitter_Carrier_Duty_0_cntr_tc      <= 1'b0;

        IR_Emitter_Carrier_Duty_1_cntr         <= 0;
        IR_Emitter_Carrier_Duty_1_cntr_tc      <= 1'b0;

        IR_Emitter_Carrier_Duty_cntr_ld        <= 1'b0;
        IR_Emitter_Carrier_Duty_cntr_tc        <= 1'b0;
        IR_Emitter_Carrier_Duty_ld_tc          <= 1'b0;

        IR_Emitter_Carrier_Duty_State          <= DUTY_IDLE_ST;

        IR_Emitter_Carrier_Signal_o            <= 1'b0;

    end
    else 
    begin  
        IR_Emitter_Carrier_Cycle_0_cntr        <= IR_Emitter_Carrier_Cycle_0_cntr_nxt;
        IR_Emitter_Carrier_Cycle_0_cntr_tc     <= IR_Emitter_Carrier_Cycle_0_cntr_tc_nxt;

		if (IR_Emitter_Carrier_Cycle_Enable_o || IR_Emitter_Carrier_Cycle_0_cntr_tc)
		begin
            IR_Emitter_Carrier_Cycle_1_cntr    <= IR_Emitter_Carrier_Cycle_1_cntr_nxt;
            IR_Emitter_Carrier_Cycle_1_cntr_tc <= IR_Emitter_Carrier_Cycle_1_cntr_tc_nxt;
        end

        IR_Emitter_Carrier_Cycle_Enable_o      <=  IR_Emitter_Carrier_Cycle_0_cntr_tc_nxt
		                                       & (~IR_Emitter_Carrier_Cycle_0_cntr_tc)
		                                       &   IR_Emitter_Carrier_Cycle_1_cntr_tc;


        IR_Emitter_Carrier_Duty_0_cntr         <= IR_Emitter_Carrier_Duty_0_cntr_nxt;
        IR_Emitter_Carrier_Duty_0_cntr_tc      <= IR_Emitter_Carrier_Duty_0_cntr_tc_nxt;

		if (IR_Emitter_Carrier_Cycle_Enable_o  || 
            IR_Emitter_Carrier_Duty_cntr_ld    || IR_Emitter_Carrier_Duty_0_cntr_tc )
		begin
            IR_Emitter_Carrier_Duty_1_cntr     <= IR_Emitter_Carrier_Duty_1_cntr_nxt;
            IR_Emitter_Carrier_Duty_1_cntr_tc  <= IR_Emitter_Carrier_Duty_1_cntr_tc_nxt;
        end
 
        IR_Emitter_Carrier_Duty_cntr_ld        <= IR_Emitter_Carrier_Duty_cntr_ld_nxt;
        IR_Emitter_Carrier_Duty_cntr_tc        <= IR_Emitter_Carrier_Duty_cntr_tc_nxt;
        IR_Emitter_Carrier_Duty_ld_tc          <= IR_Emitter_Carrier_Duty_ld_tc_nxt;

        IR_Emitter_Carrier_Duty_State          <= IR_Emitter_Carrier_Duty_State_nxt;

        IR_Emitter_Carrier_Signal_o            <= IR_Emitter_Carrier_Signal_o_nxt;

	end
end

// Define the Carrier Generator's Frequency Cycle Counter's LSBs
//
// Note: The LSBs of the counter must operate at the frequency of the input
//       clock. However, the MSBs run at the division rate of the LSBs. This
//       relaxes the timing of the MSBs.
//
always@(
        IR_Emitter_Carrier_Cycle_0_cntr     or
        IR_Emitter_Carrier_Cycle_Len_i      or
        IR_Emitter_Carrier_Enable_i         or
        IR_Emitter_Carrier_Cycle_Enable_o   
       ) 
begin

    case({IR_Emitter_Carrier_Enable_i,
          IR_Emitter_Carrier_Cycle_Enable_o}
		 )
    2'b10:   IR_Emitter_Carrier_Cycle_0_cntr_nxt    <= IR_Emitter_Carrier_Cycle_0_cntr - 1;                        // Count
	default: IR_Emitter_Carrier_Cycle_0_cntr_nxt    <= IR_Emitter_Carrier_Cycle_Len_i[CARRIER_CYCLE_LSB_BITS-1:0]; // Load
	endcase

    case({IR_Emitter_Carrier_Enable_i,
          IR_Emitter_Carrier_Cycle_Enable_o}
		 )
    2'b10:   IR_Emitter_Carrier_Cycle_0_cntr_tc_nxt <= (IR_Emitter_Carrier_Cycle_0_cntr == 2);                            // Count
	default: IR_Emitter_Carrier_Cycle_0_cntr_tc_nxt <= (IR_Emitter_Carrier_Cycle_Len_i[CARRIER_CYCLE_LSB_BITS-1:0] == 0)
	                                                 | (IR_Emitter_Carrier_Cycle_Len_i[CARRIER_CYCLE_LSB_BITS-1:0] == 1); // Load
	endcase

end


// Define the Carrier Generator's Frequency Cycle Counter's MSBs
//
always@(
        IR_Emitter_Carrier_Cycle_1_cntr     or
        IR_Emitter_Carrier_Cycle_Len_i      or
        IR_Emitter_Carrier_Enable_i         or
        IR_Emitter_Carrier_Cycle_Enable_o
       ) 
begin

    case({IR_Emitter_Carrier_Enable_i,
          IR_Emitter_Carrier_Cycle_Enable_o}
		 )
    2'b10:   IR_Emitter_Carrier_Cycle_1_cntr_nxt    <= IR_Emitter_Carrier_Cycle_1_cntr - 1;                    // Count
	default: IR_Emitter_Carrier_Cycle_1_cntr_nxt    <= IR_Emitter_Carrier_Cycle_Len_i[CARRIER_CYCLE_BITS-1:
			                                                                          CARRIER_CYCLE_LSB_BITS]; // Load
	endcase

    case({IR_Emitter_Carrier_Enable_i,
          IR_Emitter_Carrier_Cycle_Enable_o}
		 )
    2'b10:   IR_Emitter_Carrier_Cycle_1_cntr_tc_nxt <= (IR_Emitter_Carrier_Cycle_1_cntr == 1);                        // Count
	default: IR_Emitter_Carrier_Cycle_1_cntr_tc_nxt <= (IR_Emitter_Carrier_Cycle_Len_i[CARRIER_CYCLE_BITS-1:
			                                                                           CARRIER_CYCLE_LSB_BITS] == 0); // Load
	endcase

end


// Define when the IR Emitter's Duty Cycle Counter is done
//
// Note: The Carrier Duty Cycle Counter's value should always be less than or equal 
//       to the Carrier Cycle Counter's value. However, if the Carrier Cycle's Counter
//       value is smaller then the Carrier Duty Cycle Counter, the terms below will
//       correctly maintain counter loading. 
//
//       In addition, these terms allow for proper loading when the Carrier Signal is disabled.
//
assign IR_Emitter_Carrier_Duty_cntr_tc_nxt = (IR_Emitter_Carrier_Cycle_Enable_o || IR_Emitter_Carrier_Duty_cntr_ld) 
                                           ?  IR_Emitter_Carrier_Duty_ld_tc
                                           :  IR_Emitter_Carrier_Duty_0_cntr_tc_nxt & IR_Emitter_Carrier_Duty_1_cntr_tc;


// Define the Terminal Count for a load of zero
//
// Note: This was done in this way to avoid having to decode a larger number
//       of bits at a time to address certain corner cases. These cases should 
//       not happen if the correct values are loaded into the Carrier Cycle and 
//       Carrier Duty Cycle Counters.
//
assign IR_Emitter_Carrier_Duty_ld_tc_nxt  = ((IR_Emitter_Carrier_Duty_Len_i == 0)
                                          || (IR_Emitter_Carrier_Duty_Len_i == 1)) ? 1'b1: 1'b0;


// Define the IR Emitter's Carrier Duty Cycle Counter's statemachine
//
// Note: The Carrier Signal starts at the begining of each Carrier Cycle Counter 
//       Cycle and then should shut off until the start of the next cycle.
//
//       This statemachine handles conditions when the Carrier Duty Cycle Counter
//       value is below, equal to, or above the Carrier Cycle Counter value.
//
always @(IR_Emitter_Carrier_Duty_State       or
		 IR_Emitter_Carrier_Enable_i         or
         IR_Emitter_Carrier_Cycle_Enable_o   or
		 IR_Emitter_Carrier_Duty_cntr_tc_nxt or
		 IR_Emitter_Carrier_Duty_cntr_tc
        )
begin
    case(IR_Emitter_Carrier_Duty_State)
	DUTY_IDLE_ST:
	begin
		case(IR_Emitter_Carrier_Enable_i)
		1'b0: // Waiting for the Carrier Signal to be enabled
		begin
			IR_Emitter_Carrier_Duty_State_nxt   <= DUTY_IDLE_ST;

			IR_Emitter_Carrier_Duty_cntr_ld_nxt <= 1'b1;
			IR_Emitter_Carrier_Signal_o_nxt     <= 1'b0;
		end
		1'b1:  // The Carrier Signal has been enabled
		begin
			IR_Emitter_Carrier_Duty_State_nxt   <= DUTY_COUNT_ST;

			IR_Emitter_Carrier_Duty_cntr_ld_nxt <=  IR_Emitter_Carrier_Duty_cntr_tc_nxt;
			IR_Emitter_Carrier_Signal_o_nxt     <=  1'b1;
		end
        endcase
	end
    DUTY_COUNT_ST:
	begin
		case({IR_Emitter_Carrier_Enable_i, 
              IR_Emitter_Carrier_Cycle_Enable_o, 
              IR_Emitter_Carrier_Duty_cntr_tc}
	        )
		3'b100: // The Carrier Duty Cycle is counting down
		begin
			IR_Emitter_Carrier_Duty_State_nxt   <= DUTY_COUNT_ST;

			IR_Emitter_Carrier_Duty_cntr_ld_nxt <= IR_Emitter_Carrier_Duty_cntr_tc_nxt;
			IR_Emitter_Carrier_Signal_o_nxt     <= 1'b1;
		end
		3'b101: // The Carrier Cycle Count is longer than the Carrier Duty Cycle.
		begin
			IR_Emitter_Carrier_Duty_State_nxt   <= DUTY_WAIT_ST;

			IR_Emitter_Carrier_Duty_cntr_ld_nxt <= 1'b1;
			IR_Emitter_Carrier_Signal_o_nxt     <= 1'b0;
		end
		3'b110: // The Carrier Cycle Count is shorter than the Carrier Duty Cycle count.
		        // Note: For proper operation, the Carrier Cycle Count should 
				//       never be shorter than the Carrier Duty Cycle.
		begin
			IR_Emitter_Carrier_Duty_State_nxt   <= DUTY_COUNT_ST;

			IR_Emitter_Carrier_Duty_cntr_ld_nxt <= 1'b0;
			IR_Emitter_Carrier_Signal_o_nxt     <= 1'b1;
		end
		3'b111: // The Carrier Cycle Count is the same as the Carrier Duty Cycle.
		begin
			IR_Emitter_Carrier_Duty_State_nxt   <= DUTY_COUNT_ST;

			IR_Emitter_Carrier_Duty_cntr_ld_nxt <= 1'b0;
			IR_Emitter_Carrier_Signal_o_nxt     <= 1'b1;
		end
		default: // The Carrier Signal has been disabled.
		begin
			IR_Emitter_Carrier_Duty_State_nxt   <= DUTY_IDLE_ST;

			IR_Emitter_Carrier_Duty_cntr_ld_nxt <= 1'b1;
			IR_Emitter_Carrier_Signal_o_nxt     <= 1'b0;
		end
        endcase
	end
    DUTY_WAIT_ST:
	begin
		case({IR_Emitter_Carrier_Enable_i, IR_Emitter_Carrier_Cycle_Enable_o})
		2'b10: // Waiting for the Carrier Cycle Counter to count down
		begin
			IR_Emitter_Carrier_Duty_State_nxt   <= DUTY_WAIT_ST;

			IR_Emitter_Carrier_Duty_cntr_ld_nxt <= 1'b1;
			IR_Emitter_Carrier_Signal_o_nxt     <= 1'b0;
		end
		2'b11: // Carrier Cycle Counter has finished
		begin
			IR_Emitter_Carrier_Duty_State_nxt   <= DUTY_COUNT_ST;

			IR_Emitter_Carrier_Duty_cntr_ld_nxt <=  IR_Emitter_Carrier_Duty_cntr_tc_nxt;
			IR_Emitter_Carrier_Signal_o_nxt     <=  1'b1;
		end
		default: // The Carrier Signal Output has been disabled
		begin
			IR_Emitter_Carrier_Duty_State_nxt   <= DUTY_IDLE_ST;

			IR_Emitter_Carrier_Duty_cntr_ld_nxt <= 1'b1;
			IR_Emitter_Carrier_Signal_o_nxt     <= 1'b0;
		end
        endcase
	end
	default: // An unexpected condition has happened
	begin
		IR_Emitter_Carrier_Duty_State_nxt   <= DUTY_IDLE_ST;

		IR_Emitter_Carrier_Duty_cntr_ld_nxt <= 1'b1;
		IR_Emitter_Carrier_Signal_o_nxt     <= 1'b0;
	end
	endcase
end

// Define the Carrier Generator's Duty Cycle Counter's LSBs
//
// Note: The LSBs of the counter must operate at the frequency of the input
//       clock. However, the MSBs run at the division rate of the LSBs. This
//       relaxes the timing of the MSBs.
//
always@(
        IR_Emitter_Carrier_Duty_0_cntr     or
        IR_Emitter_Carrier_Duty_Len_i      or
        IR_Emitter_Carrier_Cycle_Enable_o  or
        IR_Emitter_Carrier_Duty_cntr_ld
       ) 
begin

    case({IR_Emitter_Carrier_Cycle_Enable_o,
		  IR_Emitter_Carrier_Duty_cntr_ld}
		 )
    2'b00:   IR_Emitter_Carrier_Duty_0_cntr_nxt    <= IR_Emitter_Carrier_Duty_0_cntr - 1;                       // Count
	default: IR_Emitter_Carrier_Duty_0_cntr_nxt    <= IR_Emitter_Carrier_Duty_Len_i[CARRIER_DUTY_LSB_BITS-1:0]; // Load
	endcase

    case({IR_Emitter_Carrier_Cycle_Enable_o,
		  IR_Emitter_Carrier_Duty_cntr_ld}
		 )
    2'b00:   IR_Emitter_Carrier_Duty_0_cntr_tc_nxt <= (IR_Emitter_Carrier_Duty_0_cntr == 2);                           // Count
	default: IR_Emitter_Carrier_Duty_0_cntr_tc_nxt <= (IR_Emitter_Carrier_Duty_Len_i[CARRIER_DUTY_LSB_BITS-1:0] == 0)
	                                                | (IR_Emitter_Carrier_Duty_Len_i[CARRIER_DUTY_LSB_BITS-1:0] == 1); // Load
	endcase

end


// Define the Carrier Generator's Duty Cycle Counter's MSBs
//
always@(
        IR_Emitter_Carrier_Duty_1_cntr     or
        IR_Emitter_Carrier_Duty_Len_i      or
        IR_Emitter_Carrier_Cycle_Enable_o  or
        IR_Emitter_Carrier_Duty_cntr_ld
       ) 
begin

    case({IR_Emitter_Carrier_Cycle_Enable_o,
		  IR_Emitter_Carrier_Duty_cntr_ld}
		 )
    2'b10:   IR_Emitter_Carrier_Duty_1_cntr_nxt    <= IR_Emitter_Carrier_Duty_1_cntr - 1;                   // Count
	default: IR_Emitter_Carrier_Duty_1_cntr_nxt    <= IR_Emitter_Carrier_Duty_Len_i[CARRIER_DUTY_BITS-1:
			                                                                        CARRIER_DUTY_LSB_BITS]; // Load
	endcase

    case({IR_Emitter_Carrier_Cycle_Enable_o,
		  IR_Emitter_Carrier_Duty_cntr_ld}
		 )
    2'b10:   IR_Emitter_Carrier_Duty_1_cntr_tc_nxt <= (IR_Emitter_Carrier_Duty_1_cntr == 1);                       // Count
	default: IR_Emitter_Carrier_Duty_1_cntr_tc_nxt <= (IR_Emitter_Carrier_Duty_Len_i[CARRIER_DUTY_BITS-1:
			                                                                         CARRIER_DUTY_LSB_BITS] == 0); // Load
	endcase

end


//------Instantiate Modules----------------
//



endmodule
