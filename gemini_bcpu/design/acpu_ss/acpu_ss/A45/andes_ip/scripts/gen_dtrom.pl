#!/usr/bin/perl

# Script to generate device tree RAM data

my $NDS_HOME = $ENV{NDS_HOME};
my $platform     = "ae350";
my $core_cfg     = "config.inc";
my $platform_cfg = "ae350_config.vh";
my $board        = "orca";

my $dts_file     = "$platform.dts";
my $dtc_cmd      = "dtc";
my $data_file    = "sample_dtrom.data";

unlink($data_file);

our $address_size = 64;
our $size_size = 64;

while (my $arg = shift @ARGV) {
	if ($arg =~ /^-+platform(=(.+))?$/) {
		$platform = ($2 or (shift @ARGV));
	}
	elsif ($arg =~ /^-+c(ore_)?cfg(=(.+))?$/) {
		$core_cfg = ($3 or (shift @ARGV));
	}
	elsif ($arg =~ /^-+p(latform_)?cfg(=(.+))?$/) {
		$platform_cfg = ($3 or (shift @ARGV));
	}
	elsif ($arg =~ m/^-+b(oard)?(=(.+))?$/) {
		$board = ($3 or (shift @ARGV));
		print "Borad argument is $board";
	}
	print "arg = $arg\n";
}

#---------------------------------
# Parse Configurations
#---------------------------------
my $PLATFORM            = uc $platform;
my $cpu_config_def      = parse_config($core_cfg);
my $platform_config_def = parse_config($platform_cfg);

my $atcbmc300_config_file        = "$NDS_HOME/andes_ip/$platform/define/atcbmc300_config.vh";
my $atcapbbrg100_config_file     = "$NDS_HOME/andes_ip/$platform/define/atcapbbrg100_config.vh";
my $atcbusdec200_config_file     = "$NDS_HOME/andes_ip/$platform/define/atcbusdec200_config.vh";
my $atcbusdec200_rom_config_file = "$NDS_HOME/andes_ip/$platform/define/atcbusdec200_rom_config.vh";
my $kv_bmc_config_file           = "$NDS_HOME/andes_ip/$platform/define/atcbmc301_config.vh";
my $kv_busdec_config_file        = "$NDS_HOME/andes_ip/$platform/define/atcbusdec301_config.vh";

my $ae350_chip_file              = "$NDS_HOME/andes_ip/$platform/top/hdl/ae350_chip.v";
my $ae350_aopd_file              = "$NDS_HOME/andes_ip/$platform/top/hdl/ae350_aopd.v";

my $atcbmc300_map        = parse_brg_addr_config(undef, $atcbmc300_config_file);
my $atcapbbrg100_map     = parse_brg_addr_config(undef, $atcapbbrg100_config_file);
my $atcbusdec200_map     = parse_brg_addr_config(undef, $atcbusdec200_config_file);
my $atcbusdec200_rom_map = parse_brg_addr_config(undef, $atcbusdec200_rom_config_file);
my $kv_bmc_map           = parse_brg_addr_config(undef, $kv_bmc_config_file);
my $kv_busdec_map        = parse_brg_addr_config(undef, $kv_busdec_config_file);

my $l2c_reg_base;
if ($cpu_config_def->{"NDS_L2C_CACHE_SIZE_KB"} ne "0") {
	$l2c_reg_base = $cpu_config_def->{"NDS_L2C_REG_BASE"};
	$l2c_reg_base =~ s/^\d+\'h//;
	$l2c_reg_base =~ s/_//g;
	$l2c_reg_base = hex($l2c_reg_base);
}

my $ddr_size = 0x0;
if ($board eq 'vcu118') {
	$ddr_size= 0x80000000;
} else {
	$ddr_size= 0x40000000;
}

# ----- sanity check
# internal mux for PLIC/PLMT/PLDM ----
if (!defined($kv_bmc_map->{slave1})) {
	printf "ERROR: no slave1 defined in $kv_bmc_config_file\n";
	exit(1);
}
if (!defined($kv_busdec_map->{slave1})) {
	printf "ERROR: no slave1 (PLIC) defined in $kv_busdec_config_file\n";
	exit(1);
}
if (!defined($kv_busdec_map->{slave2})) {
	printf "ERROR: no slave2 (PLMT) defined in $kv_busdec_config_file\n";
	exit(1);
}
if (!defined($kv_busdec_map->{slave3})) {
	printf "ERROR: no slave3 (PLIC_SW) defined in $kv_busdec_config_file\n";
	exit(1);
}

