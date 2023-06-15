`define MEM_TYPE      Register file
`define SYN_RESET     1'b1
`define FIFO_MODE     1'b0
`define RD_WIDTH      54
`define RD_DEPTH      16
`define WR_WIDTH      54
`define WR_DEPTH      16
`define RST_DOUT      0

	   

module sr16_fifo_regfile54 (          

                      output [`RD_WIDTH-1:0] RD_DATA,  
                      output              FIFO_FULL,
                      output              FIF_EMPTY ,
                      output              FIFO_ALMOST_EMPTY ,						
                      output              FIFO_ALMOST_FULL ,						                 
                      
                      input  [`WR_WIDTH-1:0] WR_DATA ,
                      input               WR_EN ,
                      input               RD_EN ,
                      input               RD_CLK ,
                      input               WR_CLK ,     
                      input               RD_RST,
                      input               WR_RST,
                      input [`WR_DEPTH-1:0]  ALMOST_FULL_THRESHOLD ,
                      input [`RD_DEPTH-1:0]  ALMOST_EMPTY_THRESHOLD    

);
           
reg [4:0] wr_pntr = 5'h00, rd_pntr = 5'h00;


assign wr_pntr_wire = wr_pntr;
assign rd_pntr_wire =  rd_pntr;
 
always @(posedge WR_CLK ) 
begin
  // if (rd_pntr <= 0100)
      rd_pntr <= wr_pntr + 4'hf;   
  // else 
  //    rd_pntr <= 4'h0;   
end

always @(posedge RD_CLK) 
begin
 // if (wr_pntr <= 0100)
      wr_pntr <= wr_pntr + 1'b1;   
 //  else 
 //     wr_pntr <= 4'h0;   
end  


sr16_fifo_regfile54_reg_mem u_sr16_fifo_regfile54_reg_mem(
       .addr1(wr_ptr),
       .addr0(rd_ptr),
       .din(WR_DATA),
       .clk(WR_CLK),
       .en(1'b1),
       .dout(RD_DATA)
     );


   
   /* M2000 to provide Glue Logic  */        
          
          






endmodule

