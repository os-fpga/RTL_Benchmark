module spi_if (/*AUTOARG*/
   // Outputs
   miso, rf_addr, rf_din, wre,
   // Inputs
   csn, sclk, mosi, rf_dout
   ) ;
   
   input csn;
   input sclk;
   input mosi;
   input [7:0] rf_dout;   
   output miso;
   output [7:0] rf_addr;
   output [7:0] rf_din;
   output 	wre;
   
   parameter read_cmd    = 8'hc1;
   parameter read_burst  = 8'hc5;   
   parameter write_cmd   = 8'hc2;
   parameter write_burst = 8'hca;

   parameter cmd_st   = 2'b00;
   parameter addr_st  = 2'b01;
   parameter data_st  = 2'b11;   
   
   reg [7:0] 	mosi_reg;
   reg [7:0] 	addr_reg;
   reg [7:0] 	data_reg;   
   reg 		wre;
   reg [2:0] 	bit_count;
   reg [1:0] 	state;
   reg [7:0] 	miso_reg;
   

   assign miso = miso_reg[7];
   assign rf_din = data_reg;
   assign rf_addr = addr_reg;
   
   
   always @(posedge sclk or posedge csn) begin
      if (csn == 1'b1) begin
	 mosi_reg   <= 8'b0;
	 data_reg   <= 8'b0;
	 addr_reg   <= 8'b0;
	 state      <= cmd_st;	
	 bit_count  <= 3'd0; 
	 wre        <= 1'b0;	 
      end
      else begin
	 
	 bit_count <= bit_count + 1'b1;
	 
	 case (state) 
	   cmd_st: begin
	      if (bit_count==7) begin
		 state <= addr_st;
	      end
	      mosi_reg <= {mosi_reg[6:0], mosi};	      
	   end
	   addr_st: begin
	      if (bit_count==7) begin
		 state <= data_st;	 
	      end
	      addr_reg <= {addr_reg[6:0], mosi};	      
	   end
	   data_st: begin
	      data_reg <= {data_reg[6:0], mosi};
	      case (mosi_reg)
		write_cmd: begin
		   if (bit_count==7) begin
		      wre <= 1'b1;
		   end
		end		

		write_burst: begin
		   if (bit_count==7) begin
		      wre <= 1'b1;
		   end
		   else begin
		      wre <= 1'b0;		      
		   end
		   addr_reg <= addr_reg + wre;		   
		end

		read_burst: begin
		   if (bit_count==7) begin
		      addr_reg <= addr_reg + 1'b1;		      
		   end	   
		end
	      endcase // case (mosi_reg)	      
	   end // case: data_st	   
	 endcase // case (state)	 
      end         
   end
   
   always @(negedge sclk or posedge csn) begin
      if (csn==1'b1) begin
	 miso_reg <= 8'b0;	 
      end
      else begin
	 if ((mosi_reg==read_burst || mosi_reg == read_cmd) && state==data_st) begin
	    if (bit_count==0) begin
	       miso_reg <= rf_dout;
	    end
	    else begin
	       miso_reg <= {miso_reg[6:0], 1'b0};	       
	    end
	 end
      end
   end

   
endmodule  
