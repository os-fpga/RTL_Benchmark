module CLKDLL (
	CLK0, CLK180, CLK270, CLK2X, CLK90, CLKDV, LOCKED, 
	CLKFB, CLKIN, RST);

parameter real CLKDV_DIVIDE = 2.0;
parameter DUTY_CYCLE_CORRECTION = "TRUE";
parameter FACTORY_JF = 16'hC080;		// non-simulatable
localparam integer MAXPERCLKIN = 40000;			// simulation parameter
localparam integer SIM_CLKIN_CYCLE_JITTER = 300;		// simulation parameter
localparam integer SIM_CLKIN_PERIOD_JITTER = 1000;	// simulation parameter
parameter STARTUP_WAIT = "FALSE";		// non-simulatable

input CLKFB, CLKIN, RST;

output CLK0, CLK180, CLK270, CLK2X, CLK90, CLKDV, LOCKED;

reg CLK0, CLK180, CLK270, CLK2X, CLK90, CLKDV;

wire clkfb_in, clkin_in, rst_in;
wire clk0_out;
reg clk2x_out, clkdv_out, locked_out;

reg [1:0] clkfb_type;
reg [8:0] divide_type;
reg clk1x_type;

reg lock_period, lock_delay, lock_clkin, lock_clkfb;
reg [1:0] lock_out;
reg lock_fb;
reg fb_delay_found;
reg clock_stopped;

reg clkin_ps;
reg clkin_fb;

time clkin_edge;
time clkin_ps_edge;
time delay_edge;
time clkin_period [2:0];
time period;
time period_ps;
time period_orig;
time clkout_delay;
time fb_delay;
time period_dv_high, period_dv_low;
time cycle_jitter, period_jitter;

reg clkin_window, clkfb_window;
reg clkin_5050;
reg [2:0] rst_reg;
reg [23:0] i, n, d, p;


reg notifier;

// initial begin
//     #1;
//     if ($realtime == 0) begin
// 	$display ("Simulator Resolution Error : Simulator resolution is set to a value greater than 1 ps.");
// 	$display ("In order to simulate the CLKDLL, the simulator resolution must be set to 1ps or smaller.");
// 	$finish;
//     end
// end

initial begin
    case (CLKDV_DIVIDE)
	1.5  : divide_type = 'd3;
	2.0  : divide_type = 'd4;
	2.5  : divide_type = 'd5;
	3.0  : divide_type = 'd6;
	4.0  : divide_type = 'd8;
	5.0  : divide_type = 'd10;
	8.0  : divide_type = 'd16;
	16.0 : divide_type = 'd32;
	default : begin
	    $display("Attribute Syntax Error : The attribute CLKDV_DIVIDE on CLKDLL instance %m is set to %0.1f.  Legal values for this attribute are 1.5, 2.0, 2.5, 3.0, 4.0, 5.0, 8.0 or 16.0.", CLKDV_DIVIDE);
	    $finish;
	end
    endcase

    clkfb_type = 2;

    period_jitter = SIM_CLKIN_PERIOD_JITTER;
    cycle_jitter = SIM_CLKIN_CYCLE_JITTER;

    case (DUTY_CYCLE_CORRECTION)
	"false" : clk1x_type <= 0;
	"FALSE" : clk1x_type <= 0;
	"true"  : clk1x_type <= 1;
	"TRUE"  : clk1x_type <= 1;
	default : begin
	    $display("Attribute Syntax Error : The attribute DUTY_CYCLE_CORRECTION on CLKDLL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", DUTY_CYCLE_CORRECTION);
	    $finish;
	end
    endcase

    case (STARTUP_WAIT)
	"false" : ;
	"FALSE" : ;
	"true"  : ;
	"TRUE"  : ;
	default : begin
	    $display("Attribute Syntax Error : The attribute STARTUP_WAIT on CLKDLL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", STARTUP_WAIT);
	    $finish;
	end
    endcase
