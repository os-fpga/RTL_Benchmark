`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:49:15 11/02/2011 
// Design Name: 
// Module Name:    spiwrap 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module spiloop(
    input Reset,
    input SysClk,
    input spi_ss,
    input spi_mosi,
    input spi_clk,
    output spi_miso,
    output [7:0] leds
    );

wire [7:0]  debug_out;
wire [11:0] txMemAddr;
wire [7:0]  txMemData;
wire [11:0] rcMemAddr;
wire [7:0]  rcMemData;
wire        rcMemWE;

wire [3:0]  regAddr;
wire [31:0] regWriteData;
wire        regWE;
reg  [31:0] regReadData_wreg;
reg  [31:0] regbank [0:15];

always @(*) begin                 // Read reg
  regReadData_wreg <= regbank[regAddr];
end
always @(posedge SysClk) begin    // Write reg
  if (regWE) begin
    regbank[regAddr] <= regWriteData;
  end
end

spiloopmem your_instance_name (
  .clka(SysClk), // input clka
  .ena(1'b1), // input ena
  .wea(rcMemWE), // input [0 : 0] wea
  .addra(rcMemAddr), // input [11 : 0] addra
  .dina(rcMemData), // input [7 : 0] dina
  .clkb(SysClk), // input clkb
  .enb(1'b1), // input enb
  .addrb(txMemAddr), // input [11 : 0] addrb
  .doutb(txMemData) // output [7 : 0] doutb
);

spiifc mySpiIfc (
  .Reset(Reset),
  .SysClk(SysClk),
  .SPI_CLK(spi_clk),
  .SPI_MISO(spi_miso),
  .SPI_MOSI(spi_mosi),
  .SPI_SS(spi_ss),
  .txMemAddr(txMemAddr),
  .txMemData(txMemData),
  .rcMemAddr(rcMemAddr),
  .rcMemData(rcMemData),
  .rcMemWE(rcMemWE),
 // .regAddr(regAddr),
 // .regReadData(regReadData_wreg),
//  .regWriteData(regWriteData),
//  .regWriteEn(regWE),
  .debug_out(debug_out)
);

//assign leds = debug_out ;
assign leds = txMemData;

endmodule


module spiloopmem(
  clka,
  ena,
  wea,
  addra,
  dina,
  clkb,
  enb,
  addrb,
  doutb
);

input clka;
input ena;
input [0 : 0] wea;
input [11 : 0] addra;
input [7 : 0] dina;
input clkb;
input enb;
input [11 : 0] addrb;
output [7 : 0] doutb;

// synthesis translate_off

  BLK_MEM_GEN_V6_2 #(
    .C_ADDRA_WIDTH(12),
    .C_ADDRB_WIDTH(12),
    .C_ALGORITHM(1),
    .C_AXI_ID_WIDTH(4),
    .C_AXI_SLAVE_TYPE(0),
    .C_AXI_TYPE(1),
    .C_BYTE_SIZE(9),
    .C_COMMON_CLK(0),
    .C_DEFAULT_DATA("0"),
    .C_DISABLE_WARN_BHV_COLL(0),
    .C_DISABLE_WARN_BHV_RANGE(0),
    .C_FAMILY("spartan6"),
    .C_HAS_AXI_ID(0),
    .C_HAS_ENA(1),
    .C_HAS_ENB(1),
    .C_HAS_INJECTERR(0),
    .C_HAS_MEM_OUTPUT_REGS_A(0),
    .C_HAS_MEM_OUTPUT_REGS_B(0),
    .C_HAS_MUX_OUTPUT_REGS_A(0),
    .C_HAS_MUX_OUTPUT_REGS_B(0),
    .C_HAS_REGCEA(0),
    .C_HAS_REGCEB(0),
    .C_HAS_RSTA(0),
    .C_HAS_RSTB(0),
    .C_HAS_SOFTECC_INPUT_REGS_A(0),
    .C_HAS_SOFTECC_OUTPUT_REGS_B(0),
    .C_INIT_FILE_NAME("no_coe_file_loaded"),
    .C_INITA_VAL("0"),
    .C_INITB_VAL("0"),
    .C_INTERFACE_TYPE(0),
    .C_LOAD_INIT_FILE(0),
    .C_MEM_TYPE(1),
    .C_MUX_PIPELINE_STAGES(0),
    .C_PRIM_TYPE(1),
    .C_READ_DEPTH_A(4096),
    .C_READ_DEPTH_B(4096),
    .C_READ_WIDTH_A(8),
    .C_READ_WIDTH_B(8),
    .C_RST_PRIORITY_A("CE"),
    .C_RST_PRIORITY_B("CE"),
    .C_RST_TYPE("SYNC"),
    .C_RSTRAM_A(0),
    .C_RSTRAM_B(0),
    .C_SIM_COLLISION_CHECK("ALL"),
    .C_USE_BYTE_WEA(0),
    .C_USE_BYTE_WEB(0),
    .C_USE_DEFAULT_DATA(0),
    .C_USE_ECC(0),
    .C_USE_SOFTECC(0),
    .C_WEA_WIDTH(1),
    .C_WEB_WIDTH(1),
    .C_WRITE_DEPTH_A(4096),
    .C_WRITE_DEPTH_B(4096),
    .C_WRITE_MODE_A("WRITE_FIRST"),
    .C_WRITE_MODE_B("WRITE_FIRST"),
    .C_WRITE_WIDTH_A(8),
    .C_WRITE_WIDTH_B(8),
    .C_XDEVICEFAMILY("spartan6")
  )
  inst (
    .CLKA(clka),
    .ENA(ena),
    .WEA(wea),
    .ADDRA(addra),
    .DINA(dina),
    .CLKB(clkb),
    .ENB(enb),
    .ADDRB(addrb),
    .DOUTB(doutb),
    .RSTA(),
    .REGCEA(),
    .DOUTA(),
    .RSTB(),
    .REGCEB(),
    .WEB(),
    .DINB(),
    .INJECTSBITERR(),
    .INJECTDBITERR(),
    .SBITERR(),
    .DBITERR(),
    .RDADDRECC(),
    .S_ACLK(),
    .S_ARESETN(),
    .S_AXI_AWID(),
    .S_AXI_AWADDR(),
    .S_AXI_AWLEN(),
    .S_AXI_AWSIZE(),
    .S_AXI_AWBURST(),
    .S_AXI_AWVALID(),
    .S_AXI_AWREADY(),
    .S_AXI_WDATA(),
    .S_AXI_WSTRB(),
    .S_AXI_WLAST(),
    .S_AXI_WVALID(),
    .S_AXI_WREADY(),
    .S_AXI_BID(),
    .S_AXI_BRESP(),
    .S_AXI_BVALID(),
    .S_AXI_BREADY(),
    .S_AXI_ARID(),
    .S_AXI_ARADDR(),
    .S_AXI_ARLEN(),
    .S_AXI_ARSIZE(),
    .S_AXI_ARBURST(),
    .S_AXI_ARVALID(),
    .S_AXI_ARREADY(),
    .S_AXI_RID(),
    .S_AXI_RDATA(),
    .S_AXI_RRESP(),
    .S_AXI_RLAST(),
    .S_AXI_RVALID(),
    .S_AXI_RREADY(),
    .S_AXI_INJECTSBITERR(),
    .S_AXI_INJECTDBITERR(),
    .S_AXI_SBITERR(),
    .S_AXI_DBITERR(),
    .S_AXI_RDADDRECC()
  );

// synthesis translate_on

endmodule