# external mux for AHB address space ----
if (!defined($atcbmc300_map->{slave1})) {
	printf "ERROR: no slave1 (AHB space) defined in $atcbmc300_config_file\n";
	exit(1);
}
if (!defined($atcbmc300_map->{slave2})) {
	printf "ERROR: no slave2 (memory) defined in $atcbmc300_config_file\n";
	exit(1);
}
if (!defined($atcbusdec200_map->{slave2})) {
	printf "ERROR: no slave1 (APB space) defined in $atcbusdec200_config_file\n";
	exit(1);
}
if (!defined($atcapbbrg100_map->{slave1})) {
	printf "ERROR: no slave1 (SMU) defined in $atcapbbrg100_config_file\n";
	exit(1);
}



my $platform_map;
$platform_map->{"l2"}      = $l2c_reg_base;
$platform_map->{"plic0"}   = $kv_bmc_map->{slave1} + $kv_busdec_map->{slave1};
$platform_map->{"plmt"}    = $kv_bmc_map->{slave1} + $kv_busdec_map->{slave2};
$platform_map->{"plic1"}   = $kv_bmc_map->{slave1} + $kv_busdec_map->{slave3};
$platform_map->{"ahbc"}    = $atcbmc300_map->{slave1};
$platform_map->{"memory"}  = $atcbmc300_map->{slave2};
# ahb
$platform_map->{"apbbrg"}  = $platform_map->{"ahbc"} + $atcbusdec200_map->{slave1};
$platform_map->{"smc0"}    = $platform_map->{"ahbc"} + $atcbusdec200_map->{slave2};
$platform_map->{"lcd0"}    = $platform_map->{"ahbc"} + $atcbusdec200_map->{slave3};
$platform_map->{"mac0"}    = $platform_map->{"ahbc"} + $atcbusdec200_map->{slave4};
$platform_map->{"nor"}     = $atcbusdec200_rom_map->{slave2};
# apb
$platform_map->{"smu"}     = $platform_map->{"apbbrg"} + $atcapbbrg100_map->{slave1};
$platform_map->{"serial0"} = $platform_map->{"apbbrg"} + $atcapbbrg100_map->{slave3};
$platform_map->{"timer0"}  = $platform_map->{"apbbrg"} + $atcapbbrg100_map->{slave4};
$platform_map->{"wdt"}     = $platform_map->{"apbbrg"} + $atcapbbrg100_map->{slave5};
$platform_map->{"rtc"}     = $platform_map->{"apbbrg"} + $atcapbbrg100_map->{slave6};
$platform_map->{"gpio"}    = $platform_map->{"apbbrg"} + $atcapbbrg100_map->{slave7};
$platform_map->{"i2c"}     = $platform_map->{"apbbrg"} + $atcapbbrg100_map->{slave8};
$platform_map->{"spi"}     = $platform_map->{"apbbrg"} + $atcapbbrg100_map->{slave9};
$platform_map->{"mmc0"}    = $platform_map->{"apbbrg"} + $atcapbbrg100_map->{slave11};
$platform_map->{"dma0"}    = $platform_map->{"apbbrg"} + $atcapbbrg100_map->{slave12};
$platform_map->{"snd0"}    = $platform_map->{"apbbrg"} + $atcapbbrg100_map->{slave13};

my $irq_table = parse_interrupt_num($ae350_aopd_file);

my @isa = (is_rv64($cpu_config_def) ? "rv64" : "rv32");
push(@isa, "i", "2.0",
	   "m", "2.0",
	   "a", "2.0",
);

if ($cpu_config_def->{"NDS_FPU_TYPE"} eq "sp") {
	push(@isa, ("f", "2.0"));
}
if ($cpu_config_def->{"NDS_FPU_TYPE"} eq "dp") {
	push(@isa, ("f", "2.0"));
	push(@isa, ("d", "2.0"));
}

push(@isa, "c", "2.0");

if ($cpu_config_def->{"NDS_RVV_SUPPORT"} eq "yes") {
	push(@isa, ("v", "0.7.2"));
}

push(@isa, "xv5-", "1.1");
if ($cpu_config_def->{"NDS_DSP_SUPPORT"} eq "yes") {
	push(@isa, "xdsp", "0.0");
}
	
my $cpu_name       = is_rv64($cpu_config_def) ? "ax45": "a45";
my $isa_str        = join("", @isa);
$isa_str =~ s/\./p/g;

my $mmu_scheme     = $cpu_config_def->{"NDS_MMU_SCHEME"};
my $nhart          = $cpu_config_def->{"NDS_NHART"};
my $icache_size    = $cpu_config_def->{"NDS_ICACHE_SIZE_KB"} * 1024;
my $dcache_size    = $cpu_config_def->{"NDS_DCACHE_SIZE_KB"} * 1024;
my $l2_size        = $cpu_config_def->{"NDS_L2C_CACHE_SIZE_KB"} * 1024;
my $cacheline_size = $cpu_config_def->{"NDS_CACHE_LINE_SIZE"};
my $icache_sets    = $icache_size / $cpu_config_def->{"NDS_ICACHE_WAY"} / $cacheline_size;
my $dcache_sets    = $dcache_size / $cpu_config_def->{"NDS_DCACHE_WAY"} / $cacheline_size;
my $coherent_dma =  $cpu_config_def->{"NDS_IOCP_NUM"} gt "0";
my $lcd_on_coherent_port = 1;
my $cpu_frequency = 60*1000000; # 60MHz
my $timer0_frequency = 60*1000000; # 60MHz
my $apb_frequency = 60*1000000; # 60MHz

