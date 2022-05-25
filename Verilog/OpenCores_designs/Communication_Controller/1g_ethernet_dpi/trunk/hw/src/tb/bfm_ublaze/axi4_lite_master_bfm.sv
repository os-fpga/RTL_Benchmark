//////////////////////////////////////////////////////////////////////////////////
// Company:         ;)
// Engineer:        IK
// 
// Create Date:     11:35:01 03/21/2013 
// Design Name:     
// Module Name:     axi4_lite_master_bfm
// Project Name:    
// Target Devices:  
// Tool versions:   
// Description:     
//                  USAGE:
//                      READ()
//                      WRITE()
//                  
//                  
// Revision: 
// Revision 0.01 - File Created,
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

module axi4_lite_master_bfm #
(
parameter   p_ADDRESS_BUS_WIDTH         =   32,
parameter   p_DATA_BUS_WIDTH            =   32,
parameter   p_AXI4_LITE_PROT_BUS_WIDTH  =    3,
parameter   p_AXI4_LITE_RESP_BUS_WIDTH  =    2, 
parameter   p_RESPONSE_TIMEOUT          =   64
)
(
    // SYS_CON
    input   ACLK,
    input   ARESETn,
    //
    // Write Address Channel Signals
    output logic [p_ADDRESS_BUS_WIDTH-1:0]          AWADDR, // Master Write address
    output logic [p_AXI4_LITE_PROT_BUS_WIDTH-1:0]   AWPROT, // Master Protection type
    output logic                                    AWVALID,// Master Write address valid
    input                                           AWREADY,// Slave Write address ready
    // Write Data Channel Signals
    output logic [p_DATA_BUS_WIDTH-1:0]             WDATA,  // Master Write data
    output logic [(p_DATA_BUS_WIDTH/8)-1:0]         WSTRB,  // Master Write strobes
    output logic                                    WVALID, // Master Write valid
    input                                           WREADY, // Slave Write ready
    // Write Response Channel Signals
    input        [p_AXI4_LITE_RESP_BUS_WIDTH-1:0]   BRESP,  // Slave Write response
    input                                           BVALID, // Slave Write response valid
    output logic                                    BREADY, // Master Response ready
    //
    // Read Address Channel Signals
    output logic [p_ADDRESS_BUS_WIDTH-1:0]          ARADDR, // Master Read address
    output logic [p_AXI4_LITE_PROT_BUS_WIDTH-1:0]   ARPROT, // Master Protection type
    output logic                                    ARVALID,// Master Read address valid
    input                                           ARREADY,// Slave Read address ready
    // Read Data Channel Signals
    input        [p_DATA_BUS_WIDTH-1:0]             RDATA,  // Slave Read data
    input        [p_AXI4_LITE_RESP_BUS_WIDTH-1:0]   RRESP,  // Slave Read response
    input                                           RVALID, // Slave Read valid
    output logic                                    RREADY  // Master Read ready
);
//////////////////////////////////////////////////////////////////////////////////
    // AXI-internals
    int timeout_counter;
    
//////////////////////////////////////////////////////////////////////////////////
//
// BFM CLOCKING
//
default clocking cb @(posedge ACLK);
    input #1ns AWREADY, WREADY, BVALID;
    input #1ns ARREADY, RVALID, RDATA, RRESP;
endclocking : cb
//////////////////////////////////////////////////////////////////////////////////
//
// Initialize AXI-signals/internals
//
initial
begin   :   INIT
    // axi-signals
    AWADDR = 0;
    AWPROT = 0; // !!!
    AWVALID = 0;
    WDATA = 0;
    WSTRB = 0;
    WVALID = 0;
    BREADY = 0;
    
    ARADDR = 0;
    ARPROT = 0; // !!!
    ARVALID = 0;
    RREADY = 0;
    // axi-internal
    timeout_counter = 0;
    // Final
end
//////////////////////////////////////////////////////////////////////////////////
//
// AXI4-LITE READ
//
task READ ( input   [p_ADDRESS_BUS_WIDTH-1:0]           iv_addr,
            output  [p_DATA_BUS_WIDTH-1:0]              ov_data,
            output  [p_AXI4_LITE_RESP_BUS_WIDTH-1:0]    ov_resp);
    // addr
    PROC_RADDR(iv_addr);
    // data
    PROC_RDATA(ov_data, ov_resp);
    // Final
