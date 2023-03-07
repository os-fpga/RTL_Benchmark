//-----------------------------------------------------------------------------------------------------------
//    Copyright (C) 2022 by Dolphin Technology
//    All right reserved.
//
//    Copyright Notification
//    No part may be reproduced except as authorized by written permission.
//
//    Module: dti_pvt_controller.dti_pvt_controller
//    Company: Dolphin Technology
//    Author: tung
//    Date: 14:48:49 04/20/22
//-----------------------------------------------------------------------------------------------------------


module dti_pvt_controller( 
  // Port Declarations
  input   wire            VDD,      // Power Pin
  input   wire            VDDO,     // Power Pin
  input   wire            VIN,      // Input Voltage
  input   wire            VSS,      // Power Pin
  input   wire            clk,      // Core IP Clock
  input   wire    [7:0]   paddr, 
  input   wire            pclk, 
  input   wire            penable, 
  input   wire            presetn, 
  input   wire            psel, 
  input   wire    [31:0]  pwdata, 
  input   wire            pwrite, 
  input   wire            reset_n,  // System Async Reset
  output  wire            TSTOUT,   // Analog Voltage Monitoring
  output  wire    [31:0]  prdata, 
  output  wire            pready, 
  output  wire            pslverr
);


// Internal Declarations


// Local declarations

// Internal signal declarations
wire        [8:0]  C_TS;                 // Temperature Code
wire        [8:0]  C_VM;                 // Voltage Code
wire        [3:0]  DIV;                  // Division factor
wire               DONE;                 // Complete Process Monitor
wire               E;                    // Enable monitor
wire               MEAS;                 // Start Measuring for Process
wire        [9:0]  PM_C;                 // Process Monitor Code
wire        [3:0]  TRIM;                 // Resistor value adjustment for post silicon to calibrate to simulation results
wire        [3:0]  TSTEN;                // Enable Analog Voltage Monitor
wire               TS_OUT;               // Result of comparison Thermal Sensor Monitor
wire               VMRANGE;              // Voltage monitor range
wire               VM_OUT;               // Result of comparison Voltage Monitor
wire               conf_freqrange;
wire        [7:0]  paddr_ip;
wire               penable_ip;
wire        [9:0]  pm_diff;
wire               pm_done;
wire               pm_enable;
wire               pm_error;
wire               pm_faster;
wire               pm_finish;
wire               pm_start;
wire        [31:0] prdata_ip;
wire               pready_ip;
wire               psel_ip;
wire               pslverr_ip;
wire        [31:0] pwdata_ip;
wire               pwrite_ip;
wire        [4:0]  reg_t_en;
wire        [2:0]  reg_t_mstep;
wire        [7:0]  reg_t_timeout;
wire signed [4:0]  reg_ts_cal_offset;    // adjust c_din depend on silicon corner
wire signed [4:0]  reg_vm_cal_offset;    // adjust c_din depend on silicon corner
wire               req_ready;
wire               t_en_count_en;
wire               t_en_done;            // complete enable time (30ns)
wire               t_en_load;
wire               t_en_load_pm;
wire               t_en_load_ts;         // start enable timing count
wire               t_en_load_vm;         // start enable timing count
wire               t_mstep_count_en;
wire               t_mstep_done;
wire               t_mstep_load;
wire               t_mstep_load_ts;      // start step timing count
wire               t_mstep_load_vm;      // start step timing count
wire               t_timeout_count_en;
wire               t_timeout_done;
wire               t_timeout_load;
wire        [8:0]  ts_c_final;           // final code
wire               ts_done;
wire               ts_enable;            // enable to measure
wire               ts_error;             // failure in measurement 
wire               ts_finish;            // end of fsm, complete measuring
wire               ts_start;             // start to measure
wire        [8:0]  vm_c_final;           // final code
wire               vm_done;
wire               vm_enable;            // enable to measure
wire               vm_error;             // failure in measurement 
wire               vm_finish;            // end of fsm, complete measuring
wire               vm_start;             // start to measure
wire        [7:0]  waddr;
wire        [31:0] wdata;
wire               wstrobe;


// Instances 
dti_bictr_rcnto_up #(5) t_cen_counter( 
  .clk         (clk), 
  .reset_n     (reset_n), 
  .load_en     (t_en_load), 
  .count_en    (t_en_count_en), 
  .count_to    (reg_t_en), 
  .tercnt_flag (t_en_done)
); 

dti_bictr_rcnto_up #(3) t_mstep_counter( 
  .clk         (clk), 
  .reset_n     (reset_n), 
  .load_en     (t_mstep_load), 
  .count_en    (t_mstep_count_en), 
  .count_to    (reg_t_mstep), 
  .tercnt_flag (t_mstep_done)
); 

dti_bictr_rcnto_up #(8) t_timeout_counter( 
  .clk         (clk), 
  .reset_n     (reset_n), 
  .load_en     (t_timeout_load), 
  .count_en    (t_timeout_count_en), 
  .count_to    (reg_t_timeout), 
  .tercnt_flag (t_timeout_done)
); 

dti_apb_sync dti_apb_sync( 
  .presetn    (presetn), 
  .pclk       (pclk), 
  .paddr      (paddr), 
  .psel       (psel), 
  .penable    (penable), 
  .pwrite     (pwrite), 
  .pwdata     (pwdata), 
  .pready     (pready), 
  .prdata     (prdata), 
  .pslverr    (pslverr), 
  .clk        (clk), 
  .reset_n    (reset_n), 
  .paddr_ip   (paddr_ip), 
  .psel_ip    (psel_ip), 
  .penable_ip (penable_ip), 
  .pwrite_ip  (pwrite_ip), 
  .pwdata_ip  (pwdata_ip), 
  .pready_ip  (pready_ip), 
  .prdata_ip  (prdata_ip), 
  .pslverr_ip (pslverr_ip)
); 

