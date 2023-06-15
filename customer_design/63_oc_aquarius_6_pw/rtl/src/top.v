
module top_75 (/*AUTOARG*/
   // Outputs
   pass, done, clkout,
   // Inputs
   clk, reset
   );
   parameter TESTLENGTH = 'h8_000_000;
   //XQ parameter NUM_FIFOS = 1000;
   parameter NUM_FIFOS = 75;
   parameter FIFOA_DEPTH = 32;
   parameter FIFOB_DEPTH = 32;
   parameter WIDTH = 32;
   
   input clk;
   input reset;
   output pass;
   output done;
   output clkout;
   
//   ckgen ckgen_inst(
//		    .clkin (clk),
//		    .Clk2 (clk2),
//		    .Clk  (clk1));

//   wire 		sysClk;
//   m_gbuf clkBuf (.I(clk2), .O(sysClk));
   assign sysClk = clk;
   
   reg 	  rstSync1, rstSync2;
   always @(posedge sysClk) begin
      { rstSync2, rstSync1 } <= { rstSync1,  reset };
   end
   wire sysReset;
   //XQ m_gbuf rstBuf (.I(rstSync2), .O(sysReset));
	assign sysReset = rstSync2;
   reg 			clkout;
   always @(posedge sysClk) begin
      if (sysReset) begin
	 clkout <= 0;
      end else begin
	 clkout <= ~clkout;
      end
   end

/*AUTOWIRE*/
// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire			doneA;			// From checkA of bist_check.v
wire			doneB;			// From checkB of bist_check.v
wire			passA;			// From checkA of bist_check.v
wire			passB;			// From checkB of bist_check.v
// End of automatics
   wire [WIDTH-1:0] 	dataA [0:NUM_FIFOS];  // Data from FIFOs
   wire [WIDTH-1:0] 	dataB [0:NUM_FIFOS];  // Data from FIFOs
   wire [WIDTH-1:0] 	butterfly_dataA [0:NUM_FIFOS]; // Data from butterflys
   wire [WIDTH-1:0] 	butterfly_dataB [0:NUM_FIFOS]; // Data from butterflys
   wire 		dataValid [0:NUM_FIFOS];  // DV,TD from butterflys
   wire 		takingData [0:NUM_FIFOS];
   wire 		dataValidA [0:NUM_FIFOS]; // DV,TD from FIFOs
   wire 		takingDataA [0:NUM_FIFOS];
   wire 		dataValidB [0:NUM_FIFOS];
   wire 		takingDataB [0:NUM_FIFOS];
	
   
   bist_generate #(.WIDTH(WIDTH),
		   .TESTLENGTH(TESTLENGTH),
		   .DATASEED(877),
		   .RATE_NUM(1),		  
		   .RATE_DEN(1))
   gena (
	// Outputs
	.dataValid	(dataValidA[0]),
	.data_out	(dataA[0]),
	// Inputs
	.takingData	(takingDataA[0]),
	/*AUTOINST*/
	 // Inputs
	 .clk				(sysClk),
	 .reset				(sysReset));
   bist_generate #(.WIDTH(WIDTH),
		   .TESTLENGTH(TESTLENGTH),
		   .DATASEED(433),
		   .RATE_NUM(1),		  
		   .RATE_DEN(1))
   genb (
	// Outputs
	.dataValid	(dataValidB[0]),
	.data_out	(dataB[0]),
	// Inputs
	.takingData	(takingDataB[0]),
	/*AUTOINST*/
	 // Inputs
	 .clk				(sysClk),
	 .reset				(sysReset));
   genvar 		i;
   generate for(i = 0; i < NUM_FIFOS; i = i + 1) begin: butterfly_loop
      butterfly #(.WIDTH(WIDTH))
      butterfly_inst (
		      // Outputs
		      .aout		(butterfly_dataA[i]),
		      .bout		(butterfly_dataB[i]),
		      .dataValidOut	(dataValid[i]),
		      .takingDataIn	(takingData[i]),
		      // Inputs
		      .ain		(dataA[i]),
		      .bin		(dataB[i]),
		      .dataValidInA	(dataValidA[i]),
		      .dataValidInB	(dataValidB[i]),
		      .takingDataOutA	(takingDataA[i]),
		      .takingDataOutB	(takingDataB[i]));
		      
      sync_fifo #(.WIDTH(WIDTH),
		  .DEPTH(FIFOA_DEPTH))
      fifo_instA (
		 // Outputs
		 .takingDataIn	(takingDataA[i]),
		 .data_out	(dataA[i+1]),
		 .dataValidOut	(dataValidA[i+1]),
		 // Inputs
		 .data_in       (butterfly_dataA[i]),
		 .dataValidIn	(dataValid[i]),
		 .takingDataOut	(takingDataA[i+1]),
		 /*AUTOINST*/
		  // Inputs
		  .clk			(sysClk),
		  .reset		(sysReset));
      sync_fifo #(.WIDTH(WIDTH),
		  .DEPTH(FIFOB_DEPTH))
      fifo_instB (
		 // Outputs
		 .takingDataIn	(takingDataB[i]),
		 .data_out	(dataB[i+1]),
		 .dataValidOut	(dataValidB[i+1]),
		 // Inputs
		 .data_in       (butterfly_dataB[i]),
		 .dataValidIn	(dataValid[i]),
		 .takingDataOut	(takingDataB[i+1]),
		 /*AUTOINST*/
		  // Inputs
		  .clk			(sysClk),
		  .reset		(sysReset));
   end // block: fifo_inst
endgenerate
   
   bist_check #(.WIDTH(WIDTH),
		.TESTLENGTH(TESTLENGTH),
		   .DATASEED(877),
		.RATE_NUM(1),		  
		.RATE_DEN(1))
   checkA ( .data_in		(dataA[NUM_FIFOS]),
	    .takingData		(takingDataA[NUM_FIFOS]),
	    .dataValid		(dataValidA[NUM_FIFOS]),
	    // Outputs
	    .pass		(passA),
	    .done		(doneA),
	    /*AUTOINST*/
	   // Inputs
	   .clk				(sysClk),
	   .reset			(sysReset));
   bist_check #(.WIDTH(WIDTH),
		.TESTLENGTH(TESTLENGTH),
		.DATASEED(433),
		.RATE_NUM(1),		  
		.RATE_DEN(1))
   checkB ( .data_in		(dataB[NUM_FIFOS]),
	    .takingData		(takingDataB[NUM_FIFOS]),
	    .dataValid		(dataValidB[NUM_FIFOS]),
	    // Outputs
	    .pass		(passB),
	    .done		(doneB),
	    /*AUTOINST*/
	   // Inputs
	   .clk				(sysClk),
	   .reset			(sysReset));
   assign pass = passA && passB;
   assign done = doneA && doneB;
   
endmodule // top

// Local Variables:
// verilog-library-directories:("." "../../rtl")
// End:





