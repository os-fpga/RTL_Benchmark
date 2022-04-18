module CONTROL(
	       input 	     PCLK, rstn,
	       input   PWDATA,
	       output 	     sda
	       );
   reg       fsm_ctl;
   reg 	     i_sda;
 		     
   assign sda = i_sda;
   
   parameter fsm_IDLE 	= 0;
   parameter fsm_WRITE 	= 1;
   
   always@(posedge PCLK or negedge rstn) begin : CONTROL
      if (rstn == 1'b0) begin
	 i_sda <= 1;
	 fsm_ctl <= fsm_IDLE;
      end
      else begin
	 case (fsm_ctl) // synopsys full_case parallel_case
	   fsm_IDLE: begin
	      fsm_ctl <= fsm_WRITE;
	   end
	   fsm_WRITE: begin
	      fsm_ctl <= fsm_IDLE;
	      i_sda <= PWDATA;
	   end
	 endcase
      end 
   end 
endmodule // CONTROL
