
module butterfly(/*AUTOARG*/
   // Outputs
   aout, bout, dataValidOut, takingDataIn,
   // Inputs
   ain, bin, dataValidInA, dataValidInB, takingDataOutA,
   takingDataOutB
   );
   parameter WIDTH = 32;
   input [WIDTH-1:0] ain, bin;
   output [WIDTH-1:0] aout, bout;
   input 	      dataValidInA, dataValidInB, takingDataOutA, takingDataOutB;
   output 	      dataValidOut, takingDataIn;

   wire [WIDTH:0]     a0, b0, a1, b1;

   assign a0 = ain + bin;
   assign b0 = ain - bin;
   assign a1 = a0 + b0;
   assign b1 = a0 - b0;
   assign aout = a1>>1;
   assign bout = b1>>1;
   assign dataValidOut = dataValidInA && dataValidInB;
   assign takingDataIn = takingDataOutA && takingDataOutB;

endmodule // butterfly
