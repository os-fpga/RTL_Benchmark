// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// Combine InW data and write to OutW data if packed to full word or stop signal


module prim_packer #(
  parameter int InW  = 32,
  parameter int OutW = 32,
  parameter int HintByteData = 0 // If 1, The input/output are byte granularity
) (
  input clk_i ,
  input rst_ni,

  input                   valid_i,
  input        [InW-1:0]  data_i,
  input        [InW-1:0]  mask_i,
  output                  ready_o,

  output logic            valid_o,
  output logic [OutW-1:0] data_o,
  output logic [OutW-1:0] mask_o,
  input                   ready_i,

  input                   flush_i,  // If 1, send out remnant and clear state
  output logic            flush_done_o
);

  localparam int Width = InW + OutW; // storage width
  localparam int ConcatW = Width + InW; // Input concatenated width
  localparam int PtrW = $clog2(ConcatW+1);
  localparam int IdxW = $clog2(InW) + ~|$clog2(InW);

  logic valid_next, ready_next;
  logic [Width-1:0]   stored_data, stored_mask;
  logic [ConcatW-1:0] concat_data, concat_mask;
  logic [ConcatW-1:0] shiftl_data, shiftl_mask;

  logic [PtrW-1:0]          pos, pos_next; // Current write position
  logic [IdxW-1:0]          lod_idx;       // result of Leading One Detector
  logic [$clog2(InW+1)-1:0] inmask_ones;   // Counting Ones for mask_i

  logic ack_in, ack_out;

  logic flush_valid; // flush data out request
  logic flush_done;

  // Computing next position ==================================================
  always_comb begin
    // counting mask_i ones
    inmask_ones = '0;
    for (int i = 0 ; i < InW ; i++) begin
      inmask_ones = inmask_ones + mask_i[i];
    end
  end

  logic [PtrW-1:0] pos_with_input;

  always_comb begin
    pos_next = pos;
    pos_with_input = pos + PtrW'(inmask_ones);

    unique case ({ack_in, ack_out})
      2'b00: pos_next = pos;
      2'b01: pos_next = (pos <= OutW) ? '0 : pos - OutW;
      2'b10: pos_next = pos_with_input;
      2'b11: pos_next = (pos_with_input <= OutW) ? '0 : pos_with_input - OutW;
      default: pos_next = pos;
    endcase
  end

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      pos <= '0;
    end else if (flush_done) begin
      pos <= '0;
    end else begin
      pos <= pos_next;
    end
  end
  //---------------------------------------------------------------------------

  // Leading one detector for mask_i
  always_comb begin
    lod_idx = 0;
    for (int i = InW-1; i >= 0 ; i--) begin
      if (mask_i[i] == 1'b1) begin
        lod_idx = $unsigned(i);
      end
    end
  end

  assign ack_in  = valid_i & ready_o;
  assign ack_out = valid_o & ready_i;

  // Data process =============================================================
  //  shiftl : Input data shifted into the current stored position
  assign shiftl_data = (valid_i) ? Width'(data_i >> lod_idx) << pos : '0;
  assign shiftl_mask = (valid_i) ? Width'(mask_i >> lod_idx) << pos : '0;

  // concat : Merging stored and shiftl
  assign concat_data = {{(InW){1'b0}}, stored_data & stored_mask} |
                       (shiftl_data & shiftl_mask);
  assign concat_mask = {{(InW){1'b0}}, stored_mask} | shiftl_mask;

  logic [Width-1:0] stored_data_next, stored_mask_next;

  always_comb begin
    unique case ({ack_in, ack_out})
      2'b 00: begin
        stored_data_next = stored_data;
        stored_mask_next = stored_mask;
      end
      2'b 01: begin
        // ack_out : shift the amount of OutW
        stored_data_next = {{OutW{1'b0}}, stored_data[Width-1:OutW]};
        stored_mask_next = {{OutW{1'b0}}, stored_mask[Width-1:OutW]};
      end
      2'b 10: begin
        // ack_in : Store concat data
        stored_data_next = concat_data[0+:Width];
        stored_mask_next = concat_mask[0+:Width];
      end
      2'b 11: begin
        // both : shift the concat_data
        stored_data_next = concat_data[ConcatW-1:OutW];
        stored_mask_next = concat_mask[ConcatW-1:OutW];
      end
      default: begin
        stored_data_next = stored_data;
        stored_mask_next = stored_mask;
      end
    endcase
  end

  // Store the data temporary if it doesn't exceed OutW
  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      stored_data <= '0;
      stored_mask <= '0;
    end else if (flush_done) begin
      stored_data <= '0;
      stored_mask <= '0;
    end else begin
      stored_data <= stored_data_next;
      stored_mask <= stored_mask_next;
    end
  end
  //---------------------------------------------------------------------------

  // flush handling
  typedef enum logic {
    FlushIdle,
    FlushSend
  } flush_st_e;
  flush_st_e flush_st, flush_st_next;

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      flush_st <= FlushIdle;
    end else begin
      flush_st <= flush_st_next;
    end
  end

  always_comb begin
    flush_st_next = FlushIdle;

    flush_valid = 1'b0;
    flush_done  = 1'b0;

    unique case (flush_st)
      FlushIdle: begin
        if (flush_i) begin
          flush_st_next = FlushSend;
        end else begin
          flush_st_next = FlushIdle;
        end
      end

      FlushSend: begin
        if (pos == '0) begin
          flush_st_next = FlushIdle;

          flush_valid = 1'b 0;
          flush_done  = 1'b 1;
        end else begin
          flush_st_next = FlushSend;

          flush_valid = 1'b 1;
          flush_done  = 1'b 0;
        end
      end
      default: begin
        flush_st_next = FlushIdle;

        flush_valid = 1'b 0;
        flush_done  = 1'b 0;
      end
    endcase
  end

  assign flush_done_o = flush_done;


  // Output signals ===========================================================
  assign valid_next = (pos >= OutW) ? 1'b 1 : flush_valid;

  // storage space is InW + OutW. So technically, ready_o can be asserted even
  // if `pos` is greater than OutW. But in order to do that, the logic should
  // use `inmask_ones` value whether pos+inmask_ones is less than (InW+OutW)
  // with `valid_i`. It creates a path from `valid_i` --> `ready_o`.
  // It may create a timing loop in some modules that use `ready_o` to
  // `valid_i` (which is not a good practice though)
  assign ready_next = pos <= OutW;

  // Output request
  assign valid_o = valid_next;
  assign data_o  = stored_data[OutW-1:0];
  assign mask_o  = stored_mask[OutW-1:0];

  // ready_o
  assign ready_o = ready_next;
  //---------------------------------------------------------------------------
endmodule
