module pufs_osc_wp#(
   parameter   OSC_TYPE    = 0,
   parameter   PRBS_SIZE   = 32,
   parameter   PRBS_POLY   = 32'h8020_0003,
   parameter   PRBS_INIT   = 32'heffe_feef
   )(
   output [3:0]ro_out,
   input       clk   ,
   input       rst_n 
   );
   
   generate
      if(OSC_TYPE == 2)begin:LFSR
         reg   [PRBS_SIZE     -1:0] prbs;
         wire  [PRBS_SIZE     -1:0] prbs_fsel;
         wire  [PRBS_SIZE     -1:0] prbs_next;

         assign   ro_out = prbs[3:0];
         assign   prbs_fsel = (prbs[0])? PRBS_POLY : {PRBS_SIZE{1'b0}};
         assign   prbs_next = {1'b0,prbs[PRBS_SIZE-1:1]}^prbs_fsel;

         always@(posedge clk or negedge rst_n) begin
            if(~rst_n) prbs <= PRBS_INIT;
            else       prbs <= prbs_next;
         end
      end
      else if(OSC_TYPE == 1)begin:TGL
         reg tgl;
         assign ro_out = {3'b0, tgl};
         always@(posedge clk or negedge rst_n)begin
            if(!rst_n)  tgl <= 1'b0;
            else        tgl <= ~tgl;
         end 
      end  
      else begin:OSC
         ring_oscillator#(.RING_NUM(5 ))   I_RO5 ( .en(rst_n), .ro_out(ro_out[0]) );
         ring_oscillator#(.RING_NUM(7 ))   I_RO7 ( .en(rst_n), .ro_out(ro_out[1]) );
         ring_oscillator#(.RING_NUM(11))   I_RO11( .en(rst_n), .ro_out(ro_out[2]) );
         ring_oscillator#(.RING_NUM(17))   I_RO17( .en(rst_n), .ro_out(ro_out[3]) );
      end 
   endgenerate 

endmodule
