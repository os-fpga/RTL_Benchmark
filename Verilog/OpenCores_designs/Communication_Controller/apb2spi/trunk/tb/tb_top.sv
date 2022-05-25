`include "uvm_macros.svh"
`include "defines.v"
`include "prj_pkg.sv"

module tb_top;

import uvm_pkg::*;
import prj_pkg::*;

apb_if apb_if1();
spi_if spi_if1();

APB_SPI_top A1(
 .PCLK   (apb_if1.PCLK),
 .PRESETn(apb_if1.PRESETn),
 .PADDR  (apb_if1.PADDR),
 .PWRITE (apb_if1.PWRITE),
 .PSEL   (apb_if1.PSEL),
 .PENABLE(apb_if1.PENABLE),
 .PWDATA (apb_if1.PWDATA),
 .PRDATA (apb_if1.PRDATA),
 .PREADY (apb_if1.PREADY),
 .TrFr   (apb_if1.TrFr),
 .SCLK   (spi_if1.SCLK),
 .MISO   (spi_if1.MISO),
 .MOSI   (spi_if1.MOSI),
 .SS     (spi_if1.SS)
);

initial
begin
	uvm_config_db#(virtual apb_if)::set(null,"*","apb_vif",apb_if1);
	uvm_config_db#(virtual spi_if)::set(null,"*","spi_vif",spi_if1);
end

initial
begin
	apb_if1.PCLK = 1'b0;
	apb_if1.PRESETn = 1'b0;
	#20 apb_if1.PRESETn = 1'b1;
	#5 forever apb_if1.PCLK = ~apb_if1.PCLK;
	#100 $finish;
end


endmodule
