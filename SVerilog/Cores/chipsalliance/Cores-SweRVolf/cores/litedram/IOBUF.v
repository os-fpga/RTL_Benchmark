module IOBUF (
    
    output wire O,
    inout  wire IO,
    input  wire I, T
    );

    parameter integer DRIVE = 12;
    parameter IBUF_LOW_PWR = "TRUE";
    parameter IOSTANDARD = "DEFAULT";
`ifdef XIL_TIMING

    parameter LOC = " UNPLACED";

`endif
    parameter SLEW = "SLOW";


    wire ts;

    //tri0 GTS = glbl.GTS;

   // or O1 (ts, GTS, T);
    bufif0 T1 (IO, I, ts);

    buf B1 (O, IO);

    initial begin

        case (IBUF_LOW_PWR)

            "FALSE", "TRUE" : ;
            default : begin
                          $display("Attribute Syntax Error : The attribute IBUF_LOW_PWR on IBUF instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", IBUF_LOW_PWR);
                          #1 $finish;
                      end

        endcase
    end

`ifdef XIL_TIMING
    
    specify
        (I => O) = (0:0:0, 0:0:0);
        (I => IO)= (0:0:0,  0:0:0);
        (IO => O) = (0:0:0,  0:0:0);
        (T => O) = (0:0:0, 0:0:0);
        (T => IO) = (0:0:0, 0:0:0);
        specparam PATHPULSE$ = 0;
    endspecify

`endif
    
endmodule