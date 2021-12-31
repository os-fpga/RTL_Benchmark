`timescale 1ns / 1ns
module top (
	    // APB BUS connetions
 	    input 	  PCLK, rstn,
         // pragma attribute PCLK pad ck_buff
	    input 	  PSEL, PWRITE, PENABLE,
	    input [6:0]   PADDR,
	    input [31:0]  PWDATA,
	    output 	  PREADY,
	    output [31:0] PRDATA,
	    //gpio Signals
	    //output [41:0] gpio_o, gpio_oe,
	    //input [41:0]  gpio_i,
		//interrupt signal
		output 	  intr_0,
	    // MU 1 RAM connections
	    //output [1:0]  oper1_rmode, oper1_wmode,
	    output 	  oper1_wdsel, oper1_we, oper1_rclk, oper1_wclk,
	    output [11:0] oper1_waddr, oper1_raddr,
	    output [31:0] oper1_wdata,
	    input [31:0]  oper1_rdata, coef1_rdata,
	    //output [1:0]  coef1_rmode, coef1_wmode,
	    output 	  coef1_wdsel, coef1_we, coef1_rclk, coef1_wclk,
	    output [11:0] coef1_raddr, coef1_waddr,
	    output [31:0] coef1_wdata,
	    // MU 2 RAM connections
	    //output [1:0]  oper2_rmode, oper2_wmode,
	    output 	  oper2_wdsel, oper2_we, oper2_rclk, oper2_wclk,
	    output [11:0] oper2_waddr, oper2_raddr,
	    output [31:0] oper2_wdata,
	    input [31:0]  oper2_rdata, coef2_rdata,
	    //output [1:0]  coef2_rmode, coef2_wmode,
	    output 	  coef2_wdsel, coef2_we, coef2_rclk, coef2_wclk,
	    output [11:0] coef2_raddr, coef2_waddr,
	    output [31:0] coef2_wdata,
	    // MU Multiplier Connections
	    input [31:0]  mult1_in, mult2_in,
	    output [31:0] mult1_oper,mult1_coef,
	    output [31:0] mult2_oper,mult2_coef,
	    output [5:0]  m1_outsel, m2_outsel,
	    //output 	  m1_tc, m2_tc,
	    //output [1:0]  m1_oper_sel, m1_coef_sel, 
	    //output [1:0]  m2_oper_sel, m2_coef_sel,
	    output 	  m2_clk, m1_clk, m2_clken, m1_clken,
	    output 	  m2_osel, m2_csel, m1_osel, m1_csel,
	    output [1:0]  m2_math_mode, m1_math_mode,
	    output 	  m2_sat, m2_clr, m2_rnd, m1_sat, m1_clr, m1_rnd,
	    // TCDM connections
	    //output [19:0] tcdm_addr_p0,tcdm_addr_p1,
      output [19:0] tcdm_addr_p1,
	    output [19:0] tcdm_addr_p2,tcdm_addr_p3,
	    //output [31:0] tcdm_wdata_p0,tcdm_wdata_p1,
	    //output [31:0] tcdm_wdata_p2,tcdm_wdata_p3,
      output [31:0] tcdm_wdata_p2,
	    //output [3:0]  tcdm_be_p0,tcdm_be_p1,tcdm_be_p2,tcdm_be_p3,
	    output 	  tcdm_req_p0,tcdm_req_p1,tcdm_req_p2,tcdm_req_p3,
	    //input [31:0]  tcdm_rdata_p0,tcdm_rdata_p1,
      input [31:0]  tcdm_rdata_p1,
	    input [31:0]  tcdm_rdata_p2,tcdm_rdata_p3,
	    input 	  tcdm_valid_p0,tcdm_valid_p1,
	    input 	  tcdm_valid_p2,tcdm_valid_p3,
	    output 	  tcdm_wen_p0,tcdm_wen_p1,tcdm_wen_p2,tcdm_wen_p3, 
	    input 	  tcdm_gnt_p0,tcdm_gnt_p1,
	    input 	  tcdm_gnt_p2,tcdm_gnt_p3
	    
	    
	     );

   
   //reg [3:0] 		  counter;
   
   wire [5:0] 		  outsel;
   wire [11:0] 		  filter2d_raddr, filterdw_raddr, pixel2d_raddr;
   wire [11:0] 		  filter2d_waddr, pixel2d_waddr, bias_waddr, bias_raddr;
   wire 		  filter2d_wen1,filter2d_wen2,pixel2d_wen, bias_wen;
   
   wire 		  mac_clr, mac_clken;
   wire 		  start2d, done2d;
   
   wire [8:0] 		  width,height,channels,filters;
   wire [15:0] 		  total_pixels;
   
   wire 		  filter_write;
   wire [19:0] 		  waddr1,waddr2,raddr;  // 
   wire [19:0] 		  filter_base, pixel_base, bias_base, result_base;
   
   wire [31:0] 		  wdata1,wdata2, filter2d_wdata, pixel2d_wdata, bias_wdata;
   
   
   wire 		  ctl_pwen,ctl_fwen,ctl_bwen,ctl_incontrol;
   wire [19:0] 		  ctl_pfwaddr;
   wire [31:0] 		  ctl_pfwdata;
   
   wire [19:0] 		  tcdm1_addr, tcdm2_addr;
   wire [31:0] 		  tcdm0_wdata, tcdm1_wdata, tcdm2_wdata, tcdm3_wdata;
   wire 		  tcdm0_wen,tcdm1_wen,tcdm2_wen,tcdm3_wen;
   wire 		  tcdm0_req,tcdm1_req,tcdm2_req,tcdm3_req;
   
   wire [3:0] 		  tcdm0_be,tcdm1_be,tcdm2_be,tcdm3_be;
   wire [15:0] 		  conv2d_debug;
   wire [7:0] 		  debug_mux;
   wire [1:0] 		  math_mode;
   reg [1:0] 		  i_math_mode;
   reg 			  i_mac_clr, i_mac_clken;
   reg [5:0] 		  i_outsel;
   wire [15:0] 		  quant;
   wire [2:0] 		  shift;
   
   wire 		  csel,sat;
   
   wire 		  conv_done_intr;
   wire [31:0] 		  m1_coef,m2_coef;
   wire r_sda, sda, r_scl, scl;
   //reg 	sda_o, sda_oe, scl_o, scl_oe;
   
   
   //assign r_sda = gpio_i[3];
   //assign r_scl = gpio_i[4];
   
   
   assign mult1_coef = /*csel ? coef1_rdata : */ m1_coef;
   assign mult2_coef = /*csel ? coef2_rdata :*/ m2_coef;

   assign intr_0 = conv_done_intr;   

   
   //assign tcdm_addr_p0 = 20'b0; // pragma attribute tcdm_addr_p0 pad out_buff
   assign tcdm_addr_p1 = tcdm1_addr; // pragma attribute tcdm_addr_p1 pad out_buff
   assign tcdm_addr_p2 = tcdm2_addr; // pragma attribute tcdm_addr_p2 pad out_buff

   
   //assign tcdm_wdata_p0 = 32'b0; // pragma attribute tcdm_wdata_p0 pad out_buff
   //assign tcdm_wdata_p1 = 32'b0; // pragma attribute tcdm_wdata_p1 pad out_buff
   assign tcdm_wdata_p2 = tcdm2_wdata;
   //assign tcdm_wdata_p3 = 32'b0; // pragma attribute tcdm_wdata_p3 pad out_buff
   
   
   //assign tcdm_be_p0 = 4'b1111; // pragma attribute tcdm_be_p0 pad out_buff
   //assign tcdm_be_p1 = 4'b1111; // pragma attribute tcdm_be_p1 pad out_buff
   //assign tcdm_be_p2 = 4'b1111; // pragma attribute tcdm_be_p2 pad out_buff
   //assign tcdm_be_p3 = 4'b1111; // pragma attribute tcdm_be_p3 pad out_buff


   assign tcdm_wen_p0 = 1'b1;// pragma attribute tcdm_wen_p0 pad out_buff
   assign tcdm_wen_p1 = tcdm1_wen;
   assign tcdm_wen_p2 = tcdm2_wen;


   assign tcdm_req_p0 = 1'b0; // pragma attribute tcdm_req_p0 pad out_buff
   assign tcdm_req_p1 = tcdm1_req;
   assign tcdm_req_p2 = tcdm2_req;


   
   assign #1 oper1_waddr = ctl_incontrol ? ctl_pfwaddr[11:0] : pixel2d_waddr;
   // pragma attribute oper1_waddr pad out_buff
   assign #1 coef1_waddr = ctl_incontrol ? ctl_pfwaddr[12:1] : filter2d_waddr ;
   // pragma attribute coef1_waddr pad out_buff   
   assign #1 coef2_waddr = ctl_incontrol ? ctl_pfwaddr[12:1] : filter2d_waddr;
      // pragma attribute coef2_waddr pad out_buff
   assign #1 oper1_wdata = ctl_incontrol ? PWDATA: pixel2d_wdata;
   assign #1 coef1_wdata = ctl_incontrol ? PWDATA : filter2d_wdata;
   assign #1 coef2_wdata = ctl_incontrol ? PWDATA : filter2d_wdata;
   assign #1 oper1_we = ctl_incontrol ? ctl_pwen : 
			pixel2d_wen ;
   assign #1 coef1_we = ctl_incontrol ? ctl_fwen & ~ctl_pfwaddr[2]: 
			filter2d_wen1;
   assign #1 coef2_we = ctl_incontrol ? ctl_fwen & ctl_pfwaddr[2]:
			filter2d_wen2 ;

   assign #1 oper2_we = ctl_incontrol ? ctl_bwen : bias_wen; 
   
   assign #1 oper2_waddr = ctl_incontrol?  ctl_pfwaddr[11:0] : bias_waddr;
   assign #1 oper2_raddr = ctl_incontrol ? ctl_pfwaddr[11:0] : bias_raddr;
   
   assign #1 oper2_wdata = ctl_incontrol ? PWDATA : bias_wdata;

   
   assign #1 oper1_raddr = ctl_incontrol ?  ctl_pfwaddr[11:0] : pixel2d_raddr;
   
   assign #1 coef1_raddr = ctl_incontrol ? ctl_pfwaddr[12:1] : filter2d_raddr;
   assign #1 coef2_raddr = ctl_incontrol ? ctl_pfwaddr[12:1] : filter2d_raddr;
      
/* 
   always@(posedge PCLK or negedge rstn) begin
      if (rstn == 0) begin
	 scl_o <= 1;
      	 scl_oe <= 1;
      	 sda_o <= 1;
      	 sda_oe <= 1;
	     counter <= 4'b0;
	 end
	
        else begin
	   sda_o <= sda;
	   sda_oe <= (sda & ~sda_o) || (~sda);
	   scl_o <= scl;
	   scl_oe <= (scl & ~scl_o) || (~scl);
	   counter <= counter + 1;
      end
      
   end */
   
   assign m2_math_mode = math_mode;
   
   // pragma attribute m2_math_mode pad out_buff
   assign m1_math_mode = math_mode;
   
   // pragma attribute m1_math_mode pad out_buff
   assign m2_sat = sat; // pragma attribute m2_sat pad out_buff
   assign m1_sat = sat; // pragma attribute m1_sat pad out_buff
   assign m2_clr = mac_clr; // pragma attribute m2_clr pad out_buff
   assign m1_clr = mac_clr; // pragma attribute m1_clr pad out_buff
   assign m2_rnd = 1'b0; // pragma attribute m2_rnd pad out_buff
   assign m1_rnd = 1'b0; // pragma attribute m1_rnd pad out_buff
   assign m2_clk = PCLK;   // pragma attribute m2_clk pad out_buff
   assign m2_clken = mac_clken; // pragma attribute m2_clken pad out_buff
   assign m1_clk = PCLK;   // pragma attribute m1_clk pad out_buff
   assign m1_clken = mac_clken; // pragma attribute m1_clken pad out_buff

   assign m2_osel = 1'b0;  // pragma attribute m2_osel pad out_buff
   assign m2_csel = csel;
//1'b0; // pragma attribute m2_csel pad out_buff
   
   assign m1_osel = 1'b0;  // pragma attribute m1_osel pad out_buff
   assign m1_csel = csel;
//1'b0; //pragma attribute m1_csel pad out_buff
   
   //assign m1_tc = 1;
   //assign m2_tc = 1;
   //assign m2_oper_sel = 0; // operand data from Fabric
   //assign m1_oper_sel = 0; // operand data from Fabric
   //assign m2_coef_sel = 3; // Dynamic coefficient selection
   //assign m1_coef_sel = 3; // Dynamic coefficient selection

   assign m2_outsel = outsel; // pragma attribute m2_outsel pad out_buff
   assign m1_outsel = outsel; // pragma attribute m1_outsel pad out_buff
   
   //assign oper1_rmode = 2'b00; // pragma attribute oper1_rmode pad out_buff
   //assign oper1_wmode = 2'b00; // pragma attribute oper1_wmode pad out_buff
   assign oper1_wdsel = outsel[0];     // pragma attribute oper1_wdsel pad out_buff

   assign oper1_rclk = PCLK;
   assign oper1_wclk = PCLK;

   //assign coef1_rmode = 2'b00; // pragma attribute coef1_rmode pad out_buff
   //assign coef1_wmode = 2'b00; // pragma attribute coef1_wmode pad out_buff
   assign coef1_wdsel = outsel[0];     // pragma attribute coef1_wdsel pad out_buff
   assign coef1_rclk = PCLK;   
   assign coef1_wclk = PCLK;

   //assign oper2_rmode = 2'b00; // pragma attribute oper2_rmode pad out_buff
   //assign oper2_wmode = 2'b00; // pragma attribute oper2_wmode pad out_buff
   assign oper2_wdsel = outsel[0];     // pragma attribute oper2_wdsel pad out_buff
   assign  oper2_rclk = PCLK;
   assign oper2_wclk = PCLK;

   //assign coef2_rmode = 2'b00; // pragma attribute coef2_rmode pad out_buff
   //assign coef2_wmode = 2'b00; // pragma attribute coef2_wmode pad out_buff
   assign coef2_wdsel = outsel[0]; // pragma attribute coef2_wdsel pad out_buff
   assign coef2_rclk = PCLK;   
   assign coef2_wclk = PCLK;
   
      
   CONTROL u_ctl(
		 .rstn(rstn), .PCLK(PCLK), .PSEL(PSEL), .PWRITE(PWRITE),
		 .PENABLE(PENABLE), .PADDR(PADDR), .PWDATA(PWDATA),
		 .PREADY(PREADY), .PRDATA(PRDATA), .start2d(start2d),
		 .width(width), .height(height), .channels(channels),
		 .total_pixels(total_pixels),
		 .filter_base(filter_base),.pixel_base(pixel_base),
		 .bias_base(bias_base),.result_base(result_base),
		 .filters(filters), .ctl_pwen(ctl_pwen),.ctl_bwen(ctl_bwen),
		 .ctl_fwen(ctl_fwen),.ctl_pfwaddr(ctl_pfwaddr),
		 .ctl_pfwdata(ctl_pfwdata),.ctl_incontrol(ctl_incontrol),
		 .debug_mux(debug_mux),.conv_done_intr(conv_done_intr),
		 .oper1_rdata(oper1_rdata), .oper2_rdata(oper2_rdata),
		 .coef1_rdata(coef1_rdata), .coef2_rdata(coef2_rdata),
		 .quant(quant), .shift(shift),
		 .sda(sda), .scl(scl), .r_sda(1'b1), .r_scl(1'b1),
		 .done2d(done2d)
		 );

   conv2d # (.RAM_DEPTH(8192))
   u_conv2d (
	   .clk(PCLK),.rstn(rstn), .start2d(start2d),
	   .done2d(done2d), .width(width), .height(height),
	   .channels(channels), .filters(filters),
	   .ext_filter_base(filter_base),.ext_pixel_base(pixel_base),
	   .ext_bias_base(bias_base),.ext_result_base(result_base),
	   .csel(csel),.sat(sat),.math_mode(math_mode),
	   .outsel(outsel), .mac_clr(mac_clr),.mac_clken(mac_clken),
	   .pixel_wen(pixel2d_wen), .filter1_wen(filter2d_wen1),
	   .filter2_wen(filter2d_wen2),
	   .total_pixels(total_pixels),
	   .pixel_raddr(pixel2d_raddr), .filter_raddr(filter2d_raddr),
	   .pixel_waddr(pixel2d_waddr), .filter_waddr(filter2d_waddr),
	   .pixel_wdata(pixel2d_wdata),. filter_wdata(filter2d_wdata),
	   .pixel_rdata(oper1_rdata),
	     .coef2_rdata(coef2_rdata),.coef1_rdata(coef1_rdata),
	   .mac0_din(mult1_in[31:24]),.mac1_din(mult1_in[23:16]),
	   .mac2_din(mult1_in[15:8]),.mac3_din(mult1_in[7:0]),
	   .mac4_din(mult2_in[31:24]),.mac5_din(mult2_in[23:16]),
	   .mac6_din(mult2_in[15:8]),.mac7_din(mult2_in[7:0]),
	   .tcdm2_wdata({tcdm2_wdata[7:0],tcdm2_wdata[15:8],tcdm2_wdata[23:16],tcdm2_wdata[31:24]}),
//	   .tcdm2_wdata(tcdm2_wdata),
	   .tcdm1_valid(tcdm_valid_p1),
	   .tcdm1_req(tcdm1_req), .tcdm1_gnt(tcdm_gnt_p1),
//	   .tcdm1_rdata(tcdm_rdata_p1),
	   .tcdm1_rdata({tcdm_rdata_p1[7:0],tcdm_rdata_p1[15:8],tcdm_rdata_p1[23:16],tcdm_rdata_p1[31:24]}),
	   .tcdm1_addr(tcdm1_addr),
	   .tcdm1_wen(tcdm1_wen),
	   .tcdm2_valid(tcdm_valid_p2),
	   .tcdm2_req(tcdm2_req), .tcdm2_gnt(tcdm_gnt_p2),
//         .tcdm2_rdata(tcdm_rdata_p2),
	   .tcdm2_rdata({tcdm_rdata_p2[7:0],tcdm_rdata_p2[15:8],tcdm_rdata_p2[23:16],tcdm_rdata_p2[31:24]}), 	     
	   .tcdm2_addr(tcdm2_addr),
	   .tcdm2_wen(tcdm2_wen),
	   .mult1_oper(mult1_oper), .mult2_oper(mult2_oper), .bias_wdata(bias_wdata),
	   .bias_raddr(bias_raddr), .bias_rdata(oper2_rdata),.bias_waddr(bias_waddr),
	   .bias_wen(bias_wen), .tcdm3_req(tcdm_req_p3), .tcdm3_valid(tcdm_valid_p3),
	   .tcdm3_wen(tcdm_wen_p3), .tcdm3_addr(tcdm_addr_p3), 
	   .tcdm3_rdata(tcdm_rdata_p3),
//	   .tcdm3_rdata({tcdm_rdata_p3[7:0],tcdm_rdata_p3[15:8],tcdm_rdata_p3[23:16],tcdm_rdata_p3[31:24]}),	     
	   .tcdm3_gnt(tcdm_gnt_p3),
	    .mult1_coef(m1_coef),.mult2_coef(m2_coef),
	     .quant(quant), .shift(shift),
	     .debug(conv2d_debug)
);

//`define logic_analyzer
//`ifdef logic_analyzer
  // reg [15:0] set0, set1, set2, set3;
  // wire [11:0] m2_ctl, m1_ctl;
   
  // assign m2_ctl = {m2_osel,m2_math_mode[1:0],
	//	    m2_rnd,m2_sat,m2_clr,m2_outsel[5:0]};
  // assign m1_ctl = {m1_osel,m1_math_mode[1:0],
	//	    m1_rnd,m1_sat,m1_clr,m1_outsel[5:0]};
   
  // always @ (posedge PCLK) begin
  //    set3[0] <=start2d;
  //    set3[1] <= mac_clken;
  //    set3[2] <= m2_csel;
  //    set3[14:3] <= debug_mux[7] ? m1_ctl : m2_ctl;
  //    
  //    set0[0] <= start2d;//PSEL;
  //    set0[1] <= mac_clken; //PWRITE;
  //    set0[2] <= math_mode[0]; // PREADY
  //    set0[14:3] <= debug_mux[7] ?  
