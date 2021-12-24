// -----------------------------------------------------------------------------
// title          : IR Hub Top Level Module
// project        : IR Hub
// -----------------------------------------------------------------------------
// file           : IR_Hub.v
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

module top   (

                Clock_i,
                Reset_i_N,

		        IR_Emitter_Gpio_Port_io,

                CpuSda,
                CpuScl,

                IR_Emitter_Interrupt_o,

                IR_LED_En

                );


//-----Port Parameters-----------------
//

parameter       I2C_ADDRESS                = 7'b0101010;    // Default uses ArcticLink II VX2/4 address
parameter       CLK_FREQ                   = 24;            // Default is 24MHz as used by I2C Slave IP

parameter       HOST_ADR_IN_BITS           =  8;
parameter       HOST_DATA_IN_BITS          =  8;
parameter       HOST_DATA_OUT_BITS         =  8;

parameter       GPIO_PORT_BITS             =  8;
parameter       GPIO_PORT_VALUE            =  8'h0;
parameter       GPIO_DIR_VALUE             =  8'hFF;

parameter       DEVICE_ID_NUM_L            =  8'h21; // Device ID LSB Bits
parameter       DEVICE_ID_NUM_H            =  8'h43; // Device ID MSB Bits
parameter       DEVICE_REV_NUM_L           =  8'h01; // Revision Number LSB Bits
parameter       DEVICE_REV_NUM_H           =  8'h00; // Revision Number MSB Bits

	
//-----Port Signals--------------------
//

input                           Clock_i;
input                           Reset_i_N;

inout                           CpuSda;
inout                           CpuScl;

inout      [GPIO_PORT_BITS-1:0] IR_Emitter_Gpio_Port_io;

output                          IR_Emitter_Interrupt_o;

output                          IR_LED_En;


wire                            Clock_i;
wire                            Reset_i_N;

wire                            CpuSda;
wire                            CpuScl;

wire       [GPIO_PORT_BITS-1:0] IR_Emitter_Gpio_Port_io;

wire                            IR_Emitter_Interrupt_o;

wire                            IR_LED_En;

//------Internal Signals-------------------
//
//
wire                            Reset_i;
wire                            Clock_i_gclk;

wire     [HOST_ADR_IN_BITS-1:0] RegAddr_i;
wire    [HOST_DATA_IN_BITS-1:0] RegData_i;
wire   [HOST_DATA_OUT_BITS-1:0] RegData_o;

wire                            RegWr_En_i;
wire                            RegRd_En_i;


//------Define Parameters------------------
//


//------Logic Operations-------------------
//

// Invert the incomming reset
//
assign Reset_i = ~Reset_i_N;


// Define the global clock
//
//gclkbuff u_Clock_i_gclkbuff (.A(Clock_i), .Z(Clock_i_gclk));
assign Clock_i_gclk = Clock_i;
//pragma attribute u_Clock_i_gclkbuff ql_pack 1
//pragma attribute u_Clock_i_gclkbuff hierarchy preserve


//------Instantiate Modules----------------
//


///////////////////////////////
// I2C Host Interface
//

i2cSlaveTop                                #(

        .I2C_ADDRESS                        (I2C_ADDRESS),
        .CLK_FREQ                           (CLK_FREQ)

		)
		
		u_i2cSlaveTop                       (

        .ClockIn                            (Clock_i_gclk),
        .ResetIn                            (Reset_i),
        .Scl                                (CpuScl),
        .Sda                                (CpuSda),
        .RegAddrOut                         (RegAddr_i),
        .RegDataIn                          (RegData_o),
        .RegDataOut                         (RegData_i),
        .WriteEnableOut                     (RegWr_En_i),
        .I2CReadDataLatchedOut              (RegRd_En_i)

         );


///////////////////////////////
// IR Emitter Interface
//

IR_Emitter_Interface                       #(
	   
        .HOST_ADR_IN_BITS                   (HOST_ADR_IN_BITS),
        .HOST_DATA_IN_BITS                  (HOST_DATA_IN_BITS),
        .HOST_DATA_OUT_BITS                 (HOST_DATA_OUT_BITS),

        .GPIO_PORT_BITS                     (GPIO_PORT_BITS),
        .GPIO_PORT_VALUE                    (GPIO_PORT_VALUE),
        .GPIO_DIR_VALUE                     (GPIO_DIR_VALUE),

        .DEVICE_ID_NUM_L                    (DEVICE_ID_NUM_L),
        .DEVICE_ID_NUM_H                    (DEVICE_ID_NUM_H),
        .DEVICE_REV_NUM_L                   (DEVICE_REV_NUM_L),
        .DEVICE_REV_NUM_H	                (DEVICE_REV_NUM_H)
	
        )

		u_IR_Emitter_Interface

		                                    (
        .Clock_i                            (Clock_i_gclk),
        .Reset_i                            (Reset_i),

		.IR_Emitter_Gpio_Port_io            (IR_Emitter_Gpio_Port_io),

		.RegAddr_i                          (RegAddr_i),
		.RegData_i                          (RegData_i),
		.RegWr_En_i                         (RegWr_En_i),
		.RegRd_En_i                         (RegRd_En_i),

		.RegData_o                          (RegData_o),

		.IR_Emitter_Interrupt_o             (IR_Emitter_Interrupt_o),
		.IR_LED_En_o                        (IR_LED_En)

        );


endmodule
