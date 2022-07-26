module CONTROL(
	       input 	     PCLK, rstn,
	       input 	     PSEL, PWRITE, PENABLE,
	       input [6:0]   PADDR,
	       input [31:0]  PWDATA,
	       input 	     r_sda, r_scl,
	       output 	     PREADY,
	       output [31:0] PRDATA,
	       output [8:0]  width,height,channels,filters,
	       output 	     ctl_pwen,ctl_fwen,ctl_bwen,ctl_incontrol,
	       output [19:0] ctl_pfwaddr,
	       output [31:0] ctl_pfwdata,
	       output [15:0] total_pixels,
	       output [19:0] filter_base, pixel_base,
	       output [19:0] bias_base, result_base,
	       output [7:0]  debug_mux,
	       output 	     start2d,
	       output 	     conv_done_intr,
	       output [15:0] quant,
	       output [2:0]  shift,
	       input [31:0]  oper1_rdata, oper2_rdata, coef1_rdata, coef2_rdata,
	       output 	     sda,scl,
	       input 	     done2d
	       );
   reg [8:0] 		     i_width, i_height, i_channels, i_filters;
   reg [31:0] 		     ctl;
   reg [31:0] 		     i_dataout;
   reg [2:0] 		     fsm_ctl;
   reg 			     i_ready;
   reg 			     i_ctl_pwen,i_ctl_fwen,i_ctl_bwen;
   reg [19:0] 		     i_ctl_pfwaddr;
   reg [31:0] 		     i_ctl_pfwdata;
   reg [19:0] 		     i_addr;
   reg [15:0] 		     i_total;
   reg [19:0] 		     i_filter_base, i_pixel_base;
   reg [19:0] 		     i_bias_base, i_result_base;
   reg [23:0] 		     counter;
   reg 			     start2d_last_value;
   reg [7:0] 		     i_debug_mux;
   reg 			     i_intr_en,i_intr_sts;
   reg [15:0] 		     i_quant;
   reg [2:0] 		     i_shift;
   reg 			     i_sda, i_scl;
 		     
   
   assign conv_done_intr = i_intr_en & i_intr_sts;
   assign filter_base = i_filter_base;
   assign pixel_base = i_pixel_base;
   assign bias_base = i_bias_base;
   assign result_base = i_result_base;
   assign total_pixels = i_total;
   assign start2d = ctl[0];
   assign PRDATA = i_dataout;
   assign PREADY = i_ready;
   assign filters = i_filters;
   assign channels = i_channels;
   assign width = i_width;
   assign height = i_height;
   assign ctl_pfwaddr = i_ctl_pfwaddr;
   assign ctl_pfwdata = i_ctl_pfwdata;
   assign ctl_pwen = i_ctl_pwen; 
   assign ctl_fwen = i_ctl_fwen;
   assign ctl_bwen = i_ctl_bwen;
   assign ctl_incontrol = ctl[1];
   assign debug_mux = i_debug_mux;
   assign quant = i_quant;
   assign shift = i_shift;
   assign sda = i_sda;
   assign scl = i_scl;
   
   parameter fsm_IDLE 	= 0;
   parameter fsm_WRITE 	= 1;
   parameter fsm_READ 	= 2;
   parameter fsm_WAIT 	= 3;
   
   always@(posedge PCLK or negedge rstn) begin : CONTROL
      if (rstn == 1'b0) begin
	 i_ready <= 0;
	 ctl <= 32'h0;
	 i_width <= 9'h0;
	 i_height <= 9'h0;
	 i_channels <= 9'h0;
	 i_filters <= 9'h0;
	 i_dataout <= 32'h0;
	 i_filter_base <= 20'h0;
	 i_pixel_base <= 20'h0;
	 i_bias_base <= 20'h0;
	 i_result_base <= 20'h0;
	 i_total  <= 16'h0;
	 counter <= 24'h0;
	 start2d_last_value <= 1'b0;
	 i_debug_mux <= 8'h1;
	 i_ctl_pfwdata <= 32'h0;
	 i_addr <= 20'h0;
	 i_ctl_pfwaddr <= 20'h0;
	 i_ctl_fwen <= 1'b0;
	 i_ctl_pwen <= 1'b0;
	 i_ctl_bwen <= 1'b0;
	 i_intr_en <= 1'b0;
	 i_intr_sts <= 1'b0;
	 i_quant <= 16'h4000;
	 i_shift <= 3'h2;
	 i_sda <= 1;
	 i_scl <= 1;
	 fsm_ctl <= fsm_IDLE;
      end
      else begin
	 if (done2d ==1) begin
	    ctl[0] <= 1'b0;  // clear start2d
	    i_intr_sts <= 1'b1;
	 end
	 
	 start2d_last_value <= start2d;
	 if ((start2d_last_value == 0) && (start2d == 1)) begin
	    counter <= 24'b0;
	 end
	 else begin
	    counter <= counter + start2d;
	 end
	 
	 i_ctl_pfwdata <= 32'h0;
	 i_ctl_pfwaddr <= 20'h0;
	 i_ctl_fwen <= 1'b0;
	 i_ctl_pwen <= 1'b0;
	 i_ctl_bwen <= 1'b0;
	 i_ctl_pfwaddr <= i_addr;
	 
	 case (fsm_ctl)
	   fsm_IDLE: begin
	      if ((PENABLE == 1) & (PWRITE == 1)) begin
		 fsm_ctl <= fsm_WRITE;
		 i_ready <= 1;
	      end
	      if ((PSEL == 1) & (PWRITE == 0)) begin
		 fsm_ctl <= fsm_READ;
	      end
	   end // case: fsm_IDLE
	   fsm_WAIT: begin
	      fsm_ctl <= fsm_IDLE;
	      i_ready <= 0;
	   end
	   fsm_WRITE: begin
	      i_ready <= 0;
	      fsm_ctl <= fsm_IDLE;
	      case (PADDR)
		7'h0: ctl <= PWDATA;  // 0x0
		7'h1: i_width <= PWDATA[8:0]; // 0x4
		7'h2: i_height <= PWDATA[8:0]; // 0x8
		7'h3: i_channels <= PWDATA[8:0]; // 0xC
		7'h4: i_filters <= PWDATA[8:0]; // 0x10
		7'h5: i_filter_base <= PWDATA[19:0]; // 0x14
		7'h6: i_pixel_base <= PWDATA[19:0]; // 0x18
		7'h7: i_bias_base <= PWDATA[19:0]; // 0x1c
		7'h8: i_result_base <= PWDATA[19:0]; // 0x20
		7'h9: i_total <= PWDATA; //0x24
		7'ha: i_intr_en <= PWDATA[0]; //0x28
		7'hb: i_intr_sts <= PWDATA[0]; //0x2C
		7'hc: i_addr <= PWDATA[19:0]; //0x30
		7'hd: begin  //0x34
		   i_ctl_pfwdata <= PWDATA;
		   i_addr <= i_addr + 4;
		   i_ctl_pwen <= 1;
		end
		7'he: begin //0x38 
		   i_ctl_pfwdata <= PWDATA;
		   i_addr <= i_addr + 4;
		   i_ctl_fwen <= 1;
		end
		7'hf: begin //0x3c 
		   i_ctl_pfwdata <= PWDATA;
		   i_addr <= i_addr + 4;
		   i_ctl_bwen <= 1;
		end
		7'h10: begin // 0x40  debug mux
		   i_debug_mux <= PWDATA[7:0];
		end
		7'h12: begin //0x48  Quantize Value
		   i_quant <= PWDATA[15:0];
		   i_shift <= PWDATA[18:16];
		end
		7'h13: begin // 0x4c scl,sda
		   i_scl <= PWDATA[1];
		   i_sda <= PWDATA[0];
		end
	      endcase // case (address)
	   end // case: fsm_WRITE
	   fsm_READ: begin
	      i_ready <= 1;
	      case (PADDR)
		7'h00: i_dataout <= {31'b0,ctl};  //0x0
		7'h01: i_dataout <= {22'h0,i_width};//0x4
		7'h02: i_dataout <= {23'h0,i_height};//0x8
		7'h03: i_dataout <= {23'h0,i_channels};//0xc
		7'h04: i_dataout <= {23'h0,i_filters};//0x10
		7'h05: i_dataout <= {12'h0,i_filter_base};//0x14
		7'h06: i_dataout <= {12'h0,i_pixel_base};//0x18
		7'h07: i_dataout <= {12'h0,i_bias_base};//0x1c
		7'h08: i_dataout <= {12'h0,i_result_base};//0x20
		7'h09: i_dataout <= {16'h0,i_total};//0x24
		7'h0a: i_dataout <= {31'h0,i_intr_en};//0x28
		7'h0b: i_dataout <= {31'h0,i_intr_sts};//0x2c
		7'h0c: i_dataout <= i_addr;
		7'h0d: begin
		   i_dataout <= oper1_rdata;
		   i_addr <= i_addr + 4;
		end
		7'h0e: begin
		   i_dataout <= i_addr[2] ? coef2_rdata : coef1_rdata;
		   i_addr <= i_addr + 4;
		end
		7'h0f: begin
		   i_dataout <= oper2_rdata;
		   i_addr <= i_addr + 4;
		end
		7'h10: i_dataout <= {24'h0,i_debug_mux}; //0x40
		7'h11: i_dataout <= {8'h0,counter};//0x44
		7'h12: i_dataout <= {13'b0,i_shift,i_quant};
		7'h13: i_dataout <= {26'b0,i_scl,i_sda,2'b00,r_scl, r_sda};
		
	      endcase // case (address)
	      fsm_ctl <= fsm_WAIT;
	   end // case: fsm_READ
	 endcase // case (ctrl_fsm)      
      end // else: !if(rstn == 1'b0)
   end // block: CONTROL
endmodule // CONTROL