/* debug 7 == 1 */  //debug_mux[6] ? mult1_oper[27:16] : mult1_oper[11:0] :
/* debug 7 == 0 */  //debug_mux[6] ? mult2_oper[27:16] : mult2_oper[11:0];
      
			      
      //set1[1] <= start2d;
      //set1[1] <= mac_clken;
      //set1[2] <= outsel[4];
      //set1[14:3] <= debug_mux[7] ?  
/* debug 7 == 1 */  //debug_mux[6] ? mult1_coef[27:16] : mult1_coef[11:0] :
/* debug 7 == 0 */  //debug_mux[6] ? mult2_coef[27:16] : mult2_coef[11:0];
//conv2d_debug[11:0];
      


      //set2[0] <= start2d;
      //set2[1] <= coef1_we;
      //set2[2] <= coef2_we;
      
      //set2[14:3] <= debug_mux[7] ? 
/* debug 7 == 1 */  //debug_mux[6] ? mult1_in[31:20] : mult1_in[15:4] :
/* debug 7 == 0 */  //debug_mux[6] ? mult2_in[31:20] : mult2_in[15:4];
//tcdm2_wdata[31:20];


   //end // always @ (posedge PCLK)

   //assign gpio_o[19:16] = counter;
   //assign gpio_o[23:20] = counter;
   //assign gpio_o[27:24] = counter;
   //assign gpio_o[31:28] = counter;
   //assign gpio_o[35] = counter[3];
   //assign gpio_o[32] = counter[3];
   //assign gpio_o[39:36] = counter;
   //assign gpio_o[41:40] = counter[1:0];
   //pragma attribute gpio_o pad out_buff   
   //assign gpio_oe[32:4] = 33'h0000fff; // pragma attribute gpio_oe pad out_buff
   //assign gpio_oe[1:0] = 3;
   
   //assign gpio_oe[41:33] = 7'h0;

   //assign gpio_oe[3] = sda_oe;
   //assign gpio_o[3] = sda;
   //assign gpio_oe[4] = scl_oe;
   //assign gpio_o[4] = scl;
   
   
   //assign gpio_o[14:0] = debug_mux[1] ? 
/* debug 3,2 */       //debug_mux[0] ? set3[14:0] : set2[14:0] : 
/* debug 1 */       	// debug_mux[0] ? set1[14:0] : 
/* debug 0 */    	 //set0[14:0];
   //assign gpio_o[15] = PCLK;
//`else // !`ifdef logic_analyzer

   //assign gpio_o[41:16] = 0;// pragma attribute gpio_o pad out_buff
   //assign gpio_o[15] = PCLK;
   //assign gpio_o[14:5] = conv2d_debug[11:2];
   //assign gpio_o[4] = scl_o;
   //assign gpio_o[3] = sda_o;
   //assign gpio_o[2] = sda_oe; //tcdm2_req;
   //assign gpio_o[1] = sda; // m1_clr;
   //assign gpio_o[0] = start2d;

   //assign gpio_oe[41:16] = 26'h3ffffff;// pragma attribute gpio_oe pad out_buff
   //assign gpio_oe[15:5] = 11'b11111111111;
   //assign gpio_oe[4] = scl_oe;
   //assign gpio_oe[3] = sda_oe;
   //assign gpio_oe[2:0] = 3'b111;

//`endif // !`ifdef logic_analyzer
   

endmodule // tfl

