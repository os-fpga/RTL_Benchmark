//Wrapper Design

`timescale 1ns / 1ns
module wrapper_conv2d (
 	       input 		 clk, rstn, start2d,
	       output 		 done2d,
	       input [8:0] 	 width,height,channels,filters,
		   input [19:0]  ext_base_temp,
		   input [1:0] 	 select_ext_base_temp,
	       output 		 csel,sat,
	       output [1:0]  math_mode,
	       output [5:0]  outsel, 
	       output 		 mac_clr, mac_clken,
	       output 		 pixel_wen, filter1_wen,filter2_wen,
	       output 		 bias_wen,
	       input [15:0]  total_pixels,
		   output [11:0] bias_raddr, bias_waddr,
	       
		   output reg [11:0] 	temp_addr,
		   input [1:0] 			select_pixel_filter_temp,
		   output [31:0] 		mux_data_32,
		   input [2:0] 			sel_mux_data_32,
		   input [31:0] 		rdata_temp,
		   input [1:0] 			select_rdata_temp,
		   input [7:0] 			mac_temp_din,
		   input [2:0] 			select_mac_temp_din,
		   output reg [19:0] 	tcdm_temp_addr,
		   input [31:0] 	 	tcdm_temp_rdata,
		   output reg 			tcdm_temp_req, tcdm_temp_wen,
	       input 		 		tcdm1_gnt, tcdm1_valid,
		   input 		 		tcdm2_gnt, tcdm2_valid,
	       input 		 		tcdm3_gnt, tcdm3_valid,
	       input [15:0] 	 	quant,
	       input [2:0] 			shift,
	       output [15:0] 	 	debug
	       );
	reg [19:0] ext_filter_base;
	reg [19:0] ext_pixel_base;
	reg [19:0] ext_bias_base;
	reg [19:0] ext_result_base;
	reg [31:0] pixel_rdata;
	reg [31:0] bias_rdata;
	reg [31:0] coef2_rdata;
	reg [31:0] coef1_rdata;
	reg [7:0] mac0_din, mac1_din, mac2_din, mac3_din, mac4_din, mac5_din, mac6_din, mac7_din;
	reg [31:0] tcdm1_rdata, tcdm2_rdata, tcdm3_rdata;
 
	wire tcdm1_req, tcdm1_wen, tcdm2_req, tcdm2_wen, tcdm3_req, tcdm3_wen;
	wire [19:0] tcdm1_addr, tcdm2_addr, tcdm3_addr;
	wire [11:0] filter_raddr;
	wire [11:0] pixel_raddr;
	wire [11:0] filter_waddr;
	wire [11:0] pixel_waddr;
	wire [31:0] tcdm2_wdata;
	wire [31:0] bias_wdata;
	wire [31:0] pixel_wdata, filter_wdata;
	wire [31:0] mult1_oper, mult2_oper, mult1_coef, mult2_coef;
	always @(posedge clk) begin
		case (select_ext_base_temp)
			2'd0:
			ext_filter_base = ext_base_temp;
			2'd1:
			ext_pixel_base = ext_base_temp;
			2'd2:
			ext_bias_base = ext_base_temp;
			2'd3:
			ext_result_base = ext_base_temp;
		endcase

		case (select_rdata_temp)
			2'd0:
				pixel_rdata = rdata_temp;
			2'd1:
				bias_rdata = rdata_temp;
			2'd2:
				coef2_rdata = rdata_temp;
				
			2'd3:
				coef1_rdata = rdata_temp;
		endcase

		case (select_mac_temp_din)
			3'd0:
				mac0_din = mac_temp_din;
			3'd1:
				mac1_din = mac_temp_din;
			3'd2:
				mac2_din = mac_temp_din;
			3'd3:
				mac3_din = mac_temp_din;
			3'd4:
				mac4_din = mac_temp_din;
			3'd5:
				mac5_din = mac_temp_din;
			3'd6:
				mac6_din = mac_temp_din;
			3'd7:
				mac7_din = mac_temp_din;

		endcase

		case (select_pixel_filter_temp)
			2'd0:
				temp_addr = filter_raddr;
			2'd1:
				temp_addr = filter_waddr;
			2'd2:
				temp_addr = pixel_raddr;
			2'd3:
				temp_addr = pixel_waddr;
		endcase
	end
    always @(posedge clk) begin
		if (tcdm1_gnt && tcdm1_valid) begin
			 tcdm1_rdata <= tcdm_temp_rdata;
			 tcdm_temp_req <= tcdm1_req;
			 tcdm_temp_wen <= tcdm1_wen;
			 tcdm_temp_addr <= tcdm1_addr;
			end
		else if (tcdm2_gnt && tcdm2_valid) begin
			tcdm2_rdata <= tcdm_temp_rdata;
			tcdm_temp_req <= tcdm2_req;
			tcdm_temp_wen <= tcdm2_wen;
			tcdm_temp_addr <= tcdm2_addr;
			end
		else begin
			tcdm3_rdata <= tcdm_temp_rdata;	
			tcdm_temp_req <= tcdm3_req;
			tcdm_temp_wen <= tcdm3_wen;
			tcdm_temp_addr <= tcdm3_addr;	
			end
	end
   
conv2d	(clk, rstn, start2d,
	    	done2d,
	    	width,height,channels,filters,
	    	ext_filter_base, ext_pixel_base, 
	    	ext_bias_base, ext_result_base,
	 		csel,sat,
	    	math_mode,
	    	outsel, 
	    	mac_clr, mac_clken,
	    	pixel_wen, filter1_wen,filter2_wen,
	    	bias_wen,
	    	total_pixels,
	    	bias_raddr, bias_waddr,
	    	pixel_raddr, filter_waddr,
	    	filter_raddr, pixel_waddr,
	    	pixel_wdata, filter_wdata, bias_wdata,
	    	pixel_rdata,bias_rdata,
	    	coef2_rdata,coef1_rdata,
	    	mac0_din, mac1_din, mac2_din, mac3_din,
	    	mac4_din, mac5_din, mac6_din, mac7_din,
	    	tcdm2_wdata,
	    	tcdm1_addr, tcdm2_addr, tcdm3_addr,
	    	tcdm1_rdata, tcdm2_rdata, tcdm3_rdata,
	    	tcdm1_req, tcdm1_wen,
	    	tcdm1_gnt, tcdm1_valid,
	    	tcdm2_req, tcdm2_wen,
	    	tcdm2_gnt, tcdm2_valid,
	    	tcdm3_req, tcdm3_wen,
	    	tcdm3_gnt, tcdm3_valid,
	    	mult1_oper, mult2_oper,
	    	mult1_coef, mult2_coef,
	    	quant,
	    	shift,
	    	debug
	       );
		   mux_8x1 (.in0(tcdm2_wdata),. in1(bias_wdata),. in2(pixel_wdata),. in3(filter_wdata),. in4(mult1_oper),. in5(mult2_oper),. in6(mult1_coef),. in7(mult2_coef),.sel(sel_mux_data_32),.out(mux_data_32));
endmodule
