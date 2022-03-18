//-----------------------------------------------------------------------------
// Title         : sip_xpcs_comma_detect
// Project       : SIP
//-----------------------------------------------------------------------------
// File          : sip_xpcs_comma_detect.v
// Author        : Lior Valency
// Created       : 19/02/2008
// Last modified : 19/02/2008
//-----------------------------------------------------------------------------
// Description : This block is the comma detect block. It search for comma
// for data received from serdes, after comma is found offset is locked 
// and correct data is forwarded to next block.    
//-----------------------------------------------------------------------------
// Copyright (c) 2007  Marvell International Ltd.
//
// THIS CODE CONTAINS CONFIDENTIAL INFORMATION OF MARVELL SEMICONDUCTOR, INC.
// NO RIGHTS ARE GRANTED HEREIN UNDER ANY PATENT, MASK WORK RIGHT OR COPYRIGHT
// OF MARVELL OR ANY THIRD PARTY. MARVELL RESERVES THE RIGHT AT ITS SOLE
// DISCRETION TO REQUEST THAT THIS CODE BE IMMEDIATELY RETURNED TO MARVELL.
// THIS CODE IS PROVIDED "AS IS". MARVELL MAKES NO WARRANTIES, EXPRESS,
// IMPLIED OR OTHERWISE, REGARDING ITS ACCURACY, COMPLETENESS OR PERFORMANCE.
//
//------------------------------------------------------------------------------
// Modification history :
// 12/12/2007  : created
//-----------------------------------------------------------------------------
module sip_xpcs_comma_detect (/*AUTOARG*/
   // Outputs
   lock, rout, 
   // Inputs
   bypass, clk, comma_valid0, comma_valid1, commaa, commab, 
   data_special_valid0, data_special_valid1, reset, rin, sel_comma, 
   sigdet, en_comma_align_glob, rf_en_2sync
   );



   output		lock;			// From cd_ssm of cd_ssm.v
   output [19:0]	rout;			// From cd_mux of cd_mux.v

   input		bypass;			// To cd_7bit of cd_7bit.v, ...
   input		clk;			// To cd_7bit of cd_7bit.v, ...
   input		comma_valid0;		// To cd_ssm of cd_ssm.v
   input		comma_valid1;		// To cd_ssm of cd_ssm.v
   input [9:0]		commaa;			// To cd_10bit of cd_10bit.v
   input [9:0]		commab;			// To cd_10bit of cd_10bit.v
   input		data_special_valid0;	// To cd_ssm of cd_ssm.v
   input		data_special_valid1;	// To cd_ssm of cd_ssm.v
   input		reset;			// To cd_7bit of cd_7bit.v, ...
   input [19:0]		rin;			// To cd_7bit of cd_7bit.v, ...
   input		sel_comma;		// To cd_7bit of cd_7bit.v, ...
   input		sigdet;			// To cd_ssm of cd_ssm.v
   input 		en_comma_align_glob;    // To cd_ssm. Added by Erez Reches 21Oct01
   input                rf_en_2sync;          // Skip Synch FSM 
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			bypass_sync;		// From cd_sync of cd_sync.v
   wire [9:0]		commaa_sync;		// From cd_sync of cd_sync.v
   wire [9:0]		commab_sync;		// From cd_sync of cd_sync.v
   wire			enable_cgalign;		// From cd_ssm of cd_ssm.v
   wire [4:0]		position_10bit;		// From cd_10bit of cd_10bit.v
   wire [4:0]		position_7bit;		// From cd_7bit of cd_7bit.v
   wire			reset_sync;		// From cd_sync of cd_sync.v
   wire			sel_comma_sync;		// From cd_sync of cd_sync.v
   wire			sigdet_sync;		// From cd_sync of cd_sync.v
   wire [10:0]		sync_state;		// From cd_ssm of cd_ssm.v
   wire [10:0]		sync_state_z;		// From cd_ssm of cd_ssm.v
   // End of automatics

   wire                 rf_en_2sync_sync;

/*
   cd_ssm AUTO_TEMPLATE (
		  // Outputs
		  .sync_status		(lock));
*/


// drorb: Sample input signals
   sip_xpcs_cd_sync cd_sync (/*AUTOINST*/
		    // Outputs
		    .bypass_sync	(bypass_sync),
		    .commaa_sync	(commaa_sync[9:0]),
		    .commab_sync	(commab_sync[9:0]),
		    .reset_sync		(reset_sync),
		    .sel_comma_sync	(sel_comma_sync),
		    .sigdet_sync	(sigdet_sync),
		    .rf_en_2sync_sync(rf_en_2sync_sync),
		    // Inputs
		    .bypass		(bypass),
		    .clk		(clk),
		    .commaa		(commaa[9:0]),
		    .commab		(commab[9:0]),
		    .reset		(reset),
		    .sel_comma		(sel_comma),
		    .sigdet		(sigdet),
		    .rf_en_2sync           (rf_en_2sync));


// drorb: Find comma index 
   sip_xpcs_cd_7bit cd_7bit (/*AUTOINST*/
		    // Outputs
		    .position_7bit	(position_7bit[4:0]),
		    // Inputs
		    .bypass_sync	(bypass_sync),
		    .clk		(clk),
		    .enable_cgalign	(enable_cgalign),
		    .reset_sync		(reset_sync),
		    .rin		(rin[19:0]),
		    .sel_comma_sync	(sel_comma_sync));


// drorb: This block is not used.
   sip_xpcs_cd_10bit cd_10bit (/*AUTOINST*/
		      // Outputs
		      .position_10bit	(position_10bit[4:0]),
		      // Inputs
		      .bypass_sync	(bypass_sync),
		      .clk		(clk),
		      .commaa_sync	(commaa_sync[9:0]),
		      .commab_sync	(commab_sync[9:0]),
		      .enable_cgalign	(enable_cgalign),
		      .reset_sync	(reset_sync),
		      .rin		(rin[19:0]),
		      .sel_comma_sync	(sel_comma_sync));



// drorb: The 'cd_ssm' is the standard Synch FSM (Figure 48-7, 802.3ae)

   sip_xpcs_cd_ssm cd_ssm (/*AUTOINST*/
		  // Outputs
		  .enable_cgalign	(enable_cgalign),
		  .sync_status		(lock),			 // Templated
		  .sync_state		(sync_state[10:0]),
		  .sync_state_z		(sync_state_z[10:0]),
		  // Inputs
		  .bypass_sync		(bypass_sync),
		  .clk			(clk),
		  .comma_valid0		(comma_valid0),
		  .comma_valid1		(comma_valid1),
		  .data_special_valid0	(data_special_valid0),
		  .data_special_valid1	(data_special_valid1),
		  .reset_sync		(reset_sync),
		  .sigdet_sync		(sigdet_sync),
		  .en_comma_align_glob	(en_comma_align_glob),
		  .rf_en_2sync_sync   (rf_en_2sync_sync));


