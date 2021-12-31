// -----------------------------------------------------------------------------
// title          : IR Emitter Register Module
// project        : IR Hub
// -----------------------------------------------------------------------------
// file           : IR_Emitter_Registers.v
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
//              This modules provide the registers used to the control the IP.
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

module IR_Emitter_Registers (

                Clock_i,
                Reset_i,

                IR_Emitter_Busy_Modulator_i,

                IR_Emitter_Gpio_Port_i,

		        RegAddr_i,
		        RegData_i,
		        RegWr_En_i,

		        RegData_o,

                IR_Emitter_Run_Modulator_o,
		        IR_Emitter_Mode_Modulator_o,

                IR_Emitter_Carrier_Cycle_Len_o,
                IR_Emitter_Carrier_Duty_Len_o,

		        IR_Emitter_MemRd_Start_o,
		        IR_Emitter_MemRd_Stop_o,

                IR_Emitter_MemAddr_Reg_o,

                IR_LED_Gpio_Polarity_o,
		        IR_LED_Gpio_o,

                IR_Emitter_Gpio_Port_o,
                IR_Emitter_Gpio_Dir_o,

				IR_Emitter_Interrupt_o

                );


//-----Port Parameters-----------------
//

parameter       CARRIER_CYCLE_BITS  = 16;
parameter       CARRIER_DUTY_BITS   = 16;
parameter       HOST_ADR_IN_BITS    =  8;
parameter       HOST_DATA_IN_BITS   =  8;
parameter       HOST_DATA_OUT_BITS  =  8;
parameter       MEM_BLOCK_ADR_BITS  = 10;
parameter       MEM_ADR_BUS_BITS    = 13;
parameter       GPIO_PORT_BITS      =  8;
parameter       GPIO_PORT_VALUE     = 8'h0;
parameter       GPIO_DIR_VALUE      = 8'hFF;
parameter       DEVICE_ID_NUM_L     = 8'h21;
parameter       DEVICE_ID_NUM_H     = 8'h43;
parameter       DEVICE_REV_NUM_L    = 8'h01;
parameter       DEVICE_REV_NUM_H    = 8'h00;

//-----Port Signals--------------------
//

input                            Clock_i;
input                            Reset_i;

input                            IR_Emitter_Busy_Modulator_i;    // IR Emitter Statemachine is busy generating IR waveforms

input       [GPIO_PORT_BITS-1:0] IR_Emitter_Gpio_Port_i;

input     [HOST_ADR_IN_BITS-1:0] RegAddr_i;
input    [HOST_DATA_IN_BITS-1:0] RegData_i;
input                            RegWr_En_i;

output  [HOST_DATA_OUT_BITS-1:0] RegData_o;

output                           IR_Emitter_Run_Modulator_o;     // IR Emitter Statemachine Run Command
output                     [1:0] IR_Emitter_Mode_Modulator_o;    // IR Emitter Statemachine Operating Mode

output  [CARRIER_CYCLE_BITS-1:0] IR_Emitter_Carrier_Cycle_Len_o; // Carrier Generator Cycle Length
output  [ CARRIER_DUTY_BITS-1:0] IR_Emitter_Carrier_Duty_Len_o;  // Carrier Duty      Cycle Length

output    [MEM_ADR_BUS_BITS-1:0] IR_Emitter_MemRd_Start_o;
output    [MEM_ADR_BUS_BITS-1:0] IR_Emitter_MemRd_Stop_o;

output    [MEM_ADR_BUS_BITS-
		   HOST_ADR_IN_BITS  :0] IR_Emitter_MemAddr_Reg_o;

output                           IR_LED_Gpio_Polarity_o;
output                           IR_LED_Gpio_o;                  // IR LED Controlled via "General Purpose I/O"

output      [GPIO_PORT_BITS-1:0] IR_Emitter_Gpio_Port_o;
output      [GPIO_PORT_BITS-1:0] IR_Emitter_Gpio_Dir_o;

output                           IR_Emitter_Interrupt_o;


wire                             Clock_i;
wire                             Reset_i;

wire                             IR_Emitter_Busy_Modulator_i;    // IR Emitter Statemachine is busy generating IR waveforms

wire      [HOST_ADR_IN_BITS-1:0] RegAddr_i;
wire     [HOST_DATA_IN_BITS-1:0] RegData_i;
wire                             RegWr_En_i;

reg     [HOST_DATA_OUT_BITS-1:0] RegData_o;

