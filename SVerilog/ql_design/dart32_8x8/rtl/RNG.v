`timescale 1 ns/100 ps	// time unit = 1ns; precision = 1/10 ns
 /* Random Number Generator
 * rng.v
 *
 * This RNG implements a three-component Tausworth generator.
 * It generates a 32-bit random value.
 *
 * The output of RNG is registered.
 *
 * Configuration path
 *      config_in -> s1 -> s2 -> s3 -> config_out
 */

module RNG (
    clock,
    reset,
    enable,
    rand_out,
    config_in_valid,
    config_in,
    config_out_valid,
    config_out
);

    input           clock;
    input           reset;
    input           enable;
    input           config_in_valid;
    input   [15: 0] config_in;
    output          config_out_valid;
    output  [15: 0] config_out;
    output  [31: 0] rand_out;
    
    
    // Seeds
    reg     [31: 0] s1, s2, s3;
    wire    [31: 0] s1_wire, s2_wire, s3_wire, b1_wire, b2_wire, b3_wire;
    
    assign b1_wire = (((s1 << 13) ^ s1) >> 19);
    assign s1_wire = (((s1 & 32'hFFFFFFFE) << 12) ^ b1_wire);
    assign b2_wire = (((s2 << 2) ^ s2) >> 25);
    assign s2_wire = (((s2 & 32'hFFFFFFF8) << 4) ^ b2_wire);
    assign b3_wire = (((s3 << 3) ^ s3) >> 11);
    assign s3_wire = (((s3 & 32'hFFFFFFF0) << 17) ^ b3_wire);
    
    assign rand_out = s1 ^ s2 ^ s3;
    assign config_out_valid = config_in_valid;
    assign config_out = s3[15:0];
    
    always @(posedge clock)
    begin
        if (reset)
        begin
            s1 <= 32'hffff_fc02;
            s2 <= 32'hffff_fc03;
            s3 <= 32'hffff_fc04;
        end
        else
        begin
            // Configuration path
            if (config_in_valid)
                {s1, s2, s3} <= {config_in, s1, s2, s3[31:16]};
            // Data path
            else if (enable)
                {s1, s2, s3} <= {s1_wire, s2_wire, s3_wire};
        end
    end

endmodule