dti_p_mon_fsm dti_pm_fsm( 
  .clk            (clk), 
  .freqrange      (conf_freqrange), 
  .pm_c           (PM_C), 
  .pm_done        (DONE), 
  .pm_start       (pm_start), 
  .reset_n        (reset_n), 
  .t_en_done      (t_en_done), 
  .t_timeout_done (t_timeout_done), 
  .enable         (pm_enable), 
  .meas           (MEAS), 
  .pm_diff        (pm_diff), 
  .pm_error       (pm_error), 
  .pm_faster      (pm_faster), 
  .pm_finish      (pm_finish), 
  .t_en_load      (t_en_load_pm), 
  .t_timeout_load (t_timeout_load)
); 

dti_pvt_global_ctrl dti_pvt_global_ctrl( 
  .waddr     (waddr), 
  .wdata     (wdata), 
  .wstrobe   (wstrobe), 
  .clk       (clk), 
  .reset_n   (reset_n), 
  .pm_finish (pm_finish), 
  .vm_finish (vm_finish), 
  .ts_finish (ts_finish), 
  .pm_start  (pm_start), 
  .vm_start  (vm_start), 
  .ts_start  (ts_start), 
  .pm_done   (pm_done), 
  .vm_done   (vm_done), 
  .ts_done   (ts_done), 
  .req_ready (req_ready)
); 

dti_vt_mon_fsm dti_ts_fsm( 
  .cal_offset   (reg_ts_cal_offset), 
  .clk          (clk), 
  .greater      (TS_OUT), 
  .reset_n      (reset_n), 
  .start        (ts_start), 
  .t_en_done    (t_en_done), 
  .t_mstep_done (t_mstep_done), 
  .c_final      (ts_c_final), 
  .c_in         (C_TS), 
  .enable       (ts_enable), 
  .error        (ts_error), 
  .finish       (ts_finish), 
  .t_en_load    (t_en_load_ts), 
  .t_mstep_load (t_mstep_load_ts)
); 

dti_vt_mon_fsm dti_vm_fsm( 
  .cal_offset   (reg_vm_cal_offset), 
  .clk          (clk), 
  .greater      (VM_OUT), 
  .reset_n      (reset_n), 
  .start        (vm_start), 
  .t_en_done    (t_en_done), 
  .t_mstep_done (t_mstep_done), 
  .c_final      (vm_c_final), 
  .c_in         (C_VM), 
  .enable       (vm_enable), 
  .error        (vm_error), 
  .finish       (vm_finish), 
  .t_en_load    (t_en_load_vm), 
  .t_mstep_load (t_mstep_load_vm)
); 

dti_pvt_reg_blk dti_pvt_reg_blk( 
  .req_pm             (), 
  .req_vm             (), 
  .req_ts             (), 
  .treg_t_timeout     (reg_t_timeout), 
  .treg_t_en          (reg_t_en), 
  .treg_t_mstep       (reg_t_mstep), 
  .conf_trim          (TRIM), 
  .conf_freqrange     (conf_freqrange), 
  .conf_div           (DIV), 
  .conf_vmrange       (VMRANGE), 
  .conf_vm_cal_offset (reg_vm_cal_offset), 
  .conf_ts_cal_offset (reg_ts_cal_offset), 
  .test_tsten         (TSTEN), 
  .result_pm_diff     (pm_diff), 
  .result_pm_fast     (pm_faster), 
  .result_pm_done     (pm_done), 
  .result_vm_c        (vm_c_final), 
  .result_vm_done     (vm_done), 
  .result_ts_c        (ts_c_final), 
  .result_ts_done     (ts_done), 
  .stt_pm_error       (pm_error), 
  .stt_vm_error       (vm_error), 
  .stt_ts_error       (ts_error), 
  .stt_req_ready      (req_ready), 
  .presetn            (reset_n), 
  .pclk               (clk), 
  .paddr              (paddr_ip), 
  .psel               (psel_ip), 
  .penable            (penable_ip), 
  .pwrite             (pwrite_ip), 
  .pwdata             (pwdata_ip), 
  .pready             (pready_ip), 
  .prdata             (prdata_ip), 
  .pslverr            (pslverr_ip), 
  .waddr              (waddr), 
  .wdata              (wdata), 
  .wstrobe            (wstrobe)
); 

// tm16_pvt tm16_pvt( 
//   .CK      (clk), 
//   .C_TS    (C_TS), 
//   .C_VM    (C_VM), 
//   .DIV     (DIV), 
//   .DONE    (DONE), 
//   .E       (E), 
//   .MEAS    (MEAS), 
//   .PM_C    (PM_C), 
//   .RN      (reset_n), 
//   .TRIM    (TRIM), 
//   .TSTEN   (TSTEN), 
//   .TSTOUT  (TSTOUT), 
//   .TS_OUT  (TS_OUT), 
//   .VDD     (VDD), 
//   .VDDO    (VDDO), 
//   .VIN     (VIN), 
//   .VMRANGE (VMRANGE), 
//   .VM_OUT  (VM_OUT), 
//   .VSS     (VSS)
// ); 

// HDL Embedded Text Block 1 eb1
// Assignment
assign t_en_load          = t_en_load_ts | t_en_load_vm | t_en_load_pm;
assign t_mstep_load       = t_mstep_load_ts | t_mstep_load_vm;
assign t_en_count_en      = ~t_en_done;
assign t_mstep_count_en   = ~t_mstep_done;
assign t_timeout_count_en = ~t_timeout_done;
assign E                  = ts_enable | vm_enable | pm_enable;

endmodule // dti_pvt_controller

