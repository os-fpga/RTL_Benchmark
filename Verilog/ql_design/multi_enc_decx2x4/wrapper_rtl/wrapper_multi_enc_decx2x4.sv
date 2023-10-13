//////////////////////////////////////////////////////////////////////
//Wrapper Design
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// TOP_multi_enc_decx2x4
module  wrapper_multi_enc_decx2x4(
    clock,
    datain_temp,
    reset,
    dataout_temp,
    select_datain_temp
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input          clock;
input  [127:0] datain_temp;
input          reset;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output reg [127:0] dataout_temp;
input [1:0] select_datain_temp;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
reg   [127:0] datain;
reg   [127:0] datain1;
reg   [127:0] datain1_0;
reg   [127:0] datain_0;
wire  [127:0] dataout;
wire  [127:0] dataout1;
wire  [127:0] dataout1_0;
wire  [127:0] dataout_0;

always @ (select_datain_temp, datain_temp, dataout, dataout1, dataout1_0, dataout_0)
        begin
                dataout_temp = 'b0;
                datain = 'b0;
                datain1 = 'b0;
                datain1_0 = 'b0;
                datain_0 = 'b0;
                case (select_datain_temp)
                        2'd0:   begin
                                datain = datain_temp;
                                dataout_temp = dataout;
                                end
                        2'd1:   begin
                                datain1 = datain_temp;
                                dataout_temp = dataout1;
                                end
                        2'd2:   begin
                                datain1_0 = datain_temp;
                                dataout_temp = dataout1_0;
                                end
                        2'd3:   begin
                                datain_0 = datain_temp;
                                dataout_temp = dataout_0;
                                end
                endcase
        end

//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------

multi_enc_decx2x4(
    clock,
    datain,
    datain1,
    datain1_0,
    datain_0,
    reset,
    dataout,
    dataout1,
    dataout1_0,
    dataout_0
);

endmodule
