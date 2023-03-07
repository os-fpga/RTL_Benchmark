
`ifdef PLATFORM_XMR_VH
`else
`define PLATFORM_XMR_VH

`define NDS_BENCH_TOP		system
`define NDS_BENCH		`NDS_BENCH_TOP.ae350_tb
`define NDS_CHIP_TOP		`NDS_BENCH_TOP.ae350_chip

`define NDS_PLATFORM_CHIP	`NDS_CHIP_TOP
`define NDS_CHIP_AOPD		`NDS_CHIP_TOP.ae350_aopd
`define NDS_PLATFORM_CORE	`NDS_PLATFORM_CHIP

`define NDS_PLATFORM_CLKGEN	`NDS_CHIP_AOPD.sample_ae350_clkgen
`define NDS_SMU			`NDS_CHIP_AOPD.sample_ae350_smu
`define NDS_RAM			`NDS_PLATFORM_CORE.ae350_ram_subsystem.u_sram.ram_inst.mem
`ifdef  NDS_CPU_SUBSYSTEM
`else
		`define NDS_CPU_SUBSYSTEM	`NDS_PLATFORM_CORE.ae350_cpu_subsystem

`endif


`define NDS_AHBDEC		`NDS_PLATFORM_CORE.ae350_ahb_subsystem.u_hbmc



`define NDS_JTAG_HOST		`NDS_BENCH_TOP.jtag_host
`define NDS_SIM_CONTROL		`NDS_BENCH_TOP.sim_control
`define NDS_I2C_MASTER		`NDS_BENCH_TOP.i2c_master
`define NDS_GPIO_MODEL		`NDS_BENCH_TOP.gpio_slv
`define NDS_PWM_MODEL		`NDS_BENCH_TOP.pwm_model
`define	NDS_APB_SUBSYSTEM	`NDS_PLATFORM_CHIP.ae350_apb_subsystem

	`define NDS_BMC			`NDS_PLATFORM_CORE.ae350_bus_connector.u_axi_bmc
`define NDS_APB_DECODER		`NDS_PLATFORM_CORE.ds_ahb2apb
`define NDS_GPIO		`NDS_APB_SUBSYSTEM.u_gpio
`define NDS_UART1		`NDS_APB_SUBSYSTEM.u_uart1
`define NDS_UART2		`NDS_APB_SUBSYSTEM.u_uart2
`define NDS_SPI1		`NDS_APB_SUBSYSTEM.u_spi1
`define NDS_SPI2		`NDS_APB_SUBSYSTEM.u_spi2
`define NDS_PIT			`NDS_APB_SUBSYSTEM.u_pit
`define NDS_WDT			`NDS_APB_SUBSYSTEM.u_wdt

`define NDS_PLDM                `NDS_CPU_SUBSYSTEM.u_pldm

`define SPI_FLASH_DATA		`NDS_BENCH_TOP.spi_flash1.Mem


`define END_SIM_EVENT		`NDS_SIM_CONTROL.event_finish

`define NDS_DEBUG_HCLK		busclk

`define NDS_DEBUG_HRESETN	dmi_resetn
`define NDS_DEBUG_HADDR		dmi_haddr
`define NDS_DEBUG_HTRANS	dmi_htrans
`define NDS_DEBUG_HWRITE	dmi_hwrite
`define NDS_DEBUG_HSIZE		dmi_hsize
`define NDS_DEBUG_HBURST	dmi_hburst
`define NDS_DEBUG_HPROT		dmi_hprot
`define NDS_DEBUG_HWDATA	dmi_hwdata
`define NDS_DEBUG_HRDATA	dmi_hrdata
`define NDS_DEBUG_HREADY	dmi_hreadyout
`define NDS_DEBUG_HRESP		dmi_hresp

`endif
