`include "minsoc_bench_defines.v"
`include "minsoc_defines.v"
`include "or1200_defines.v"

module minsoc_bench();

reg clock, reset;

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

//UART wires
wire uart_stx;
reg uart_srx;

//ETH wires
reg eth_col;
reg eth_crs;
wire eth_trst;
reg eth_tx_clk;
wire eth_tx_en;
wire eth_tx_er;
wire [3:0] eth_txd;
reg eth_rx_clk;
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
integer initialize, final, ptr;
reg [8*64:0] file_name;
reg load_file;

initial begin
    reset = 1'b0;
    clock = 1'b0;

`ifndef NO_CLOCK_DIVISION
    minsoc_top_0.clk_adjust.clk_int = 1'b0;
    minsoc_top_0.clk_adjust.clock_divisor = 32'h0000_0000;
`endif
    
    uart_srx = 1'b1;
    
	eth_col = 1'b0;
	eth_crs = 1'b0;
	eth_fds_mdint = 1'b1;
	eth_rx_er = 1'b0;
	
	eth_tx_clk = 1'b0;
	eth_rx_clk = 1'b0;
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
			$display("ERROR: please specify an input file to start.");
			$finish;
		end
		$readmemh(file_name, program_mem);
		// First word comprehends size of program
		final = { program_mem[0] , program_mem[1] , program_mem[2] , program_mem[3] };
	end

`ifdef INITIALIZE_MEMORY_MODEL 
	// Initialize memory with firmware
	initialize = 0;
	while ( initialize < final ) begin
		minsoc_top_0.onchip_ram_top.block_ram_3.mem[initialize/4] = program_mem[initialize];
		minsoc_top_0.onchip_ram_top.block_ram_2.mem[initialize/4] = program_mem[initialize+1];
		minsoc_top_0.onchip_ram_top.block_ram_1.mem[initialize/4] = program_mem[initialize+2];
		minsoc_top_0.onchip_ram_top.block_ram_0.mem[initialize/4] = program_mem[initialize+3];
        initialize = initialize + 4;
	end
	$display("Memory model initialized with firmware:");
	$display("%s", file_name);
	$display("%d Bytes loaded from %d ...", initialize , final);
`endif

    // Reset controller
    repeat (2) @ (negedge clock);
    reset = 1'b1;
    repeat (16) @ (negedge clock);
    reset = 1'b0;

`ifdef START_UP
	// Pass firmware over spi to or1k_startup
	ptr = 0;
	//read dummy
	send_spi(program_mem[ptr]);
	send_spi(program_mem[ptr]);
	send_spi(program_mem[ptr]);
	send_spi(program_mem[ptr]);
	//~read dummy
	while ( ptr < final ) begin
		send_spi(program_mem[ptr]);
		ptr = ptr + 1;
	end
	$display("Memory start-up completed...");
	$display("Loaded firmware:");
	$display("%s", file_name);