reg                              IR_Emitter_Run_Modulator_o;     // IR Emitter Statemachine Run Command
reg                        [1:0] IR_Emitter_Mode_Modulator_o;    // IR Emitter Statemachine Operating Mode

reg     [CARRIER_CYCLE_BITS-1:0] IR_Emitter_Carrier_Cycle_Len_o; // Carrier Generator Cycle Length
reg     [ CARRIER_DUTY_BITS-1:0] IR_Emitter_Carrier_Duty_Len_o;  // Carrier Duty      Cycle Length

reg       [MEM_ADR_BUS_BITS-1:0] IR_Emitter_MemRd_Start_o;
reg       [MEM_ADR_BUS_BITS-1:0] IR_Emitter_MemRd_Stop_o;

reg       [MEM_ADR_BUS_BITS-
		   HOST_ADR_IN_BITS  :0] IR_Emitter_MemAddr_Reg_o;

reg                              IR_LED_Gpio_Polarity_o;
reg                              IR_LED_Gpio_o;                  // IR LED Controlled via "General Purpose I/O"

reg         [GPIO_PORT_BITS-1:0] IR_Emitter_Gpio_Port_o;
reg         [GPIO_PORT_BITS-1:0] IR_Emitter_Gpio_Dir_o;

wire                             IR_Emitter_Interrupt_o;


//------Internal Signals-------------------
//

reg       [HOST_ADR_IN_BITS-1:0] RegAddr_i_1ff;

reg     [HOST_DATA_OUT_BITS-1:0] RegData_o_comb;

wire                             command_reg_we_dcd;
wire                             control_reg_we_dcd;

wire                             IR_Emitter_Carrier_Cycle_Len_L_we_dcd;
wire                             IR_Emitter_Carrier_Cycle_Len_H_we_dcd;

wire                             IR_Emitter_Carrier_Duty_Len_L_we_dcd;
wire                             IR_Emitter_Carrier_Duty_Len_H_we_dcd;

wire                             IR_Emitter_MemRd_Start_L_we_dcd;
wire                             IR_Emitter_MemRd_Start_H_we_dcd;

wire                             IR_Emitter_MemRd_Stop_L_we_dcd;
wire                             IR_Emitter_MemRd_Stop_H_we_dcd;

wire                             IR_Emitter_MemAddr_Reg_L_we_dcd;

wire                             IR_Emitter_Gpio_Port_Reg_L_we_dcd;

wire                             IR_Emitter_Gpio_Dir_Reg_L_we_dcd;

reg                              IR_Emitter_Busy_Modulator_i_1ff;

reg                              IR_Emitter_Interrupt;
reg                              IR_Emitter_Interrupt_Enable;


//------Define Parameters------------------
//

// Define the available registers
//
parameter DEVICE_ID_ADR_L                     = 8'h00;  // Read only value
parameter DEVICE_ID_ADR_H                     = 8'h01;  // Read only value

parameter DEVICE_REVISION_ADR_L               = 8'h02;  // Read only value
parameter DEVICE_REVISION_ADR_H               = 8'h03;  // Read only value

parameter IR_EMITTER_COMMAND_REG_ADR          = 8'h04;
parameter IR_EMITTER_CONTROL_REG_ADR          = 8'h05;

parameter IR_EMITTER_CARRIER_CYCLE_LEN_ADR_L  = 8'h06;
parameter IR_EMITTER_CARRIER_CYCLE_LEN_ADR_H  = 8'h07;

parameter IR_EMITTER_CARRIER_DUTY_LEN_ADR_L   = 8'h08;
parameter IR_EMITTER_CARRIER_DUTY_LEN_ADR_H   = 8'h09; 

parameter IR_EMITTER_MEM_READ_START_ADR_L     = 8'h0a;
parameter IR_EMITTER_MEM_READ_START_ADR_H     = 8'h0b;

parameter IR_EMITTER_MEM_READ_STOP_ADR_L      = 8'h0c;
parameter IR_EMITTER_MEM_READ_STOP_ADR_H      = 8'h0d;

parameter IR_EMITTER_MEM_ADDR_REG_ADR_L       = 8'h0e;
parameter IR_EMITTER_MEM_ADDR_REG_ADR_H       = 8'h0f;  // Currently not used

parameter IR_EMITTER_GPIO_PORT_REG_ADR_L      = 8'h10;
parameter IR_EMITTER_GPIO_PORT_REG_ADR_H      = 8'h11;  // Currently not used

