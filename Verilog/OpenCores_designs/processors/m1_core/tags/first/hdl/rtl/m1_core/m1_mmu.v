/*
 * Simply RISC M1 Memory Management Unit
 * 
 * It will include the following components:
 * - Instruction Cache
 * - Data Cache
 * - TLB
 * but for now it's just a fake MMU.
 */

module m1_mmu (
    sys_clock_i, sys_reset_i,
    imem_addr_i, imem_data_o, imem_read_i, imem_busy_o,
    dmem_addr_i, dmem_data_o, dmem_data_i, dmem_read_i, dmem_write_i, dmem_busy_o ,dmem_sel_i
  );

  // System
  input sys_clock_i, sys_reset_i;
   
  // Instruction Memory
  input[31:0] imem_addr_i;
  output[31:0] imem_data_o;
  input imem_read_i;
  output imem_busy_o;

  // Data Memory
  input[31:0] dmem_addr_i;
  output[31:0] dmem_data_o;
  input[31:0] dmem_data_i;
  input dmem_read_i;
  input dmem_write_i;
  output dmem_busy_o;

  // Fake Instruction and Data Memories
  reg[31:0] imem_data[0:1023];   // 4KB I$
  reg[31:0] dmem_data[0:255];    // 1KB D$
 

  //Selector
  input[3:0] dmem_sel_i;
  reg[31:0] data_temp;                    

  // Initialize fake memories
  integer i;
  initial begin
     
    // I$ is initialized from file
    $readmemh("code.txt", imem_data);

    // D$ defaults to zeroes
    for(i=0; i<256; i=i+1) dmem_data[i] = 0;
     
  end

  assign imem_busy_o = 0;
  assign dmem_busy_o = 0;


  assign imem_data_o = imem_data[{2'b00, imem_addr_i[31:2]}];
  assign dmem_data_o = dmem_data[{2'b00, dmem_addr_i[31:2]}];


  always @(dmem_write_i or dmem_read_i) begin          

    if(dmem_write_i) begin

       if(dmem_sel_i[0]) begin
                         data_temp = dmem_data[{2'b00, dmem_addr_i[31:2]}];
                         data_temp[7:0] = dmem_data_i[7:0];
                         dmem_data[{2'b00, dmem_addr_i[31:2]}] = data_temp;
       end 
       if(dmem_sel_i[1]) begin
                         data_temp = dmem_data[{2'b00, dmem_addr_i[31:2]}];
                         data_temp[15:8] = dmem_data_i[15:8];
                         dmem_data[{2'b00, dmem_addr_i[31:2]}] = data_temp;
       end 
       if(dmem_sel_i[2]) begin
                         data_temp = dmem_data[{2'b00, dmem_addr_i[31:2]}];
                         data_temp[24:16] = dmem_data_i[24:16];
                         dmem_data[{2'b00, dmem_addr_i[31:2]}] = data_temp;
       end 
       if(dmem_sel_i[3]) begin
                         data_temp = dmem_data[{2'b00, dmem_addr_i[31:2]}];
                         data_temp[31:24] = dmem_data_i[31:24];
                         dmem_data[{2'b00, dmem_addr_i[31:2]}] = data_temp;
       end
       $display("INFO: MEMH(%m): WRITE_ADDR=%X, WRITE_DATA=%X", dmem_addr_i, dmem_data_i);
    end             


    if(dmem_read_i) begin
      $display("INFO: MEMH(%m): READ_ADDR=%X, READ_DATA=%X", dmem_addr_i, dmem_data[{2'b00, dmem_addr_i[31:2]}]);  
    end
  end
  
   
endmodule

