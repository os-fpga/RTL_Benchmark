module Bus(input In1, output Out1);
  import "DPI" function void increment(input int indata, output int outdata);
  export "DPI" function stepit;

  // This SystemVerilog function could be called from C
  function void stepit(input int indata, output int outdata);
     outdata = indata+1;
  endfunction

int iData,oData;

initial begin
  iData = 10;
  increment(iData,oData);
  $display("At SV: Input: %d Output : %d", iData,oData);
end

endmodule
