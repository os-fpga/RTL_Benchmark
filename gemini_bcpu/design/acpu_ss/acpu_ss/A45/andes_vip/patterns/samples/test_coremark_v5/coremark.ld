ENTRY(_start)
SECTIONS
{
	PROVIDE(__TEXT_BASE = 0x0000000000000000);
	PROVIDE(__SPI_MEM_BASE = 0x0000000080000000);
	PROVIDE(__executable_start = __TEXT_BASE);

	. = __TEXT_BASE;		/* current location counter */
	.init :				/* allocate memory for a block */
	{
		*(.init)
	}
	. = ALIGN(4);

	.exec.itable    : { *(.exec.itable ) }

	.text :
	{ 
		*(.text .stub .text.* .gnu.linkonce.t.*) KEEP(*(.text.*personality*))
		*(.gnu.warning)
		. = ALIGN(8);
	}
	. = ALIGN(8);
	_etext = .;		/* assign the current location counter to variable _etext */
	PROVIDE (etext = .);

	PROVIDE(__DATA_BASE = 0x0000000000010000);
	. = __DATA_BASE;	/* let rodata section begin at __DATA_BASE */
	PROVIDE (.rodata = .);
	.rodata : AT (LOADADDR(.text) + SIZEOF(.text))
	{
		*(.rodata .*rodata.* .gnu.linkonce.r.* .eh_frame)
	}
	. = ALIGN(0x20);
	PROVIDE (rodata_end = .);
	PROVIDE (rodata_lma = LOADADDR(.rodata));

	.data :
	{
		PROVIDE (__data_start = .);
		*(.data .data.* .gnu.linkonce.d.*)
		KEEP(*(.gnu.linkonce.d.*personality*))
		SORT(CONSTRUCTORS)
		. = ALIGN(8);
	}
	. = ALIGN(8);
	PROVIDE(__data_lmastart =  LOADADDR (.data));

	.got :
	{
		*(.got.plt) *(.got)
	}
	. = ALIGN(8);

	PROVIDE (__global_pointer$ = . + 0x800);
	.sdata : { *(.sdata .sdata.* .gnu.linkonce.s.*) }
	.sdata_f : { *(.sdata_f .sdata_f.*) }
	.sdata_w : { *(.sdata_w .sdata_w.*) }
	.sdata_h : { *(.sdata_h .sdata_h.*) }
	.sdata_b : { *(.sdata_b .sdata_b.*) }
	. = ALIGN(8);
	PROVIDE (_edata = .);
	__bss_start = .;
	.sbss (NOLOAD) :
	{
		*(.sbss .sbss.*)
		*(.scommon .scommon.*)
	}
	.sbss_d (NOLOAD) :
	{
		 *(.sbss_d .sbss_d.* )
		*(.scommon_d .scommon_d.* )
	}
	.sbss_f (NOLOAD) :
	{
		*(.sbss_f .sbss_f.*)
		*(.scommon_f .scommon_f.*)
	}
	.sbss_w (NOLOAD) :
	{
		*(.sbss_w .sbss_w.*)
		*(.scommon_w .scommon_w.*)
		*(.dynsbss)
		*(.scommon)
	}
	.sbss_h (NOLOAD) :
	{
		*(.sbss_h .sbss_h.*)
		*(.scommon_h .scommon_h.*)
	}
	.sbss_b (NOLOAD) :
	{
		*(.sbss_b .sbss_b.*)
		*(.scommon_b .scommon_b.*)
	}
	. = ALIGN(4);
	PROVIDE (__sbss_end = .);
	PROVIDE (___sbss_end = .);
	.bss (NOLOAD) :
	{
		*(.dynbss)
		*(.bss .bss.* .gnu.linkonce.b.*)
		*(COMMON)
	}
	. = ALIGN(16);
	PROVIDE (_end = .);
	PROVIDE (__STACK_BASE = 0x18000);
	PROVIDE (_stack = __STACK_BASE);
	PROVIDE(__SHAREDATA_BASE = 0x20000);
	. = __SHAREDATA_BASE;
	.sharedata : AT (__SHAREDATA_BASE)
	{
		__sharedata_start = ADDR(.sharedata);
		*(.sharedata )
		__sharedata_end = .;
	}
	. = __SPI_MEM_BASE;
	.loader .       : AT (LOADADDR(.sbss) + SIZEOF(.sbss))
	{
		*(.loader)
		. = ALIGN(4);
	}
	.comment 0 : { *(.comment) }
}
ASSERT(_stack > _end, "stack OVERFLOW");
