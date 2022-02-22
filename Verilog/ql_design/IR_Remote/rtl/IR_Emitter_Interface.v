// -----------------------------------------------------------------------------
// title          : IR Emitter Interface Top Level Module
// project        : IR Hub
// -----------------------------------------------------------------------------
// file           : IR_Emitter_Interface.v
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

module IR_Emitter_Interface (

                Clock_i,
                Reset_i,

		        IR_Emitter_Gpio_Port_io,

		        RegAddr_i,
		        RegData_i,
		        RegWr_En_i,
		        RegRd_En_i,

		        RegData_o,

				IR_Emitter_Interrupt_o,
		        IR_LED_En_o

                );


//-----Port Parameters-----------------
//

parameter       CARRIER_CYCLE_BITS   = 16;    // Maximum size of Carrier Cycle       Counter
parameter       CARRIER_DUTY_BITS    = 16;    // Maximum size of Carrier Duty  Cycle Counter

parameter       MODULATOR_PULSE_BITS = 16;    // Maximum size of Modulator Pulse Cycle Counter

parameter       HOST_ADR_IN_BITS     =  8;    // Host Interface Input  Address Bus width
parameter       HOST_DATA_IN_BITS    =  8;    // Host Interface Input  Data    Bus width
parameter       HOST_DATA_OUT_BITS   =  8;    // Host Interface Output Data    Bus width

parameter       MEM_BLOCKS_NUM       =  8;    // Number of Instantiated Memory Blocks
parameter       MEM_BLOCK_ADR_BITS   = 10;    // Address Port Bit Width for Instantiated Memory Blocks (i.e. 1024 Addresses)
parameter       MEM_BLOCK_DATA_BITS  =  9;    // Data    Port Bit Width for Instantiated Memory Blocks (i.e. 1 Byte + Parity)

parameter       MEM_MAX_PHYS_SIZE    = ((MEM_BLOCKS_NUM * 1024) - 1);  // Total Amount of Physical Memory Capacity Available
parameter       MEM_ADR_BUS_BITS     = 13;                             // Total Memory Address Bus Width

parameter       GPIO_PORT_BITS       =  8;
parameter       GPIO_PORT_VALUE      =  8'h0;
parameter       GPIO_DIR_VALUE       =  8'hFF;

parameter       DEVICE_ID_NUM_L      =  8'h21; // Device ID LSB Bits
parameter       DEVICE_ID_NUM_H      =  8'h43; // Device ID MSB Bits
parameter       DEVICE_REV_NUM_L     =  8'h01; // Revision Number LSB Bits
parameter       DEVICE_REV_NUM_H     =  8'h00; // Revision Number MSB Bits
	

//-----Port Signals--------------------
//

input                            Clock_i;
input                            Reset_i;

inout       [GPIO_PORT_BITS-1:0] IR_Emitter_Gpio_Port_io;

input     [HOST_ADR_IN_BITS-1:0] RegAddr_i;
input    [HOST_DATA_IN_BITS-1:0] RegData_i;
input                            RegWr_En_i;
input                            RegRd_En_i;

output  [HOST_DATA_OUT_BITS-1:0] RegData_o;

output                           IR_Emitter_Interrupt_o;
output                           IR_LED_En_o;


wire                             Clock_i;
wire                             Reset_i;

wire        [GPIO_PORT_BITS-1:0] IR_Emitter_Gpio_Port_io;

wire      [HOST_ADR_IN_BITS-1:0] RegAddr_i;
wire     [HOST_DATA_IN_BITS-1:0] RegData_i;
wire                             RegWr_En_i;
wire                             RegRd_En_i;

wire    [HOST_DATA_OUT_BITS-1:0] RegData_o;

wire                             IR_Emitter_Interrupt_o;
wire                             IR_LED_En_o;


//------Internal Signals-------------------
//

reg                              RegRd_En_i_1ff;
reg       [HOST_ADR_IN_BITS-2:0] RegAddr_i_1ff;


