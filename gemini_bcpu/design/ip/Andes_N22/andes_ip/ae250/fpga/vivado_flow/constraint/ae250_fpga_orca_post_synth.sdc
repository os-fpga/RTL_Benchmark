# ============================
if {[llength [get_pins -quiet u_spi*/u_spi_reg/spi_r_clk_inferred_i_*/O]]} {
	# Vivado has difficulties at deciding the clock edge used so let's guide it.
	if {$spi_mode_0 == $spi_mode_1} {
		set_clock_sense -positive [get_pins u_spi*/u_spi_reg/spi_r_clk_inferred_i_*/O]
	} else {
		set_clock_sense -negative [get_pins u_spi*/u_spi_reg/spi_r_clk_inferred_i_*/O]
	}
}

# ====================
# Pin Assignments
# ====================

set_property	PACKAGE_PIN	U22	[get_ports X_hw_rstn]
set_property	PACKAGE_PIN	G24	[get_ports X_oschin]
set_property	PACKAGE_PIN	H17	[get_ports X_osclin]
set_property	PACKAGE_PIN	U21	[get_ports X_por_b]
set_property	PACKAGE_PIN	D9	[get_ports X_wakeup_in]


# Use AICE_CON1 with 1.8/3.3V:
set jtag_con2	0
if {$platform == "ae250"} {
	set bank16_iostandard	LVCMOS18
} else {	# ae350
	set bank16_iostandard	LVCMOS33
}

# Use AICE_CON2 with 1.8V
# jtag_con2 = 1
# set bank16_iostandard	LVCMOS18

# Use AICE_CON2 with 2.5V
# jtag_con2 = 1
# set bank16_iostandard	LVCMOS25


if {$jtag_con2} {
	set jtag_iostandard	$bank16_iostandard
} else {
	set jtag_iostandard	LVCMOS33
}

if {$jtag_con2} {
	set_property	PACKAGE_PIN		G11	[get_ports X_tck]
	set_property	PACKAGE_PIN		H9	[get_ports X_tms]
	if {!$jtag_twowire} {
		set_property	PACKAGE_PIN	H8	[get_ports X_tdo]
		set_property	PACKAGE_PIN	G10	[get_ports X_tdi]
		set_property	PACKAGE_PIN	J13	[get_ports X_trst]
	}
} else {
	set_property	PACKAGE_PIN		Y22	[get_ports X_tck]
	set_property	PACKAGE_PIN		AA24	[get_ports X_tms]
	if {!$jtag_twowire} {
		set_property	PACKAGE_PIN	AA22	[get_ports X_tdo]
		set_property	PACKAGE_PIN	AC23	[get_ports X_tdi]
		set_property	PACKAGE_PIN	W20	[get_ports X_trst]
	}
}

if {$i2c1_support} {
	set_property	PACKAGE_PIN		M25	[get_ports X_i2c_scl]
	set_property	PACKAGE_PIN		L25	[get_ports X_i2c_sda]
}

set_property	PACKAGE_PIN			AC6	[get_ports X_spi1_mosi]
set_property	PACKAGE_PIN			AC4	[get_ports X_spi1_miso]
set_property	PACKAGE_PIN			AA5	[get_ports X_spi1_clk]
set_property	PACKAGE_PIN			Y5	[get_ports X_spi1_csn]
set_property	PACKAGE_PIN			AB6	[get_ports X_spi1_holdn]
set_property	PACKAGE_PIN			AB5	[get_ports X_spi1_wpn]

if {$spi2_support} {
	# IDE_CON1.36
	set_property	PACKAGE_PIN		H14	[get_ports X_spi2_mosi]
	# IDE_CON1.38
	set_property	PACKAGE_PIN		C14	[get_ports X_spi2_miso]
	# IDE_CON1.35
	set_property	PACKAGE_PIN		J11	[get_ports X_spi2_clk]
	# IDE_CON1.37
	set_property	PACKAGE_PIN		E12	[get_ports X_spi2_csn]
	# IDE_CON1.33
	set_property	PACKAGE_PIN		J10	[get_ports X_spi2_holdn]
	# IDE_CON1.34
	set_property	PACKAGE_PIN		H12	[get_ports X_spi2_wpn]
}

if {$uart1_support} {
	# To RS-232 S2
	set_property	PACKAGE_PIN		G25	[get_ports X_uart1_rxd]
	# To RS-232 S2
	set_property	PACKAGE_PIN		D25	[get_ports X_uart1_txd]
}

if {$uart2_support} {
	# To RS-232 S1
	set_property	PACKAGE_PIN		R18	[get_ports X_uart2_rxd]
	# To RS-232 S1
	set_property	PACKAGE_PIN		T17	[get_ports X_uart2_txd]
}