$nhart ||= 1;
#---------------------------------
# Generate DTS file
#---------------------------------

write_dts($dts_file);

sub write_dts {
	my ($dts_file) = @_;
	my $fh;
	if (!open($fh, ">", $dts_file)) {
		printf "ERROR: unable to write to file: %s\n", $dts_file;
		exit(1);
	}

	my $indent = "";
	print $fh "$indent/dts-v1/;\n";
	print $fh "$indent\n";
	print $fh "$indent/ {\n";

	write_dts_top_level($fh, "$indent\t");

	print $fh "$indent};\n";

	close($fh);
}

sub write_dts_top_level {
	my ($fh, $indent) = @_;
	print $fh qq|${indent}#address-cells = <2>;\n|;
	print $fh qq|${indent}#size-cells = <2>;\n|;
	print $fh qq|${indent}compatible = "andestech,$platform";\n|;
	print $fh qq|${indent}model = "andestech,$cpu_name";\n|;
	print $fh qq|${indent}aliases {\n|;
		if (exists $platform_config_def->{"${PLATFORM}_UART2_SUPPORT"}) {
			print $fh qq|${indent}	uart0 = &serial0;\n|;
		}
		if (exists $platform_config_def->{"${PLATFORM}_SPI1_SUPPORT"}) {
			print $fh qq|${indent}	spi0 = &spi;\n|;
		}
	print $fh qq|${indent}};\n|;
	print $fh qq|\n|;
	print $fh qq|${indent}chosen {\n|;
	print $fh qq|${indent}	bootargs = "console=ttyS0,38400n8 debug loglevel=7 earlycon=sbi";\n|;
	print $fh qq|${indent}	stdout-path = "uart0:38400n8";\n|;
	print $fh qq|${indent}};\n|;

	print $fh qq|${indent}cpus {\n|;
	
	write_dts_cpus($fh, "$indent\t");
	print $fh qq|${indent}};|;
	print $fh qq|\n|;

	if ($cpu_config_def->{"NDS_L2C_CACHE_SIZE_KB"} ne "0") {
		write_dts_l2($fh, $indent);
	}

	write_dts_dev($fh, $indent, 1, {
		"driver" => "memory",
		"addr" => $platform_map->{"memory"},
		"size" => $ddr_size,
		"device_type" => "memory",
	});

	print $fh qq|${indent}soc {\n|;
	write_dts_soc($fh, "\t$indent");
	print $fh qq|${indent}};\n|;
}

sub write_dts_cpus {
	my ($fh, $indent) = @_;

	print $fh qq|${indent}#address-cells = <1>;\n|;
 	print $fh qq|${indent}#size-cells = <0>;\n|;
 	print $fh qq|${indent}timebase-frequency = <$cpu_frequency>;\n|;

	foreach my $hart_id (0..($nhart-1)) {
		print $fh qq|${indent}CPU$hart_id: cpu\@$hart_id {\n|;
		write_dts_cpu($fh, "$indent\t", $hart_id);
		print $fh qq|${indent}};\n|;
	}
}

sub write_dts_cpu {
	my ($fh, $indent, $hart_id) = @_;
	print  $fh qq|${indent}device_type = "cpu";\n|;
	print  $fh qq|${indent}reg = <$hart_id>;\n|;
	print  $fh qq|${indent}status = "okay";\n|;
	print  $fh qq|${indent}compatible = "riscv";\n|;
	print  $fh qq|${indent}riscv,isa = "$isa_str";\n|;
	print  $fh qq|${indent}riscv,priv-major = <1>;\n|;
	print  $fh qq|${indent}riscv,priv-minor = <10>;\n|;
	print  $fh qq|${indent}mmu-type = "riscv,$mmu_scheme";\n|;
	print  $fh qq|${indent}clock-frequency = <$cpu_frequency>;\n|;
	printf $fh qq|${indent}i-cache-size = <0x%x>;\n|, $icache_size;
	print  $fh qq|${indent}i-cache-sets = <$icache_sets>;\n|;
	print  $fh qq|${indent}i-cache-line-size = <$cacheline_size>;\n|;
	print  $fh qq|${indent}i-cache-block-size = <$cacheline_size>;\n|;
	printf $fh qq|${indent}d-cache-size = <0x%x>;\n|, $dcache_size;
	print  $fh qq|${indent}d-cache-sets = <$dcache_sets>;\n|;
	print  $fh qq|${indent}d-cache-line-size = <$cacheline_size>;\n|;
	print  $fh qq|${indent}d-cache-block-size = <$cacheline_size>;\n|;
	if ($cpu_config_def->{"NDS_L2C_CACHE_SIZE_KB"} ne "0") {
		print $fh qq|${indent}next-level-cache = <&L2>;\n|;
	}
	print $fh qq|${indent}CPU${hart_id}_intc: interrupt-controller {\n|;
        print $fh qq|${indent}	#interrupt-cells = <1>;\n|;
        print $fh qq|${indent}	interrupt-controller;\n|;
        print $fh qq|${indent}	compatible = "riscv,cpu-intc";\n|;
	print $fh qq|${indent}};\n|;
}