// Define the Carrier Generator Signals
//
wire    [CARRIER_CYCLE_BITS-1:0] IR_Emitter_Carrier_Cycle_Len; // Carrier Generator Cycle Length
wire    [ CARRIER_DUTY_BITS-1:0] IR_Emitter_Carrier_Duty_Len;  // Carrier Duty      Cycle Length

wire                             IR_Emitter_Carrier_Cycle_Enable;
wire                             IR_Emitter_Carrier_Signal;

wire                             IR_LED_Gpio_Polarity;
wire                             IR_LED_Gpio;                  // IR LED Controlled via "General Purpose I/O"

wire        [GPIO_PORT_BITS-1:0] IR_Emitter_Gpio_Port;
wire        [GPIO_PORT_BITS-1:0] IR_Emitter_Gpio_Dir;


// Define the IR Emitter Modulator signals
//
wire                             IR_Emitter_Busy_Modulator;         // IR Emitter Statemachine is busy generating IR waveforms
wire                             IR_Emitter_Carrier_Enable;

wire      [MEM_ADR_BUS_BITS-1:0] IR_Emitter_MemAddr_Modulator;      // IR Emitter Statemachine controlled memory read address
wire                             IR_Emitter_MemRd_Stb_Modulator;    // IR Emitter Statemachine controlled memory read strobe

wire                             IR_Emitter_Run_Modulator;          // IR Emitter Statemachine Run Command
wire                       [1:0] IR_Emitter_Mode_Modulator;         // IR Emitter Statemachine Operating Mode



// Define the IR Emitter Register based signals
//
wire      [MEM_ADR_BUS_BITS-8:0] IR_Emitter_MemAddr_Reg;

wire                             IR_Emitter_MemWr_Stb_Reg;
wire                             IR_Emitter_MemRd_Stb_Reg;



// Define signals local to this module
//

wire      [MEM_ADR_BUS_BITS-1:0] IR_Emitter_MemRd_Addr;
wire      [MEM_ADR_BUS_BITS-1:0] IR_Emitter_MemWr_Addr;

wire      [MEM_ADR_BUS_BITS-1:0] IR_Emitter_MemRd_Start;
wire      [MEM_ADR_BUS_BITS-1:0] IR_Emitter_MemRd_Stop;

wire   [MEM_BLOCK_DATA_BITS-1:0] IR_Emitter_MemData_i;
reg     [HOST_DATA_OUT_BITS-1:0] IR_Emitter_MemData_o;
wire   [MEM_BLOCK_DATA_BITS-1:0] IR_Emitter_MemData_0_o;
wire   [MEM_BLOCK_DATA_BITS-1:0] IR_Emitter_MemData_1_o;
wire   [MEM_BLOCK_DATA_BITS-1:0] IR_Emitter_MemData_2_o;
wire   [MEM_BLOCK_DATA_BITS-1:0] IR_Emitter_MemData_3_o;
wire   [MEM_BLOCK_DATA_BITS-1:0] IR_Emitter_MemData_4_o;
wire   [MEM_BLOCK_DATA_BITS-1:0] IR_Emitter_MemData_5_o;
wire   [MEM_BLOCK_DATA_BITS-1:0] IR_Emitter_MemData_6_o;
wire   [MEM_BLOCK_DATA_BITS-1:0] IR_Emitter_MemData_7_o;

wire        [MEM_BLOCKS_NUM-1:0] IR_Emitter_MemWr_Sel;
wire        [MEM_BLOCKS_NUM-1:0] IR_Emitter_MemRd_Sel;


wire    [HOST_DATA_OUT_BITS-1:0] IR_Emitter_RegData_o;

wire IR_Emitter_o_8;
//------Define Parameters------------------
//


//------Logic Operations-------------------
//

