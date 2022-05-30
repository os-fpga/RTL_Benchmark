//author :gurenliang
//Email: gurenliang@gmail.com 
//note: if there are some errors, you are welcome to contact me. It would be the best appreciation to me.

//This module incharge of the generation of the reset signal for PHY chip
//and hold low for at least 10ms.
module InitModule(init_clk, reset, phy_reset, out_en);
	input init_clk, reset;			//init_clk should be 10KHz
	output phy_reset, out_en;
	
	reg [6:0] init_cnt=7'h0;
	reg phy_reset=1'b1;
	
	assign  out_en = (init_cnt<7'h75) ?  1'b1:1'b0;
	
	always @ (posedge init_clk or posedge reset) begin
		if(reset)
			init_cnt <= 7'h0;
		else if (init_cnt <7'h7f) begin
			init_cnt <= init_cnt+7'h1;
			case (init_cnt)
			7'h02:	phy_reset <= 1'b0;
			7'h66: phy_reset <= 1'b1;
			default:phy_reset <= phy_reset;
			endcase
		end
	end
endmodule
