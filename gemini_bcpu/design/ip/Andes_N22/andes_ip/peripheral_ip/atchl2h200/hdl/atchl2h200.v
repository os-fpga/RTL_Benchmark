// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

module atchl2h200 (
		  hclk,
		  hresetn,
		  us_haddr,
		  us_hburst,
		  us_hprot,
		  us_hsize,
		  us_htrans,
		  us_hmastlock,
		  ds_hlock,
		  ds_hmastlock,
		  us_hwrite,
		  us_hreadyout,
		  us_hresp,
		  ds_hbusreq,
		  ds_hgrant,
		  us_hready,
		  us_hsel,
		  ds_haddr,
		  ds_htrans,
		  ds_hwrite,
		  ds_hsize,
		  ds_hburst,
		  ds_hprot,
		  ds_hready,
		  ds_hresp
	);

localparam PRODUCT_ID = 32'h00082002;
parameter ADDR_WIDTH           = 32;
parameter MASTER_INTERFACE     = 1;
parameter LOCK_SUPPORT         = 1;
localparam NDS_HTRANS_IDLE     = 2'b00;
localparam NDS_HTRANS_BUSY     = 2'b01;
localparam NDS_HTRANS_NONSEQ   = 2'b10;
localparam NDS_HTRANS_SEQ      = 2'b11;
localparam NDS_HRESP_OK        = 2'b00;
localparam NDS_HRESP_ERROR     = 2'b01;
localparam NDS_HRESP_RETRY     = 2'b10;
localparam NDS_HRESP_SPLIT     = 2'b11;
localparam NDS_HBURST_SINGLE   = 3'b000;
localparam NDS_HBURST_INCR     = 3'b001;
localparam NDS_HBURST_WRAP4    = 3'b010;
localparam NDS_HBURST_INCR4    = 3'b011;
localparam NDS_HBURST_WRAP8    = 3'b100;
localparam NDS_HBURST_INCR8    = 3'b101;
localparam NDS_HBURST_WRAP16   = 3'b110;
localparam NDS_HBURST_INCR16   = 3'b111;

input                    hclk;
input                    hresetn;
input   [ADDR_WIDTH-1:0] us_haddr;
input              [2:0] us_hburst;
input              [3:0] us_hprot;
input              [2:0] us_hsize;
input              [1:0] us_htrans;
input                    us_hmastlock;
output                   ds_hlock;
output                   ds_hmastlock;
input                    us_hwrite;
output                   us_hreadyout;
output                   us_hresp;
output                   ds_hbusreq;
input                    ds_hgrant;
input                    us_hready;
input                    us_hsel;
output  [ADDR_WIDTH-1:0] ds_haddr;
output             [1:0] ds_htrans;
output                   ds_hwrite;
output             [2:0] ds_hsize;
output             [2:0] ds_hburst;
output             [3:0] ds_hprot;
input                    ds_hready;
input              [1:0] ds_hresp;
wire                     s0;
wire                     s1;
wire                     s2;
wire                     s3;
reg                      s4;
wire                     s5;
wire                     s6;
wire                     s7;
wire                     s8;
reg                      s9;
reg     [ADDR_WIDTH-1:0] s10;
reg                [2:0] s11;
reg                      s12;
reg                [3:0] s13;
reg                [2:0] s14;
reg                      s15;
wire                     s16;
wire                     s17;
wire                     s18;
wire                     s19;
wire                     s20;
wire                     s21;
reg                      s22;
wire                     s23;
wire                     s24;
wire                     s25;
reg                      s26;
wire                     s27;
wire                     s28;
wire                     s29;
wire                     s30;
wire                     s31;
wire                     s32;
wire                     s33;
wire                     s34;
wire                     s35;
wire [3:0]               s36;
reg  [3:0]               s37;
wire                     s38;
wire                     s39;
wire                     s40;
wire                     s41;
wire                     s42;
wire                     s43;
wire                     s44;
wire                     s45;
reg                      s46;
wire                     s47;
wire                     s48;
wire                     s49;
wire                     s50;
wire                     s51;
wire                     s52;
wire                     s53;
reg                      s54;
wire                     s55;
wire                     s56;
reg                      s57;
wire                     s58;
wire                     s59;
wire                     s60;
wire                     s61;

