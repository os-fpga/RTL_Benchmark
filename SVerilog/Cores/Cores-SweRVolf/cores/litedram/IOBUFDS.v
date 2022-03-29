module IOBUFDS (
    output wire O,
    inout wire IO,IOB,
    input wire I,T
    );

`ifdef XIL_TIMING
    parameter LOC = "UNPLACED";
`endif // `ifdef XIL_TIMING
    parameter DIFF_TERM = "FALSE";
    parameter DQS_BIAS = "FALSE";
    parameter IBUF_LOW_PWR = "TRUE";
    parameter IOSTANDARD = "DEFAULT";
    parameter SLEW = "SLOW";

  localparam MODULE_NAME = "IOBUFDS";


    wire i_in, io_in, iob_in, t_in;
    reg o_out, io_out, iob_out;
    reg O_int;

    reg DQS_BIAS_BINARY = 1'b0;

    wire t_or_gts; 
    //tri0 GTS = glbl.GTS;

    assign i_in = I;
    assign t_in = T;
    assign io_in = IO;
    assign iob_in = IOB;

 //   assign t_or_gts = GTS || t_in;
 assign t_or_gts = t_in;
    assign IO  = t_or_gts ? 1'bz :  i_in;
    assign IOB = t_or_gts ? 1'bz : ~i_in;

    initial begin

        case (DQS_BIAS)

            "TRUE"  : DQS_BIAS_BINARY <= #1 1'b1;
            "FALSE" : DQS_BIAS_BINARY <= #1 1'b0;
            default : begin
                          $display("Attribute Syntax Error : The attribute DQS_BIAS on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, DQS_BIAS);
                          #1 $finish;
                      end

        endcase

       case (DIFF_TERM)

            "TRUE", "FALSE" : ;
            default : begin
                          $display("Attribute Syntax Error : The attribute DIFF_TERM on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, DIFF_TERM);
                          #1 $finish;
                      end

        endcase // case(DIFF_TERM)

        case (IBUF_LOW_PWR)

            "FALSE", "TRUE" : ;
            default : begin
                          $display("Attribute Syntax Error : The attribute IBUF_LOW_PWR on %s instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MODULE_NAME, IBUF_LOW_PWR);
                          #1 $finish;
                      end

        endcase

      if((IOSTANDARD == "LVDS_25") || (IOSTANDARD == "LVDSEXT_25")) begin
            $display("DRC Warning : The IOSTANDARD attribute on %s instance %m is set to %s.  LVDS_25 is a fixed impedance structure optimized to 100ohm differential. If the intended usage is a bus architecture, please use BLVDS. This is only intended to be used in point to point transmissions that do not have turn around timing requirements", MODULE_NAME, IOSTANDARD);
        end

    end

    always @(io_in or iob_in or DQS_BIAS_BINARY) begin
        if (io_in == 1'b1 && iob_in == 1'b0)
          o_out <= 1'b1;
        else if (io_in == 1'b0 && iob_in == 1'b1)
          o_out <= 1'b0;
        else if ((io_in === 1'bz || io_in == 1'b0) && (iob_in === 1'bz || iob_in == 1'b1))
          if (DQS_BIAS_BINARY == 1'b1)
            o_out <= 1'b0;
          else
            o_out <= 1'bx;
        else if ((io_in === 1'bx) || (iob_in == 1'bx))
          o_out <= 1'bx;
        end

//    assign O  =  (t_in === 1'b0) ? 1'b1 : ((t_in === 1'b1) ? o_out : 1'bx));
    assign O  =  o_out;



`ifdef XIL_TIMING
    specify
        (I => O)                = (0:0:0,  0:0:0);
        (I => IO)               = (0:0:0,  0:0:0);
        (I => IOB)              = (0:0:0,  0:0:0);
        (IO => O)               = (0:0:0,  0:0:0);
        (IO => IOB)             = (0:0:0,  0:0:0);
        (IOB => O)              = (0:0:0,  0:0:0);
        (IOB => IO)             = (0:0:0,  0:0:0);
        (T => O)                = (0:0:0,  0:0:0);
        (T => IO)               = (0:0:0,  0:0:0);
        (T => IOB)              = (0:0:0,  0:0:0);
        specparam PATHPULSE$ = 0;
    endspecify
`endif // `ifdef XIL_TIMING

endmodule
