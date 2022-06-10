`ifndef _AuxPkg_
`define _AuxPkg_
`include "AuxClasses.sv"

package AuxFuncPkg;
	import AuxClassesPkg::*;
	export AuxClassesPkg::*;
	
	function automatic int atan_iq_int(int IS, int QS);
		if (IS == 0)
			if (QS > 0)
				return 2**30; // 90
			else if (QS < 0)
				return -(2**30); // -90
			else
				return 0;
		else if (QS == 0)
			if (IS < 0)
				return 1<<31; // -180
			else
				return 0;
		else if (IS < 0)
			if (QS > 0)
				return int'(($atan(real'(QS)/IS) + PI) * ((2.0**31) / PI));
			else
				return int'(($atan(real'(QS)/IS) - PI) * ((2.0**31) / PI));
		else
			return int'($atan(real'(QS)/IS) * ((2.0**31) / PI));
	endfunction
	
	function automatic real int_to_deg(int angle);
		return real'(angle) / 2.0**30 * 90.0;
	endfunction
	
	function automatic int delta(int ref_angle, int angle);
		return angle - ref_angle;
	endfunction
	
	function automatic real rel_pct(int ref_angle, int angle);
		int d = delta(ref_angle, angle);
		
		if (d < 0) d = -d;
		
		if (ref_angle == 0)
			if (d == 0)
				return 0;
			else
				return 100;
		else
			return real'(d) / real'(ref_angle) * 100.0;
	endfunction
	
	function automatic IQArrayList GenIQ(int POINTS = 8);
		IQArrayList v = new;
		
		// 135...45 deg
		for (int i = -POINTS; i < POINTS; i++)
			v.push_back(i * (V_MAX / POINTS), V_MAX);
		
		// 45...-45 deg
		for (int i = POINTS; i > -POINTS; i--)
			v.push_back(V_MAX, i * (V_MAX / POINTS));
		
		// -45...-135 deg
		for (int i = POINTS; i > -POINTS; i--)
			v.push_back(i * (V_MAX / POINTS), V_MIN);
		
		// -135...135 deg
		for (int i = -POINTS; i < POINTS; i++)
			v.push_back(V_MIN, i * (V_MAX / POINTS));
			
		return v;
	endfunction
	
	function automatic int unsigned iabs(int value);
		if (value < 0) value = -value;
		return value;
	endfunction
	
	function automatic int unsigned imag(int I, int Q);
		real res = int'( $sqrt(real'(I) * real'(I) + real'(Q) * real'(Q)) );
		int unsigned res_uint = longint'(res);
//		$display("I %d Q %d Mag %g (%d)\n", I, Q, res, res_uint);
		return res_uint;
	endfunction

endpackage :AuxFuncPkg

`endif
