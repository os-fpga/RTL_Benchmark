`ifndef _AuxClasses_
`define _AuxClasses_

package AuxClassesPkg;
	
	const real PI = 3.1415926535897932384626433832795;
	
	const int V_MAX = {{3{1'b0}}, {29{1'b1}}};
	const int V_MIN = {{3{1'b1}}, {29{1'b0}}};
	
//	const int V_MAX = {{4{1'b0}}, {28{1'b1}}};
//	const int V_MIN = {{4{1'b1}}, {28{1'b0}}};

	class IQClass;
		int I, Q;
		
		function new(int I, int Q);
			this.I = I;
			this.Q = Q;
		endfunction
	endclass :IQClass
	
	class IQArrayList;
		IQClass data[$];
		
		function new();
			data = {};
		endfunction
		
		function void push_back(int I, int Q);
			IQClass iq = new(I, Q);
			data.push_back(iq);
		endfunction
		
		function int size();
			return data.size;
		endfunction
		
		function string ToString();
			return "";
		endfunction
	endclass :IQArrayList

endpackage :AuxClassesPkg

`endif
