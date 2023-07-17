module dct(sel,y);
  input [2:0]sel;
  output reg [15:0]y; 
  wire [15:0]y0,y1,y2,y3,y4,y5,y6,y7;
  wire [7:0]p0,p1,p2,p3,p10,p11,p100,m0,m1,m2,m3,m10,m11,m100;
  wire [15:0]n0,n1,n2,n3,q0,q1,q2,q3;
  wire [7:0]x0,x1,x2,x3,x4,x5,x6,x7;

// pre declared
parameter c1=8'b11111011;
parameter c2=8'b11101100;
parameter c3=8'b11010100;
parameter c4=8'b10110101;
parameter c5=8'b10001110;
parameter c6=8'b01100001;
parameter c7=8'b00110001;

// pre declared
assign x0=8'b10110;
assign x1=8'b1001;
assign x2=8'b101;
assign x3=8'b1111;
assign x4=8'b1011;
assign x5=8'b10;
assign x6=8'b100;
assign x7=8'b10010;

//Butter Fly Stages


//stage1
bfly1 s11(x0,x7,p0,m0);
bfly1 s12(x3,x4,p1,m1);
bfly1 s13(x1,x6,p2,m2); 
bfly1 s14(x2,x5,p3,m3);
//stage2
bfly2 s21(m0,m1,c1,c7,n0,q0); 
bfly2 s22(m2,m3,c3,c5,n1,q1);
bfly2 s23(m0,m1,c5,c3,n2,q2);
bfly2 s24(m2,m3,c7,c1,n3,q3);
bfly1 s15(p0,p1,p10,m10);
bfly1 s16(p2,p3,p11,m11);
//stage3
bfly2 s31(m10,m11,c2,c6,y2,y6);
bfly1 s32(p10,p11,p100,m100);

assign y1=n0+n1;
assign y7=q0+(~q1+1);
assign y5=n2+(~q3+1);
assign y3=q2+(~n3+1);
assign y0=p100*c4;
assign y4=m100*c4;




always@(sel)
case(sel)
  0:begin y=y0; end
  1:begin y=y1; end
  2:begin y=y2; end
  3:begin y=y3; end
  4:begin y=y4; end
  5:begin y=y5; end
  6:begin y=y6; end
  7:begin y=y7; end
endcase
 endmodule

module bfly1(x,y,p,m);
  input [7:0]x,y;
  output[7:0]p,m;
  assign p=x+y;
  assign m=x+(~y+1);
  endmodule

module bfly2(x,y,cx,cy,sx,sy);
  input [7:0]x,y,cx,cy;
  output [15:0]sx,sy;
   assign sx=(x*cx)+(y*cy);
  assign sy=(x*cy)+(~(y*cx)+1);

endmodule