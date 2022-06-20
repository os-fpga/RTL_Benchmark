module irda_fir_4ppm_encoder (clk, wb_rst_i, ppm_restart, fir_tx8_enable, fir_tx4_enable, 
			next_data_fir, txdout, ppm_o);

input		clk;
input		wb_rst_i;
input		ppm_restart;
input		fir_tx8_enable;
input		fir_tx4_enable;
input		next_data_fir;
input		txdout; // input to the module is output from the CRC module

output	ppm_o;

reg			ppm_o;

reg			buffer;
reg			div2;
reg	[1:0]	dbp; // data bit pair (to be encoded)
reg			new_dbp;

// enabled every 2 bits
always @(posedge clk or posedge wb_rst_i)
begin
	if (wb_rst_i) begin
		div2 <= #1 0;
	end else if (ppm_restart)
		div2 <= #1 0;
	else if (next_data_fir)
		div2 <= #1 ~div2;
end

// input level (works at 4 Mhz)
always @(posedge clk or posedge wb_rst_i)
begin
	if (wb_rst_i) begin
		buffer <= #1 0;
	end else if (ppm_restart)
		buffer <= #1 0;
	else if 	(fir_tx4_enable && div2)
		buffer <= #1 txdout; // get input data to buffer once in 2 bits
end

// 2-bit holder register
always @(posedge clk or posedge wb_rst_i)
begin
	if (wb_rst_i) begin
		dbp <= #1 0;
		new_dbp <= #1 0;
	end else if (ppm_restart) begin
		dbp <= #1 0;
		new_dbp <= #1 0;
	end else if (fir_tx4_enable && next_data_fir)
		if ( !div2 ) begin
			dbp <= #1 {txdout, buffer};
			new_dbp <= #1 1;
		end else
			new_dbp <= #1 0;
end

reg [0:1] chip; // chip number inside the dbp

always @(posedge clk or posedge wb_rst_i)
begin
	if (wb_rst_i) begin
		ppm_o <= #1 0;
		chip <= #1 0;
	end else if (ppm_restart) begin
		ppm_o <= #1 0;
		chip <= #1 0;
	end else	if (fir_tx8_enable)
	if (new_dbp) begin
			case (dbp)
				2'b00 : ppm_o <= #1 1;
				default : ppm_o <= #1 0;
			endcase
			chip <= #1 1;
	end else if (chip==1) begin
		case (dbp)
			2'b01 : ppm_o <= #1 1;
			default : ppm_o <= #1 0;
		endcase
		chip <= #1 2;
	end else if (chip==2) begin
		case (dbp)
			2'b10 : ppm_o <= #1 1;
			default : ppm_o <= #1 0;
		endcase
		chip <= #1 3;
	end else if (chip==3) begin
		case (dbp)
			2'b11 : ppm_o <= #1 1;
			default : ppm_o <= #1 0;
		endcase
		chip <= #1 0;
	end
end

endmodule