sub write_dts_l2 {
	my ($fh, $indent) = @_;

	my $addr = $platform_map->{"l2"};
	my $size = 0x10000; # 0x0 .. 0x2f8
	my $addr_high = $addr >> 32;
	my $addr_low = $addr & 0xffffffff;
	my $size_high = $size >> 32;
	my $size_low = $size & 0xffffffff;

	printf  $fh qq|${indent}L2: l2-cache@%x {\n|, $addr;
	print  $fh qq|${indent}	compatible = "cache";\n|;
	print  $fh qq|${indent}	cache-level = <2>;\n|;
	printf $fh qq|${indent}	cache-size = <0x%x>;\n|, $l2_size;
	printf $fh qq|${indent}	reg = <0x%08x 0x%08x 0x%08x 0x%08x>;\n|, $addr_high, $addr_low, $size_high, $size_low;
	print  $fh qq|${indent}	andes,inst-prefetch = <3>;\n|;
	print  $fh qq|${indent}	andes,data-prefetch = <3>;\n|;
	print  $fh qq|${indent}	// The value format is <XRAMOCTL XRAMICTL>\n|;
	print  $fh qq|${indent}	andes,tag-ram-ctl = <0 0>;\n|;
	print  $fh qq|${indent}	andes,data-ram-ctl = <0 0>;\n|;
	print  $fh qq|${indent}};\n|;
}

