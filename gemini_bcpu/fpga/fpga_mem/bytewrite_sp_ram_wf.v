module bytewrite_sp_ram_wf
#(
//--------------------------------------------------------------------------
parameter NUM_COL = 4, // 4 columns of 1 byte each make : 32 bits
parameter COL_WIDTH = 8, //1 byte
parameter ADDR_WIDTH = 10, // Addr Width in bits : 2 *ADDR_WIDTH = RAM Depth ---> 2^10 = 1024
parameter DATA_WIDTH = NUM_COL*COL_WIDTH // Data Width in bits
//--------------------------------------------------------------------------
) (
input clk,
input ena,
input [NUM_COL-1:0] we,
input [ADDR_WIDTH-1:0] addr,
input [DATA_WIDTH-1:0] din,
output reg [DATA_WIDTH-1:0] dout
);

(* ram_style = "block" *) reg [DATA_WIDTH-1:0] ram [(2**ADDR_WIDTH)-1:0];
integer i;

always @ (posedge clk) 
begin
	if(ena) 
	begin
		for(i=0;i<NUM_COL;i=i+1) 
		begin
			if(we[i]) 
			begin
				ram[addr][i*COL_WIDTH +: COL_WIDTH] <= din[i*COL_WIDTH +: COL_WIDTH];
				dout[i*COL_WIDTH +: COL_WIDTH] <= din[i*COL_WIDTH +: COL_WIDTH];
			end
			else
				dout[i*COL_WIDTH +: COL_WIDTH] <= ram[addr][i*COL_WIDTH +: COL_WIDTH];
		end
	end
end

endmodule 


//  Xilinx Single Port Byte-Write Read First RAM
  //  This code implements a parameterizable single-port byte-write read-first memory where when data
  //  is written to the memory, the output reflects the prior contents of the memory location.
  //  If a reset or enable is not necessary, it may be tied off or removed from the code.
  //  Modify the parameters for the desired RAM characteristics.
module bytewrite_sp_ram_wf_new # (

  parameter NB_COL = 4,                       // Specify number of columns (number of bytes)
  parameter COL_WIDTH = 8,                  // Specify column width (byte width, typically 8 or 9)
  parameter RAM_DEPTH =32,                  // Specify RAM depth (number of entries)
  parameter RAM_PERFORMANCE = "HIGH_PERFORMANCE", // Select "HIGH_PERFORMANCE" or "LOW_LATENCY" 
  parameter INIT_FILE = ""  ,                     // Specify name/location of RAM initialization file if using one (leave blank if not)
  parameter ADDR_WIDTH = 13
) ( 
  input [(ADDR_WIDTH-1):0] addra,  // Address bus, width determined from RAM_DEPTH
  input [(NB_COL*COL_WIDTH)-1:0] dina,  // RAM input data
  input clka,                           // Clock
  input [NB_COL-1:0] wea,               // Byte-write enable
  input ena,                            // RAM Enable, for additional power savings, disable port when not in use
  output rsta,                           // Output reset (does not affect memory contents)
  output regcea,                        // Output register enable

  output [(NB_COL*COL_WIDTH)-1:0] douta          // RAM output data

);

  reg [(NB_COL*COL_WIDTH)-1:0] ram_name [RAM_DEPTH-1:0];
  reg [(NB_COL*COL_WIDTH)-1:0] ram_data = {(NB_COL*COL_WIDTH){1'b0}};

  // The following code either initializes the memory values to a specified file or to all zeros to match hardware
  generate
    if (INIT_FILE != "") begin: use_init_file
      initial
        $readmemh(INIT_FILE, ram_name, 0, RAM_DEPTH-1);
    end else begin: init_bram_to_zero
      integer ram_index;
      initial
        for (ram_index = 0; ram_index < RAM_DEPTH; ram_index = ram_index + 1)
          ram_name[ram_index] = {(NB_COL*COL_WIDTH){1'b0}};
    end
  endgenerate

  always @(posedge clka)
    if (ena) begin
      ram_data <= ram_name[addra];
    end

  generate
  genvar i;
     for (i = 0; i < NB_COL; i = i+1) begin: byte_write
       always @(posedge clka)
         if (ena)
           if (wea[i])
             ram_name[addra][(i+1)*COL_WIDTH-1:i*COL_WIDTH] <= dina[(i+1)*COL_WIDTH-1:i*COL_WIDTH];
      end
  endgenerate

  //  The following code generates HIGH_PERFORMANCE (use output register) or LOW_LATENCY (no output register)
  generate
    if (RAM_PERFORMANCE == "LOW_LATENCY") begin: no_output_register

      // The following is a 1 clock cycle read latency at the cost of a longer clock-to-out timing
       assign douta = ram_data;

    end else begin: output_register

      // The following is a 2 clock cycle read latency with improve clock-to-out timing

      reg [(NB_COL*COL_WIDTH)-1:0] douta_reg = {(NB_COL*COL_WIDTH){1'b0}};

      always @(posedge clka)
        if (rsta)
          douta_reg <= {(NB_COL*COL_WIDTH){1'b0}};
        else if (regcea)
          douta_reg <= ram_data;

      assign douta = douta_reg;

    end
  endgenerate

  //  The following function calculates the address width based on specified RAM depth
  function integer clogb2;
    input integer depth;
      for (clogb2=0; depth>0; clogb2=clogb2+1)
        depth = depth >> 1;
  endfunction
endmodule							
