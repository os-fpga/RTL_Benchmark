`timescale 1ns/1ns

module top;

int iCnt = 5; // number of contents in each row

string iString = ""; 
string iFormateString = "%3h %3h %3h %3h %3h"; 
string iTempString="";
integer TvTxPtr,TvTxPtr1=0,i,TvRxPtr;
int iRowCnt = 0;
reg [55:0]  inData;
int     iStringSize[5];
int iPos = 0;

initial
begin
    $display("Starting Testing");
    TvTxPtr  =$fopen("input.hex","r");
    TvRxPtr  =$fopen("output.hex","w");
    if(TvTxPtr == 0 ) begin
        $display ("ERROR at (%m): Unable to open the input vector file");
        $finish;
    end
    while (TvTxPtr1 != -1) begin
       iString = "";
       for(i = 0; i < iCnt; i=i+1) begin
           TvTxPtr1 = $fscanf(TvTxPtr,"%s ",iTempString);
           if(TvTxPtr1 == -1) break;
           iString  = {iString,iTempString};
           iStringSize[i] = iTempString.len();

       end 
        if(TvTxPtr1 == -1) break;

       $sscanf(iString,"%h",inData);
       iPos = 0;
       $display("Row:%d String: %s; String Length : %d Hex Data: %h",++iRowCnt, iString,iStringSize[i],inData);
       for(i = 0; i < iCnt; i=i+1) begin
           $write("%d %s ",iStringSize[i],iString.substr(iPos,iPos+iStringSize[i]-1));
           if(i == iCnt -1) // If you at last column, bypass the space character
              $fwrite(TvRxPtr,"%s",iString.substr(iPos,iPos+iStringSize[i]-1));
           else // If you are not at lasy colum, keep a space between next word
              $fwrite(TvRxPtr,"%s ",iString.substr(iPos,iPos+iStringSize[i]-1));
           iPos = iPos +iStringSize[i];
       end
       $fwrite(TvRxPtr,"\n");

   end

  $fclose(TvTxPtr);
  $fclose(TvRxPtr);
  #200;
  $finish;

end



endmodule
