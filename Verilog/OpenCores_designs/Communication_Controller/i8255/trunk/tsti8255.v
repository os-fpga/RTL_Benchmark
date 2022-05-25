`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:16:54 11/16/2009
// Design Name:   i8255
// Module Name:   /home/malasar/projects/fpga/i8080/tsti8255.v
// Project Name:  i8080
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: i8255
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

	
module tsti8255;

	// Inputs
	reg reset;
	reg ncs;
	reg nrd;
	reg nwr;
	reg [1:0] addr;
	// Bidirs
	wire [7:0] data;
	wire [7:0] pa;
	reg pae;
	wire [7:0] pb;
	reg pbe;
	wire [3:0] pch;
	reg pche;
	wire [3:0] pcl;
	reg pcle;
	wire clk;
	reg oflag;
	reg pause;
	reg [7:0] newval;
	reg [7:0] step;
	reg [7:0] wrtport;
	reg [7:0] resetret;
	reg [7:0] writeret;
   clck clk1(clk);
	// Instantiate the Unit Under Test (UUT)
	i8255 uut (
		.data(data), 
		.reset(reset), 
		.ncs(ncs), 
		.nrd(nrd), 
		.nwr(nwr), 
		.addr(addr), 
		.pa(pa), 
		.pb(pb), 
		.pch(pch), 
		.pcl(pcl)
	);

	initial begin
		// Initialize Inputs
		reset <= 1;
		pae<=0;
		pche<=0;
		wrtport<=0;
		ncs <= 1;
		nrd <= 1;
		nwr <= 1;
		addr <= 2'b11;
		oflag<=0;
		newval<=0;
		step<=6;
		resetret<=0;
		writeret<=0;
		#10 $finish();
        
		// Add stimulus here

	end
	assign data=(oflag)?newval:8'bz;
	assign pa=(pae)?wrtport:8'bz;
	assign pch=(pche)?wrtport[7:4]:8'bz;
		
	always @(posedge clk) begin
		if (reset==1) begin
			ncs<=0;
			reset<=0; //#2
			end
		else begin
			case (step)
				0: begin
					newval<=8'b10000000; //#4
					oflag<=1;
					step<=33;
					resetret<=2;
					writeret<=32;
					ncs<=0;
					end
				2: begin
				   newval<=8'h35; //#10
					oflag<=1;
					addr<=0;
					step<=33;
					resetret<=3;
					writeret<=32;
					end
				3: begin
				   newval<=8'h0;
					nrd<=1;
					nwr<=1;
					step<=4;
					end
				4: begin
					newval<=8'b10100000;
					addr<=2;
					nrd<=1;
					nwr<=0;
					step<=5;
					end
				6: begin
					newval<=8'b10010000; //a-output, c -input //#4
					addr<=3;
					oflag<=1;
					pae<=0;
					step<=33;
					resetret<=7;
					writeret<=32;
					end
				7: begin
					wrtport<=8'b11010000; //#10
					pae<=1;
					//pche=1;
					oflag<=0;
					addr<=0;
					nrd<=0;
					nwr<=1;
					step<=32;
					resetret<=8;
					end
				8: begin
					newval<=8'b10100000;
					//pae=0;
					pche<=1;
					oflag<=1;
					addr<=0;
					nrd<=1;
					nwr<=0;
					step<=10;
					end
				9: begin
					pae<=0;
					addr<=0;
					nrd<=0;
					nwr<=1;
					step<=10;
					end
				32: begin //reset step
					oflag<=0;
					nrd<=1;
					nwr<=1;
					step<=resetret;
					end
				33: begin //write routine
					nwr<=0;
					nrd<=1;
					step<=writeret;
					end
					
			endcase
			end
		end
		
      
endmodule