sub write_dts_soc {
	my ($fh, $indent) = @_;
	print $fh qq|${indent}#address-cells = <2>;\n|;
	print $fh qq|${indent}#size-cells = <2>;\n|;
	print $fh qq|${indent}compatible = "andestech,riscv-$platform-soc", "simple-bus";\n|;
	print $fh qq|${indent}ranges;\n|;

	write_dts_dev($fh, $indent, 1, {
		"name" => "plic0",
		"driver" => "interrupt-controller",
		"addr" => $platform_map->{"plic0"},
		"size" => 0x2000000,
		"compatible" => "riscv,plic0",
		"#address-cells" => 2,
		"#interrupt-cells" => 2,
		"interrupts-extended" => [11, 9],
		"riscv,ndev" => 71,
	});

	write_dts_dev($fh, $indent, 1, {
		"name" => "plic1",
		"driver" => "interrupt-controller",
		"addr" => $platform_map->{"plic1"},
		"size" => 0x400000,
		"compatible" => "riscv,plic1",
		"#address-cells" => 2,
		"#interrupt-cells" => 2,
		"interrupts-extended" => 3,
		"riscv,ndev" => $nhart,
	});
	write_dts_dev($fh, $indent, 1, {
		"name" => "plmt0",
		"driver" => "plmt0",
		"addr" => $platform_map->{"plmt"},
		"size" => 0x100000,
		"compatible" => "riscv,plmt0",
		"interrupts-extended" => 7,
	});

	write_dts_dev($fh, $indent, 1, {
		"name" => "spiclk",
		"driver" => "virt_100mhz",
		"#clock-cells" => 0,
		"compatible" => "fixed-clock",
		"clock-frequency" => 100000000,
	});

	write_dts_dev($fh, $indent, $platform_config_def->{"${PLATFORM}_PIT_SUPPORT"}, {
		"name" => "timer0",
		"driver" => "timer",
		"addr" => $platform_map->{"timer0"},
		"size" => 0x1000,
		"compatible" => "andestech,atcpit100",
		"interrupts" => $irq_table->{"pit_intr"},
		"clock-frequency" => $timer0_frequency,
		"interrupt-parent" => "&plic0",
	});
	write_dts_dev($fh, $indent, $platform_config_def->{"${PLATFORM}_PIT_SUPPORT"}, {
		"name" => "pwm",
		"driver" => "pwm",
		"addr" => $platform_map->{"timer0"},
		"size" => 0x1000,
		"compatible" => "andestech,atcpit100-pwm",
		"interrupts" => $irq_table->{"pit_intr"},
		"clock-frequency" => $timer0_frequency,
		"interrupt-parent" => "&plic0",
		"pwm-cells" => 2,
	});

	write_dts_dev($fh, $indent, $platform_config_def->{"${PLATFORM}_WDT_SUPPORT"}, {
		"name" => "wdt",
		"driver" => "wdt",
		"addr" => $platform_map->{"wdt"},
		"size" => 0x1000,
		"compatible" => "andestech,atcwdt200",
		"interrupts" => $irq_table->{"pit_intr"},
		"clock-frequency" => $apb_frequency,
		"interrupt-parent" => "&plic0",
	});

	write_dts_dev($fh, $indent, $platform_config_def->{"${PLATFORM}_UART2_SUPPORT"}, {
		"name" => "serial0",
		"driver" => "serial",
		"addr" => $platform_map->{"serial0"},
		"size" => 0x1000,
		"compatible" => ["andestech,uart16550", "ns16550a"],
		"interrupts" => $irq_table->{"uart2_int"},
		"clock-frequency" => 19660800,
		"current-speed" => 38400,
		"reg-shift" => 2,
		"reg-offset" => 32,
		"reg-io-width" => 4,
		"no-loopback-test" => 1,
		"interrupt-parent" => "&plic0",
	});

	write_dts_dev($fh, $indent, $platform_config_def->{"${PLATFORM}_RTC_SUPPORT"}, {
		"name" => "rtc0",
		"driver" => "rtc",
		"addr" => $platform_map->{"rtc"},
		"size" => 0x1000,
		"compatible" => "andestech,atcrtc100",
		"interrupts" => [1, 2], # period & alarm
		"wakeup-source" => "",
		"interrupt-parent" => "&plic0",
	});

	write_dts_dev($fh, $indent, $platform_config_def->{"${PLATFORM}_GPIO_SUPPORT"}, {
		"name" => "gpio",
		"driver" => "gpio",
		"addr" => $platform_map->{"gpio"},
		"size" => 0x1000,
		"compatible" => "andestech,atcgpio100",
		"interrupts" => $irq_table->{"gpio_intr"},
		"wakeup-source" => "",
		"interrupt-parent" => "&plic0",
	});

	write_dts_dev($fh, $indent, $platform_config_def->{"${PLATFORM}_I2C_SUPPORT"}, {
		"name" => "i2c",
		"driver" => "i2c",
		"addr" => $platform_map->{"i2c"},
		"size" => 0x1000,
		"compatible" => "andestech,atciic100",
		"interrupts" => $irq_table->{"i2c_int"},
		"wakeup-source" => "",
		"interrupt-parent" => "&plic0",
	});

	write_dts_dev($fh, $indent, $platform_config_def->{"${PLATFORM}_MAC_SUPPORT"}, {
		"name" => "mac0",
		"driver" => "mac",
		"addr" => $platform_map->{"mac0"},
		"size" => 0x1000,
		"compatible" => "andestech,atmac100",
		"interrupts" => $irq_table->{"mac_int"},
		"interrupt-parent" => "&plic0",
		"dma-coherent" => $coherent_dma,
	});
		
	write_dts_dev($fh, $indent, 1, {
		"name" => "smu",
		"driver" => "smu",
		"addr" => $platform_map->{"smu"},
		"size" => 0x1000,
		"compatible" => "andestech,atcsmu",
	});

	write_dts_dev($fh, $indent, $platform_config_def->{"${PLATFORM}_SDC_SUPPORT"}, {
		"name" => "mmc0",
		"driver" => "mmc",
		"addr" => $platform_map->{"mmc0"},
		"size" => 0x1000,
		"compatible" => "andestech,atfsdc010g",
		"interrupts" => $irq_table->{"sdc_int"},
		"interrupt-parent" => "&plic0",
		"max-frequency" => 100000000,
		"clock-freq-min-max" => [400000, 100000000],
		"fifo-depth" => 0x10,
		"dmas" => "&dma0 9",
		"dma-names" => "rxtx",
		"dma-coherent" => $coherent_dma,
	});
		
	write_dts_dev($fh, $indent, $platform_config_def->{"${PLATFORM}_DMA_SUPPORT"}, {
		"name" => "dma0",
		"driver" => "dma",
		"addr" => $platform_map->{"dma0"},
		"size" => 0x1000,
		"compatible" => "andestech,atcdmac300g",
		"interrupts" => [$irq_table->{"dma_int"}],
		"interrupt-parent" => "&plic0",
		"dma-channels" => 8,
		"#dma-cells" => 1,
		"dma-coherent" => $coherent_dma,
	});
	write_dts_dev($fh, $indent, $platform_config_def->{"${PLATFORM}_LCDC_SUPPORT"}, {
		"name" => "lcd0",
		"driver" => "lcd",
		"addr" => $platform_map->{"lcd0"},
		"size" => 0x1000,
		"compatible" => "andestech,atflcdc100",
		"interrupts" => $irq_table->{"lcd_intr"},
		"interrupt-parent" => "&plic0",
		"dma-coherent" => ($coherent_dma && $lcd_on_coherent_port),
	});
	write_dts_dev($fh, $indent, $platform_config_def->{"${PLATFORM}_SMC_SUPPORT"}, {
		"name" => "smc0",
		"driver" => "smc",
		"addr" => $platform_map->{"smc0"},
		"size" => 0x1000,
		"compatible" => "andestech,atfsmc020",
	});
	write_dts_dev($fh, $indent, $platform_config_def->{"${PLATFORM}_SMC_SUPPORT"}, {
		"name" => "nor",
		"driver" => "nor",
		"addr" => $platform_map->{"nor"},
		"size" => 0x1000,
		"compatible" => "cfi-flash",
		"bank-width" => 2,
		"device-width" => 2,
	});
	write_dts_dev($fh, $indent, $platform_config_def->{"${PLATFORM}_SSP_SUPPORT"}, {
		"name" => "snd0",
		"driver" => "snd",
		"addr" => $platform_map->{"snd0"},
		"size" => 0x1000,
		"compatible" => "andestech,atfac97",
		"interrupts" => $irq_table->{"ssp_intr"},
		"interrupt-parent" => "&plic0",
		"dma-coherent" => $coherent_dma,
	});
	write_dts_dev($fh, $indent, 1, {
		"name" => "pmu",
		"driver" => "pmu",
		"compatible" => "riscv,andes-pmu",
		"device_type" => "pmu",
	});
	write_dts_dev($fh, $indent, $platform_config_def->{"${PLATFORM}_SPI1_SUPPORT"}, {
		"name" => "spi",
		"driver" => "spi",
		"addr" => $platform_map->{"spi"},
		"size" => 0x1000,
		"compatible" => "andestech,atcspi200",
		"#address-cells" => 1,
		"#size-cells" => 0,
		"num-cs" => "1",
		"clocks" => "&spiclk",
		"interrupts" => $irq_table->{"spi1_int"},
		"interrupt-parent" => "&plic0",
		"child" => sub {
			write_dts_dev($fh, "\t$indent", 1, {
				"driver" => "flash",
				"unit_addr" => 0,
				"compatible" => "jedec,spi-nor",
				"spi-max-frequency" => 50000000,
				"addr" => 0,
				"spi-cpol" => "",
				"spi-cpha" => "",
			});
		},

	});
}

