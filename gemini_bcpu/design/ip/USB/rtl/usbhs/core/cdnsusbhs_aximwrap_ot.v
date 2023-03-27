//------------------------------------------------------------------------------
// Copyright (c) 2019 Cadence Design Systems, Inc.
//
// The information herein (Cadence IP) contains confidential and proprietary
// information of Cadence Design Systems, Inc. Cadence IP may not be modified,
// copied, reproduced, distributed, or disclosed to third parties in any manner,
// medium, or form, in whole or in part, without the prior written consent of
// Cadence Design Systems Inc. Cadence IP is for use by Cadence Design Systems,
// Inc. customers only. Cadence Design Systems, Inc. reserves the right to make
// changes to Cadence IP at any time and without notice.
//------------------------------------------------------------------------------
//
//   Filename:           cdnsusbhs_aximwrap_ot.v
//   Module Name:        cdnsusbhs_aximwrap_ot
//
//   Release Revision:   R128_F015
//   Release SVN Tag:    USBHS_DUS1301_R128_F015_H03X32T08A32
//
//   IP Name:            USBHS-OTG
//   IP Part Number:     IP4010E
//
//   Product Type:       Configurable
//   IP Type:            Soft IP
//   IP Family:          USB
//   Technology:         N/A
//   Protocol:           USB2
//   Architecture:       OTGCTL
//   Licensable IP:      N/A
//
//------------------------------------------------------------------------------
//   Description:
//   CDNSAXIMWRAP sub module: OT
//   Outstanding Transaction counter. Incremented at each accepted AXI command
//   and decremented at last data beat.
//------------------------------------------------------------------------------




`include "cdnsusbhs_cusb2_defines.v"



module cdnsusbhs_aximwrap_ot
(
  aclk,
  aresetn,
  max,
  axvalid,
  axready,
  xvalid,
  xready,
  xlast,
  cnt,
  limit
);

parameter MAX_OT_WIDTH = 32'd4;
parameter LAST_NOT_USED = 32'd0;
parameter AXI_OT_W = 32'd8;

input  aclk;
input  aresetn;
input [AXI_OT_W-1:0] max;
input  axvalid;
input  axready;
input  xvalid;
input  xready;
input  xlast;
output [MAX_OT_WIDTH:0] cnt;
output limit;

reg [MAX_OT_WIDTH:0] cnt_r;
wire [MAX_OT_WIDTH:0] max_ot;
wire inc;
wire dec;

assign max_ot = max[MAX_OT_WIDTH:0] + 1;
assign inc   = axvalid & axready;

generate
  if(LAST_NOT_USED == 32'd0)
  begin : LAST_USED_GENERATE
    assign dec = xvalid & xready & xlast;
  end
  else
  begin : LAST_NOT_USED_GENERATE
    assign dec = xvalid & xready;
  end
endgenerate

assign limit =
  (
    (cnt_r == max_ot) ||
    (
      (cnt_r == (max_ot-5'd1)) &&
      inc &&
      (!dec)
    )
  );

`CDNSUSBHS_ALWAYS(aclk,aresetn)
begin : CNT_PROC
  if `CDNSUSBHS_RESET(aresetn)
  begin
    cnt_r <= {(MAX_OT_WIDTH+1){1'b0}};
  end
  else
  begin
    if( !(inc && dec) )
    begin
      if( inc )
      begin
        cnt_r <= cnt_r + 1;
      end
      else
      begin
        if( dec )
        begin
          cnt_r <= cnt_r - 1;
        end
      end
    end
  end
end

assign cnt = cnt_r;

endmodule
