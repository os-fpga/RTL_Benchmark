// Wrapper_Design

module wrapper_adder_FFs(temp_in_a_or_b, clk, clr, d_out, cout, select_a_or_b);

    input [127:0] temp_in_a_or_b;
    output [127:0] d_out;
    input clr, clk;
    output [1:0] cout;
    input select_a_or_b;
    
    reg [127:0] a;
    reg [127:0] b;
    always @(posedge clk)
        begin
            case (select_a_or_b)
                    1'b0:
                        begin
                            a <= temp_in_a_or_b;
                            //b = b;
                        end
                    1'b1:
                        begin
                            b <= temp_in_a_or_b;
                            //a = a;                           
                        end
            endcase
        end
    adder_FFs (a, b, clk, clr, d_out, cout);
    endmodule
    
    