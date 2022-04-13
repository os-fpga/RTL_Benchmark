`timescale 1 ns/100 ps  // time unit = 1ns; precision = 1/10 ns
/* Select Early (use 3-bit timestamp LSb)
 * select_early_3b.v
 *
 * Combinational module that selects the earliest of N input timestamps
 */

module select_early_3b (
    ts_in,
    valid,
    tmin,
    sel,
    sel_valid
);
    `include "math.v"

    parameter N = 2;
    localparam LOG_N = CLogB2(N-1);

    input    [3*N-1:0] ts_in;
    input      [N-1:0] valid;

    output        [2:0] tmin;
    output  [LOG_N-1:0] sel;
    output              sel_valid;

    // We only support x2, x8 for now
    // psl ERROR_unsupported_N: assert always {N == 2 || N == 8};

    assign sel_valid = |valid;


    // The strictly-earlier table:
    //
    // t1\t0 | 000 | 001 | 010 | 011 | 100 | 101 | 110 | 111
    // ------------------------------------------------------
    //   000 | t0  | t1  | t1  | t1  | t1  | t0  | t0  | t0
    //   001 | t0  | t0  | t1  | t1  | t1  | t1  | t0  | t0
    //   010 | t0  | t0  | t0  | t1  | t1  | t1  | t1  | t0
    //   011 | t0  | t0  | t0  | t0  | t1  | t1  | t1  | t1
    //   100 | t1  | t0  | t0  | t0  | t0  | t1  | t1  | t1
    //   101 | t1  | t1  | t0  | t0  | t0  | t0  | t1  | t1
    //   110 | t1  | t1  | t1  | t0  | t0  | t0  | t0  | t1
    //   111 | t1  | t1  | t1  | t1  | t0  | t0  | t0  | t0

    generate
        if (N == 2)
        begin
            reg bsel;
            reg [2:0] btmin;
            assign sel = (bsel & valid[1]) | (~valid[0]);
            //assign tmin = (sel == 1'b0) ? ts_in[2:0] : ts_in[5:3];
            //assign tmin = (valid[1] == 1'b0) ? ts_in[2:0] : btmin;
            assign tmin = btmin;

            always @(*)
            begin
                case (ts_in)
                    // t1 = 000
                    6'b000_000:     begin bsel = 1'b0; btmin = 3'b000;end  // select t0
                    6'b000_001:     begin bsel = 1'b1; btmin = 3'b000;end  // select t1
                    6'b000_010:     begin bsel = 1'b1; btmin = 3'b000;end
                    6'b000_011:     begin bsel = 1'b1; btmin = 3'b000;end
                    6'b000_100:     begin bsel = 1'b1; btmin = 3'b000;end
                    6'b000_101:     begin bsel = 1'b0; btmin = 3'b101;end
                    6'b000_110:     begin bsel = 1'b0; btmin = 3'b110;end
                    6'b000_111:     begin bsel = 1'b0; btmin = 3'b111;end
                    
                    // t1 = 001
                    6'b001_000:     begin bsel = 1'b0; btmin = 3'b000;end
                    6'b001_001:     begin bsel = 1'b0; btmin = 3'b001;end
                    6'b001_010:     begin bsel = 1'b1; btmin = 3'b001;end
                    6'b001_011:     begin bsel = 1'b1; btmin = 3'b001;end
                    6'b001_100:     begin bsel = 1'b1; btmin = 3'b001;end
                    6'b001_101:     begin bsel = 1'b1; btmin = 3'b001;end
                    6'b001_110:     begin bsel = 1'b0; btmin = 3'b110;end
                    6'b001_111:     begin bsel = 1'b0; btmin = 3'b111;end

                    // t1 = 010
                    6'b010_000:     begin bsel = 1'b0; btmin = 3'b000;end
                    6'b010_001:     begin bsel = 1'b0; btmin = 3'b001;end
                    6'b010_010:     begin bsel = 1'b0; btmin = 3'b010;end
                    6'b010_011:     begin bsel = 1'b1; btmin = 3'b010;end
                    6'b010_100:     begin bsel = 1'b1; btmin = 3'b010;end
                    6'b010_101:     begin bsel = 1'b1; btmin = 3'b010;end
                    6'b010_110:     begin bsel = 1'b1; btmin = 3'b010;end
                    6'b010_111:     begin bsel = 1'b0; btmin = 3'b111;end

                    // t1 = 011
                    6'b011_000:     begin bsel = 1'b0; btmin = 3'b000;end
                    6'b011_001:     begin bsel = 1'b0; btmin = 3'b001;end
                    6'b011_010:     begin bsel = 1'b0; btmin = 3'b010;end
                    6'b011_011:     begin bsel = 1'b0; btmin = 3'b011;end
                    6'b011_100:     begin bsel = 1'b1; btmin = 3'b011;end
                    6'b011_101:     begin bsel = 1'b1; btmin = 3'b011;end
                    6'b011_110:     begin bsel = 1'b1; btmin = 3'b011;end
                    6'b011_111:     begin bsel = 1'b1; btmin = 3'b011;end

                    // t1 = 100
                    6'b100_000:     begin bsel = 1'b1; btmin = 3'b100;end
                    6'b100_001:     begin bsel = 1'b0; btmin = 3'b001;end
                    6'b100_010:     begin bsel = 1'b0; btmin = 3'b010;end
                    6'b100_011:     begin bsel = 1'b0; btmin = 3'b011;end
                    6'b100_100:     begin bsel = 1'b0; btmin = 3'b100;end
                    6'b100_101:     begin bsel = 1'b1; btmin = 3'b100;end
                    6'b100_110:     begin bsel = 1'b1; btmin = 3'b100;end
                    6'b100_111:     begin bsel = 1'b1; btmin = 3'b100;end

                    // t1 = 101
                    6'b101_000:     begin bsel = 1'b1; btmin = 3'b101;end
                    6'b101_001:     begin bsel = 1'b1; btmin = 3'b101;end
                    6'b101_010:     begin bsel = 1'b0; btmin = 3'b010;end
                    6'b101_011:     begin bsel = 1'b0; btmin = 3'b011;end
                    6'b101_100:     begin bsel = 1'b0; btmin = 3'b100;end
                    6'b101_101:     begin bsel = 1'b0; btmin = 3'b101;end
                    6'b101_110:     begin bsel = 1'b1; btmin = 3'b101;end
                    6'b101_111:     begin bsel = 1'b1; btmin = 3'b101;end

                    // t1 = 110
                    6'b110_000:     begin bsel = 1'b1; btmin = 3'b110;end
                    6'b110_001:     begin bsel = 1'b1; btmin = 3'b110;end
                    6'b110_010:     begin bsel = 1'b1; btmin = 3'b110;end
                    6'b110_011:     begin bsel = 1'b0; btmin = 3'b011;end
                    6'b110_100:     begin bsel = 1'b0; btmin = 3'b100;end
                    6'b110_101:     begin bsel = 1'b0; btmin = 3'b101;end
                    6'b110_110:     begin bsel = 1'b0; btmin = 3'b110;end
                    6'b110_111:     begin bsel = 1'b1; btmin = 3'b110;end

                    // t1 = 111
                    6'b111_000:     begin bsel = 1'b1; btmin = 3'b111;end
                    6'b111_001:     begin bsel = 1'b1; btmin = 3'b111;end
                    6'b111_010:     begin bsel = 1'b1; btmin = 3'b111;end
                    6'b111_011:     begin bsel = 1'b1; btmin = 3'b111;end
                    6'b111_100:     begin bsel = 1'b0; btmin = 3'b100;end
                    6'b111_101:     begin bsel = 1'b0; btmin = 3'b101;end
                    6'b111_110:     begin bsel = 1'b0; btmin = 3'b110;end
                    6'b111_111:     begin bsel = 1'b0; btmin = 3'b111;end
                endcase
            end
        end
        else if (N == 4 || N == 8)
        begin
            wire  [2:0] w_tmin;
            wire  [2:0] w_tmin_temp [1:0];
            wire [LOG_N-2:0] w_sel_temp [1:0];

            wire [1:0] w_valid_temp;
            wire       w_sel;
            wire [LOG_N-2:0] w_sub_sel;

            select_early_3b #(.N(N/2)) u0 (
                .ts_in (ts_in[3*N/2-1:0]),
                .valid (valid[N/2-1:0]),
                .tmin (w_tmin_temp[0]),
                .sel (w_sel_temp[0]),
                .sel_valid (w_valid_temp[0]));

            select_early_3b #(.N(N/2)) u1 (
                .ts_in (ts_in[3*N-1:3*N/2]),
                .valid (valid[N-1:N/2]),
                .tmin (w_tmin_temp[1]),
                .sel (w_sel_temp[1]),
                .sel_valid (w_valid_temp[1]));

            select_early_3b #(.N(2)) u (
                .ts_in ({w_tmin_temp[1], w_tmin_temp[0]}),
                .valid (w_valid_temp),
                .tmin (w_tmin),
                .sel (w_sel),
                .sel_valid ());

            assign w_sub_sel = (w_sel == 1'b0) ? w_sel_temp[0] : w_sel_temp[1];
            assign tmin = w_tmin;
            assign sel = {w_sel, w_sub_sel};

        end
    endgenerate

endmodule

