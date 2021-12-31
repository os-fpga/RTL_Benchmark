// ========== Copyright Header Begin ==========================================
// 
// OpenSPARC T1 Processor File: bw_clk_cl_sctag_cmp.v
// Copyright (c) 2006 Sun Microsystems, Inc.  All Rights Reserved.
// DO NOT ALTER OR REMOVE COPYRIGHT NOTICES.
// 
// The above named program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public
// License version 2 as published by the Free Software Foundation.
// 
// The above named program is distributed in the hope that it will be 
// useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// General Public License for more details.
// 
// You should have received a copy of the GNU General Public
// License along with this work; if not, write to the Free Software
// Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.
// 
// ========== Copyright Header End ============================================
module bw_clk_cl_sctag_cmp (/*AUTOARG*/
   // Outputs
   dbginit_l, cluster_grst_l, rclk, so, 
   // Inputs
   gclk, cluster_cken, arst_l, grst_l, adbginit_l, gdbginit_l, si, 
   se
   );

input       gclk;
input       cluster_cken;
input       arst_l;
input       grst_l;
input       adbginit_l;
input       gdbginit_l;
output      dbginit_l;
output      cluster_grst_l;
output      rclk;

input       si;
input       se;
output      so;



cluster_header I0 (/*AUTOINST*/
                   // Outputs
                   .dbginit_l           (dbginit_l),
                   .cluster_grst_l      (cluster_grst_l),
                   .rclk                (rclk),
                   .so                  (so),
                   // Inputs
                   .gclk                (gclk),
                   .cluster_cken        (cluster_cken),
                   .arst_l              (arst_l),
                   .grst_l              (grst_l),
                   .adbginit_l          (adbginit_l),
                   .gdbginit_l          (gdbginit_l),
                   .si                  (si),
                   .se                  (se));

endmodule
