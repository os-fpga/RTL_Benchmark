// $Header:   /pvcs/designs/power_sanity_designs/source/sudoku_check_wrapper/sudoku_bin2hex.v__   1.0   30 Mar 2006 08:53:06   rtai  $

module sudoku_bin2hex (
	bin,
	hex);

input [9*9*9-1:0]  bin;
output [9*9*4-1:0] hex;

generate
	genvar i;
	for (i=0; i < 9*9; i=i+1)
	begin : BIN2HEX
		bin2hex b2h(.bin(bin[i*9+9-1:i*9]),
					.out(hex[i*4+4-1:i*4]));
	end
endgenerate

endmodule


module bin2hex (
	input [9-1:0]bin,
	output [3:0]out);

integer hex;

always @(bin)
begin
	case (bin)
		9'b 000000001 : hex = 4'h 1;
		9'b 000000010 : hex = 4'h 2;
		9'b 000000100 : hex = 4'h 3;
		9'b 000001000 : hex = 4'h 4;
		9'b 000010000 : hex = 4'h 5;
		9'b 000100000 : hex = 4'h 6;
		9'b 001000000 : hex = 4'h 7;
		9'b 010000000 : hex = 4'h 8;
		9'b 100000000 : hex = 4'h 9;
		default       : hex = 4'h 0;
	endcase
end

assign out = hex[3:0];

endmodule
