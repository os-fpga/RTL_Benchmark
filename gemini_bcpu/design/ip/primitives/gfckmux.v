`ifndef GFCKMUX
`define GFCKMUX

module gfckmux
(
    input  wire arst_n   , // asynchronys reset
    input  wire clka     , // clock domain a
    input  wire clkb     , // clock domain b
    input  wire select   , // asynchronus select clock

    output wire clk_out    // result clock
);

// lower synchronization stage
reg  sync_clka_sel;
reg  sync_clka;
// upper synchronization stage
reg  sync_clkb_sel;
reg  sync_clkb;

wire clk_up, clk_dn;
wire clk_res;

//==================================================
//       LOWER SYNCRONIZATION STAGE
always @(posedge clka, negedge arst_n)
    if(~arst_n) sync_clka     <= 1'b1;
    else        sync_clka     <=  select & ~sync_clkb_sel;

always @(negedge clka, negedge arst_n)
    if(~arst_n) sync_clka_sel <= 1'b1;
    else        sync_clka_sel <= sync_clka;
//==================================================

//==================================================
//       UPPER SYNCRONIZATION STAGE
always @(posedge clkb, negedge arst_n)
    if(~arst_n) sync_clkb     <= 1'b0;
    else        sync_clkb     <= ~select & ~sync_clka_sel;

always @(negedge clkb, negedge arst_n)
    if(~arst_n) sync_clkb_sel <= 1'b0;
    else        sync_clkb_sel <= sync_clkb;
//==================================================

assign clk_up = ~(clka & sync_clka_sel);
assign clk_dn = ~(clkb & sync_clkb_sel);
assign clk_out = ~(clk_up & clk_dn);

//*****************************************************************************
endmodule
`endif //GFCKMUX