# write out these formats:
# key;					if value is an empty string
# key = "string1", "string2", ... ;     if values are strings (except starting with &)
# key = <number1 number2 ...>;		if values are numbers or start with &
sub write_dts_cell_val {
	my ($fh, $indent, $hash, $key, $force_string) = @_;
	my $val = consume_entry($hash, $key);
	return if !defined($val);
	my $val_type = 'num';
	my $quote_begin = "<";
	my $quote_sep = " ";
	my $quote_end = ">";
	my $val_format = "%d";

	my $v0 = $val;
	if (ref($v0)) {
		$v0 = $val->[0];
	}

	if ($v0 =~ m/^&/) {
		$val_format = '%s';
	} elsif ($v0 !~ m/^\d/) {
		$quote_begin = '"';
		$quote_end = '"';
		$quote_sep = '", "';
		$val_format = '%s';
	}
			
	printf $fh qq|${indent}\t$key|;
	if ($val eq "") { # $val will not be a ref here.
		printf $fh qq|;\n|;
		return;
	}
	printf $fh qq| = ${quote_begin}|;

	my @val;
	if (ref($val)) {
		push(@val, @$val);
	} else {
		push(@val, $val);
	}
	my $sep = '';
	foreach my $v (@val) {
		printf $fh $sep;
		printf $fh qq|${val_format}|, $v;
		$sep = $quote_sep;
	}
	printf $fh qq|$quote_end;\n|;
}

sub write_dts_cell_attr {
	my ($fh, $indent, $hash, $key) = @_;
	my $val = consume_entry($hash, $key);
	return if !defined($val);

	printf $fh qq|${indent}\t$key;\n|;
}

sub consume_entry {
	my ($hash, $key) = @_;
	my $val = $hash->{$key};
	delete $hash->{$key};
	return $val;
}

sub peek_entry {
	my ($hash, $key) = @_;
	my $val = $hash->{$key};
	return $val;
}