assign s0         =  ds_hresp[1];
assign s1         = (ds_hresp == NDS_HRESP_ERROR);
assign s2            = (ds_hresp == NDS_HRESP_OK);
assign s27  = (|us_htrans);
assign s28      = ~s27;
assign s29      = (us_htrans == NDS_HTRANS_BUSY);
assign s30      = us_htrans[1];
assign s31  = (|ds_htrans);
assign s32      = ~s31;
assign s53      = (us_hburst == NDS_HBURST_INCR);

assign s61 = (ds_hready & ~s2 & ~s40) & (us_hreadyout & s30 & us_hready & us_hsel);

assign s3 = ~s2 & ~(s1 & s40) & ~ds_hready;

always @(posedge hclk or negedge hresetn)begin
	if (!hresetn)begin
		s4 <= 1'b0;
	end
	else begin
		s4 <= s3;
	end
end

assign s55  = s1 & ~ds_hready & s40 & s32;

always @(posedge hclk or negedge hresetn) begin
	if (!hresetn) begin
		s54 <= 1'b0;
	end
	else begin
		s54 <= s55;
	end
end

assign s56 = s54 & s30 & us_hready & us_hsel;

assign s59 = ds_hbusreq & ~(ds_hready & ds_hgrant);
assign s60 = ds_hready & ds_hgrant;
assign s58  = s59 | (s57 & ~s60);

always @(posedge hclk or negedge hresetn) begin
	if (!hresetn) begin
		s57 <= 1'b0;
	end
	else begin
		s57 <= s58;
	end
end

assign s44        = s30 & ~(s39 | s40 | s9);

assign s6 =   (s40 & s0)
                           | s38
			   | s17
			   | s44
			   | s50
			   | s52
			   | s56
			   | s61
			   ;
assign s7 = s9 & s39 & ds_hready
                           & ~s18
			   & ~s4;
assign s8  = s6 | (~s7 & s9);

always @(posedge hclk or negedge hresetn) begin
	if (!hresetn) begin
		s9 <= 1'b0;
	end
	else begin
		s9 <= s8;
	end
end

assign s19 = us_hreadyout & us_hsel & us_hready & (us_htrans == NDS_HTRANS_NONSEQ) & (|us_hburst[2:1]);
assign s20 = s35;
assign s21  = s19 | (~s20 & s22);

always @(posedge hclk or negedge hresetn) begin
	if (!hresetn) begin
		s22 <= 1'b0;
	end
	else begin
		s22 <= s21;
	end
end

assign s45 = ~s39 & s40 & ds_hready & s29 & ~s9;

assign s23 = (s22) & ((s40 & s0)
                                                 | s38
			                         | s50
						 | s45);
assign s24 = s20;
assign s25  = s23 | (~s24 & s26);

always @(posedge hclk or negedge hresetn) begin
	if (!hresetn) begin
		s26 <= 1'b0;
	end
	else begin
		s26 <= s25;
	end
end

assign s47 = ~s39 & us_hreadyout & s29;
assign s48 = s46 & s30;
assign s49  = s47 | (~s48 & s46);

always @(posedge hclk or negedge hresetn) begin
	if (!hresetn) begin
		s46 <= 1'b0;
	end
	else begin
		s46 <= s49;
	end
end

assign s50 = s48 & ~(ds_hready & s39);