parameter IR_EMITTER_GPIO_DIR_REG_ADR_L       = 8'h12;
parameter IR_EMITTER_GPIO_DIR_REG_ADR_H       = 8'h13;  // Currently not used


//------Logic Operations-------------------
//

// Define the Interrupt output
//
// Note: The interrupt state can be read regardless of if the output is enabled.
//
//       The interrupt is "high" true and there is no polarity bit for changing it.
//
assign IR_Emitter_Interrupt_o                 = IR_Emitter_Interrupt & IR_Emitter_Interrupt_Enable;


// Define the register write enables.
//
assign command_reg_we_dcd                     = (RegAddr_i_1ff == IR_EMITTER_COMMAND_REG_ADR)         & RegWr_En_i;
assign control_reg_we_dcd                     = (RegAddr_i_1ff == IR_EMITTER_CONTROL_REG_ADR)         & RegWr_En_i;

assign IR_Emitter_Carrier_Cycle_Len_L_we_dcd  = (RegAddr_i_1ff == IR_EMITTER_CARRIER_CYCLE_LEN_ADR_L) & RegWr_En_i;
assign IR_Emitter_Carrier_Cycle_Len_H_we_dcd  = (RegAddr_i_1ff == IR_EMITTER_CARRIER_CYCLE_LEN_ADR_H) & RegWr_En_i;

assign IR_Emitter_Carrier_Duty_Len_L_we_dcd   = (RegAddr_i_1ff == IR_EMITTER_CARRIER_DUTY_LEN_ADR_L)  & RegWr_En_i;
assign IR_Emitter_Carrier_Duty_Len_H_we_dcd   = (RegAddr_i_1ff == IR_EMITTER_CARRIER_DUTY_LEN_ADR_H)  & RegWr_En_i;

assign IR_Emitter_MemRd_Start_L_we_dcd        = (RegAddr_i_1ff == IR_EMITTER_MEM_READ_START_ADR_L)    & RegWr_En_i;
assign IR_Emitter_MemRd_Start_H_we_dcd        = (RegAddr_i_1ff == IR_EMITTER_MEM_READ_START_ADR_H)    & RegWr_En_i;

assign IR_Emitter_MemRd_Stop_L_we_dcd         = (RegAddr_i_1ff == IR_EMITTER_MEM_READ_STOP_ADR_L)     & RegWr_En_i;
assign IR_Emitter_MemRd_Stop_H_we_dcd         = (RegAddr_i_1ff == IR_EMITTER_MEM_READ_STOP_ADR_H)     & RegWr_En_i;

assign IR_Emitter_MemAddr_Reg_L_we_dcd        = (RegAddr_i_1ff == IR_EMITTER_MEM_ADDR_REG_ADR_L)      & RegWr_En_i;

assign IR_Emitter_Gpio_Port_Reg_L_we_dcd      = (RegAddr_i_1ff == IR_EMITTER_GPIO_PORT_REG_ADR_L)     & RegWr_En_i;
assign IR_Emitter_Gpio_Dir_Reg_L_we_dcd       = (RegAddr_i_1ff == IR_EMITTER_GPIO_DIR_REG_ADR_L)      & RegWr_En_i;


// Define the register read-back logic
//
always @(
        IR_Emitter_Run_Modulator_o      or
        IR_Emitter_Mode_Modulator_o     or
        IR_Emitter_Busy_Modulator_i     or
		IR_LED_Gpio_Polarity_o          or
		IR_LED_Gpio_o                   or
        IR_Emitter_Carrier_Cycle_Len_o  or
        IR_Emitter_Carrier_Duty_Len_o   or
        IR_Emitter_MemRd_Start_o        or
        IR_Emitter_MemRd_Stop_o         or
        IR_Emitter_MemAddr_Reg_o        or
        IR_Emitter_Gpio_Port_i          or
        IR_Emitter_Gpio_Dir_o           or
        IR_Emitter_Interrupt            or
        IR_Emitter_Interrupt_Enable     or
		RegAddr_i_1ff                   or
		RegData_o_comb
        )
