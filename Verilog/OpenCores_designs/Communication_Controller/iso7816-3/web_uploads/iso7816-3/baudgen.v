

// Generates pulses at the baud rate and 4 times the baud rate.
`define bauddiv 28
module baudgen(PULSE, BAUD, BAUD4, CK);
  parameter bauddiv_4 = `bauddiv / 4;
  
  output BAUD, BAUD4;
  input PULSE, CK;
  
  reg BAUD = 0;
  reg BAUD4 = 0;
  reg [1:0] baudPhase = 0;
  reg [8:0] baudDivCounter = 0;
  
  always @(posedge CK)
  begin
    BAUD4 <= 0;
    BAUD <= 0;
    if (PULSE)
    begin
      if (baudDivCounter == bauddiv_4 - 1) begin
        baudDivCounter <= 0;
        BAUD4 <= 1;
        baudPhase <= baudPhase + 1;
        BAUD <= (baudPhase == 0);
      end else begin
        baudDivCounter <= baudDivCounter + 1;
      end
    end
  end
endmodule