// Determine the controls for the GPIO Port
//
assign IR_Emitter_Gpio_Port_io[0] = IR_Emitter_Gpio_Dir[0] ? 1'b0 : IR_Emitter_Gpio_Port[0];
assign IR_Emitter_Gpio_Port_io[1] = IR_Emitter_Gpio_Dir[1] ? 1'b0 : IR_Emitter_Gpio_Port[1];
assign IR_Emitter_Gpio_Port_io[2] = IR_Emitter_Gpio_Dir[2] ? 1'b0 : IR_Emitter_Gpio_Port[2];
assign IR_Emitter_Gpio_Port_io[3] = IR_Emitter_Gpio_Dir[3] ? 1'b0 : IR_Emitter_Gpio_Port[3];

assign IR_Emitter_Gpio_Port_io[4] = IR_Emitter_Gpio_Dir[4] ? 1'b0 : IR_Emitter_Gpio_Port[4];
assign IR_Emitter_Gpio_Port_io[5] = IR_Emitter_Gpio_Dir[5] ? 1'b0 : IR_Emitter_Gpio_Port[5];
assign IR_Emitter_Gpio_Port_io[6] = IR_Emitter_Gpio_Dir[6] ? 1'b0 : IR_Emitter_Gpio_Port[6];
assign IR_Emitter_Gpio_Port_io[7] = IR_Emitter_Gpio_Dir[7] ? IR_Emitter_o_8 : IR_Emitter_Gpio_Port[7];


// Select the address bits to use for reading and writing memory
//
// Note: Only the host interface is allowed to write to the memory. Therefore,
//       there is no need for a "write" address multiplexer.
//
assign  IR_Emitter_MemRd_Addr = IR_Emitter_Busy_Modulator ?  IR_Emitter_MemAddr_Modulator[MEM_ADR_BUS_BITS-1:0] 
                                                          : {IR_Emitter_MemAddr_Reg[MEM_ADR_BUS_BITS-HOST_ADR_IN_BITS:0], 
                                                                        RegAddr_i_1ff[HOST_ADR_IN_BITS-2:0]};

assign  IR_Emitter_MemWr_Addr = {IR_Emitter_MemAddr_Reg [MEM_ADR_BUS_BITS-HOST_ADR_IN_BITS:0], 
		                                   RegAddr_i_1ff[HOST_ADR_IN_BITS-2:0]};


// Select the Memory Data to read
//
// Note: Both the host interface and the IR Emitter Core can read from SRAM.
//
always @(
		 IR_Emitter_MemRd_Addr   or
		 IR_Emitter_MemData_0_o  or
		 IR_Emitter_MemData_1_o  or
		 IR_Emitter_MemData_2_o  or
		 IR_Emitter_MemData_3_o  or
		 IR_Emitter_MemData_4_o  or
		 IR_Emitter_MemData_5_o  or
		 IR_Emitter_MemData_6_o  or
		 IR_Emitter_MemData_7_o
        )
begin
	case(IR_Emitter_MemRd_Addr[MEM_ADR_BUS_BITS-1:MEM_BLOCK_ADR_BITS])
    3'h0:    IR_Emitter_MemData_o <= IR_Emitter_MemData_0_o[HOST_DATA_OUT_BITS-1:0];
    3'h1:    IR_Emitter_MemData_o <= IR_Emitter_MemData_1_o[HOST_DATA_OUT_BITS-1:0];
    3'h2:    IR_Emitter_MemData_o <= IR_Emitter_MemData_2_o[HOST_DATA_OUT_BITS-1:0];
    3'h3:    IR_Emitter_MemData_o <= IR_Emitter_MemData_3_o[HOST_DATA_OUT_BITS-1:0];
    3'h4:    IR_Emitter_MemData_o <= IR_Emitter_MemData_4_o[HOST_DATA_OUT_BITS-1:0];
    3'h5:    IR_Emitter_MemData_o <= IR_Emitter_MemData_5_o[HOST_DATA_OUT_BITS-1:0];
    3'h6:    IR_Emitter_MemData_o <= IR_Emitter_MemData_6_o[HOST_DATA_OUT_BITS-1:0];
    3'h7:    IR_Emitter_MemData_o <= IR_Emitter_MemData_7_o[HOST_DATA_OUT_BITS-1:0];
    default: IR_Emitter_MemData_o <= 0;
	endcase
end

// Size the in-comming data bus to the fixed size of the memory block
//
assign IR_Emitter_MemData_i = {1'b0, RegData_i};


// Select the source for data read by the host interface.
//
// Note: The host interface address space is divided in half. The lower half
//       addresses the IP's registers while the upper half addresses the IP's
//       memory.
//
assign RegData_o = RegAddr_i[HOST_ADR_IN_BITS-1] ? IR_Emitter_MemData_o[HOST_DATA_OUT_BITS-1:0] 
                                                 : IR_Emitter_RegData_o[HOST_DATA_OUT_BITS-1:0];


// Select the Read strobe signal
//
assign IR_Emitter_MemRd_Stb = IR_Emitter_Busy_Modulator ? IR_Emitter_MemRd_Stb_Modulator
                                                        : IR_Emitter_MemRd_Stb_Reg;

// Decode the Host Interface read and write strobe
//
// Note: The host interface's address range is divided into two parts. The
//       upper addresses are directed to the memory blocks.
//
assign IR_Emitter_MemRd_Stb_Reg = RegAddr_i[HOST_ADR_IN_BITS-1]  & RegRd_En_i & ~RegRd_En_i_1ff;
assign IR_Emitter_MemWr_Stb_Reg = RegAddr_i[HOST_ADR_IN_BITS-1]  & RegWr_En_i;


// Select the Read enables for each memory.
//
// Note: Both the host interface and the IR Emitter Core can read from the SRAM.
//
assign IR_Emitter_MemRd_Sel[0] = (IR_Emitter_MemRd_Addr[MEM_ADR_BUS_BITS-1:MEM_BLOCK_ADR_BITS] == 3'h0) & IR_Emitter_MemRd_Stb;
assign IR_Emitter_MemRd_Sel[1] = (IR_Emitter_MemRd_Addr[MEM_ADR_BUS_BITS-1:MEM_BLOCK_ADR_BITS] == 3'h1) & IR_Emitter_MemRd_Stb;
assign IR_Emitter_MemRd_Sel[2] = (IR_Emitter_MemRd_Addr[MEM_ADR_BUS_BITS-1:MEM_BLOCK_ADR_BITS] == 3'h2) & IR_Emitter_MemRd_Stb;
assign IR_Emitter_MemRd_Sel[3] = (IR_Emitter_MemRd_Addr[MEM_ADR_BUS_BITS-1:MEM_BLOCK_ADR_BITS] == 3'h3) & IR_Emitter_MemRd_Stb;
assign IR_Emitter_MemRd_Sel[4] = (IR_Emitter_MemRd_Addr[MEM_ADR_BUS_BITS-1:MEM_BLOCK_ADR_BITS] == 3'h4) & IR_Emitter_MemRd_Stb;
assign IR_Emitter_MemRd_Sel[5] = (IR_Emitter_MemRd_Addr[MEM_ADR_BUS_BITS-1:MEM_BLOCK_ADR_BITS] == 3'h5) & IR_Emitter_MemRd_Stb;
assign IR_Emitter_MemRd_Sel[6] = (IR_Emitter_MemRd_Addr[MEM_ADR_BUS_BITS-1:MEM_BLOCK_ADR_BITS] == 3'h6) & IR_Emitter_MemRd_Stb;
assign IR_Emitter_MemRd_Sel[7] = (IR_Emitter_MemRd_Addr[MEM_ADR_BUS_BITS-1:MEM_BLOCK_ADR_BITS] == 3'h7) & IR_Emitter_MemRd_Stb;


// Select the write enables for each memory.
//
// Note: Only the host interface will write to memory.
//
assign IR_Emitter_MemWr_Sel[0] = (IR_Emitter_MemWr_Addr[MEM_ADR_BUS_BITS-1:MEM_BLOCK_ADR_BITS] == 3'h0) & IR_Emitter_MemWr_Stb_Reg;
assign IR_Emitter_MemWr_Sel[1] = (IR_Emitter_MemWr_Addr[MEM_ADR_BUS_BITS-1:MEM_BLOCK_ADR_BITS] == 3'h1) & IR_Emitter_MemWr_Stb_Reg;
assign IR_Emitter_MemWr_Sel[2] = (IR_Emitter_MemWr_Addr[MEM_ADR_BUS_BITS-1:MEM_BLOCK_ADR_BITS] == 3'h2) & IR_Emitter_MemWr_Stb_Reg;
assign IR_Emitter_MemWr_Sel[3] = (IR_Emitter_MemWr_Addr[MEM_ADR_BUS_BITS-1:MEM_BLOCK_ADR_BITS] == 3'h3) & IR_Emitter_MemWr_Stb_Reg;
assign IR_Emitter_MemWr_Sel[4] = (IR_Emitter_MemWr_Addr[MEM_ADR_BUS_BITS-1:MEM_BLOCK_ADR_BITS] == 3'h4) & IR_Emitter_MemWr_Stb_Reg;
assign IR_Emitter_MemWr_Sel[5] = (IR_Emitter_MemWr_Addr[MEM_ADR_BUS_BITS-1:MEM_BLOCK_ADR_BITS] == 3'h5) & IR_Emitter_MemWr_Stb_Reg;
assign IR_Emitter_MemWr_Sel[6] = (IR_Emitter_MemWr_Addr[MEM_ADR_BUS_BITS-1:MEM_BLOCK_ADR_BITS] == 3'h6) & IR_Emitter_MemWr_Stb_Reg;
assign IR_Emitter_MemWr_Sel[7] = (IR_Emitter_MemWr_Addr[MEM_ADR_BUS_BITS-1:MEM_BLOCK_ADR_BITS] == 3'h7) & IR_Emitter_MemWr_Stb_Reg;

assign IR_Emitter_o_8 = (IR_Emitter_MemData_0_o[8] & 
IR_Emitter_MemData_1_o[8] & 
IR_Emitter_MemData_2_o[8] & 
IR_Emitter_MemData_3_o[8] & 
IR_Emitter_MemData_4_o[8] & 
IR_Emitter_MemData_5_o[8] & 
IR_Emitter_MemData_6_o[8] & 
IR_Emitter_MemData_7_o[8] );

// Register the Host Interface Register Read Enable
//
always @(posedge Clock_i or posedge Reset_i) 
begin
    if (Reset_i)
	begin
        RegRd_En_i_1ff                     <=  1'b0;
        RegAddr_i_1ff                      <=  0;
	end
    else 
	begin
        RegRd_En_i_1ff                     <= RegRd_En_i;
        RegAddr_i_1ff                      <= RegAddr_i[HOST_ADR_IN_BITS-2:0];
	end
end

//------Instantiate Modules----------------
//


///////////////////////////////
// IR Emitter Carrier Generator Block
//

IR_Emitter_Carrier_Generator               #(

        .CARRIER_CYCLE_BITS                 (CARRIER_CYCLE_BITS),
        .CARRIER_DUTY_BITS                  (CARRIER_DUTY_BITS)

        )

        u_IR_Emitter_Carrier_Generator      
		
		                                    (
        .Clock_i                            (Clock_i),
        .Reset_i                            (Reset_i),

        .IR_Emitter_Carrier_Enable_i        (IR_Emitter_Carrier_Enable),

		.IR_Emitter_Carrier_Cycle_Len_i     (IR_Emitter_Carrier_Cycle_Len),
        .IR_Emitter_Carrier_Duty_Len_i      (IR_Emitter_Carrier_Duty_Len),

		.IR_Emitter_Carrier_Cycle_Enable_o  (IR_Emitter_Carrier_Cycle_Enable),
		.IR_Emitter_Carrier_Signal_o        (IR_Emitter_Carrier_Signal)

        );


///////////////////////////////
// IR Emitter Modulator Block
//

IR_Emitter_Modulator                       #(

        .HOST_DATA_OUT_BITS                 (HOST_DATA_OUT_BITS),
        .MEM_BLOCK_DATA_BITS                (MEM_BLOCK_DATA_BITS),
		.MEM_ADR_BUS_BITS                   (MEM_ADR_BUS_BITS),
        .MEM_MAX_PHYS_SIZE                  (MEM_MAX_PHYS_SIZE)

         )

		u_IR_Emitter_Modulator

				                            (
        .Clock_i                            (Clock_i),
        .Reset_i                            (Reset_i),

		.IR_Emitter_Carrier_Cycle_Enable_i  (IR_Emitter_Carrier_Cycle_Enable),
		.IR_Emitter_Carrier_Signal_i        (IR_Emitter_Carrier_Signal),

        .IR_Emitter_Run_Modulator_i         (IR_Emitter_Run_Modulator),
		.IR_Emitter_Mode_Modulator_i        (IR_Emitter_Mode_Modulator),

		.IR_Emitter_MemRd_Start_i           (IR_Emitter_MemRd_Start),
		.IR_Emitter_MemRd_Stop_i            (IR_Emitter_MemRd_Stop),

        .IR_Emitter_MemData_i               (IR_Emitter_MemData_o[HOST_DATA_OUT_BITS-1:0]),

		.IR_LED_Gpio_Polarity_i             (IR_LED_Gpio_Polarity),
		.IR_LED_Gpio_i                      (IR_LED_Gpio),

		.IR_Emitter_Carrier_Enable_o        (IR_Emitter_Carrier_Enable),

        .IR_Emitter_Busy_Modulator_o        (IR_Emitter_Busy_Modulator),
        .IR_Emitter_MemAddr_Modulator_o     (IR_Emitter_MemAddr_Modulator),
        .IR_Emitter_MemRd_Stb_Modulator_o   (IR_Emitter_MemRd_Stb_Modulator),

		.IR_LED_En_o                        (IR_LED_En_o)

        );



///////////////////////////////
// IR Emitter Register Block
//

IR_Emitter_Registers                       #(
	   
        .CARRIER_CYCLE_BITS                 (CARRIER_CYCLE_BITS),
        .CARRIER_DUTY_BITS                  (CARRIER_DUTY_BITS),
        .HOST_ADR_IN_BITS                   (HOST_ADR_IN_BITS),
        .HOST_DATA_IN_BITS                  (HOST_DATA_IN_BITS),
        .HOST_DATA_OUT_BITS                 (HOST_DATA_OUT_BITS),
        .MEM_BLOCK_ADR_BITS                 (MEM_BLOCK_ADR_BITS),
		.MEM_ADR_BUS_BITS                   (MEM_ADR_BUS_BITS),
        .GPIO_PORT_BITS                     (GPIO_PORT_BITS),
        .GPIO_PORT_VALUE                    (GPIO_PORT_VALUE),
        .GPIO_DIR_VALUE                     (GPIO_DIR_VALUE),
        .DEVICE_ID_NUM_L                    (DEVICE_ID_NUM_L),
        .DEVICE_ID_NUM_H                    (DEVICE_ID_NUM_H),
        .DEVICE_REV_NUM_L                   (DEVICE_REV_NUM_L),
        .DEVICE_REV_NUM_H                   (DEVICE_REV_NUM_H)

		)
	
		u_IR_Emitter_Registers
		                                    (
        .Clock_i                            (Clock_i),
        .Reset_i                            (Reset_i),

        .IR_Emitter_Busy_Modulator_i        (IR_Emitter_Busy_Modulator),
		.IR_Emitter_Gpio_Port_i             (IR_Emitter_Gpio_Port_io),

		.RegAddr_i                          (RegAddr_i),
		.RegData_i                          (RegData_i),
		.RegWr_En_i                         (RegWr_En_i),

		.RegData_o                          (IR_Emitter_RegData_o),

        .IR_Emitter_Run_Modulator_o         (IR_Emitter_Run_Modulator),
		.IR_Emitter_Mode_Modulator_o        (IR_Emitter_Mode_Modulator),

        .IR_Emitter_Carrier_Cycle_Len_o     (IR_Emitter_Carrier_Cycle_Len),
        .IR_Emitter_Carrier_Duty_Len_o      (IR_Emitter_Carrier_Duty_Len),

		.IR_Emitter_MemRd_Start_o           (IR_Emitter_MemRd_Start),
		.IR_Emitter_MemRd_Stop_o            (IR_Emitter_MemRd_Stop),

        .IR_Emitter_MemAddr_Reg_o           (IR_Emitter_MemAddr_Reg),

		.IR_LED_Gpio_Polarity_o             (IR_LED_Gpio_Polarity),
		.IR_LED_Gpio_o                      (IR_LED_Gpio),

		.IR_Emitter_Gpio_Port_o             (IR_Emitter_Gpio_Port),
		.IR_Emitter_Gpio_Dir_o              (IR_Emitter_Gpio_Dir),

        .IR_Emitter_Interrupt_o             (IR_Emitter_Interrupt_o)

        );


///////////////////////////////
// IR Emitter SRAM Blocks
//
// Note: There are a total of 8 memory blocks available in a Polar Pro III. 
//       The memory blocks below represent the minimum size blocks supported. 
//       Therefore, blocks can be instantiated or removed by "full" block sizes.
//
//       Each SRAM can be written/read by the host interface in blocks of as 
//       much as 128 bytes. This helps to increase the data throughput by
//       reducing the ratio of overhead protocol cycles to data transfer
//       cycles.
// 

r1024x9_1024x9  u_IR_Emitter_SRAM_0 

                                            (
		.WA                                 (IR_Emitter_MemWr_Addr[MEM_BLOCK_ADR_BITS-1:0]),
		.RA                                 (IR_Emitter_MemRd_Addr[MEM_BLOCK_ADR_BITS-1:0]),
		.WD_SEL                             (IR_Emitter_MemWr_Sel[0]),
		.RD_SEL                             (IR_Emitter_MemRd_Sel[0]),
		.WClk                               (Clock_i),
		.RClk                               (Clock_i),
		.WClk_En                            (1'b1),
		.RClk_En                            (1'b1),
		.WEN                                (1'b1),
		.WD                                 (IR_Emitter_MemData_i),
		.RD                                 (IR_Emitter_MemData_0_o)
        );


r1024x9_1024x9  u_IR_Emitter_SRAM_1 

                                            (
		.WA                                 (IR_Emitter_MemWr_Addr[MEM_BLOCK_ADR_BITS-1:0]),
		.RA                                 (IR_Emitter_MemRd_Addr[MEM_BLOCK_ADR_BITS-1:0]),
		.WD_SEL                             (IR_Emitter_MemWr_Sel[1]),
		.RD_SEL                             (IR_Emitter_MemRd_Sel[1]),
		.WClk                               (Clock_i),
		.RClk                               (Clock_i),
		.WClk_En                            (1'b1),
		.RClk_En                            (1'b1),
		.WEN                                (1'b1),
		.WD                                 (IR_Emitter_MemData_i),
		.RD                                 (IR_Emitter_MemData_1_o)
        );


r1024x9_1024x9  u_IR_Emitter_SRAM_2 

                                            (
		.WA                                 (IR_Emitter_MemWr_Addr[MEM_BLOCK_ADR_BITS-1:0]),
		.RA                                 (IR_Emitter_MemRd_Addr[MEM_BLOCK_ADR_BITS-1:0]),
		.WD_SEL                             (IR_Emitter_MemWr_Sel[2]),
		.RD_SEL                             (IR_Emitter_MemRd_Sel[2]),
		.WClk                               (Clock_i),
		.RClk                               (Clock_i),
		.WClk_En                            (1'b1),
		.RClk_En                            (1'b1),
		.WEN                                (1'b1),
		.WD                                 (IR_Emitter_MemData_i),
		.RD                                 (IR_Emitter_MemData_2_o)
        );


r1024x9_1024x9  u_IR_Emitter_SRAM_3 

                                            (
		.WA                                 (IR_Emitter_MemWr_Addr[MEM_BLOCK_ADR_BITS-1:0]),
		.RA                                 (IR_Emitter_MemRd_Addr[MEM_BLOCK_ADR_BITS-1:0]),
		.WD_SEL                             (IR_Emitter_MemWr_Sel[3]),
		.RD_SEL                             (IR_Emitter_MemRd_Sel[3]),
		.WClk                               (Clock_i),
		.RClk                               (Clock_i),
		.WClk_En                            (1'b1),
		.RClk_En                            (1'b1),
		.WEN                                (1'b1),
		.WD                                 (IR_Emitter_MemData_i),
		.RD                                 (IR_Emitter_MemData_3_o)
        );


r1024x9_1024x9  u_IR_Emitter_SRAM_4 

                                            (
		.WA                                 (IR_Emitter_MemWr_Addr[MEM_BLOCK_ADR_BITS-1:0]),
		.RA                                 (IR_Emitter_MemRd_Addr[MEM_BLOCK_ADR_BITS-1:0]),
		.WD_SEL                             (IR_Emitter_MemWr_Sel[4]),
		.RD_SEL                             (IR_Emitter_MemRd_Sel[4]),
		.WClk                               (Clock_i),
		.RClk                               (Clock_i),
		.WClk_En                            (1'b1),
		.RClk_En                            (1'b1),
		.WEN                                (1'b1),
		.WD                                 (IR_Emitter_MemData_i),
		.RD                                 (IR_Emitter_MemData_4_o)
        );


r1024x9_1024x9  u_IR_Emitter_SRAM_5 

                                            (
		.WA                                 (IR_Emitter_MemWr_Addr[MEM_BLOCK_ADR_BITS-1:0]),
		.RA                                 (IR_Emitter_MemRd_Addr[MEM_BLOCK_ADR_BITS-1:0]),
		.WD_SEL                             (IR_Emitter_MemWr_Sel[5]),
		.RD_SEL                             (IR_Emitter_MemRd_Sel[5]),
		.WClk                               (Clock_i),
		.RClk                               (Clock_i),
		.WClk_En                            (1'b1),
		.RClk_En                            (1'b1),
		.WEN                                (1'b1),
		.WD                                 (IR_Emitter_MemData_i),
		.RD                                 (IR_Emitter_MemData_5_o)
        );


r1024x9_1024x9  u_IR_Emitter_SRAM_6 

                                            (
		.WA                                 (IR_Emitter_MemWr_Addr[MEM_BLOCK_ADR_BITS-1:0]),
		.RA                                 (IR_Emitter_MemRd_Addr[MEM_BLOCK_ADR_BITS-1:0]),
		.WD_SEL                             (IR_Emitter_MemWr_Sel[6]),
		.RD_SEL                             (IR_Emitter_MemRd_Sel[6]),
		.WClk                               (Clock_i),
		.RClk                               (Clock_i),
		.WClk_En                            (1'b1),
		.RClk_En                            (1'b1),
		.WEN                                (1'b1),
		.WD                                 (IR_Emitter_MemData_i),
		.RD                                 (IR_Emitter_MemData_6_o)
        );


r1024x9_1024x9  u_IR_Emitter_SRAM_7 

                                            (
		.WA                                 (IR_Emitter_MemWr_Addr[MEM_BLOCK_ADR_BITS-1:0]),
		.RA                                 (IR_Emitter_MemRd_Addr[MEM_BLOCK_ADR_BITS-1:0]),
		.WD_SEL                             (IR_Emitter_MemWr_Sel[7]),
		.RD_SEL                             (IR_Emitter_MemRd_Sel[7]),
		.WClk                               (Clock_i),
		.RClk                               (Clock_i),
		.WClk_En                            (1'b1),
		.RClk_En                            (1'b1),
		.WEN                                (1'b1),
		.WD                                 (IR_Emitter_MemData_i),
		.RD                                 (IR_Emitter_MemData_7_o)
        );


endmodule
