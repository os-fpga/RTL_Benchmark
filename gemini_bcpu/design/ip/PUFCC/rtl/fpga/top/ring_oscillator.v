module ring_oscillator
#(
parameter       RING_NUM = 5
)(
input       en,
output      ro_out
    );
    
(*DONT_TOUCH = "true" *) wire    [RING_NUM-1:0]        roWire;
assign  roWire[RING_NUM-1:1] = ~roWire[RING_NUM-2:0];
assign  roWire[0] = ~(en & roWire[RING_NUM-1]);
assign  ro_out = roWire[RING_NUM-1];
endmodule
