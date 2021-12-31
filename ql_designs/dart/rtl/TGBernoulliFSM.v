`timescale 1ns / 1ps
/* TGBernoulli.v
 * Bernoulli traffic injection engine
 * Injections a packet when 1) rand_wire < threshold
 *                          2) current time >= lag time
 * Spits out a flit every clock cycle if there is a flit
 * to inject and this unit is enabled
 */
`include "const.v"
module TGBernoulliFSM(
    clock,
    reset,
    enable,
    sim_time,
    measure,            // Approximation: global inject measurement flag
    stop_injection,
    psize,
    sendto,
    obuf_full,          // Output buffer is full
    rand_below_threshold,
    flit_out,
    ready,
    tick_rng
);
    parameter [`ADDR_WIDTH-1:0] HADDR = 0;  // Hardware node address
    parameter PSIZE_WIDTH = 10;
    localparam START = 0,
               INJECT_HEAD = 1,
               INJECT_NORMAL = 2,
               INJECT_WAIT = 3,
               INJECT_TAIL = 3;

    input                       clock;
    input                       reset;
    input                       enable;
    input       [`TS_WIDTH-1:0] sim_time;
    input                       measure;
    input                       stop_injection;
    input     [PSIZE_WIDTH-1:0] psize;
    input     [`ADDR_WIDTH-1:0] sendto;
    input                       obuf_full;
    input                       rand_below_threshold;
    
    output    [`FLIT_WIDTH-1:0] flit_out;
    output                      ready;
    output                      tick_rng;

    // Internal states
    reg        [`TS_WIDTH-1: 0] lag_ts; // Current timestamp of the lagging injection process
    reg      [PSIZE_WIDTH-1: 0] flits_injected;
    
    reg         [CLogB2(3)-1:0] state;
    reg         [CLogB2(3)-1:0] next_state;

    // Wires
    reg                     w_inc_lag_ts;
    reg                     w_tick_rng;
    reg                     w_inject_head, w_inject_normal, w_inject_tail;
    reg                     w_clear_flits_injected;
    wire [PSIZE_WIDTH-1: 0] w_flits_injected;
    wire            [ 9: 0] w_src_or_injection;
    
    
    reg r_tick_rng;
    always @(posedge clock)
    begin
        if (reset)
            r_tick_rng <= 1'b0;
        else
            r_tick_rng <= w_tick_rng;
    end
    
    
    // Output
    assign flit_out = {w_inject_head, w_inject_tail, measure, lag_ts, sendto, w_src_or_injection, 5'h0};
    assign ready = w_inject_head | w_inject_normal | w_inject_tail;
    assign tick_rng = r_tick_rng;
    
    assign w_src_or_injection = (w_inject_head) ? {2'b00, HADDR} : lag_ts;
    assign w_flits_injected = flits_injected + ready;
    
    function integer CLogB2;
	input [31:0] Depth;
	integer i;
	begin
	 	i = Depth;		
		for(CLogB2 = 0; i > 0; CLogB2 = CLogB2 + 1)
			i = i >> 1;
	end
    endfunction
    
    
    // FSM state register
    always @(posedge clock)
    begin
        if (reset)
            state <= 0;
        else if (enable)
            state <= next_state;
    end
    
	// lag_ts is never more than 1 step ahead of sim_time
    wire [`TS_WIDTH-1:0] w_lag_ts_diff;
    wire w_lag_ts_is_behind;
    
    assign w_lag_ts_diff = lag_ts - sim_time;
	assign w_lag_ts_is_behind = (w_lag_ts_diff[`TS_WIDTH-1:1] == 0) ? 1'b0 : 1'b1;	// (lag_ts - sim_time) != 0 or 1
    
    // FSM
    always @(*)
    begin
        next_state = state;
        w_inc_lag_ts = 1'b0;
        w_tick_rng = 1'b0;
        w_inject_head = 1'b0;
        w_inject_normal = 1'b0;
        w_inject_tail = 1'b0;
        w_clear_flits_injected = 1'b0;
        
        case (state)
            START:
            begin
                if (w_lag_ts_is_behind && enable == 1'b1 && stop_injection == 1'b0)
                begin
                    w_tick_rng = 1'b1;
                    if (~rand_below_threshold)  // Don't inject packet this time step
                        w_inc_lag_ts = 1'b1;
                    else    // Inject head
                    begin
                        next_state = INJECT_HEAD;
                    end
                end
            end
            
            INJECT_HEAD:
            begin
                if (~obuf_full)
                begin
                    w_inject_head = 1'b1;
                    
                    if (flits_injected == psize)
                        next_state = INJECT_TAIL;
                    else
                        next_state = INJECT_NORMAL;
                end
            end
            
            INJECT_TAIL:
            begin
                if (~obuf_full)
                begin
                    w_inject_tail = 1'b1;
                    w_clear_flits_injected = 1'b1;
                    w_inc_lag_ts = 1'b1;
                    next_state = START;
                end
            end
            
            INJECT_NORMAL:
            begin
                if (~obuf_full)
                begin
                    w_inject_normal = 1'b1;
                    
                    if (flits_injected == psize)
                        next_state = INJECT_TAIL;
                end
            end
        endcase
    end

    // Update states
    always @(posedge clock)
    begin
        if (reset)
        begin
            lag_ts              <= {(`TS_WIDTH){1'b0}};
            flits_injected      <= {(PSIZE_WIDTH){1'b0}};
        end
        else if (enable)
        begin
            if (w_inc_lag_ts)
                lag_ts <= lag_ts + 1;
            
            if (w_clear_flits_injected)
                flits_injected <= 0;
            else
                flits_injected <= w_flits_injected;
        end
    end
endmodule

