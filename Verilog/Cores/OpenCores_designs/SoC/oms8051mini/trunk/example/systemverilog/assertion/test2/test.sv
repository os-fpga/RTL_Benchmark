//+++++++++++++++++++++++++++++++++++++++++++++++++
//   DUT With assertions
//+++++++++++++++++++++++++++++++++++++++++++++++++
module concurrent_assertion(
  input wire clk,req,reset, 
  input wire gnt);

//=================================================
// Sequence Layer
//=================================================
sequence req_gnt_seq;
  // (~req & gnt) and (~req & ~gnt) is Boolean Layer
 (req & ~gnt) ##1 (~req & gnt) ##1 (~req & ~gnt) ;
endsequence

//=================================================
// Property Specification Layer
//=================================================
property req_gnt_prop;
  @ (posedge clk) 
    disable iff (reset)
      req |-> req_gnt_seq;
endproperty
//=================================================
// Assertion Directive Layer
//=================================================
req_gnt_assert : assert property (req_gnt_prop)
                 else
                 $display("@%0dns Assertion Failed", $time);

endmodule

//+++++++++++++++++++++++++++++++++++++++++++++++
//   Testbench Code
//+++++++++++++++++++++++++++++++++++++++++++++++
module concurrent_assertion_tb();

reg clk = 0;
reg reset, req = 0;
reg gnt;

always #3 clk ++;

initial begin
  reset <= 1;
  #20 reset <= 0;
  repeat (100) @ (posedge clk);
  // Make the assertion pass
  @ (posedge clk) #1 req  <= 1;
  @ (posedge clk) #1 req <= 0;
  repeat (100) @ (posedge clk);
  // Make the assertion fail
  @ (posedge clk) #1 req  <= 1;
  repeat (5) @ (posedge clk);
  @ (posedge clk) #1 req <= 0;
  req <= 0;
  repeat (100) @ (posedge clk);
  #10 $finish;
end

//=================================================
// Actual DUT RTL
//=================================================
always @ (posedge clk)
  gnt <= #1 req ;


concurrent_assertion dut (clk,req,reset,gnt);


// Dumping Waveforms
initial begin //{
   
    $shm_open("simvision.shm"); 
    $shm_probe("AC"); 
end //}


endmodule
