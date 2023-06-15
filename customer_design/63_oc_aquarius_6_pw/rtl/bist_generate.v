// Test fixture that sends a data stream to the FIFO
// We generate a pseudo-random string of data according
// to a seed.  We also generate DataValids at a random
// rate according to a second seed.

`timescale 1ns / 1ns

module bist_generate(/*AUTOARG*/
   // Outputs
   dataValid, data_out,
   // Inputs
   clk, reset, takingData
   );
  parameter WIDTH = 32;
   parameter DATASEED = 187;	// Must match bist_check
   // Generate this much data. If 0, then infinite
   parameter TESTLENGTH = 100; 
   // Generate takingData RATE_NUM/RATE_DEN of the time
   parameter RATE_NUM = 1;
   parameter RATE_DEN = 2;
  parameter LASTDATA = 0;	// Marks last data sent
  
  input clk;
  input reset;
  output dataValid;
  input  takingData;
   output [WIDTH-1:0] data_out;
   reg [7:0] 	     rate_cnt;
   
   

/*AUTOREG*/
// Beginning of automatic regs (for this module's undeclared outputs)
reg			dataValid;
reg [WIDTH-1:0]		data_out;
// End of automatics

  reg			rand;
  reg [39:0] 		test_count;
  
  always @(posedge clk) begin
    if (reset) begin
      test_count <= 0;
      data_out <= DATASEED;
      dataValid <= 0;
       rate_cnt <= 0;
	rand <= 1;
    end else begin
      if (dataValid & takingData) begin
	if (TESTLENGTH != 0 && test_count >= TESTLENGTH) begin
	  data_out <= LASTDATA;
	end else begin
	   data_out <= { data_out[WIDTH-2:0] , rand};
	   rand <= data_out[WIDTH-1] ^~ data_out[WIDTH-11] ^~ data_out[2] ^~ data_out[1];
	   test_count <= test_count + 1;
	end
      end
      // Set dataValid for the next cycle
       if (rate_cnt >= RATE_DEN) begin
	  dataValid <= 1;
	  rate_cnt <= rate_cnt - RATE_DEN + RATE_NUM;
       end else begin
	  dataValid <= 0;
	  rate_cnt <= rate_cnt + RATE_NUM;
       end
    end
  end

endmodule // bist_generate


		   