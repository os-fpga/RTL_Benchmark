`include "minsoc_bench_defines.v"
`include "minsoc_defines.v"
`include "or1200_defines.v"

`include "timescale.v"
`include "verilator_defines.v"

module minsoc_bench_core(
    clock,
    reset,
    eth_tx_clk,
    eth_rx_clk
);

input clock, reset, eth_tx_clk, eth_rx_clk;

//Debug interface
wire dbg_tms_i;
wire dbg_tck_i;
wire dbg_tdi_i;
wire dbg_tdo_o;
wire jtag_vref;
wire jtag_gnd;

//SPI wires
wire spi_mosi;
reg spi_miso;
wire spi_sclk;
wire [1:0] spi_ss;

//ETH wires
reg eth_col;
reg eth_crs;
wire eth_trst;
wire eth_tx_en;
wire eth_tx_er;
wire [3:0] eth_txd;
reg eth_rx_dv;
reg eth_rx_er;
reg [3:0] eth_rxd;
reg eth_fds_mdint;
wire eth_mdc;
wire eth_mdio;

//
//	TASKS registers to communicate with interfaces
//
`ifdef ETHERNET
reg [7:0] eth_rx_data [0:1535];		 //receive buffer ETH (max packet 1536)
reg [7:0] eth_tx_data [0:1535];     //send buffer ETH (max packet 1536)
localparam ETH_HDR = 14;
localparam ETH_PAYLOAD_MAX_LENGTH = 1518;//only able to send up to 1536 bytes with header (14 bytes) and CRC (4 bytes)
`endif


//
// Testbench mechanics
//
reg [7:0] program_mem[(1<<(`MEMORY_ADR_WIDTH+2))-1:0];
integer initialize, ptr;
reg [8*64:0] file_name;
integer      firmware_size;  // Note that the .hex file size is greater than this, as each byte in the file needs 2 hex characters.
integer      firmware_size_in_header;
reg load_file;

initial begin
`ifndef NO_CLOCK_DIVISION
    minsoc_top_0.clk_adjust.clk_int = 1'b0;
    minsoc_top_0.clk_adjust.clock_divisor = 32'h0000_0000;
`endif
    
	eth_col = 1'b0;
	eth_crs = 1'b0;
	eth_fds_mdint = 1'b1;
	eth_rx_er = 1'b0;
	eth_rxd = 4'h0;
	eth_rx_dv = 1'b0;
    

//dual and two port rams from FPGA memory instances have to be initialized to 0
    init_fpga_memory();

	load_file = 1'b0;
`ifdef INITIALIZE_MEMORY_MODEL 
	load_file = 1'b1;
`endif
`ifdef START_UP
	load_file = 1'b1;
`endif

	//get firmware hex file from command line input
	if ( load_file ) begin
		if ( ! $value$plusargs("file_name=%s", file_name) || file_name == 0 ) begin
			$display("ERROR: Please specify the name of the firmware file to load on start-up.");
			$finish;
		end

        // We are passing the firmware size separately as a command-line argument in order
        // to avoid this kind of Icarus Verilog warnings:
        //   WARNING: minsoc_bench_core.v:111: $readmemh: Standard inconsistency, following 1364-2005.
        //   WARNING: minsoc_bench_core.v:111: $readmemh(../../sw/uart/uart.hex): Not enough words in the file for the requested range [0:32767].
        // Apparently, some of the $readmemh() warnigns are even required by the standard. The trouble is,
        // Verilog's $fread() is not widely implemented in the simulators, so from Verilog alone
        // it's not easy to read the firmware file header without getting such warnings.
		if ( ! $value$plusargs("firmware_size=%d", firmware_size) ) begin
			$display("ERROR: Please specify the size of the firmware (in bytes) contained in the hex firmware file.");
			$finish;
		end

		$readmemh(file_name, program_mem, 0, firmware_size - 1);

		firmware_size_in_header = { program_mem[0] , program_mem[1] , program_mem[2] , program_mem[3] };

        if ( firmware_size != firmware_size_in_header ) begin
			$display("ERROR: The firmware size in the file header does not match the firmware size given as command-line argument. Did you forget bin2hex's -size_word flag when generating the firmware file?");
			$finish;
        end
       
	end

