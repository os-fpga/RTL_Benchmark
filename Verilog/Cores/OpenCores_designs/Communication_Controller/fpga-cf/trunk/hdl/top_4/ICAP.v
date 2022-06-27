module ICAP_VIRTEX5 (
	BUSY,
	O,
	CE,
	CLK,
	I,
	WRITE
);

output BUSY;
output [31:0] O;

input CE;
input CLK;
input WRITE;
input [31:0] I;

parameter ICAP_WIDTH = "X8";

initial begin
        case (ICAP_WIDTH)
                "X8" , "X16", "X32" : ;
                default : begin
                        $display("Attribute Syntax Error : The Attribute ICAP_WIDTH on ICAP_VIRTEX5 instance %m is set to %s.  Legal values for this attribute are X8, X16 or X32.", ICAP_WIDTH);
                        $finish;
                end
        endcase

end



specify
	specparam PATHPULSE$ = 0;
endspecify

endmodule 
