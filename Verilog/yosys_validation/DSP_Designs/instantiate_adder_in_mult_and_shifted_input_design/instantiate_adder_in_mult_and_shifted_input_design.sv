`include "adder.sv"
module instantiate_adder_in_mult_and_shifted_input_design (clk, areset, A, B, acc_fir, result);
	input clk;
	input areset;
	input signed [19:0] A;
	input signed [17:0] B;
    input [5:0] acc_fir;
    output reg signed [37:0] result;

	reg signed [19:0] a_reg;
	reg signed [17:0] b_reg;
	reg [5:0] acc_fir_reg;
	
    wire signed [63:0] extended_mult_o;
    wire signed [63:0] acc_fir_left_shift_o;
    wire signed [63:0] adder_output;

	wire signed [37:0] mult_o;
    wire signed [63:0] extend_A_input;	

	always @ (posedge clk or posedge areset) begin
		if(areset) begin
			a_reg <= 0;
			b_reg <= 0;
			acc_fir_reg <= 0;
			
		end
		else begin
		    a_reg <= A;	 
		    b_reg <= B;
		    acc_fir_reg <= acc_fir;
		    
		end
	end

    assign mult_o = a_reg * b_reg;
    assign extended_mult_o = { {26{mult_o[37]}}, mult_o[37:0] };
    assign extend_A_input =  { {44{a_reg[19]}}, a_reg[19:0] };
    assign acc_fir_left_shift_o = extend_A_input << acc_fir_reg;

    adder add_unit (.A(extended_mult_o),. B(acc_fir_left_shift_o),. out(adder_output));

    always @ (posedge clk or posedge areset) begin
        if (areset) begin
            result <=0;
        end
        else begin
            result <= {adder_output[63], adder_output[36:0]};
        end

    end


endmodule
