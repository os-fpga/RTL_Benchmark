
initial
begin
   reg_cs  = 0;
   reg_be  = 4'h0;
   reg_id  = 0;
end

task cpu_read;
  input  [3:0]  block_id; 
  input  [15:0] address;
  output [31:0] read_data;
  begin 
      @(posedge app_clk);
      reg_id  = block_id;

      // Byte-0
      reg_cs = 1;
      reg_wr = 0;
      reg_be = 1'h1;
      reg_addr = address;
      @(posedge reg_ack);
       #1 read_data[7:0] = reg_rdata[7:0];
      @(posedge app_clk);
       reg_cs  = 0;

      // Byte-1
      reg_cs = 1;
      reg_wr = 0;
      reg_be = 1'h1;
      reg_addr = address+1;
      @(posedge reg_ack);
       #1 read_data[15:8]= reg_rdata[7:0];
      @(posedge app_clk);
       reg_cs  = 0;

      // Byte-2
      reg_cs = 1;
      reg_wr = 0;
      reg_be = 1'h1;
      reg_addr = address+2;
      @(posedge reg_ack);
       #1 read_data[23:16]= reg_rdata[7:0];
      @(posedge app_clk);
       reg_cs  = 0;

      // Byte-3
      reg_cs = 1;
      reg_wr = 0;
      reg_be = 1'h1;
      reg_addr = address+3;
      @(posedge reg_ack);
       #1 read_data[31:24] = reg_rdata[7:0];
      @(posedge app_clk);
       reg_cs  = 0;
      //$display ("Config-Read: Id: %h Addr = %h, Data = %h", block_id,address, read_data);
  end
endtask

task cpu_write;
  input  [3:0] block_id; // 0/1/2 --> ram/spi/uart 
  input  [15:0] address;
  input  [31:0] write_data;
  begin 
      $display ("Config-Write: Id: %h Addr = %h, Cfg. Data = %h", block_id,address, write_data);
      // Byte-0
      @(posedge app_clk);
      reg_id  = block_id;
      reg_cs = 1;
      reg_wr = 1;
      reg_be = 1'h1;
      reg_addr = address;
      reg_wdata = write_data[7:0];
      @(posedge reg_ack);
      @(posedge app_clk);
      reg_cs  = 0;
      reg_wr = 0;

      // Byte-1
      @(posedge app_clk);
      reg_id  = block_id;
      reg_cs = 1;
      reg_wr = 1;
      reg_be = 1'h1;
      reg_addr = address+1;
      reg_wdata = write_data[15:8];
      @(posedge reg_ack);
      @(posedge app_clk);
      reg_cs  = 0;
      reg_wr = 0;

      // Byte-2
      @(posedge app_clk);
      reg_id  = block_id;
      reg_cs = 1;
      reg_wr = 1;
      reg_be = 1'h1;
      reg_addr = address+2;
      reg_wdata = write_data[23:16];
      @(posedge reg_ack);
      @(posedge app_clk);
      reg_cs  = 0;
      reg_wr = 0;

      // Byte-2
      @(posedge app_clk);
      reg_id  = block_id;
      reg_cs = 1;
      reg_wr = 1;
      reg_be = 1'h1;
      reg_addr = address+3;
      reg_wdata = write_data[31:24];
      @(posedge reg_ack);
      @(posedge app_clk);
      reg_cs  = 0;
      reg_wr = 0;

  end
endtask

task cpu_byte_read;
  input  [3:0]  block_id; 
  input  [15:0] address;
  output [7:0] read_data;
  begin 
      @(posedge app_clk);
      reg_id  = block_id;

      // Byte-0
      reg_cs = 1;
      reg_wr = 0;
      reg_be = 1'h1;
      reg_addr = address;
      @(posedge reg_ack);
       #1 read_data[7:0] = reg_rdata[7:0];
      @(posedge app_clk);
       reg_cs  = 0;

      $display ("Config-Read: Id: %h Addr = %h, Data = %h", block_id,address, read_data);
  end
endtask

task cpu_byte_read_cmp;
  input  [3:0]  block_id; 
  input  [15:0] address;
  input [7:0]   exp_read_data;
  reg   [7:0]   read_data;
  begin 
      @(posedge app_clk);
      reg_id  = block_id;

      // Byte-0
      reg_cs = 1;
      reg_wr = 0;
      reg_be = 1'h1;
      reg_addr = address;
      @(posedge reg_ack);
       #1 read_data[7:0] = reg_rdata[7:0];
      @(posedge app_clk);
       reg_cs  = 0;

      if(read_data !== exp_read_data) begin
          $display ("ERROR: REG READ : Id: %h Addr = %h, Data = %h", block_id,address, read_data);
          `TB_GLBL.test_err;
      end else
          $display ("Config-Read: Id: %h Addr = %h, Data = %h", block_id,address, read_data);
  end
endtask
task cpu_byte_write;
  input  [3:0] block_id; // 0/1/2 --> ram/spi/uart 
  input  [15:0] address;
  input  [7:0] write_data;
  begin 
      $display ("Config-Write: Id: %h Addr = %h, Cfg. Data = %h", block_id,address, write_data);
      // Byte-0
      @(posedge app_clk);
      reg_id  = block_id;
      reg_cs = 1;
      reg_wr = 1;
      reg_be = 1'h1;
      reg_addr = address;
      reg_wdata = write_data[7:0];
      @(posedge reg_ack);
      @(posedge app_clk);
      reg_cs  = 0;
      reg_wr = 0;

  end
endtask

