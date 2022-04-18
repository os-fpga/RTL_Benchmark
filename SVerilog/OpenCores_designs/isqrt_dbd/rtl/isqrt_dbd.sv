`ifndef _isqrt_dbd_
`define _isqrt_dbd_

// Digit-by-digit method
`define M(W, I) (W'('h1)<<(W - 2*(I + 1)))

module isqrt_dbd #(parameter DATA_WIDTH = 32) (clk, data, q);
	localparam WIDTH = (DATA_WIDTH & 1) ? DATA_WIDTH + 1 : DATA_WIDTH;

	input clk;
	input [DATA_WIDTH-1:0] data;
	output [WIDTH/2-1:0] q;

	reg [WIDTH-1:0] data_reg;
	reg [WIDTH/2 - 1:0][31:0] x, y;
	logic [WIDTH/2 - 2:0][31:0] b;
	
	always_ff @(posedge clk)
		data_reg <= data;
	
	always_ff @(posedge clk) begin
		if (data_reg >= `M(WIDTH, 0))
			begin
				x[0] <= data_reg - `M(WIDTH, 0);
				y[0] <= `M(WIDTH, 0);
			end
		else
			begin
				x[0] <= data_reg;
				y[0] <= '0;
			end
	end
	
	genvar i;
	generate for (i = 1; i < WIDTH/2; i++)
		begin :gen
			always_comb
				b[i-1] = y[i-1] | `M(WIDTH, i);
		
			always_ff @(posedge clk)
				if (x[i-1] >= b[i-1])
					begin
						x[i] <= x[i-1] - b[i-1];
						y[i] <= (y[i-1] >> 1'b1) | `M(WIDTH, i);
					end
				else
					begin
						x[i] <= x[i-1];
						y[i] <= y[i-1] >> 1'b1;
					end
		end
	endgenerate
	
	assign q = y[WIDTH/2 - 1][WIDTH/2 - 1:0];
	
endmodule

//unsigned x, y;
//unsigned sqrt(){
//  y = 0;
//  unsigned m = 1 << 30;    
//  while( m ){
//    unsigned b =  y | m;
//    y >>= 1;
//    if( x >= b ){
//        x -= b;
//        y |= m;
//    }            
//    m >>= 2;
//  }    
//}

// https://en.wikipedia.org/wiki/Methods_of_computing_square_roots
//short isqrt(short num) {
//    short res = 0;
//    short bit = 1 << 14; // The second-to-top bit is set: 1 << 30 for 32 bits
// 
//    // "bit" starts at the highest power of four <= the argument.
//    while (bit > num)
//        bit >>= 2;
//        
//    while (bit != 0) {
//        if (num >= res + bit) {
//            num -= res + bit;
//            res = (res >> 1) + bit;
//        }
//        else
//            res >>= 1;
//        bit >>= 2;
//    }
//    return res;
//}

`endif
