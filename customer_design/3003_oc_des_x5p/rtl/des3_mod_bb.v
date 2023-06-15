/////////////////////////////////////////////////////////////////////
////                                                             ////
////  Tripple DES                                                ////
////  Tripple DES Top Level module                               ////
////                                                             ////
////  Author: Rudolf Usselmann                                   ////
////          rudi@asics.ws                                      ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2002 Rudolf Usselmann                         ////
////                    rudi@asics.ws                            ////
////                                                             ////
//// This source file may be used and distributed without        ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and that any derivative work contains ////
//// the original copyright notice and the associated disclaimer.////
////                                                             ////
////     THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     ////
//// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   ////
//// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   ////
//// FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      ////
//// OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         ////
//// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    ////
//// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   ////
//// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        ////
//// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  ////
//// LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  ////
//// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  ////
//// OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         ////
//// POSSIBILITY OF SUCH DAMAGE.                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////

module des3(desOut, desIn, key1, key2, key3, decrypt, clk)/*synthesis black_box */; 
output	[63:0]	desOut;
input	[63:0]	desIn;
input	[55:0]	key1;
input	[55:0]	key2;
input	[55:0]	key3;
input		decrypt;
input		clk;

wire	[55:0]	key_a;
wire	[55:0]	key_b;
wire	[55:0]	key_c;
wire	[63:0]	stage1_out, stage2_out;
//reg	[54:0]	key_b_r; 
//wire [54:0] key_b_r15;
//reg	[55:0]	key_c_r [33:0];
integer		i;

assign key_a = decrypt ? key3 : key1;
assign key_b = key2;
assign key_c = decrypt ? key1 : key3;   

//replace first shift register 56 wide 17 deep
reg	[55:0]	key_b_r55 [16:0];
reg [55:0] key_b_r54 [16:0];      
reg	[54:0]	key_b_r; 
wire [54:0] key_b_r15;

always @(posedge clk)
begin
	key_b_r55[0] <= #1 key_b[55];
	key_b_r54[0] <= #1 key_b[54];
end

always @(posedge clk)
	for(i=0;i<16;i=i+1)
	begin
		key_b_r55[i+1] <= #1 key_b_r55[i];  
		key_b_r54[i+1] <= #1 key_b_r54[i];
	end

reg [3:0] wr_pntr1 = 4'h00, rd_pntr1 = 4'h00;


assign wr_pntr_wire1 = wr_pntr1;
assign rd_pntr_wire1 =  rd_pntr1;
 
always @(posedge clk ) 
begin
      rd_pntr1 <= wr_pntr1 + 4'hf;  //16-5=11    
end

always @(posedge clk) 
begin
      wr_pntr1 <= wr_pntr1 + 1'b1;      
end  
		
sr16_fifo_regfile54_reg_mem sr16_1(
       .addr1(wr_ptr1),
       .addr0(rd_ptr1),
       .din(key_b[54:0]),
       .clk(clk),
       .en(1'b1),
       .dout(key_b_r15)
     );		

always @(posedge clk)
	key_b_r <= #1 key_b_r15;		
//end replace first shift register

//replace second shift register 56 wide 33 deep		
reg	[55:0]	key_c_r55 [33:0];
reg [55:0] key_c_r54 [33:0];      
reg	[53:0]	key_c_r; 
wire [53:0] key_c_r15;

always @(posedge clk)
begin
	key_c_r55[0] <= #1 key_c[55];
	key_c_r54[0] <= #1 key_c[54];
	end

always @(posedge clk)
	for(i=0;i<33;i=i+1)
	begin
		key_c_r55[i+1] <= #1 key_c_r55[i];  
    key_c_r54[i+1] <= #1 key_c_r54[i];
  end
    
reg [4:0] wr_pntr2 = 5'h00, rd_pntr2 = 5'h00;


assign wr_pntr_wire2 = wr_pntr2;
assign rd_pntr_wire2 =  rd_pntr2;
 
always @(posedge clk ) 
begin
      rd_pntr2 <= wr_pntr2 + 5'h1f;  //16-5=11    
end

always @(posedge clk) 
begin
      wr_pntr2 <= wr_pntr2 + 1'b1;      
end  
		
sr32_fifo_regfile54_reg_mem sr32_1(
       .addr1(wr_ptr2),
       .addr0(rd_ptr2),
       .din(key_c[53:0]),
       .clk(clk),
       .en(1'b1),
       .dout(key_c_r32)
     );		

always @(posedge clk)
	key_c_r <= #1 key_c_r32;		
//end replace second shift register

des u0(	.desOut(stage1_out),	.desIn(desIn),		.key(key_a), .decrypt(decrypt), .clk(clk) );

des u1(	.desOut(stage2_out),	.desIn(stage1_out),	.key({key_b_r55[16],key_b_r54[16],key_b_r}), .decrypt(!decrypt), .clk(clk) );

des u2(	.desOut(desOut),	.desIn(stage2_out),	.key({key_c_r55[32],key_c_r54[32],key_c_r}), .decrypt(decrypt),	.clk(clk) );

endmodule


