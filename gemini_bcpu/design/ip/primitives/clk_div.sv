`ifndef CKDIV
`define CKDIV

module clk_div
#(
    parameter DIVIDER_WIDTH = 4,
    parameter BYPASS_EN     = 0
)(
    input  wire                      clk           , // Input clock
    input  wire                      rst_n         , // Sync Reset
    input  wire [DIVIDER_WIDTH -1:0] dvalue        , // DivideValue = ( Decimation factor ) *0.5 -1
    input  wire                      bypass        , // 1 - Clk_o = Clk_i, else divided clock
    
    output wire                      clk_out         // Output divided clock
);

reg   [DIVIDER_WIDTH -1:0] cnt_div ; // divider counter
reg   clk_div                      ; // divider clock generator
wire  cnt_null                     ; // count reset and output event flag
wire  gen_clk                      ;

assign cnt_null = ~(|cnt_div);

always @(posedge clk or negedge rst_n)
    if      (!rst_n)    cnt_div <= {DIVIDER_WIDTH{1'b0}};
    else if (!cnt_null) cnt_div <= cnt_div - 1'b1;
    else                cnt_div <= dvalue;

always @(posedge clk or negedge rst_n)
    if      (!rst_n)   clk_div <= 1'b0;
    else if (cnt_null) clk_div <= !clk_div;
  
assign gen_clk = clk_div;


generate
    if(BYPASS_EN) begin
        // glitch free clock multi
        // use clka by default
        // clka -> input clock (source clk)
        // clkb -> generated clock (source clk_div register)

        gfckmux ckmux_u
        (
        .arst_n              (rst_n           ),
        .clka                (clk             ),
        .clkb                (gen_clk         ),
        .select              (bypass          ),
        .clk_out             (clk_out         )
        );
        //*****************************************************************************        
    end
    else 
        assign clk_out = gen_clk;
endgenerate




endmodule // CKDIV
`endif // CKDIV