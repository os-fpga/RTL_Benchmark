//=============================================
// Function  : Synchronous (single clock) FIFO
//             With Assertion
// Coder     : Deepak Kumar Tala
// Date      : 1-Nov-2005
//=============================================
// synopsys translate_off
`define OVL_ASSERT_ON
`define OVL_INIT_MSG
`include "assert_fifo_index.vlib"
`include "assert_always.vlib"
`include "assert_never.vlib"
`include "assert_increment.vlib"
// synopsys translate_on
module syn_fifo (
clk      , // Clock input
rst      , // Active high reset
wr_cs    , // Write chip select
rd_cs    , // Read chipe select
data_in  , // Data input
rd_en    , // Read enable
wr_en    , // Write Enable
data_out , // Data Output
empty    , // FIFO empty
full       // FIFO full
);    
 
// FIFO constants
parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;
parameter RAM_DEPTH = (1 << ADDR_WIDTH);
// Port Declarations
input clk ;
input rst ;
input wr_cs ;
input rd_cs ;
input rd_en ;
input wr_en ;
input [DATA_WIDTH-1:0] data_in ;
output full ;
output empty ;
output [DATA_WIDTH-1:0] data_out ;

//-----------Internal variables-------------------
reg [ADDR_WIDTH-1:0] wr_pointer;
reg [ADDR_WIDTH-1:0] rd_pointer;
reg [ADDR_WIDTH :0] status_cnt;
reg [DATA_WIDTH-1:0] data_out ;
wire [DATA_WIDTH-1:0] data_ram ;

//-----------Variable assignments---------------
assign full = (status_cnt == (RAM_DEPTH-1));
assign empty = (status_cnt == 0);

//-----------Code Start---------------------------
always @ (posedge clk or posedge rst)
begin : WRITE_POINTER
  if (rst) begin
   wr_pointer <= 0;
  end else if (wr_cs && wr_en ) begin
   wr_pointer <= wr_pointer + 1;
  end
end

always @ (posedge clk or posedge rst)
begin : READ_POINTER
  if (rst) begin
    rd_pointer <= 0;
  end else if (rd_cs && rd_en ) begin
    rd_pointer <= rd_pointer + 1;
  end
end

always  @ (posedge clk or posedge rst)
begin : READ_DATA
  if (rst) begin
    data_out <= 0;
  end else if (rd_cs && rd_en ) begin
    data_out <= data_ram;
  end
end

always @ (posedge clk or posedge rst)
begin : STATUS_COUNTER
  if (rst) begin
    status_cnt <= 0;
  // Read but no write.
  end else if ((rd_cs && rd_en) && !(wr_cs && wr_en) 
                && (status_cnt != 0)) begin
    status_cnt <= status_cnt - 1;
  // Write but no read.
  end else if ((wr_cs && wr_en) && !(rd_cs && rd_en) 
               && (status_cnt != RAM_DEPTH)) begin
    status_cnt <= status_cnt + 1;
  end
end
   
ram_dp_ar_aw #(DATA_WIDTH,ADDR_WIDTH) DP_RAM (
.address_0 (wr_pointer) , // address_0 input 
.data_0    (data_in)    , // data_0 bi-directional
.cs_0      (wr_cs)      , // chip select
.we_0      (wr_en)      , // write enable
.oe_0      (1'b0)       , // output enable
.address_1 (rd_pointer) , // address_q input
.data_1    (data_ram)   , // data_1 bi-directional
.cs_1      (rd_cs)      , // chip select
.we_1      (1'b0)       , // Read enable
.oe_1      (rd_en)        // output enable
);  

// Add assertion here
// synopsys translate_off
// Assertion to check overflow and underflow
assert_fifo_index #(
`OVL_ERROR      , // severity_level
(RAM_DEPTH-1)   , // depth
1               , // push width
1               , // pop width
`OVL_ASSERT     , // property type
"my_module_err" , // msg
`OVL_COVER_NONE , //coverage_level
1) no_over_under_flow (
.clk     (clk),           // Clock
.reset_n (~rst),          // Active low reset
.pop     (rd_cs & rd_en), // FIFO Write
.push    (wr_cs & wr_en)  // FIFO Read
);

// Assertion to check full and write
assert_always #(
`OVL_ERROR       , // severity_level
`OVL_ASSERT      , // property_type
"fifo_full_write", // msg
`OVL_COVER_NONE    // coverage_level
) no_full_write (
.clk       (clk),
.reset_n   (~rst),
.test_expr (!(full && wr_cs && wr_en))
);

// Assertion to check empty and read
assert_never #(
`OVL_ERROR       , // severity_level
`OVL_ASSERT      , // property_type
"fifo_empty_read", // msg
`OVL_COVER_NONE    // coverage_level
) no_empty_read (
.clk       (clk),
.reset_n   (~rst),
.test_expr ((empty && rd_cs && rd_en))
);

// Assertion to check if write pointer increments by just one
assert_increment #(
`OVL_ERROR            , // severity_level
ADDR_WIDTH            , // width
1                     , // value 
`OVL_ASSERT           , // property_typ 
"Write_Pointer_Error" , // msg 
`OVL_COVER_NONE         // coverage_level
) write_count ( 
.clk         (clk), 
.reset_n     (~rst),
.test_expr   (wr_pointer)
); 
// synopsys translate_on
endmodule