// drorb: 'sel_comma_sync' is always 1 (at Top level), which means only position_7bit is used.

   sip_xpcs_cd_mux cd_mux (/*AUTOINST*/
		  // Outputs
		  .rout			(rout[19:0]),
		  // Inputs
		  .bypass_sync		(bypass_sync),
		  .clk			(clk),
		  .position_7bit	(position_7bit[4:0]),
		  .position_10bit	(position_10bit[4:0]),
		  .rin			(rin[19:0]),
		  .sel_comma_sync	(sel_comma_sync));

endmodule // comma_detect


module sip_xpcs_cd_sync (/*AUTOARG*/
   // Outputs
   bypass_sync, commaa_sync, commab_sync, reset_sync, sel_comma_sync, 
   sigdet_sync, rf_en_2sync_sync, 
   // Inputs
   bypass, clk, commaa, commab, reset, sel_comma, sigdet, rf_en_2sync
   );

   output bypass_sync;
   output [9:0] commaa_sync;
   output [9:0] commab_sync;
   output reset_sync;
   output sel_comma_sync;
   output sigdet_sync;
   output rf_en_2sync_sync;

   input bypass;
   input clk;
   input [9:0] commaa;
   input [9:0] commab;
   input reset;
   input sel_comma;
   input sigdet;
   input rf_en_2sync; 

   reg bypass_sync;
   reg [9:0] commaa_sync;
   reg [9:0] commab_sync;
   reg reset_sync;
   reg sel_comma_sync;
   reg sigdet_sync;
   reg rf_en_2sync_sync;

   always @(posedge clk)
    begin
     bypass_sync <= #1 bypass;
     commaa_sync <= #1 commaa;
     commab_sync <= #1 commab;
     reset_sync <= #1 reset;
     sel_comma_sync <= #1 sel_comma;
     sigdet_sync <= #1 sigdet;
     rf_en_2sync_sync <= #1 rf_en_2sync;
    end

endmodule // cd_sync