`ifdef INITIALIZE_MEMORY_MODEL 
	// Initialize memory with firmware
	initialize = 0;
	while ( initialize < firmware_size ) begin
		minsoc_top_0.onchip_ram_top.block_ram_3.mem[initialize/4] = program_mem[initialize];
		minsoc_top_0.onchip_ram_top.block_ram_2.mem[initialize/4] = program_mem[initialize+1];
		minsoc_top_0.onchip_ram_top.block_ram_1.mem[initialize/4] = program_mem[initialize+2];
		minsoc_top_0.onchip_ram_top.block_ram_0.mem[initialize/4] = program_mem[initialize+3];
        initialize = initialize + 4;
	end
	$display("Memory model initialized with firmware:");
	$display("%s", file_name);
	$display("%d Bytes loaded from %d ...", initialize , firmware_size);
`endif

`ifdef START_UP
	// Pass firmware over spi to or1k_startup
	ptr = 0;
	//read dummy
	send_spi(program_mem[ptr]);
	send_spi(program_mem[ptr]);
	send_spi(program_mem[ptr]);
	send_spi(program_mem[ptr]);
	//~read dummy
	while ( ptr < firmware_size ) begin
		send_spi(program_mem[ptr]);
		ptr = ptr + 1;
	end
	$display("Memory start-up completed...");
	$display("Loaded firmware:");
	$display("%s", file_name);
`endif
end


//
// Modules instantiations
//
minsoc_top minsoc_top_0(
   .clk(clock),
   .reset(reset)

   //JTAG ports
`ifdef GENERIC_TAP
   , .jtag_tdi(dbg_tdi_i),
   .jtag_tms(dbg_tms_i),
   .jtag_tck(dbg_tck_i),
   .jtag_tdo(dbg_tdo_o),
   .jtag_vref(jtag_vref),
   .jtag_gnd(jtag_gnd)
`endif

   //SPI ports
`ifdef START_UP
   , .spi_flash_mosi(spi_mosi), 
   .spi_flash_miso(spi_miso), 
   .spi_flash_sclk(spi_sclk), 
   .spi_flash_ss(spi_ss)
`endif

   //UART ports
`ifdef UART
   , .uart_stx(uart_stx),
   .uart_srx(uart_srx)
`endif // !UART

	// Ethernet ports
`ifdef ETHERNET
	, .eth_col(eth_col), 
    .eth_crs(eth_crs), 
    .eth_trste(eth_trst), 
    .eth_tx_clk(eth_tx_clk),
	.eth_tx_en(eth_tx_en), 
    .eth_tx_er(eth_tx_er), 
    .eth_txd(eth_txd), 
    .eth_rx_clk(eth_rx_clk),
	.eth_rx_dv(eth_rx_dv), 
    .eth_rx_er(eth_rx_er), 
    .eth_rxd(eth_rxd), 
    .eth_fds_mdint(eth_fds_mdint),
	.eth_mdc(eth_mdc), 
    .eth_mdio(eth_mdio)
`endif // !ETHERNET
);

`ifdef DPI_DEBUG
    jtag_dpi jtag_dpi_0
    (
        .system_clk( clock ),
        .jtag_tms_o( dbg_tms_i ),
        .jtag_tck_o( dbg_tck_i ),
        .jtag_trst_o(),  // TODO: JTAG reset signal not used yet
        .jtag_tdi_o( dbg_tdi_i ),
        .jtag_tdo_i( dbg_tdo_o )
    );
`else
   assign dbg_tdi_i = 1;
   assign dbg_tck_i = 0;
   assign dbg_tms_i = 1;
`endif


`ifdef VCD_OUTPUT
initial begin
	$dumpfile("../results/minsoc_wave.vcd");
	$dumpvars();
end
`endif


//
//	Functionalities tasks: SPI Startup and UART Monitor
//
//SPI START_UP
`ifdef START_UP
task send_spi;
    input [7:0] data_in;
    integer i;
    begin
	i = 7;
	for ( i = 7 ; i >= 0; i = i - 1 ) begin
        	spi_miso = data_in[i];
			@ (posedge spi_sclk);
	    end
    end
