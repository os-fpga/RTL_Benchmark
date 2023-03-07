// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcdmac300_config.vh"
`include "atcdmac300_const.vh"

module atcdmac300_arbiter (
                            	  ch_request,
                            	  ch_level,
                            	  current_channel,
                            	  granted_channel
);

input	[7:0]	ch_request;
input	[7:0]	ch_level;
input	[2:0]	current_channel;

output 	[2:0]	granted_channel;
wire	[2:0]	granted_channel;
reg	[2:0]	s0;
reg	[2:0]	s1;
wire	[7:0]	s2;
wire	[7:0]	s3;
wire		s4;

assign	s4 = |s3;
assign	s3 = ch_request & ch_level;
assign	s2 = ch_request & ~ch_level;
assign	granted_channel = s4 ? s1 : s0;


always @(*) begin
	case(current_channel)
		3'h1: begin
			if (s2[2]) s0 = 3'h2;
			else if (s2[3]) s0 = 3'h3;
			else if (s2[4]) s0 = 3'h4;
			else if (s2[5]) s0 = 3'h5;
			else if (s2[6]) s0 = 3'h6;
			else if (s2[7]) s0 = 3'h7;
			else if (s2[0]) s0 = 3'h0;
			else s0 = 3'h1;
		end
		3'h2: begin
			if (s2[3]) s0 = 3'h3;
			else if (s2[4]) s0 = 3'h4;
			else if (s2[5]) s0 = 3'h5;
			else if (s2[6]) s0 = 3'h6;
			else if (s2[7]) s0 = 3'h7;
			else if (s2[0]) s0 = 3'h0;
			else if (s2[1]) s0 = 3'h1;
			else s0 = 3'h2;
		end
		3'h3: begin
			if (s2[4]) s0 = 3'h4;
			else if (s2[5]) s0 = 3'h5;
			else if (s2[6]) s0 = 3'h6;
			else if (s2[7]) s0 = 3'h7;
			else if (s2[0]) s0 = 3'h0;
			else if (s2[1]) s0 = 3'h1;
			else if (s2[2]) s0 = 3'h2;
			else s0 = 3'h3;
		end
		3'h4: begin
			if (s2[5]) s0 = 3'h5;
			else if (s2[6]) s0 = 3'h6;
			else if (s2[7]) s0 = 3'h7;
			else if (s2[0]) s0 = 3'h0;
			else if (s2[1]) s0 = 3'h1;
			else if (s2[2]) s0 = 3'h2;
			else if (s2[3]) s0 = 3'h3;
			else s0 = 3'h4;
		end
		3'h5: begin
			if (s2[6]) s0 = 3'h6;
			else if (s2[7]) s0 = 3'h7;
			else if (s2[0]) s0 = 3'h0;
			else if (s2[1]) s0 = 3'h1;
			else if (s2[2]) s0 = 3'h2;
			else if (s2[3]) s0 = 3'h3;
			else if (s2[4]) s0 = 3'h4;
			else s0 = 3'h5;
		end
		3'h6: begin
			if (s2[7]) s0 = 3'h7;
			else if (s2[0]) s0 = 3'h0;
			else if (s2[1]) s0 = 3'h1;
			else if (s2[2]) s0 = 3'h2;
			else if (s2[3]) s0 = 3'h3;
			else if (s2[4]) s0 = 3'h4;
			else if (s2[5]) s0 = 3'h5;
			else s0 = 3'h6;
		end
		3'h7: begin
			if (s2[0]) s0 = 3'h0;
			else if (s2[1]) s0 = 3'h1;
			else if (s2[2]) s0 = 3'h2;
			else if (s2[3]) s0 = 3'h3;
			else if (s2[4]) s0 = 3'h4;
			else if (s2[5]) s0 = 3'h5;
			else if (s2[6]) s0 = 3'h6;
			else s0 = 3'h7;
		end
		default: begin
			if (s2[1]) s0 = 3'h1;
			else if (s2[2]) s0 = 3'h2;
			else if (s2[3]) s0 = 3'h3;
			else if (s2[4]) s0 = 3'h4;
			else if (s2[5]) s0 = 3'h5;
			else if (s2[6]) s0 = 3'h6;
			else if (s2[7]) s0 = 3'h7;
			else s0 = 3'h0;
		end
	endcase
end
always @(*) begin
	case(current_channel)
		3'h1: begin
			if (s3[2]) s1 = 3'h2;
			else if (s3[3]) s1 = 3'h3;
			else if (s3[4]) s1 = 3'h4;
			else if (s3[5]) s1 = 3'h5;
			else if (s3[6]) s1 = 3'h6;
			else if (s3[7]) s1 = 3'h7;
			else if (s3[0]) s1 = 3'h0;
			else s1 = 3'h1;
		end
		3'h2: begin
			if (s3[3]) s1 = 3'h3;
			else if (s3[4]) s1 = 3'h4;
			else if (s3[5]) s1 = 3'h5;
			else if (s3[6]) s1 = 3'h6;
			else if (s3[7]) s1 = 3'h7;
			else if (s3[0]) s1 = 3'h0;
			else if (s3[1]) s1 = 3'h1;
			else s1 = 3'h2;
		end
		3'h3: begin
			if (s3[4]) s1 = 3'h4;
			else if (s3[5]) s1 = 3'h5;
			else if (s3[6]) s1 = 3'h6;
			else if (s3[7]) s1 = 3'h7;
			else if (s3[0]) s1 = 3'h0;
			else if (s3[1]) s1 = 3'h1;
			else if (s3[2]) s1 = 3'h2;
			else s1 = 3'h3;
		end
		3'h4: begin
			if (s3[5]) s1 = 3'h5;
			else if (s3[6]) s1 = 3'h6;
			else if (s3[7]) s1 = 3'h7;
			else if (s3[0]) s1 = 3'h0;
			else if (s3[1]) s1 = 3'h1;
			else if (s3[2]) s1 = 3'h2;
			else if (s3[3]) s1 = 3'h3;
			else s1 = 3'h4;
		end
		3'h5: begin
			if (s3[6]) s1 = 3'h6;
			else if (s3[7]) s1 = 3'h7;
			else if (s3[0]) s1 = 3'h0;
			else if (s3[1]) s1 = 3'h1;
			else if (s3[2]) s1 = 3'h2;
			else if (s3[3]) s1 = 3'h3;
			else if (s3[4]) s1 = 3'h4;
			else s1 = 3'h5;
		end
		3'h6: begin
			if (s3[7]) s1 = 3'h7;
			else if (s3[0]) s1 = 3'h0;
			else if (s3[1]) s1 = 3'h1;
			else if (s3[2]) s1 = 3'h2;
			else if (s3[3]) s1 = 3'h3;
			else if (s3[4]) s1 = 3'h4;
			else if (s3[5]) s1 = 3'h5;
			else s1 = 3'h6;
		end
		3'h7: begin
			if (s3[0]) s1 = 3'h0;
			else if (s3[1]) s1 = 3'h1;
			else if (s3[2]) s1 = 3'h2;
			else if (s3[3]) s1 = 3'h3;
			else if (s3[4]) s1 = 3'h4;
			else if (s3[5]) s1 = 3'h5;
			else if (s3[6]) s1 = 3'h6;
			else s1 = 3'h7;
		end
		default: begin
			if (s3[1]) s1 = 3'h1;
			else if (s3[2]) s1 = 3'h2;
			else if (s3[3]) s1 = 3'h3;
			else if (s3[4]) s1 = 3'h4;
			else if (s3[5]) s1 = 3'h5;
			else if (s3[6]) s1 = 3'h6;
			else if (s3[7]) s1 = 3'h7;
			else s1 = 3'h0;
		end
	endcase
end

endmodule
