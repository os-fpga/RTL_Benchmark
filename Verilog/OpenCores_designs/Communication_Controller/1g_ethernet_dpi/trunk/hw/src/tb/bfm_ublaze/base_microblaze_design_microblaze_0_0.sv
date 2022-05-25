//ENTITY base_microblaze_design_microblaze_0_0
module base_microblaze_design_microblaze_0_0
(
    input   Clk ,// IN STD_LOGIC;
    input   Reset ,// IN STD_LOGIC;
    input   Interrupt ,// IN STD_LOGIC;
    input   [0:31]  Interrupt_Address ,// IN STD_LOGIC_VECTOR(0 TO 31);
    output  [0: 1]  Interrupt_Ack ,// OUT STD_LOGIC_VECTOR(0 TO 1);
    output  [0:31]  Instr_Addr ,// OUT STD_LOGIC_VECTOR(0 TO 31);
    input   [0:31]  Instr ,// IN STD_LOGIC_VECTOR(0 TO 31);
    output  IFetch ,// OUT STD_LOGIC;
    output  I_AS ,// OUT STD_LOGIC;
    input   IReady ,// IN STD_LOGIC;
    input   IWAIT ,// IN STD_LOGIC;
    input   ICE ,// IN STD_LOGIC;
    input   IUE ,// IN STD_LOGIC;
    output  [0:31]  Data_Addr ,// OUT STD_LOGIC_VECTOR(0 TO 31);
    output  [0:31]  Data_Read ,// IN STD_LOGIC_VECTOR(0 TO 31);
    output  [0:31]  Data_Write ,// OUT STD_LOGIC_VECTOR(0 TO 31);
    output  D_AS ,// OUT STD_LOGIC;
    output  Read_Strobe ,// OUT STD_LOGIC;
    output  Write_Strobe ,// OUT STD_LOGIC;
    input   DReady ,// IN STD_LOGIC;
    input   DWait ,// IN STD_LOGIC;
    input   DCE ,// IN STD_LOGIC;
    input   DUE ,// IN STD_LOGIC;
    output  [0:3]   Byte_Enable ,// OUT STD_LOGIC_VECTOR(0 TO 3);
    
    output  [31:0]  M_AXI_DP_AWADDR ,// OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    output  [ 2:0]  M_AXI_DP_AWPROT ,// OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    output          M_AXI_DP_AWVALID ,// OUT STD_LOGIC;
    input           M_AXI_DP_AWREADY ,// IN STD_LOGIC;
    output  [31:0]  M_AXI_DP_WDATA ,// OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    output  [ 3:0]  M_AXI_DP_WSTRB ,// OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    output          M_AXI_DP_WVALID ,// OUT STD_LOGIC;
    input           M_AXI_DP_WREADY ,// IN STD_LOGIC;
    input   [ 1:0]  M_AXI_DP_BRESP ,// IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    input           M_AXI_DP_BVALID ,// IN STD_LOGIC;
    output          M_AXI_DP_BREADY ,// OUT STD_LOGIC;
    output  [31:0]  M_AXI_DP_ARADDR ,// OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    output  [ 2:0]  M_AXI_DP_ARPROT ,// OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    output          M_AXI_DP_ARVALID ,// OUT STD_LOGIC;
    input           M_AXI_DP_ARREADY ,// IN STD_LOGIC;
    input   [31:0]  M_AXI_DP_RDATA ,// IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    input   [ 1:0]  M_AXI_DP_RRESP ,// IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    input           M_AXI_DP_RVALID ,// IN STD_LOGIC;
    output          M_AXI_DP_RREADY ,// OUT STD_LOGIC;
    
    input   Dbg_Clk ,// IN STD_LOGIC;
    input   Dbg_TDI ,// IN STD_LOGIC;
    output  Dbg_TDO ,// OUT STD_LOGIC;
    output  [0:7]   Dbg_Reg_En ,// IN STD_LOGIC_VECTOR(0 TO 7);
    input   Dbg_Shift ,// IN STD_LOGIC;
    input   Dbg_Capture ,// IN STD_LOGIC;
    input   Dbg_Update ,// IN STD_LOGIC;
    input   Debug_Rst // IN STD_LOGIC
);
//////////////////////////////////////////////////////////////////////////////////
// axi-req/resp def
import bfm_ublaze_pkg::*;
//////////////////////////////////////////////////////////////////////////////////
    // axi-req/resp mbox
    typedef mailbox#(mailbox_t) mbox_t;
    // ??
    mbox_t axi_req_mailbox = new(1);
    mbox_t axi_resp_mailbox = new(1);
    int axi_trans_idx=0;
    
//////////////////////////////////////////////////////////////////////////////////
//
// SYS-CLK
//
default clocking cb @(posedge Clk);
endclocking : cb
//////////////////////////////////////////////////////////////////////////////////
//
//  AXI4-LITE MASTER BFM
//
axi4_lite_master_bfm // use DEFAULT-params
            U_AXI_BFM
