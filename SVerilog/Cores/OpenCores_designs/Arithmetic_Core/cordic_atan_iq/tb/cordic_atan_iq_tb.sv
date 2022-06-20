timeunit 1ns;
timeprecision 1ns;

`include "AuxFunc.sv"
`include "AuxClasses.sv"
`include "atan32_table.sv"

module cordic_atan_iq_tb;
	import AuxFuncPkg::*;
	import AuxClassesPkg::*;

	bit clk = 0;
	bit signed [29:0] IS, QS;
	wire signed [31:0] angle;
	wire [31:0] coe_radius;
	
	int ang_delta_max = 0, ang_delta_min = 0;
	int abs_delta_max = 0, abs_delta_min = 0;
	real pct;
	int i, j;
	
	always #10ns clk++;
	
	initial begin
		repeat(10) @(posedge clk);
		
		//Test(20_000_000, 4_000_000);
		//Test(0, V_MAX);
		//Test(V_MIN, 0);
		//Test(V_MIN, V_MAX);
		//Test(0, V_MIN);
		Test2();
		
		$stop(2);
	end
	
	cordic_atan_iq dut(.*);
	
	task Test(bit signed [29:0] I, Q);
		int atan_ref, ang_delta, abs_ref, abs_res, abs_delta;
		
		IS = I;
		QS = Q;
		repeat(100) @(posedge clk);
		
		atan_ref = atan_iq_int(int'(IS), int'(QS));
		ang_delta = delta(atan_ref, angle);
		pct = rel_pct(atan_ref, angle);
		
		$display("%d {%08h, %08h}: Ref %g deg (%d), RTL %g deg (%d), delta %d (%g pct)", i, int'(IS), int'(QS), int_to_deg(atan_ref), atan_ref, int_to_deg(angle), angle, ang_delta, pct);		
		
		abs_ref = imag(I, Q);
		abs_res = int'(ConstPkg::K * real'(coe_radius));
		abs_delta = delta(abs_ref, abs_res);
		$display("\tAbs: x[end] = %08h, Ref %d, RTL %d, delta %d", coe_radius, abs_ref, abs_res, abs_delta);
		
		assert (iabs(ang_delta) <= 16 && iabs(abs_delta) <= 16) else $display("ERROR!");
	endtask
	
	task Test2();
		int atan_ref, ang_delta, abs_ref, abs_res, abs_delta;
		int I, Q;
		automatic bit error = 0;
		
//		automatic IQArrayList v = GenIQ();
		automatic IQArrayList v = GenIQ(1024);
		
		fork
			begin
				for (int i = 0; i < v.size(); i++) begin
					IS = v.data[i].I;
					QS = v.data[i].Q;
					@(posedge clk);
				end
			end
			begin
				repeat(32+1) @(posedge clk);
				
				for (int i = 0; i < v.size(); i++) begin
					I = v.data[i].I;
					Q = v.data[i].Q;
					
					atan_ref = atan_iq_int(I, Q);
					
					ang_delta = delta(atan_ref, angle);
					if (ang_delta > ang_delta_max) ang_delta_max = ang_delta;
					if (ang_delta < ang_delta_min) ang_delta_min = ang_delta;
					
					pct = rel_pct(atan_ref, angle);
					
					$display("%d {%08h, %08h}. Angle: Ref %g deg (%d), RTL %g deg (%d), delta %d (%g pct)", i, I, Q, int_to_deg(atan_ref), atan_ref, int_to_deg(angle), angle, ang_delta, pct);
					
					abs_ref = imag(I, Q);
					abs_res = int'(ConstPkg::K * real'(coe_radius));
					abs_delta = delta(abs_ref, abs_res);
					if (abs_delta > abs_delta_max) abs_delta_max = abs_delta;
					if (abs_delta < abs_delta_min) abs_delta_min = abs_delta;
					
					$display("\tAbs: x[end] = %08h, Ref %d, RTL %d, delta %d", coe_radius, abs_ref, abs_res, abs_delta);
					
					assert (iabs(ang_delta) <= 16 && iabs(abs_delta) <= 16)
					else
						begin
							error = 1;
							$display("ERROR!");
						end
					
					@(posedge clk);
				end
				
				if (error)
					$display("Result: ERROR!");
				else
					$display("Result: OK");
			end
		join
		
		$display("Calculation precision. Angle: [%d, %d] ([%g, %g] sec)", ang_delta_min, ang_delta_max, int_to_deg(ang_delta_min) * 60**2, int_to_deg(ang_delta_max) * 60**2);
		$display("\tAbs: [%d, %d])", abs_delta_min, abs_delta_max);
		
		repeat(100) @(posedge clk);
		$stop(2);
	endtask
	
	//
	wire [31:0][31:0] x;
	wire [30:0][31:0] y;
	wire [31:1][31:0] a;
	
	genvar k;
	generate for (k = 0; k < 32; k++)
		begin :gen_x
			assign x[k] = dut.x[k];
		end
	endgenerate
	
	genvar n;
	generate for (n = 0; n < 31; n++)
		begin :gen_y
			assign y[n] = dut.y[n];
		end
	endgenerate
	
	genvar m;
	generate for (m = 1; m < 32; m++)
		begin :gen_a
			assign a[m] = dut.a[m];
		end
	endgenerate
	
endmodule :cordic_atan_iq_tb