endtask
`endif
//~SPI START_UP


//
// TASK to initialize instantiated FPGA dual and two port memory to 0
//
task init_fpga_memory;
    integer i;
    begin
`ifdef OR1200_RFRAM_TWOPORT
`ifdef OR1200_XILINX_RAMB4
    for ( i = 0; i < (1<<8); i = i + 1 ) begin
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.ramb4_s16_s16_0.mem[i] = 16'h0000;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.ramb4_s16_s16_1.mem[i] = 16'h0000;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.ramb4_s16_s16_0.mem[i] = 16'h0000;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.ramb4_s16_s16_1.mem[i] = 16'h0000;
    end
`elsif OR1200_XILINX_RAMB16
    for ( i = 0; i < (1<<9); i = i + 1 ) begin
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.ramb16_s36_s36.mem[i] = 32'h0000_0000;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.ramb16_s36_s36.mem[i] = 32'h0000_0000;
    end
`elsif OR1200_ALTERA_LPM
`ifndef OR1200_ALTERA_LPM_XXX
    $display("Definition OR1200_ALTERA_LPM in or1200_defines.v does not enable ALTERA memory for neither DUAL nor TWO port RFRAM");
    $display("It uses GENERIC memory instead.");
    $display("Add '`define OR1200_ALTERA_LPM_XXX' under '`define OR1200_ALTERA_LPM' on or1200_defines.v to use ALTERA memory.");
`endif
`ifdef OR1200_ALTERA_LPM_XXX
    $display("...Using ALTERA memory for TWOPORT RFRAM!");
    for ( i = 0; i < (1<<5); i = i + 1 ) begin
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.altqpram_component.mem[i] = 32'h0000_0000;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.altqpram_component.mem[i] = 32'h0000_0000;
    end
`else
    $display("...Using GENERIC memory!");
    for ( i = 0; i < (1<<5); i = i + 1 ) begin
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.mem[i] = 32'h0000_0000;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.mem[i] = 32'h0000_0000;
    end
`endif
`elsif OR1200_XILINX_RAM32X1D
    $display("Definition OR1200_XILINX_RAM32X1D in or1200_defines.v does not enable FPGA memory for TWO port RFRAM");
    $display("It uses GENERIC memory instead.");
    $display("FPGA memory can be used if you choose OR1200_RFRAM_DUALPORT");
    for ( i = 0; i < (1<<5); i = i + 1 ) begin
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.mem[i] = 32'h0000_0000;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.mem[i] = 32'h0000_0000;
    end
`else
    for ( i = 0; i < (1<<5); i = i + 1 ) begin
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.mem[i] = 32'h0000_0000;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.mem[i] = 32'h0000_0000;
    end
`endif
`elsif OR1200_RFRAM_DUALPORT
`ifdef OR1200_XILINX_RAMB4
    for ( i = 0; i < (1<<8); i = i + 1 ) begin
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.ramb4_s16_0.mem[i] = 16'h0000;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.ramb4_s16_1.mem[i] = 16'h0000;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.ramb4_s16_0.mem[i] = 16'h0000;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.ramb4_s16_1.mem[i] = 16'h0000;
    end
`elsif OR1200_XILINX_RAMB16
    for ( i = 0; i < (1<<9); i = i + 1 ) begin
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.ramb16_s36_s36.mem[i] = 32'h0000_0000;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.ramb16_s36_s36.mem[i] = 32'h0000_0000;
    end
`elsif OR1200_ALTERA_LPM
`ifndef OR1200_ALTERA_LPM_XXX
    $display("Definition OR1200_ALTERA_LPM in or1200_defines.v does not enable ALTERA memory for neither DUAL nor TWO port RFRAM");
    $display("It uses GENERIC memory instead.");
    $display("Add '`define OR1200_ALTERA_LPM_XXX' under '`define OR1200_ALTERA_LPM' on or1200_defines.v to use ALTERA memory.");
`endif
`ifdef OR1200_ALTERA_LPM_XXX
    $display("...Using ALTERA memory for DUALPORT RFRAM!");
    for ( i = 0; i < (1<<5); i = i + 1 ) begin
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.altqpram_component.mem[i] = 32'h0000_0000;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.altqpram_component.mem[i] = 32'h0000_0000;
    end