(
// Global Clock Input. All signals are sampled on the rising edge.
.ACLK       (Clk),
// Global Reset Input. Active Low.
.ARESETn    (!Reset),

// Write Address Channel Signals
.AWADDR     (M_AXI_DP_AWADDR),  // Master Write address
.AWPROT     (M_AXI_DP_AWPROT),  // Master Protection type
.AWVALID    (M_AXI_DP_AWVALID), // Master Write address valid
.AWREADY    (M_AXI_DP_AWREADY), // Slave Write address ready

// Write Data Channel Signals
.WDATA      (M_AXI_DP_WDATA),  // Master Write data
.WSTRB      (M_AXI_DP_WSTRB),  // Master Write strobes
.WVALID     (M_AXI_DP_WVALID), // Master Write valid
.WREADY     (M_AXI_DP_WREADY), // Slave Write ready

// Write Response Channel Signals
.BRESP      (M_AXI_DP_BRESP),  // Slave Write response
.BVALID     (M_AXI_DP_BVALID), // Slave Write response valid
.BREADY     (M_AXI_DP_BREADY), // Master Response ready

// Read Address Channel Signals
.ARADDR     (M_AXI_DP_ARADDR),  // Master Read address
.ARPROT     (M_AXI_DP_ARPROT),  // Master Protection type
.ARVALID    (M_AXI_DP_ARVALID), // Master Read address valid
.ARREADY    (M_AXI_DP_ARREADY), // Slave Read address ready

// Read Data Channel Signals
.RDATA      (M_AXI_DP_RDATA),  // Slave Read data
.RRESP      (M_AXI_DP_RRESP),  // Slave Read response
.RVALID     (M_AXI_DP_RVALID), // Slave Read valid
.RREADY     (M_AXI_DP_RREADY)  // Master Read ready
);
//////////////////////////////////////////////////////////////////////////////////
//
// uBLAZE internal AXI logic 
//

initial
begin   :   AXI_LOGIC
    // proc axi-req
    forever
        begin   :   WRK
            @cb; proc_axi_req();
        end
end

task proc_axi_req;
    // declare
    mailbox_t axi_req;
    mailbox_t axi_resp;
    logic [1:0] responce;
    int sv_data;
    // chk-req
    if (axi_req_mailbox.num()) // req-posted by nios2-sw
        begin   :   WRK
            // get-req
            axi_req_mailbox.get(axi_req);
            // proc-cmd
            if (axi_req.trans == READ)
                U_AXI_BFM.READ(axi_req.trans_param.addr, sv_data, responce);
            else // axi_req.trans == WRITE
                U_AXI_BFM.WRITE(axi_req.trans_param.addr, axi_req.trans_param.data, axi_req.trans_param.be, responce);
            // cre resp
            axi_resp.trans = axi_req.trans;
            axi_resp.trans_idx = axi_req.trans_idx;
            axi_resp.trans_param.addr = axi_req.trans_param.addr;
            axi_resp.trans_param.be = axi_req.trans_param.be;
            axi_resp.trans_param.data = (axi_req.trans == READ)? (sv_data) : (-1);
            // post resp
            axi_resp_mailbox.put(axi_resp);
        end
    // Final
endtask : proc_axi_req
//////////////////////////////////////////////////////////////////////////////////
//
// C/CPP-MAIN / uBLAZE-SW
//

// DPC-C import / MAIN
import "DPI-C" context task main();

initial 
begin   :   MAIN
    main();
end
//////////////////////////////////////////////////////////////////////////////////
//
// CPP-HDL AXI routines
//

// DPI-C export / AXI
export "DPI-C" task axi_read;
export "DPI-C" task axi_write;

task automatic axi_read (input int iv_addr, input int iv_be, output int ov_data);
    // declare
    mailbox_t rd_req;
    mailbox_t rd_resp;
    // init-req
    rd_req.trans = READ;
    rd_req.trans_idx = ++axi_trans_idx;
    rd_req.trans_param.addr = iv_addr;
    rd_req.trans_param.be = iv_be;
    rd_req.trans_param.data = -1;
    // post-req
    axi_req_mailbox.put(rd_req); // method places a message in a mailbox
    // wait
    do begin : WAIT_RD_RESP
        // prep
        rd_resp.trans_idx = 0; @cb;
        // chk resp
        if (axi_resp_mailbox.num()) // obtain number of messages in a mailbox
            axi_resp_mailbox.peek(rd_resp); // copies a message from a mailbox without removing the message from the queue.
    end while(rd_resp.trans_idx != rd_req.trans_idx);
    // get rd-data
    axi_resp_mailbox.get(rd_resp); // retrieves a message from a mailbox
    ov_data = rd_resp.trans_param.data;
    //$display("[%t]: %m: iv_addr=%x, ov_data=%x", $time, iv_addr, ov_data);
    // Final
endtask : axi_read

task automatic axi_write (input int iv_addr, input int iv_be, input int iv_data);
    // declare
    mailbox_t wr_req;
    mailbox_t wr_resp;
    // init
    wr_req.trans = WRITE;
    wr_req.trans_idx = ++axi_trans_idx;
    wr_req.trans_param.addr = iv_addr;
    wr_req.trans_param.be = iv_be;
    wr_req.trans_param.data = iv_data;
    // post-req
    axi_req_mailbox.put(wr_req);
    // wait
    do begin : WAIT_WR_RESP
        // prep
        wr_resp.trans_idx = 0; @cb;
        // chk resp
        if (axi_resp_mailbox.num())
            axi_resp_mailbox.peek(wr_resp);
    end while (wr_resp.trans_idx != wr_req.trans_idx);
    axi_resp_mailbox.get(wr_resp); // dummy-read REQ!!!
    // Final
endtask : axi_write
//////////////////////////////////////////////////////////////////////////////////
//
// CPP-HDL sync
//

// DPI-C export / cpp-hdl
export "DPI-C" task ublaze_initial;
export "DPI-C" task ublaze_final;
export "DPI-C" task ublaze_wait;

task ublaze_initial;
    // 
    do @cb;
    while (Reset == 1); 
    ##100;
    $display("[%t]: %m: START", $time); 
    // Final
endtask : ublaze_initial

task ublaze_final;
    // 
    ##100;
    $display("[%t]: %m: STOP", $time); 
    $finish;
    // Final
endtask : ublaze_final

task ublaze_wait(input int iv_value);
    // simple-bfm-dly
    repeat(iv_value)
        @cb;
    // Final
endtask : ublaze_wait
//////////////////////////////////////////////////////////////////////////////////
endmodule
