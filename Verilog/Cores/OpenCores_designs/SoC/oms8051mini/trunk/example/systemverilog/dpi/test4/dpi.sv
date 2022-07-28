module Bus(input In1, output Out1);
  import "DPI" function void increment(input int indata, output int outdata);
  export "DPI" function stepit;

parameter string InFileName ="Infile.hex";
parameter EOF = 32'hFFFFFFFF;
  // This SystemVerilog function could be called from C
  function void stepit(input int indata, output int outdata);
     outdata = indata+1;
  endfunction

int iData,oData;
integer TvTxPtr,TvTxPtr1=0;
reg [11:0] FileI1,FileQ1;
reg [23:0] FileIn;
string    InString;

initial begin
  iData = 10;
  increment(iData,oData);
  TvTxPtr  =$fopen(InFileName,"r");
  if(TvTxPtr == 0) begin
        $fclose(TvTxPtr); 
   end else begin
     //while(TvTxPtr1 != EOF) begin
        //TvTxPtr1 = $fscanf(TvTxPtr,"%h %h\n",FileI1,FileQ1);
        //$display("%h %h",FileI1,FileQ1);
        TvTxPtr1 = $fgets(InString, 100,TvTxPtr);
        $display("%s",InString);
      //end
      $fclose(TvTxPtr); 
   end

  $display("At SV: Input: %d Output : %d", iData,oData);
end

endmodule
