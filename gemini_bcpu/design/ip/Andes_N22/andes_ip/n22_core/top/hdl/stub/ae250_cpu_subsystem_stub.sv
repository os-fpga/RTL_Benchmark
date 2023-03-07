module ae250_cpu_subsystem (
	input  logic [31:1] int_src                  ,
	output logic        dbg_wakeup_req           ,
	input  logic        test_mode                ,
	input  logic        hart0_nmi                ,
	output logic        dbg_srst_req             ,
	input  logic        dbg_tck                  ,
	input  logic        mtime_clk                ,
	input  logic        pin_tdi_in               ,
	output logic        pin_tdi_out              ,
	output logic        pin_tdi_out_en           ,
	input  logic        pin_tdo_in               ,
	output logic        pin_tdo_out              ,
	output logic        pin_tdo_out_en           ,
	input  logic        pin_tms_in               ,
	output logic        pin_tms_out              ,
	output logic        pin_tms_out_en           ,
	input  logic        pin_trst_in              ,
	output logic        pin_trst_out             ,
	output logic        pin_trst_out_en          ,
	input  logic        por_rstn                 ,
	input  logic        core_clk                 ,
	input  logic        hart0_core_reset_n       ,
	output logic        hart0_core_wfi_mode      ,
	input  logic [31:0] hart0_reset_vector       ,
	input  logic        hart0_icache_disable_init,
	input  logic        hart0_dcache_disable_init,
	input  logic        ahb_bus_clk_en           ,
	input  logic        hclk                     ,
	input  logic        hresetn                  ,
	input  logic [31:0] hrdata                   ,
	input  logic        hready                   ,
	input  logic [ 1:0] hresp                    ,
	output logic [31:0] haddr                    ,
    output logic        hsel                     ,
	output logic [ 2:0] hburst                   ,
	output logic [ 3:0] hprot                    ,
	output logic [ 2:0] hsize                    ,
	output logic [ 1:0] htrans                   ,
	output logic [31:0] hwdata                   ,
	output logic        hwrite
);

assign dbg_wakeup_req      = 'h0;
assign dbg_srst_req        = 'h0;
assign pin_tdi_out         = 'h0;
assign pin_tdi_out_en      = 'h0;
assign pin_tdo_out         = 'h0;
assign pin_tdo_out_en      = 'h0;
assign pin_tms_out         = 'h0;
assign pin_tms_out_en      = 'h0;
assign pin_trst_out        = 'h0;
assign pin_trst_out_en     = 'h0;
assign hart0_core_wfi_mode = 'h0;
assign haddr               = 'h0;
assign hburst              = 'h0;
assign hprot               = 'h0;
assign hsize               = 'h0;
assign htrans              = 'h0;
assign hwdata              = 'h0;
assign hwrite              = 'h0;
assign hsel                = 'h1;
endmodule