`else
    $display("...Using GENERIC memory!");
    for ( i = 0; i < (1<<5); i = i + 1 ) begin
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.mem[i] = 32'h0000_0000;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.mem[i] = 32'h0000_0000;
    end
`endif
`elsif OR1200_XILINX_RAM32X1D
`ifdef OR1200_USE_RAM16X1D_FOR_RAM32X1D
    for ( i = 0; i < (1<<4); i = i + 1 ) begin
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_0.ram32x1d_0_0.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_0.ram32x1d_0_1.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_0.ram32x1d_0_2.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_0.ram32x1d_0_3.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_0.ram32x1d_0_4.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_0.ram32x1d_0_5.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_0.ram32x1d_0_6.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_0.ram32x1d_0_7.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_0.ram32x1d_1_0.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_0.ram32x1d_1_1.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_0.ram32x1d_1_2.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_0.ram32x1d_1_3.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_0.ram32x1d_1_4.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_0.ram32x1d_1_5.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_0.ram32x1d_1_6.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_0.ram32x1d_1_7.mem[i] = 1'b0;

        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_1.ram32x1d_0_0.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_1.ram32x1d_0_1.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_1.ram32x1d_0_2.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_1.ram32x1d_0_3.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_1.ram32x1d_0_4.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_1.ram32x1d_0_5.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_1.ram32x1d_0_6.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_1.ram32x1d_0_7.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_1.ram32x1d_1_0.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_1.ram32x1d_1_1.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_1.ram32x1d_1_2.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_1.ram32x1d_1_3.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_1.ram32x1d_1_4.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_1.ram32x1d_1_5.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_1.ram32x1d_1_6.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_1.ram32x1d_1_7.mem[i] = 1'b0;

        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_2.ram32x1d_0_0.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_2.ram32x1d_0_1.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_2.ram32x1d_0_2.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_2.ram32x1d_0_3.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_2.ram32x1d_0_4.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_2.ram32x1d_0_5.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_2.ram32x1d_0_6.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_2.ram32x1d_0_7.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_2.ram32x1d_1_0.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_2.ram32x1d_1_1.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_2.ram32x1d_1_2.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_2.ram32x1d_1_3.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_2.ram32x1d_1_4.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_2.ram32x1d_1_5.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_2.ram32x1d_1_6.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_2.ram32x1d_1_7.mem[i] = 1'b0;

        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_3.ram32x1d_0_0.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_3.ram32x1d_0_1.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_3.ram32x1d_0_2.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_3.ram32x1d_0_3.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_3.ram32x1d_0_4.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_3.ram32x1d_0_5.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_3.ram32x1d_0_6.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_3.ram32x1d_0_7.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_3.ram32x1d_1_0.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_3.ram32x1d_1_1.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_3.ram32x1d_1_2.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_3.ram32x1d_1_3.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_3.ram32x1d_1_4.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_3.ram32x1d_1_5.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_3.ram32x1d_1_6.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_3.ram32x1d_1_7.mem[i] = 1'b0;

        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_0.ram32x1d_0_0.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_0.ram32x1d_0_1.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_0.ram32x1d_0_2.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_0.ram32x1d_0_3.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_0.ram32x1d_0_4.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_0.ram32x1d_0_5.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_0.ram32x1d_0_6.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_0.ram32x1d_0_7.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_0.ram32x1d_1_0.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_0.ram32x1d_1_1.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_0.ram32x1d_1_2.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_0.ram32x1d_1_3.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_0.ram32x1d_1_4.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_0.ram32x1d_1_5.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_0.ram32x1d_1_6.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_0.ram32x1d_1_7.mem[i] = 1'b0;

        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_1.ram32x1d_0_0.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_1.ram32x1d_0_1.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_1.ram32x1d_0_2.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_1.ram32x1d_0_3.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_1.ram32x1d_0_4.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_1.ram32x1d_0_5.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_1.ram32x1d_0_6.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_1.ram32x1d_0_7.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_1.ram32x1d_1_0.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_1.ram32x1d_1_1.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_1.ram32x1d_1_2.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_1.ram32x1d_1_3.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_1.ram32x1d_1_4.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_1.ram32x1d_1_5.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_1.ram32x1d_1_6.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_1.ram32x1d_1_7.mem[i] = 1'b0;

        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_2.ram32x1d_0_0.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_2.ram32x1d_0_1.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_2.ram32x1d_0_2.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_2.ram32x1d_0_3.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_2.ram32x1d_0_4.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_2.ram32x1d_0_5.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_2.ram32x1d_0_6.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_2.ram32x1d_0_7.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_2.ram32x1d_1_0.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_2.ram32x1d_1_1.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_2.ram32x1d_1_2.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_2.ram32x1d_1_3.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_2.ram32x1d_1_4.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_2.ram32x1d_1_5.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_2.ram32x1d_1_6.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_2.ram32x1d_1_7.mem[i] = 1'b0;

        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_3.ram32x1d_0_0.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_3.ram32x1d_0_1.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_3.ram32x1d_0_2.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_3.ram32x1d_0_3.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_3.ram32x1d_0_4.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_3.ram32x1d_0_5.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_3.ram32x1d_0_6.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_3.ram32x1d_0_7.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_3.ram32x1d_1_0.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_3.ram32x1d_1_1.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_3.ram32x1d_1_2.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_3.ram32x1d_1_3.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_3.ram32x1d_1_4.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_3.ram32x1d_1_5.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_3.ram32x1d_1_6.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_3.ram32x1d_1_7.mem[i] = 1'b0;
    end
