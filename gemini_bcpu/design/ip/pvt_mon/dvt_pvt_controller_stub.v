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

endmodule
