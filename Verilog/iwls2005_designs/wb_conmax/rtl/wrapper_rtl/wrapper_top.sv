

parameter       dw  = 32;
parameter		aw	= 32;		
parameter		sw	= dw / 8;	

`timescale 1ns / 10ps

module wrapper_top (
input                   clk_i, rst_i,

// Master 0 Interface
input	    [dw-1:0]	tm_data_i,
output	reg [dw-1:0]	tm_data_o,
input	    [aw-1:0]	tm_addr_i,
input	    [sw-1:0]	tm_sel_i,
input			        tm_we_i,
input			        tm_cyc_i,
input			        tm_stb_i,
output  reg	            tm_ack_o,
output  reg	            tm_err_o,
output  reg	            tm_rty_o,


// Slave 0 Interface
input	    [dw-1:0]	ts_data_i,
output	reg [dw-1:0]	ts_data_o,
output	reg [aw-1:0]	ts_addr_o,
output	reg [sw-1:0]	ts_sel_o,
output	reg 		    ts_we_o,
output	reg 		    ts_cyc_o,
output	reg 		    ts_stb_o,
input			        ts_ack_i,
input			        ts_err_i,
input			        ts_rty_i,

input        [3:0]      slave_select,
input        [2:0]      master_select


);



// Master 0 Interface
reg	    [dw-1:0]	m0_data_i;
wire	[dw-1:0]	m0_data_o;
reg	    [aw-1:0]	m0_addr_i;
reg	    [sw-1:0]	m0_sel_i;
reg		       	    m0_we_i;
reg		       	    m0_cyc_i;
reg		       	    m0_stb_i;
wire			    m0_ack_o;
wire			    m0_err_o;
wire			    m0_rty_o;

// Master 1 Interface
reg	    [dw-1:0]	m1_data_i;
wire	[dw-1:0]	m1_data_o;
reg	    [aw-1:0]	m1_addr_i;
reg	    [sw-1:0]	m1_sel_i;
reg		       	    m1_we_i;
reg		       	    m1_cyc_i;
reg		       	    m1_stb_i;
wire			    m1_ack_o;
wire			    m1_err_o;
wire			    m1_rty_o;

// Master 2 Interface
reg	    [dw-1:0]	m2_data_i;
wire	[dw-1:0]	m2_data_o;
reg	    [aw-1:0]	m2_addr_i;
reg	    [sw-1:0]	m2_sel_i;
reg		       	    m2_we_i;
reg		       	    m2_cyc_i;
reg		       	    m2_stb_i;
wire			    m2_ack_o;
wire			    m2_err_o;
wire			    m2_rty_o;

// Master 3 Interface
reg	    [dw-1:0]	m3_data_i;
wire	[dw-1:0]	m3_data_o;
reg	    [aw-1:0]	m3_addr_i;
reg	    [sw-1:0]	m3_sel_i;
reg		       	    m3_we_i;
reg		       	    m3_cyc_i;
reg		       	    m3_stb_i;
wire			    m3_ack_o;
wire			    m3_err_o;
wire			    m3_rty_o;

// Master 4 Interface
reg	    [dw-1:0]	m4_data_i;
wire	[dw-1:0]	m4_data_o;
reg	    [aw-1:0]	m4_addr_i;
reg	    [sw-1:0]	m4_sel_i;
reg		       	    m4_we_i;
reg		       	    m4_cyc_i;
reg		       	    m4_stb_i;
wire			    m4_ack_o;
wire			    m4_err_o;
wire			    m4_rty_o;

// Master 5 Interface
reg	    [dw-1:0]	m5_data_i;
wire	[dw-1:0]	m5_data_o;
reg	    [aw-1:0]	m5_addr_i;
reg	    [sw-1:0]	m5_sel_i;
reg		       	    m5_we_i;
reg		       	    m5_cyc_i;
reg		       	    m5_stb_i;
wire			    m5_ack_o;
wire			    m5_err_o;
wire			    m5_rty_o;

// Master 6 Interface
reg	    [dw-1:0]	m6_data_i;
wire	[dw-1:0]	m6_data_o;
reg	    [aw-1:0]	m6_addr_i;
reg	    [sw-1:0]	m6_sel_i;
reg		       	    m6_we_i;
reg		       	    m6_cyc_i;
reg		       	    m6_stb_i;
wire			    m6_ack_o;
wire			    m6_err_o;
wire			    m6_rty_o;

// Master 7 Interface
reg	    [dw-1:0]	m7_data_i;
wire	[dw-1:0]	m7_data_o;
reg	    [aw-1:0]	m7_addr_i;
reg	    [sw-1:0]	m7_sel_i;
reg		       	    m7_we_i;
reg		       	    m7_cyc_i;
reg		       	    m7_stb_i;
wire			    m7_ack_o;
wire			    m7_err_o;
wire			    m7_rty_o;

// Slave 0 Interface
reg	    [dw-1:0]	s0_data_i;
wire	[dw-1:0]	s0_data_o;
wire	[aw-1:0]	s0_addr_o;
wire	[sw-1:0]	s0_sel_o;
wire			    s0_we_o;
wire			    s0_cyc_o;
wire			    s0_stb_o;
reg			        s0_ack_i;
reg			        s0_err_i;
reg			        s0_rty_i;

// Slave 1 Interface
reg	    [dw-1:0]	s1_data_i;
wire	[dw-1:0]	s1_data_o;
wire	[aw-1:0]	s1_addr_o;
wire	[sw-1:0]	s1_sel_o;
wire			    s1_we_o;
wire			    s1_cyc_o;
wire			    s1_stb_o;
reg			        s1_ack_i;
reg			        s1_err_i;
reg			        s1_rty_i;

// Slave 2 Interface
reg	    [dw-1:0]	s2_data_i;
wire	[dw-1:0]	s2_data_o;
wire	[aw-1:0]	s2_addr_o;
wire	[sw-1:0]	s2_sel_o;
wire			    s2_we_o;
wire			    s2_cyc_o;
wire			    s2_stb_o;
reg			        s2_ack_i;
reg			        s2_err_i;
reg			        s2_rty_i;

// Slave 3 Interface
reg	    [dw-1:0]	s3_data_i;
wire	[dw-1:0]	s3_data_o;
wire	[aw-1:0]	s3_addr_o;
wire	[sw-1:0]	s3_sel_o;
wire			    s3_we_o;
wire			    s3_cyc_o;
wire			    s3_stb_o;
reg			        s3_ack_i;
reg			        s3_err_i;
reg			        s3_rty_i;

// Slave 4 Interface
reg	    [dw-1:0]	s4_data_i;
wire	[dw-1:0]	s4_data_o;
wire	[aw-1:0]	s4_addr_o;
wire	[sw-1:0]	s4_sel_o;
wire			    s4_we_o;
wire			    s4_cyc_o;
wire			    s4_stb_o;
reg			        s4_ack_i;
reg			        s4_err_i;
reg			        s4_rty_i;

// Slave 5 Interface
reg	    [dw-1:0]	s5_data_i;
wire	[dw-1:0]	s5_data_o;
wire	[aw-1:0]	s5_addr_o;
wire	[sw-1:0]	s5_sel_o;
wire			    s5_we_o;
wire			    s5_cyc_o;
wire			    s5_stb_o;
reg			        s5_ack_i;
reg			        s5_err_i;
reg			        s5_rty_i;

// Slave 6 Interface
reg	    [dw-1:0]	s6_data_i;
wire	[dw-1:0]	s6_data_o;
wire	[aw-1:0]	s6_addr_o;
wire	[sw-1:0]	s6_sel_o;
wire			    s6_we_o;
wire			    s6_cyc_o;
wire			    s6_stb_o;
reg			        s6_ack_i;
reg			        s6_err_i;
reg			        s6_rty_i;

// Slave 7 Interface
reg	    [dw-1:0]	s7_data_i;
wire	[dw-1:0]	s7_data_o;
wire	[aw-1:0]	s7_addr_o;
wire	[sw-1:0]	s7_sel_o;
wire			    s7_we_o;
wire			    s7_cyc_o;
wire			    s7_stb_o;
reg			        s7_ack_i;
reg			        s7_err_i;
reg			        s7_rty_i;

// Slave 8 Interface
reg	    [dw-1:0]	s8_data_i;
wire	[dw-1:0]	s8_data_o;
wire	[aw-1:0]	s8_addr_o;
wire	[sw-1:0]	s8_sel_o;
wire			    s8_we_o;
wire			    s8_cyc_o;
wire			    s8_stb_o;
reg			        s8_ack_i;
reg			        s8_err_i;
reg			        s8_rty_i;

// Slave 9 Interface
reg	    [dw-1:0]	s9_data_i;
wire	[dw-1:0]	s9_data_o;
wire	[aw-1:0]	s9_addr_o;
wire	[sw-1:0]	s9_sel_o;
wire			    s9_we_o;
wire			    s9_cyc_o;
wire			    s9_stb_o;
reg			        s9_ack_i;
reg			        s9_err_i;
reg			        s9_rty_i;

// Slave 10 Interface
reg	    [dw-1:0]	s10_data_i;
wire	[dw-1:0]	s10_data_o;
wire	[aw-1:0]	s10_addr_o;
wire	[sw-1:0]	s10_sel_o;
wire			    s10_we_o;
wire			    s10_cyc_o;
wire			    s10_stb_o;
reg			        s10_ack_i;
reg			        s10_err_i;
reg			        s10_rty_i;

// Slave 11 Interface
reg	    [dw-1:0]	s11_data_i;
wire	[dw-1:0]	s11_data_o;
wire	[aw-1:0]	s11_addr_o;
wire	[sw-1:0]	s11_sel_o;
wire			    s11_we_o;
wire			    s11_cyc_o;
wire			    s11_stb_o;
reg			        s11_ack_i;
reg			        s11_err_i;
reg			        s11_rty_i;

// Slave 12 Interface
reg	    [dw-1:0]	s12_data_i;
wire	[dw-1:0]	s12_data_o;
wire	[aw-1:0]	s12_addr_o;
wire	[sw-1:0]	s12_sel_o;
wire			    s12_we_o;
wire			    s12_cyc_o;
wire			    s12_stb_o;
reg			        s12_ack_i;
reg			        s12_err_i;
reg			        s12_rty_i;

// Slave 13 Interface
reg	    [dw-1:0]	s13_data_i;
wire	[dw-1:0]	s13_data_o;
wire	[aw-1:0]	s13_addr_o;
wire	[sw-1:0]	s13_sel_o;
wire			    s13_we_o;
wire			    s13_cyc_o;
wire			    s13_stb_o;
reg			        s13_ack_i;
reg			        s13_err_i;
reg			        s13_rty_i;

// Slave 14 Interface
reg	    [dw-1:0]	s14_data_i;
wire	[dw-1:0]	s14_data_o;
wire	[aw-1:0]	s14_addr_o;
wire	[sw-1:0]	s14_sel_o;
wire			    s14_we_o;
wire			    s14_cyc_o;
wire			    s14_stb_o;
reg			        s14_ack_i;
reg			        s14_err_i;
reg			        s14_rty_i;

// Slave 15 Interface
reg	    [dw-1:0]	s15_data_i;
wire	[dw-1:0]	s15_data_o;
wire	[aw-1:0]	s15_addr_o;
wire	[sw-1:0]	s15_sel_o;
wire			    s15_we_o;
wire			    s15_cyc_o;
wire			    s15_stb_o;
reg			        s15_ack_i;
reg			        s15_err_i;
reg			        s15_rty_i;


always @(master_select, tm_data_i, m0_data_o, tm_addr_i, tm_sel_i, tm_we_i, tm_cyc_i, tm_stb_i, m0_ack_o, m0_err_o, m0_rty_o,
         m1_data_o, m1_ack_o, m1_err_o, m1_rty_o,m2_data_o, m2_ack_o, m2_err_o, m2_rty_o,m3_data_o, m3_ack_o, m3_err_o, m3_rty_o,
         m4_data_o, m4_ack_o, m4_err_o, m4_rty_o,m5_data_o, m5_ack_o, m5_err_o, m5_rty_o,m6_data_o, m6_ack_o, m6_err_o, m6_rty_o,
         m7_data_o, m7_ack_o, m7_err_o, m7_rty_o) begin 

    tm_data_o = 'b0;
    tm_ack_o  = 'b0;
    tm_err_o  = 'b0;
    tm_rty_o  = 'b0;
    m0_data_i = 'b0;
    m0_addr_i = 'b0;
    m0_sel_i  = 'b0;
    m0_we_i   = 'b0;
    m0_cyc_i  = 'b0;
    m0_stb_i  = 'b0;
    m1_data_i = 'b0;
    m1_addr_i = 'b0;
    m1_sel_i  = 'b0;
    m1_we_i   = 'b0;
    m1_cyc_i  = 'b0;
    m1_stb_i  = 'b0;
    m2_data_i = 'b0;
    m2_addr_i = 'b0;
    m2_sel_i  = 'b0;
    m2_we_i   = 'b0;
    m2_cyc_i  = 'b0;
    m2_stb_i  = 'b0;
    m3_data_i = 'b0;
    m3_addr_i = 'b0;
    m3_sel_i  = 'b0;
    m3_we_i   = 'b0;
    m3_cyc_i  = 'b0;
    m3_stb_i  = 'b0;
    m4_data_i = 'b0;
    m4_addr_i = 'b0;
    m4_sel_i  = 'b0;
    m4_we_i   = 'b0;
    m4_cyc_i  = 'b0;
    m4_stb_i  = 'b0;
    m5_data_i = 'b0;
    m5_addr_i = 'b0;
    m5_sel_i  = 'b0;
    m5_we_i   = 'b0;
    m5_cyc_i  = 'b0;
    m5_stb_i  = 'b0;
    m6_data_i = 'b0;
    m6_addr_i = 'b0;
    m6_sel_i  = 'b0;
    m6_we_i   = 'b0;
    m6_cyc_i  = 'b0;
    m6_stb_i  = 'b0;
    m7_data_i = 'b0;
    m7_addr_i = 'b0;
    m7_sel_i  = 'b0;
    m7_we_i   = 'b0;
    m7_cyc_i  = 'b0;
    m7_stb_i  = 'b0;

    case(master_select) /*full_case*/

        3'd0: begin
            m0_data_i = tm_data_i;
            tm_data_o = m0_data_o;
            m0_addr_i = tm_addr_i;
            m0_sel_i  = tm_sel_i;
            m0_we_i   = tm_we_i;
            m0_cyc_i  = tm_cyc_i;
            m0_stb_i  = tm_stb_i;
            tm_ack_o  = m0_ack_o;
            tm_err_o  = m0_err_o;
            tm_rty_o  = m0_rty_o;
        end
        3'd1: begin
            m1_data_i = tm_data_i;
            tm_data_o = m1_data_o;
            m1_addr_i = tm_addr_i;
            m1_sel_i  = tm_sel_i;
            m1_we_i   = tm_we_i;
            m1_cyc_i  = tm_cyc_i;
            m1_stb_i  = tm_stb_i;
            tm_ack_o  = m1_ack_o;
            tm_err_o  = m1_err_o;
            tm_rty_o  = m1_rty_o;
        end
        3'd2: begin
            m2_data_i = tm_data_i;
            tm_data_o = m2_data_o;
            m2_addr_i = tm_addr_i;
            m2_sel_i  = tm_sel_i;
            m2_we_i   = tm_we_i;
            m2_cyc_i  = tm_cyc_i;
            m2_stb_i  = tm_stb_i;
            tm_ack_o  = m2_ack_o;
            tm_err_o  = m2_err_o;
            tm_rty_o  = m2_rty_o;
        end
        3'd3: begin
            m3_data_i = tm_data_i;
            tm_data_o = m3_data_o;
            m3_addr_i = tm_addr_i;
            m3_sel_i  = tm_sel_i;
            m3_we_i   = tm_we_i;
            m3_cyc_i  = tm_cyc_i;
            m3_stb_i  = tm_stb_i;
            tm_ack_o  = m3_ack_o;
            tm_err_o  = m3_err_o;
            tm_rty_o  = m3_rty_o;
        end
        3'd4: begin
            m4_data_i = tm_data_i;
            tm_data_o = m4_data_o;
            m4_addr_i = tm_addr_i;
            m4_sel_i  = tm_sel_i;
            m4_we_i   = tm_we_i;
            m4_cyc_i  = tm_cyc_i;
            m4_stb_i  = tm_stb_i;
            tm_ack_o  = m4_ack_o;
            tm_err_o  = m4_err_o;
            tm_rty_o  = m4_rty_o;
        end
        3'd5: begin
            m5_data_i = tm_data_i;
            tm_data_o = m5_data_o;
            m5_addr_i = tm_addr_i;
            m5_sel_i  = tm_sel_i;
            m5_we_i   = tm_we_i;
            m5_cyc_i  = tm_cyc_i;
            m5_stb_i  = tm_stb_i;
            tm_ack_o  = m5_ack_o;
            tm_err_o  = m5_err_o;
            tm_rty_o  = m5_rty_o;
        end
        3'd6: begin
            m6_data_i = tm_data_i;
            tm_data_o = m6_data_o;
            m6_addr_i = tm_addr_i;
            m6_sel_i  = tm_sel_i;
            m6_we_i   = tm_we_i;
            m6_cyc_i  = tm_cyc_i;
            m6_stb_i  = tm_stb_i;
            tm_ack_o  = m6_ack_o;
            tm_err_o  = m6_err_o;
            tm_rty_o  = m6_rty_o;
        end
        3'd7: begin
            m7_data_i = tm_data_i;
            tm_data_o = m7_data_o;
            m7_addr_i = tm_addr_i;
            m7_sel_i  = tm_sel_i;
            m7_we_i   = tm_we_i;
            m7_cyc_i  = tm_cyc_i;
            m7_stb_i  = tm_stb_i;
            tm_ack_o  = m7_ack_o;
            tm_err_o  = m7_err_o;
            tm_rty_o  = m7_rty_o;
        end
    endcase
end


always @(slave_select, ts_data_i, ts_ack_i, ts_err_i, ts_rty_i, s0_data_o, s0_addr_o, s0_sel_o, s0_we_o, s0_cyc_o, s0_stb_o,
         s1_data_o, s1_addr_o, s1_sel_o, s1_we_o, s1_cyc_o, s1_stb_o, s2_data_o, s2_addr_o, s2_sel_o, s2_we_o, s2_cyc_o, s2_stb_o,
         s3_data_o, s3_addr_o, s3_sel_o, s3_we_o, s3_cyc_o, s3_stb_o, s4_data_o, s4_addr_o, s4_sel_o, s4_we_o, s4_cyc_o, s4_stb_o,
         s5_data_o, s5_addr_o, s5_sel_o, s5_we_o, s5_cyc_o, s5_stb_o, s6_data_o, s6_addr_o, s6_sel_o, s6_we_o, s6_cyc_o, s6_stb_o,
         s7_data_o, s7_addr_o, s7_sel_o, s7_we_o, s7_cyc_o, s7_stb_o, s8_data_o, s8_addr_o, s8_sel_o, s8_we_o, s8_cyc_o, s8_stb_o,
         s9_data_o, s9_addr_o, s9_sel_o, s9_we_o, s9_cyc_o, s9_stb_o, s10_data_o, s10_addr_o, s10_sel_o, s10_we_o, s10_cyc_o, s10_stb_o,
         s11_data_o, s11_addr_o, s11_sel_o, s11_we_o, s11_cyc_o, s11_stb_o, s12_data_o, s12_addr_o, s12_sel_o, s12_we_o, s12_cyc_o, s12_stb_o,
         s13_data_o, s13_addr_o, s13_sel_o, s13_we_o, s13_cyc_o, s13_stb_o, s14_data_o, s14_addr_o, s14_sel_o, s14_we_o, s14_cyc_o, s14_stb_o,
         s15_data_o, s15_addr_o, s15_sel_o, s15_we_o, s15_cyc_o, s15_stb_o) begin

    s0_data_i  = 'b0;
    s0_ack_i   = 'b0;
    s0_err_i   = 'b0;
    s0_rty_i   = 'b0;
    s1_data_i  = 'b0;
    s1_ack_i   = 'b0;
    s1_err_i   = 'b0;
    s1_rty_i   = 'b0;
    s2_data_i  = 'b0;
    s2_ack_i   = 'b0;
    s2_err_i   = 'b0;
    s2_rty_i   = 'b0;
    s3_data_i  = 'b0;
    s3_ack_i   = 'b0;
    s3_err_i   = 'b0;
    s3_rty_i   = 'b0;
    s4_data_i  = 'b0;
    s4_ack_i   = 'b0;
    s4_err_i   = 'b0;
    s4_rty_i   = 'b0;
    s5_data_i  = 'b0;
    s5_ack_i   = 'b0;
    s5_err_i   = 'b0;
    s5_rty_i   = 'b0;
    s6_data_i  = 'b0;
    s6_ack_i   = 'b0;
    s6_err_i   = 'b0;
    s6_rty_i   = 'b0;
    s7_data_i  = 'b0;
    s7_ack_i   = 'b0;
    s7_err_i   = 'b0;
    s7_rty_i   = 'b0;
    s8_data_i  = 'b0;
    s8_ack_i   = 'b0;
    s8_err_i   = 'b0;
    s8_rty_i   = 'b0;
    s9_data_i  = 'b0;
    s9_ack_i   = 'b0;
    s9_err_i   = 'b0;
    s9_rty_i   = 'b0;
    s10_data_i = 'b0;
    s10_ack_i  = 'b0;
    s10_err_i  = 'b0;
    s10_rty_i  = 'b0;
    s11_data_i = 'b0;
    s11_ack_i  = 'b0;
    s11_err_i  = 'b0;
    s11_rty_i  = 'b0;
    s12_data_i = 'b0;
    s12_ack_i  = 'b0;
    s12_err_i  = 'b0;
    s12_rty_i  = 'b0;
    s13_data_i = 'b0;
    s13_ack_i  = 'b0;
    s13_err_i  = 'b0;
    s13_rty_i  = 'b0;
    s14_data_i = 'b0;
    s14_ack_i  = 'b0;
    s14_err_i  = 'b0;
    s14_rty_i  = 'b0;
    s15_data_i = 'b0;
    s15_ack_i  = 'b0;
    s15_err_i  = 'b0;
    s15_rty_i  = 'b0;
    ts_data_o  = 'b0;
    ts_addr_o  = 'b0;
    ts_sel_o   = 'b0;
    ts_we_o    = 'b0;
    ts_cyc_o   = 'b0;
    ts_stb_o   = 'b0;

    case(slave_select) /*full_case*/
        4'd0: begin
            s0_data_i = ts_data_i;
            s0_ack_i  = ts_ack_i;
            s0_err_i  = ts_err_i;
            s0_rty_i  = ts_rty_i;
            ts_data_o = s0_data_o;
            ts_addr_o = s0_addr_o;
            ts_sel_o  = s0_sel_o;
            ts_we_o   = s0_we_o;
            ts_cyc_o  = s0_cyc_o;
            ts_stb_o  = s0_stb_o;
        end
        4'd1: begin
            s1_data_i = ts_data_i;
            s1_ack_i  = ts_ack_i;
            s1_err_i  = ts_err_i;
            s1_rty_i  = ts_rty_i;
            ts_data_o = s1_data_o;
            ts_addr_o = s1_addr_o;
            ts_sel_o  = s1_sel_o;
            ts_we_o   = s1_we_o;
            ts_cyc_o  = s1_cyc_o;
            ts_stb_o  = s1_stb_o;
        end
        4'd2: begin
            s2_data_i = ts_data_i;
            s2_ack_i  = ts_ack_i;
            s2_err_i  = ts_err_i;
            s2_rty_i  = ts_rty_i;
            ts_data_o = s2_data_o;
            ts_addr_o = s2_addr_o;
            ts_sel_o  = s2_sel_o;
            ts_we_o   = s2_we_o;
            ts_cyc_o  = s2_cyc_o;
            ts_stb_o  = s2_stb_o;
        end
        4'd3: begin
            s3_data_i = ts_data_i;
            s3_ack_i  = ts_ack_i;
            s3_err_i  = ts_err_i;
            s3_rty_i  = ts_rty_i;
            ts_data_o = s3_data_o;
            ts_addr_o = s3_addr_o;
            ts_sel_o  = s3_sel_o;
            ts_we_o   = s3_we_o;
            ts_cyc_o  = s3_cyc_o;
            ts_stb_o  = s3_stb_o;
        end
        4'd4: begin
            s4_data_i = ts_data_i;
            s4_ack_i  = ts_ack_i;
            s4_err_i  = ts_err_i;
            s4_rty_i  = ts_rty_i;
            ts_data_o = s4_data_o;
            ts_addr_o = s4_addr_o;
            ts_sel_o  = s4_sel_o;
            ts_we_o   = s4_we_o;
            ts_cyc_o  = s4_cyc_o;
            ts_stb_o  = s4_stb_o;
        end
        4'd5: begin
            s5_data_i = ts_data_i;
            s5_ack_i  = ts_ack_i;
            s5_err_i  = ts_err_i;
            s5_rty_i  = ts_rty_i;
            ts_data_o = s5_data_o;
            ts_addr_o = s5_addr_o;
            ts_sel_o  = s5_sel_o;
            ts_we_o   = s5_we_o;
            ts_cyc_o  = s5_cyc_o;
            ts_stb_o  = s5_stb_o;
        end
        4'd6: begin
            s6_data_i = ts_data_i;
            s6_ack_i  = ts_ack_i;
            s6_err_i  = ts_err_i;
            s6_rty_i  = ts_rty_i;
            ts_data_o = s6_data_o;
            ts_addr_o = s6_addr_o;
            ts_sel_o  = s6_sel_o;
            ts_we_o   = s6_we_o;
            ts_cyc_o  = s6_cyc_o;
            ts_stb_o  = s6_stb_o;
        end
        4'd7: begin
            s7_data_i = ts_data_i;
            s7_ack_i  = ts_ack_i;
            s7_err_i  = ts_err_i;
            s7_rty_i  = ts_rty_i;
            ts_data_o = s7_data_o;
            ts_addr_o = s7_addr_o;
            ts_sel_o  = s7_sel_o;
            ts_we_o   = s7_we_o;
            ts_cyc_o  = s7_cyc_o;
            ts_stb_o  = s7_stb_o;
        end
        4'd8: begin
            s8_data_i = ts_data_i;
            s8_ack_i  = ts_ack_i;
            s8_err_i  = ts_err_i;
            s8_rty_i  = ts_rty_i;
            ts_data_o = s8_data_o;
            ts_addr_o = s8_addr_o;
            ts_sel_o  = s8_sel_o;
            ts_we_o   = s8_we_o;
            ts_cyc_o  = s8_cyc_o;
            ts_stb_o  = s8_stb_o;
        end
        4'd9: begin
            s9_data_i = ts_data_i;
            s9_ack_i  = ts_ack_i;
            s9_err_i  = ts_err_i;
            s9_rty_i  = ts_rty_i;
            ts_data_o = s9_data_o;
            ts_addr_o = s9_addr_o;
            ts_sel_o  = s9_sel_o;
            ts_we_o   = s9_we_o;
            ts_cyc_o  = s9_cyc_o;
            ts_stb_o  = s9_stb_o;
        end
        4'd10: begin
            s10_data_i = ts_data_i;
            s10_ack_i  = ts_ack_i;
            s10_err_i  = ts_err_i;
            s10_rty_i  = ts_rty_i;
            ts_data_o  = s10_data_o;
            ts_addr_o  = s10_addr_o;
            ts_sel_o   = s10_sel_o;
            ts_we_o    = s10_we_o;
            ts_cyc_o   = s10_cyc_o;
            ts_stb_o   = s10_stb_o;
        end
        4'd11: begin
            s11_data_i = ts_data_i;
            s11_ack_i  = ts_ack_i;
            s11_err_i  = ts_err_i;
            s11_rty_i  = ts_rty_i;
            ts_data_o  = s11_data_o;
            ts_addr_o  = s11_addr_o;
            ts_sel_o   = s11_sel_o;
            ts_we_o    = s11_we_o;
            ts_cyc_o   = s11_cyc_o;
            ts_stb_o   = s11_stb_o;
        end
        4'd12: begin
            s12_data_i = ts_data_i;
            s12_ack_i  = ts_ack_i;
            s12_err_i  = ts_err_i;
            s12_rty_i  = ts_rty_i;
            ts_data_o  = s12_data_o;
            ts_addr_o  = s12_addr_o;
            ts_sel_o   = s12_sel_o;
            ts_we_o    = s12_we_o;
            ts_cyc_o   = s12_cyc_o;
            ts_stb_o   = s12_stb_o;
        end
        4'd13: begin
            s13_data_i = ts_data_i;
            s13_ack_i  = ts_ack_i;
            s13_err_i  = ts_err_i;
            s13_rty_i  = ts_rty_i;
            ts_data_o  = s13_data_o;
            ts_addr_o  = s13_addr_o;
            ts_sel_o   = s13_sel_o;
            ts_we_o    = s13_we_o;
            ts_cyc_o   = s13_cyc_o;
            ts_stb_o   = s13_stb_o;
        end
        4'd14: begin
            s14_data_i = ts_data_i;
            s14_ack_i  = ts_ack_i;
            s14_err_i  = ts_err_i;
            s14_rty_i  = ts_rty_i;
            ts_data_o  = s14_data_o;
            ts_addr_o  = s14_addr_o;
            ts_sel_o   = s14_sel_o;
            ts_we_o    = s14_we_o;
            ts_cyc_o   = s14_cyc_o;
            ts_stb_o   = s14_stb_o;
        end
        4'd15: begin
            s15_data_i = ts_data_i;
            s15_ack_i  = ts_ack_i;
            s15_err_i  = ts_err_i;
            s15_rty_i  = ts_rty_i;
            ts_data_o  = s15_data_o;
            ts_addr_o  = s15_addr_o;
            ts_sel_o   = s15_sel_o;
            ts_we_o    = s15_we_o;
            ts_cyc_o   = s15_cyc_o;
            ts_stb_o   = s15_stb_o;
        end
    endcase

end

 wb_conmax_top top_wrappper (
	clk_i, rst_i,

	// Master 0 Interface
	m0_data_i, m0_data_o, m0_addr_i, m0_sel_i, m0_we_i, m0_cyc_i,
	m0_stb_i, m0_ack_o, m0_err_o, m0_rty_o,

	// Master 1 Interface
	m1_data_i, m1_data_o, m1_addr_i, m1_sel_i, m1_we_i, m1_cyc_i,
	m1_stb_i, m1_ack_o, m1_err_o, m1_rty_o,

	// Master 2 Interface
	m2_data_i, m2_data_o, m2_addr_i, m2_sel_i, m2_we_i, m2_cyc_i,
	m2_stb_i, m2_ack_o, m2_err_o, m2_rty_o,

	// Master 3 Interface
	m3_data_i, m3_data_o, m3_addr_i, m3_sel_i, m3_we_i, m3_cyc_i,
	m3_stb_i, m3_ack_o, m3_err_o, m3_rty_o,

	// Master 4 Interface
	m4_data_i, m4_data_o, m4_addr_i, m4_sel_i, m4_we_i, m4_cyc_i,
	m4_stb_i, m4_ack_o, m4_err_o, m4_rty_o,

	// Master 5 Interface
	m5_data_i, m5_data_o, m5_addr_i, m5_sel_i, m5_we_i, m5_cyc_i,
	m5_stb_i, m5_ack_o, m5_err_o, m5_rty_o,

	// Master 6 Interface
	m6_data_i, m6_data_o, m6_addr_i, m6_sel_i, m6_we_i, m6_cyc_i,
	m6_stb_i, m6_ack_o, m6_err_o, m6_rty_o,

	// Master 7 Interface
	m7_data_i, m7_data_o, m7_addr_i, m7_sel_i, m7_we_i, m7_cyc_i,
	m7_stb_i, m7_ack_o, m7_err_o, m7_rty_o,

	// Slave 0 Interface
	s0_data_i, s0_data_o, s0_addr_o, s0_sel_o, s0_we_o, s0_cyc_o,
	s0_stb_o, s0_ack_i, s0_err_i, s0_rty_i,

	// Slave 1 Interface
	s1_data_i, s1_data_o, s1_addr_o, s1_sel_o, s1_we_o, s1_cyc_o,
	s1_stb_o, s1_ack_i, s1_err_i, s1_rty_i,

	// Slave 2 Interface
	s2_data_i, s2_data_o, s2_addr_o, s2_sel_o, s2_we_o, s2_cyc_o,
	s2_stb_o, s2_ack_i, s2_err_i, s2_rty_i,

	// Slave 3 Interface
	s3_data_i, s3_data_o, s3_addr_o, s3_sel_o, s3_we_o, s3_cyc_o,
	s3_stb_o, s3_ack_i, s3_err_i, s3_rty_i,

	// Slave 4 Interface
	s4_data_i, s4_data_o, s4_addr_o, s4_sel_o, s4_we_o, s4_cyc_o,
	s4_stb_o, s4_ack_i, s4_err_i, s4_rty_i,

	// Slave 5 Interface
	s5_data_i, s5_data_o, s5_addr_o, s5_sel_o, s5_we_o, s5_cyc_o,
	s5_stb_o, s5_ack_i, s5_err_i, s5_rty_i,

	// Slave 6 Interface
	s6_data_i, s6_data_o, s6_addr_o, s6_sel_o, s6_we_o, s6_cyc_o,
	s6_stb_o, s6_ack_i, s6_err_i, s6_rty_i,

	// Slave 7 Interface
	s7_data_i, s7_data_o, s7_addr_o, s7_sel_o, s7_we_o, s7_cyc_o,
	s7_stb_o, s7_ack_i, s7_err_i, s7_rty_i,

	// Slave 8 Interface
	s8_data_i, s8_data_o, s8_addr_o, s8_sel_o, s8_we_o, s8_cyc_o,
	s8_stb_o, s8_ack_i, s8_err_i, s8_rty_i,

	// Slave 9 Interface
	s9_data_i, s9_data_o, s9_addr_o, s9_sel_o, s9_we_o, s9_cyc_o,
	s9_stb_o, s9_ack_i, s9_err_i, s9_rty_i,

	// Slave 10 Interface
	s10_data_i, s10_data_o, s10_addr_o, s10_sel_o, s10_we_o, s10_cyc_o,
	s10_stb_o, s10_ack_i, s10_err_i, s10_rty_i,

	// Slave 11 Interface
	s11_data_i, s11_data_o, s11_addr_o, s11_sel_o, s11_we_o, s11_cyc_o,
	s11_stb_o, s11_ack_i, s11_err_i, s11_rty_i,

	// Slave 12 Interface
	s12_data_i, s12_data_o, s12_addr_o, s12_sel_o, s12_we_o, s12_cyc_o,
	s12_stb_o, s12_ack_i, s12_err_i, s12_rty_i,

	// Slave 13 Interface
	s13_data_i, s13_data_o, s13_addr_o, s13_sel_o, s13_we_o, s13_cyc_o,
	s13_stb_o, s13_ack_i, s13_err_i, s13_rty_i,

	// Slave 14 Interface
	s14_data_i, s14_data_o, s14_addr_o, s14_sel_o, s14_we_o, s14_cyc_o,
	s14_stb_o, s14_ack_i, s14_err_i, s14_rty_i,

	// Slave 15 Interface
	s15_data_i, s15_data_o, s15_addr_o, s15_sel_o, s15_we_o, s15_cyc_o,
	s15_stb_o, s15_ack_i, s15_err_i, s15_rty_i
	);

endmodule