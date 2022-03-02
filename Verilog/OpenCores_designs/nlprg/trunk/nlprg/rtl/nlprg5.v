/*
 * Generated by Digital. Don't modify this file!
 * Any changes will be lost if this file is regenerated.
 */

module DIG_D_FF_AS_1bit
#(
    parameter Default = 0
)
(
   input Set,
   input D,
   input C,
   input Clr,
   output Q,
   output \~Q
);
    reg state;

    assign Q = state;
    assign \~Q  = ~state;

    always @ (posedge C or posedge Clr or posedge Set)
    begin
        if (Set)
            state <= 1'b1;
        else if (Clr)
            state <= 'h0;
        else
            state <= D;
    end

    initial begin
        state = Default;
    end
endmodule

module nlprg5 (
  input ck,
  input rst,
  output [4:0] o
);
  wire o0;
  wire o1;
  wire o2;
  wire o3;
  wire o4;
  wire s0;
  wire s1;
  wire s2;
  DIG_D_FF_AS_1bit #(
    .Default(0)
  )
  DIG_D_FF_AS_1bit_i0 (
    .Set( 1'b0 ),
    .D( s0 ),
    .C( ck ),
    .Clr( rst ),
    .Q( o0 )
  );
  DIG_D_FF_AS_1bit #(
    .Default(0)
  )
  DIG_D_FF_AS_1bit_i1 (
    .Set( 1'b0 ),
    .D( s1 ),
    .C( ck ),
    .Clr( rst ),
    .Q( o2 )
  );
  DIG_D_FF_AS_1bit #(
    .Default(0)
  )
  DIG_D_FF_AS_1bit_i2 (
    .Set( 1'b0 ),
    .D( s2 ),
    .C( ck ),
    .Clr( rst ),
    .Q( o1 )
  );
  DIG_D_FF_AS_1bit #(
    .Default(0)
  )
  DIG_D_FF_AS_1bit_i3 (
    .Set( 1'b0 ),
    .D( o2 ),
    .C( ck ),
    .Clr( rst ),
    .Q( o3 )
  );
  DIG_D_FF_AS_1bit #(
    .Default(0)
  )
  DIG_D_FF_AS_1bit_i4 (
    .Set( 1'b0 ),
    .D( o3 ),
    .C( ck ),
    .Clr( rst ),
    .Q( o4 )
  );
  assign o[0] = o0;
  assign o[1] = o1;
  assign o[2] = o2;
  assign o[3] = o3;
  assign o[4] = o4;
  assign s0 = ~ ((o2 ^ o4) ^ o2);
  assign s2 = ((o3 ^ o4) ^ o0);
  assign s1 = (~ (o2 ^ o1) ^ (o0 & (~ (o4 | o3) & ~ o2)));
endmodule
