//------------------------------------------------------------------------------
// Copyright (c) 2001-2017 Cadence Design Systems, Inc.
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
//   Filename:           rmii_interface.v
//   Module Name:        rmii_interface
//
//   Release Revision:   r1p12
//   Release SVN Tag:    gem_gxl_det0102_r1p12
//
//   IP Name:            GEM Gigabit Ethernet MAC
//   IP Part Number:     IP7014
//
//   Product Type:       Off-the-shelf
//   IP Type:            Soft
//   IP Family:          Ethernet Controller
//   Technology:         N/A
//   Protocol:           Ethernet
//   Architecture:       N/A
//   Licensable IP:      SIP-Ethernet-MAC+DMA+1588+TSN+PCS-10M/100M/1G-IP7014
//
//------------------------------------------------------------------------------
//   Description    : This is the rmii_interface module for the Ethernet GEM.
//                    It provides the appropriate interfaces to connect the GEM
//                    MII interface to an RMII compatible PHY.
//                    This block performs all the signal conversions and the
//                    internal clock generation compliant to the RMII
//                    specifications.
//
//------------------------------------------------------------------------------


module rmii_interface (
   // System signals
   n_ref_reset,
   speed,
   tx_lpi_en,

   // Clock input signal
   ref_clk,

   // Clock outputs back to clk module.
   rx_clk,
   tx_clk,

   // MII signals
   col,
   crs,
   txd,
   tx_en,
   rxd,
   rx_er,
   rx_dv,

   // RMII signals
   txd_rmii,
   tx_en_rmii,
   rxd_rmii,
   rx_er_rmii,
   crs_dv);

   // System signals
   input          n_ref_reset;         // Asynchronous reset signal.
   input          speed;               // 10/100Mb speed selection (pclk timed)
   input          tx_lpi_en;           // enables transmission of LPI
                                       // (for rmii this is txd_rmii set to 01 with tx_en set to 0)
   input          ref_clk;             // 50MHz reference clock input.
                                       // used to time all registers.
   output         rx_clk;              // Clock outputs for MII signal
   output         tx_clk;              // timing, with extra setup allowance.

   // MII signals
   // Note that col and crs are asynchronous output signals.
   output         col;                 // Indicate collision occured.
   output         crs;                 // Carrier sense signal.
   input    [3:0] txd;                 // Transmit data nibble.
   input          tx_en;               // Transmit enable.
   output   [3:0] rxd;                 // Receive data nibble.
   output         rx_er;               // Receive error.
   output         rx_dv;               // Receive data valid.

   // RMII signals
   output   [1:0] txd_rmii;            // Transmit data, di-bit.
   output         tx_en_rmii;          // Transmit enable on RMII.
   input    [1:0] rxd_rmii;            // Receive data, di-bit.
   input          rx_er_rmii;          // Receive error on RMII.
   input          crs_dv;              // Carrier sense / Data valid.



   // Port declarations
   reg            rx_clk;              // Clock outputs for MII signal
   reg            tx_clk;              // timing, with extra setup allowance.
   wire           col;                 // Indicate collision occured.
   wire           crs;                 // Carrier sense signal.
   reg      [3:0] rxd;                 // Receive data nibble.
   wire           rx_er;               // Receive error.
   reg            rx_dv;               // Receive data valid.
   reg      [1:0] txd_rmii;            // Transmit data, di-bit.
   reg            tx_en_rmii;          // Transmit enable on RMII.


   // Wire and reg declarations.
   reg      [3:0] tx_clk_count;        // Used in generating the tx clock.

   reg      [1:0] rxd_low;             // Saving the first di-bit for rxd.

   reg      [1:0] txd_sample;          // Sampling the high di-bit of txd.

   reg            rx_error_occurred;   // Receive error had occurred.
   reg            rx_ready;            // Receive ready and receive done,
   reg            rx_done;             // signifies start and end of frame.

   reg            bit_count;           // Counters for rx and tx processes
   reg            tx_bit_count;        // for tx process.

   wire           preamble;            // Indicates a valid pre-amble.
   wire           sample_time;         // Indicate when allowed to sample.

   wire           speed_sync2;         // Synchronize speed to ref_clk
   reg            speed_sync3;         // Synchronize speed to ref_clk
   wire           speed_change;        // Force reset on speed change.

   reg            crs_enable;          // Signal to qualify crs_dv

   wire           tx_lpi_en_s;         // transmit LPI synchronized to ref_clk
   reg            lpi_detected;        // asserted if rxd_rmii is seen as 01 with crs_dv low
                                       // lpi_detected is used to force rx_er assertion to MAC for LPI indication


   // synchronize speed input
   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_speed (
      .clk(ref_clk),
      .reset_n(n_ref_reset),
      .din(speed),
      .dout(speed_sync2));

   // Detect a change on the speed pin to reset the rmii counters
   always@(posedge ref_clk or negedge n_ref_reset)
      if (~n_ref_reset)
         begin
            speed_sync3 <= 1'b0;
         end
      else
         begin
            speed_sync3 <= speed_sync2;
         end

   assign speed_change = speed_sync2 ^ speed_sync3;

   // synchronize tx_lpi_en input
   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_tx_lpi_en (
      .clk(ref_clk),
      .reset_n(n_ref_reset),
      .din(tx_lpi_en),
      .dout(tx_lpi_en_s));

   // Generate the transmit clock.  This will be set depending on the speed
   // selection input, for 100Mb/s this will be 25MHz and for 10Mb/s it will be
   // at 2.5MHz.  The clock is generated from ref_clk.
   always@(posedge ref_clk or negedge n_ref_reset)
      if (~n_ref_reset)
         begin
            tx_clk_count <= 4'h0;
            tx_clk <= 1'b0;
         end
      else if (speed_change)  // Reset on change in speed pin
         begin
            tx_clk_count <= 4'h0;
            tx_clk <= 1'b0;
         end
      else if (speed_sync2)     // Selecting 100Mbit operation.
         begin
            tx_clk_count <= 4'h0;
            tx_clk <= ~tx_clk;  // Toggle every clk = 1/2 clk
         end
      else if (tx_clk_count == 4'b1001) // For 10Mbit operation.
         begin
            tx_clk_count <= 4'h0;
            tx_clk <= ~tx_clk;  // Toggle on 10 clks = 1/20 clk
         end
      else
         begin
            tx_clk_count <= tx_clk_count + 4'b0001;  // Increment count (10Mbit)
            tx_clk <= tx_clk;
         end


   // Sample pulse to indicate when it is time to sample the RMII signals..
   assign sample_time = speed_sync2 |
                        (~speed_sync2 & (tx_clk_count == 4'b1001));


   // Generate a collision when the mac tries to transmit while receiving.
   // Note that crs is used rather than rx_dv since rx_dv is delayed
   // due to pipelining.  With crs, nothing can be tx'd as soon as a
   // carrier event is detected...
   // Note also that crs may de-assert before rx_dv is de-asserted.  This
   // occurs when the receive medium is idle, but the PHY still requires to
   // transfer data.  Therefore, it would still have been safe to transmit..
   assign col = (crs_dv & crs_enable) & tx_en;


   // Generate carrier sense when receiving or carrier sense received..
   // Note crs_dv is used so that the carrier event is detected as soon as
   // possible so is asynchronous to carrier reception on the phy,
   // useful in repeater applications to allow for earliest possible indication.
   // Carrier sense should also be activated when transmitting...
   // rx_dv is not used, since the PHY could still be transferring data to the
   // MAC even when the receive medium is idle.  This would be due to buffering
   // within the PHY device.
   // The crs_dv signal is qualified by an enable signal to prevent crs from
   // toggling if crs_dv toggles..
   assign crs = tx_en | (crs_dv & crs_enable);


   // Preamble detection.  This is to allow sampling to commence as soon as a
   // valid preamble is detected rather than being delayed an extra cycle for
   // rx_ready signal.
   assign preamble = ((crs_dv) & (rxd_rmii == 2'b01));


   // Detect valid pre-amble and assert the rx_ready signal to enable
   // sampling of data on rxd_rmii.
   // rx_ready remains asserted until rx_done signal received indicating
   // end of the frame..
   always@(posedge ref_clk or negedge n_ref_reset)
      if (~n_ref_reset)
         rx_ready <= 1'b0;
      else if (speed_change | (sample_time & rx_done))
         rx_ready <= 1'b0;
      else if (sample_time & preamble) // Only change at sample time
         rx_ready <= 1'b1;


   // Assert rx_done when crs_dv is de-asserted after a valid pre-amble
   // had been detected.
   // Modified to be able to accomodate cases where crs_dv toggles due to
   // clearing out of the PHY FIFO.  In this case, data is still valid, but
   // crs_dv will be de-asserted on the first di-bit, and re-asserted on the
   // second di-bit.
   always@(posedge ref_clk or negedge n_ref_reset)
      if (~n_ref_reset)
         rx_done <= 1'b0;
      else if (speed_change)  // Reset on change in speed pin
         rx_done <= 1'b0;
      else if (sample_time & (~crs_dv & bit_count) & rx_ready)
         rx_done <= 1'b1;
      else if (sample_time)
         rx_done <= 1'b0;


   // Generate signal to determine when it is valid to generate crs signal
   // from crs_dv.  When crs_dv drops low after receive has started on the
   // first di-bit, then we know that the receive medium is idle.
   // Note that although the medium is idle, the PHY could still transfer
   // data to the mac by toggling crs_dv.
   always@(posedge ref_clk or negedge n_ref_reset)
      if (~n_ref_reset)
         crs_enable <= 1'b1;
      else if (speed_change)  // Reset on change in speed pin
         crs_enable <= 1'b1;
      else if (rx_done | (crs_dv & bit_count))
         crs_enable <= 1'b1;
      else if ((~crs_dv & ~bit_count) & rx_ready)
         crs_enable <= 1'b0;
      else
         crs_enable <= crs_enable;

   // Generate rx_error_occurred, used to extend rx_er event until rx_dv
   // is de-asserted by the rx_ready signal after end of frame..
   always@(posedge ref_clk or negedge n_ref_reset)
      if (~n_ref_reset)
         rx_error_occurred <= 1'b0;
      else if (speed_change | ~rx_ready)
         rx_error_occurred <= 1'b0;
      else if (rx_er_rmii)
         rx_error_occurred <= 1'b1;


   // Drive rx_er signal, only used when rx_dv also active,
   // or when we want to indicate lpi reception to the MAC
   assign rx_er = (rx_error_occurred & rx_dv) | lpi_detected;


   // Sample RMII signals and save value.  Drive MII signals on reception of
   // second di-bit and generate rx_clk.
   // Note that MII signals are driven on the equivalen falling edge of rx_clk,
   // this gives the signals an extra cycle for setup and recovery.
   // A limitation of this is that depending on when the data comes in, this
   // might result in a phase of rx_clk being extended by 1 ref_clk.  This
   // however should not cause any problems.
   always@(posedge ref_clk or negedge n_ref_reset)
      if (~n_ref_reset)
         begin
            rxd_low <= 2'b00;
            bit_count <= 1'b0;
            rxd <= 4'h0;
            rx_dv <= 1'b0;
            rx_clk <= 1'b0;
            lpi_detected <= 1'b0;
         end
      else if (speed_change)  // Reset on change in speed pin
         begin
            rxd_low <= 2'b00;
            bit_count <= 1'b0;
            rxd <= 4'h0;
            rx_dv <= 1'b0;
            rx_clk <= 1'b0;
            lpi_detected <= 1'b0;
         end
      else if (sample_time)
        begin
         if ( rx_ready | preamble )
            if (bit_count)  // The second di-bit..
            begin
               bit_count <= bit_count + 1'b1;
               rxd <= {rxd_rmii, rxd_low};
               rxd_low <= rxd_low;
               rx_dv <= (~rx_done & crs_dv);
               rx_clk <= 1'b0;
               lpi_detected <= 1'b0;
            end
            else  // The first di-bit..
            begin
               bit_count <= bit_count +1'b1;
               rxd_low <= rxd_rmii;
               rx_dv <= rx_dv;
               rxd <= rxd;
               rx_clk <= 1'b1;
               lpi_detected <= 1'b0;
            end
         else if (~crs_dv & (rxd_rmii == 2'b01)) // lpi detected
            begin
               bit_count <= 1'b0;
               rxd_low <= 2'b00;
               rx_dv <= 1'b0;
               rx_clk <= ~rx_clk;
               if (rx_clk) // only change rx signals to MAC on falling edge of rx_clk
                 begin
                  rxd <= 4'h1;
                  lpi_detected <= 1'b1; // causes rx_er assertion for LPI indication to MAC
                 end
               else
                 begin
                  rxd <= rxd;
                  lpi_detected <= lpi_detected;
                 end
            end
         else  // i.e. no valid frames..
            begin
               bit_count <= 1'b0;
               rxd_low <= 2'b00;
               rx_dv <= 1'b0;
               rx_clk <= ~rx_clk;
               if (rx_clk)  // only change rx signals to MAC on falling edge of rx_clk
                 begin
                  rxd <= 4'h0;
                  lpi_detected <= 1'b0;
                 end
               else
                 begin
                  rxd <= rxd;
                  lpi_detected <= lpi_detected;
                 end
            end
        end
      else  // In between sample times (for 10Mb)
         begin
            bit_count <= bit_count;
            rxd_low <= rxd_low;
            rxd <= rxd;
            rx_dv <= rx_dv;
            rx_clk <= rx_clk;
            lpi_detected <= lpi_detected;
         end


   // Now sample the MII signals and generate the appropriate RMII signals.
   always@(posedge ref_clk or negedge n_ref_reset)
      if (~n_ref_reset)
         begin
            txd_sample <= 2'b00;
            tx_bit_count <= 1'b0;
            tx_en_rmii <= 1'b0;
            txd_rmii <= 2'b00;
         end
      else if (speed_change)  // Reset on change in speed pin
         begin
            txd_sample <= 2'b00;
            tx_bit_count <= 1'b0;
            tx_en_rmii <= 1'b0;
            txd_rmii <= 2'b00;
         end
      else if (sample_time)
        begin
         if (tx_en)
            if (tx_bit_count)
            begin
               tx_en_rmii <= 1'b1;
               txd_sample <= txd_sample;
               txd_rmii <= txd_sample;
               tx_bit_count <= tx_bit_count + 1'b1;
            end
            else
            begin
               tx_en_rmii <= 1'b1;
               txd_sample <= txd[3:2];
               txd_rmii <= txd[1:0];
               tx_bit_count <= tx_bit_count + 1'b1;
            end
         else if (tx_lpi_en_s)
            begin
               tx_en_rmii <= 1'b0;
               txd_sample <= txd_sample;
               txd_rmii <= 2'b01;
               tx_bit_count <= 1'b0;
            end
         else
            begin
               tx_en_rmii <= 1'b0;
               txd_sample <= txd_sample;
               txd_rmii <= 2'b00;
               tx_bit_count <= 1'b0;
            end
        end
      else
         begin
            tx_en_rmii <= tx_en_rmii;
            txd_sample <= txd_sample;
            txd_rmii <= txd_rmii;
            tx_bit_count <= tx_bit_count;
         end

endmodule
