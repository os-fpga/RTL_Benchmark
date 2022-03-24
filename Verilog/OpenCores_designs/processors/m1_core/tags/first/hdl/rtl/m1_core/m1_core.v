/*
 * Simply RISC M1 Core Top-Level
 */

module m1_core (
    sys_clock_i, sys_reset_i, sys_irq_i
  );
   
  input sys_clock_i, sys_reset_i;
  input[31:0] sys_irq_i;
  wire[31:0] imem_addr, imem_data, dmem_addr, dmem_rdata, dmem_wdata;
  wire imem_read, imem_busy, dmem_read, dmem_write, dmem_busy;
  wire[3:0] dmem_sel;

  m1_cpu cpu_0(sys_clock_i, sys_reset_i, sys_irq_i,
    imem_addr, imem_data, imem_read, imem_busy,
    dmem_addr, dmem_rdata, dmem_wdata, dmem_read, dmem_write, dmem_busy , dmem_sel
  );

  m1_mmu mmu_0(sys_clock_i, sys_reset_i,
    imem_addr, imem_data, imem_read, imem_busy,
    dmem_addr, dmem_rdata, dmem_wdata, dmem_read, dmem_write, dmem_busy , dmem_sel
  );

endmodule