begin
    case(RegAddr_i_1ff)
    DEVICE_ID_ADR_L:                    RegData_o_comb <=  DEVICE_ID_NUM_L;
    DEVICE_ID_ADR_H:                    RegData_o_comb <=  DEVICE_ID_NUM_H;

    DEVICE_REVISION_ADR_L:              RegData_o_comb <=  DEVICE_REV_NUM_L;
    DEVICE_REVISION_ADR_H:              RegData_o_comb <=  DEVICE_REV_NUM_H;

    IR_EMITTER_COMMAND_REG_ADR:         RegData_o_comb <= {3'h0, IR_Emitter_Busy_Modulator_i, 3'h0, IR_Emitter_Run_Modulator_o};
    IR_EMITTER_CONTROL_REG_ADR:         RegData_o_comb <= {2'h0, IR_Emitter_Interrupt_Enable, 
			                                                     IR_Emitter_Interrupt, 
																 IR_LED_Gpio_Polarity_o, 
																 IR_LED_Gpio_o, 
																 IR_Emitter_Mode_Modulator_o};

    IR_EMITTER_CARRIER_CYCLE_LEN_ADR_L: RegData_o_comb <= IR_Emitter_Carrier_Cycle_Len_o[HOST_DATA_IN_BITS-1:0];
    IR_EMITTER_CARRIER_CYCLE_LEN_ADR_H: RegData_o_comb <= IR_Emitter_Carrier_Cycle_Len_o[CARRIER_CYCLE_BITS-1:HOST_DATA_IN_BITS];

    IR_EMITTER_CARRIER_DUTY_LEN_ADR_L:  RegData_o_comb <= IR_Emitter_Carrier_Duty_Len_o [HOST_DATA_IN_BITS-1:0];
    IR_EMITTER_CARRIER_DUTY_LEN_ADR_H:  RegData_o_comb <= IR_Emitter_Carrier_Duty_Len_o [CARRIER_DUTY_BITS-1:HOST_DATA_IN_BITS];

    IR_EMITTER_MEM_READ_START_ADR_L:    RegData_o_comb <= IR_Emitter_MemRd_Start_o[HOST_DATA_IN_BITS-1:0];
    IR_EMITTER_MEM_READ_START_ADR_H:    RegData_o_comb <= IR_Emitter_MemRd_Start_o[MEM_ADR_BUS_BITS-1:HOST_DATA_IN_BITS];

    IR_EMITTER_MEM_READ_STOP_ADR_L:     RegData_o_comb <= IR_Emitter_MemRd_Stop_o[HOST_DATA_IN_BITS-1:0];
    IR_EMITTER_MEM_READ_STOP_ADR_H:     RegData_o_comb <= IR_Emitter_MemRd_Stop_o[MEM_ADR_BUS_BITS-1:HOST_DATA_IN_BITS];

    IR_EMITTER_MEM_ADDR_REG_ADR_L:      RegData_o_comb <= {2'h0, IR_Emitter_MemAddr_Reg_o[MEM_ADR_BUS_BITS-HOST_ADR_IN_BITS:0]};

    IR_EMITTER_GPIO_PORT_REG_ADR_L:     RegData_o_comb <= IR_Emitter_Gpio_Port_i[HOST_DATA_IN_BITS-1:0];
    IR_EMITTER_GPIO_DIR_REG_ADR_L:      RegData_o_comb <= IR_Emitter_Gpio_Dir_o[HOST_DATA_IN_BITS-1:0];
	default:                            RegData_o_comb <=  8'h0;
	endcase
end

// Define the IR Emitter's Registers
//
always @(posedge Clock_i or posedge Reset_i) 
begin
    if (Reset_i)
    begin

        RegAddr_i_1ff                      <=  0;
 
        RegData_o                          <=  0;

        IR_Emitter_Run_Modulator_o         <=  1'b0;
        IR_Emitter_Mode_Modulator_o        <=  2'h0;

        IR_Emitter_Carrier_Cycle_Len_o     <=  0;
        IR_Emitter_Carrier_Duty_Len_o      <=  0;

        IR_Emitter_MemRd_Start_o           <=  0;
        IR_Emitter_MemRd_Stop_o            <=  0;

		IR_Emitter_MemAddr_Reg_o           <=  0;

        IR_LED_Gpio_Polarity_o             <=  1'b1;
        IR_LED_Gpio_o                      <=  1'b0;

        IR_Emitter_Gpio_Port_o             <=  GPIO_PORT_VALUE;
        IR_Emitter_Gpio_Dir_o              <=  GPIO_DIR_VALUE;

        IR_Emitter_Busy_Modulator_i_1ff    <=  1'b0;

        IR_Emitter_Interrupt               <=  1'b0;
        IR_Emitter_Interrupt_Enable        <=  1'b0;

    end
    else 
    begin  

        RegAddr_i_1ff                      <= RegAddr_i;
        RegData_o                          <= RegData_o_comb;

        IR_Emitter_Run_Modulator_o         <= command_reg_we_dcd && RegData_i[0];

        if (control_reg_we_dcd)
		begin
            IR_Emitter_Mode_Modulator_o    <= RegData_i[1:0];
            IR_LED_Gpio_o                  <= RegData_i[2];
            IR_LED_Gpio_Polarity_o         <= RegData_i[3];
            IR_Emitter_Interrupt_Enable    <= RegData_i[5];
        end

		// Issue an interrupt at the end of the IR Emitter Sequence.
		//
        if (control_reg_we_dcd)
            IR_Emitter_Interrupt           <= RegData_i[4];
		else if (IR_Emitter_Busy_Modulator_i_1ff && (!IR_Emitter_Busy_Modulator_i))
            IR_Emitter_Interrupt           <= 1'b1;

        IR_Emitter_Busy_Modulator_i_1ff    <=  IR_Emitter_Busy_Modulator_i;


        if (IR_Emitter_Carrier_Cycle_Len_L_we_dcd)
            IR_Emitter_Carrier_Cycle_Len_o[HOST_DATA_IN_BITS-1:0]                  <= RegData_i[HOST_DATA_IN_BITS-1:0];

        if (IR_Emitter_Carrier_Cycle_Len_H_we_dcd)
            IR_Emitter_Carrier_Cycle_Len_o[CARRIER_CYCLE_BITS-1:HOST_DATA_IN_BITS] <= RegData_i[CARRIER_CYCLE_BITS-HOST_DATA_IN_BITS-1:0];

        if (IR_Emitter_Carrier_Duty_Len_L_we_dcd)
            IR_Emitter_Carrier_Duty_Len_o [HOST_DATA_IN_BITS-1:0]                  <= RegData_i[HOST_DATA_IN_BITS-1:0];

        if (IR_Emitter_Carrier_Duty_Len_H_we_dcd)
            IR_Emitter_Carrier_Duty_Len_o [CARRIER_DUTY_BITS-1:HOST_DATA_IN_BITS]  <= RegData_i[CARRIER_DUTY_BITS-HOST_DATA_IN_BITS-1:0];

        if (IR_Emitter_MemRd_Start_L_we_dcd)
            IR_Emitter_MemRd_Start_o      [HOST_DATA_IN_BITS-1:0]                  <= RegData_i[HOST_DATA_IN_BITS-1:0];

        if (IR_Emitter_MemRd_Start_H_we_dcd)
            IR_Emitter_MemRd_Start_o      [MEM_ADR_BUS_BITS-1:HOST_DATA_IN_BITS]   <= RegData_i[MEM_ADR_BUS_BITS-HOST_DATA_IN_BITS-1:0];

        if (IR_Emitter_MemRd_Stop_L_we_dcd)
            IR_Emitter_MemRd_Stop_o       [HOST_DATA_IN_BITS-1:0]                  <= RegData_i[HOST_DATA_IN_BITS-1:0];

        if (IR_Emitter_MemRd_Stop_H_we_dcd)
            IR_Emitter_MemRd_Stop_o       [MEM_ADR_BUS_BITS-1:HOST_DATA_IN_BITS]   <= RegData_i[MEM_ADR_BUS_BITS-HOST_DATA_IN_BITS-1:0];

        if (IR_Emitter_MemAddr_Reg_L_we_dcd)
            IR_Emitter_MemAddr_Reg_o      [MEM_ADR_BUS_BITS-HOST_ADR_IN_BITS:0]    <= RegData_i[MEM_ADR_BUS_BITS-HOST_ADR_IN_BITS:0];

        if (IR_Emitter_Gpio_Port_Reg_L_we_dcd)
            IR_Emitter_Gpio_Port_o        [HOST_DATA_IN_BITS-1:0]                  <= RegData_i[HOST_DATA_IN_BITS-1:0];

        if (IR_Emitter_Gpio_Dir_Reg_L_we_dcd)
            IR_Emitter_Gpio_Dir_o         [HOST_DATA_IN_BITS-1:0]                  <= RegData_i[HOST_DATA_IN_BITS-1:0];

	end
end

//------Instantiate Modules----------------
//



endmodule
