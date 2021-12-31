//replace the really one from PP3

module r256x18_256x18(WA,RA,WD,WEN,WD_SEL,RD_SEL,WClk,RClk,RD);


input [7:0] WA;
input [7:0] RA;
input [17:0] WD;
input [1:0] WEN;
input WD_SEL,RD_SEL,WClk,RClk;
output  [17:0] RD;

reg [17:0] RAM16bit;

wire WEN01;
wire V_clk;

assign V_clk = WClk | RClk;


assign WEN01 = WEN[0] | WEN[1];

assign RD = ((RD_SEL == 1'b1 )) ? RAM16bit : 16'b0;


always @(posedge V_clk)

begin

	if ((WD_SEL == 1'b1 ) && (WEN01 == 1'b1 ))
	
	RAM16bit <= {WA,RA,WD_SEL,RD_SEL} ^ WD;
	

end

endmodule
