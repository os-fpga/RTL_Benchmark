module lpm_counter #(parameter WIDTH = 32)
(
	data, 
  clk,
  clk_en,
  cnt_en,
	aclr, 
  aset,
  sload,
	updown,
  q
);

  input [WIDTH-1 :0] data;
  input aclr, aset, clk, clk_en;
  input sload, updown, cnt_en;
  output [WIDTH-1 :0] q;
  
	reg [WIDTH-1 :0] count;
  reg clk_en_r;
  
  wire clk_int;
  
  assign clk_int = clk & clk_en_r;
  
  always @ (negedge clk or posedge aclr)
	begin
		if (aclr) 
		begin
       clk_en_r <= 1;
		end
		else 
		begin
			 if (clk_en == 1'b0)
          clk_en_r <= 0;
       else
          clk_en_r <= 1; 
		end
	end

	always @ (posedge clk or posedge aclr)
	begin
		if (aclr) 
		begin
			count <= 0;
		end
		else 
		begin
			if (sload == 1)
         count <= data;
      else if (cnt_en == 1)
          if (updown == 1)
            count <= count + 1;
          else
            count <= count - 1; 
      else
         count <= count;
		end
	end
  
  assign q = count;
	
endmodule
