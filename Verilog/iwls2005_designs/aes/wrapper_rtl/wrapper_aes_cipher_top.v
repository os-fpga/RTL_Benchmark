//wrapper Design

`include "timescale.v"

module wrapper_aes_cipher_top(clk, rst, ld, done, key_text_in_temp, sel_key_text_in_temp, text_out );
input		clk, rst;
input		ld;
output		done;
input	[127:0]	key_text_in_temp;
input	sel_key_text_in_temp;
output	[127:0]	text_out;

////////////////////////////////////////////////////////////////////

reg	[127:0]	key;
reg	[127:0]	text_in;

//

always @(posedge clk)
    begin
        case (sel_key_text_in_temp)
			1'd0:
                key = key_text_in_temp;
			1'd1:
                text_in = key_text_in_temp;
		endcase
    end
aes_cipher_top (.clk(clk),. rst(rst),. ld(ld),. done(done),. key(key),. text_in(text_in),. text_out(text_out) );
endmodule