sub write_dts_dev {
	my ($fh, $indent, $cond, $hash) = @_;

	if (!defined($cond)) {
		return;
	}

	my $name = consume_entry($hash, "name");
	my $driver = consume_entry($hash, "driver");
	my $unit_addr = consume_entry($hash, "unit_addr");
	my $addr = consume_entry($hash, "addr");
	my $size = consume_entry($hash, "size");
	my $interrupts = consume_entry($hash, "interrupts");
	my $interrupts_extended = consume_entry($hash, "interrupts-extended");
	my $interrupt_controller = $driver eq "interrupt-controller";
	my $address_cells = peek_entry($hash, "#address-cells");
	my $size_cells = peek_entry($hash, "#size-cells");
	my $pwm_cells = peek_entry($hash, "pwm-cells");
	
	# begin $indent$name: $driver@addr
	print $fh $indent;
	if (defined($name)) {
		print $fh qq|$name: |;
	}
	print $fh $driver;
	if (defined($unit_addr)) {
		printf $fh qq|@%s|, $unit_addr;
	} elsif (defined($addr)) {
		printf $fh qq|@%x|, $addr;
	}
	# end $indent$name: $driver@addr

	print $fh qq| {\n|;

	write_dts_cell_val($fh, $indent, $hash, "compatible");

	if (defined($addr)) {
		my $addr_high = $addr >> 32;
		my $addr_low = $addr & 0xffffffff;
		my $size_high = $size >> 32;
		my $size_low = $size & 0xffffffff;
		if ($size_size > 0) {
			if ($address_size == 64) {
				printf $fh qq|${indent}\treg = <0x%08x 0x%08x 0x%08x 0x%08x>;\n|, $addr_high, $addr_low, $size_high, $size_low;
			} else {
				printf $fh qq|${indent}\treg = <0x%08x 0x%08x>;\n|, $addr_low, $size_low;
			}
		} else {
			if ($address_size == 64) {
				printf $fh qq|${indent}\treg = <0x%08x 0x%08x>;\n|, $addr_high, $addr_lo;
			} else {
				printf $fh qq|${indent}\treg = <0x%08x>;\n|, $addr_lo;
			}
		}
	}
	if (defined($interrupts)) {
		my $flag = consume_entry($hash, "trigger");
		$flag ||= 4; # active-high, level trigger

		my @ints;
		if (ref($interrupts)) {
			foreach my $i (@$interrupts) {
				push(@ints, $i, $flag);
			}
		} else {
			push(@ints, $interrupts, $flag);
		}
		printf $fh qq|${indent}\tinterrupts = <%s>;\n|, join(" ", @ints);
	}
	if (defined($interrupts_extended)) {
		print $fh qq|${indent}\tinterrupts-extended = <|;
		foreach my $hart_id (0..($nhart-1)) {
			my @ints;
			if (ref($interrupts_extended)) {
				push(@ints, @$interrupts_extended);
			} else {
				push(@ints, $interrupts_extended);
			}
			foreach my $i (@ints) {
				print $fh " &CPU${hart_id}_intc $i";
			}
		}
		print $fh qq|>;\n|;
	}
	write_dts_cell_val($fh, $indent, $hash, "interrupt-parent");
	if ($interrupt_controller) {
		print $fh qq|${indent}\tinterrupt-controller;\n|;
	}
	write_dts_cell_val($fh, $indent, $hash, "#address-cells");
	write_dts_cell_val($fh, $indent, $hash, "#size-cells");
	write_dts_cell_val($fh, $indent, $hash, "#clock-cells");
	write_dts_cell_val($fh, $indent, $hash, "#interrupt-cells");
	write_dts_cell_val($fh, $indent, $hash, "clock-frequency");
	write_dts_cell_val($fh, $indent, $hash, "clock-freq-min-max");
	write_dts_cell_val($fh, $indent, $hash, "max-frequency");
	write_dts_cell_val($fh, $indent, $hash, "spi-max-frequency");
	write_dts_cell_val($fh, $indent, $hash, "fifo-depth");
	write_dts_cell_val($fh, $indent, $hash, "reg-shift");
	write_dts_cell_val($fh, $indent, $hash, "reg-offset");
	write_dts_cell_val($fh, $indent, $hash, "no-loopback-test");
	write_dts_cell_val($fh, $indent, $hash, "dma-channels");
	write_dts_cell_val($fh, $indent, $hash, "bank-width");
	write_dts_cell_val($fh, $indent, $hash, "device-width");
	write_dts_cell_val($fh, $indent, $hash, "riscv,ndev");
	write_dts_cell_val($fh, $indent, $hash, "num-cs");
	write_dts_cell_val($fh, $indent, $hash, "device_type");

	write_dts_cell_val($fh, $indent, $hash, "cap-sd-highspeed");
	write_dts_cell_val($fh, $indent, $hash, "wakeup-source");
	write_dts_cell_val($fh, $indent, $hash, "spi-cpol");
	write_dts_cell_val($fh, $indent, $hash, "spi-cpha");
	write_dts_cell_val($fh, $indent, $hash, "clocks");
	write_dts_cell_val($fh, $indent, $hash, "pwm-cells");

	my $dma_coherent = consume_entry($hash, "dma-coherent");
	if ($dma_coherent) {
		print $fh qq|${indent}dma-coherent;\n|;
	}

	foreach my $key (keys %$hash) {
		next if ($key eq "child");

		my $name_or_driver = $name;
		$name_or_driver ||= $driver;

		printf "WARNING: %s: previously unknown keyword: \"%s\"\n", $name_or_driver, $key;
		write_dts_cell_val($fh, $indent, $hash, $key);
	}

	my $child = consume_entry($hash, "child");
	if (defined($child)) {
		my $orig_address_size = $address_size;
		my $orig_size_size = $size_size;
		if (defined($address_cells)) {
			# set address_size after reg statement is printed.
			$address_size = $address_cells > 1 ? 64 : 32;
		}
		if (defined($size_cells)) {
			# set size_size after reg statement is printed.
			$size_size = $size_cells > 1 ? 64 : ($size_cells == 1 ? 32 : 0);
		}

		my @array;
		if (ref($child) eq 'ARRAY') {
			push(@array, @{$child});
		} else {
			push(@array, $child);
		}
		foreach my $sub (@array) {
			$sub->($fh, $indent);
		}
		$address_size = $orig_address_size;
		$size_size = $orig_size_size;
	}
	print $fh qq|${indent}};\n|;
}

