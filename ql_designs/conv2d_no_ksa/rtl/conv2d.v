`timescale 1ns / 1ns
module conv2d (
 	       input 		 clk, rstn, start2d,
	       output 		 done2d,
	       input [8:0] 	 width,height,channels,filters,
	       input [19:0] 	 ext_filter_base, ext_pixel_base, 
	       input [19:0] 	 ext_bias_base, ext_result_base,
	       output 		 csel,sat,
	       output [1:0] 	 math_mode,
	       output [5:0] 	 outsel, 
	       output 		 mac_clr, mac_clken,
	       output 		 pixel_wen, filter1_wen,filter2_wen,
	       output 		 bias_wen,
	       input [15:0] 	 total_pixels,
	       output [11:0] 	 bias_raddr, bias_waddr,
	       
	       output [11:0] 	 pixel_raddr, filter_waddr,
	       output [11:0] 	 filter_raddr, pixel_waddr,
	       output [31:0] 	 pixel_wdata, filter_wdata, bias_wdata,
	       input [31:0] 	 pixel_rdata,bias_rdata,
	       input [31:0] 	 coef2_rdata,coef1_rdata,
	       input [7:0] 	 mac0_din, mac1_din, mac2_din, mac3_din,
	       input [7:0] 	 mac4_din, mac5_din, mac6_din, mac7_din,
	       output [31:0] 	 tcdm2_wdata,
	       output [19:0] 	 tcdm1_addr, tcdm2_addr, tcdm3_addr,
	       input [31:0] 	 tcdm1_rdata, tcdm2_rdata, tcdm3_rdata,
	       output 		 tcdm1_req, tcdm1_wen,
	       input 		 tcdm1_gnt, tcdm1_valid,
	       output 		 tcdm2_req, tcdm2_wen,
	       input 		 tcdm2_gnt, tcdm2_valid,
	       output 		 tcdm3_req, tcdm3_wen,
	       input 		 tcdm3_gnt, tcdm3_valid,
	       output reg [31:0] mult1_oper, mult2_oper,
	       output [31:0] 	 mult1_coef, mult2_coef,
	       input [15:0] 	 quant,
	       input [2:0] shift,
	       output [15:0] 	 debug
	       );
   
   
   
   parameter RAM_DEPTH = 8192;
      
   reg [4:0] 			 fsm_conv2d;  

   reg [11:0] 			 i_filter_waddr, i_pixel_waddr;
   reg [11:0] 			 i_filter_raddr, i_pixel_raddr;
   reg 			     	 i_filter1_wen,i_filter2_wen,i_pixel_wen;
   reg [23:0] 			 acc0,acc1,acc2,acc3;
   reg [23:0] 			 acc4,acc5,acc6,acc7;
   reg [23:0] 			 bias0,bias1,bias2,bias3;
   reg [23:0] 			 bias4,bias5,bias6,bias7;
   reg [5:0] 			 i_outsel;
   reg 			     	 i_csel, i_mac_clr, i_sat;
   reg [1:0] 			 pixel_select;
   reg [1:0] 			 fract_select;
 			 
   reg [1:0] 			 i_math_mode;
   
   
   reg 			     	 write2, i_done2d;
   reg [15:0] 			 total_pixels_done;
   reg [8:0] 			 channels_done, filters_done, filters_complete;
   reg [8:0] 			 filters_loaded ;
   reg [8:0] 			 total_filters_done;
   
   reg 			     	 i_mac_clken;
   reg [8:0] 			 channels_loaded;
   reg 			     	 pixel_start, load_more_pixels;
   reg 			     	 load_more_filters,filter_reload;
   
   reg 			     	 filter_start, running;
   reg [31:0] 			 wdata2;
   reg 				 last_start2d;
   reg [31:0] 			 i_mult1_coef, i_mult2_coef;

   reg [7:0] 			 sat04, sat15, sat26, sat37;


   always@(posedge clk or negedge rstn ) begin
      if (rstn == 0) begin
	 sat04 <= 0;
	 sat15 <= 0;
	 sat26 <= 0;
	 sat37 <= 0;
      end
      else begin
      sat04 <= mac0_din[7] ? 8'h0 : |mac0_din[6:4] ? 8'hff : {mac0_din[3:0],mac1_din[7:4]};
      sat15 <= mac2_din[7] ? 8'h0 : |mac2_din[6:4] ? 8'hff : {mac2_din[3:0],mac3_din[7:4]};
      sat26 <= mac4_din[7] ? 8'h0 : |mac4_din[6:4] ? 8'hff : {mac4_din[3:0],mac5_din[7:4]};
      sat37 <= mac6_din[7] ? 8'h0 : |mac6_din[6:4] ? 8'hff : {mac6_din[3:0],mac7_din[7:4]};
      end // else: !if(rstn == 0)
   end
   
   
   assign filter_raddr = running ? i_filter_raddr : ~i_filter_waddr;
   assign pixel_raddr = running ? i_pixel_raddr : ~i_pixel_waddr;
   assign mac_clr = i_mac_clr;
   assign mac_clken = i_mac_clken;
   assign outsel = i_outsel;
   assign done2d = i_done2d;

   assign csel = i_csel;
   assign sat = i_sat;
   assign math_mode = i_math_mode;
   assign mult1_coef = i_mult1_coef;
   assign mult2_coef = i_mult2_coef;
   
   //always @(*) begin
   always @(fract_select or 
            pixel_select or
            shift[1:0]   or
            pixel_rdata  or
            acc0[18:1]   or
            acc1[18:1]   or
            acc4[18:1]   or
            acc5[18:1]   
            ) begin
    casez({fract_select,pixel_select})
      4'b0000     : mult1_oper <= {4{pixel_rdata[31:24]}};
      4'b0001     : mult1_oper <= {4{pixel_rdata[23:16]}};  
      4'b0010     : mult1_oper <= {4{pixel_rdata[15:8]}}; 
      4'b0011     : mult1_oper <= {4{pixel_rdata[7:0]}};
      4'b01??     : begin
        case (shift[1:0])
          1: begin 
            mult1_oper[31:16] <= acc0[16:1];
            mult1_oper[15:0] <= acc1[16:1];
          end
          2: begin
            mult1_oper[31:16] <= acc0[17:2];
            mult1_oper[15:0] <= acc1[17:2];
          end
          3: begin
            mult1_oper[31:16] <= acc0[18:3];
            mult1_oper[15:0] <= acc1[18:3];
          end
          default: mult1_oper <= 32'h0;
        endcase
        //mult1_oper[31:16] <= acc0 >> shift; //scale0;
        //mult1_oper[15:0]  <= acc1 >> shift; //scale1;
        end
      4'b10??     : begin
	     	case (shift[1:0])
          1: begin 
            mult1_oper[31:16] <= acc4[16:1];
            mult1_oper[15:0] <= acc5[16:1];
          end
          2: begin
            mult1_oper[31:16] <= acc4[17:2];
            mult1_oper[15:0] <= acc5[17:2];
          end
          3: begin
            mult1_oper[31:16] <= acc4[18:3];
            mult1_oper[15:0] <= acc5[18:3];
          end
          default: mult1_oper <= 32'h0;
        endcase
//	     mult1_oper[31:16] <= acc4 >> shift; //scale4;
//	     mult1_oper[15:0]  <= acc5 >> shift; //scale5;
        end
	    //4'b11??     : mult1_oper <= 32'h0;
      default       : mult1_oper <= 32'h0;
	  endcase
   end
   
   //always @(*) begin
   always @(fract_select or 
            pixel_select or
            shift[1:0]   or
            pixel_rdata  or
            acc2[18:1]   or
            acc3[18:1]   or
            acc6[18:1]   or
            acc7[18:1]   
            ) begin
    casez({fract_select,pixel_select})
      4'b0000     : mult2_oper <= {4{pixel_rdata[31:24]}}; 
	    4'b0001     : mult2_oper <= {4{pixel_rdata[23:16]}};  
	    4'b0010     : mult2_oper <= {4{pixel_rdata[15:8]}}; 
	    4'b0011     : mult2_oper <= {4{pixel_rdata[7:0]}}; 
	    4'b01??     : begin 
        case (shift[1:0])
          1: begin 
            mult2_oper[31:16] <= acc2[16:1];
            mult2_oper[15:0] <= acc3[16:1];
          end
          2: begin
            mult2_oper[31:16] <= acc2[17:2];
		        mult2_oper[15:0] <= acc3[17:2];
	        end
	        3: begin
            mult2_oper[31:16] <= acc2[18:3];
            mult2_oper[15:0] <= acc3[18:3];
	        end
          default: mult2_oper <= 32'h0;
        endcase
//	     mult2_oper[31:16] <= acc2 >> shift; //scale2;
//	     mult2_oper[15:0]  <= acc3 >> shift; //scale3;
      end
      4'b10??     : begin 
        case (shift[1:0])
          1: begin 
            mult2_oper[31:16] <= acc6[16:1];
            mult2_oper[15:0] <= acc7[16:1];
          end
          2: begin
            mult2_oper[31:16] <= acc6[17:2];
            mult2_oper[15:0] <= acc7[17:2];
          end
          3: begin
            mult2_oper[31:16] <= acc6[18:3];
            mult2_oper[15:0] <= acc7[18:3];
          end
          default: mult2_oper <= 32'h0;
        endcase

//	     mult2_oper[31:16] <= acc6 >> shift; //scale6;
//	     mult2_oper[15:0]  <= acc7 >> shift; //scale7;
      end
      //4'b11??     : mult2_oper <= 32'h0;
	    default       : mult2_oper <= 32'h0;
	  endcase
  end   
   
   reg [2:0] fsm_getfilters, fsm_getbias; 
   reg [3:0] fsm_writechannels;
   reg [3:0] fsm_loadacc;
   
   parameter laIDLE = 0;
   parameter laST1 = 1;
   parameter laST2 = 2;
   parameter laST3 = 3;
   parameter laST4 = 4;
   parameter laST5 = 5;
   parameter laST6 = 6;
   parameter laST7 = 7;
   parameter laST8 = 8;
   parameter laST9 = 9;
   parameter laST10 = 10;
   parameter laST11 = 11;
   parameter laST12 = 12;
   parameter laWAIT = 13;
   
   parameter gfIDLE = 0;
   parameter gfLOAD = 1;
   parameter gfDONE = 2;
   parameter gfLOADMORE = 3;
   
   parameter gbIDLE = 0;
   parameter gbLOAD = 1;
   parameter gbDONE = 2;
   
   parameter wcIDLE = 0; 
   parameter wcWAIT1 = 1;
   parameter wcWRITE1 = 2;
   parameter wcWAIT2 = 3;
   parameter wcWRITE2 = 4;
   parameter wcSTART1 = 5;
   parameter wcSTART2 = 6;
   parameter wcSTART3 = 7;
   parameter wcWAIT = 8;
   

//   reg [15:0] fract0,fract1,fract2,fract3,fract4,fract5,fract6,fract7;
   reg 	      reset_bias_address;
 	      
   
   reg [19:0] i_tcdm2_raddr,  i_tcdm2_waddr;
   reg [19:0] i1_t2_waddr, i2_t2_waddr, i3_t2_waddr;
   wire [19:0] i1_adder, i2_adder, i3_adder;
   
   reg [19:0] i_tcdm3_raddr;
   reg [19:0] result_base;
   
   reg [13:0] filter_space_left;
   reg [8:0]  filter_channels, bias_loaded;
   reg 	      i_tcdm2_rreq, i_tcdm2_wen, i_tcdm2_wreq;
   reg 	      i_tcdm3_req, i_tcdm3_wen;
   
   reg [31:0] i_filter_wdata, i_tcdm2_wdata, i_tcdm2_rdata;
   reg [31:0] i_bias_wdata, i_tcdm3_rdata;
   reg [11:0] i_bias_raddr, i_bias_waddr, bias_base_addr;
   
   reg 	      i_bias_wen;
   
   reg [12:0] filter_stride, add_stride;
   reg 	      next_buffer, load_ext_acc, copy_acc;
   

   myadder # (.WIDTH(20)) t2_1 (.a(result_base),.b({11'b0,filters_loaded}),
			    .sum(i1_adder),.cout());
   myadder # (.WIDTH(20)) t2_2 (.a(i_tcdm2_waddr),.b(20'h4),
			    .sum(i2_adder),.cout());
   myadder # (.WIDTH(20)) t2_3 (.a(i_tcdm2_waddr),.b({7'b0,add_stride}),
			    .sum(i3_adder),.cout());
   
   
   assign bias_wdata = i_bias_wdata;
   assign bias_raddr = i_bias_raddr;
   assign bias_waddr = i_bias_waddr;
   assign bias_wen = i_bias_wen;
   
   assign tcdm3_req = i_tcdm3_req;
   assign tcdm3_wen = i_tcdm3_wen;
   assign tcdm3_addr = i_tcdm3_raddr;
   
   assign filter_wdata = i_filter_wdata;
   assign tcdm2_req = i_tcdm2_rreq | i_tcdm2_wreq;
   assign tcdm2_wen = i_tcdm2_wen;
   assign tcdm2_addr = i_tcdm2_wen ? i_tcdm2_raddr : i_tcdm2_waddr;
   assign filter_waddr = i_filter_waddr;
   assign filter1_wen = i_filter1_wen;
   assign filter2_wen = i_filter2_wen;
   assign tcdm2_wdata = i_tcdm2_wdata;
   
   always@(posedge clk or negedge rstn) begin
      if (rstn == 0) begin
	 i1_t2_waddr <= 0;
	 i2_t2_waddr <= 0;
	 i3_t2_waddr <= 0;
	 filters_loaded <= 0;
	 filter_stride <= 0;
	 add_stride <= 4;
	 fsm_getfilters <= gfIDLE;
	 fsm_getbias <= gbIDLE;
	 fsm_loadacc <= laIDLE;
	 bias0 <= 0;
	 bias1 <= 0;
	 bias2 <= 0;
	 bias3 <= 0;
	 bias4 <= 0;
	 bias5 <= 0;
	 bias6 <= 0;
	 bias7 <= 0;
	 i_tcdm2_raddr <= ext_filter_base;
	 i_tcdm2_waddr <= ext_result_base;
	 result_base <=0;
	 i_tcdm2_wdata <= 0;
	 wdata2 <= 0;
	 i_tcdm3_raddr <= ext_bias_base;
	 i_bias_raddr <= 12'h00; //middle of oper2
	 i_bias_waddr <= 12'h200;
	 bias_base_addr <=12'h200;
	 bias_loaded <= 0;
	 i_tcdm2_rreq <= 0;
	 i_tcdm2_wreq <= 0;
	 i_tcdm3_req <= 0;
	 i_tcdm3_wen <= 0;
	 i_bias_wen <= 0;
	 i_bias_wdata <= 0;
	 
	 i_filter_waddr <= 0;
	 i_filter_wdata <= 0;
	 i_filter1_wen <= 0;
	 i_filter2_wen <= 0;
	 
	 filter_channels <= 0;
	 i_tcdm2_wen <= 1;
	 filter_start <= 0;
	 filter_space_left <= RAM_DEPTH; 
	 filters_complete <= 0;
	 fsm_writechannels <= wcIDLE;
	 last_start2d <= 0;
/*
	 fract0 <= 0;
	 fract1 <= 0;
	 fract2 <= 0;
	 fract3 <= 0;
	 fract4 <= 0;
	 fract5 <= 0;
	 fract6 <= 0;
	 fract7 <= 0;
	 scale0 <= 0;
	 scale1 <= 0;
	 scale2 <= 0;
	 scale3 <= 0;
	 scale4 <= 0;
	 scale5 <= 0;
	 scale6 <= 0;
	 scale7 <= 0;
*/
 	 reset_bias_address <= 0;
	 i_tcdm2_rdata <= 0;
	 i_tcdm3_rdata <= 0;
      end
      else begin
	 last_start2d <= start2d;
	 i_filter1_wen <= 0;
	 i_filter2_wen <= 0;
	 if ((start2d == 1) && (last_start2d == 0)) begin
	    i_tcdm2_waddr <= ext_result_base;
	 end
	 if (load_more_pixels) begin
	    reset_bias_address <= 1;
	 end
	 
	 case (fsm_loadacc)
	   laIDLE: begin
	      i_bias_raddr <= 12'h200; // start of bias values
	      bias_base_addr <= 12'h200;
	      
	      if (start2d == 1) begin
		 fsm_loadacc <= laWAIT;
	      end
	   end
	   laWAIT: begin
	      if (load_more_filters == 1) begin
		 bias_base_addr <= bias_base_addr + (filters_loaded << 2);
		 i_bias_raddr <= bias_base_addr + (filters_loaded << 2);
	      end
	      else if (reset_bias_address) begin
		 i_bias_raddr <= bias_base_addr;
		 reset_bias_address <= 0;
	      end
	      if (load_ext_acc) begin
		 fsm_loadacc <= laST1;
		 i_bias_raddr <= i_bias_raddr + 4;
	      end
	      else if (copy_acc) begin
		 bias0 <= acc0;
		 bias1 <= acc1;
		 bias2 <= acc2;
		 bias3 <= acc3;
		 bias4 <= acc4;
		 bias5 <= acc5;
		 bias6 <= acc6;
		 bias7 <= acc7;
	      end
	      if (done2d == 1) begin
		 fsm_loadacc <= laIDLE;
	      end
	   end
	   laST1: begin
	      i_bias_raddr <= i_bias_raddr + 4;
	      bias0 <= bias_rdata[23:0];
//	      scale0 <= bias_rdata[27:24];
	      
	      fsm_loadacc <= laST2;
	   end
	   laST2: begin
	      i_bias_raddr <= i_bias_raddr + 4;
	      bias1 <= bias_rdata[23:0];
//	      scale1 <= bias_rdata[27:24];
	      
	      fsm_loadacc <= laST3;
	   end
	   laST3: begin
	      i_bias_raddr <= i_bias_raddr + 4;
	      bias2 <= bias_rdata[23:0];
//	      scale2 <= bias_rdata[27:24];
	      
	      fsm_loadacc <= laST4;
	   end
	   laST4: begin
	      i_bias_raddr <= i_bias_raddr + 4;
	      bias3 <= bias_rdata[23:0];
//	      scale3 <= bias_rdata[27:24];
	      
	      fsm_loadacc <= laST5;
	   end
	   laST5: begin
	      i_bias_raddr <= i_bias_raddr + 4;
	      bias4 <= bias_rdata[23:0];
//	      scale4 <= bias_rdata[27:24];
	      
	      fsm_loadacc <= laST6;
	   end
	   laST6: begin
	      i_bias_raddr <= i_bias_raddr + 4;
	      bias5 <= bias_rdata[23:0];
//	      scale5 <= bias_rdata[27:24];
	      
	      fsm_loadacc <= laST7;
	   end
	   laST7: begin
	      i_bias_raddr <= i_bias_raddr + 4;
	      bias6 <= bias_rdata[23:0];
//	      scale6 <= bias_rdata[27:24];
	      
	      fsm_loadacc <= laST8;
	   end
	   laST8: begin
//	      i_bias_raddr <= i_bias_raddr + 4;
	      bias7 <= bias_rdata[23:0];
	      	      if (reset_bias_address) begin
		 i_bias_raddr <= 12'h200;
		 reset_bias_address <= 0;
	      end
	      fsm_loadacc <= laWAIT;
//	      scale7 <= bias_rdata[27:24];
//	      fsm_loadacc <= laST9;
	   end
/*
	   laST9: begin
	      i_bias_raddr <= i_bias_raddr + 4;
	      fract0 <= bias_rdata[31:16];
	      fract1 <= bias_rdata[15:0];
	      fsm_loadacc <= laST10;
	   end
	   laST10: begin
	      i_bias_raddr <= i_bias_raddr + 4;
	      fract2 <= bias_rdata[31:16];
	      fract3 <= bias_rdata[15:0];
	      fsm_loadacc <= laST11;
	   end
	   laST11: begin
	      i_bias_raddr <= i_bias_raddr + 4;
	      fract4 <= bias_rdata[31:16];
	      fract5 <= bias_rdata[15:0];
	      fsm_loadacc <= laST12;
	   end
	   laST12: begin
	      if (reset_bias_address) begin
		 i_bias_raddr <= 12'h200;
		 reset_bias_address <= 0;
	      end
	      fract6 <= bias_rdata[31:16];
	      fract7 <= bias_rdata[15:0];
	      fsm_loadacc <= laWAIT;
	   end
*/
	 endcase // case (fsm_loadacc)
	 i1_t2_waddr <= i1_adder;
	 i2_t2_waddr <= i2_adder;
	 i3_t2_waddr <= i3_adder;
	 case (fsm_writechannels)
	   wcIDLE: begin
	      result_base <= ext_result_base;
	      i_tcdm2_waddr <= result_base;
	      if (write2 == 1)
		fsm_writechannels <= wcSTART1;
	   end
	   wcWAIT: begin
	      if (load_more_filters == 1) begin
	      	 i_tcdm2_waddr <= i1_t2_waddr; // result_base + filters_loaded;
		 result_base <= i1_t2_waddr; //result_base + filters_loaded;
	      end
	      else if (load_more_pixels == 1)
		add_stride <= filter_stride + 4;
	      if (write2 == 1) begin
		 fsm_writechannels <= wcSTART1;
	      end
	 end // case: wcWAIT
	   wcSTART1:
	     fsm_writechannels <= wcSTART2;
	   
	   wcSTART2: begin
	      i_tcdm2_wdata <= {sat04,sat15,sat26,sat37};
	      fsm_writechannels <= wcSTART3;
	   end
	   
	   wcSTART3: begin
	      wdata2 <= {sat04,sat15,sat26,sat37};
	      i_tcdm2_wreq <= 1;
	      fsm_writechannels <= wcWRITE1;
	   end

	   wcWAIT1: begin
	      if (i_tcdm2_rreq == 0) begin
		 i_tcdm2_wreq <= 1;
		 fsm_writechannels <= wcWRITE1;
	      end
	   end
	   wcWRITE1: begin
	      if (tcdm2_gnt && i_tcdm2_wreq) begin
		 i_tcdm2_wreq <= 0;
		 i_tcdm2_wdata <= wdata2;
	      end
	      if (tcdm2_valid == 1) begin
		 i_tcdm2_waddr <= i2_t2_waddr; //i_tcdm2_waddr + 4;
		 if (i_tcdm2_rreq == 0) begin
		    i_tcdm2_wreq <= 1;
		    fsm_writechannels <= wcWRITE2;
		 end
		 else begin
		    i_tcdm2_wreq <= 0;
		    fsm_writechannels <= wcWAIT2;
                 end
	      end
	   end // case: wcWRITE1
	   wcWAIT2: begin
	      if (i_tcdm2_rreq == 0) begin
		 i_tcdm2_wreq <= 1;
		 fsm_writechannels <= wcWRITE2;
	      end
	   end
	   wcWRITE2: begin
	      if (tcdm2_gnt && i_tcdm2_wreq) begin
		 i_tcdm2_wreq <= 0;
	      end
	      if (tcdm2_valid == 1) begin
		 i_tcdm2_waddr <= i3_t2_waddr; //i_tcdm2_waddr + add_stride;
		 add_stride <= 4; // reset to default add
		 if (start2d == 1) 
		   fsm_writechannels <= wcWAIT;
		 else
   		   fsm_writechannels <= wcIDLE;
	      end
	   end // case: wcWRITE2
	 endcase // case (fsm_writechannels)
	 
	 
	 if (i_bias_wen) begin
	    i_bias_wen <= 0;
	    i_bias_waddr <= i_bias_waddr + 4;
	 end
	 i_tcdm3_rdata <= tcdm3_rdata;

	 case (fsm_getbias)
	   gbIDLE: begin
	      i_bias_waddr <= 11'h200;
	      filters_complete <= 0;
	      i_tcdm3_raddr <= ext_bias_base;
	      if (start2d == 1) begin
		 i_tcdm3_req <= 1;
		 i_tcdm3_wen <= 1;
		 bias_loaded <= 0;
		 fsm_getbias <= gbLOAD;
	      end
	   end
	   gbLOAD: begin
	      if ((tcdm3_gnt == 1) && (i_tcdm3_req == 1)) begin
		 i_tcdm3_req <= 0;
		 i_tcdm3_wen <= 1;
	      end
	      if (tcdm3_valid == 1) begin
		 i_bias_wdata <= i_tcdm3_rdata;	 
		 i_tcdm3_wen <= 1;	     
		 i_tcdm3_raddr <= i_tcdm3_raddr + 4;
//		 if (bias_loaded == filters+(filters>>1)) begin
 		 if (bias_loaded == filters) begin
		    fsm_getbias <= gbDONE;
		 end else begin
		    i_tcdm3_req <= 1;

		    i_bias_wen <= 1;
		    bias_loaded <= bias_loaded + 1;
		 end
	      end
	   end // case: gbLOAD
	   gbDONE: begin
	      if (done2d == 1) begin
		 bias_loaded <= 0;
		 fsm_getbias <= gbIDLE;
	      end
	   end
	 endcase // case (fsm_getbias)

	 i_tcdm2_rdata <= tcdm2_rdata; // Align data with Valid
	 
	 
	 case (fsm_getfilters)
	   gfIDLE: begin
	      i_filter_waddr <= 0;
	      filter_space_left <= RAM_DEPTH; 
	      filter_stride <= filters;
	      filters_loaded <= 0;
	      if (start2d == 1) begin
		 i_tcdm2_raddr <= ext_filter_base;
		 i_tcdm2_rreq <= 1;
		 i_tcdm2_wen <= 1;
		 filter_channels <= 0;
		 fsm_getfilters <= gfLOAD;
	      end
	   end
	   gfLOAD: begin
	      if (i_filter1_wen) begin
	      	 i_filter_waddr <= i_filter_waddr + 2; // futzing to deal with 2 coef RAMs
	      end
	      if (i_filter2_wen) begin
		 filter_space_left <= filter_space_left - 8;
		 i_filter_waddr <= i_filter_waddr + 2; // futzing to deal with 2 coef RAMs
	      end
	      if ((tcdm2_gnt == 1) && (i_tcdm2_rreq == 1)) begin
		 i_tcdm2_rreq <= 0;
		 i_tcdm2_wen <= 1;
	      end
	      if (tcdm2_valid == 1) begin // todo validate with rreq
		 i_filter_wdata <= i_tcdm2_rdata;
		 i_tcdm2_raddr <= i_tcdm2_raddr + 4;
		 i_filter1_wen <= ~i_filter_waddr[1];
		 i_filter2_wen <= i_filter_waddr[1];
		 if (i_tcdm2_raddr[2] != ext_filter_base[2]) begin
		    filter_channels <= filter_channels + 1;
		    if ((filter_channels + 1) == channels) begin
		       filter_stride <= filter_stride - 8;
		       filters_loaded <= filters_loaded + 8;
		       filters_complete <= filters_complete + 8;
		       if ( ((filters_complete + 8) < filters) && 
			    (filter_space_left >= (channels << 3))) begin
			  i_tcdm2_rreq <= 1;
			  i_tcdm2_wen <= 1;
			  filter_channels <= 0;
		       end // if ((filters_complete + 8 < filters) &&...
		       else begin
			  i_tcdm2_rreq <= 0;
			  i_tcdm2_wen <= 0;
			  filter_channels <= 0;
			  filter_start <= 1;
			  fsm_getfilters <= gfDONE;		       
		       end
		    end // if ((filter_channels + 1) == channels)
		    else begin
		       i_tcdm2_rreq <= 1;
		       i_tcdm2_wen <= 1;
		    end // else: !if((filter_channels + 1) == channels)
		 end // if (i_tcdm2_addr[2] == 1)
		 else begin
		    i_tcdm2_rreq <= 1;
		    i_tcdm2_wen <= 1;
		 end // else: !if((filter_channels + 1) == channels)
	      end // if (i_tcdm2_raddr[2] == 1)
	   end // case: gfLOAD
	   gfLOADMORE: begin
	      if (i_filter1_wen) begin
	      	 i_filter_waddr <= i_filter_waddr + 2; // futzing to deal with 2 coef RAMs
	      end
	      if (i_filter2_wen) begin
		 filter_space_left <= filter_space_left - 8;
		 i_filter_waddr <= i_filter_waddr + 2; // futzing to deal with 2 coef RAMs
	      end
	      if ((tcdm2_gnt == 1) && (i_tcdm2_rreq == 1)) begin
		 i_tcdm2_rreq <= 0;
		 i_tcdm2_wen <= 1;
	      end
	      if (tcdm2_valid == 1) begin // todo validate with rreq
		 i_filter_wdata <= i_tcdm2_rdata;
		 i_tcdm2_raddr <= i_tcdm2_raddr + 4;
		 i_filter1_wen <= ~i_filter_waddr[1];
		 i_filter2_wen <= i_filter_waddr[1];
		 if (i_tcdm2_raddr[2] != ext_filter_base[2]) begin		 
		    filter_channels <= filter_channels + 1;
		    if ((filter_channels + 1) == channels) begin
		       filters_loaded <= filters_loaded + 8;
		       filters_complete <= filters_complete + 8;
		       if ((filters_complete + 8 < filters) && 
			   (filter_space_left >= (channels << 3))) begin
			  i_tcdm2_rreq <= 1;
			  i_tcdm2_wen <= 1;
			  filter_channels <= 0;
		       end // if ((filters_complete + 8 < filters) &&...
		       else begin
			  i_tcdm2_rreq <= 0;
			  i_tcdm2_wen <= 0;
			  filter_channels <= 0;
			  filter_start <= 1;
			  fsm_getfilters <= gfDONE;		       
		       end
		    end // if ((filter_channels + 1) == channels)
		    else begin
		       i_tcdm2_rreq <= 1;
		       i_tcdm2_wen <= 1;
		    end // else: !if((filter_channels + 1) == channels)
		 end // if (i_tcdm2_addr[2] == 1)
		 else begin
		    i_tcdm2_rreq <= 1;
		    i_tcdm2_wen <= 1;
		 end // else: !if((filter_channels + 1) == channels)
	      end // if (i_tcdm2_raddr[2] == 1)
	   end // case: gfLOAD

	   gfDONE: begin
	      if (running) begin
		 filter_start <= 0;
		 i_filter_waddr <= 0; // reset write address incase we reload
	      end 
	      if ((load_more_filters) && (i_tcdm2_wreq == 0)) begin

		 filter_space_left <= RAM_DEPTH;  
		 filters_loaded <= 0;
		 filter_channels <= 0;
		 i_tcdm2_rreq <= 1;
		 i_tcdm2_wen <= 1;
		 fsm_getfilters <= gfLOADMORE;
		 if (filters_complete == filters) begin
		    filters_complete <=0;		 
		 end
	      end // if (load_more_filters)
	      if (done2d == 1) begin
		 fsm_getfilters <= gfIDLE;
	      end
	   end // case: gfDONE	   
	 endcase // case (fsm_getfilters)
      end // else: !if(rstn == 0)
   end // always@ (posedge clk or negedge rstn)
   
   
   reg [2:0] fsm_getpixels;
   reg [15:0] pixels_read;
   reg [19:0] i_tcdm1_addr;
   
   reg 	      i_tcdm1_req, i_tcdm1_wen;
   reg [31:0] i_pixel_wdata, i_tcdm1_rdata;
   
   assign pixel_wdata = i_pixel_wdata;
   assign tcdm1_req = i_tcdm1_req;
   assign tcdm1_wen = i_tcdm1_wen;
   assign tcdm1_addr = i_tcdm1_addr;
   assign pixel_waddr = i_pixel_waddr;
   assign pixel_wen = i_pixel_wen;

   wire [7:0] u2i_0,u2i_1,u2i_2,u2i_3; //tcdm1_rdata;
   assign u2i_0 = tcdm1_rdata[31:24] - 8'h80;
   assign u2i_1 = tcdm1_rdata[23:16] - 8'h80;
   assign u2i_2 = tcdm1_rdata[15:8] - 8'h80;
   assign u2i_3 = tcdm1_rdata[7:0] - 8'h80;
   
   
   parameter gpIDLE = 0;
   parameter gpLOAD = 1;   
   parameter gpDONE = 2;
   parameter gpWAIT = 3;
   
   reg [1:0]  buffers_used;
   reg 	      load_buffer;
   
   
   always@(posedge clk or negedge rstn) begin
      if (rstn == 0) begin
	 fsm_getpixels <= gpIDLE;
	 channels_loaded <= 0;
	 pixels_read <= 0;
	 i_tcdm1_addr <= ext_pixel_base;
	 i_tcdm1_wen <= 0;
	 i_tcdm1_req <= 0;
	 i_pixel_wen <=0;
	 i_pixel_waddr <=0;
	 i_pixel_wdata <=0;
	 pixel_start <= 0;
	 buffers_used <= 0;
	 load_buffer <= 0;
	 i_tcdm1_rdata <= 0;
	 
	 
      end
      else begin
	 // new getpixels
	 i_tcdm1_rdata <= {u2i_0,u2i_1,u2i_2,u2i_3}; //tcdm1_rdata;
	 if (i_pixel_wen == 1) begin
	    i_pixel_wen <= 0;
	    i_pixel_waddr <= i_pixel_waddr + 4;
	 end
	 
	 case (fsm_getpixels)
	   gpIDLE: begin
	      pixels_read <= 0;

	      i_pixel_waddr <=0;
	      load_buffer <= 0;
	      pixel_start <= 0;
	      i_tcdm1_addr <= ext_pixel_base;
	      buffers_used <= 2'b00;//  both channel buffers empty
	      if (start2d == 1) begin
		 fsm_getpixels <= gpLOAD;
		 i_tcdm1_req <= 1;
		 i_tcdm1_wen <= 1;
	      end
	   end // case: qpIDLE
	   gpLOAD: begin
	      if ((tcdm1_gnt == 1) && (i_tcdm1_req == 1)) begin
		 i_tcdm1_req <= 0;
		 i_tcdm1_wen <= 0;
	      end
	      if (tcdm1_valid == 1) begin
		 i_pixel_wdata <= i_tcdm1_rdata;
		 i_tcdm1_addr <= i_tcdm1_addr + 4;
		 i_pixel_wen <= 1;
		 channels_loaded <= channels_loaded + 4;
		 if ((channels_loaded + 4) == channels) begin
		    buffers_used[load_buffer] <= 1;
		    load_buffer <= ~load_buffer;
		    channels_loaded <= 0;
		    pixels_read <= pixels_read + 1;
		    pixel_start <= 1;
		    if ((pixels_read + 1) == total_pixels)  begin
		       fsm_getpixels <= gpDONE;
		       pixel_start <= 0;
		    end
		    else begin
		      fsm_getpixels <= gpWAIT;
		    end
		    
		 end // if ((channels_loaded + 4) == channels)
		 else begin
		    i_tcdm1_req <= 1;
		    i_tcdm1_wen <= 1;
		 end // else: !if((channels_loaded + 4) == channels)
	      end // if (tcdm1_valid == 1)
	   end // case: gpLOAD
	   gpDONE: begin
	      if (load_more_filters == 1) begin
		 fsm_getpixels <= gpIDLE;
	      end
	      if (done2d == 1) begin
		 fsm_getpixels <= gpIDLE;
	      end
	   end
	   gpWAIT: begin
	      if (load_buffer == 0) begin // last buffer
		 i_pixel_waddr <= 0;
	      end
	      if (buffers_used[load_buffer] == 0) begin
		 fsm_getpixels <= gpLOAD;
		 i_tcdm1_req <= 1;
		 i_tcdm1_wen <= 1;
	      end
	      if (load_more_pixels == 1) begin
		 buffers_used[load_buffer] <= 0;
	      end
	   end
	 endcase // case (fsm_getpixels)
      end // else: !if(rstn == 0)
   end // always@ (posedge clk or negedge rstn)
   
   parameter fsm_IDLE  = 0;
   parameter fsm_SOP   = 1;
   parameter fsm_SOP8  = 2;
   parameter fsm_SOP16 = 3;
   parameter fsm_SOP24 = 4;
   parameter fsm_DONE  = 5;
   parameter fsm_WAIT2 = 6;
   parameter fsm_NEXT  = 7;
   parameter fsm_SOP1  = 8;
      parameter fsm_FRAC1  = 9;
      parameter fsm_FRAC2  = 10;

   parameter fsm_WAIT1 = 11;
   parameter fsm_DONE2 = 12;
      parameter fsm_WAIT3 = 13;
            parameter fsm_FRAC3  = 14;
               parameter fsm_FRAC4  = 15;

   
   wire [23:0] k24acc0, k24acc1, k24acc2, k24acc3;
   wire [23:0] k24acc4, k24acc5, k24acc6, k24acc7;
   wire [15:0] k16acc0, k16acc1, k16acc2, k16acc3;
   wire [15:0] k16acc4, k16acc5, k16acc6, k16acc7;
   
   myadder # (.WIDTH(24)) k0 (.a(bias0),.b({16'b0,mac0_din}),.sum(k24acc0),.cout());
   myadder # (.WIDTH(24)) k1 (.a(bias1),.b({16'b0,mac1_din}),.sum(k24acc1),.cout());
   myadder # (.WIDTH(24)) k2 (.a(bias2),.b({16'b0,mac2_din}),.sum(k24acc2),.cout());
   myadder # (.WIDTH(24)) k3 (.a(bias3),.b({16'b0,mac3_din}),.sum(k24acc3),.cout());
   myadder # (.WIDTH(24)) k4 (.a(bias4),.b({16'b0,mac4_din}),.sum(k24acc4),.cout());
   myadder # (.WIDTH(24)) k5 (.a(bias5),.b({16'b0,mac5_din}),.sum(k24acc5),.cout());
   myadder # (.WIDTH(24)) k6 (.a(bias6),.b({16'b0,mac6_din}),.sum(k24acc6),.cout());
   myadder # (.WIDTH(24)) k7 (.a(bias7),.b({16'b0,mac7_din}),.sum(k24acc7),.cout());
   
   myadder # (.WIDTH(16)) k16_0 (.a(acc0[23:8]),.b({8'b0,mac0_din}),.sum(k16acc0),.cout());
   myadder # (.WIDTH(16)) k16_1 (.a(acc1[23:8]),.b({8'b0,mac1_din}),.sum(k16acc1),.cout());
   myadder # (.WIDTH(16)) k16_2 (.a(acc2[23:8]),.b({8'b0,mac2_din}),.sum(k16acc2),.cout());
   myadder # (.WIDTH(16)) k16_3 (.a(acc3[23:8]),.b({8'b0,mac3_din}),.sum(k16acc3),.cout());
   myadder # (.WIDTH(16)) k16_4 (.a(acc4[23:8]),.b({8'b0,mac4_din}),.sum(k16acc4),.cout());
   myadder # (.WIDTH(16)) k16_5 (.a(acc5[23:8]),.b({8'b0,mac5_din}),.sum(k16acc5),.cout());
   myadder # (.WIDTH(16)) k16_6 (.a(acc6[23:8]),.b({8'b0,mac6_din}),.sum(k16acc6),.cout());
   myadder # (.WIDTH(16)) k16_7 (.a(acc7[23:8]),.b({8'b0,mac7_din}),.sum(k16acc7),.cout());

   reg [11:0]  p1_raddr, p2_raddr;
   wire [11:0] p1_adder, p2_adder;
   myadder # (.WIDTH(12)) pk1 (.a(pixel_raddr),.b(12'h4),.sum(p1_adder),.cout());
   fadder # (.WIDTH(12)) pk2 (.a(pixel_raddr),.b({3'b111,~channels}),.sum(p2_adder),.cin(1'b1),.cout());
   always@(posedge clk or negedge rstn) begin
      if (rstn == 1'b0) begin // reset stuff
	 p1_raddr <= 0;
	 p2_raddr <=0;
	 fsm_conv2d <= fsm_IDLE;
	 i_csel <= 1; // select coef ram to drive multiplier
	 i_sat <= 1;  // no saturation
	 i_math_mode <= 2'b10; // math mode = 8-bit
	 i_mac_clr <= 1'b1;
	 i_mac_clken <= 1;
	 i_outsel <= 6'b100011;
	 i_pixel_raddr <= 11'd0;
	 i_filter_raddr <= 11'd0;
	 channels_done <= 0;
	 filters_done <=0;
	 total_filters_done <=0;
	 i_done2d <= 0;
	 running <= 0;
	 filter_reload <= 0;
	 load_more_filters <= 0;
	 load_more_pixels <= 0;
	 total_pixels_done <= 0;
	 load_ext_acc <= 0;
	 copy_acc <= 0;
	 acc0 <= 0;
	 acc1 <= 1;
	 acc2 <= 2;
	 acc3 <= 3;
	 acc4 <= 4;
	 acc5 <= 5;
	 acc6 <= 6;
	 acc7 <= 7;
	 next_buffer <= 0;
	 pixel_select <= 0;
	 fract_select <= 0;
	 write2 <= 0;
	 i_mult1_coef <= 0;
	 i_mult2_coef <= 0;
	 
      end
      else begin
	 p1_raddr <= p1_adder;
	 p2_raddr <= p2_adder;
	 i_sat <= 0;
	 copy_acc <= 0;
	 load_ext_acc <= 0;
	 write2 <= 0;
	 load_more_pixels <= 0;
	 if (start2d == 0) begin
	    total_pixels_done <= 0;

	 end // else: !if(rstn == 1'b0)
	 
	 case (fsm_conv2d)
	   fsm_FRAC1: begin
     	      i_math_mode <= 2'b01;
	      acc0[23:16] <= acc0[23:16] + {{4{mac0_din[7]}},mac0_din[7:4]};
	      acc1[23:16] <= acc1[23:16] + {{4{mac1_din[7]}},mac1_din[7:4]};
	      acc2[23:16] <= acc2[23:16] + {{4{mac2_din[7]}},mac2_din[7:4]};
	      acc3[23:16] <= acc3[23:16] + {{4{mac3_din[7]}},mac3_din[7:4]};
	      acc4[23:16] <= acc4[23:16] + {{4{mac4_din[7]}},mac4_din[7:4]};
	      acc5[23:16] <= acc5[23:16] + {{4{mac5_din[7]}},mac5_din[7:4]};
	      acc6[23:16] <= acc6[23:16] + {{4{mac6_din[7]}},mac6_din[7:4]};
	      acc7[23:16] <= acc7[23:16] + {{4{mac7_din[7]}},mac7_din[7:4]};
	      fsm_conv2d <= fsm_FRAC2;
	   end
	   fsm_FRAC2: begin
	      i_outsel <= 6'd16;
	      i_mult1_coef <= {quant,quant}; //{fract0,fract1};
	      i_mult2_coef <= {quant,quant}; //{fract2,fract3};
	      if (channels_done == channels) begin
		 if (filters_done < filters_loaded) begin
		    i_pixel_raddr <= p2_raddr;		    
//		    i_pixel_raddr <= i_pixel_raddr - (channels); // rewind pixel ram
		    fsm_conv2d <= fsm_NEXT;
		 end
		 else begin // filters done == filters loaded
		    if (total_pixels_done == total_pixels)  begin
		       total_pixels_done <= 0;
		       if  ((total_filters_done + filters_loaded) == filters) begin
			  fsm_conv2d <= fsm_DONE;
		       end
		       else begin
			  total_filters_done <= total_filters_done + filters_loaded;
			  filter_reload <= 1;
			  fsm_conv2d <= fsm_NEXT;
		       end // else: !if((total_filters_done + filters_loaded)...
		       
                    end // if (total_pixels_done == total_pixels)
		    else begin
		       if (next_buffer == 0) begin
			  i_pixel_raddr <= 0;
		       end
		       filters_done <= 0;
		       load_more_pixels <= 1;
		       next_buffer <= ~next_buffer;
		       fsm_conv2d <= fsm_NEXT;
		    end // else: !if(filters_done < filters_loaded)
		 end // else: !if(filters_done < filters_loaded)
	      end // if (channels_done == channels)
	   end // case: fsm_FRAC2
	   fsm_FRAC3: begin
	      fsm_conv2d <= fsm_FRAC4;
	   end

	   fsm_FRAC4: begin
	      fsm_conv2d <= fsm_NEXT;
	   end
	   
	   fsm_NEXT: begin
	      write2 <= 1;  // write 8 filter results via tcdm
	      i_mult1_coef <= {quant,quant}; //{fract4,fract5};
	      i_mult2_coef <= {quant,quant}; //{fract6,fract7};
	      pixel_select <= 2'b00;
	      fract_select <= 2'b10;
	      channels_done <= 0;
	      fsm_conv2d <= fsm_WAIT2;
	   end // case: fsm_NEXT
	   fsm_WAIT1:begin
	      fsm_conv2d <= fsm_WAIT2;
	      end
	   fsm_IDLE: begin
	      i_sat <= 0; //
              i_done2d <= 0;
	      next_buffer <= 1;
	      i_mac_clr <= 1'b1;
	      i_mac_clken <= 1;
	      i_pixel_raddr <= 11'd0;
	      i_filter_raddr <= 11'd0;
	      i_outsel <= 0;
	      pixel_select <= 2'b00;
	      fract_select <= 2'b11;
	      load_more_filters <= 0;

	      filter_reload <= 0;
	      if ((pixel_start == 1) && (filter_start == 1)) begin
		 //		 total_filters_done <= filters_loaded;
		 
		 running <= 1;
		 channels_done <= 0;
		 fsm_conv2d <= fsm_WAIT2;
	      end
	   end // case: fsm_IDLE
	   fsm_WAIT2: begin
	      if (filter_reload) begin
		 if ((fsm_writechannels == wcWAIT) && (write2 == 0)) begin
		    load_more_pixels <= 1;
		    load_more_filters <= 1;
		    filters_done <= 0;
		    filter_reload <= 0;
		    fsm_conv2d <= fsm_IDLE;
		 end
	      end
	      else begin
	      i_csel <= 1;
	      i_sat <= 0;
	      fract_select <= 2'b00;
	      i_filter_raddr <= i_filter_raddr + 4;
	      load_ext_acc <= 1;
	      fsm_conv2d <= fsm_SOP;
//	      i_math_mode <= 2'b10;
	      i_outsel <= 0;
	      end // else: !if(filter_reload)
	   end // case: fsm_WAIT2
	   
	   
	   fsm_SOP1: begin
	      acc0[23:16] <= acc0[23:16] + {{4{mac0_din[7]}},mac0_din[7:4]};
	      acc1[23:16] <= acc1[23:16] + {{4{mac1_din[7]}},mac1_din[7:4]};
	      acc2[23:16] <= acc2[23:16] + {{4{mac2_din[7]}},mac2_din[7:4]};
	      acc3[23:16] <= acc3[23:16] + {{4{mac3_din[7]}},mac3_din[7:4]};
	      acc4[23:16] <= acc4[23:16] + {{4{mac4_din[7]}},mac4_din[7:4]};
	      acc5[23:16] <= acc5[23:16] + {{4{mac5_din[7]}},mac5_din[7:4]};
	      acc6[23:16] <= acc6[23:16] + {{4{mac6_din[7]}},mac6_din[7:4]};
	      acc7[23:16] <= acc7[23:16] + {{4{mac7_din[7]}},mac7_din[7:4]};
	      copy_acc <= 1;
	      i_filter_raddr <= i_filter_raddr + 4;
	      fsm_conv2d <=  fsm_SOP;
	   end //
	   fsm_SOP: begin
	      case (i_math_mode)
		 2'b00: i_math_mode <= 2'b10;
		 2'b01: i_math_mode <= 2'b00;
		 2'b10: i_math_mode <= 2'b10;
		 2'b00: i_math_mode <= 2'b10;
	      endcase
	      i_mac_clr <= 0;
	      if(pixel_select == 2) begin
		 i_pixel_raddr <= p1_raddr;
//		 i_pixel_raddr <= i_pixel_raddr + 4;
	      end
	      pixel_select <= pixel_select+1;
	      //	      i_filter_raddr <= i_filter_raddr + 4;
	      if (pixel_select == 2'd3) begin
		 channels_done <= channels_done + 4;
		 if ( ((channels_done+4) == channels) || (channels_done[3:0] == 4'b1100) ) begin
		    //		    if ((channels_done+4) == channels) begin
		    //		       if ((filters_done + 8) == filters_loaded) begin
		    //			  i_filter_raddr <= 0;
		    //		       end
		    //		    end
		    
		    i_mac_clken <= 0;
		    fsm_conv2d <= fsm_SOP8;
		    i_outsel <= 6'h8;  // get the high 8-bits
		 end // if ( ((channels_done+4) == channels) || (channels_done[3:0] == 4'b1100) )
		 else begin
		    i_filter_raddr <= i_filter_raddr + 4;
		 end
	      end // if (pixel_select == 2'd3)
	      else begin
		 i_filter_raddr <= i_filter_raddr + 4;
	      end // else: !if(pixel_select == 2'd3)
	      
	   end // case: fsm_SOP
	   fsm_SOP8: begin
	      i_outsel <= 6'd12;  // Get the 4 overflow bits
	      fsm_conv2d <= fsm_SOP16;
	      if (channels_done == channels) begin
		 filters_done <= filters_done + 8;
		 if ((filters_done + 8) == filters_loaded) begin
		    i_filter_raddr<= 0;
		 end		    
	      end
	   end // case: fsm_SOP8
	   fsm_SOP16: begin
	      acc0 <= k24acc0; //acc0 + mac0_din;
	      acc1 <= k24acc1; //acc1 + mac1_din;
	      acc2 <= k24acc2; //acc2 + mac2_din;
	      acc3 <= k24acc3; //acc3 + mac3_din;
	      acc4 <= k24acc4; //acc4 + mac4_din;
	      acc5 <= k24acc5; //acc5 + mac5_din;
	      acc6 <= k24acc6; //acc6 + mac6_din;
	      acc7 <= k24acc7; //acc7 + mac7_din;
	      i_outsel <= 6'd0;
	      fsm_conv2d <= fsm_SOP24;
	      if (filters_done == filters_loaded) begin
		 total_pixels_done <= total_pixels_done+1;
	      end
	   end // case: fsm_SOP16
	   fsm_SOP24: begin
	      acc0[23:8] <= k16acc0;//acc0 + {mac0_din,8'b0};
	      acc1[23:8] <= k16acc1;//acc1 + {mac1_din,8'b0};
	      acc2[23:8] <= k16acc2;//acc2 + {mac2_din,8'b0};
	      acc3[23:8] <= k16acc3;//acc3 + {mac3_din,8'b0};
	      acc4[23:8] <= k16acc4;//acc4 + {mac4_din,8'b0};
	      acc5[23:8] <= k16acc5;//acc5 + {mac5_din,8'b0};
	      acc6[23:8] <= k16acc6;//acc6 + {mac6_din,8'b0};
	      acc7[23:8] <= k16acc7;//acc7 + {mac7_din,8'b0};
	      // Default Action
	      i_mac_clken <= 1;
	      i_mac_clr <= 1'b1;
	      // Completion of 1 pixel for 8 filters
	      if (channels_done != channels) begin
		 fsm_conv2d <= fsm_SOP1;
	      end
	      else begin
		 i_csel <= 0; //

		 fract_select <= 2'b01;
		 fsm_conv2d <= fsm_FRAC1;
	      end
	   end // case: fsm_SOP24
	   fsm_DONE: begin
	      write2 <= 1;  // write 8 filter results via tcdm
	      i_mult1_coef <= {quant,quant}; //{fract4,fract5};
	      i_mult2_coef <= {quant,quant}; //{fract6,fract7};
	      fract_select <= 2'b10;
	      total_filters_done <= 0;
	      filters_done <= 0;
	      fsm_conv2d <= fsm_DONE2;

	   end
	   fsm_DONE2: begin
	      i_done2d <= 1;

	      if (start2d == 0) begin
		 i_csel <= 1;
		 running <= 0;
		 i_math_mode <= 2'b10;
		 fsm_conv2d <= fsm_IDLE;
	      end
	   end	 
	 endcase // case (fsm_conv2d)
      end // else: !if(rstn == 1'b0)
   end // always@ posedge(clk

   assign debug[15:0] = 16'h0; //mac4_din;
   
//   assign debug[7:0] = {mac6_din[3:0],mac7_din[7:4]};
//   assign debug[11:8] = mac6_din[7:4];
//   assign   debug[12] = i_filter1_wen;
//   assign   debug[15:13] = fsm_getpixels[2:0];

endmodule // conv2d

