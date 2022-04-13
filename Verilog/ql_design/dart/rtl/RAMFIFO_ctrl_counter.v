`timescale 1ns / 1ps
/* RAMFIFO_ctrl_counter.v
 * Counter-based control for RAM FIFO
 */
module RAMFIFO_ctrl_counter (
    clock,
    reset,
    enable,
    write,
    read,
    full,
    empty,
    ram_wen,
    ram_waddr,
    ram_raddr,
	ram_raddr_next
);
    parameter WIDTH = 36;
    parameter LOG_DEP = 6;
    localparam DEPTH = 1 << LOG_DEP;
    
    input                   clock;
    input                   reset;
    input                   enable;
    input                   write;
    input                   read;
    
    output                  full;
    output                  empty;
    output                  ram_wen;
    output    [LOG_DEP-1:0] ram_waddr;
    output    [LOG_DEP-1:0] ram_raddr;
	output    [LOG_DEP-1:0] ram_raddr_next;

    // Control signals
    wire                valid_write;
    wire                valid_read;
    wire                next_head_is_tail;
    wire  [LOG_DEP-1:0] next_head;
    wire  [LOG_DEP-1:0] next_tail;
    
    reg                 empty;
    reg   [LOG_DEP-1:0] tail;
    reg   [LOG_DEP-1:0] head;
    
    // Output
    assign full = (head == tail && empty == 1'b0) ? 1'b1 : 1'b0;
    assign ram_wen = valid_write;
    assign ram_waddr = tail;
    assign ram_raddr = head;
	assign ram_raddr_next = next_head;

    // Valid write, high when valid to write data to the FIFO
    assign valid_write = enable & ((read & write) | (write & ~full));
    assign valid_read = enable & (read & ~empty);
    
    // Empty state
    always @(posedge clock)
    begin
        if (reset)
            empty <= 1'b1;
		else if (enable)
		begin
			if (empty & write)
				empty <= 1'b0;
			else if (read & ~write & next_head_is_tail)
				empty <= 1'b1;
		end
    end
    
    // W   R   Action
    // 0   0   head <= head, tail <= tail
    // 0   1   head <= head + 1, tail <= tail
    // 1   0   head <= head, tail = tail + 1
    // 1   1   head <= head + 1, tail <= tail + 1
    always @(posedge clock)
    begin
        if (reset)
        begin
            head <= {(LOG_DEP){1'b0}};
            tail <= {(LOG_DEP){1'b0}};
        end
        else
        begin
            if (valid_read)     head <= next_head;
            if (valid_write)    tail <= next_tail;
        end
    end
    
    assign next_head_is_tail = (next_head == tail) ? 1'b1 : 1'b0;
    assign next_head = head + 1;
    assign next_tail = tail + 1;
    
endmodule