# IDE_CON1.1
set_property	PACKAGE_PIN			A15	[get_ports X_pwm_ch0]
# IDE_CON1.3
set_property	PACKAGE_PIN			C12	[get_ports X_pwm_ch1]
# IDE_CON1.5
set_property	PACKAGE_PIN			D10	[get_ports X_pwm_ch2]
# IDE_CON1.7
set_property	PACKAGE_PIN			E10	[get_ports X_pwm_ch3]
set_property	PACKAGE_PIN			E21	[get_ports {X_gpio[0]}]
set_property	PACKAGE_PIN			F24	[get_ports {X_gpio[1]}]
set_property	PACKAGE_PIN			J21	[get_ports {X_gpio[2]}]
set_property	PACKAGE_PIN			L23	[get_ports {X_gpio[3]}]
set_property	PACKAGE_PIN			A13	[get_ports {X_gpio[4]}]
set_property	PACKAGE_PIN			A12	[get_ports {X_gpio[5]}]
set_property	PACKAGE_PIN			J14	[get_ports {X_gpio[6]}]
set_property	PACKAGE_PIN			C11	[get_ports {X_gpio[7]}]
set_property	PACKAGE_PIN			E11	[get_ports {X_gpio[8]}]
set_property	PACKAGE_PIN			D11	[get_ports {X_gpio[9]}]
set_property	PACKAGE_PIN			F14	[get_ports {X_gpio[10]}]
set_property	PACKAGE_PIN			F13	[get_ports {X_gpio[11]}]
set_property	PACKAGE_PIN			G12	[get_ports {X_gpio[12]}]
set_property	PACKAGE_PIN			F12	[get_ports {X_gpio[13]}]
set_property	PACKAGE_PIN			D14	[get_ports {X_gpio[14]}]
set_property	PACKAGE_PIN			J8	[get_ports {X_gpio[15]}]
set_property	PACKAGE_PIN			V26	[get_ports {X_gpio[16]}]
set_property	PACKAGE_PIN			W25	[get_ports {X_gpio[17]}]
set_property	PACKAGE_PIN			W26	[get_ports {X_gpio[18]}]
set_property	PACKAGE_PIN			V21	[get_ports {X_gpio[19]}]
set_property	PACKAGE_PIN			W21	[get_ports {X_gpio[20]}]
set_property	PACKAGE_PIN			AA25	[get_ports {X_gpio[21]}]
set_property	PACKAGE_PIN			AB25	[get_ports {X_gpio[22]}]
set_property	PACKAGE_PIN			W23	[get_ports {X_gpio[23]}]
set_property	PACKAGE_PIN			W24	[get_ports {X_gpio[24]}]
set_property	PACKAGE_PIN			AB26	[get_ports {X_gpio[25]}]
set_property	PACKAGE_PIN			AC26	[get_ports {X_gpio[26]}]
set_property	PACKAGE_PIN			Y25	[get_ports {X_gpio[27]}]
set_property	PACKAGE_PIN			Y26	[get_ports {X_gpio[28]}]
set_property	PACKAGE_PIN			AD21	[get_ports {X_gpio[29]}]
set_property	PACKAGE_PIN			AD23	[get_ports {X_gpio[30]}]
set_property	PACKAGE_PIN			AB24	[get_ports {X_gpio[31]}]
# I/O standard
set_property		SLEW		FAST		[get_ports X_tms]
if {!$jtag_twowire} {
	set_property	SLEW		FAST		[get_ports X_tdo]
	set_property	DRIVE		16		[get_ports X_tdo]
}

set_property	IOSTANDARD	LVCMOS33		[get_ports X_hw_rstn]
set_property	IOSTANDARD	LVCMOS33		[get_ports X_osch*]
set_property	IOSTANDARD	LVCMOS33		[get_ports X_oscl*]
set_property	IOSTANDARD	LVCMOS33		[get_ports X_por_b]
set_property	IOSTANDARD	$bank16_iostandard	[get_ports X_wakeup_in]

set_property	IOSTANDARD	$jtag_iostandard	[get_ports X_tck]
set_property	IOSTANDARD	$jtag_iostandard	[get_ports X_tms]

if {!$jtag_twowire} {
	set_property	IOSTANDARD $jtag_iostandard	[get_ports X_trst]
	set_property	IOSTANDARD $jtag_iostandard	[get_ports X_tdi]
	set_property	IOSTANDARD $jtag_iostandard	[get_ports X_tdo]
}

if {$i2c1_support} {
	set_property	IOSTANDARD	LVCMOS33	[get_ports X_i2c_*]
}