module sip_xpcs_cd_7bit (/*AUTOARG*/
   // Outputs
   position_7bit, 
   // Inputs
   bypass_sync, clk, enable_cgalign, reset_sync, rin, sel_comma_sync
   );

   output [4:0] position_7bit;

   input bypass_sync;
   input clk;
   input enable_cgalign;
   input reset_sync;
   input [19:0] rin;
   input sel_comma_sync;

   parameter COMMA_N = 7'b1111100;
   parameter COMMA_P = 7'b0000011;
   parameter POSITION_0 = 5'd0;
   parameter POSITION_1 = 5'd1;
   parameter POSITION_2 = 5'd2;
   parameter POSITION_3 = 5'd3;
   parameter POSITION_4 = 5'd4;
   parameter POSITION_5 = 5'd5;
   parameter POSITION_6 = 5'd6;
   parameter POSITION_7 = 5'd7;
   parameter POSITION_8 = 5'd8;
   parameter POSITION_9 = 5'd9;
   parameter POSITION_10 = 5'd10;
   parameter POSITION_11 = 5'd11;
   parameter POSITION_12 = 5'd12;
   parameter POSITION_13 = 5'd13;
   parameter POSITION_14 = 5'd14;
   parameter POSITION_15 = 5'd15;
   parameter POSITION_16 = 5'd16;
   parameter POSITION_17 = 5'd17;
   parameter POSITION_18 = 5'd18;
   parameter POSITION_19 = 5'd19;

   reg comma_found;
   //reg [19:0] comma_pos;
   reg [4:0] position_7bit;
   reg [4:0] position;
   reg [19:0] rin_z;
   
   reg comma_pos_0;
   reg comma_pos_1;
   reg comma_pos_2;
   reg comma_pos_3;
   reg comma_pos_4;
   reg comma_pos_5;
   reg comma_pos_6;
   reg comma_pos_7;
   reg comma_pos_8;
   reg comma_pos_9;
   reg comma_pos_10;
   reg comma_pos_11;
   reg comma_pos_12;
   reg comma_pos_13;
   reg comma_pos_14;
   reg comma_pos_15;
   reg comma_pos_16;
   reg comma_pos_17;
   reg comma_pos_18;
   reg comma_pos_19;


   wire [19:0] comma_pos;

   assign comma_pos = {comma_pos_19,
                       comma_pos_18,
                       comma_pos_17,
                       comma_pos_16,
                       comma_pos_15,
                       comma_pos_14,
                       comma_pos_13,
                       comma_pos_12,
                       comma_pos_11,
                       comma_pos_10,
                       comma_pos_9,
                       comma_pos_8,
                       comma_pos_7,
                       comma_pos_6,
                       comma_pos_5,
                       comma_pos_4,
                       comma_pos_3,
                       comma_pos_2,
                       comma_pos_1,
                       comma_pos_0};
     
   wire [25:0] datain;
   wire reset_7bit_det;

   assign reset_7bit_det = reset_sync | bypass_sync | ~sel_comma_sync;
   assign datain = {rin[5:0],rin_z};

   always @(posedge clk)
    begin
     rin_z <= #1 rin;
    end

   always @(posedge clk)
    begin
     if (reset_7bit_det)
      begin
       comma_pos_0 <= 1'b0;
      end
     else if ((datain[6:0] == COMMA_N) | (datain[6:0] == COMMA_P))
      begin
       comma_pos_0 <= 1'b1;
      end
     else
      begin
       comma_pos_0 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_7bit_det)
      begin
       comma_pos_1 <= 1'b0;
      end
     else if ((datain[7:1] == COMMA_N) | (datain[7:1] == COMMA_P))
      begin
       comma_pos_1 <= 1'b1;
      end
     else
      begin
       comma_pos_1 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_7bit_det)
      begin
       comma_pos_2 <= 1'b0;
      end
     else if ((datain[8:2] == COMMA_N) | (datain[8:2] == COMMA_P))
      begin
       comma_pos_2 <= 1'b1;
      end
     else
      begin
       comma_pos_2 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_7bit_det)
      begin
       comma_pos_3 <= 1'b0;
      end
     else if ((datain[9:3] == COMMA_N) | (datain[9:3] == COMMA_P))
      begin
       comma_pos_3 <= 1'b1;
      end
     else
      begin
       comma_pos_3 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_7bit_det)
      begin
       comma_pos_4 <= 1'b0;
      end
     else if ((datain[10:4] == COMMA_N) | (datain[10:4] == COMMA_P))
      begin
       comma_pos_4 <= 1'b1;
      end
     else
      begin
       comma_pos_4 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_7bit_det)
      begin
       comma_pos_5 <= 1'b0;
      end
     else if ((datain[11:5] == COMMA_N) | (datain[11:5] == COMMA_P))
      begin
       comma_pos_5 <= 1'b1;
      end
     else
      begin
       comma_pos_5 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_7bit_det)
      begin
       comma_pos_6 <= 1'b0;
      end
     else if ((datain[12:6] == COMMA_N) | (datain[12:6] == COMMA_P))
      begin
       comma_pos_6 <= 1'b1;
      end
     else
      begin
       comma_pos_6 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_7bit_det)
      begin
       comma_pos_7 <= 1'b0;
      end
     else if ((datain[13:7] == COMMA_N) | (datain[13:7] == COMMA_P))
      begin
       comma_pos_7 <= 1'b1;
      end
     else
      begin
       comma_pos_7 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_7bit_det)
      begin
       comma_pos_8 <= 1'b0;
      end
     else if ((datain[14:8] == COMMA_N) | (datain[14:8] == COMMA_P))
      begin
       comma_pos_8 <= 1'b1;
      end
     else
      begin
       comma_pos_8 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_7bit_det)
      begin
       comma_pos_9 <= 1'b0;
      end
     else if ((datain[15:9] == COMMA_N) | (datain[15:9] == COMMA_P))
      begin
       comma_pos_9 <= 1'b1;
      end
     else
      begin
       comma_pos_9 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_7bit_det)
      begin
       comma_pos_10 <= 1'b0;
      end
     else if ((datain[16:10] == COMMA_N) | (datain[16:10] == COMMA_P))
      begin
       comma_pos_10 <= 1'b1;
      end
     else
      begin
       comma_pos_10 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_7bit_det)
      begin
       comma_pos_11 <= 1'b0;
      end
     else if ((datain[17:11] == COMMA_N) | (datain[17:11] == COMMA_P))
      begin
       comma_pos_11 <= 1'b1;
      end
     else
      begin
       comma_pos_11 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_7bit_det)
      begin
       comma_pos_12 <= 1'b0;
      end
     else if ((datain[18:12] == COMMA_N) | (datain[18:12] == COMMA_P))
      begin
       comma_pos_12 <= 1'b1;
      end
     else
      begin
       comma_pos_12 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_7bit_det)
      begin
       comma_pos_13 <= 1'b0;
      end
     else if ((datain[19:13] == COMMA_N) | (datain[19:13] == COMMA_P))
      begin
       comma_pos_13 <= 1'b1;
      end
     else
      begin
       comma_pos_13 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_7bit_det)
      begin
       comma_pos_14 <= 1'b0;
      end
     else if ((datain[20:14] == COMMA_N) | (datain[20:14] == COMMA_P))
      begin
       comma_pos_14 <= 1'b1;
      end
     else
      begin
       comma_pos_14 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_7bit_det)
      begin
       comma_pos_15 <= 1'b0;
      end
     else if ((datain[21:15] == COMMA_N) | (datain[21:15] == COMMA_P))
      begin
       comma_pos_15 <= 1'b1;
      end
     else
      begin
       comma_pos_15 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_7bit_det)
      begin
       comma_pos_16 <= 1'b0;
      end
     else if ((datain[22:16] == COMMA_N) | (datain[22:16] == COMMA_P))
      begin
       comma_pos_16 <= 1'b1;
      end
     else
      begin
       comma_pos_16 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_7bit_det)
      begin
       comma_pos_17 <= 1'b0;
      end
     else if ((datain[23:17] == COMMA_N) | (datain[23:17] == COMMA_P))
      begin
       comma_pos_17 <= 1'b1;
      end
     else
      begin
       comma_pos_17 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_7bit_det)
      begin
       comma_pos_18 <= 1'b0;
      end
     else if ((datain[24:18] == COMMA_N) | (datain[24:18] == COMMA_P))
      begin
       comma_pos_18 <= 1'b1;
      end
     else
      begin
       comma_pos_18 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_7bit_det)
      begin
       comma_pos_19 <= 1'b0;
      end
     else if ((datain[25:19] == COMMA_N) | (datain[25:19] == COMMA_P))
      begin
       comma_pos_19 <= 1'b1;
      end
     else
      begin
       comma_pos_19 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_7bit_det)
      begin
       position_7bit <= #1 POSITION_0;
      end
     else if (~enable_cgalign)
      begin
       position_7bit <= #1 position_7bit;
      end
     else if (comma_found)
      begin
       position_7bit <= #1 position;
      end
     else
      begin
       position_7bit <= #1 position_7bit;
      end
    end

   always @(/*AUTOSENSE*/comma_pos or reset_7bit_det)
    begin
     if (reset_7bit_det)
      begin
       position = POSITION_0;
       comma_found = 1'b0;
      end // if (reset_7bit_det)
     else
      begin
       case (comma_pos) 
        20'b00000000000000000001, 20'b00000000010000000001:
         begin
          comma_found = 1'b1;
          position = POSITION_0;
         end
        20'b00000000000000000010, 20'b00000000100000000010:
         begin
          comma_found = 1'b1;
          position = POSITION_1;
         end
        20'b00000000000000000100, 20'b00000001000000000100:
         begin
          comma_found = 1'b1;
          position = POSITION_2;
         end
        20'b00000000000000001000, 20'b00000010000000001000:
         begin
          comma_found = 1'b1;
          position = POSITION_3;
         end
        20'b00000000000000010000, 20'b00000100000000010000:
         begin
          comma_found = 1'b1;
          position = POSITION_4;
         end
        20'b00000000000000100000, 20'b00001000000000100000:
         begin
          comma_found = 1'b1;
          position = POSITION_5;
         end
        20'b00000000000001000000, 20'b00010000000001000000:
         begin
          comma_found = 1'b1;
          position = POSITION_6;
         end
        20'b00000000000010000000, 20'b00100000000010000000:
         begin
          comma_found = 1'b1;
          position = POSITION_7;
         end
        20'b00000000000100000000, 20'b01000000000100000000:
         begin
          comma_found = 1'b1;
          position = POSITION_8;
         end
        20'b00000000001000000000, 20'b10000000001000000000:
         begin
          comma_found = 1'b1;
          position = POSITION_9;
         end
        20'b00000000010000000000:
         begin
          comma_found = 1'b1;
          position = POSITION_10;
         end
        20'b00000000100000000000:
         begin
          comma_found = 1'b1;
          position = POSITION_11;
         end
        20'b00000001000000000000:
         begin
          comma_found = 1'b1;
          position = POSITION_12;
         end
        20'b00000010000000000000:
         begin
          comma_found = 1'b1;
          position = POSITION_13;
         end
        20'b00000100000000000000:
         begin
          comma_found = 1'b1;
          position = POSITION_14;
         end
        20'b00001000000000000000:
         begin
          comma_found = 1'b1;
          position = POSITION_15;
         end
        20'b00010000000000000000:
         begin
          comma_found = 1'b1;
          position = POSITION_16;
         end
        20'b00100000000000000000:
         begin
          comma_found = 1'b1;
          position = POSITION_17;
         end
        20'b01000000000000000000:
         begin
          comma_found = 1'b1;
          position = POSITION_18;
         end
        20'b10000000000000000000:
         begin
          comma_found = 1'b1;
          position = POSITION_19;
         end
        default:
         begin
          comma_found = 1'b0;
          position = POSITION_0;
         end
       endcase
      end
    end

endmodule // cd_7bit


