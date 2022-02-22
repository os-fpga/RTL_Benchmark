/*------------------------------------------------------------------------------
 * --
 *  --   FileName:         verilog_debounce.v
 *  --   Dependencies:     debounce.vhd
 *  --   Design Software:  Quartus Prime Version 17.0.0 Build 595 SJ Lite
 *  Edition
 *  --
 *  --   HDL CODE IS PROVIDED "AS IS."  DIGI-KEY EXPRESSLY DISCLAIMS ANY
 *  --   WARRANTY OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING BUT NOT
 *  --   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
 *  --   PARTICULAR PURPOSE, OR NON-INFRINGEMENT. IN NO EVENT SHALL DIGI-KEY
 *  --   BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR CONSEQUENTIAL
 *  --   DAMAGES, LOST PROFITS OR LOST DATA, HARM TO YOUR EQUIPMENT, COST OF
 *  --   PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS
 *  --   BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF),
 *  --   ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER SIMILAR COSTS.
 *  --
 *  --   Version History
 *  --   Version 1.0 11/2/2021 Scott Larson
 *  --     Initial Public Release
 *  --
 *  ------------------------------------------------------------------------------*/

module verilog_debounce(
    input clk,             //system clock
    input reset_n,         //asynchronous active low reset
    input [1:0] button,    //two input signals to be debounced
    output [1:0] result    //two debounced signals
    );

    debounce #(50_000_000,10)                     //VHDL component name and generic parameter mapping
    debounce_0(clk,reset_n,button[0],result[0]);  //instance name and port mapping for first signal

    debounce #(50_000_000,10)                     //VHDL component name and generic parameter mapping
    debounce_1(clk,reset_n,button[1],result[1]);  //instance name and port mapping for second signal
	 
endmodule