set_property	IOSTANDARD		LVCMOS18	[get_ports X_spi1_*]

if {$spi2_support} {
	set_property	IOSTANDARD $bank16_iostandard	[get_ports X_spi2_*]
}

if {$uart_support} {
	set_property	IOSTANDARD	LVCMOS33	[get_ports X_uart*]
}

set_property	IOSTANDARD	$bank16_iostandard	[get_ports X_pwm*]

set_property	IOSTANDARD	LVCMOS33		[get_ports {X_gpio[0]}]
set_property	IOSTANDARD	LVCMOS33		[get_ports {X_gpio[1]}]
set_property	IOSTANDARD	LVCMOS33		[get_ports {X_gpio[2]}]
set_property	IOSTANDARD	LVCMOS33		[get_ports {X_gpio[3]}]

set_property	IOSTANDARD	$bank16_iostandard	[get_ports {X_gpio[4]}]
set_property	IOSTANDARD	$bank16_iostandard	[get_ports {X_gpio[5]}]
set_property	IOSTANDARD	$bank16_iostandard	[get_ports {X_gpio[6]}]
set_property	IOSTANDARD	$bank16_iostandard	[get_ports {X_gpio[7]}]
set_property	IOSTANDARD	$bank16_iostandard	[get_ports {X_gpio[8]}]
set_property	IOSTANDARD	$bank16_iostandard	[get_ports {X_gpio[9]}]
set_property	IOSTANDARD	$bank16_iostandard	[get_ports {X_gpio[10]}]
set_property	IOSTANDARD	$bank16_iostandard	[get_ports {X_gpio[11]}]
set_property	IOSTANDARD	$bank16_iostandard	[get_ports {X_gpio[12]}]
set_property	IOSTANDARD	$bank16_iostandard	[get_ports {X_gpio[13]}]
set_property	IOSTANDARD	$bank16_iostandard	[get_ports {X_gpio[14]}]
set_property	IOSTANDARD	$bank16_iostandard	[get_ports {X_gpio[15]}]

set_property	IOSTANDARD	LVCMOS33		[get_ports {X_gpio[16]}]
set_property	IOSTANDARD	LVCMOS33		[get_ports {X_gpio[17]}]
set_property	IOSTANDARD	LVCMOS33		[get_ports {X_gpio[18]}]
set_property	IOSTANDARD	LVCMOS33		[get_ports {X_gpio[19]}]
set_property	IOSTANDARD	LVCMOS33		[get_ports {X_gpio[20]}]
set_property	IOSTANDARD	LVCMOS33		[get_ports {X_gpio[21]}]
set_property	IOSTANDARD	LVCMOS33		[get_ports {X_gpio[22]}]
set_property	IOSTANDARD	LVCMOS33		[get_ports {X_gpio[23]}]
set_property	IOSTANDARD	LVCMOS33		[get_ports {X_gpio[24]}]
set_property	IOSTANDARD	LVCMOS33		[get_ports {X_gpio[25]}]
set_property	IOSTANDARD	LVCMOS33		[get_ports {X_gpio[26]}]
set_property	IOSTANDARD	LVCMOS33		[get_ports {X_gpio[27]}]
set_property	IOSTANDARD	LVCMOS33		[get_ports {X_gpio[28]}]
set_property	IOSTANDARD	LVCMOS33		[get_ports {X_gpio[29]}]
set_property	IOSTANDARD	LVCMOS33		[get_ports {X_gpio[30]}]
set_property	IOSTANDARD	LVCMOS33		[get_ports {X_gpio[31]}]

set_property	IOSTANDARD	LVCMOS33		[get_ports X_mpd_pwr_off]
set_property	IOSTANDARD	LVCMOS33		[get_ports X_rtc_wakeup]
# ====================
# Attributes
# ====================

set_property		PULLDOWN	true	[get_ports X_hw_rstn]
set_property		PULLDOWN	true	[get_ports X_por_b]

if {!$jtag_twowire} {
	set_property	PULLUP		true	[get_ports X_tdo]
}

if {$uart1_support} {
	set_property	PULLDOWN	true	[get_ports X_uart1_txd]
	set_property	PULLDOWN	true	[get_ports X_uart1_rxd]
}

if {$uart2_support} {
	set_property	PULLDOWN	true	[get_ports X_uart2_txd]
	set_property	PULLDOWN	true	[get_ports X_uart2_rxd]
}

set_property		PULLUP		true	[get_ports {X_gpio[*]}]
# # Ram style
# define_global_attribute			syn_ramstyle		block_ram

# # Automatically insert a BUFG primitive on high fanout nets
# define_global_attribute			syn_auto_insert_bufg	1