`endif


	//
    // Testbench START
	//
	
    fork
        begin 
`ifdef ETHERNET            
            get_mac();
            
            if ( { eth_rx_data[ETH_HDR] , eth_rx_data[ETH_HDR+1] , eth_rx_data[ETH_HDR+2] , eth_rx_data[ETH_HDR+3] } == 32'hFF2B4050 )
                $display("eth-nocache firmware started.");
`endif
        end
        begin
	        #2000000;
`ifdef UART
            uart_send(8'h41);       //Character A
`endif	
`ifdef ETHERNET    
	        eth_tx_data[ETH_HDR+0] = 8'hBA;
	        eth_tx_data[ETH_HDR+1] = 8'h87;	
	        eth_tx_data[ETH_HDR+2] = 8'hAA;
	        eth_tx_data[ETH_HDR+3] = 8'hBB;	
	        eth_tx_data[ETH_HDR+4] = 8'hCC;
	        eth_tx_data[ETH_HDR+5] = 8'hDD;	

	        send_mac(6);
`endif        
        end
    join

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

`ifdef VPI_DEBUG
	dbg_comm_vpi dbg_if(
		.SYS_CLK(clock),
		.P_TMS(dbg_tms_i), 
		.P_TCK(dbg_tck_i), 
		.P_TRST(), 
		.P_TDI(dbg_tdi_i), 
		.P_TDO(dbg_tdo_o)
	);
`else
   assign dbg_tdi_i = 1;
   assign dbg_tck_i = 0;
   assign dbg_tms_i = 1;
`endif


//
//	Regular clocking and output
//
always begin
    #((`CLK_PERIOD)/2) clock <= ~clock;
end

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

//UART
`ifdef UART
localparam UART_TX_WAIT = (`FREQ_NUM_FOR_NS / `UART_BAUDRATE);

task uart_send;
    input [7:0] data;
    integer i;
    begin
        uart_srx = 1'b0;
	    #UART_TX_WAIT;
        for ( i = 0; i < 8 ; i = i + 1 ) begin
		    uart_srx = data[i];
		    #UART_TX_WAIT;
	    end        
        uart_srx = 1'b0;
	    #UART_TX_WAIT;
	    uart_srx = 1'b1;	    
    end
endtask

//UART Monitor (prints uart output on the terminal)
// Something to trigger the task
always @(posedge clock)
	uart_decoder;

task uart_decoder;
	integer i;
	reg [7:0] tx_byte;
	begin

	// Wait for start bit
	while (uart_stx == 1'b1)
		@(uart_stx);

	#(UART_TX_WAIT+(UART_TX_WAIT/2));

    for ( i = 0; i < 8 ; i = i + 1 ) begin
		tx_byte[i] = uart_stx;
		#UART_TX_WAIT;
	end

	//Check for stop bit
	if (uart_stx == 1'b0) begin
		  //$display("* WARNING: user stop bit not received when expected at time %d__", $time);
	  // Wait for return to idle
		while (uart_stx == 1'b0)
			@(uart_stx);
	  //$display("* USER UART returned to idle at time %d",$time);
	end
	// display the char
	$write("%c", tx_byte);
	end
endtask
//~UART Monitor
`endif // !UART
//~UART


//
//	TASKS to communicate with interfaces
//
//MAC_DATA
//
`ifdef ETHERNET
reg [31:0] crc32_result;

task get_mac;
    integer conta;
    reg LSB;
    begin
        conta = 0;
        LSB = 1;
        @ ( posedge eth_tx_en);
        
        repeat (16) @ (negedge eth_tx_clk);  //8 bytes, preamble (7 bytes) + start of frame (1 byte)
                
        while ( eth_tx_en == 1'b1 ) begin
            @ (negedge eth_tx_clk) begin
                if ( LSB == 1'b1 )
                    eth_rx_data[conta][3:0] = eth_txd;
                else begin
                    eth_rx_data[conta][7:4] = eth_txd;
                    conta = conta + 1;
                end
                LSB = ~LSB;
            end
        end
    end
endtask

task send_mac;              //only able to send up to 1536 bytes with header (14 bytes) and CRC (4 bytes)
    input [31:0] length;    //ETH_PAYLOAD_MAX_LENGTH 1518
    integer conta;
    begin
        if ( length <= ETH_PAYLOAD_MAX_LENGTH ) begin
            //DEST MAC
            eth_tx_data[0] = 8'h55;
            eth_tx_data[1] = 8'h47;
            eth_tx_data[2] = 8'h34;
            eth_tx_data[3] = 8'h22;
            eth_tx_data[4] = 8'h88;
            eth_tx_data[5] = 8'h92;

            //SOURCE MAC
            eth_tx_data[6] = 8'h3D;
            eth_tx_data[7] = 8'h4F;
            eth_tx_data[8] = 8'h1A;
            eth_tx_data[9] = 8'hBE;
            eth_tx_data[10] = 8'h68;
            eth_tx_data[11] = 8'h72;

            //LEN
            eth_tx_data[12] = length[7:4];
            eth_tx_data[13] = length[3:0];

            //DATA input by task caller

            //PAD
            for ( conta = length+14; conta < 60; conta = conta + 1 ) begin
                eth_tx_data[conta] = 8'h00;
            end

            gencrc32(conta);

            eth_tx_data[conta] = crc32_result[31:24];
            eth_tx_data[conta+1] = crc32_result[23:16];
            eth_tx_data[conta+2] = crc32_result[15:8];
            eth_tx_data[conta+3] = crc32_result[7:0];

            send_rx_packet( 64'h0055_5555_5555_5555, 4'h7, 8'hD5, 32'h0000_0000, conta+4, 1'b0 );
        end
        else
            $display("Warning: Ethernet packet is to big to be sent.");
    end

endtask

task send_rx_packet;
  input  [(8*8)-1:0] preamble_data; // preamble data to be sent - correct is 64'h0055_5555_5555_5555
  input   [3:0] preamble_len; // length of preamble in bytes - max is 4'h8, correct is 4'h7 
  input   [7:0] sfd_data; // SFD data to be sent - correct is 8'hD5
  input  [31:0] start_addr; // start address
  input  [31:0] len; // length of frame in Bytes (without preamble and SFD)
  input         plus_drible_nibble; // if length is longer for one nibble
  integer       rx_cnt;
  reg    [31:0] eth_tx_data_addr_in; // address for reading from RX memory       
  reg     [7:0] eth_tx_data_data_out; // data for reading from RX memory
begin
      @(posedge eth_rx_clk);
      #1 eth_rx_dv = 1;

      // set initial rx memory address
      eth_tx_data_addr_in = start_addr;
    
      // send preamble
      for (rx_cnt = 0; (rx_cnt < (preamble_len << 1)) && (rx_cnt < 16); rx_cnt = rx_cnt + 1)
      begin
        #1 eth_rxd = preamble_data[3:0];
        #1 preamble_data = preamble_data >> 4;
        @(posedge eth_rx_clk);
      end
    
      // send SFD
      for (rx_cnt = 0; rx_cnt < 2; rx_cnt = rx_cnt + 1)
      begin
        #1 eth_rxd = sfd_data[3:0];
        #1 sfd_data = sfd_data >> 4;
        @(posedge eth_rx_clk);
      end

      // send packet's addresses, type/length, data and FCS
      for (rx_cnt = 0; rx_cnt < len; rx_cnt = rx_cnt + 1)
      begin
        #1;
        eth_tx_data_data_out = eth_tx_data[eth_tx_data_addr_in[21:0]];
        eth_rxd = eth_tx_data_data_out[3:0];
        @(posedge eth_rx_clk);
        #1;
        eth_rxd = eth_tx_data_data_out[7:4];
        eth_tx_data_addr_in = eth_tx_data_addr_in + 1;
        @(posedge eth_rx_clk);
        #1;
      end
      if (plus_drible_nibble)
      begin
        eth_tx_data_data_out = eth_tx_data[eth_tx_data_addr_in[21:0]];
        eth_rxd = eth_tx_data_data_out[3:0];
        @(posedge eth_rx_clk);
      end

      #1 eth_rx_dv = 0;
      @(posedge eth_rx_clk);

end
endtask // send_rx_packet

//CRC32
localparam [31:0] CRC32_POLY = 32'h04C11DB7;

task gencrc32;
    input [31:0] crc32_length;

    integer	byte, bit;
    reg		msb;
    reg [7:0]	current_byte;
    reg [31:0]	temp;

    begin
        crc32_result = 32'hffffffff;
        for (byte = 0; byte < crc32_length; byte = byte + 1) begin
            current_byte = eth_tx_data[byte];
            for (bit = 0; bit < 8; bit = bit + 1) begin
                msb = crc32_result[31];
                crc32_result = crc32_result << 1;
                if (msb != current_byte[bit]) begin
                    crc32_result = crc32_result ^ CRC32_POLY;
                    crc32_result[0] = 1;
                end
            end
        end

        // Last step is to "mirror" every bit, swap the 4 bytes, and then complement each bit.
        //
        // Mirror:
        for (bit = 0; bit < 32; bit = bit + 1)
            temp[31-bit] = crc32_result[bit];

        // Swap and Complement:
        crc32_result = ~{temp[7:0], temp[15:8], temp[23:16], temp[31:24]};
    end
endtask
//~CRC32

//Generate tx and rx clocks
always begin
	#((`ETH_PHY_PERIOD)/2) eth_tx_clk <= ~eth_tx_clk;
end
always begin
	#((`ETH_PHY_PERIOD)/2) eth_rx_clk <= ~eth_rx_clk;	
end
//~Generate tx and rx clocks

`endif // !ETHERNET
//~MAC_DATA



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