assign s33      =   ((us_hburst[2:1] == 2'b01) & (&s37[1:0]))
                                | ((us_hburst[2:1] == 2'b10) & (&s37[2:0]))
                                | ((us_hburst[2:1] == 2'b11) & (&s37[3:0]));
assign s34           = us_hreadyout & us_hsel & us_hready & s30 & (|us_hburst[2:1]);
assign s35          = us_hreadyout & (  (us_hsel & us_hready & (&us_htrans[1:0]) & s33)
                                             | (us_hresp & ~(|us_htrans)));
assign s36 = (s35) ? 4'b0000 :
                                ((s34) ? s37 + 4'h1 : s37);

always@ (posedge hclk or negedge hresetn) begin
	if (!hresetn) begin
		s37 <= 4'b0000;
	end
	else begin
		s37 <= s36;
	end
end

generate
	if (MASTER_INTERFACE) begin : ahb_control_master
		reg	s62;
		reg	s63;
		reg     s64;
		wire    s65;
		wire    s66;
		wire    s67;

		assign	s39 = s62;
		assign	s40 = s63;

		always @(posedge hclk or negedge hresetn) begin
			if (!hresetn) begin
				s62 <= 1'b0;
			end
			else if (ds_hready) begin
				s62 <= ds_hgrant;
			end
		end
		always @(posedge hclk or negedge hresetn) begin
			if (!hresetn) begin
				s63 <= 1'b0;
			end
			else if (ds_hready) begin
				s63 <= s62;
			end
		end
		assign s38 =   ~s39
                  		  &  s40
		  		  &  ds_hready
		  		  & ~s0
		 		  &  s30
		  		  & ~s9;
		assign s16 = s42;
		assign ds_hbusreq        = s27 | s9 | s41 | s57;

		assign s65 = us_hreadyout & s28 & ~s64;
		assign s66 = s27;
		assign s67  = s65 | (~s66 & s64);
		always @(posedge hclk or negedge hresetn) begin
			if (!hresetn) begin
				s64 <= 1'b0;
			end
			else begin
				s64 <= s67;
			end
		end

		assign s51            = s64;
		assign s52 = s64 & s30 & ~(ds_hready & s39);
	end
	else begin : ahb_control_slave

		assign s39       = 1'b1;
		assign s40       = 1'b1;
		assign s38         = 1'b0;
		assign s16 = ds_hmastlock;
		assign ds_hbusreq        = 1'b1;
		assign s51        = 1'b0;
		assign s52 = 1'b0;
	end
endgenerate

assign s5    =   s43
                           | s38
			   | s17
			   | s44
			   | s50
			   | s52
			   | s56
			   | s61
			   ;
always @(posedge hclk or negedge hresetn) begin
	if (!hresetn) begin
		s10  <= {(ADDR_WIDTH){1'b0}};
		s12 <= 1'b0;
		s11  <= 3'b000;
		s13  <= 4'b0000;
		s14 <= 3'b000;
	end
	else if (s5) begin
		s10  <= ds_haddr;
		s12 <= ds_hwrite;
		s11  <= ds_hsize;
		s13  <= ds_hprot;
		s14 <= (s22 & (|us_hburst[2:1]) & ~s18) ? NDS_HBURST_SINGLE : ds_hburst;
	end
end

generate
if (LOCK_SUPPORT) begin : retry_lock
	always @(posedge hclk or negedge hresetn) begin
		if (!hresetn) begin
			s15  <= 1'b0;
		end
		else if (s5) begin
			s15  <= s16;
		end
	end
end
endgenerate


assign us_hresp  = s1 & s40;

assign us_hreadyout = (ds_hready & ~(s9 | s4)) | s51 | s46 ;

generate
if (MASTER_INTERFACE) begin : ds_control_master
	assign s43 =  (us_hsel & us_hready)
	                           & ds_hbusreq & s39 & ds_hready & (s2 | s1)
				   & ~s41;

	assign ds_htrans = (s39 & ~(s4 | s18 | s54) & ((us_hsel & us_hready) | s22 | s9)) ?
	                   ((s9 | ((s26 | s53) & s30)) ? NDS_HTRANS_NONSEQ
			    : (((s26 | s53) & s29) ? NDS_HTRANS_IDLE : us_htrans))
			   : NDS_HTRANS_IDLE;
end
else begin : ds_control_slave
	assign s43 = us_hsel & us_hready & ds_hready & (s2 | s1) & s27;

	assign ds_htrans = ((s43 | s22 | s9) & ~(s4 | s18 | s54)) ?
	                   ((s9 | ((s26 | s53) & s30)) ? NDS_HTRANS_NONSEQ
			    : (((s26 | s53) & s29) ? NDS_HTRANS_IDLE : us_htrans))
			   : NDS_HTRANS_IDLE;
end
endgenerate

assign ds_haddr  = s9 ? s10  : us_haddr;
assign ds_hsize  = s9 ? s11  : us_hsize;
assign ds_hwrite = s9 ? s12 : us_hwrite;
assign ds_hprot  = s9 ? s13  : us_hprot;

assign ds_hburst = (s26 | s53) ? NDS_HBURST_SINGLE : (s9 ? s14 : us_hburst);

generate
if (LOCK_SUPPORT) begin : lock_control
	if (MASTER_INTERFACE) begin : lock_control_master
	wire   s68;
	reg    s69;
	wire   s70;
	wire   s71;
	wire   s72;
	wire   s73;
	wire   s74;
	wire   s75;
	reg    s76;
	reg    s77;
	reg    s78;
	wire   s79;

        assign s79      = (us_hmastlock | s69) & ds_hbusreq & ~(  s73
	                                                                                    | s76
											    | (s9 & ~s69)
									         	  );

	assign s68             =   us_hmastlock & us_hready & s27
	                              & ds_hbusreq
				      & ~s9;
	assign s71 = s68 & ~(  (ds_hgrant & ds_hready & ~(~s40 & ~s2))
	                                           | s76
						   );
	assign s72 = s69 & ds_hgrant & ds_hready & s2;
	assign s70  = s71 | (~s72 & s69);

	always @(posedge hclk or negedge hresetn) begin
		if (!hresetn) begin
			s69 <= 1'b0;
		end
		else begin
			s69 <= s70;
		end
	end

	assign s73 = (s68 | s69) & ds_hgrant & ds_hready & ~(s76 | (s39 & s0));
	assign s74 = s76 & ds_hready & ~(us_hmastlock | s9);
	assign s75  = s73 | (~s74 & s76);

	always @(posedge hclk or negedge hresetn) begin
		if (!hresetn) begin
			s76 <= 1'b0;
		end
		else begin
			s76 <= s75;
		end
	end

	assign s17 = us_hreadyout & s30 & s18 & us_hready & us_hsel;

	always @(posedge hclk or negedge hresetn) begin
		if (!hresetn) begin
			s77 <= 1'b0;
		end
		else begin
			s77 <= s74;
		end
	end
	always @(posedge hclk or negedge hresetn) begin
		if (!hresetn) begin
			s78 <= 1'b0;
		end
		else begin
			s78 <= s77;
		end
	end

	assign s18  = s73 | s74 | s77 | s78 | s79 ;
	assign ds_hlock         = s9 ? s15 : (s68 | s76);
	assign ds_hmastlock     = 1'b0;
	assign s41  = s74 | s77 | s78;
	assign s42      = s68 | (s76 & ~(s74 | s77));

	end
	else begin : lock_control_slave

	assign s17 = 1'b0;
	assign s18  = 1'b0;
	assign ds_hlock         = 1'b0;
	assign ds_hmastlock     = s9 ? s15 : us_hmastlock;
	assign s41  = 1'b0;
	assign s42      = 1'b0;

	end
end
else begin : no_lock_control

	assign s17 = 1'b0;
	assign s18  = 1'b0;
	assign ds_hlock         = 1'b0;
	assign ds_hmastlock     = 1'b0;
	assign s41  = 1'b0;
	assign s42      = 1'b0;

end
endgenerate

endmodule