endtask : READ
//////////////////////////////////////////////////////////////////////////////////
//
// AXI4-LITE WRITE
//
task WRITE (input   [p_ADDRESS_BUS_WIDTH-1:0]           iv_addr,
            input   [p_DATA_BUS_WIDTH-1:0]              iv_data,
            input   [(p_DATA_BUS_WIDTH/8)-1:0]          iv_be,
            output  [p_AXI4_LITE_RESP_BUS_WIDTH-1:0]    ov_resp);
    // addr
    PROC_WADDR(iv_addr);
    // data
    PROC_WDATA(iv_data, iv_be);
    // resp
    PROC_WRESP(ov_resp);
    // Final
endtask : WRITE
//////////////////////////////////////////////////////////////////////////////////
//
// SUPPORT: READ()
//
task PROC_RADDR(input [p_ADDRESS_BUS_WIDTH-1:0] iv_addr);
    // 
    // #0 - Drive the Read Address Channel with ARVALID asserted
    ARADDR <= iv_addr;
    ARPROT <= 0; // !!!TBD
    ARVALID <= 1;
    // #1 - Wait for handshake on the next clk edge
    do begin @cb; end
    while (cb.ARREADY == 0);
    // #2 - de-assert ARVALID
    ARVALID <= 0;
    // #3 - clr on exit
    //ARADDR <= 0;
    ARPROT <= 0; @cb;
    // Final
endtask : PROC_RADDR

task PROC_RDATA(output [p_DATA_BUS_WIDTH-1:0] ov_data, output [p_AXI4_LITE_RESP_BUS_WIDTH-1:0] ov_resp);
    //
    // #0 - Drive RREADY and Wait for RVALID to be asserted
    timeout_counter = 0;
    RREADY <= 1;
    do begin : RDATA_RVALID
        @cb;
        // t-out check
        if (timeout_counter++ == p_RESPONSE_TIMEOUT)
            begin : TOUT
                $display("[%t]: %m: READ DATA transfer ERROR!!!", $time);
                $stop;
            end
        
    end while (cb.RVALID == 0);
    // #1 - sample RDATA and RRESP
    ov_data = cb.RDATA;
    ov_resp = cb.RRESP;
    // #2 - check RRESP
    if (ov_resp) // {RRESP_OK == 0}
        begin   :   RRESP
            $display("[%t]: %m: READ DATA transfer ERROR!!!", $time);
            $stop;
        end
    // #3 - if RRESP == OK, then de-assert RREADY
    RREADY <= 0;
    // Final
endtask : PROC_RDATA
//////////////////////////////////////////////////////////////////////////////////
//
// SUPPORT: WRITE()
//
task PROC_WADDR(input [p_ADDRESS_BUS_WIDTH-1:0] iv_addr);
    // 
    // #0 - Drive the Write Address Channel with AWVALID asserted
    AWADDR <= iv_addr;
    AWPROT <= 0; // !!!TBD
    AWVALID <= 1;
    // #1 - Wait for handshake on the next clk edge
    @cb;
    while (cb.AWREADY == 0) @cb;
    // #2 - de-assert AWVALID
    AWVALID <= 0;
    // Final
endtask : PROC_WADDR

task PROC_WDATA(input [p_DATA_BUS_WIDTH-1:0] iv_data, input [(p_DATA_BUS_WIDTH/8)-1:0] iv_be);
    // 
    // #0 - Drive the Write Data Channel with WVALID asserted
    WSTRB <= iv_be;
    WDATA <= iv_data;
    WVALID <= 1;
    // #1 - Wait for handshake on the next clk edge
    @cb;
    while (cb.WREADY == 0) @cb;
    // #2 - de-assert WVALID
    WVALID <= 0;
    // #3 - clr on exit
    //WSTRB <= 0;
    //WDATA <= 0; 
    @cb;
    // Final
endtask : PROC_WDATA

task PROC_WRESP(output [p_AXI4_LITE_RESP_BUS_WIDTH-1:0] ov_resp);
    //
    // #0 - Drive BREADY and Wait for BVALID to be asserted
    timeout_counter = 0;
    BREADY <= 1;
    do begin : WRESP_BVALID
        @cb;
        // t-out check
        if (timeout_counter++ == p_RESPONSE_TIMEOUT)
            begin : TOUT
                $display("[%t]: %m: WRITE RESPONSE transfer ERROR!!!", $time);
                $stop;
            end
    end while(cb.BVALID == 0);
    // #1 - Sample the BRESP signal
    ov_resp = BRESP;
    // #2 - check RRESP
    if (ov_resp) // {BRESP_OK == 0}
        begin   :   RRESP
            $display("[%t]: %m: WRITE RESPONSE transfer ERROR!!!", $time);
            $stop;
        end
    // #3 - if BRESP == OK, then de-assert BREADY
    BREADY <= 0;
    // Final
endtask : PROC_WRESP
//////////////////////////////////////////////////////////////////////////////////
endmodule
