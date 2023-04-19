//
// Complex Multiplier (ar + ai)*(br + bi) = (pr + pi)
//
module complex_multiplier # (parameter  A_WIDTH = 20,  B_WIDTH = 18)
(
 input clk, reset,
 input signed [ A_WIDTH-1:0] ar, ai,
 input signed [ B_WIDTH-1:0] br, bi,
 output signed [ A_WIDTH+ B_WIDTH:0] pr, pi
 );

reg signed [ A_WIDTH-1:0] ai_d, ai_dd, ai_ddd, ai_dddd ;
reg signed [ A_WIDTH-1:0] ar_d, ar_dd, ar_ddd, ar_dddd ;
reg signed [ B_WIDTH-1:0] bi_d, bi_dd, bi_ddd, br_d, br_dd, br_ddd ;
reg signed [ A_WIDTH:0] addcommon ;
reg signed [ B_WIDTH:0] addr, addi ;
reg signed [ A_WIDTH+ B_WIDTH:0] mult0, multr, multi, pr_int, pi_int ;
reg signed [ A_WIDTH+ B_WIDTH:0] common, commonr1, commonr2 ;

always @(posedge clk) begin
    if (reset) begin 
        ar_d <= 0;
        ar_dd <= 0;
        ai_d <= 0;
        ai_dd <= 0;
        br_d <= 0;
        br_dd <= 0;
        br_ddd <= 0;
        bi_d <= 0;
        bi_dd <= 0;
        bi_ddd <= 0;
    end
    else begin
        ar_d <= ar;
        ar_dd <= ar_d;
        ai_d <= ai;
        ai_dd <= ai_d;
        br_d <= br;
        br_dd <= br_d;
        br_ddd <= br_dd;
        bi_d <= bi;
        bi_dd <= bi_d;
        bi_ddd <= bi_dd;
    end
end 
// Common factor (ar ai) x bi, shared for the calculations of the real and imaginary final products
//
always @(posedge clk) begin
    if (reset) begin
        addcommon <= 0;
        mult0 <= 0;
        common <= 0;
    end
    else begin
        addcommon <= ar_d - ai_d;
        mult0 <= addcommon * bi_dd;
        common <= mult0;
    end
end
// Real product
//
always @(posedge clk) begin
    if (reset) begin   
        ar_ddd <= 0;
        ar_dddd <= 0;
        addr <= 0;
        multr <= 0;
        commonr1 <= 0;
        pr_int <= 0;
    end
    else begin
        ar_ddd <= ar_dd;
        ar_dddd <= ar_ddd;
        addr <= br_ddd - bi_ddd;
        multr <= addr * ar_dddd;
        commonr1 <= common;
        pr_int <= multr + commonr1;
    end
end
// Imaginary product
//
always @(posedge clk) begin
    if (reset) begin   
        ai_ddd <= 0;
        ai_dddd <= 0;
        addi <= 0;
        multi <= 0;
        commonr2 <= 0;
        pi_int <= 0;
    end
    else begin
        ai_ddd <= ai_dd;
        ai_dddd <= ai_ddd;
        addi <= br_ddd + bi_ddd;
        multi <= addi * ai_dddd;
        commonr2 <= common;
        pi_int <= multi + commonr2;
    end
end
assign pr = pr_int;
assign pi = pi_int;

endmodule // cmult