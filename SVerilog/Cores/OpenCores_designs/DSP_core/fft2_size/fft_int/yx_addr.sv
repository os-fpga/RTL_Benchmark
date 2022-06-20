`ifndef _yx_addr_
`define _yx_addr_

module yx_addr #(WIDTH = 9, POW = 2)(
	input [WIDTH-1:0] cnt,
	output [WIDTH-1:0] yx_cnt
);

generate
	if (POW < 1)
		begin
			assign yx_cnt = cnt;
		end
	else if (POW == 1)
		begin
			assign yx_cnt = {cnt[WIDTH-1:POW], !cnt[0]};
		end
	else if (POW == WIDTH)
		begin
			assign yx_cnt = {!cnt[0], cnt[POW-1:1]};
		end
	else
		begin
			assign yx_cnt = {cnt[WIDTH-1:POW], !cnt[0], cnt[POW-1:1]};
		end
endgenerate

endmodule :yx_addr

`endif
