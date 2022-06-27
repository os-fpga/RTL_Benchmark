
interface apb_intf;
		logic [3:0] paddr;
		logic pwrite;
		logic [1:0] psel;
		logic penable;
		wire  pready;
		logic [31:0] pwdata;
		wire  [31:0] prdata;
		logic pclk;
		logic presetn;

endinterface
