parameter ADDR_WIDTH = 32;
parameter DATA_WIDTH = 32;
parameter ID_WIDTH   = 4;
parameter AXLEN_WIDTH = 8;

`ifdef NDS_IOCP_NUM
        `define TB_IOCP_NUM    `NDS_IOCP_NUM
`else
        `define TB_IOCP_NUM    0
`endif

`define DMAC300_AXIMST_0        `NDS_APB_SUBSYSTEM.u_dmac_axi.atcdmac300_aximst_0
`define IOCP0                   `NDS_CORE_TOP.u_l2.u_iocp0_axi2tluh
`define L2_MEM                  `NDS_CORE_TOP.u_l2.u_mem
`define AXI_MST                 `IOCP0               
`define CORE0                   `NDS_CORE0_TOP.a45_core.kv_core

typedef enum { READ , WRITE } rw_enum;
typedef enum { BURST_FIXED, BURST_INCR, BURST_WRAP } burst_enum;

class axi_packet;
	// input information (for random or self defined)
	rand logic [ID_WIDTH-1:0]		id;
	rand logic [ADDR_WIDTH-1:0]	addr;
	rand logic [AXLEN_WIDTH-1:0]	axlen;
	rand logic [2:0]			axsize;
	rand logic [1:0]			burst;
	rand logic [1:0]			lock;
	rand logic [3:0]			cache;
	rand logic [2:0]			prot;
	rand logic			        rw;
	rand logic [31:0]		        itr;
	rand logic [31:0]		        port;
        
        function void str ( );
                reg [128*8-1:0] str;
                str = "";
                str = $sformatf("%0t:nds_tb::\t\t",$realtime);
                str = $sformatf("%s addr:'h%0x ", str, this.addr);
                str = $sformatf("%s %s ", str, (this.rw) ? "WRITE":"READ");
                str = $sformatf("%s burst:%0x ", str, this.burst);
                str = $sformatf("%s cache:'h%0x ", str, this.cache);
                str = $sformatf("%s prot:'h%0x ", str, this.prot);
                str = $sformatf("%s size:'h%0x ", str, this.axsize);
                str = $sformatf("%s len:'h%0x ", str, this.axlen);
                str = $sformatf("%s id:'h%0x ", str, this.id);
                $display("%s",str);
        endfunction
        
        function void latency_str (int latency, int port, int file);
                reg [128*8-1:0] str;
                str = "";
                str = $sformatf("%0t:nds_tb:: ",$realtime);
                str = $sformatf("%s addr:'h%0x ", str, this.addr);
                str = $sformatf("%s %s ", str, (this.rw) ? "WRITE":"READ");
                str = $sformatf("%s burst:%0x ", str, this.burst);
                str = $sformatf("%s cache:'h%0x ", str, this.cache);
                str = $sformatf("%s prot:'h%0x ", str, this.prot);
                str = $sformatf("%s size:'h%0x ", str, this.axsize);
                str = $sformatf("%s len:'h%0x ", str, this.axlen);
                str = $sformatf("%s id:'h%0x ", str, this.id);
                str = $sformatf("%s used_cycles:'d%0d ", str, latency);
                str = $sformatf("%s port:'d%0d ", str, port);
                $display("%s",str);
                if (file != 0) $fwrite(file,"%s\n",        str);
        endfunction
endclass

wire    [31:0]          total_size = `NDS_SIM_CONTROL.temp4;
wire    [31:0]          port = `NDS_SIM_CONTROL.temp5;
wire    [31:0]          test = `NDS_SIM_CONTROL.temp6;
wire                    set_wrap = `NDS_SIM_CONTROL.temp7[5];
wire    [31:0]          done = `NDS_SIM_CONTROL.temp7[0];

wire                               aclk;
wire                               aresetn;
wire            [(ADDR_WIDTH-1):0] araddr;
wire                         [1:0] arburst;
wire                         [3:0] arcache;
wire              [(ID_WIDTH-1):0] arid;
wire                         [7:0] arlen;
wire                               arlock;
wire                         [2:0] arprot;
wire                              arready;
wire                         [2:0] arsize;
wire                               arvalid;
wire            [(ADDR_WIDTH-1):0] awaddr;
wire                         [1:0] awburst;
wire                         [3:0] awcache;
wire              [(ID_WIDTH-1):0] awid;
wire                         [7:0] awlen;
wire                               awlock;
wire                         [2:0] awprot;
wire                              awready;
wire                         [2:0] awsize;
wire                               awvalid;
wire             [(ID_WIDTH-1):0] bid;
wire                               bready;
wire                        [1:0] bresp;
wire                              bvalid;
wire           [(DATA_WIDTH-1):0] rdata;
wire             [(ID_WIDTH-1):0] rid;
wire                              rlast;
wire                               rready;
wire                        [1:0] rresp;
wire                              rvalid;
wire            [(DATA_WIDTH-1):0] wdata;
wire                               wlast;
wire                              wready;
wire        [((DATA_WIDTH/8)-1):0] wstrb;
wire                               wvalid;

`ifdef  NDS_IO_SLAVEPORT_COMMON_X1
assign	aresetn	        =		`CORE0.slv_reset_n		;
assign	aclk		=		`CORE0.slv_clk		;
assign	araddr		=		`CORE0.slv_araddr		;
assign	arburst		=		`CORE0.slv_arburst		;
assign	arcache		=		`CORE0.slv_arcache		;
assign	arid		=		`CORE0.slv_arid		;
assign	arlen		=		`CORE0.slv_arlen		;
assign	arlock		=		`CORE0.slv_arlock		;
assign	arprot		=		`CORE0.slv_arprot		;
assign	arready		=		`CORE0.slv_arready		;
assign	arsize		=		`CORE0.slv_arsize		;
assign	arvalid		=		`CORE0.slv_arvalid		;
assign	awaddr		=		`CORE0.slv_awaddr		;
assign	awburst		=		`CORE0.slv_awburst		;
assign	awcache		=		`CORE0.slv_awcache		;
assign	awid		=		`CORE0.slv_awid		;
assign	awlen		=		`CORE0.slv_awlen		;
assign	awlock		=		`CORE0.slv_awlock		;
assign	awprot		=		`CORE0.slv_awprot		;
assign	awready		=		`CORE0.slv_awready		;
assign	awsize		=		`CORE0.slv_awsize		;
assign	awvalid		=		`CORE0.slv_awvalid		;
assign	bid		=		`CORE0.slv_bid		;
assign	bready		=		`CORE0.slv_bready		;
assign	bresp		=		`CORE0.slv_bresp		;
assign	bvalid		=		`CORE0.slv_bvalid		;
assign	rdata		=		`CORE0.slv_rdata		;
assign	rid		=		`CORE0.slv_rid		;
assign	rlast		=		`CORE0.slv_rlast		;
assign	rready		=		`CORE0.slv_rready		;
assign	rresp		=		`CORE0.slv_rresp		;
assign	rvalid		=		`CORE0.slv_rvalid		;
assign	wdata		=		`CORE0.slv_wdata		;
assign	wlast		=		`CORE0.slv_wlast		;
assign	wready		=		`CORE0.slv_wready		;
assign	wstrb		=		`CORE0.slv_wstrb		;
assign	wvalid		=		`CORE0.slv_wvalid		;
`endif 

