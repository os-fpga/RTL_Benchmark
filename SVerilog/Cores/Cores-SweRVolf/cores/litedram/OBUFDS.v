module OBUFDS (
    output wire O,OB,
    input wire I);

    parameter CAPACITANCE = "DONT_CARE";
    parameter IOSTANDARD = "DEFAULT";
    parameter SLEW = "SLOW";
    
`ifdef XIL_TIMING

    parameter LOC = " UNPLACED";

`endif

    
    //tri0 GTS = glbl.GTS;

    initial begin

        case (CAPACITANCE)

            "LOW", "NORMAL", "DONT_CARE" : ;
            default : begin
                          $display("Attribute Syntax Error : The attribute CAPACITANCE on OBUFDS instance %m is set to %s.  Legal values for this attribute are DONT_CARE, LOW or NORMAL.", CAPACITANCE);
                          #1 $finish;
                      end

        endcase

    end

  //  bufif0 (O, I, GTS);
  //  notif0 (OB, I, GTS);

`ifdef XIL_TIMING

    specify
	(I => O) = (0:0:0, 0:0:0);
	(I => OB) = (0:0:0, 0:0:0);
	specparam PATHPULSE$ = 0;
    endspecify

`endif

endmodule
