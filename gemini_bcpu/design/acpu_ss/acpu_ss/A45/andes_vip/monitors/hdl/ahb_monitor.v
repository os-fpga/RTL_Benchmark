// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary



`timescale 1ns/1ps

`ifdef NDS_AHB_NOK_TIMEOUT
`else
	`define NDS_AHB_NOK_TIMEOUT 32'h3ff
`endif

module ahb_monitor (
	  hclk,
	  hresetn,
	  hmaster,
	  hmastlock,
	  hselx,
	  haddr,
	  htrans,
	  hwrite,
	  hsize,
	  hburst,
	  hprot,
	  hwdata,
	  hrdata,
	  hready,
	  hresp,
	  hllsc_req,
	  hllsc_error,
	  hm0_hbusreq,
	  hm0_hlock,
	  hm1_hbusreq,
	  hm1_hlock,
	  hm2_hbusreq,
	  hm2_hlock,
	  hm3_hbusreq,
	  hm3_hlock
);

parameter ID = 0;
parameter [2:0] DATA_WIDTH = 3'd2;
parameter ADDR_WIDTH = 32;
parameter PEAK_TIME_WINDOW = 100;

parameter HREADY_WARN_WAIT_CNT = 1024;
parameter HREADY_MAX_WAIT_CNT = HREADY_WARN_WAIT_CNT * 32;
parameter MONITOR_TRANS_ON = 1;
parameter INTERFACE_TYPE = "master";

parameter [0:0]	FORBID_UNKNOWN_READ_DATA = 0;

parameter [0:0]	AHB_LITE = 0;
parameter [0:0]	HOLD_IDLE_AT_ERR_RESP = 0;

localparam DATA_BYTES = 1 << DATA_WIDTH;
localparam DATA_BITS = DATA_BYTES * 8;
localparam ADDR_MSB = ADDR_WIDTH - 1;

localparam HTRANS_IDLE    = 2'b00;
localparam HTRANS_BUSY    = 2'b01;
localparam HTRANS_NONSEQ  = 2'b10;
localparam HTRANS_SEQ     = 2'b11;
localparam HBURST_SINGLE  = 3'b000;
localparam HBURST_INCR    = 3'b001;
localparam HBURST_WRAP4   = 3'b010;
localparam HBURST_INCR4   = 3'b011;
localparam HBURST_WRAP8   = 3'b100;
localparam HBURST_INCR8   = 3'b101;
localparam HBURST_WRAP16  = 3'b110;
localparam HBURST_INCR16  = 3'b111;
localparam HRESP_OK       = 2'b00;
localparam HRESP_ERROR    = 2'b01;
localparam HRESP_RETRY    = 2'b10;
localparam HRESP_SPLIT    = 2'b11;
localparam HSIZE_BYTE     = 3'b000;
localparam HSIZE_HALFWORD = 3'b001;
localparam HSIZE_HALF     = 3'b001;
localparam HSIZE_WORD     = 3'b010;
localparam HSIZE_2WORD    = 3'b011;
localparam HSIZE_4WORD    = 3'b100;
localparam HSIZE_8WORD    = 3'b101;
localparam HSIZE_16WORD   = 3'b110;
localparam HSIZE_32WORD   = 3'b111;

input				hclk;
input				hresetn;

input [3:0]			hmaster;
input				hmastlock;
input [31:0]			hselx;

input [ADDR_WIDTH-1:0]		haddr;
input [1:0]			htrans;
input				hwrite;
input [2:0]			hsize;
input [2:0]			hburst;
input [3:0]			hprot;
input [DATA_BITS-1:0]		hwdata;
input [DATA_BITS-1:0]		hrdata;
input				hready;
input [1:0]			hresp;
input				hllsc_req;
input				hllsc_error;

input				hm0_hbusreq;
input				hm0_hlock;
input				hm1_hbusreq;
input				hm1_hlock;
input				hm2_hbusreq;
input				hm2_hlock;
input				hm3_hbusreq;
input				hm3_hlock;

reg				txn_pending;
event				trans;

`ifdef NDS_AHB_RATIO_MON
reg			        hmastlock_d;
reg [ADDR_WIDTH-1:0]    	haddr_d;
reg [1:0]       		htrans_d;
reg      			hwrite_d;
reg [2:0]		        hsize_d;
reg [2:0]		        hburst_d;
reg [3:0]		        hprot_d;
reg [DATA_BITS-1:0] 		hwdata_d;
reg      			hm0_hbusreq_d;
reg      			hm0_hlock_d;
reg       			hm1_hbusreq_d;
reg       			hm1_hlock_d;
reg 			        hm2_hbusreq_d;
reg 			        hm2_hlock_d;
reg     			hm3_hbusreq_d;
reg 			        hm3_hlock_d;
`endif

reg [3:0]			hmaster_dp;
reg				hmastlock_d1;
reg				hmastlock_f1;
reg [ADDR_WIDTH-1:0]		haddr_dp;
reg [1:0]			htrans_dp;
reg [1:0]			htrans_db;
reg				hwrite_dp;
reg [2:0]			hburst_dp;
reg [3:0]			hprot_d1;
reg [4:0]			slave_id;
reg [4:0]			slave_id_d1;
reg				hllsc_req_d1;

reg				hready_dp;
reg				hsel_dp;
reg [1:0]			hresp_dp;
reg [2:0]			hsize_dp;
reg [3:0]			hprot_dp;
reg [3:0]			seq_cnt_ap;

reg				hm0_hlock_ap;
reg				hm1_hlock_ap;
reg				hm2_hlock_ap;
reg				hm3_hlock_ap;


reg [ADDR_WIDTH-1:0]		haddr_exp;

wire				hsel;

`ifdef NDS_AHB_RATIO_MON
wire  		                core_clk = `NDS_CORE_CLK;
wire				cpu_estrb = `NDS_BENCH.cpu_estrb;
reg 				cpu_estrb_d1;
`endif

reg dispmon_ahb_addr_mon_9;
reg dispmon_ahb_early_termination_mon_9;
reg dispmon_ahb_htrans_in_hready_low_mon_9;
reg dispmon_ahb_mon_0;
reg dispmon_ahb_resp_mon_9;
initial begin
	dispmon_ahb_addr_mon_9 = 1'b1;
	dispmon_ahb_early_termination_mon_9 = 1'b1;
	dispmon_ahb_htrans_in_hready_low_mon_9 = 1'b1;
	dispmon_ahb_mon_0 = 1'b1;
	dispmon_ahb_resp_mon_9 = 1'b1;

	if ($test$plusargs("mon+ahb_addr_mon+9+off")) dispmon_ahb_addr_mon_9 = 1'b0;
	if ($test$plusargs("mon+ahb_early_termination_mon+9+off")) dispmon_ahb_early_termination_mon_9 = 1'b0;
	if ($test$plusargs("mon+ahb_htrans_in_hready_low_mon+9+off")) dispmon_ahb_htrans_in_hready_low_mon_9 = 1'b0;
	if ($test$plusargs("mon+ahb_mon+0+off")) dispmon_ahb_mon_0 = 1'b0;
	if ($test$plusargs("mon+ahb_resp_mon+9+off")) dispmon_ahb_resp_mon_9 = 1'b0;
end

assign hsel = |hselx;

always @(hselx) begin
	casez(hselx)
	32'b1???????_????????_????????_???????? :	slave_id = 5'd31;
	32'b01??????_????????_????????_???????? :	slave_id = 5'd30;
	32'b001?????_????????_????????_???????? :	slave_id = 5'd29;
	32'b0001????_????????_????????_???????? :	slave_id = 5'd28;
	32'b00001???_????????_????????_???????? :	slave_id = 5'd27;
	32'b000001??_????????_????????_???????? :	slave_id = 5'd26;
	32'b0000001?_????????_????????_???????? :	slave_id = 5'd25;
	32'b00000001_????????_????????_???????? :	slave_id = 5'd24;

	32'b00000000_1???????_????????_???????? :	slave_id = 5'd23;
	32'b00000000_01??????_????????_???????? :	slave_id = 5'd22;
	32'b00000000_001?????_????????_???????? :	slave_id = 5'd21;
	32'b00000000_0001????_????????_???????? :	slave_id = 5'd20;
	32'b00000000_00001???_????????_???????? :	slave_id = 5'd19;
	32'b00000000_000001??_????????_???????? :	slave_id = 5'd18;
	32'b00000000_0000001?_????????_???????? :	slave_id = 5'd17;
	32'b00000000_00000001_????????_???????? :	slave_id = 5'd16;

	32'b00000000_00000000_1???????_???????? :	slave_id = 5'd15;
	32'b00000000_00000000_01??????_???????? :	slave_id = 5'd14;
	32'b00000000_00000000_001?????_???????? :	slave_id = 5'd13;
	32'b00000000_00000000_0001????_???????? :	slave_id = 5'd12;
	32'b00000000_00000000_00001???_???????? :	slave_id = 5'd11;
	32'b00000000_00000000_000001??_???????? :	slave_id = 5'd10;
	32'b00000000_00000000_0000001?_???????? :	slave_id = 5'd8;
	32'b00000000_00000000_00000001_???????? :	slave_id = 5'd8;

	32'b00000000_00000000_00000000_1??????? :	slave_id = 5'd7;
	32'b00000000_00000000_00000000_01?????? :	slave_id = 5'd6;
	32'b00000000_00000000_00000000_001????? :	slave_id = 5'd5;
	32'b00000000_00000000_00000000_0001???? :	slave_id = 5'd4;
	32'b00000000_00000000_00000000_00001??? :	slave_id = 5'd3;
	32'b00000000_00000000_00000000_000001?? :	slave_id = 5'd2;
	32'b00000000_00000000_00000000_0000001? :	slave_id = 5'd1;
	32'b00000000_00000000_00000000_00000001 :	slave_id = 5'd0;
	default: slave_id = 5'd0;
	endcase
end

always @(negedge hresetn or posedge hclk)
	if (~hresetn) begin
		txn_pending <= 1'b0;
		hmastlock_d1 <= 1'b0;
		hprot_d1 <= 4'b0;
		slave_id_d1 <= 5'b0;
		hllsc_req_d1 <= 1'b0;
	end
	else if (hready) begin
		if (hsel & htrans[1]) begin
			txn_pending <= 1'b1;
		end
		else begin
			txn_pending <= 1'b0;
		end
		hmastlock_d1 <= hmastlock;
		hprot_d1 <= hprot;
		slave_id_d1 <= slave_id;
		hllsc_req_d1 <= hllsc_req;
	end

always @(negedge hresetn or posedge hclk)
	if (!hresetn)
		hmastlock_f1 <= 1'b0;
	else
		hmastlock_f1 <= hmastlock;

always @(posedge hclk)
	if (hready && txn_pending && (MONITOR_TRANS_ON == 1)) begin
		->trans;
		if (hllsc_req_d1 !== 1'b1) begin
			if (dispmon_ahb_mon_0) $display("%0t:ahb_mon:AHB%0d M%0dS%0d %s %x htrans=%x data=%x burst=%x size=%x prot=%x lock=%x resp=%0s", $realtime, ID, hmaster_dp, slave_id_d1, hwrite_dp ? "write" : "read", haddr_dp, htrans_dp, (hwrite_dp ? hwdata : hrdata), hburst_dp, hsize_dp, hprot_d1, hmastlock_d1, get_hresp_string(hresp));
			if (hresp == HRESP_OK) begin
				     if ( hwrite_dp && (^hwdata === 1'bx)) begin
					$display("%0t:ahb_mon:AHB%0d:WARNING: addr=%x write contains unknown data=%x", $realtime, ID, haddr_dp, hwdata);
				end
				else if (~hwrite_dp && (^hrdata === 1'bx)) begin
					$display("%0t:ahb_mon:AHB%0d:%0s: addr=%x read contains unknown data=%x", $realtime, ID, FORBID_UNKNOWN_READ_DATA ? "ERROR" : "WARNING", haddr_dp, hrdata);
				end
			end
		end
		else begin
			if (dispmon_ahb_mon_0) $display("%0t:ahb_mon:AHB%0d M%0dS%0d %s %x htrans=%x data=%x burst=%x size=%x prot=%x lock=%x resp=%0s hllsc=%s", $realtime, ID, hmaster_dp, slave_id_d1, hwrite_dp ? "write" : "read", haddr_dp, htrans_dp, (hwrite_dp ? hwdata : hrdata), hburst_dp, hsize_dp, hprot_d1, hmastlock_d1, get_hresp_string(hresp), hllsc_error ? "fail": "okay");
		end
	end


always @(posedge hclk or negedge hresetn) begin
	if (!hresetn) begin
		hwrite_dp  <= 1'h0;
		htrans_dp  <= 2'h0;
		hburst_dp  <= 3'h0;
		hsize_dp   <= 3'h0;
		hprot_dp   <= 4'h0;
		haddr_dp   <= {ADDR_WIDTH{1'b0}};
		hmaster_dp <= 4'h0;
		hm0_hlock_ap   <= 1'h0;
		hm1_hlock_ap   <= 1'h0;
		hm2_hlock_ap   <= 1'h0;
		hm3_hlock_ap   <= 1'h0;
		seq_cnt_ap         <= 4'h0;
	end
	else if (hready) begin
		hwrite_dp  <= hwrite ;
		htrans_dp  <= htrans ;
		hburst_dp  <= hburst ;
		hsize_dp   <= hsize  ;
		hprot_dp   <= hprot  ;
		haddr_dp   <= haddr  ;
		hmaster_dp <= hmaster;
		hm0_hlock_ap   <= hm0_hlock;
		hm1_hlock_ap   <= hm1_hlock;
		hm2_hlock_ap   <= hm2_hlock;
		hm3_hlock_ap   <= hm3_hlock;
		seq_cnt_ap         <= (hmaster!==hmaster_dp & htrans==HTRANS_IDLE) ? 4'h0 :
			           htrans==HTRANS_NONSEQ ?
	 		          ((hburst==HBURST_WRAP4  | hburst==HBURST_INCR4)  ? 4'h3 :
			           (hburst==HBURST_WRAP8  | hburst==HBURST_INCR8)  ? 4'h7 :
				   (hburst==HBURST_WRAP16 | hburst==HBURST_INCR16) ? 4'hf : 4'h0) : seq_cnt_ap - (((htrans==HTRANS_SEQ | (hmaster===hmaster_dp & htrans==HTRANS_IDLE)) & seq_cnt_ap!==4'h0) ? 4'h1 : 4'h0) ;
	end
end
always @(posedge hclk or negedge hresetn) begin
	if (!hresetn) begin
		hready_dp  <= 1'b0 ;
		hresp_dp   <= 2'h0 ;
		htrans_db  <= 2'h0 ;

		hsel_dp		<= 1'b0;
	end
	else begin
		hready_dp  <= hready ;
		hresp_dp   <= hresp  ;
		htrans_db  <= htrans ;

		if (hready)
			hsel_dp <= hsel;
	end
end

reg [7*8-1:0] htrans_string;
reg [7*8-1:0] htrans_db_string;
function [7*8-1:0] get_htrans_string;
input [1:0] htrans;
begin
	case (htrans)
		HTRANS_IDLE: begin
			get_htrans_string = "idle";
		end
		HTRANS_BUSY: begin
			get_htrans_string = "busy";
		end
		HTRANS_NONSEQ: begin
			get_htrans_string = "nonseq";
		end
		HTRANS_SEQ: begin
			get_htrans_string = "seq";
		end
		default: begin
			get_htrans_string = "unknown";
		end
	endcase
end
endfunction

function [7*8-1:0] get_hresp_string;
input [1:0] hresp;
begin
	case (hresp)
		HRESP_OK: begin
			get_hresp_string = "ok";
		end
		HRESP_ERROR: begin
			get_hresp_string = "error";
		end
		HRESP_RETRY: begin
			get_hresp_string = "retry";
		end
		HRESP_SPLIT: begin
			get_hresp_string = "split";
		end
		default: begin
			get_hresp_string = "unknown";
		end
	endcase
end
endfunction

wire htrans_nonseq_idle;
assign  htrans_nonseq_idle = (!hready_dp & (htrans!=htrans_db))
			&& !((htrans_db==HTRANS_IDLE) & (htrans==HTRANS_NONSEQ))
			&& !((htrans_db==HTRANS_BUSY) & (htrans!=HTRANS_BUSY))
                        && (hresp == HRESP_OK)
                        && (INTERFACE_TYPE == "master");
always @(posedge hclk) begin
	if (htrans_nonseq_idle) begin
		htrans_string = get_htrans_string(htrans);
		htrans_db_string = get_htrans_string(htrans_db);
		if (dispmon_ahb_htrans_in_hready_low_mon_9) begin $display("%0t:ahb_htrans_in_hready_low_mon:ERROR:AHB%0d:ERROR:htrans=%0s cannot be followed by htrans=%0s when hready is low", $realtime, ID, htrans_db_string, htrans_string); #1 $finish; end
	end
	if (HOLD_IDLE_AT_ERR_RESP & hready && (hresp_dp == hresp) && (hresp == HRESP_ERROR) && (htrans_db == HTRANS_IDLE) && (htrans != HTRANS_IDLE)) begin
		htrans_string = get_htrans_string(htrans);
		$display("%0t:AHB%0d:ERROR:htrans should hold idle and not change to %0s at the second cycle of a two-cycle error response for hresp=%h",$realtime, ID, htrans_string, hresp);
		#1 $finish;
	end

	if ((hmaster == hmaster_dp) && hready && (hresp_dp == hresp) && (hresp != HRESP_OK && hresp != HRESP_ERROR) && (htrans != HTRANS_IDLE)) begin
		htrans_string = get_htrans_string(htrans);
		$display("%0t:AHB%0d:ERROR:htrans should be idle and not %0s at the second cycle of a two-cycle response for hresp=%h",$realtime, ID, htrans_string, hresp);
	end
	if (hready && hready_dp && (hresp_dp == hresp) && (hresp != HRESP_OK)) begin
		$display("%0t:AHB%0d:ERROR:two-cycle response hresp=%h asserts hready for more than 1 cycle",$realtime, ID, hresp);
	end
end

reg        wait_cnt_warn;
reg [31:0] wait_cnt;
always @(posedge hclk or negedge hresetn)
	if (!hresetn)
		wait_cnt <= 32'h0;
	else if (hready)
		wait_cnt <= 32'h0;
	else
		wait_cnt <= wait_cnt + 32'h1;

reg        nok_cnt_warn;
reg [31:0] nok_cnt;
always @(posedge hclk or negedge hresetn)
	if (!hresetn)
		nok_cnt <= 32'h0;
	else if (hready & (hresp!=HRESP_OK))
		nok_cnt <= nok_cnt + 32'h1;
	else if (hready & (htrans_dp==HTRANS_NONSEQ))
		nok_cnt <= 32'h0;

reg nok_one_happen;
always @(posedge hclk or negedge hresetn)
	if (!hresetn)
		nok_one_happen <= 1'h0;
	else if (!hready & (hresp!=HRESP_OK))
		nok_one_happen <= 1'h1;
	else if (hready & (hresp!=HRESP_OK))
		nok_one_happen <= 1'h0;

always @(posedge hclk or negedge hresetn)
	if (!hresetn) begin
		wait_cnt_warn <= 1'b1;
		nok_cnt_warn  <= 1'b1;
		haddr_exp     <= {(ADDR_WIDTH){1'b0}};
	end
	else begin
		if (wait_cnt_warn & (wait_cnt > HREADY_WARN_WAIT_CNT)) begin
			$display("%0t:AHB%0d:WARNING:%0d cycle without hready",$realtime,ID,wait_cnt);
			wait_cnt_warn <= 1'b0;
		end
		if (wait_cnt >= HREADY_MAX_WAIT_CNT) begin
			$display("%0t:AHB%0d:ERROR:%0d cycle without hready",$realtime,ID,wait_cnt);
			#10 $finish;
		end
		if (nok_cnt_warn & (nok_cnt > `NDS_AHB_NOK_TIMEOUT)) begin
			$display("%0t:AHB%0d:ERROR:%0d transaction without ok hresp",$realtime,ID,nok_cnt);
			nok_cnt_warn <= 1'b0;
			#10 $finish;
		end
		if ((hresp!=HRESP_OK) & hready & !nok_one_happen) begin
			$display("%0t:AHB%0d:ERROR:non-ok response violates two-cycle response",$realtime,ID);
			#10 $finish;
		end
		if ((hresp!=HRESP_OK) & !hready & nok_one_happen) begin
			$display("%0t:AHB%0d:ERROR:hready is low at the 2nd cycle of the two-cycle response",$realtime,ID);
			#10 $finish;
		end
		if (hsel_dp && (htrans_dp===HTRANS_IDLE) & !hready) begin
			$display("%0t:AHB%0d:ERROR:idle should not have wait state",$realtime,ID);
			#10 $finish;
		end
		if ((htrans_dp===HTRANS_BUSY) & !hready) begin
			$display("%0t:AHB%0d:ERROR:busy should not have wait state",$realtime,ID);
			#10 $finish;
		end
		if ((hburst===HBURST_SINGLE) & (htrans===HTRANS_SEQ)) begin
			$display("%0t:AHB%0d:ERROR:htrans,hburst should not be seq,single",$realtime,ID);
			#10 $finish;
		end
		if ((hburst===HBURST_SINGLE) & (htrans===HTRANS_BUSY)) begin
			$display("%0t:AHB%0d:ERROR:htrans,hburst should not be busy,single",$realtime,ID);
			#10 $finish;
		end
		if ((htrans===HTRANS_BUSY) & (htrans_dp===HTRANS_IDLE)) begin
			$display("%0t:AHB%0d:ERROR:htrans following idle should not be busy",$realtime,ID);
			#10 $finish;
		end
		if ((htrans===HTRANS_SEQ) & (htrans_dp===HTRANS_IDLE)) begin
			$display("%0t:AHB%0d:ERROR:htrans following idle should not be seq",$realtime,ID);
			#10 $finish;
		end
		if ((htrans===HTRANS_BUSY) & (hmaster_dp!==hmaster)) begin
			$display("%0t:AHB%0d:ERROR:htrans following handover should not be busy",$realtime,ID);
			#10 $finish;
		end
		if ((htrans===HTRANS_SEQ) & (hmaster_dp!==hmaster)) begin
			$display("%0t:AHB%0d:ERROR:htrans following handover should not be seq",$realtime,ID);
			#10 $finish;
		end
		if ((htrans===HTRANS_NONSEQ) & (seq_cnt_ap!==4'h0) & hready & (hmaster_dp===hmaster) & nok_cnt===0 & (haddr[ADDR_MSB:10]===haddr_dp[ADDR_MSB:10]))  begin
			if (dispmon_ahb_early_termination_mon_9) begin $display("%0t:ahb_early_termination_mon:ERROR:AHB%0d:premature early termination", $realtime, ID); #1 $finish; end
		end
		if (AHB_LITE && (htrans_dp != HTRANS_IDLE) && ((htrans==HTRANS_IDLE) || (htrans == HTRANS_NONSEQ)) &&
			(seq_cnt_ap !== 4'h0) && (hresp==HRESP_OK)) begin
			if (dispmon_ahb_early_termination_mon_9) begin $display("%0t:ahb_early_termination_mon:ERROR:AHB%0d: Unexpected early termination", $realtime, ID); #1 $finish; end
		end
		if ((htrans===HTRANS_SEQ) & (hburst_dp===HBURST_SINGLE)) begin
			$display("%0t:AHB%0d:ERROR:htrans following hburst_single should not be seq",$realtime,ID);
			#10 $finish;
		end
		if ((htrans===HTRANS_BUSY) & (hburst_dp===HBURST_SINGLE)) begin
			$display("%0t:AHB%0d:ERROR:htrans following hburst_single should not be busy",$realtime,ID);
			#10 $finish;
		end
		if (((htrans===HTRANS_SEQ) | (htrans===HTRANS_BUSY)) & (htrans_dp===HTRANS_BUSY)) begin
			if (haddr !== haddr_dp) begin
				if (dispmon_ahb_addr_mon_9) begin $display("%0t:ahb_addr_mon:ERROR:AHB%0d:when busy to seq/busy, haddr should not change from %x to %x", $realtime, ID,haddr_dp,haddr); #1 $finish; end
			end
			if (hburst !== hburst_dp) begin
				$display("%0t:AHB%0d:ERROR:when busy to seq/busy, hburst should not change from %x to %x",$realtime,ID,hburst_dp,hburst);
				#10 $finish;
			end
			if (hwrite !== hwrite_dp) begin
				$display("%0t:AHB%0d:ERROR:when busy to seq/busy, hwrite should not change from %x to %x",$realtime,ID,hwrite_dp,hwrite);
				#10 $finish;
			end
			if (hsize !== hsize_dp) begin
				$display("%0t:AHB%0d:ERROR:when busy to seq/busy, hsize should not change from %x to %x",$realtime,ID,hsize_dp,hsize);
				#10 $finish;
			end
			if (hprot !== hprot_dp) begin
				$display("%0t:AHB%0d:ERROR:when busy to seq/busy, hprot should not change from %x to %x",$realtime,ID,hprot_dp,hprot);
				#10 $finish;
			end
		end
		if (((htrans===HTRANS_SEQ) | (htrans===HTRANS_BUSY)) & ((htrans_dp===HTRANS_NONSEQ) | (htrans_dp===HTRANS_SEQ))) begin
			if (hburst !== hburst_dp) begin
				$display("%0t:AHB%0d:ERROR:when nonseq/seq to seq/busy, hburst should not change from %x to %x",$realtime,ID,hburst_dp,hburst);
				#10 $finish;
			end
			if (hwrite !== hwrite_dp) begin
				$display("%0t:AHB%0d:ERROR:when nonseq/seq to seq/busy, hwrite should not change from %x to %x",$realtime,ID,hwrite_dp,hwrite);
				#10 $finish;
			end
			if (hsize !== hsize_dp) begin
				$display("%0t:AHB%0d:ERROR:when nonseq/seq to seq/busy, hsize should not change from %x to %x",$realtime,ID,hsize_dp,hsize);
				#10 $finish;
			end
			if (hprot !== hprot_dp) begin
				$display("%0t:AHB%0d:ERROR:when nonseq/seq to seq/busy, hprot should not change from %x to %x",$realtime,ID,hprot_dp,hprot);
				#10 $finish;
			end
		end
		if (((htrans===HTRANS_SEQ) | (htrans===HTRANS_BUSY)) & (htrans_dp!==HTRANS_BUSY)) begin
			if (haddr[ADDR_MSB:10]!==haddr_dp[ADDR_MSB:10]) begin
				$display("%0t:AHB%0d:ERROR:Burst must not cross 1KB boundary",$realtime,ID);
				#10 $finish;
			end
			else begin
				haddr_exp = haddr_inc(haddr_dp, hburst_dp, hsize_dp);
				if (haddr !== haddr_exp) begin
					if (dispmon_ahb_addr_mon_9) begin $display("%0t:ahb_addr_mon:ERROR:AHB%0d:haddr=0x%h does not equal the expected next address 0x%h for {hburst=%0d, hsize=%0d}", $realtime, ID, haddr, haddr_exp, hburst_dp, hsize_dp); #1 $finish; end
				end
			end
		end
		if ((htrans!==HTRANS_IDLE) & ((haddr & ~({ADDR_WIDTH{1'b1}}<<hsize)) !== {ADDR_WIDTH{1'b0}})) begin
			if (dispmon_ahb_addr_mon_9) begin $display("%0t:ahb_addr_mon:ERROR:AHB%0d:haddr=0x%h does not align to hsize=%d", $realtime, ID, haddr, hsize); #1 $finish; end
		end
		if (((hmaster == hmaster_dp) && (htrans!==HTRANS_IDLE) & hready & ((hresp===HRESP_RETRY) | (hresp===HRESP_SPLIT))) & (!hready_dp & ((hresp_dp===HRESP_RETRY) | (hresp_dp===HRESP_SPLIT)))) begin
			if (dispmon_ahb_resp_mon_9) begin $display("%0t:ahb_resp_mon:ERROR:nHB%0d:htrans is not idle upon receiving the first cycle of retry/split response", $realtime, ID); #1 $finish; end
		end

 	        if (hready & ~hmastlock & ((hm0_hlock_ap & (hmaster == 4'd0))
					 | (hm1_hlock_ap & (hmaster == 4'd1))
				   	 | (hm2_hlock_ap & (hmaster == 4'd2))
					 | (hm3_hlock_ap & (hmaster == 4'd3)))) begin
			$display("%0t:AHB%0d:ERROR:hmastlock should be asserted to work as delayed version of hlock", $realtime, ID);
			#10 $finish;
	        end

		if (AHB_LITE && !hmastlock_f1 && (hmastlock===1'b1) && (htrans==HTRANS_IDLE)) begin
			$display("%0t:AHB%0d:ERROR:Master should not start locked sequence with an idle transfer", $realtime, ID);
			#10 $finish;
		end

		if (hready & (htrans!=HTRANS_IDLE) & ((~hm0_hlock & hm0_hlock_ap)
					    	    | (~hm1_hlock & hm1_hlock_ap)
					    	    | (~hm2_hlock & hm2_hlock_ap)
						    | (~hm3_hlock & hm3_hlock_ap))) begin
			$display("%0t:AHB%0d:ERROR:an idle transfer is not following the lock sequence", $realtime, ID);
			#10 $finish;
	        end

		if (hsize>DATA_WIDTH && htrans != HTRANS_IDLE) begin
			$display("%0t:AHB%0d:ERROR:hsize is larger than data width", $realtime, ID);
		end
	end

function [ADDR_MSB:0] haddr_inc;
	input [ADDR_MSB:0] haddr_i;
	input        [2:0] hburst_i;
	input        [2:0] hsize_i;
	reg [9:0] addr_plus_beat;
	begin
		addr_plus_beat = haddr_i[9:0] + (10'h1<<hsize_i);
		case ({hsize_i,hburst_i})
			{HSIZE_BYTE  ,HBURST_WRAP4 }: haddr_inc = {haddr_i[ADDR_MSB: 2],addr_plus_beat[1:0]};
			{HSIZE_HALF  ,HBURST_WRAP4 }: haddr_inc = {haddr_i[ADDR_MSB: 3],addr_plus_beat[2:0]};
			{HSIZE_WORD  ,HBURST_WRAP4 }: haddr_inc = {haddr_i[ADDR_MSB: 4],addr_plus_beat[3:0]};
			{HSIZE_2WORD ,HBURST_WRAP4 }: haddr_inc = {haddr_i[ADDR_MSB: 5],addr_plus_beat[4:0]};
			{HSIZE_4WORD ,HBURST_WRAP4 }: haddr_inc = {haddr_i[ADDR_MSB: 6],addr_plus_beat[5:0]};
			{HSIZE_8WORD ,HBURST_WRAP4 }: haddr_inc = {haddr_i[ADDR_MSB: 7],addr_plus_beat[6:0]};
			{HSIZE_16WORD,HBURST_WRAP4 }: haddr_inc = {haddr_i[ADDR_MSB: 8],addr_plus_beat[7:0]};
			{HSIZE_32WORD,HBURST_WRAP4 }: haddr_inc = {haddr_i[ADDR_MSB: 9],addr_plus_beat[8:0]};
			{HSIZE_BYTE  ,HBURST_WRAP8 }: haddr_inc = {haddr_i[ADDR_MSB: 3],addr_plus_beat[2:0]};
			{HSIZE_HALF  ,HBURST_WRAP8 }: haddr_inc = {haddr_i[ADDR_MSB: 4],addr_plus_beat[3:0]};
			{HSIZE_WORD  ,HBURST_WRAP8 }: haddr_inc = {haddr_i[ADDR_MSB: 5],addr_plus_beat[4:0]};
			{HSIZE_2WORD ,HBURST_WRAP8 }: haddr_inc = {haddr_i[ADDR_MSB: 6],addr_plus_beat[5:0]};
			{HSIZE_4WORD ,HBURST_WRAP8 }: haddr_inc = {haddr_i[ADDR_MSB: 7],addr_plus_beat[6:0]};
			{HSIZE_8WORD ,HBURST_WRAP8 }: haddr_inc = {haddr_i[ADDR_MSB: 8],addr_plus_beat[7:0]};
			{HSIZE_16WORD,HBURST_WRAP8 }: haddr_inc = {haddr_i[ADDR_MSB: 9],addr_plus_beat[8:0]};
			{HSIZE_32WORD,HBURST_WRAP8 }: haddr_inc = {haddr_i[ADDR_MSB:10],addr_plus_beat[9:0]};
			{HSIZE_BYTE  ,HBURST_WRAP16}: haddr_inc = {haddr_i[ADDR_MSB: 4],addr_plus_beat[3:0]};
			{HSIZE_HALF  ,HBURST_WRAP16}: haddr_inc = {haddr_i[ADDR_MSB: 5],addr_plus_beat[4:0]};
			{HSIZE_WORD  ,HBURST_WRAP16}: haddr_inc = {haddr_i[ADDR_MSB: 6],addr_plus_beat[5:0]};
			{HSIZE_2WORD ,HBURST_WRAP16}: haddr_inc = {haddr_i[ADDR_MSB: 7],addr_plus_beat[6:0]};
			{HSIZE_4WORD ,HBURST_WRAP16}: haddr_inc = {haddr_i[ADDR_MSB: 8],addr_plus_beat[7:0]};
			{HSIZE_8WORD ,HBURST_WRAP16}: haddr_inc = {haddr_i[ADDR_MSB: 9],addr_plus_beat[8:0]};
			{HSIZE_16WORD,HBURST_WRAP16}: haddr_inc = {haddr_i[ADDR_MSB:10],addr_plus_beat[9:0]};
			{HSIZE_32WORD,HBURST_WRAP16}: haddr_inc = {haddr_i[ADDR_MSB:10],addr_plus_beat[9:0]};
			default: haddr_inc = {haddr_i[ADDR_MSB:10],addr_plus_beat[9:0]};
		endcase
	end
endfunction


genvar i;
generate
for (i = 0; i < 16; i = i + 1) begin: early_termination_monitor
	wire		valid_nonseq;
	wire		burst_first;
	reg		burst_in_nx;
	reg		burst_in;
	reg [2:0]	hburst_saved;
	reg [4:0]	burst_cnt_nx;
	reg [4:0]	burst_cnt;

	assign valid_nonseq = (hmaster === i[3:0]) && hready && (htrans === HTRANS_NONSEQ);
	assign burst_first = valid_nonseq && (hburst !== HBURST_SINGLE) && (hburst !== HBURST_INCR);

	always @* begin
		if (valid_nonseq) begin
			if ((hburst === HBURST_SINGLE) || (hburst === HBURST_INCR)) begin
				burst_in_nx = 1'd0;
			end
			else begin
				burst_in_nx = 1'd1;
			end
		end
		else if (burst_in && (burst_cnt_nx == 5'd0)) begin
			burst_in_nx = 1'd0;
		end
		else begin
			burst_in_nx = burst_in;
		end
	end

	always @* begin
		if ((hmaster == i[3:0]) & hready & htrans[1]) begin
			if (~htrans[0]) begin
				case(hburst[2:1])
				2'b00: burst_cnt_nx = 5'd0;
				2'b01: burst_cnt_nx = 5'd3;
				2'b10: burst_cnt_nx = 5'd7;
				2'b11: burst_cnt_nx = 5'd15;
				default: burst_cnt_nx = 5'bx;
				endcase
			end
			else if (~(burst_cnt==5'd0)) begin
				burst_cnt_nx=burst_cnt-5'h1;
			end
			else begin
				burst_cnt_nx=5'd0;
			end
		end
		else begin
			burst_cnt_nx=burst_cnt;
		end
	end

	always @(posedge hclk or negedge hresetn) begin
		if (~hresetn) begin
			burst_cnt <= 5'd0;
			burst_in  <= 1'd0;
		end
		else begin
			burst_cnt <= burst_cnt_nx;
			burst_in  <= burst_in_nx;
		end
	end

	always @(posedge hclk) begin
		if (burst_first) begin
			hburst_saved <= hburst;
		end
	end

	always @(posedge hclk) begin
		if (valid_nonseq && burst_in && (hburst_saved === hburst)) begin
			$display("%0t:AHB%0d:master %0d:WARNING: the value of hburst after early termination is same as the value of hburst before early termination",$realtime, ID, i);
		end
	end

end
endgenerate




`ifdef NDS_AHB_MON_PERF
wire				wstart;
wire				wvalid;
wire				wlast;
wire				rstart;
wire				rvalid;
wire				rlast;


assign wstart = hwrite && (htrans == 2'b10) && hready && hsel;
assign wvalid = (((htrans_dp == HTRANS_NONSEQ) || (htrans_dp == HTRANS_SEQ)) && hwrite_dp  && hready);
assign wlast = (((htrans_dp == HTRANS_NONSEQ) || (htrans_dp == HTRANS_SEQ)) && ((htrans == HTRANS_NONSEQ) || (htrans == HTRANS_IDLE)) && hwrite_dp && hready);

assign rstart = ~hwrite && (htrans == 2'b10) && hready && hsel;
assign rvalid = (((htrans_dp == HTRANS_NONSEQ) || (htrans_dp == HTRANS_SEQ)) && ~hwrite_dp  && hready);
assign rlast = (((htrans_dp == HTRANS_NONSEQ) || (htrans_dp == HTRANS_SEQ)) && ((htrans == HTRANS_NONSEQ) || (htrans == HTRANS_IDLE)) && ~hwrite_dp && hready);

bus_mon ahb_perf_mon(
        .wstart(wstart),
        .wvalid(wvalid),
        .wlast(wlast),
        .rstart(rstart),
        .rvalid(rvalid),
        .rlast(rlast),
        .mon_en(1'b1),
        .resetn(hresetn),
        .clk(hclk)
);
`endif

`ifdef NDS_AHB_RATIO_MON
always @ (posedge core_clk) begin
	cpu_estrb_d1 <= cpu_estrb;
end

always @ (posedge core_clk) begin
        if (cpu_estrb_d1) begin
		hmastlock_d   <= hmastlock;
	        haddr_d       <= haddr;
	        htrans_d      <= htrans;
	        hwrite_d      <= hwrite;
	        hsize_d       <= hsize;
	        hburst_d      <= hburst;
	        hprot_d       <= hprot;
	        hwdata_d      <= hwdata;
	        hm0_hbusreq_d <= hm0_hbusreq;
	        hm0_hlock_d   <= hm0_hlock;
	        hm1_hbusreq_d <= hm1_hbusreq;
	        hm1_hlock_d   <= hm1_hlock;
	        hm2_hbusreq_d <= hm2_hbusreq;
	        hm2_hlock_d   <= hm2_hlock;
	        hm3_hbusreq_d <= hm3_hbusreq;
	        hm3_hlock_d   <= hm3_hlock;
	end
end

`ifdef NDS_BIU_SYNC
`ifndef NDS_CLK_RATIO_3_2
`ifndef NDS_CLK_RATIO_5_2

always @ (posedge core_clk)begin
	if (hresetn && !cpu_estrb_d1 && (htrans_dp !== 2'b0)) begin
		if (hwdata_d !== hwdata) begin
	                $display("%0t:ahb_wdata_mon:ERROR:AHB%0d:hwdata change in a bus cycle", $realtime, ID); #10 $finish;
	        end
	end
end
always @ (posedge core_clk)begin
	if (hresetn && !cpu_estrb_d1 && (htrans_d !== 2'b0)) begin
		if (hmastlock_d != hmastlock) begin
	                $display("%0t:ahb_mastlock_mon:ERROR:AHB%0d:hmastlock changes in a bus cycle", $realtime, ID); #10 $finish;
	        end
		if (haddr_d !== haddr) begin
	                $display("%0t:ahb_addr_mon:ERROR:AHB%0d:haddr change in a bus cycle", $realtime, ID); #10 $finish;
	        end
		if (htrans_d !== htrans) begin
	                $display("%0t:ahb_trans_mon:ERROR:AHB%0d:htrans change in a bus cycle", $realtime, ID); #10 $finish;
	        end
		if (hwrite_d != hwrite) begin
	                $display("%0t:ahb_write_mon:ERROR:AHB%0d:hwrite change in a bus cycle", $realtime, ID); #10 $finish;
	        end
		if (hsize_d !== hsize) begin
	                $display("%0t:ahb_size_mon:ERROR:AHB%0d:hsize change in a bus cycle", $realtime, ID); #10 $finish;
	        end
		if (hburst_d !== hburst) begin
	                $display("%0t:ahb_burst_mon:ERROR:AHB%0d:hburst change in a bus cycle", $realtime, ID); #10 $finish;
	        end
		if (hprot_d !== hprot) begin
	                $display("%0t:ahb_prot_mon:ERROR:AHB%0d:hprot change in a bus cycle", $realtime, ID); #10 $finish;
	        end
		if (hm0_hbusreq_d != hm0_hbusreq) begin
	                $display("%0t:ahb_hm0_busreq_mon:ERROR:AHB%0d:hm0_hbusreq change in a bus cycle", $realtime, ID); #10 $finish;
	        end
		if (hm0_hlock_d != hm0_hlock) begin
	                $display("%0t:ahb_hm0_lock_mon:ERROR:AHB%0d:hm0_hlock change in a bus cycle", $realtime, ID); #10 $finish;
	        end
		if (hm1_hbusreq_d != hm1_hbusreq) begin
	                $display("%0t:ahb_hm1_hbusreq_mon:ERROR:AHB%0d:hm1_hbusreq change in a bus cycle", $realtime, ID); #10 $finish;
	        end
		if (hm1_hlock_d != hm1_hlock) begin
	                $display("%0t:ahb_hm1_hlock_mon:ERROR:AHB%0d:hm1_hlock change in a bus cycle", $realtime, ID); #10 $finish;
	        end
		if (hm2_hbusreq_d != hm2_hbusreq) begin
	                $display("%0t:ahb_hm2_hbusreq_mon:ERROR:AHB%0d:hm2_hbusreq change in a bus cycle", $realtime, ID); #10 $finish;
	        end
		if (hm2_hlock_d != hm2_hlock) begin
	                $display("%0t:ahb_hm2_hlock_mon:ERROR:AHB%0d:hm2_hlock change in a bus cycle", $realtime, ID); #10 $finish;
	        end
		if (hm3_hbusreq_d != hm3_hbusreq) begin
	                $display("%0t:ahb_hm3_hbusreq_mon:ERROR:AHB%0d:hm3_hbusreq change in a bus cycle", $realtime, ID); #10 $finish;
	        end
		if (hm3_hlock_d != hm3_hlock) begin
	                $display("%0t:ahb_hm3_hlock_mon:ERROR:AHB%0d:hm3_hlock change in a bus cycle", $realtime, ID); #10 $finish;
	        end
	end

end

`endif
`endif
`endif
`endif

wire nds_unused_partially_used_wires = !htrans_dp   |
			    !hm0_hbusreq | !hm1_hbusreq | !hm2_hbusreq | !hm3_hbusreq ;

endmodule