wire ar_trans = arvalid & arready;
wire aw_trans = awvalid & awready;
wire r_last_trans = rvalid & rready & rlast;
wire b_trans = bvalid & bready;

wire clr_cnt = r_last_trans | b_trans;
reg [31:0] cnt;
wire [31:0] cnt_nx = (clr_cnt) ? '0 : cnt + 1;
always @(posedge aclk or negedge aresetn) begin
        if (!aresetn) 
            cnt <= '0;
        else
            cnt <= cnt_nx;
end

reg [31:0] ar_cnt, aw_cnt;
reg [31:0] r_acc_cnt, w_acc_cnt;
always @(posedge aclk or negedge aresetn) begin
        if (!aresetn) begin
            ar_cnt <= '0;
            aw_cnt <= '0;
        end
        else begin
            if (ar_trans) begin
                ar_cnt <= cnt;
                capture_cmd();
            end
            if (aw_trans) begin
                aw_cnt <= cnt;
                capture_cmd();
            end
        end
end

always @(posedge aclk) begin
        if (r_last_trans) begin
            report_latency(READ);
        end
        if (b_trans) begin
            report_latency(WRITE);
        end
end

axi_packet rcmd, wcmd;

integer f;
initial begin
        f = $fopen("SLVP0_trans.log","w");
        rcmd = new();
        wcmd = new();
        r_acc_cnt = 0;
        w_acc_cnt = 0;

        @(posedge done);
        $fclose(f);
end

initial begin
        fork 
        begin
                @(posedge aresetn);
                while (!done) begin
                        @(`NDS_SIM_CONTROL.event_model_0);
                        if (f != 0) begin
                            //$display("test: %0d\n", test);
                            $fwrite(f, "test: %0d\n", test);
                            $fwrite(f, "total size: %0d\n", total_size);
                        end
                        if (set_wrap) begin
                            force `CORE0.slv_arburst = BURST_WRAP;
                            force `CORE0.slv_awburst = BURST_WRAP;
                        end else begin
                            release `CORE0.slv_arburst;
                            release `CORE0.slv_awburst;
                        end
                end
        end
        begin
                @(posedge aresetn);
                while (!done) begin
                        @(`NDS_SIM_CONTROL.event_model_1);
                        if (f != 0) begin
                             $fwrite(f, "\n");
                        end
                end
        end
        begin
                @(posedge aresetn);
                while (!done) begin
                        @(`NDS_SIM_CONTROL.event_model_2);
                        if (f != 0) begin
                             $fwrite(f, "accumulated read used cycles:%0d , write used cycles:%0d\n", r_acc_cnt, w_acc_cnt);
                             r_acc_cnt = 0;     
                             w_acc_cnt = 0;
                        end
                end
        end
        join
end

function void capture_cmd();
      if (ar_trans) begin
              rcmd.addr       = araddr             ;
              rcmd.burst      = arburst            ;
              rcmd.cache      = arcache            ;
              rcmd.axsize     = arsize             ;
              rcmd.axlen      = arlen              ;
              rcmd.id         = arid               ;
              rcmd.prot       = arprot             ;
              rcmd.rw         = READ ;
      end
      if (aw_trans) begin
              wcmd.addr       = awaddr              ;
              wcmd.burst      = awburst             ;
              wcmd.cache      = awcache             ;
              wcmd.axsize     = awsize              ;
              wcmd.axlen      = awlen               ;
              wcmd.id         = awid                ;
              wcmd.prot       = awprot              ;
              wcmd.rw         = WRITE ;
      end
endfunction

task report_latency (rw_enum rw);
        reg [31:0] used_cycle;
        if (rw == READ) begin 
            used_cycle = (cnt - ar_cnt);     
            r_acc_cnt = r_acc_cnt + used_cycle;
            rcmd.latency_str(used_cycle, port, f);
        end else begin
            used_cycle = (cnt - aw_cnt);
            w_acc_cnt = w_acc_cnt + used_cycle;
            wcmd.latency_str(used_cycle, port, f);
        end
endtask

