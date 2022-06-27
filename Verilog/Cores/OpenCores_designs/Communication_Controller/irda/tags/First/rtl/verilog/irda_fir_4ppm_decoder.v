module irda_fir_4ppm_decoder (clk, wb_rst_i, fir_rx8_enable, ppmd_restart,
				fd_o, ppmd_o, ppmd_bad_chip);
input		clk;
input		wb_rst_i;
input		ppmd_restart;
input		fir_rx8_enable;
input		fd_o;

output	ppmd_o;
output	ppmd_bad_chip;

reg	[2:0]	in_buffer;
reg			out_buffer;
reg	[1:0] chip_sync;
reg			bit_sync;
reg			ppmd_o;
reg			ppmd_bad_chip;

// bit sync signal logic (divides by 2 the fir_rx8_enable - 4Mhz)
always @(posedge clk or posedge wb_rst_i)
begin
	if (wb_rst_i)
		bit_sync <= #1 0;
	else if (ppmd_restart)
		bit_sync <= #1 0;
	else if (fir_rx8_enable)
		bit_sync <= #1 ~bit_sync;		
end

// chip_sync counter (chip start at 0)
always @(posedge clk or posedge wb_rst_i)
begin
	if (wb_rst_i)
		chip_sync <= #1 0;
	else if (ppmd_restart)
		chip_sync <= #1 1;
	else if (fir_rx8_enable)
		chip_sync <= #1 chip_sync + 1;		
end

// input buffer 
always @(posedge clk or posedge wb_rst_i)
begin
	if (wb_rst_i) begin
		in_buffer <= #1 0;
	end else if (ppmd_restart) begin
		in_buffer[2] <= #1 fd_o;
	end else if (fir_rx8_enable) begin
		case (chip_sync)
			0 : in_buffer[2] <= #1 fd_o;
			1 : in_buffer[1] <= #1 fd_o;
			2 : in_buffer[0] <= #1 fd_o;
		default: ;
		endcase
	end
end

// 4ppm decoder
reg	[1:0] dbp; // decoded signal
always @(in_buffer or fd_o)
	case ( {in_buffer, fd_o} )
		4'b1000 : dbp = 2'b00;
		4'b0100 : dbp = 2'b01;
		4'b0010 : dbp = 2'b10;
		4'b0001 : dbp = 2'b11;
		default : dbp = 2'b00;
	endcase

// ppmd_bad_chip output
always @(in_buffer or fd_o)
	case ( {in_buffer, fd_o} )
		4'b1000,	4'b0100, 
		4'b0010, 4'b0001 : ppmd_bad_chip = 0;
		default : ppmd_bad_chip = 1;
	endcase

// output decoder
always @(posedge clk or posedge wb_rst_i)
begin
	if (wb_rst_i) begin
		out_buffer <= #1 0;
		ppmd_o <= #1 0;
	end else if (ppmd_restart) begin
		out_buffer <= #1 0;
		ppmd_o <= #1 0;
	end else if (fir_rx8_enable) begin
		if (bit_sync) begin
			ppmd_o <= #1 dbp[0]; /// LSB first
			out_buffer <= #1 dbp[1];
		end else begin
			ppmd_o <= #1 out_buffer;
		end
	end
end

endmodule
