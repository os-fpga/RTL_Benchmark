// Implement a synchronous FIFO, i.e. a FIFO that uses the same clock
// for inputs and outputs

`timescale 1ns / 1ns


module sync_fifo(/*AUTOARG*/
   // Outputs
   takingDataIn, data_out, dataValidOut,
   // Inputs
   clk, reset, data_in, dataValidIn, takingDataOut
   );
   parameter  DEPTH = 64;
   parameter  WIDTH = 32;
   localparam ADDR_BITS = log2(DEPTH);

  input      clk;
  input      reset;

  input [WIDTH-1 :0] data_in;
  input 	     dataValidIn;
  output 	     takingDataIn;

  output [WIDTH-1 :0] data_out;
  output 	     dataValidOut;
  input 	     takingDataOut;

  /*AUTOREG*/
  /*AUTOWIRE*/
   
 function integer log2;
  input integer value;
  begin
    value = value-1;
    for (log2=0; value>0; log2=log2+1)
      value = value>>1;
  end
  endfunction

 // FIFO head and tail pointers
  reg [ADDR_BITS-1:0] wr_ptr;
  wire [ADDR_BITS-1:0] wr_ptr_1;
  reg [ADDR_BITS-1:0] rd_ptr;
 
  // FIFO memory
  reg [WIDTH-1:0]     mem [0:DEPTH-1];

  //  Write pointer generation.
  //  It increments when there is a dataValid.
  //  It resets to zero if there is a reset

  // Share the + 1 with the full computation
  assign wr_ptr_1 = wr_ptr + 1;
  
  always @ (posedge clk) begin
     if (reset) begin
	wr_ptr <= 0;
     end else if (dataValidIn & takingDataIn) begin
	wr_ptr <= wr_ptr_1;
     end
   end

//  Read pointer generation.
//  It increments when there is a takingData.
//  It resets to zero if there is a reset.
  always @ (posedge clk) begin
    if (reset) begin
       rd_ptr <= 0;
    end else if (dataValidOut & takingDataOut) begin
       rd_ptr <= rd_ptr + 1;
    end
  end

  assign takingDataIn = ! (wr_ptr_1 == rd_ptr);
  assign dataValidOut = ! (rd_ptr == wr_ptr);

  // Read port
  assign data_out = mem[rd_ptr];

  // Write port
  always @ (posedge clk) begin
    if (dataValidIn && takingDataIn) begin
      mem[wr_ptr] <= data_in;
    end
  end

endmodule
