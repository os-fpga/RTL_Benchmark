OUTPUT_ARCH( "riscv" )

SECTIONS
{
	PROVIDE(__TEXT_BASE = 0x0000000000000000);
	PROVIDE(__SPI_MEM_BASE = 0x0000000080000000);
	PROVIDE(__executable_start = __TEXT_BASE);

	. = __TEXT_BASE;
	.text.init : { *(.text.init) }
	.tohost : ALIGN(0x1000) { *(.tohost) }
	.text : ALIGN(0x1000) { *(.text) }
	.data : ALIGN(0x1000) { *(.data) }
	__global_pointer$ = . + 0x800;
	.bss : { *(.bss) }
	_end = .;
	. = __SPI_MEM_BASE;
	.loader . : AT(LOADADDR(.bss)) { *(.loader) . = ALIGN(4); }
}

