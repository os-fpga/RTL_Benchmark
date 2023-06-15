// We generate a pseudo-random string of data according
// to a seed and check this against the input.
// We also generate takingData at a random
// rate according to a second seed.

`timescale 1ns / 1ns

module bist_check(/*AUTOARG*/
   // Outputs
   takingData, pass, done,
   // Inputs
   clk, reset, dataValid, data_in
   );
  parameter WIDTH = 32;		// FIFO width
  parameter DATASEED = 187;	// Must match bist_generate
   // Generate takingData RATE_NUM/RATE_DEN of the time
   parameter RATE_NUM = 1;
   parameter RATE_DEN = 3;
   parameter TESTLENGTH = 100;
   
  input clk;
  input reset;
  input dataValid;
  output  takingData;
   output pass,done;
  input [WIDTH-1:0] data_in;
   reg [39:0] 	    test_cnt;
   reg [7:0] 	    rate_cnt;
   reg 		    pass, done;

/*AUTOREG*/
// Beginning of automatic regs (for this module's undeclared outputs)
reg			takingData;
// End of automatics

  reg [WIDTH-1:0] 	checkData;
  reg 			rand;

  always @(posedge clk) begin
     if (reset) begin
	checkData <= DATASEED;
	rand <= 1;
	takingData <= 0;
	rate_cnt <= 0;
	pass <= 1;
	done <= 0;
	test_cnt <= 0;
     end else begin
	if (dataValid & takingData) begin
	   if (test_cnt >= TESTLENGTH) begin
	      done <= 1;
	   end else if (checkData != data_in) begin
	      pass <= 0;
	      $display("ERROR: check=%d, data_in=%d", checkData, data_in);
	      $stop;
	   end
	   checkData <= {checkData[WIDTH-2:0] , rand};
	   rand <= checkData[WIDTH-1] ^~ checkData[WIDTH-11] ^~ checkData[2] ^~ checkData[1];
	   test_cnt <= test_cnt + 1;
	end
	if (rate_cnt >= RATE_DEN) begin
	   takingData <= 1;
	   rate_cnt <= rate_cnt - RATE_DEN + RATE_NUM;
	end else begin
	   takingData <= 0;
	   rate_cnt <= rate_cnt + RATE_NUM;
	end
     end
  end

endmodule // bist_check

