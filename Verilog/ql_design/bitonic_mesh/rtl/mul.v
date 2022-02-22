
/****************************************************************************
          MUL/DIV unit

Operation table

   op
   0    MULTU
   1    MULT
****************************************************************************/
module mul(
            opA, opB, 
            op,                 //is_signed
            hi, lo);
parameter WIDTH=32;

input [WIDTH-1:0] opA;
input [WIDTH-1:0] opB;
input op;

output [WIDTH-1:0] hi;
output [WIDTH-1:0] lo;

wire is_signed;
assign is_signed=op;

wire dum,dum2;
wire [WIDTH:0] dataa, datab;
wire [2*WIDTH+1:0] mult;

assign dataa = {is_signed&opA[WIDTH-1],opA};
assign datab = {is_signed&opB[WIDTH-1],opB};
assign mult = dataa * datab;

assign lo = mult[WIDTH -1:0];
assign hi = mult[2*WIDTH-1 :WIDTH];
assign dum = mult[2*WIDTH];
assign dum2 = mult[2*WIDTH+1];
/*
    lpm_mult	lpm_mult_component (
        .dataa ({is_signed&opA[WIDTH-1],opA}),
        .datab ({is_signed&opB[WIDTH-1],opB}),
        .result ({dum2,dum,hi,lo})
        // synopsys translate_off
        ,
        .clken (1'b1),
        .clock (1'b0),
        .sum (1'b0),
        .aclr (1'b0)
        // synopsys translate_on
    );
    defparam
        lpm_mult_component.lpm_widtha = WIDTH+1,
        lpm_mult_component.lpm_widthb = WIDTH+1,
        lpm_mult_component.lpm_widthp = 2*WIDTH+2,
        lpm_mult_component.lpm_widths = 1,
        lpm_mult_component.lpm_pipeline = 0,
        lpm_mult_component.lpm_type = "LPM_MULT",
        lpm_mult_component.lpm_representation = "SIGNED",
        lpm_mult_component.lpm_hint = "MAXIMIZE_SPEED=6";
        
*/

endmodule
