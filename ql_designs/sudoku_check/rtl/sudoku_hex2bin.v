// $Header:   /pvcs/designs/power_sanity_designs/source/sudoku_check_wrapper/sudoku_hex2bin.v__   1.0   30 Mar 2006 08:53:32   rtai  $

module sudoku_hex2bin (
	hex,
	bin);

input [9*9*4-1:0]  hex;
output [9*9*9-1:0] bin;

generate
	genvar i;
	for (i=0; i < 9*9; i=i+1)
	begin : HEX2BIN
		hex2bin h2b(.hex(hex[i*4+4-1:i*4]),
					.out(bin[i*9+9-1:i*9]));
	end
endgenerate

endmodule


module hex2bin(
	input [3:0]hex,
	output [9-1:0]out);

integer bin;

always @(hex)
begin
	case (hex)
		4'h 1   : bin = 9'b 000000001;
		4'h 2   : bin = 9'b 000000010;
		4'h 3   : bin = 9'b 000000100;
		4'h 4   : bin = 9'b 000001000;
		4'h 5   : bin = 9'b 000010000;
		4'h 6   : bin = 9'b 000100000;
		4'h 7   : bin = 9'b 001000000;
		4'h 8   : bin = 9'b 010000000;
		4'h 9   : bin = 9'b 100000000;
		default : bin = 9'b 000000000;
	endcase
end

assign out = bin[9-1:0];

endmodule