module sip_xpcs_cd_10bit (/*AUTOARG*/
   // Outputs
   position_10bit, 
   // Inputs
   bypass_sync, clk, commaa_sync, commab_sync, enable_cgalign, 
   reset_sync, rin, sel_comma_sync
   );

   output [4:0] position_10bit;

   input bypass_sync;
   input clk;
   input [9:0] commaa_sync;
   input [9:0] commab_sync;
   input enable_cgalign;
   input reset_sync;
   input [19:0] rin;
   input sel_comma_sync;

   parameter COMMA_N = 7'b1111100;
   parameter COMMA_P = 7'b0000011;
   parameter POSITION_0 = 5'd0;
   parameter POSITION_1 = 5'd1;
   parameter POSITION_2 = 5'd2;
   parameter POSITION_3 = 5'd3;
   parameter POSITION_4 = 5'd4;
   parameter POSITION_5 = 5'd5;
   parameter POSITION_6 = 5'd6;
   parameter POSITION_7 = 5'd7;
   parameter POSITION_8 = 5'd8;
   parameter POSITION_9 = 5'd9;
   parameter POSITION_10 = 5'd10;
   parameter POSITION_11 = 5'd11;
   parameter POSITION_12 = 5'd12;
   parameter POSITION_13 = 5'd13;
   parameter POSITION_14 = 5'd14;
   parameter POSITION_15 = 5'd15;
   parameter POSITION_16 = 5'd16;
   parameter POSITION_17 = 5'd17;
   parameter POSITION_18 = 5'd18;
   parameter POSITION_19 = 5'd19;

   reg comma_found;
   //reg [19:0] comma_pos;
   reg [4:0] position_10bit;
   reg [4:0] position;
   reg [19:0] rin_z;

   reg comma_pos_0;
   reg comma_pos_1;
   reg comma_pos_2;
   reg comma_pos_3;
   reg comma_pos_4;
   reg comma_pos_5;
   reg comma_pos_6;
   reg comma_pos_7;
   reg comma_pos_8;
   reg comma_pos_9;
   reg comma_pos_10;
   reg comma_pos_11;
   reg comma_pos_12;
   reg comma_pos_13;
   reg comma_pos_14;
   reg comma_pos_15;
   reg comma_pos_16;
   reg comma_pos_17;
   reg comma_pos_18;
   reg comma_pos_19;

   wire [19:0] comma_pos;
   assign comma_pos = {comma_pos_19,
                       comma_pos_18,
                       comma_pos_17,
                       comma_pos_16,
                       comma_pos_15,
                       comma_pos_14,
                       comma_pos_13,
                       comma_pos_12,
                       comma_pos_11,
                       comma_pos_10,
                       comma_pos_9,
                       comma_pos_8,
                       comma_pos_7,
                       comma_pos_6,
                       comma_pos_5,
                       comma_pos_4,
                       comma_pos_3,
                       comma_pos_2,
                       comma_pos_1,
                       comma_pos_0};

   wire [28:0] datain;
   wire reset_10bit_det;

   assign reset_10bit_det = reset_sync | bypass_sync | sel_comma_sync;
   assign datain = {rin[8:0],rin_z};

   always @(posedge clk)
    begin
     rin_z <= #1 rin;
    end

   always @(posedge clk)
    begin
     if (reset_10bit_det)
      begin
       comma_pos_0 <= 1'b0;
      end
     else if ((datain[9:0] == commaa_sync) | (datain[9:0] == commab_sync))
      begin
       comma_pos_0 <= 1'b1;
      end
     else
      begin
       comma_pos_0 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_10bit_det)
      begin
       comma_pos_1 <= 1'b0;
      end
     else if ((datain[10:1] == commaa_sync) | (datain[10:1] == commab_sync))
      begin
       comma_pos_1 <= 1'b1;
      end
     else
      begin
       comma_pos_1 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_10bit_det)
      begin
       comma_pos_2 <= 1'b0;
      end
     else if ((datain[11:2] == commaa_sync) | (datain[11:2] == commab_sync))
      begin
       comma_pos_2 <= 1'b1;
      end
     else
      begin
       comma_pos_2 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_10bit_det)
      begin
       comma_pos_3 <= 1'b0;
      end
     else if ((datain[12:3] == commaa_sync) | (datain[12:3] == commab_sync))
      begin
       comma_pos_3 <= 1'b1;
      end
     else
      begin
       comma_pos_3 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_10bit_det)
      begin
       comma_pos_4 <= 1'b0;
      end
     else if ((datain[13:4] == commaa_sync) | (datain[13:4] == commab_sync))
      begin
       comma_pos_4 <= 1'b1;
      end
     else
      begin
       comma_pos_4 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_10bit_det)
      begin
       comma_pos_5 <= 1'b0;
      end
     else if ((datain[14:5] == commaa_sync) | (datain[14:5] == commab_sync))
      begin
       comma_pos_5 <= 1'b1;
      end
     else
      begin
       comma_pos_5 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_10bit_det)
      begin
       comma_pos_6 <= 1'b0;
      end
     else if ((datain[15:6] == commaa_sync) | (datain[15:6] == commab_sync))
      begin
       comma_pos_6 <= 1'b1;
      end
     else
      begin
       comma_pos_6 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_10bit_det)
      begin
       comma_pos_7 <= 1'b0;
      end
     else if ((datain[16:7] == commaa_sync) | (datain[16:7] == commab_sync))
      begin
       comma_pos_7 <= 1'b1;
      end
     else
      begin
       comma_pos_7 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_10bit_det)
      begin
       comma_pos_8 <= 1'b0;
      end
     else if ((datain[17:8] == commaa_sync) | (datain[17:8] == commab_sync))
      begin
       comma_pos_8 <= 1'b1;
      end
     else
      begin
       comma_pos_8 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_10bit_det)
      begin
       comma_pos_9 <= 1'b0;
      end
     else if ((datain[18:9] == commaa_sync) | (datain[18:9] == commab_sync))
      begin
       comma_pos_9 <= 1'b1;
      end
     else
      begin
       comma_pos_9 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_10bit_det)
      begin
       comma_pos_10 <= 1'b0;
      end
     else if ((datain[19:10] == commaa_sync) | (datain[19:10] == commab_sync))
      begin
       comma_pos_10 <= 1'b1;
      end
     else
      begin
       comma_pos_10 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_10bit_det)
      begin
       comma_pos_11 <= 1'b0;
      end
     else if ((datain[20:11] == commaa_sync) | (datain[20:11] == commab_sync))
      begin
       comma_pos_11 <= 1'b1;
      end
     else
      begin
       comma_pos_11 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_10bit_det)
      begin
       comma_pos_12 <= 1'b0;
      end
     else if ((datain[21:12] == commaa_sync) | (datain[21:12] == commab_sync))
      begin
       comma_pos_12 <= 1'b1;
      end
     else
      begin
       comma_pos_12 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_10bit_det)
      begin
       comma_pos_13 <= 1'b0;
      end
     else if ((datain[22:13] == commaa_sync) | (datain[22:13] == commab_sync))
      begin
       comma_pos_13 <= 1'b1;
      end
     else
      begin
       comma_pos_13 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_10bit_det)
      begin
       comma_pos_14 <= 1'b0;
      end
     else if ((datain[23:14] == commaa_sync) | (datain[23:14] == commab_sync))
      begin
       comma_pos_14 <= 1'b1;
      end
     else
      begin
       comma_pos_14 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_10bit_det)
      begin
       comma_pos_15 <= 1'b0;
      end
     else if ((datain[24:15] == commaa_sync) | (datain[24:15] == commab_sync))
      begin
       comma_pos_15 <= 1'b1;
      end
     else
      begin
       comma_pos_15 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_10bit_det)
      begin
       comma_pos_16 <= 1'b0;
      end
     else if ((datain[25:16] == commaa_sync) | (datain[25:16] == commab_sync))
      begin
       comma_pos_16 <= 1'b1;
      end
     else
      begin
       comma_pos_16 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_10bit_det)
      begin
       comma_pos_17 <= 1'b0;
      end
     else if ((datain[26:17] == commaa_sync) | (datain[26:17] == commab_sync))
      begin
       comma_pos_17 <= 1'b1;
      end
     else
      begin
       comma_pos_17 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_10bit_det)
      begin
       comma_pos_18 <= 1'b0;
      end
     else if ((datain[27:18] == commaa_sync) | (datain[27:18] == commab_sync))
      begin
       comma_pos_18 <= 1'b1;
      end
     else
      begin
       comma_pos_18 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_10bit_det)
      begin
       comma_pos_19 <= 1'b0;
      end
     else if ((datain[28:19] == commaa_sync) | (datain[28:19] == commab_sync))
      begin
       comma_pos_19 <= 1'b1;
      end
     else
      begin
       comma_pos_19 <= 1'b0;
      end
    end

   always @(posedge clk)
    begin
     if (reset_10bit_det)
      begin
       position_10bit <= #1 POSITION_0;
      end
     else if (~enable_cgalign)
      begin
       position_10bit <= #1 position_10bit;
      end
     else if (comma_found)
      begin
       position_10bit <= #1 position;
      end
     else
      begin
       position_10bit <= #1 position_10bit;
      end
    end

   always @(/*AUTOSENSE*/comma_pos or reset_10bit_det)
    begin
     if (reset_10bit_det)
      begin
       comma_found = 1'b0;
       position = POSITION_0;
      end
     else
      begin
       case (comma_pos) 
        20'b00000000000000000001, 20'b00000000010000000001:
         begin
          comma_found = 1'b1;
          position = POSITION_0;
         end
        20'b00000000000000000010, 20'b00000000100000000010:
         begin
          comma_found = 1'b1;
          position = POSITION_1;
         end
        20'b00000000000000000100, 20'b00000001000000000100:
         begin
          comma_found = 1'b1;
          position = POSITION_2;
         end
        20'b00000000000000001000, 20'b00000010000000001000:
         begin
          comma_found = 1'b1;
          position = POSITION_3;
         end
        20'b00000000000000010000, 20'b00000100000000010000:
         begin
          comma_found = 1'b1;
          position = POSITION_4;
         end
        20'b00000000000000100000, 20'b00001000000000100000:
         begin
          comma_found = 1'b1;
          position = POSITION_5;
         end
        20'b00000000000001000000, 20'b00010000000001000000:
         begin
          comma_found = 1'b1;
          position = POSITION_6;
         end
        20'b00000000000010000000, 20'b00100000000010000000:
         begin
          comma_found = 1'b1;
          position = POSITION_7;
         end
        20'b00000000000100000000, 20'b01000000000100000000:
         begin
          comma_found = 1'b1;
          position = POSITION_8;
         end
        20'b00000000001000000000, 20'b10000000001000000000:
         begin
          comma_found = 1'b1;
          position = POSITION_9;
         end
        20'b00000000010000000000:
         begin
          comma_found = 1'b1;
          position = POSITION_10;
         end
        20'b00000000100000000000:
         begin
          comma_found = 1'b1;
          position = POSITION_11;
         end
        20'b00000001000000000000:
         begin
          comma_found = 1'b1;
          position = POSITION_12;
         end
        20'b00000010000000000000:
         begin
          comma_found = 1'b1;
          position = POSITION_13;
         end
        20'b00000100000000000000:
         begin
          comma_found = 1'b1;
          position = POSITION_14;
         end
        20'b00001000000000000000:
         begin
          comma_found = 1'b1;
          position = POSITION_15;
         end
        20'b00010000000000000000:
         begin
          comma_found = 1'b1;
          position = POSITION_16;
         end
        20'b00100000000000000000:
         begin
          comma_found = 1'b1;
          position = POSITION_17;
         end
        20'b01000000000000000000:
         begin
          comma_found = 1'b1;
          position = POSITION_18;
         end
        20'b10000000000000000000:
         begin
          comma_found = 1'b1;
          position = POSITION_19;
         end
        default:
         begin
          comma_found = 1'b0;
          position = POSITION_0;
         end
       endcase
      end
    end