#---------------------------------
# Generate RAM initial file
#---------------------------------
my $dtc_path = `which $dtc_cmd`;
if (!defined $dtc_path or $dtc_path eq "") {
	printf "ERROR: $dtc_cmd is not in PATH\n";
	exit(1);
}

printf "$dtc_cmd $dts_file | hexdump -v -e '\"%08x\\n\"' > $data_file\n";
system("$dtc_cmd $dts_file | hexdump -v -e '\"%08x\n\"' > $data_file");

exit(0);

#---------------------------------
# Functions
#---------------------------------
# parse configuration
sub parse_config {
	my ($file) = @_;
	my $fh;
	my $line;
	my $config_def;

	if (!open($fh, "<", $file)) {
		printf "ERROR: unable to read file: %s\n", $file;
		exit(1);
	}

	while ($line = <$fh>) {
		next if ($line =~ m/^\s*\/\//); # comment line

		chomp($line);
		if ($line =~ m/^\s*`define\s+(\w+)\s+(\S*)\s*$/) {
			$config_def->{$1} = $2;
			$config_def->{$1} =~ s/"//g;
		}
		elsif ($line =~ m/^\s*`define\s+(\w+)\s*$/) {
			$config_def->{$1} = 1;
		}
	}

	close($fh);

	return $config_def;
}

# parse bridge config for memory mapping
sub parse_brg_addr_config {
	my ($prefix, $file) = @_;
	my $fh;
	my $line;
	my $map;

	if (!defined($prefix)) {
		$prefix = $file;
		$prefix =~ s/.*\///;
		$prefix =~ s/_config.vh$//;
	}

	$prefix = uc $prefix;

	if (open($fh, "<", $file)) {
		printf "Info: parse config file: %s\n", $file;
	} else {
                # Cannot open configuration file
                return $map;
        }

	while ($line = <$fh>) {
		next if ($line =~ m/^\s*\/\//); # comment line

		# ATCBMC300
		if ($line =~ m/${prefix}_SLV(\d+)_BASE_ADDR\s+[^'\s]*'h([0-9a-fA-F_]+)/) {
			$map->{"slave$1"} = hex($2);
		}
		if ($line =~ m/${prefix}_AHB_SLV(\d+)_BASE\s+[^'\s]*'h([0-9a-fA-F_]+)/) {
			$map->{"slave$1"} = hex($2);
		}

		# others
		if ($line =~ m/${prefix}_SLV(\d+)_OFFSET\s+[^'\s]*'h([0-9a-fA-F_]+)/) {
			$map->{"slave$1"} = hex($2);
		}
	}

	close($fh);

	return $map;
}

# parse interrupt number
sub parse_interrupt_num {
	my ($file) = @_;
	my $fh;
	my $line;
	my $hash;

	if (!open($fh, "<", $file)) {
		printf "ERROR: unable to read file: %s\n", $file;
		exit(1);
	}

	while ($line = <$fh>) {
		next if ($line =~ m/^\s*\/\//); # comment line

		if ($line =~ m/assign\s+int_src\[(\d+)\]\s+=\s+(\w+);/) {
			my ($bit, $src) = ($1, $2);
			next if $src =~ m/'/; # 1'b0;
			$hash->{$src} = $bit;
			next;
		}
	}

	close($fh);

	return $hash;
}

sub is_rv64 {
	my ($cpu_config_def) = @_;
	my $is_rv64 = 0;
	$is_rv64 = 1 if ($cpu_config_def->{"NDS_ISA_BASE"} =~ m/64/);
	return $is_rv64;
}


