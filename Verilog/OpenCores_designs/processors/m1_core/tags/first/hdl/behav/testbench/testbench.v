/*
 * Simply RISC M1 Core Testbench
 */

module testbench();
  reg sys_clock_i, sys_reset_i;
  reg[31:0] sys_irq_i;

  m1_core core_0(sys_clock_i, sys_reset_i, sys_irq_i);

  always #1 sys_clock_i = ~sys_clock_i;

  initial begin

    // Display start message
    $display("INFO: TBENCH(%m): Starting Simply RISC M1 Core simulation...");
     
    // Create VCD trace file
    $dumpfile("trace.vcd");
    $dumpvars();

    // Run the simulation
    sys_clock_i <= 1;
    sys_reset_i <= 1;
    #5
    sys_reset_i <= 0;
    #1000
    $display("INFO: TBENCH(%m): Completed Simply RISC M1 Core simulation!");
    $finish;

  end

endmodule

