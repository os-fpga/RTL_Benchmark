module DCM_BASE (
	CLK0,
	CLK180,
	CLK270,
	CLK2X,
	CLK2X180,
	CLK90,
	CLKDV,
	CLKFX,
	CLKFX180,
	LOCKED,
	CLKFB,
	CLKIN,
	RST
);

parameter real CLKDV_DIVIDE = 2.0;
parameter integer CLKFX_DIVIDE = 1;
parameter integer CLKFX_MULTIPLY = 4;
parameter CLKIN_DIVIDE_BY_2 = "FALSE";
parameter real CLKIN_PERIOD = 10.0;
parameter CLKOUT_PHASE_SHIFT = "NONE";
parameter CLK_FEEDBACK = "1X";
parameter DCM_AUTOCALIBRATION = "TRUE";
parameter DCM_PERFORMANCE_MODE = "MAX_SPEED";
parameter DESKEW_ADJUST = "SYSTEM_SYNCHRONOUS";
parameter DFS_FREQUENCY_MODE = "LOW";
parameter DLL_FREQUENCY_MODE = "LOW";
parameter DUTY_CYCLE_CORRECTION = "TRUE";
parameter FACTORY_JF = 16'hF0F0;
parameter integer PHASE_SHIFT = 0;
parameter STARTUP_WAIT = "FALSE";


output CLK0;
output CLK180;
output CLK270;
output CLK2X180;
output CLK2X;
output CLK90;
output CLKDV;
output CLKFX180;
output CLKFX;
output LOCKED;

input CLKFB;
input CLKIN;
input RST;

wire OPEN_DRDY;
wire OPEN_PSDONE;
wire [15:0] OPEN_DO;

initial
begin
   if (CLKOUT_PHASE_SHIFT != "NONE" && CLKOUT_PHASE_SHIFT != "FIXED")
     begin
     $display(" Attribute Syntax Error :The attribute CLKOUT_PHASE_SHIFT on DCM_BASE instance %m is set to %s.  Legal values for this attribute is NONE or FIXED", CLKOUT_PHASE_SHIFT);
        $finish;
     end

   if (CLK_FEEDBACK != "NONE" && CLK_FEEDBACK != "1X")
        begin
            $display("Attribute Syntax Error : The attribute CLK_FEEDBACK on DCM_BASE instance %m is set to %s.  Legal values for this attribute are NONE or 1X.", CLK_FEEDBACK);
            $finish;
        end

end


endmodule 
