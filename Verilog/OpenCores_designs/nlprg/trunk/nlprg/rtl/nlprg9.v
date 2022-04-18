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

module nlprg9 (
  input ck,
  input rst,
  output [8:0] o
);
  wire o0;
  wire o1;
  wire o2;
  wire o3;
  wire o4;
  wire o5;
  wire o6;
  wire o7;
  wire o8;
  wire s0;
  wire s1;
  wire s2;
  wire s3;
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
    .D( s3 ),
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
  DIG_D_FF_AS_1bit #(
    .Default(0)
  )
  DIG_D_FF_AS_1bit_i5 (
    .Set( 1'b0 ),
    .D( o4 ),
    .C( ck ),
    .Clr( rst ),
    .Q( o5 )
  );
  DIG_D_FF_AS_1bit #(
    .Default(0)
  )
  DIG_D_FF_AS_1bit_i6 (
    .Set( 1'b0 ),
    .D( o5 ),
    .C( ck ),
    .Clr( rst ),
    .Q( o6 )
  );
  DIG_D_FF_AS_1bit #(
    .Default(0)
  )
  DIG_D_FF_AS_1bit_i7 (
    .Set( 1'b0 ),
    .D( o6 ),
    .C( ck ),
    .Clr( rst ),
    .Q( o7 )
  );
  DIG_D_FF_AS_1bit #(
    .Default(0)
  )
  DIG_D_FF_AS_1bit_i8 (
    .Set( 1'b0 ),
    .D( o7 ),
    .C( ck ),
    .Clr( rst ),
    .Q( o8 )
  );
  assign o[0] = o0;
  assign o[1] = o1;
  assign o[2] = o2;
  assign o[3] = o3;
  assign o[4] = o4;
  assign o[5] = o5;
  assign o[6] = o6;
  assign o[7] = o7;
  assign o[8] = o8;
  assign s0 = ~ ((o7 ^ o8) ^ o3);
  assign s2 = ((o4 ^ o6) ^ o0);
  assign s1 = ((o3 ^ o5) ^ o1);
  assign s3 = (~ (o8 ^ o2) ^ ((o1 & o0) & ((~ (o8 | o7) & ~ (o6 | o5)) & ~ (o4 | o3))));
endmodule
