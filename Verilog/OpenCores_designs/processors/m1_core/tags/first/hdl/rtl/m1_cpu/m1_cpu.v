/*
 * Simply RISC M1 Central Processing Unit
 *
 * TODO:
 * 1) check pipeline stages (especially load delay slot and branch delay slot)
 * 2) check interfaces with multiplier and divider
 * 3) interrupt and exception handling, SYSCALL and BREAK
 */

`include "m1_defs.h"

module m1_cpu (
    sys_clock_i, sys_reset_i, sys_irq_i,
    imem_addr_o, imem_data_i, imem_read_o, imem_busy_i,
    dmem_addr_o, dmem_data_i, dmem_data_o, dmem_read_o, dmem_write_o, dmem_busy_i , dmem_sel_o
  );

  /*
   * Input/Output
   */

  // System inputs
  input sys_clock_i;                                     // System Clock
  input sys_reset_i;                                     // System Reset
  input[31:0] sys_irq_i;                                 // Interrupt Requests (currently unused)

  // Instruction Memory
  output[31:0] imem_addr_o;                              // I$ Address
  input[31:0] imem_data_i;                               // I$ Data
  output imem_read_o;                                    // I$ Read
  input imem_busy_i;                                     // I$ Busy

  // Data Memory
  output[31:0] dmem_addr_o;                              // D$ Address
  input[31:0] dmem_data_i;                               // D$ Read Data
  output[31:0] dmem_data_o;                              // D$ Write Data
  output dmem_read_o;                                    // D$ Read
  output dmem_write_o;                                   // D$ Write
  output[3:0] dmem_sel_o;                                // D$ Byte selector
  input dmem_busy_i;                                     // D$ Busy

  /*
   * Registers
   */

  // Register file
  reg[31:0] GPR[0:31];                           // General Purpose Registers
  reg[31:0] PC;                                  // Program Counter
  reg[31:0] HI, LO;                              // HI and LO registers (for multiplication/division)
  reg[31:0] SysCon[0:31];                        // System Control registers

  /*
   * Pipeline latches
   */

  // Latch 1: IF/ID
  reg[31:0] if_id_opcode;                                            // Instruction Register
  reg[31:0] if_id_addr, if_id_addrnext;                              // Addresses of the fetched opcode and of the next one

  // Latch 2: ID/EX
<<<<<<< m1_cpu.v
  reg[31:0] id_ex_opcode;
  reg[31:0] id_ex_addr, id_ex_addrnext;
  reg[31:0] id_ex_addrbranch, id_ex_addrjump, id_ex_addrjr;          // Evaluated jump addresses
  reg[31:0] id_ex_alu_a, id_ex_alu_b;                                // ALU operands
  reg[4:0] id_ex_alu_func;                                           // ALU operation code
  reg id_ex_alu_signed;                                              // ALU operation is signed
  reg id_ex_branch, id_ex_jump, id_ex_jr, id_ex_linked;              // Instruction is a jump
  reg id_ex_mult, id_ex_div;                                         // Instruction is a multiplication/division
  reg id_ex_load, id_ex_store;                                       // Instruction is a load/store
  reg[2:0] id_ex_size;                                               // Load/store size (see defs.h)
  reg[31:0] id_ex_store_value;                                       // Store value
  reg[4:0] id_ex_destreg;                                            // Destination register (GPR number)
  reg id_ex_desthi, id_ex_destlo;                                    // Destination register (HI/LO)
  reg[4:0] id_ex_destsyscon;                                         // Destination register (System Control)
=======
  reg[31:0] id_ex_pc, id_ex_pcnext;
  reg[31:0] id_ex_pcjump, id_ex_pcbranch;                // Jump addresses
  reg[31:0] id_ex_alu_a, id_ex_alu_b;                    // ALU operands
  reg[4:0] id_ex_alu_func;                               // ALU operation code
  reg id_ex_alu_signed;                                  // ALU operation is signed
  reg id_ex_jump, id_ex_branch, id_ex_linked;            // Instruction is a jump
  reg id_ex_load, id_ex_store;                           // Instruction is a load/store
  reg[31:0] id_ex_store_value;                           // Store value
  reg[4:0] id_ex_destreg;                                // Destination register (GPR)
  reg id_ex_desthi, id_ex_destlo;                        // Destination register (HI/LO)
>>>>>>> 1.9

  // Latch 3: EX/MEM
<<<<<<< m1_cpu.v
  reg[31:0] ex_mem_opcode;
  reg[31:0] ex_mem_addr, ex_mem_addrnext;
  reg[31:0] ex_mem_addrbranch, ex_mem_addrjump, ex_mem_addrjr;
  reg[63:0] ex_mem_aluout;                                           // ALU result
  reg ex_mem_branch, ex_mem_jump, ex_mem_jr, ex_mem_linked;
  reg ex_mem_mult, ex_mem_div;
  reg ex_mem_load,ex_mem_store;
  reg[31:0] ex_mem_store_value;
  reg[3:0] ex_mem_store_sel;                                         // Byte Selector on Stores
  reg[4:0] ex_mem_destreg;
  reg ex_mem_desthi, ex_mem_destlo;
  reg[4:0] ex_mem_destsyscon;
=======
  reg[31:0] ex_mem_pc, ex_mem_pcnext;
  reg[31:0] ex_mem_pcjump, ex_mem_pcbranch;
  reg[63:0] ex_mem_alu_out;                               // ALU result
  reg ex_mem_jump, ex_mem_branch, ex_mem_linked;
  reg ex_mem_load, ex_mem_store;
  reg[31:0] ex_mem_store_value;
  reg[4:0] ex_mem_destreg;                       
  reg ex_mem_desthi, ex_mem_destlo;               
>>>>>>> 1.9

  // Latch 4: MEM/WB
  reg[31:0] mem_wb_opcode;
  reg[31:0] mem_wb_addr, mem_wb_addrnext;
  reg[63:0] mem_wb_value;                                            // Write-back value
  reg[4:0] mem_wb_destreg;
  reg mem_wb_desthi, mem_wb_destlo;
  reg[4:0] mem_wb_destsyscon;

  /*
   * Wires
   */

  // Incremented Program Counters
  wire[31:0] PCnext = PC + 4;

  // Memories
  assign imem_read_o = 1;
  assign imem_addr_o = PC;
  assign dmem_addr_o = ex_mem_aluout;
  assign dmem_read_o = ex_mem_load;
  assign dmem_write_o = ex_mem_store;
  assign dmem_data_o = ex_mem_store_value;
  assign dmem_sel_o = ex_mem_store_sel;

  // Decode fields from the Instruction Register
  wire[5:0] if_id_op = if_id_opcode[31:26];                                     // Operation code
  wire[4:0] if_id_rs = if_id_opcode[25:21];                                     // Source register
  wire[4:0] if_id_rt = if_id_opcode[20:16];                                     // Target register
  wire[4:0] if_id_rd = if_id_opcode[15:11];                                     // Destination register
  wire[31:0] if_id_imm_signext = {{16{if_id_opcode[15]}}, if_id_opcode[15:0]};  // Immediate field with sign-extension
  wire[31:0] if_id_imm_zeroext = {16'b0, if_id_opcode[15:0]};                   // Immediate field with zero-extension
  wire[25:0] if_id_index = if_id_opcode[25:0];                                  // Index field
  wire[4:0] if_id_shamt = if_id_opcode[10:6];                                   // Shift amount
  wire[5:0] if_id_func = if_id_opcode[5:0];                                     // Function

  // Name the System Configuration registers
  wire[31:0] BadVAddr = SysCon[`SYSCON_BADVADDR];
  wire[31:0] Status = SysCon[`SYSCON_STATUS];
  wire[31:0] Cause = SysCon[`SYSCON_CAUSE];
  wire[31:0] EPC = SysCon[`SYSCON_EPC];
  wire[31:0] PrID = SysCon[`SYSCON_PRID];

  // Decode fields from the System Configuration registers
  wire cause_bd = Cause[31];                // Branch Delay
  wire[1:0] cause_ce = Cause[29:28];        // Coprocessor Error
  wire[5:0] cause_ip = Cause[15:10];        // Interrupts Pending
  wire[1:0] cause_sw = Cause[9:8];          // Software interrupts
  wire[3:0] cause_exccode = Cause[5:2];     // Exception Code
  wire[3:0] status_cu = Status[31:28];      // Coprocessor Usability
  wire status_bev = Status[22];             // Bootstrap Exception Vector
  wire status_ts = Status [21];             // TLB Shutdown
  wire status_pe = Status[20];              // Parity Error
  wire status_cm = Status[19];              // Cache Miss
  wire status_pz = Status[18];              // Parity Zero
  wire status_swc = Status[17];             // Swap Caches
  wire status_isc = Status[16];             // Isolate Cache
  wire[7:0] status_intmask = Status[15:0];  // Interrupt Mask
  wire status_kuo = Status[5];              // Kernel/User mode Old
  wire status_ieo = Status[4];              // Interrupt Enable Old
  wire status_kup = Status[3];              // Kernel/User mode Previous
  wire status_iep = Status[2];              // Interrupt Enable Previous
  wire status_kuc = Status[1];              // Kernel/User mode Current
  wire status_iec = Status[0];              // Interrupt Enable Current
  wire[7:0] prid_imp = PrID[15:8];          // Implementation
  wire[7:0] prid_rev = PrID[7:0];           // Revision

  // True for still undecoded operations that read GPR[rs]
  wire if_id_reads_rs = (
    if_id_op==`OPCODE_BEQ || if_id_op==`OPCODE_BNE || if_id_op==`OPCODE_BLEZ || if_id_op==`OPCODE_BGTZ ||
    if_id_op==`OPCODE_ADDI || if_id_op==`OPCODE_ADDIU || if_id_op==`OPCODE_SLTI || if_id_op==`OPCODE_SLTIU ||
    if_id_op==`OPCODE_ANDI || if_id_op==`OPCODE_ORI || if_id_op==`OPCODE_XORI || if_id_op==`OPCODE_LB ||
    if_id_op==`OPCODE_LH || if_id_op==`OPCODE_LWL || if_id_op==`OPCODE_LW || if_id_op==`OPCODE_LBU ||
    if_id_op==`OPCODE_LHU || if_id_op==`OPCODE_LWR || if_id_op==`OPCODE_SB || if_id_op==`OPCODE_SH ||
    if_id_op==`OPCODE_SWL || if_id_op==`OPCODE_SW || if_id_op==`OPCODE_SWR || (
      if_id_op==`OPCODE_SPECIAL && (
        if_id_func==`FUNCTION_SLLV || if_id_func==`FUNCTION_SRLV || if_id_func==`FUNCTION_SRAV ||
        if_id_func==`FUNCTION_JR || if_id_func==`FUNCTION_JALR || if_id_func==`FUNCTION_MTHI ||
        if_id_func==`FUNCTION_MTLO || if_id_func==`FUNCTION_MULT || if_id_func==`FUNCTION_MULTU ||
        if_id_func==`FUNCTION_DIV || if_id_func==`FUNCTION_DIVU || if_id_func==`FUNCTION_ADD ||
        if_id_func==`FUNCTION_ADDU || if_id_func==`FUNCTION_SUB || if_id_func==`FUNCTION_SUBU ||
        if_id_func==`FUNCTION_AND || if_id_func==`FUNCTION_OR || if_id_func==`FUNCTION_XOR ||
        if_id_func==`FUNCTION_NOR || if_id_func==`FUNCTION_SLT || if_id_func==`FUNCTION_SLTU
      )
    ) || (
      if_id_op==`OPCODE_BCOND && (
        if_id_rt==`BCOND_BLTZ || if_id_rt==`BCOND_BGEZ || if_id_rt==`BCOND_BLTZAL || if_id_rt==`BCOND_BGEZAL
      )
   )
  );

  // True for still undecoded operations that read GPR[rt]
  wire if_id_reads_rt = (
    if_id_op==`OPCODE_BEQ || if_id_op==`OPCODE_BNE || if_id_op==`OPCODE_SB || if_id_op==`OPCODE_SH ||
    if_id_op==`OPCODE_SWL || if_id_op==`OPCODE_SW || if_id_op==`OPCODE_SWR || (
      if_id_op==`OPCODE_SPECIAL && (
        if_id_func==`FUNCTION_SLL || if_id_func==`FUNCTION_SRL || if_id_func==`FUNCTION_SRA ||
        if_id_func==`FUNCTION_SLLV || if_id_func==`FUNCTION_SRLV || if_id_func==`FUNCTION_SRAV ||
        if_id_func==`FUNCTION_MULT || if_id_func==`FUNCTION_MULTU || if_id_func==`FUNCTION_DIV ||
        if_id_func==`FUNCTION_DIVU || if_id_func==`FUNCTION_ADD || if_id_func==`FUNCTION_ADDU ||
        if_id_func==`FUNCTION_SUB || if_id_func==`FUNCTION_SUBU || if_id_func==`FUNCTION_AND ||
        if_id_func==`FUNCTION_OR || if_id_func==`FUNCTION_XOR || if_id_func==`FUNCTION_NOR ||
        if_id_func==`FUNCTION_SLT || if_id_func==`FUNCTION_SLTU
      )
    )
  );

  // True for still undecoded operations that read the HI register
  wire if_id_reads_hi = (if_id_op==`OPCODE_SPECIAL && if_id_func==`FUNCTION_MFHI);

  // True for still undecoded operations that read the LO register
  wire if_id_reads_lo = (if_id_op==`OPCODE_SPECIAL && if_id_func==`FUNCTION_MFLO);

  // Finally detect a RAW hazard
  wire raw_detected = (
    (if_id_reads_rs && if_id_rs!=0 &&
      (if_id_rs==id_ex_destreg || if_id_rs==ex_mem_destreg || if_id_rs==mem_wb_destreg)) ||
    (if_id_reads_rt && if_id_rt!=0 &&
      (if_id_rt==id_ex_destreg || if_id_rt==ex_mem_destreg || if_id_rt==mem_wb_destreg)) ||
    (if_id_reads_hi && (id_ex_desthi || ex_mem_desthi || mem_wb_desthi)) ||
    (if_id_reads_lo && (id_ex_destlo || ex_mem_destlo || mem_wb_destlo))
  );

  // Stall signals for all the stages
  wire if_stall, id_stall, ex_stall, mem_stall, wb_stall;

  // Wires connected to the ALU module instance
  wire[31:0] alu_a_i = id_ex_alu_a;
  wire[31:0] alu_b_i = id_ex_alu_b;
  wire[4:0] alu_func_i = id_ex_alu_func;
  wire alu_signed_i = id_ex_alu_signed;
  wire[31:0] alu_result_o;
  wire alu_carry_o;

  // Wires connected to the Multiplier module instance
  wire[31:0] mul_a_i = id_ex_alu_a;
  wire[31:0] mul_b_i = id_ex_alu_b;
  wire mul_signed_i = id_ex_alu_signed;
  wire[63:0] mul_product_o;
  reg mul_req_i;                            // Alternating Bit Protocol (ABP) request must be stored
  wire mul_ack_o;
  wire mul_ready = (mul_req_i==mul_ack_o);  // Convert ABP ack to true/false format
  wire mul_busy = !mul_ready;

  // Wires connected to the Divider module instance
  wire[31:0] div_a_i = id_ex_alu_a;
  wire[31:0] div_b_i = id_ex_alu_b;
  wire div_signed_i;
  wire[31:0] div_quotient_o;
  wire[31:0] div_remainder_o;
  reg div_req_i;                            // Alternating Bit Protocol (ABP) request must be stored
  wire div_ack_o;
  wire div_ready = (div_req_i==div_ack_o);  // Convert ABP ack to true/false format
  wire div_busy = !div_ready;

  /*
   * Module instances
   */

  alu alu_0(alu_a_i, alu_b_i, alu_func_i, alu_signed_i, alu_result_o, alu_carry_o);
  multiplier mul_0(sys_reset_i, sys_clock_i, mul_a_i, mul_b_i, mul_signed_i, mul_product_o, mul_req_i, mul_ack_o);
  divider div_0(sys_reset_i, sys_clock_i, div_a_i, div_b_i, div_signed_i, div_quotient_o, div_remainder_o, div_req_i, div_ack_o);
   
  /*
   * Combinational logic
   */
   
  assign if_stall = id_stall || imem_busy_i;
  assign id_stall = ex_stall || raw_detected;
  assign ex_stall = mem_stall || mul_busy || div_busy;
  assign mem_stall = wb_stall || dmem_busy_i;
  assign wb_stall = 0;

  /*
   * Sequential logic
   */

  always @ (posedge sys_clock_i) begin
    if (sys_reset_i==1) begin

      $display("================> Time %t <================", $time);

      // Initialize all the registers

      // GPRs initialization
      GPR[0] <= 0;  GPR[1] <= 0;  GPR[2] <= 0;  GPR[3] <= 0;  GPR[4] <= 0;  GPR[5] <= 0;  GPR[6] <= 0;  GPR[7] <= 0;
      GPR[8] <= 0;  GPR[9] <= 0;  GPR[10] <= 0; GPR[11] <= 0; GPR[12] <= 0; GPR[13] <= 0; GPR[14] <= 0; GPR[15] <= 0;
      GPR[16] <= 0; GPR[17] <= 0; GPR[18] <= 0; GPR[19] <= 0; GPR[20] <= 0; GPR[21] <= 0; GPR[22] <= 0; GPR[23] <= 0;
      GPR[24] <= 0; GPR[25] <= 0; GPR[26] <= 0; GPR[27] <= 0; GPR[28] <= 0; GPR[29] <= 0; GPR[30] <= 0; GPR[31] <= 0;

      // System registers
      PC <= `BOOT_ADDRESS;
      HI <= 0;
      LO <= 0;

      // System Control registers initialization
      SysCon[0] <= 0;  SysCon[1] <= 0;  SysCon[2] <= 0;  SysCon[3] <= 0;  SysCon[4] <= 0;  SysCon[5] <= 0;  SysCon[6] <= 0;  SysCon[7] <= 0;
      SysCon[8] <= 0;  SysCon[9] <= 0;  SysCon[10] <= 0; SysCon[11] <= 0; SysCon[12] <= 0; SysCon[13] <= 0; SysCon[14] <= 0; SysCon[15] <= 0;
      SysCon[16] <= 0; SysCon[17] <= 0; SysCon[18] <= 0; SysCon[19] <= 0; SysCon[20] <= 0; SysCon[21] <= 0; SysCon[22] <= 0; SysCon[23] <= 0;
      SysCon[24] <= 0; SysCon[25] <= 0; SysCon[26] <= 0; SysCon[27] <= 0; SysCon[28] <= 0; SysCon[29] <= 0; SysCon[30] <= 0; SysCon[31] <= 0;

      // Initialize ABP requests to instantiated modules
      mul_req_i <= 0;
      div_req_i <= 0;

      // Latch 1: IF/ID
      if_id_opcode <= `NOP;
      if_id_addr <= `BOOT_ADDRESS;
      if_id_addrnext <= 0;

      // Latch 2: ID/EX
      id_ex_opcode <= 0;
      id_ex_addr <= 0;
      id_ex_addrnext <= 0;
      id_ex_addrjump <= 0;
      id_ex_addrbranch <= 0;
      id_ex_alu_a <= 0;
      id_ex_alu_b <= 0;
      id_ex_alu_func <= `ALU_OP_ADD;
      id_ex_alu_signed <= 0;
      id_ex_branch <= 0;
      id_ex_jump <= 0;
      id_ex_jr <=0;
      id_ex_linked <= 0;
      id_ex_mult <= 0;
      id_ex_div <= 0;
      id_ex_load <= 0;
      id_ex_store <= 0;
      id_ex_size <= 0;
      id_ex_store_value <= 0;
      id_ex_destreg <= 0;
      id_ex_desthi <= 0;
      id_ex_destlo <= 0;
      id_ex_destsyscon <= 0;

      // Latch 3: EX/MEM
      ex_mem_opcode <= 0;
      ex_mem_addr <= 0;
      ex_mem_addrnext <= 0;
      ex_mem_addrjump <= 0;
      ex_mem_addrbranch <= 0;
      ex_mem_aluout <= 0;
      ex_mem_branch <= 0;
      ex_mem_jump <= 0;
      ex_mem_jr <= 0;
      ex_mem_linked <= 0;
      ex_mem_mult <= 0;
      ex_mem_div <= 0;
      ex_mem_load <= 0;
      ex_mem_store <= 0;
      ex_mem_store_value <= 0;
      ex_mem_store_sel <= 0;
      ex_mem_destreg <= 0;
      ex_mem_desthi <= 0;
      ex_mem_destlo <= 0;
      ex_mem_destsyscon <= 0;

      // Latch 4: MEM/WB
      mem_wb_opcode <= 0;
      mem_wb_addr <= 0;
      mem_wb_addrnext <= 0;
      mem_wb_value <= 0;
      mem_wb_destreg <= 0;
      mem_wb_desthi <= 0;
      mem_wb_destlo <= 0;
      mem_wb_destsyscon <= 0;

    end else begin

      $display("================> Time %t <================", $time);

      /*
       * Pipeline Stage 1: Instruction Fetch (IF)
       * 
       * READ/WRITE:
       * - read memory
       * - write the IF/ID latch
       * - write the PC register
       * 
       * DESCRIPTION:
       * This stage usually reads the next instruction from the PC address in memory and
       * then updates the PC value by incrementing it by 4.
       * When a hazard is detected this stage is idle.
       */

      // A RAW hazard will stall the CPU
      if(if_stall) begin
        $display("INFO: CPU(%m)-IF: Fetching stalled");

      // Branch taken: insert a bubble and increment PC
      end else if(ex_mem_branch==1 && ex_mem_aluout==1) begin
        $display("INFO: CPU(%m)-IF: Bubble inserted due branch taken in EX/MEM instruction @ADDR=%X w/OPCODE=%X having ALUout=%X",
          ex_mem_addr, ex_mem_opcode, ex_mem_aluout);
        if_id_opcode <= `BUBBLE;
        PC <= ex_mem_addrbranch;

      // Jump to the required immediate address
      end else if(id_ex_jump==1) begin
        $display("INFO: CPU(%m)-IF: Bubble inserted due to jump in ID/EX instruction @ADDR=%X w/OPCODE=%X", id_ex_addr, id_ex_opcode);
        if_id_opcode <= `BUBBLE;
        PC <= id_ex_addrjump;

      // Jump to the required address stored in GPR
      end else if(id_ex_jr==1) begin
        $display("INFO: CPU(%m)-IF: Bubble inserted due to jump register in ID/EX instruction @ADDR=%X w/OPCODE=%X", id_ex_addr, id_ex_opcode);
        if_id_opcode <= `BUBBLE;
        PC <= id_ex_addrjr;

      // Normal execution
      end else begin
        $display("INFO: CPU(%m)-IF: Fetched from Program Counter @ADDR=%h getting OPCODE=%X", PC, imem_data_i);
        if_id_opcode <= imem_data_i;
        if_id_addr <= PC;
        if_id_addrnext <= PCnext;
        PC <= PCnext;
      end

      /*
       * Pipeline Stage 2: Instruction Decode (ID)
       * 
       * READ/WRITE:
       * - read the IF/ID latch
       * - read the register file
       * - write the ID/EX latch
       * 
       * DESCRIPTION:
       * This stage decodes the instruction and puts the values for the ALU inputs
       */

      if(id_stall) begin

        // Insert a bubble in the pipeline
        $display("INFO: CPU(%m)-ID: Decoding stalled");
        id_ex_alu_a <= 0;
        id_ex_alu_b <= 0;
        id_ex_alu_func <= `ALU_OP_ADD;
        id_ex_alu_signed <= 0;
        id_ex_branch <= 0;
        id_ex_jump <= 0;
        id_ex_jr <= 0;
        id_ex_linked <= 0;
        id_ex_mult <= 0;
	id_ex_div <= 0;
        id_ex_load <= 0;
        id_ex_store <= 0;
        id_ex_size <= 0;
        id_ex_store_value <= 0;
        id_ex_destreg <= 0;
        id_ex_desthi <= 0;
        id_ex_destlo <= 0;

      end else begin

        id_ex_opcode <= if_id_opcode;
        id_ex_addr <= if_id_addr;
        id_ex_addrnext <= if_id_addrnext;
        id_ex_addrbranch <= if_id_addrnext + {if_id_imm_signext[29:0], 2'b00};
        id_ex_addrjump <= {if_id_addr[31:28], if_id_index, 2'b00};
        id_ex_addrjr <= GPR[if_id_rs];

        if(if_id_opcode==`BUBBLE) $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as BUBBLE", if_id_addr, if_id_opcode);
        else case(if_id_op)
          `OPCODE_J:
            begin
              $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as J %h", if_id_addr, if_id_opcode, if_id_index);
              id_ex_alu_a <= 0;
              id_ex_alu_b <= 0;
              id_ex_alu_func <= `ALU_OP_ADD;
              id_ex_alu_signed <= 0;
              id_ex_branch <= 0;
              id_ex_jump <= 1;
              id_ex_jr <= 0;
              id_ex_linked <= 0;
              id_ex_mult <= 0;
	      id_ex_div <= 0;
              id_ex_load <= 0;
              id_ex_store <= 0;
              id_ex_size <= 0;
              id_ex_store_value <= 0;
              id_ex_destreg <= 0;
              id_ex_desthi <= 0;
              id_ex_destlo <= 0;
              id_ex_destsyscon <= 0;
            end
          `OPCODE_JAL:
            begin
              $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as JAL %h", if_id_addr, if_id_opcode, if_id_index);
              id_ex_alu_a <= if_id_addrnext;
              id_ex_alu_b <= 0;
              id_ex_alu_func <= `ALU_OP_ADD;
              id_ex_alu_signed <= 0;
              id_ex_branch <= 0;
              id_ex_jump <= 1;
              id_ex_jr <= 0;
              id_ex_linked <= 1;
              id_ex_mult <= 0;
	      id_ex_div <= 0;
              id_ex_load <= 0;
              id_ex_store <= 0;
              id_ex_size <= 0;
              id_ex_store_value <= 0;
              id_ex_destreg <= 31;
              id_ex_desthi <= 0;
              id_ex_destlo <= 0;
              id_ex_destsyscon <= 0;
            end
          `OPCODE_BEQ:
            begin
              $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as BEQ r%d, r%d, %h", if_id_addr, if_id_opcode, if_id_rs, if_id_rt, if_id_imm_signext);
              id_ex_alu_a <= GPR[if_id_rs];
              id_ex_alu_b <= GPR[if_id_rt];
              id_ex_alu_func <= `ALU_OP_SEQ;
              id_ex_alu_signed <= 0;
              id_ex_branch <= 1;
              id_ex_jump <= 0;
              id_ex_jr <= 0;
              id_ex_linked <= 0;
              id_ex_mult <= 0;
	      id_ex_div <= 0;
              id_ex_load <= 0;
              id_ex_store <= 0;
              id_ex_size <= 0;
              id_ex_store_value <= 0;
              id_ex_destreg <= 0;
              id_ex_desthi <= 0;
              id_ex_destlo <= 0;
              id_ex_destsyscon <= 0;
            end
          `OPCODE_BNE:
            begin
              $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as BNE r%d, r%d, %h", if_id_addr, if_id_opcode, if_id_rs, if_id_rt, if_id_imm_signext);
              id_ex_alu_a <= GPR[if_id_rs];
              id_ex_alu_b <= GPR[if_id_rt];
              id_ex_alu_func <= `ALU_OP_SNE;
              id_ex_alu_signed <= 0;
              id_ex_branch <= 1;
              id_ex_jump <= 0;
              id_ex_jr <= 0;
              id_ex_linked <= 0;
              id_ex_mult <= 0;
	      id_ex_div <= 0;
              id_ex_load <= 0;
              id_ex_store <= 0;
              id_ex_size <= 0;
              id_ex_store_value <= 0;
              id_ex_destreg <= 0;
              id_ex_desthi <= 0;
              id_ex_destlo <= 0;
              id_ex_destsyscon <= 0;
            end
          `OPCODE_BLEZ:
            begin
              $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as BLEZ r%d, %h", if_id_addr, if_id_opcode, if_id_rs, if_id_imm_signext);
              id_ex_alu_a <= GPR[if_id_rs];
              id_ex_alu_b <= 0;
              id_ex_alu_func <= `ALU_OP_SLE;
              id_ex_alu_signed <= 0;
              id_ex_branch <= 1;
              id_ex_jump <= 0;
              id_ex_jr <= 0;
              id_ex_linked <= 0;
              id_ex_mult <= 0;
	      id_ex_div <= 0;
              id_ex_load <= 0;
              id_ex_store <= 0;
              id_ex_size <= 0;
              id_ex_store_value <= 0;
              id_ex_destreg <= 0;
              id_ex_desthi <= 0;
              id_ex_destlo <= 0;
              id_ex_destsyscon <= 0;
            end
          `OPCODE_BGTZ:
            begin
              $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as BGTZ r%d, %h", if_id_addr, if_id_opcode, if_id_rs, if_id_imm_signext);
              id_ex_alu_a <= GPR[if_id_rs];
              id_ex_alu_b <= 0;
              id_ex_alu_func <= `ALU_OP_SGT;
              id_ex_alu_signed <= 0;
              id_ex_branch <= 1;
              id_ex_jump <= 0;
              id_ex_jr <= 0;
              id_ex_linked <= 0;
              id_ex_mult <= 0;
	      id_ex_div <= 0;
              id_ex_load <= 0;
              id_ex_store <= 0;
              id_ex_size <= 0;
              id_ex_store_value <= 0;
              id_ex_destreg <= 0;
              id_ex_desthi <= 0;
              id_ex_destlo <= 0;
              id_ex_destsyscon <= 0;
            end
          `OPCODE_ADDI:
            begin
              $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as ADDI r%d, r%d, %h", if_id_addr, if_id_opcode, if_id_rt, if_id_rs, if_id_imm_signext);
              id_ex_alu_a <= GPR[if_id_rs];
              id_ex_alu_b <= if_id_imm_signext;
              id_ex_alu_func <= `ALU_OP_ADD;
              id_ex_alu_signed <= 1;
              id_ex_branch <= 0;
              id_ex_jump <= 0;
              id_ex_jr <= 0;
              id_ex_linked <= 0;
              id_ex_mult <= 0;
	      id_ex_div <= 0;
              id_ex_load <= 0;
              id_ex_store <= 0;
              id_ex_size <= 0;
              id_ex_store_value <= 0;
              id_ex_destreg <= if_id_rt;
              id_ex_desthi <= 0;
              id_ex_destlo <= 0;
              id_ex_destsyscon <= 0;
            end
          `OPCODE_ADDIU:
            begin
              $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as ADDIU r%d, r%d, %h", if_id_addr, if_id_opcode, if_id_rt, if_id_rs, if_id_imm_signext);
              id_ex_alu_a <= GPR[if_id_rs];
              id_ex_alu_b <= if_id_imm_signext;
              id_ex_alu_func <= `ALU_OP_ADD;
              id_ex_alu_signed <= 0;
              id_ex_branch <= 0;
              id_ex_jump <= 0;
              id_ex_jr <= 0;
              id_ex_linked <= 0;
              id_ex_mult <= 0;
	      id_ex_div <= 0;
              id_ex_load <= 0;
              id_ex_store <= 0;
              id_ex_size <= 0;
              id_ex_store_value <= 0;
              id_ex_destreg <= if_id_rt;
              id_ex_desthi <= 0;
              id_ex_destlo <= 0;
              id_ex_destsyscon <= 0;
            end
          `OPCODE_SLTI:
            begin
              $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as SLTI r%d, r%d, %h", if_id_addr, if_id_opcode, if_id_rt, if_id_rs, if_id_imm_signext);
              id_ex_alu_a <= GPR[if_id_rs];
              id_ex_alu_b <= if_id_imm_signext;
              id_ex_alu_func <= `ALU_OP_SLT;
              id_ex_alu_signed <= 1;
              id_ex_branch <= 0;
              id_ex_jump <= 0;
              id_ex_jr <= 0;
              id_ex_linked <= 0;
              id_ex_mult <= 0;
	      id_ex_div <= 0;
              id_ex_load <= 0;
              id_ex_store <= 0;
              id_ex_size <= 0;
              id_ex_store_value <= 0;
              id_ex_destreg <= if_id_rt;
              id_ex_desthi <= 0;
              id_ex_destlo <= 0;
              id_ex_destsyscon <= 0;
            end
          `OPCODE_SLTIU:
            begin
              $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as SLTIU r%d, r%d, %h", if_id_addr, if_id_opcode, if_id_rt, if_id_rs, if_id_imm_signext);
              id_ex_alu_a <= GPR[if_id_rs];
              id_ex_alu_b <= if_id_imm_signext;
              id_ex_alu_func <= `ALU_OP_SLT;
              id_ex_alu_signed <= 0;
              id_ex_branch <= 0;
              id_ex_jump <= 0;
              id_ex_jr <= 0;
              id_ex_linked <= 0;
              id_ex_mult <= 0;
	      id_ex_div <= 0;
              id_ex_load <= 0;
              id_ex_store <= 0;
              id_ex_size <= 0;
              id_ex_store_value <= 0;
              id_ex_destreg <= if_id_rt;
              id_ex_desthi <= 0;
              id_ex_destlo <= 0;
              id_ex_destsyscon <= 0;
            end
          `OPCODE_ANDI:
            begin
              $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as ANDI r%d, r%d, %h", if_id_addr, if_id_opcode, if_id_rt, if_id_rs, if_id_imm_zeroext);
              id_ex_alu_a <= GPR[if_id_rs];
              id_ex_alu_b <= if_id_imm_zeroext;
              id_ex_alu_func <= `ALU_OP_AND;
              id_ex_alu_signed <= 0;
              id_ex_branch <= 0;
              id_ex_jump <= 0;
              id_ex_jr <= 0;
              id_ex_linked <= 0;
              id_ex_mult <= 0;
	      id_ex_div <= 0;
              id_ex_load <= 0;
              id_ex_store <= 0;
              id_ex_size <= 0;
              id_ex_store_value <= 0;
              id_ex_destreg <= if_id_rt;
              id_ex_desthi <= 0;
              id_ex_destlo <= 0;
              id_ex_destsyscon <= 0;
            end
          `OPCODE_ORI:
            begin
              $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as ORI r%d, r%d, %h", if_id_addr, if_id_opcode, if_id_rt, if_id_rs, if_id_imm_zeroext);
              id_ex_alu_a <= GPR[if_id_rs];
              id_ex_alu_b <= if_id_imm_zeroext;
              id_ex_alu_func <= `ALU_OP_OR;
              id_ex_alu_signed <= 0;
              id_ex_branch <= 0;
              id_ex_jump <= 0;
              id_ex_jr <= 0;
              id_ex_linked <= 0;
              id_ex_mult <= 0;
	      id_ex_div <= 0;
              id_ex_load <= 0;
              id_ex_store <= 0;
              id_ex_size <= 0;
              id_ex_store_value <= 0;
              id_ex_destreg <= if_id_rt;
              id_ex_desthi <= 0;
              id_ex_destlo <= 0;
              id_ex_destsyscon <= 0;
            end
          `OPCODE_XORI:
            begin
              $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as XORI r%d, r%d, %h", if_id_addr, if_id_opcode, if_id_rt, if_id_rs, if_id_imm_zeroext);
              id_ex_alu_a <= GPR[if_id_rs];
              id_ex_alu_b <= if_id_imm_zeroext;
              id_ex_alu_func <= `ALU_OP_XOR;
              id_ex_alu_signed <= 0;
              id_ex_branch <= 0;
              id_ex_jump <= 0;
              id_ex_jr <= 0;
              id_ex_linked <= 0;
              id_ex_mult <= 0;
	      id_ex_div <= 0;
              id_ex_load <= 0;
              id_ex_store <= 0;
              id_ex_size <= 0;
              id_ex_store_value <= 0;
              id_ex_destreg <= if_id_rt;
              id_ex_desthi <= 0;
              id_ex_destlo <= 0;
              id_ex_destsyscon <= 0;
            end
          `OPCODE_LUI:
            begin
              $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as LUI r%d, %h", if_id_addr, if_id_opcode, if_id_rt, if_id_imm_zeroext);
              id_ex_alu_a <= if_id_imm_zeroext;
              id_ex_alu_b <= 16;
              id_ex_alu_func <= `ALU_OP_SLL;
              id_ex_alu_signed <= 0;
              id_ex_branch <= 0;
              id_ex_jump <= 0;
              id_ex_jr <= 0;
              id_ex_linked <= 0;
              id_ex_mult <= 0;
	      id_ex_div <= 0;
              id_ex_load <= 0;
              id_ex_store <= 0;
              id_ex_size <= 0;
              id_ex_store_value <= 0;
              id_ex_destreg <= if_id_rt;
              id_ex_desthi <= 0;
              id_ex_destlo <= 0;
              id_ex_destsyscon <= 0;
            end
          `OPCODE_COP0:
            begin
              $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as COP0", if_id_addr, if_id_opcode);
            end
          `OPCODE_COP1:
            begin
              $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as COP1", if_id_addr, if_id_opcode);
            end
          `OPCODE_COP2:
            begin
              $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as COP2", if_id_addr, if_id_opcode);
            end
          `OPCODE_COP3:
            begin
              $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as COP3", if_id_addr, if_id_opcode);
            end
          `OPCODE_LB:
            begin
              $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as LB r%d, %d(r%d)", if_id_addr, if_id_opcode, if_id_rt, if_id_imm_signext, if_id_rs);
              id_ex_alu_a <= GPR[if_id_rs];
              id_ex_alu_b <= if_id_imm_signext;
              id_ex_alu_func <= `ALU_OP_ADD;
              id_ex_alu_signed <= 1;
              id_ex_branch <= 0;
              id_ex_jump <= 0;
              id_ex_jr <= 0;
              id_ex_linked <= 0;
              id_ex_mult <= 0;
	      id_ex_div <= 0;
              id_ex_load <= 1;
              id_ex_store <= 0;
              id_ex_size <= `SIZE_BYTE;
              id_ex_store_value <= 0;
              id_ex_destreg <= if_id_rt;
              id_ex_desthi <= 0;
              id_ex_destlo <= 0;
              id_ex_destsyscon <= 0;
            end
          `OPCODE_LH:
            begin
              $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as LH r%d, %d(r%d)", if_id_addr, if_id_opcode, if_id_rt, if_id_imm_signext, if_id_rs);
              id_ex_alu_a <= GPR[if_id_rs];
              id_ex_alu_b <= if_id_imm_signext;
              id_ex_alu_func <= `ALU_OP_ADD;
              id_ex_alu_signed <= 1;
              id_ex_branch <= 0;
              id_ex_jump <= 0;
              id_ex_jr <= 0;
              id_ex_linked <= 0;
              id_ex_mult <= 0;
	      id_ex_div <= 0;
              id_ex_load <= 1;
              id_ex_store <= 0;
              id_ex_size <= `SIZE_HALF;
              id_ex_store_value <= 0;
              id_ex_destreg <= if_id_rt;
              id_ex_desthi <= 0;
              id_ex_destlo <= 0;
              id_ex_destsyscon <= 0;
            end
          `OPCODE_LWL:
            begin
              $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as LWL r%d, %d(r%d)", if_id_addr, if_id_opcode, if_id_rt, if_id_imm_signext, if_id_rs);
              id_ex_alu_a <= GPR[if_id_rs];
              id_ex_alu_b <= if_id_imm_signext;
              id_ex_alu_func <= `ALU_OP_ADD;
              id_ex_alu_signed <= 1;
              id_ex_branch <= 0;
              id_ex_jump <= 0;
              id_ex_jr <= 0;
              id_ex_linked <= 0;
              id_ex_mult <= 0;
	      id_ex_div <= 0;
              id_ex_load <= 1;
              id_ex_store <= 0;
              id_ex_size <= `SIZE_LEFT;
              id_ex_store_value <= 0;
              id_ex_destreg <= if_id_rt;
              id_ex_desthi <= 0;
              id_ex_destlo <= 0;
              id_ex_destsyscon <= 0;
            end
          `OPCODE_LW:
            begin
              $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as LW r%d, %d(r%d)", if_id_addr, if_id_opcode, if_id_rt, if_id_imm_signext, if_id_rs);
              id_ex_alu_a <= GPR[if_id_rs];
              id_ex_alu_b <= if_id_imm_signext;
              id_ex_alu_func <= `ALU_OP_ADD;
              id_ex_alu_signed <= 1;
              id_ex_branch <= 0;
              id_ex_jump <= 0;
              id_ex_jr <= 0;
              id_ex_linked <= 0;
              id_ex_mult <= 0;
	      id_ex_div <= 0;
              id_ex_load <= 1;
              id_ex_store <= 0;
              id_ex_size <= `SIZE_WORD;
              id_ex_store_value <= 0;
              id_ex_destreg <= if_id_rt;
              id_ex_desthi <= 0;
              id_ex_destlo <= 0;
              id_ex_destsyscon <= 0;
            end
          `OPCODE_LBU:
            begin
              $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as LBU r%d, %d(r%d)", if_id_addr, if_id_opcode, if_id_rt, if_id_imm_signext, if_id_rs);
              id_ex_alu_a <= GPR[if_id_rs];
              id_ex_alu_b <= if_id_imm_signext;
              id_ex_alu_func <= `ALU_OP_ADD;
              id_ex_alu_signed <= 0;
              id_ex_branch <= 0;
              id_ex_jump <= 0;
              id_ex_jr <= 0;
              id_ex_linked <= 0;
              id_ex_mult <= 0;
	      id_ex_div <= 0;
              id_ex_load <= 1;
              id_ex_store <= 0;
              id_ex_size <= `SIZE_BYTE;
              id_ex_store_value <= 0;
              id_ex_destreg <= if_id_rt;
              id_ex_desthi <= 0;
              id_ex_destlo <= 0;
              id_ex_destsyscon <= 0;
            end
          `OPCODE_LHU:
            begin
              $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as LHU r%d, %d(r%d)", if_id_addr, if_id_opcode, if_id_rt, if_id_imm_signext, if_id_rs);
              id_ex_alu_a <= GPR[if_id_rs];
              id_ex_alu_b <= if_id_imm_signext;
              id_ex_alu_func <= `ALU_OP_ADD;
              id_ex_alu_signed <= 0;
              id_ex_branch <= 0;
              id_ex_jump <= 0;
              id_ex_jr <= 0;
              id_ex_linked <= 0;
              id_ex_mult <= 0;
	      id_ex_div <= 0;
              id_ex_load <= 1;
              id_ex_store <= 0;
              id_ex_size <= `SIZE_HALF;
              id_ex_store_value <= 0;
              id_ex_destreg <= if_id_rt;
              id_ex_desthi <= 0;
              id_ex_destlo <= 0;
              id_ex_destsyscon <= 0;
            end
          `OPCODE_LWR:
            begin
              $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as LWR r%d, %d(r%d)", if_id_addr, if_id_opcode, if_id_rt, if_id_imm_signext, if_id_rs);
              id_ex_alu_a <= GPR[if_id_rs];
              id_ex_alu_b <= if_id_imm_signext;
              id_ex_alu_func <= `ALU_OP_ADD;
              id_ex_alu_signed <= 1;
              id_ex_branch <= 0;
              id_ex_jump <= 0;
              id_ex_jr <= 0;
              id_ex_linked <= 0;
              id_ex_mult <= 0;
	      id_ex_div <= 0;
              id_ex_load <= 1;
              id_ex_store <= 0;
              id_ex_size <= `SIZE_RIGHT;
              id_ex_store_value <= 0;
              id_ex_destreg <= if_id_rt;
              id_ex_desthi <= 0;
              id_ex_destlo <= 0;
              id_ex_destsyscon <= 0;
            end
          `OPCODE_SB:
            begin
              $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as SB r%d, %d(r%d)", if_id_addr, if_id_opcode, if_id_rt, if_id_imm_signext, if_id_rs);
              id_ex_alu_a <= GPR[if_id_rs];
              id_ex_alu_b <= if_id_imm_signext;
              id_ex_alu_func <= `ALU_OP_ADD;
              id_ex_alu_signed <= 1;
              id_ex_branch <= 0;
              id_ex_jump <= 0;
              id_ex_jr <= 0;
              id_ex_linked <= 0;
              id_ex_mult <= 0;
	      id_ex_div <= 0;
              id_ex_load <= 0;
              id_ex_store <= 1;
              id_ex_size <= `SIZE_BYTE;
              id_ex_store_value <= GPR[if_id_rt];
              id_ex_destreg <= 0;
              id_ex_desthi <= 0;
              id_ex_destlo <= 0;
              id_ex_destsyscon <= 0;
            end
          `OPCODE_SH:
            begin
              $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as SH r%d, %d(r%d)", if_id_addr, if_id_opcode, if_id_rt, if_id_imm_signext, if_id_rs);
              id_ex_alu_a <= GPR[if_id_rs];
              id_ex_alu_b <= if_id_imm_signext;
              id_ex_alu_func <= `ALU_OP_ADD;
              id_ex_alu_signed <= 1;
              id_ex_branch <= 0;
              id_ex_jump <= 0;
              id_ex_jr <= 0;
              id_ex_linked <= 0;
              id_ex_mult <= 0;
	      id_ex_div <= 0;
              id_ex_load <= 0;
              id_ex_store <= 1;
              id_ex_size <= `SIZE_HALF;
              id_ex_store_value <= GPR[if_id_rt];
              id_ex_destreg <= 0;
              id_ex_desthi <= 0;
              id_ex_destlo <= 0;
              id_ex_destsyscon <= 0;
             end
          `OPCODE_SWL:
            begin
              $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as SWL r%d, %d(r%d)", if_id_addr, if_id_opcode, if_id_rt, if_id_imm_signext, if_id_rs);
              id_ex_alu_a <= GPR[if_id_rs];
              id_ex_alu_b <= if_id_imm_signext;
              id_ex_alu_func <= `ALU_OP_ADD;
              id_ex_alu_signed <= 1;
              id_ex_branch <= 0;
              id_ex_jump <= 0;
              id_ex_jr <= 0;
              id_ex_linked <= 0;
              id_ex_mult <= 0;
	      id_ex_div <= 0;
              id_ex_load <= 0;
              id_ex_store <= 1;
              id_ex_size <= `SIZE_LEFT;
              id_ex_store_value <= GPR[if_id_rt];
              id_ex_destreg <= 0;
              id_ex_desthi <= 0;
              id_ex_destlo <= 0;
              id_ex_destsyscon <= 0;
            end
          `OPCODE_SW:
            begin
              $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as SW r%d, %d(r%d)", if_id_addr, if_id_opcode, if_id_rt, if_id_imm_signext, if_id_rs);
              id_ex_alu_a <= GPR[if_id_rs];
              id_ex_alu_b <= if_id_imm_signext;
              id_ex_alu_func <= `ALU_OP_ADD;
              id_ex_alu_signed <= 1;
              id_ex_branch <= 0;
              id_ex_jump <= 0;
              id_ex_jr <= 0;
              id_ex_linked <= 0;
              id_ex_mult <= 0;
	      id_ex_div <= 0;
              id_ex_load <= 0;
              id_ex_store <= 1;
              id_ex_size <= `SIZE_WORD;
              id_ex_store_value <= GPR[if_id_rt];
              id_ex_destreg <= 0;
              id_ex_desthi <= 0;
              id_ex_destlo <= 0;
              id_ex_destsyscon <= 0;
            end
          `OPCODE_SWR:
            begin
              $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as SWR r%d, %d(r%d)", if_id_addr, if_id_opcode, if_id_rt, if_id_imm_signext, if_id_rs);
              id_ex_alu_a <= GPR[if_id_rs];
              id_ex_alu_b <= if_id_imm_signext;
              id_ex_alu_func <= `ALU_OP_ADD;
              id_ex_alu_signed <= 1;
              id_ex_branch <= 0;
              id_ex_jump <= 0;
              id_ex_jr <= 0;
              id_ex_linked <= 0;
              id_ex_mult <= 0;
	      id_ex_div <= 0;
              id_ex_load <= 0;
              id_ex_store <= 1;
              id_ex_size <= `SIZE_RIGHT;
              id_ex_store_value <= GPR[if_id_rt];
              id_ex_destreg <= 0;
              id_ex_desthi <= 0;
              id_ex_destlo <= 0;
              id_ex_destsyscon <= 0;
            end
          `OPCODE_LWC1:
            begin
              $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as LWC1", if_id_addr, if_id_opcode);
           end
          `OPCODE_LWC2:
            begin
              $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as LWC2", if_id_addr, if_id_opcode);
            end
          `OPCODE_LWC3:
            begin
              $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as LWC3", if_id_addr, if_id_opcode);
            end
          `OPCODE_SWC1:
            begin
              $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as SWC1", if_id_addr, if_id_opcode);
            end
          `OPCODE_SWC2:
            begin
              $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as SWC2", if_id_addr, if_id_opcode);
            end
          `OPCODE_SWC3:
            begin
              $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as SWC3", if_id_addr, if_id_opcode);
            end
          `OPCODE_SPECIAL:
            case(if_id_func)
              `FUNCTION_SLL:
                begin
                  if(if_id_opcode==`NOP) $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as NOP", if_id_addr, if_id_opcode);
                  else $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as SLL r%d, r%d, %h", if_id_addr, if_id_opcode, if_id_rd, if_id_rt, if_id_shamt);
                  id_ex_alu_a <= GPR[if_id_rt];
                  id_ex_alu_b <= if_id_shamt;
                  id_ex_alu_func <= `ALU_OP_SLL;
                  id_ex_alu_signed <= 0;
                  id_ex_branch <= 0;
                  id_ex_jump <= 0;
                  id_ex_jr <= 0;
                  id_ex_linked <= 0;
                  id_ex_mult <= 0;
	          id_ex_div <= 0;
                  id_ex_load <= 0;
                  id_ex_store <= 0;
                  id_ex_size <= 0;
                  id_ex_store_value <= 0;
                  id_ex_destreg <= if_id_rd;
                  id_ex_desthi <= 0;
                  id_ex_destlo <= 0;
                  id_ex_destsyscon <= 0;
                end
              `FUNCTION_SRL:
                begin
                  $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as SRL r%d, r%d, %h", if_id_addr, if_id_opcode, if_id_rd, if_id_rt, if_id_shamt);
                  id_ex_alu_a <= GPR[if_id_rt];
                  id_ex_alu_b <= if_id_shamt;
                  id_ex_alu_func <= `ALU_OP_SRL;
                  id_ex_alu_signed <= 0;
                  id_ex_branch <= 0;
                  id_ex_jump <= 0;
                  id_ex_jr <= 0;
                  id_ex_linked <= 0;
                  id_ex_mult <= 0;
	          id_ex_div <= 0;
                  id_ex_load <= 0;
                  id_ex_store <= 0;
                  id_ex_size <= 0;
                  id_ex_store_value <= 0;
                  id_ex_destreg <= if_id_rd;
                  id_ex_desthi <= 0;
                  id_ex_destlo <= 0;
                  id_ex_destsyscon <= 0;
                end
              `FUNCTION_SRA:
                begin
                  $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as SRA r%d, r%d, %h", if_id_addr, if_id_opcode, if_id_rd, if_id_rt, if_id_shamt);
                  id_ex_alu_a <= GPR[if_id_rt];
                  id_ex_alu_b <= if_id_shamt;
                  id_ex_alu_func <= `ALU_OP_SRA;
                  id_ex_alu_signed <= 1;                 // does nothing??
                  id_ex_branch <= 0;
                  id_ex_jump <= 0;
                  id_ex_jr <= 0;
                  id_ex_linked <= 0;
                  id_ex_mult <= 0;
	          id_ex_div <= 0;
                  id_ex_load <= 0;
                  id_ex_store <= 0;
                  id_ex_size <= 0;
                  id_ex_store_value <= 0;
                  id_ex_destreg <= if_id_rd;
                  id_ex_desthi <= 0;
                  id_ex_destlo <= 0;
                  id_ex_destsyscon <= 0;
                end
              `FUNCTION_SLLV:
                begin
                  $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as SLLV r%d, r%d, r%d", if_id_addr, if_id_opcode, if_id_rd, if_id_rt, if_id_rs);
                  id_ex_alu_a <= GPR[if_id_rt];
                  id_ex_alu_b <= GPR[if_id_rs];
                  id_ex_alu_func <= `ALU_OP_SLL;
                  id_ex_alu_signed <= 0;
                  id_ex_branch <= 0;
                  id_ex_jump <= 0;
                  id_ex_jr <= 0;
                  id_ex_linked <= 0;
                  id_ex_mult <= 0;
	          id_ex_div <= 0;
                  id_ex_load <= 0;
                  id_ex_store <= 0;
                  id_ex_size <= 0;
                  id_ex_store_value <= 0;
                  id_ex_destreg <= if_id_rd;
                  id_ex_desthi <= 0;
                  id_ex_destlo <= 0;
                  id_ex_destsyscon <= 0;
                end
              `FUNCTION_SRLV:
                begin
                  $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as SRLV r%d, r%d, r%d", if_id_addr, if_id_opcode, if_id_rd, if_id_rt, if_id_rs);
                  id_ex_alu_a <= GPR[if_id_rt];
                  id_ex_alu_b <= GPR[if_id_rs];
                  id_ex_alu_func <= `ALU_OP_SRL;
                  id_ex_alu_signed <= 0;
                  id_ex_branch <= 0;
                  id_ex_jump <= 0;
                  id_ex_jr <= 0;
                  id_ex_linked <= 0;
                  id_ex_mult <= 0;
	          id_ex_div <= 0;
                  id_ex_load <= 0;
                  id_ex_store <= 0;
                  id_ex_size <= 0;
                  id_ex_store_value <= 0;
                  id_ex_destreg <= if_id_rd;
                  id_ex_desthi <= 0;
                  id_ex_destlo <= 0;
                  id_ex_destsyscon <= 0;
                end
              `FUNCTION_SRAV:
                begin
                  $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as SRAV r%d, r%d, r%d", if_id_addr, if_id_opcode, if_id_rd, if_id_rt, if_id_rs);
                  id_ex_alu_a <= GPR[if_id_rt];
                  id_ex_alu_b <= GPR[if_id_rs];
                  id_ex_alu_func <= `ALU_OP_SRA;
                  id_ex_alu_signed <= 1;
                  id_ex_branch <= 0;
                  id_ex_jump <= 0;
                  id_ex_jr <= 0;
                  id_ex_linked <= 0;
                  id_ex_mult <= 0;
	          id_ex_div <= 0;
                  id_ex_load <= 0;
                  id_ex_store <= 0;
                  id_ex_size <= 0;
                  id_ex_store_value <= 0;
                  id_ex_destreg <= if_id_rd;
                  id_ex_desthi <= 0;
                  id_ex_destlo <= 0;
                  id_ex_destsyscon <= 0;
                end
              `FUNCTION_JR:
                begin
                  $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as JR r%d", if_id_addr, if_id_opcode, if_id_rs);
                  id_ex_alu_a <= 0;
                  id_ex_alu_b <= 0;
                  id_ex_alu_func <= `ALU_OP_ADD;
                  id_ex_alu_signed <= 0;
                  id_ex_branch <= 0;
                  id_ex_jump <= 0;
                  id_ex_jr <= 1;
                  id_ex_linked <= 0;
                  id_ex_mult <= 0;
	          id_ex_div <= 0;
                  id_ex_load <= 0;
                  id_ex_store <= 0;
                  id_ex_size <= 0;
                  id_ex_store_value <= 0;
                  id_ex_destreg <= 0;
                  id_ex_desthi <= 0;
                  id_ex_destlo <= 0;
                  id_ex_destsyscon <= 0;
                end
              `FUNCTION_JALR:
                begin
                  $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as JALR [r%d,] r%d", if_id_addr, if_id_opcode, if_id_rd, if_id_rs);
                  id_ex_alu_a <= if_id_addrnext;
                  id_ex_alu_b <= 0;
                  id_ex_alu_func <= `ALU_OP_ADD;
                  id_ex_alu_signed <= 0;
                  id_ex_branch <= 0;
                  id_ex_jump <= 0;
                  id_ex_jr <= 1;
                  id_ex_linked <= 1;
                  id_ex_mult <= 0;
	          id_ex_div <= 0;
                  id_ex_load <= 0;
                  id_ex_store <= 0;
                  id_ex_size <= 0;
                  id_ex_store_value <= 0;
                  id_ex_destreg <= if_id_rd;
                  id_ex_desthi <= 0;
                  id_ex_destlo <= 0;
                  id_ex_destsyscon <= 0;
                end
              `FUNCTION_SYSCALL:
                begin
                  $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as SYSCALL", if_id_addr, if_id_opcode);
//                  id_ex_alu_a <= 0;
//                  id_ex_alu_b <= 0;
//                  id_ex_alu_func <= `ALU_OP_ADD;
//                  id_ex_alu_signed <= 0;
//                  id_ex_branch <= 0;
//                  id_ex_jump <= 0;
//                  id_ex_jr <= 0;
//                  id_ex_linked <= 0;
//                  id_ex_mult <= 0;
//                  id_ex_div <= 0;
//                  id_ex_load <= 0;
//                  id_ex_store <= 0;
//                  id_ex_size <= 0;
//                  id_ex_store_value <= 0;
//                  id_ex_destreg <= 0;
//                  id_ex_desthi <= 0;
//                  id_ex_destlo <= 0;
//                  id_ex_destsyscon <= 0;
                end
              `FUNCTION_BREAK:
                begin
                  $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as BREAK", if_id_addr, if_id_opcode);
//                  id_ex_alu_a <= 0;
//                  id_ex_alu_b <= 0;
//                  id_ex_alu_func <= `ALU_OP_ADD;
//                  id_ex_alu_signed <= 0;
//                  id_ex_branch <= 0;
//                  id_ex_jump <= 0;
//                  id_ex_jr <= 0;
//                  id_ex_linked <= 0;
//                  id_ex_mult <= 0;
//                  id_ex_div <= 0;
//                  id_ex_load <= 0;
//                  id_ex_store <= 0;
//                  id_ex_size <= 0;
//                  id_ex_store_value <= 0;
//                  id_ex_destreg <= 0;
//                  id_ex_desthi <= 0;
//                  id_ex_destlo <= 0;
//                  id_ex_destsyscon <= 0;
                end
              `FUNCTION_MFHI:
                begin
                  $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as MFHI r%d", if_id_addr, if_id_opcode, if_id_rd);
                  id_ex_alu_a <= HI;
                  id_ex_alu_b <= 0;
                  id_ex_alu_func <= `ALU_OP_ADD;
                  id_ex_alu_signed <= 0;
                  id_ex_branch <= 0;
                  id_ex_jump <= 0;
                  id_ex_jr <= 0;
                  id_ex_linked <= 0;
                  id_ex_mult <= 0;
	          id_ex_div <= 0;
                  id_ex_load <= 0;
                  id_ex_store <= 0;
                  id_ex_size <= 0;
                  id_ex_store_value <= 0;
                  id_ex_destreg <= if_id_rd;
                  id_ex_desthi <= 0;
                  id_ex_destlo <= 0;
                  id_ex_destsyscon <= 0;
                end
              `FUNCTION_MTHI:
                begin
                  $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as MTHI r%d", if_id_addr, if_id_opcode, if_id_rs);
                  id_ex_alu_a <= GPR[if_id_rs];
                  id_ex_alu_b <= 0;
                  id_ex_alu_func <= `ALU_OP_ADD;
                  id_ex_alu_signed <= 0;
                  id_ex_branch <= 0;
                  id_ex_jump <= 0;
                  id_ex_jr <= 0;
                  id_ex_linked <= 0;
                  id_ex_mult <= 0;
	          id_ex_div <= 0;
                  id_ex_load <= 0;
                  id_ex_store <= 0;
                  id_ex_size <= 0;
                  id_ex_store_value <= 0;
                  id_ex_destreg <= 0;
                  id_ex_desthi <= 1;
                  id_ex_destlo <= 0;
                  id_ex_destsyscon <= 0;
                end
              `FUNCTION_MFLO:
                begin
                  $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as MFLO r%d", if_id_addr, if_id_opcode, if_id_rd);
                  id_ex_alu_a <= LO;
                  id_ex_alu_b <= 0;
                  id_ex_alu_func <= `ALU_OP_ADD;
                  id_ex_alu_signed <= 0;
                  id_ex_branch <= 0;
                  id_ex_jump <= 0;
                  id_ex_jr <= 0;
                  id_ex_linked <= 0;
                  id_ex_mult <= 0;
	          id_ex_div <= 0;
                  id_ex_load <= 0;
                  id_ex_store <= 0;
                  id_ex_size <= 0;
                  id_ex_store_value <= 0;
                  id_ex_destreg <= if_id_rd;
                  id_ex_desthi <= 0;
                  id_ex_destlo <= 0;
                  id_ex_destsyscon <= 0;
                end
              `FUNCTION_MTLO:
                begin
                  $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as MTLO r%d", if_id_addr, if_id_opcode, if_id_rs);
                  id_ex_alu_a <= GPR[if_id_rs];
                  id_ex_alu_b <= 0;
                  id_ex_alu_func <= `ALU_OP_ADD;
                  id_ex_alu_signed <= 0;
                  id_ex_branch <= 0;
                  id_ex_jump <= 0;
                  id_ex_linked <= 0;
                  id_ex_mult <= 0;
	          id_ex_div <= 0;
                  id_ex_load <= 0;
                  id_ex_store <= 0;
                  id_ex_size <= 0;
                  id_ex_store_value <= 0;
                  id_ex_destreg <= 0;
                  id_ex_desthi <= 0;
                  id_ex_destlo <= 1;
                  id_ex_destsyscon <= 0;
                end
              `FUNCTION_MULT:
                begin
                  $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as MULT r%d, r%d", if_id_addr, if_id_opcode, if_id_rs, if_id_rt);
                  id_ex_alu_a <= GPR[if_id_rs];
                  id_ex_alu_b <= GPR[if_id_rt];
                  id_ex_alu_func <= `ALU_OP_MULT;
                  id_ex_alu_signed <= 1;
                  id_ex_branch <= 0;
                  id_ex_jump <= 0;
                  id_ex_jr <= 0;
                  id_ex_linked <= 0;
                  id_ex_mult <= 1;
	          id_ex_div <= 0;
                  id_ex_load <= 0;
                  id_ex_store <= 0;
                  id_ex_size <= 0;
                  id_ex_store_value <= 0;
                  id_ex_destreg <= 0;
                  id_ex_desthi <= 1;
                  id_ex_destlo <= 1;
                  id_ex_destsyscon <= 0;
                  mul_req_i <= !mul_req_i;  // Toggle the ABP request
                end
              `FUNCTION_MULTU:
                begin
                  $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as MULTU r%d, r%d", if_id_addr, if_id_opcode, if_id_rs, if_id_rt);
                  id_ex_alu_a <= GPR[if_id_rs];
                  id_ex_alu_b <= GPR[if_id_rt];
                  id_ex_alu_func <= `ALU_OP_MULT;
                  id_ex_alu_signed <= 0;
                  id_ex_branch <= 0;
                  id_ex_jump <= 0;
                  id_ex_jr <= 0;
                  id_ex_linked <= 0;
                  id_ex_mult <= 1;
	          id_ex_div <= 0;
                  id_ex_load <= 0;
                  id_ex_store <= 0;
                  id_ex_size <= 0;
                  id_ex_store_value <= 0;
                  id_ex_destreg <= 0;
                  id_ex_desthi <= 1;
                  id_ex_destlo <= 1;
                  id_ex_destsyscon <= 0;
                  mul_req_i <= !mul_req_i;  // Toggle the ABP request
                end
              `FUNCTION_DIV:
                begin
                  $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as DIV r%d, r%d", if_id_addr, if_id_opcode, if_id_rs, if_id_rt);
                  id_ex_alu_a <= GPR[if_id_rs];
                  id_ex_alu_b <= GPR[if_id_rt];
                  id_ex_alu_func <= `ALU_OP_DIV;
                  id_ex_alu_signed <= 1;
                  id_ex_branch <= 0;
                  id_ex_jump <= 0;
                  id_ex_jr <= 0;
                  id_ex_linked <= 0;
                  id_ex_mult <= 0;
	          id_ex_div <= 1;
                  id_ex_load <= 0;
                  id_ex_store <= 0;
                  id_ex_size <= 0;
                  id_ex_store_value <= 0;
                  id_ex_destreg <= 0;
                  id_ex_desthi <= 1;
                  id_ex_destlo <= 1;
                  id_ex_destsyscon <= 0;
                  div_req_i <= !div_req_i;  // Toggle the ABP request
                end
              `FUNCTION_DIVU:
                begin
                  $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as DIVU r%d, r%d", if_id_addr, if_id_opcode, if_id_rs, if_id_rt);
                  id_ex_alu_a <= GPR[if_id_rs];
                  id_ex_alu_b <= GPR[if_id_rt];
                  id_ex_alu_func <= `ALU_OP_DIV;
                  id_ex_alu_signed <= 0;
                  id_ex_branch <= 0;
                  id_ex_jump <= 0;
                  id_ex_jr <= 0;
                  id_ex_linked <= 0;
                  id_ex_mult <= 0;
	          id_ex_div <= 1;
                  id_ex_load <= 0;
                  id_ex_store <= 0;
                  id_ex_size <= 0;
                  id_ex_store_value <= 0;
                  id_ex_destreg <= 0;
                  id_ex_desthi <= 1;
                  id_ex_destlo <= 1;
                  id_ex_destsyscon <= 0;
                  div_req_i <= !div_req_i;  // Toggle the ABP request
                end
              `FUNCTION_ADD:
                begin
                  $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as ADD r%d, r%d, r%d", if_id_addr, if_id_opcode, if_id_rd, if_id_rs, if_id_rt);
                  id_ex_alu_a <= GPR[if_id_rs];
                  id_ex_alu_b <= GPR[if_id_rt];
                  id_ex_alu_func <= `ALU_OP_ADD;
                  id_ex_alu_signed <= 1;
                  id_ex_branch <= 0;
                  id_ex_jump <= 0;
                  id_ex_jr <= 0;
                  id_ex_linked <= 0;
                  id_ex_mult <= 0;
	          id_ex_div <= 0;
                  id_ex_load <= 0;
                  id_ex_store <= 0;
                  id_ex_size <= 0;
                  id_ex_store_value <= 0;
                  id_ex_destreg <= if_id_rd;
                  id_ex_desthi <= 0;
                  id_ex_destlo <= 0;
                  id_ex_destsyscon <= 0;
                end
              `FUNCTION_ADDU:
                begin
                  $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as ADDU r%d, r%d, r%d", if_id_addr, if_id_opcode, if_id_rd, if_id_rs, if_id_rt);
                  id_ex_alu_a <= GPR[if_id_rs];
                  id_ex_alu_b <= GPR[if_id_rt];
                  id_ex_alu_func <= `ALU_OP_ADD;
                  id_ex_alu_signed <= 0;
                  id_ex_branch <= 0;
                  id_ex_jump <= 0;
                  id_ex_jr <= 0;
                  id_ex_linked <= 0;
                  id_ex_mult <= 0;
	          id_ex_div <= 0;
                  id_ex_load <= 0;
                  id_ex_store <= 0;
                  id_ex_size <= 0;
                  id_ex_store_value <= 0;
                  id_ex_destreg <= if_id_rd;
                  id_ex_desthi <= 0;
                  id_ex_destlo <= 0;
                  id_ex_destsyscon <= 0;
                end
              `FUNCTION_SUB:
                begin
                  $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as SUB r%d, r%d, r%d", if_id_addr, if_id_opcode, if_id_rd, if_id_rs, if_id_rt);
                  id_ex_alu_a <= GPR[if_id_rs];
                  id_ex_alu_b <= GPR[if_id_rt];
                  id_ex_alu_func <= `ALU_OP_SUB;
                  id_ex_alu_signed <= 1;
                  id_ex_branch <= 0;
                  id_ex_jump <= 0;
                  id_ex_jr <= 0;
                  id_ex_linked <= 0;
                  id_ex_mult <= 0;
	          id_ex_div <= 0;
                  id_ex_load <= 0;
                  id_ex_store <= 0;
                  id_ex_size <= 0;
                  id_ex_store_value <= 0;
                  id_ex_destreg <= if_id_rd;
                  id_ex_desthi <= 0;
                  id_ex_destlo <= 0;
                  id_ex_destsyscon <= 0;
                end
              `FUNCTION_SUBU:
                begin
                  $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as SUBU r%d, r%d, r%d", if_id_addr, if_id_opcode, if_id_rd, if_id_rs, if_id_rt);
                  id_ex_alu_a <= GPR[if_id_rs];
                  id_ex_alu_b <= GPR[if_id_rt];
                  id_ex_alu_func <= `ALU_OP_SUB;
                  id_ex_alu_signed <= 0;
                  id_ex_branch <= 0;
                  id_ex_jump <= 0;
                  id_ex_jr <= 0;
                  id_ex_linked <= 0;
                  id_ex_mult <= 0;
	          id_ex_div <= 0;
                  id_ex_load <= 0;
                  id_ex_store <= 0;
                  id_ex_size <= 0;
                  id_ex_store_value <= 0;
                  id_ex_destreg <= if_id_rd;
                  id_ex_desthi <= 0;
                  id_ex_destlo <= 0;
                  id_ex_destsyscon <= 0;
                end
              `FUNCTION_AND:
                begin
                  $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as AND r%d, r%d, r%d", if_id_addr, if_id_opcode, if_id_rd, if_id_rs, if_id_rt);
                  id_ex_alu_a <= GPR[if_id_rs];
                  id_ex_alu_b <= GPR[if_id_rt];
                  id_ex_alu_func <= `ALU_OP_AND;
                  id_ex_alu_signed <= 0;
                  id_ex_branch <= 0;
                  id_ex_jump <= 0;
                  id_ex_jr <= 0;
                  id_ex_linked <= 0;
                  id_ex_mult <= 0;
	          id_ex_div <= 0;
                  id_ex_load <= 0;
                  id_ex_store <= 0;
                  id_ex_size <= 0;
                  id_ex_store_value <= 0;
                  id_ex_destreg <= if_id_rd;
                  id_ex_desthi <= 0;
                  id_ex_destlo <= 0;
                  id_ex_destsyscon <= 0;
                end
              `FUNCTION_OR:
                begin
                  $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as OR r%d, r%d, r%d", if_id_addr, if_id_opcode, if_id_rd, if_id_rs, if_id_rt);
                  id_ex_alu_a <= GPR[if_id_rs];
                  id_ex_alu_b <= GPR[if_id_rt];
                  id_ex_alu_func <= `ALU_OP_OR;
                  id_ex_alu_signed <= 0;
                  id_ex_branch <= 0;
                  id_ex_jump <= 0;
                  id_ex_jr <= 0;
                  id_ex_linked <= 0;
                  id_ex_mult <= 0;
	          id_ex_div <= 0;
                  id_ex_load <= 0;
                  id_ex_store <= 0;
                  id_ex_size <= 0;
                  id_ex_store_value <= 0;
                  id_ex_destreg <= if_id_rd;
                  id_ex_desthi <= 0;
                  id_ex_destlo <= 0;
                  id_ex_destsyscon <= 0;
                end
              `FUNCTION_XOR:
                begin
                  $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as XOR r%d, r%d, r%d", if_id_addr, if_id_opcode, if_id_rd, if_id_rs, if_id_rt);
                  id_ex_alu_a <= GPR[if_id_rs];
                  id_ex_alu_b <= GPR[if_id_rt];
                  id_ex_alu_func <= `ALU_OP_XOR;
                  id_ex_alu_signed <= 0;
                  id_ex_branch <= 0;
                  id_ex_jump <= 0;
                  id_ex_jr <= 0;
                  id_ex_linked <= 0;
                  id_ex_mult <= 0;
	          id_ex_div <= 0;
                  id_ex_load <= 0;
                  id_ex_store <= 0;
                  id_ex_size <= 0;
                  id_ex_store_value <= 0;
                  id_ex_destreg <= if_id_rd;
                  id_ex_desthi <= 0;
                  id_ex_destlo <= 0;
                  id_ex_destsyscon <= 0;
                end
              `FUNCTION_NOR:
                begin
                  $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as NOR r%d, r%d, r%d", if_id_addr, if_id_opcode, if_id_rd, if_id_rs, if_id_rt);
                  id_ex_alu_a <= GPR[if_id_rs];
                  id_ex_alu_b <= GPR[if_id_rt];
                  id_ex_alu_func <= `ALU_OP_NOR;
                  id_ex_alu_signed <= 0;
                  id_ex_branch <= 0;
                  id_ex_jump <= 0;
                  id_ex_jr <= 0;
                  id_ex_linked <= 0;
                  id_ex_mult <= 0;
	          id_ex_div <= 0;
                  id_ex_load <= 0;
                  id_ex_store <= 0;
                  id_ex_size <= 0;
                  id_ex_store_value <= 0;
                  id_ex_destreg <= if_id_rd;
                  id_ex_desthi <= 0;
                  id_ex_destlo <= 0;
                  id_ex_destsyscon <= 0;
                end
              `FUNCTION_SLT:
                begin
                  $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as SLT r%d, r%d, r%d", if_id_addr, if_id_opcode, if_id_rd, if_id_rs, if_id_rt);
                  id_ex_alu_a <= GPR[if_id_rs];
                  id_ex_alu_b <= GPR[if_id_rt];
                  id_ex_alu_func <= `ALU_OP_SLT;
                  id_ex_alu_signed <= 1;
                  id_ex_branch <= 0;
                  id_ex_jump <= 0;
                  id_ex_jr <= 0;
                  id_ex_linked <= 0;
                  id_ex_mult <= 0;
	          id_ex_div <= 0;
                  id_ex_load <= 0;
                  id_ex_store <= 0;
                  id_ex_size <= 0;
                  id_ex_store_value <= 0;
                  id_ex_destreg <= if_id_rd;
                  id_ex_desthi <= 0;
                  id_ex_destlo <= 0;
                  id_ex_destsyscon <= 0;
                end
              `FUNCTION_SLTU:
                begin
                  $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as SLTU r%d, r%d, r%d", if_id_addr, if_id_opcode, if_id_rd, if_id_rs, if_id_rt);
                  id_ex_alu_a <= GPR[if_id_rs];
                  id_ex_alu_b <= GPR[if_id_rt];
                  id_ex_alu_func <= `ALU_OP_SLT;
                  id_ex_alu_signed <= 0;
                  id_ex_branch <= 0;
                  id_ex_jump <= 0;
                  id_ex_jr <= 0;
                  id_ex_linked <= 0;
                  id_ex_mult <= 0;
	          id_ex_div <= 0;
                  id_ex_load <= 0;
                  id_ex_store <= 0;
                  id_ex_size <= 0;
                  id_ex_store_value <= 0;
                  id_ex_destreg <= if_id_rd;
                  id_ex_desthi <= 0;
                  id_ex_destlo <= 0;
                  id_ex_destsyscon <= 0;
                end
            endcase
          `OPCODE_BCOND:
            case(if_id_rt)
              `BCOND_BLTZ:
                begin
                  $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as BLTZ r%d, %h", if_id_addr, if_id_opcode, if_id_rs, if_id_imm_signext);
                  id_ex_alu_a <= GPR[if_id_rs];
                  id_ex_alu_b <= 0;
                  id_ex_alu_func <= `ALU_OP_SLT;
                  id_ex_alu_signed <= 1;
                  id_ex_branch <= 1;
                  id_ex_jump <= 0;
                  id_ex_jr <= 0;
                  id_ex_linked <= 0;
                  id_ex_mult <= 0;
	          id_ex_div <= 0;
                  id_ex_load <= 0;
                  id_ex_store <= 0;
                  id_ex_size <= 0;
                  id_ex_store_value <= 0;
                  id_ex_destreg <= if_id_rd;
                  id_ex_desthi <= 0;
                  id_ex_destlo <= 0;
                  id_ex_destsyscon <= 0;
                end
              `BCOND_BGEZ:
                begin
                  $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as BGEZ r%d, %h", if_id_addr, if_id_opcode, if_id_rs, if_id_imm_signext);
                  id_ex_alu_a <= GPR[if_id_rs];
                  id_ex_alu_b <= 0;
                  id_ex_alu_func <= `ALU_OP_SGE;
                  id_ex_alu_signed <= 1;
                  id_ex_branch <= 1;
                  id_ex_jump <= 0;
                  id_ex_jr <= 0;
                  id_ex_linked <= 0;
                  id_ex_mult <= 0;
	          id_ex_div <= 0;
                  id_ex_load <= 0;
                  id_ex_store <= 0;
                  id_ex_size <= 0;
                  id_ex_store_value <= 0;
                  id_ex_destreg <= if_id_rd;
                  id_ex_desthi <= 0;
                  id_ex_destlo <= 0;
                  id_ex_destsyscon <= 0;
                end
              `BCOND_BLTZAL:
                begin
                  $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as BLTZAL r%d, %h", if_id_addr, if_id_opcode, if_id_rs, if_id_imm_signext);
                  id_ex_alu_a <= GPR[if_id_rs];
                  id_ex_alu_b <= 0;
                  id_ex_alu_func <= `ALU_OP_SLT;
                  id_ex_alu_signed <= 1;
                  id_ex_branch <= 1;
                  id_ex_jump <= 0;
                  id_ex_jr <= 0;
                  id_ex_linked <= 1;
                  id_ex_mult <= 0;
	          id_ex_div <= 0;
                  id_ex_load <= 0;
                  id_ex_store <= 0;
                  id_ex_size <= 0;
                  id_ex_store_value <= 0;
                  id_ex_destreg <= 31;
                  id_ex_desthi <= 0;
                  id_ex_destlo <= 0;
                  id_ex_destsyscon <= 0;
                end
              `BCOND_BGEZAL:
                begin
                  $display("INFO: CPU(%m)-ID: Decoded instruction @ADDR=%X w/OPCODE=%X as BGEZAL r%d, %h", if_id_addr, if_id_opcode, if_id_rs, if_id_imm_signext);
                  id_ex_alu_a <= GPR[if_id_rs];
                  id_ex_alu_b <= 0;
                  id_ex_alu_func <= `ALU_OP_SGE;
                  id_ex_alu_signed <= 1;
                  id_ex_branch <= 1;
                  id_ex_jump <= 0;
                  id_ex_jr <= 0;
                  id_ex_linked <= 1;
                  id_ex_mult <= 0;
	          id_ex_div <= 0;
                  id_ex_load <= 0;
                  id_ex_store <= 0;
                  id_ex_size <= 0;
                  id_ex_store_value <= 0;
                  id_ex_destreg <= 31;
                  id_ex_desthi <= 0;
                  id_ex_destlo <= 0;
                  id_ex_destsyscon <= 0;
                end
            endcase

        endcase

      end

      /*
       * Pipeline Stage 3: Execute (EX)
       * 
       * READ/WRITE:
       * - read the ID/EX latch
       * - write the EX/MEM latch
       * 
       * DESCRIPTION:
       * This stage takes the result from the ALU and put it in the proper latch.
       * Please note that assignments to ALU inputs are done outside since they're wires.
       */

      if(ex_stall) begin

        $display("INFO: CPU(%m)-EX: Execution stalled");

      end else begin
<<<<<<< m1_cpu.v

        // If not stalled propagate values to next latches
        ex_mem_opcode      <= id_ex_opcode;
        ex_mem_addr        <= id_ex_addr;
        ex_mem_addrnext    <= id_ex_addrnext;
        ex_mem_addrjump    <= id_ex_addrjump;
        ex_mem_addrbranch  <= id_ex_addrbranch;
        ex_mem_branch      <= id_ex_branch;
        ex_mem_jump        <= id_ex_jump;
        ex_mem_jr          <= id_ex_jr;
        ex_mem_linked      <= id_ex_linked;
        ex_mem_mult        <= id_ex_mult;
        ex_mem_div         <= id_ex_div;
        ex_mem_load        <= id_ex_load;
        ex_mem_store       <= id_ex_store;
        ex_mem_destreg     <= id_ex_destreg;
        ex_mem_desthi      <= id_ex_desthi;
        ex_mem_destlo      <= id_ex_destlo;
        ex_mem_destsyscon  <= id_ex_destsyscon;

        // Choose the output from ALU, Multiplier or Divider
        if(id_ex_mult) ex_mem_aluout <= mul_product_o;
        else if(id_ex_div) ex_mem_aluout <= { div_remainder_o, div_quotient_o };
        else ex_mem_aluout <= alu_result_o;

        if(id_ex_store) begin

          $display("INFO: CPU(%m)-EX: Execution of Store instruction @ADDR=%X w/OPCODE=%X started to STORE_ADDR=%X", id_ex_addr, id_ex_opcode, alu_result_o);
          case(id_ex_size)
            `SIZE_WORD: begin
              ex_mem_store_value <= id_ex_store_value;
              ex_mem_store_sel <= 4'b1111;
            end
            `SIZE_HALF: begin
              if(alu_result_o[1]==0) begin
                ex_mem_store_value <= {{16'b0},id_ex_store_value[15:0]};
                ex_mem_store_sel <= 4'b0011;
              end else begin
                ex_mem_store_value <= {id_ex_store_value[15:0],{16'b0}};
                ex_mem_store_sel <= 4'b1100;
              end
            end
            `SIZE_BYTE: begin
              case(alu_result_o[1:0])
                2'b00: begin
                  ex_mem_store_value <= {{24'b0},id_ex_store_value[7:0]};
                  ex_mem_store_sel <= 4'b0001;
                end
                2'b01: begin
                  ex_mem_store_value <= {{16'b0},id_ex_store_value[7:0],{8'b0}};
                  ex_mem_store_sel <= 4'b0010;
                end
                2'b10: begin
                  ex_mem_store_value <= {{8'b0},id_ex_store_value[7:0],{16'b0}};
                  ex_mem_store_sel <= 4'b0100;
                end
                2'b11: begin
                  ex_mem_store_value <= {id_ex_store_value[7:0],{24'b0}};
                  ex_mem_store_sel <= 4'b1000;
                end
              endcase
            end
          endcase

        end else

          // Not a store
          $display("INFO: CPU(%m)-EX: Execution of instruction @ADDR=%X w/OPCODE=%X gave ALU result %X", id_ex_addr, id_ex_opcode, alu_result_o);
// Dunno why but these two cleaning instructions were always executed and prevented stores to work properly
//          ex_mem_store_value <= 0;
//          ex_mem_store_sel <= 4'b0000;

        end
=======
        ex_mem_pc          <= id_ex_pc;
        ex_mem_pcnext      <= id_ex_pcnext;
        ex_mem_pcjump      <= id_ex_pcjump;
        ex_mem_pcbranch    <= id_ex_pcbranch;
        ex_mem_alu_out     <= alu_result_o;
        ex_mem_jump        <= id_ex_jump;
        ex_mem_branch      <= id_ex_branch;
        ex_mem_linked      <= id_ex_linked;
        ex_mem_load        <= id_ex_load;
        ex_mem_store       <= id_ex_store;
        ex_mem_store_value <= id_ex_store_value;
        ex_mem_destreg     <= id_ex_destreg;
        ex_mem_desthi      <= id_ex_desthi;
        ex_mem_destlo      <= id_ex_destlo;
>>>>>>> 1.9
      end

      /*
       * Pipeline Stage 4: Memory access (MEM)
       * 
       * READ/WRITE:
       * - read the EX/MEM latch
       * - read or write memory
       * - write the MEM/WB latch
       * 
       * DESCRIPTION:
       * This stage perform accesses to memory to read/write the data during
       * the load/store operations.
       */

      if(mem_stall) begin

        $display("INFO: CPU(%m)-MEM: Memory stalled");

      end else begin

        mem_wb_opcode     <= ex_mem_opcode;
        mem_wb_addr       <= ex_mem_addr;
        mem_wb_addrnext   <= ex_mem_addrnext;
        mem_wb_destreg    <= ex_mem_destreg;
        mem_wb_desthi     <= ex_mem_desthi;
        mem_wb_destlo     <= ex_mem_destlo;
        mem_wb_destsyscon <= ex_mem_destsyscon;

        if(ex_mem_load) begin

          $display("INFO: CPU(%m)-MEM: LOADing value %X", dmem_data_i);
          mem_wb_value[63:32] <= 32'b0;
          mem_wb_value[31:0] <= dmem_data_i;

        end else begin

          $display("INFO: CPU(%m)-MEM: Propagating value %X", ex_mem_aluout);
          mem_wb_value <= ex_mem_aluout;

        end

      end

      /*
       * Pipeline Stage 5: Write Back (WB)
       * 
       * READ/WRITE:
       * - read the MEM/WB latch
       * - write the register file
       * 
       * DESCRIPTION:
       * This stage writes back the result into the proper register (GPR, HI, LO).
       */

      if(wb_stall) begin

        $display("INFO: CPU(%m)-WB: Write-Back stalled");

      end else begin

        // GPRs
        if(mem_wb_destreg!=0) begin
          $display("INFO: CPU(%m)-WB: Writing Back GPR[%d]=%X", mem_wb_destreg, mem_wb_value[31:0]);
          GPR[mem_wb_destreg] <= mem_wb_value[31:0];
        end

        // HI
        if(mem_wb_desthi) begin
          $display("INFO: CPU(%m)-WB: Writing Back HI=%X", mem_wb_value[63:32]);
          HI <= mem_wb_value[63:32];
        end

        // LO
        if(mem_wb_destlo) begin
          $display("INFO: CPU(%m)-WB: Writing Back LO=%X", mem_wb_value[31:0]);
          LO <= mem_wb_value[31:0];
        end

        // SysCon
        if(mem_wb_destsyscon!=0) begin
          $display("INFO: CPU(%m)-WB: Writing Back SysCon[%d]=%X", mem_wb_destsyscon, mem_wb_value[31:0]);
          GPR[mem_wb_destsyscon] <= mem_wb_value[31:0];
        end

        // Idle
        if(mem_wb_destreg==0 & mem_wb_desthi==0 & mem_wb_destlo==0 & mem_wb_destsyscon==0)
          $display("INFO: CPU(%m)-WB: Write-Back has nothing to do");

      end

      // Display register file at each raising edge
      $display("INFO: CPU(%m)-Regs: R00=%X R01=%X R02=%X R03=%X R04=%X R05=%X R06=%X R07=%X",
        GPR[0], GPR[1], GPR[2], GPR[3], GPR[4], GPR[5], GPR[6], GPR[7]);
      $display("INFO: CPU(%m)-Regs: R08=%X R09=%X R10=%X R11=%X R12=%X R13=%X R14=%X R15=%X",
        GPR[8], GPR[9], GPR[10], GPR[11], GPR[12], GPR[13], GPR[14], GPR[15]);
      $display("INFO: CPU(%m)-Regs: R16=%X R17=%X R18=%X R19=%X R20=%X R21=%X R22=%X R23=%X",
        GPR[16], GPR[17], GPR[18], GPR[19], GPR[20], GPR[21], GPR[22], GPR[23]);
      $display("INFO: CPU(%m)-Regs: R24=%X R25=%X R26=%X R27=%X R28=%X R29=%X R30=%X R31=%X",
        GPR[24], GPR[25], GPR[26], GPR[27], GPR[28], GPR[29], GPR[30], GPR[31]);
      $display("INFO: CPU(%m)-Regs: PC=%X HI=%X LO=%X Status=%X Cause=%X EPC=%X",
        PC, HI, LO, Status, Cause, EPC);

  end

endmodule

