
`include "defines.v"
`include "spi_if.sv"
`include "apb_if.sv"
`include "uvm_macros.svh"

package prj_pkg;

	import uvm_pkg::*;
	`include "apb_seq_item.sv"
	`include "apb_monitor.sv"
	`include "apb_driver.sv"
	`include "apb_seqr.sv"
	
endpackage