end

//
// input wire delays
//

buf b_clkin (clkin_in, CLKIN);
buf b_clkfb (clkfb_in, CLKFB);
buf b_rst (rst_in, RST);
buf #100 b_locked (LOCKED, locked_out);

clkdll_maximum_period_check #("CLKIN", MAXPERCLKIN) i_max_clkin (clkin_in, rst_in);


always @(clkin_in or rst_in) 
    if (rst_in == 1'b0)
	clkin_ps <= clkin_in;
    else if (rst_in == 1'b1) begin
	clkin_ps <= 1'b0;
//	@(negedge rst_reg[2]);
    end

always @(clkin_ps or lock_fb)
    clkin_fb <= #(period_ps) clkin_ps & lock_fb;

// always @(posedge clkin_ps) begin
//  //   clkin_ps_edge <= $time;
//     if (($time - clkin_ps_edge) <= (1.5 * period_ps))
// 	period_ps <= $time - clkin_ps_edge;
//     else if ((period_ps == 0) && (clkin_ps_edge != 0))
// 	period_ps <= $time - clkin_ps_edge;
// end

always @(posedge clkin_ps) 
    lock_fb <= lock_period;

always @(period or fb_delay)
    clkout_delay <= period - fb_delay;

//
// generate master reset signal
//

always @(posedge clkin_in) begin
    rst_reg[0] <= rst_in;
    rst_reg[1] <= rst_reg[0] & rst_in;
    rst_reg[2] <= rst_reg[1] & rst_reg[0] & rst_in;
end

time rst_tmp1, rst_tmp2;
initial
begin
rst_tmp1 = 0;
rst_tmp2 = 0;
end


//    always @(posedge rst_in or negedge rst_in)
//    begin
//       if (rst_in ==1) 
//          rst_tmp1 <= $time;
//       else if (rst_in==0 ) begin
//          rst_tmp2 = $time - rst_tmp1; 
//          if (rst_tmp2 < 2000 && rst_tmp2 != 0) 
//            $display("Input Error : RST on instance %m must be asserted at least for 2 ns.");
//       end
//    end


initial begin
    clk2x_out = 0;
    clkdv_out = 0;
    clkin_5050 = 0;
    clkfb_window = 0;
    clkin_period[0] = 0;
    clkin_period[1] = 0;
    clkin_period[2] = 0;
    clkin_ps_edge = 0;
    clkin_window = 0;
    clkout_delay = 0;
    clock_stopped = 1;
    fb_delay  = 0;
    fb_delay_found = 0;
    lock_clkfb = 0;
    lock_clkin = 0;
    lock_delay = 0;
    lock_fb = 0;
    lock_out = 2'b00;
    lock_period = 0;
    locked_out = 0;
    period = 0;
    period_ps = 0;
    period_orig = 0;
    rst_reg = 3'b000;
end

always @(rst_in) begin
    clkin_5050 <= 0;
  //  clkfb_window <= 0;
 //   clkin_period[0] <= 0;
    clkin_period[1] <= 0;
    clkin_period[2] <= 0;
    clkin_ps_edge <= 0;
    clkin_window <= 0;
  //  clkout_delay <= 0;
  //  clock_stopped <= 1;
    fb_delay  <= 0;
    fb_delay_found <= 0;
    lock_clkfb <= 0;
    lock_clkin <= 0;
    lock_delay <= 0;
  //  lock_fb <= 0;
    lock_out <= 2'b00;
//    lock_period <= 0;
    locked_out <= 0;
    period_ps <= 0;
end

//
// determine clock period
//

// always @(posedge clkin_ps) begin
//     clkin_edge <= $time;
//     clkin_period[2] <= clkin_period[1];
//     clkin_period[1] <= clkin_period[0];
//     if (clkin_edge != 0)
// 	clkin_period[0] <= $time - clkin_edge;
// end

always @(negedge clkin_ps) begin
    if (lock_period == 1'b0) begin
	if ((clkin_period[0] != 0) &&
		(clkin_period[0] - cycle_jitter <= clkin_period[1]) &&
		(clkin_period[1] <= clkin_period[0] + cycle_jitter) &&
		(clkin_period[1] - cycle_jitter <= clkin_period[2]) &&
		(clkin_period[2] <= clkin_period[1] + cycle_jitter)) begin
	    lock_period <= 1;
	    period_orig <= (clkin_period[0] +
			    clkin_period[1] +
			    clkin_period[2]) / 3;
	    period <= clkin_period[0];
	end
    end
    else if (lock_period == 1'b1) begin
	if (100000000 < (clkin_period[0] / 1000)) begin
	    $display("Warning : CLKIN stopped toggling on instance %m exceeds %d ms.  Current CLKIN Period = %1.3f ns.", 100, clkin_period[0] / 1000.0);
	    lock_period <= 0;
	 //   @(negedge rst_reg[2]);
	end
	else if ((period_orig * 2 < clkin_period[0]) && clock_stopped == 1'b0) begin
	    clkin_period[0] = clkin_period[1];
	    clock_stopped = 1'b1;
	end
	else if ((clkin_period[0] < period_orig - period_jitter) ||
		(period_orig + period_jitter < clkin_period[0])) begin
	    $display("Warning : Input Clock Period Jitter on instance %m exceeds %1.3f ns.  Locked CLKIN Period = %1.3f.  Current CLKIN Period = %1.3f.", period_jitter / 1000.0, period_orig / 1000.0, clkin_period[0] / 1000.0);
	    lock_period <= 0;
	//    @(negedge rst_reg[2]);
	end
	else if ((clkin_period[0] < clkin_period[1] - cycle_jitter) ||
		(clkin_period[1] + cycle_jitter < clkin_period[0])) begin
	    $display("Warning : Input Clock Cycle-Cycle Jitter on instance %m exceeds %1.3f ns.  Previous CLKIN Period = %1.3f.  Current CLKIN Period = %1.3f.", cycle_jitter / 1000.0, clkin_period[1] / 1000.0, clkin_period[0] / 1000.0);
	    lock_period <= 0;
	//    @(negedge rst_reg[2]);
	end
	else begin
	    period <= clkin_period[0];
	    clock_stopped = 1'b0;
	end
    end
end

//
// determine clock delay
//


// determine feedback lock
//

always @(posedge clkfb_in) begin
    #0  clkfb_window <= 1;
    #cycle_jitter clkfb_window <= 0;
end



//
// generate all output signal
//

always @(clk0_out) 
    CLK0 <= #(clkout_delay) clk0_out;

always @(clk0_out) 
    CLK90 <= #(clkout_delay + period / 4) clk0_out;

always @(clk0_out) 
    CLK180 <= #(clkout_delay + period / 2) clk0_out;

always @(clk0_out) 
    CLK270 <= #(clkout_delay + (3 * period) / 4) clk0_out;

always @(clk2x_out) 
    CLK2X <= #(clkout_delay) clk2x_out;

always @(clkdv_out) 
    CLKDV <= #(clkout_delay) clkdv_out;


endmodule

//////////////////////////////////////////////////////

module clkdll_maximum_period_check (clock, rst);
parameter clock_name = "";
parameter maximum_period = 0;
input clock;
input rst;

time clock_edge;
time clock_period;

initial begin
    clock_edge = 0;
    clock_period = 0;
end

// always @(posedge clock) begin
//     clock_edge <= $time;
//     clock_period <= $time - clock_edge;
//     if (clock_period > maximum_period && rst == 0) begin
// 	$display("Warning : Input clock period of, %1.3f ns, on the %s port of instance %m exceeds allotted value of %1.3f ns at simulation time %1.3f ns.", clock_period/1000.0, clock_name, maximum_period/1000.0, $time/1000.0);
//     end
// end
endmodule 
