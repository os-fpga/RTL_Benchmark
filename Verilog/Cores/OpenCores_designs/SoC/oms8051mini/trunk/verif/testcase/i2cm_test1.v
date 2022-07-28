/**********************************************************
             I2C Master Test
**********************************************************/
task i2cm_test1;
reg [7:0] rdata;
begin
 $display("############################################");
 $display("   Testing I2CM Read/Write Access           ");
 $display("############################################");
  
  @(posedge  app_clk);
  $display("---------- Initialize I2C Master ----------"); 
  //Wrire Prescale registers
   tb_top.cpu_byte_write(`ADDR_SPACE_I2CM,8'h0,8'hC7);  
   tb_top.cpu_byte_write(`ADDR_SPACE_I2CM,8'h1,8'h00);  
  // Core Enable
   tb_top.cpu_byte_write(`ADDR_SPACE_I2CM,8'h2,8'h80);  
  
  // Writing Data

  $display("---------- Writing Data ----------"); 
  tb_top.cpu_byte_write(`ADDR_SPACE_I2CM,8'h3,8'h20); // Slave Addr + WR  
  tb_top.cpu_byte_write(`ADDR_SPACE_I2CM,8'h4,8'h90);  
  rdata [1] = 1'b1;
  while(rdata[1]==1)
    tb_top.cpu_byte_read(`ADDR_SPACE_I2CM,8'h4,rdata);  
   
  tb_top.cpu_byte_write(`ADDR_SPACE_I2CM,8'h3,8'h66);  
  tb_top.cpu_byte_write(`ADDR_SPACE_I2CM,8'h4,8'h10);  

  rdata [1] = 1'b1;
  while(rdata[1]==1)
    tb_top.cpu_byte_read(`ADDR_SPACE_I2CM,8'h4,rdata);  
 
 /* Byte1: 12 */ 
  tb_top.cpu_byte_write(`ADDR_SPACE_I2CM,8'h3,8'h12);  
  tb_top.cpu_byte_write(`ADDR_SPACE_I2CM,8'h4,8'h10); // No Stop + Write  

  rdata [1] = 1'b1;
  while(rdata[1]==1)
    tb_top.cpu_byte_read(`ADDR_SPACE_I2CM,8'h4,rdata);  
 
 /* Byte1: 34 */ 
  tb_top.cpu_byte_write(`ADDR_SPACE_I2CM,8'h3,8'h34);  
  tb_top.cpu_byte_write(`ADDR_SPACE_I2CM,8'h4,8'h10); // No Stop + Write 

  rdata [1] = 1'b1;
  while(rdata[1]==1)
    tb_top.cpu_byte_read(`ADDR_SPACE_I2CM,8'h4,rdata);  

 /* Byte1: 56 */ 
  tb_top.cpu_byte_write(`ADDR_SPACE_I2CM,8'h3,8'h56);  
  tb_top.cpu_byte_write(`ADDR_SPACE_I2CM,8'h4,8'h10); // No Stop + Write 

  rdata [1] = 1'b1;
  while(rdata[1]==1)
    tb_top.cpu_byte_read(`ADDR_SPACE_I2CM,8'h4,rdata);  

 /* Byte1: 78 */ 
  tb_top.cpu_byte_write(`ADDR_SPACE_I2CM,8'h3,8'h78);  
  tb_top.cpu_byte_write(`ADDR_SPACE_I2CM,8'h4,8'h50); // Stop + Write 

  rdata [1] = 1'b1;
  while(rdata[1]==1)
    tb_top.cpu_byte_read(`ADDR_SPACE_I2CM,8'h4,rdata);  

  //Reading Data
  
  //Wrire Address
  $display("---------- Writing Data ----------"); 
  tb_top.cpu_byte_write(`ADDR_SPACE_I2CM,8'h3,8'h20);  
  tb_top.cpu_byte_write(`ADDR_SPACE_I2CM,8'h4,8'h90);  
  rdata [1] = 1'b1;
  while(rdata[1]==1)
    tb_top.cpu_byte_read(`ADDR_SPACE_I2CM,8'h4,rdata);  
   
  tb_top.cpu_byte_write(`ADDR_SPACE_I2CM,8'h3,8'h66);  
  tb_top.cpu_byte_write(`ADDR_SPACE_I2CM,8'h4,8'h50);  

  rdata [1] = 1'b1;
  while(rdata[1]==1)
    tb_top.cpu_byte_read(`ADDR_SPACE_I2CM,8'h4,rdata);  

  //Generate Read
  $display("---------- Writing Data ----------"); 
  tb_top.cpu_byte_write(`ADDR_SPACE_I2CM,8'h3,8'h21); // Slave Addr + RD  
  tb_top.cpu_byte_write(`ADDR_SPACE_I2CM,8'h4,8'h90);  
  rdata [1] = 1'b1;
  while(rdata[1]==1)
    tb_top.cpu_byte_read(`ADDR_SPACE_I2CM,8'h4,rdata);  

  /* BYTE-1 : 0x12  */ 
  tb_top.cpu_byte_write(`ADDR_SPACE_I2CM,8'h4,8'h20);  // RD + ACK

  rdata [1] = 1'b1;
  while(rdata[1]==1)
    tb_top.cpu_byte_read(`ADDR_SPACE_I2CM,8'h4,rdata);  

  //Compare received data
  tb_top.cpu_byte_read_cmp(`ADDR_SPACE_I2CM,8'h3,8'h12);  
   
  /* BYTE-2 : 0x34  */ 
  tb_top.cpu_byte_write(`ADDR_SPACE_I2CM,8'h4,8'h20);  // RD + ACK

  rdata [1] = 1'b1;
  while(rdata[1]==1)
    tb_top.cpu_byte_read(`ADDR_SPACE_I2CM,8'h4,rdata);  

  //Compare received data
  tb_top.cpu_byte_read_cmp(`ADDR_SPACE_I2CM,8'h3,8'h34);  

  /* BYTE-3 : 0x56  */ 
  tb_top.cpu_byte_write(`ADDR_SPACE_I2CM,8'h4,8'h20);  // RD + ACK

  rdata [1] = 1'b1;
  while(rdata[1]==1)
    tb_top.cpu_byte_read(`ADDR_SPACE_I2CM,8'h4,rdata);  

  //Compare received data
  tb_top.cpu_byte_read_cmp(`ADDR_SPACE_I2CM,8'h3,8'h56);  

  /* BYTE-4 : 0x78  */ 
  tb_top.cpu_byte_write(`ADDR_SPACE_I2CM,8'h4,8'h68);  // STOP + RD + NACK 

  rdata [1] = 1'b1;
  while(rdata[1]==1)
    tb_top.cpu_byte_read(`ADDR_SPACE_I2CM,8'h4,rdata);  

  //Compare received data
  tb_top.cpu_byte_read_cmp(`ADDR_SPACE_I2CM,8'h3,8'h78);  

  repeat(100)@(posedge app_clk);
end
endtask //}