endmodule // cd_10bit


module sip_xpcs_cd_ssm (/*AUTOARG*/
   // Outputs
   enable_cgalign, sync_status, sync_state, sync_state_z, 
   // Inputs
   bypass_sync, clk, comma_valid0, comma_valid1, data_special_valid0, 
   data_special_valid1, reset_sync, sigdet_sync, en_comma_align_glob,
   rf_en_2sync_sync
   );

   output enable_cgalign;
   output sync_status;
   output [10:0] sync_state;
   output [10:0] sync_state_z;

   input bypass_sync;
   input clk;
   input comma_valid0;
   input comma_valid1;
   input data_special_valid0;
   input data_special_valid1;
   input reset_sync;
   input sigdet_sync;
   input en_comma_align_glob;  //Added by Erez Reches 21Oct01
   input rf_en_2sync_sync;   // drorb


   // comma code groups
   //parameter K28_7 = 8'b1111_1100;
   parameter K28_5 = 8'b1011_1100; // sync K code group
   //parameter K28_1 = 8'b0011_1100;

   parameter K28_3 = 8'b0111_1100; // align code group

   parameter FALSE = 1'b0;
   parameter TRUE  = 1'b1;

   parameter SYNC_FAIL = 1'b0;
   parameter SYNC_OK   = 1'b1;

   parameter LOSS_OF_SYNC     = 11'b00000000001;
   parameter COMMA_DETECT_1   = 11'b00000000010;
   parameter COMMA_DETECT_2   = 11'b00000000100;
   parameter COMMA_DETECT_3   = 11'b00000001000;
   parameter SYNC_ACQUIRED_1  = 11'b00000010000;
   parameter SYNC_ACQUIRED_2  = 11'b00000100000;
   parameter SYNC_ACQUIRED_2A = 11'b00001000000;
   parameter SYNC_ACQUIRED_3  = 11'b00010000000;
   parameter SYNC_ACQUIRED_3A = 11'b00100000000;
   parameter SYNC_ACQUIRED_4  = 11'b01000000000;
   parameter SYNC_ACQUIRED_4A = 11'b10000000000;

   reg sigdet_z;
   wire sigdet_change;

   wire reset_ssm;

   reg enable_cgalign;
   reg enable_cgalign_wire;
   reg [1:0] good_cgs;
   reg [1:0] good_cgs_wire;
   reg [10:0] sync_state;
   reg [10:0] sync_state_z;
   reg sync_status;
   reg sync_status_wire;

   assign reset_ssm = reset_sync | bypass_sync;

   assign sigdet_change = sigdet_sync ^ sigdet_z;

   always @(posedge clk)  
    sigdet_z <= #1 sigdet_sync;



  
  
  always @(posedge clk)  
    begin
       sync_state_z <= #1 sync_state;


       // drorb: 21Nov05
       // When the Comma_detect Sync FSM is disabled (when rf_en_2sync_sync=0) , force sync_status
       // to '1', which enables the external FSM work immediately after reset.
       //sync_status <= #1 sync_status_wire;
       sync_status <= #1 (sync_status_wire | ~rf_en_2sync_sync);


       // drorb: 21Nov05
       // 'en_comma_align_glob' comes from extrenal Synch FSM
       // 'enable_cgalign_wire' comes from internal Sync FSM 
       // To be std compatible, only one Synch FSM should be used, therefore the 
       //  internal Sync FSM will be skipped.
       
       // Erez Reches 21Oct01
       //  enable_cgalign <= #1 enable_cgalign_wire;
       // enable_cgalign <= #1 enable_cgalign_wire && en_comma_align_glob;

        enable_cgalign <= #1 ( enable_cgalign_wire | ~rf_en_2sync_sync)&& en_comma_align_glob;

       good_cgs <= #1 good_cgs_wire;
    end





   always @(/*AUTOSENSE*/comma_valid0 or comma_valid1
	    or data_special_valid0 or data_special_valid1 or good_cgs
	    or reset_ssm or sigdet_change or sigdet_sync
	    or sync_state_z)
    begin
     if (reset_ssm | sigdet_change)
      begin
       sync_state = LOSS_OF_SYNC;
       sync_status_wire = SYNC_FAIL;
       enable_cgalign_wire = TRUE;
       good_cgs_wire = 2'b00;
      end
     else
      case (sync_state_z) 
       LOSS_OF_SYNC:
        begin
         if (sigdet_sync & comma_valid0 & comma_valid1)
          begin
           sync_state = COMMA_DETECT_2;
           sync_status_wire = SYNC_FAIL;
           enable_cgalign_wire = FALSE;
           good_cgs_wire = 2'b00;
          end
         else if (sigdet_sync & comma_valid0 & data_special_valid1)
          begin
           sync_state = COMMA_DETECT_1;
           sync_status_wire = SYNC_FAIL;
           enable_cgalign_wire = FALSE;
           good_cgs_wire = 2'b00;
          end
         else if (sigdet_sync & comma_valid1)
          begin
           sync_state = COMMA_DETECT_1;
           sync_status_wire = SYNC_FAIL;
           enable_cgalign_wire = FALSE;
           good_cgs_wire = 2'b00;
          end
         else
          begin
           sync_state = LOSS_OF_SYNC;
           sync_status_wire = SYNC_FAIL;
           enable_cgalign_wire = TRUE;
           good_cgs_wire = 2'b00;
          end
        end
       COMMA_DETECT_1:
        begin
         if (comma_valid0 & comma_valid1)
          begin
           sync_state = COMMA_DETECT_3;
           sync_status_wire = SYNC_FAIL;
           enable_cgalign_wire = FALSE;
           good_cgs_wire = 2'b00;
          end
         else if (comma_valid0 & data_special_valid1)
          begin
           sync_state = COMMA_DETECT_2;
           sync_status_wire = SYNC_FAIL;
           enable_cgalign_wire = FALSE;
           good_cgs_wire = 2'b00;
          end
         else if (data_special_valid0 & comma_valid1)
          begin
           sync_state = COMMA_DETECT_2;
           sync_status_wire = SYNC_FAIL;
           enable_cgalign_wire = FALSE;
           good_cgs_wire = 2'b00;
          end
         else if (sigdet_sync & ~data_special_valid0 & comma_valid1)
          begin
           sync_state = COMMA_DETECT_1;
           sync_status_wire = SYNC_FAIL;
           enable_cgalign_wire = FALSE;
           good_cgs_wire = 2'b00;
          end
         else if (data_special_valid0 & data_special_valid1)
          begin
           sync_state = COMMA_DETECT_1;
           sync_status_wire = SYNC_FAIL;
           enable_cgalign_wire = FALSE;
           good_cgs_wire = 2'b00;
          end
         else
          begin
           sync_state = LOSS_OF_SYNC;
           sync_status_wire = SYNC_FAIL;
           enable_cgalign_wire = TRUE;
           good_cgs_wire = 2'b00;
          end
        end
       COMMA_DETECT_2:
        begin
         if (comma_valid0 & comma_valid1)
          begin
           sync_state = SYNC_ACQUIRED_1;
           sync_status_wire = SYNC_OK;
           enable_cgalign_wire = FALSE;
           good_cgs_wire = 2'b00;
          end
         else if (comma_valid0 & data_special_valid1)
          begin
           sync_state = COMMA_DETECT_3;
           sync_status_wire = SYNC_FAIL;
           enable_cgalign_wire = FALSE;
           good_cgs_wire = 2'b00;
          end
         else if (data_special_valid0 & comma_valid1)
          begin
           sync_state = COMMA_DETECT_3;
           sync_status_wire = SYNC_FAIL;
           enable_cgalign_wire = FALSE;
           good_cgs_wire = 2'b00;
          end
         else if (data_special_valid0 & data_special_valid1)
          begin
           sync_state = COMMA_DETECT_2;
           sync_status_wire = SYNC_FAIL;
           enable_cgalign_wire = FALSE;
           good_cgs_wire = 2'b00;
          end
         else if (sigdet_sync & ~data_special_valid0 & comma_valid1)
          begin
           sync_state = COMMA_DETECT_1;
           sync_status_wire = SYNC_FAIL;
           enable_cgalign_wire = FALSE;
           good_cgs_wire = 2'b00;
          end
         else
          begin
           sync_state = LOSS_OF_SYNC;
           sync_status_wire = SYNC_FAIL;
           enable_cgalign_wire = TRUE;
           good_cgs_wire = 2'b00;
          end
        end
       COMMA_DETECT_3:
        begin
         if (comma_valid0 & data_special_valid1)
          begin
           sync_state = SYNC_ACQUIRED_1;
           sync_status_wire = SYNC_OK;
           enable_cgalign_wire = FALSE;
           good_cgs_wire = 2'b00;
          end
         else if (data_special_valid0 & comma_valid1)
          begin
           sync_state = SYNC_ACQUIRED_1;
           sync_status_wire = SYNC_OK;
           enable_cgalign_wire = FALSE;
           good_cgs_wire = 2'b00;
          end
         else if (comma_valid0 & ~data_special_valid1)
          begin
           sync_state = SYNC_ACQUIRED_2;
           sync_status_wire = SYNC_OK;
           enable_cgalign_wire = FALSE;
           good_cgs_wire = 2'b00;
          end
         else if (data_special_valid0 & data_special_valid1)
          begin
           sync_state = COMMA_DETECT_3;
           sync_status_wire = SYNC_FAIL;
           enable_cgalign_wire = FALSE;
           good_cgs_wire = 2'b00;
          end
         else if (sigdet_sync & ~data_special_valid0 & comma_valid1)
          begin
           sync_state = COMMA_DETECT_1;
           sync_status_wire = SYNC_FAIL;
           enable_cgalign_wire = FALSE;
           good_cgs_wire = 2'b00;
          end
         else
          begin
           sync_state = LOSS_OF_SYNC;
           sync_status_wire = SYNC_FAIL;
           enable_cgalign_wire = TRUE;
           good_cgs_wire = 2'b00;
          end
        end
       SYNC_ACQUIRED_1:
        begin
         if (~data_special_valid0 & ~data_special_valid1)
          begin
           sync_state = SYNC_ACQUIRED_3;
           sync_status_wire = SYNC_OK;
           enable_cgalign_wire = FALSE;
           good_cgs_wire = 2'b00;
          end
         else if (~data_special_valid0 & data_special_valid1)
          begin
           sync_state = SYNC_ACQUIRED_2A;
           sync_status_wire = SYNC_OK;
           enable_cgalign_wire = FALSE;
           good_cgs_wire = good_cgs + 2'b01;
          end
         else if (data_special_valid0 & ~data_special_valid1)
          begin
           sync_state = SYNC_ACQUIRED_2;
           sync_status_wire = SYNC_OK;
           enable_cgalign_wire = FALSE;
           good_cgs_wire = 2'b00;
          end
         else // if (data_special_valid0 & data_special_valid1)
          begin
           sync_state = SYNC_ACQUIRED_1;
           sync_status_wire = SYNC_OK;
           enable_cgalign_wire = FALSE;
           good_cgs_wire = 2'b00;
          end
        end
       SYNC_ACQUIRED_2:
        begin
         if (~data_special_valid0 & ~data_special_valid1)
          begin
           sync_state = SYNC_ACQUIRED_4;
           sync_status_wire = SYNC_OK;
           enable_cgalign_wire = FALSE;
           good_cgs_wire = 2'b00;
          end
         else if (~data_special_valid0 & data_special_valid1)
          begin
           sync_state = SYNC_ACQUIRED_3A;
           sync_status_wire = SYNC_OK;
           enable_cgalign_wire = FALSE;
           good_cgs_wire = good_cgs + 2'b01;
          end
         else if (data_special_valid0 & ~data_special_valid1)
          begin
           sync_state = SYNC_ACQUIRED_3;
           sync_status_wire = SYNC_OK;
           enable_cgalign_wire = FALSE;
           good_cgs_wire = 2'b00;
          end
         else // if (data_special_valid0 & data_special_valid1)
          begin
           sync_state = SYNC_ACQUIRED_2A;
           sync_status_wire = SYNC_OK;
           enable_cgalign_wire = FALSE;
           good_cgs_wire = good_cgs + 2'b10;
          end
        end
       SYNC_ACQUIRED_2A:
        begin
         if (~data_special_valid0 & ~data_special_valid1)
          begin
           sync_state = SYNC_ACQUIRED_4;
           sync_status_wire = SYNC_OK;
           enable_cgalign_wire = FALSE;
           good_cgs_wire = 2'b00;
          end
         else if (~data_special_valid0 & data_special_valid1)
          begin
           sync_state = SYNC_ACQUIRED_3A;
           sync_status_wire = SYNC_OK;
           enable_cgalign_wire = FALSE;
           good_cgs_wire = 2'b01;
          end
         else if (data_special_valid0 & ~data_special_valid1)
          begin
           if (good_cgs == 2'b01)
            begin
             sync_state = SYNC_ACQUIRED_3;
             sync_status_wire = SYNC_OK;
             enable_cgalign_wire = FALSE;
             good_cgs_wire = 2'b00;
            end
           else if (good_cgs == 2'b10)
            begin
             sync_state = SYNC_ACQUIRED_3;
             sync_status_wire = SYNC_OK;
             enable_cgalign_wire = FALSE;
             good_cgs_wire = 2'b00;
            end
           else // if (good_cgs == 2'b11))
            begin
             sync_state = SYNC_ACQUIRED_2;
             sync_status_wire = SYNC_OK;
             enable_cgalign_wire = FALSE;
             good_cgs_wire = 2'b00;
            end
          end
         else // if (data_special_valid0 & data_special_valid1)
          begin
           if (good_cgs == 2'b01)
            begin
             sync_state = SYNC_ACQUIRED_2A;
             sync_status_wire = SYNC_OK;
             enable_cgalign_wire = FALSE;
             good_cgs_wire = good_cgs + 2'b10;
            end
           else if (good_cgs == 2'b10)
            begin
             sync_state = SYNC_ACQUIRED_1;
             sync_status_wire = SYNC_OK;
             enable_cgalign_wire = FALSE;
             good_cgs_wire = 2'b00;
            end
           else // if (good_cgs == 2'b11)
            begin
             sync_state = SYNC_ACQUIRED_1;
             sync_status_wire = SYNC_OK;
             enable_cgalign_wire = FALSE;
             good_cgs_wire = 2'b00;
            end
          end
        end
       SYNC_ACQUIRED_3:
        begin
         if (~data_special_valid0 & ~data_special_valid1)
          begin
           sync_state = LOSS_OF_SYNC;
           sync_status_wire = SYNC_FAIL;
           enable_cgalign_wire = TRUE;
           good_cgs_wire = 2'b00;
          end
         else if (~data_special_valid0 & data_special_valid1)
          begin
           sync_state = SYNC_ACQUIRED_4A;
           sync_status_wire = SYNC_OK;
           enable_cgalign_wire = FALSE;
           good_cgs_wire = good_cgs + 2'b01;
          end
         else if (data_special_valid0 & ~data_special_valid1)
          begin
           sync_state = SYNC_ACQUIRED_4;
           sync_status_wire = SYNC_OK;
           enable_cgalign_wire = FALSE;
           good_cgs_wire = 2'b00;
          end
         else // if (data_special_valid0 & data_special_valid1)
          begin
           sync_state = SYNC_ACQUIRED_3A;
           sync_status_wire = SYNC_OK;
           enable_cgalign_wire = FALSE;
           good_cgs_wire = good_cgs + 2'b10;
          end
        end
       SYNC_ACQUIRED_3A:
        begin
         if (~data_special_valid0 & ~data_special_valid1)
          begin
           sync_state = LOSS_OF_SYNC;
           sync_status_wire = SYNC_FAIL;
           enable_cgalign_wire = TRUE;
           good_cgs_wire = 2'b00;
          end
         else if (~data_special_valid0 & data_special_valid1)
          begin
           sync_state = SYNC_ACQUIRED_4A;
           sync_status_wire = SYNC_OK;
           enable_cgalign_wire = FALSE;
           good_cgs_wire = 2'b01;
          end
         else if (data_special_valid0 & ~data_special_valid1)
          begin
           if (good_cgs == 2'b01)
            begin
             sync_state = SYNC_ACQUIRED_4;
             sync_status_wire = SYNC_OK;
             enable_cgalign_wire = FALSE;
             good_cgs_wire = 2'b00;
            end
           else if (good_cgs == 2'b10)
            begin
             sync_state = SYNC_ACQUIRED_4;
             sync_status_wire = SYNC_OK;
             enable_cgalign_wire = FALSE;
             good_cgs_wire = 2'b00;
            end
           else // if (good_cgs == 2'b11)
            begin
             sync_state = SYNC_ACQUIRED_3;
             sync_status_wire = SYNC_OK;
             enable_cgalign_wire = FALSE;
             good_cgs_wire = 2'b00;
            end
          end
         else // if (data_special_valid0 & data_special_valid1)
          begin
           if (good_cgs == 2'b01)
            begin
             sync_state = SYNC_ACQUIRED_3A;
             sync_status_wire = SYNC_OK;
             enable_cgalign_wire = FALSE;
             good_cgs_wire = good_cgs + 2'b10;
            end
           else if (good_cgs == 2'b10)
            begin
             sync_state = SYNC_ACQUIRED_2;
             sync_status_wire = SYNC_OK;
             enable_cgalign_wire = FALSE;
             good_cgs_wire = 2'b00;
            end
           else // if (good_cgs == 2'b11)
            begin
             sync_state = SYNC_ACQUIRED_2A;
             sync_status_wire = SYNC_OK;
             enable_cgalign_wire = FALSE;
             good_cgs_wire = 2'b01;
            end
          end
        end
       SYNC_ACQUIRED_4:
        begin
         if (data_special_valid0 & data_special_valid1)
          begin
           sync_state = SYNC_ACQUIRED_4A;
           sync_status_wire = SYNC_OK;
           enable_cgalign_wire = FALSE;
           good_cgs_wire = good_cgs + 2'b10;
          end
         else if (sigdet_sync & ~data_special_valid0 & comma_valid1)
          begin
           sync_state = COMMA_DETECT_1;
           sync_status_wire = SYNC_FAIL;
           enable_cgalign_wire = FALSE;
           good_cgs_wire = 2'b00;
          end
         else
          begin
           sync_state = LOSS_OF_SYNC;
           sync_status_wire = SYNC_FAIL;
           enable_cgalign_wire = TRUE;
           good_cgs_wire = 2'b00;
          end
        end
       SYNC_ACQUIRED_4A:
        begin
         if (data_special_valid0 & data_special_valid1)
          begin
           if (good_cgs == 2'b01)
            begin
             sync_state = SYNC_ACQUIRED_4A;
             sync_status_wire = SYNC_OK;
             enable_cgalign_wire = FALSE;
             good_cgs_wire = good_cgs + 2'b10;
            end
           else if (good_cgs == 2'b10)
            begin
             sync_state = SYNC_ACQUIRED_3;
             sync_status_wire = SYNC_OK;
             enable_cgalign_wire = FALSE;
             good_cgs_wire = 2'b00;
            end
           else // if (good_cgs == 2'b11)
            begin
             sync_state = SYNC_ACQUIRED_3A;
             sync_status_wire = SYNC_OK;
             enable_cgalign_wire = FALSE;
             good_cgs_wire = 2'b01;
            end
          end
         else if (data_special_valid0 & ~data_special_valid1)
          begin
           if (good_cgs == 2'b01)
            begin
             sync_state = LOSS_OF_SYNC;
             sync_status_wire = SYNC_FAIL;
             enable_cgalign_wire = TRUE;
             good_cgs_wire = 2'b00;
            end
           else if (good_cgs == 2'b10)
            begin
             sync_state = LOSS_OF_SYNC;
             sync_status_wire = SYNC_FAIL;
             enable_cgalign_wire = TRUE;
             good_cgs_wire = 2'b00;
            end
           else // if (good_cgs == 2'b11)
            begin
             sync_state = SYNC_ACQUIRED_4;
             sync_status_wire = SYNC_OK;
             enable_cgalign_wire = FALSE;
             good_cgs_wire = 2'b00;
            end
          end
         else if (sigdet_sync & ~data_special_valid0 & comma_valid1)
          begin
           sync_state = COMMA_DETECT_1;
           sync_status_wire = SYNC_FAIL;
           enable_cgalign_wire = FALSE;
           good_cgs_wire = 2'b00;
          end
         else
          begin
           sync_state = LOSS_OF_SYNC;
           sync_status_wire = SYNC_FAIL;
           enable_cgalign_wire = TRUE;
           good_cgs_wire = 2'b00;
          end
        end
       default:
        begin
         sync_state = LOSS_OF_SYNC;
         sync_status_wire = SYNC_FAIL;
         enable_cgalign_wire = TRUE;
         good_cgs_wire = 2'b00;
        end
      endcase
    end

endmodule // cd_ssm


module sip_xpcs_cd_mux (/*AUTOARG*/
   // Outputs
   rout, 
   // Inputs
   bypass_sync, clk, position_7bit, position_10bit, rin, 
   sel_comma_sync
   );

   output [19:0] rout;

   input bypass_sync;
   input clk;
   input [4:0] position_7bit;
   input [4:0] position_10bit;
   input [19:0] rin;
   input sel_comma_sync;

   reg [19:0] aligned;
   reg [19:0] rin_z;

   reg  [19:0] rout;
   wire [19:0] rout_pre;
   wire [4:0] shift;

   assign rout_pre = bypass_sync ? rin : aligned;
   assign shift = sel_comma_sync ? position_7bit : position_10bit;

   always @(posedge clk)
    begin
     rin_z <= #1 rin;
    end

    // drorb: 26-Jan-06: add sample for timing
    always @(posedge clk)
     begin
      rout <= #1 rout_pre;
     end


   always @(/*AUTOSENSE*/rin or rin_z or shift)
    begin
     case (shift) 
      5'd0:
       begin
        aligned = rin;
       end
      5'd1:
       begin
        aligned = {rin[0],rin_z[19:1]};
       end
      5'd2:
       begin
        aligned = {rin[1:0],rin_z[19:2]};
       end
      5'd3:
       begin
        aligned = {rin[2:0],rin_z[19:3]};
       end
      5'd4:
       begin
        aligned = {rin[3:0],rin_z[19:4]};
       end
      5'd5:
       begin
        aligned = {rin[4:0],rin_z[19:5]};
       end
      5'd6:
       begin
        aligned = {rin[5:0],rin_z[19:6]};
       end
      5'd7:
       begin
        aligned = {rin[6:0],rin_z[19:7]};
       end
      5'd8:
       begin
        aligned = {rin[7:0],rin_z[19:8]};
       end
      5'd9:
       begin
        aligned = {rin[8:0],rin_z[19:9]};
       end
      5'd10:
       begin
        aligned = {rin[9:0],rin_z[19:10]};
       end
      5'd11:
       begin
        aligned = {rin[10:0],rin_z[19:11]};
       end
      5'd12:
       begin
        aligned = {rin[11:0],rin_z[19:12]};
       end
      5'd13:
       begin
        aligned = {rin[12:0],rin_z[19:13]};
       end
      5'd14:
       begin
        aligned = {rin[13:0],rin_z[19:14]};
       end
      5'd15:
       begin
        aligned = {rin[14:0],rin_z[19:15]};
       end
      5'd16:
       begin
        aligned = {rin[15:0],rin_z[19:16]};
       end
      5'd17:
       begin
        aligned = {rin[16:0],rin_z[19:17]};
       end
      5'd18:
       begin
        aligned = {rin[17:0],rin_z[19:18]};
       end
      5'd19:
       begin
        aligned = {rin[18:0],rin_z[19]};
       end
      default:
       begin
        aligned = rin;
       end
     endcase
    end

endmodule // cd_mux