`else
    for ( i = 0; i < (1<<4); i = i + 1 ) begin
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_0.ram32x1d_0.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_0.ram32x1d_1.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_0.ram32x1d_2.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_0.ram32x1d_3.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_0.ram32x1d_4.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_0.ram32x1d_5.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_0.ram32x1d_6.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_0.ram32x1d_7.mem[i] = 1'b0;

        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_1.ram32x1d_0.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_1.ram32x1d_1.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_1.ram32x1d_2.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_1.ram32x1d_3.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_1.ram32x1d_4.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_1.ram32x1d_5.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_1.ram32x1d_6.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_1.ram32x1d_7.mem[i] = 1'b0;

        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_2.ram32x1d_0.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_2.ram32x1d_1.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_2.ram32x1d_2.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_2.ram32x1d_3.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_2.ram32x1d_4.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_2.ram32x1d_5.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_2.ram32x1d_6.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_2.ram32x1d_7.mem[i] = 1'b0;

        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_3.ram32x1d_0.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_3.ram32x1d_1.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_3.ram32x1d_2.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_3.ram32x1d_3.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_3.ram32x1d_4.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_3.ram32x1d_5.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_3.ram32x1d_6.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.xcv_ram32x8d_3.ram32x1d_7.mem[i] = 1'b0;

        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_0.ram32x1d_0.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_0.ram32x1d_1.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_0.ram32x1d_2.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_0.ram32x1d_3.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_0.ram32x1d_4.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_0.ram32x1d_5.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_0.ram32x1d_6.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_0.ram32x1d_7.mem[i] = 1'b0;

        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_1.ram32x1d_0.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_1.ram32x1d_1.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_1.ram32x1d_2.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_1.ram32x1d_3.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_1.ram32x1d_4.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_1.ram32x1d_5.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_1.ram32x1d_6.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_1.ram32x1d_7.mem[i] = 1'b0;

        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_2.ram32x1d_0.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_2.ram32x1d_1.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_2.ram32x1d_2.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_2.ram32x1d_3.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_2.ram32x1d_4.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_2.ram32x1d_5.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_2.ram32x1d_6.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_2.ram32x1d_7.mem[i] = 1'b0;

        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_3.ram32x1d_0.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_3.ram32x1d_1.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_3.ram32x1d_2.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_3.ram32x1d_3.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_3.ram32x1d_4.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_3.ram32x1d_5.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_3.ram32x1d_6.mem[i] = 1'b0;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.xcv_ram32x8d_3.ram32x1d_7.mem[i] = 1'b0;
    end
`endif
`else
    for ( i = 0; i < (1<<5); i = i + 1 ) begin
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_a.mem[i] = 32'h0000_0000;
        minsoc_top_0.or1200_top.or1200_cpu.or1200_rf.rf_b.mem[i] = 32'h0000_0000;
    end
`endif
`endif
    end
endtask

endmodule

