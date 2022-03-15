--
-- Cpu16Bit
--

__equ;

BASE_ISR		#3f8h;
BASE_ROM		#0h;
BASE_OA		#0;
BASE_RAM		#8h;
BASE_EXT		#200h;
SIZE_EXT		#200h;

INT_PAGE		#0;

__rom;

org		BASE_ROM;

--		
--		Init Parameters
--
		cla;
		ldai	#Fh;
		sta	DATA_EXP;
		ldai	#FFFh;
		sta	ext;		-- Init ext with FFFFh
		cla;
		sta	DATA_EXP;	
--		
--		Main Task
--
		
init:		lda	ext;
		add	tmp;
		addi	#5;
		sta	tmp;		-- Save it	
		jms	sub;
		jmp 	init;
sub:		lda	tmp;
		subi	#1;
		add	itmp;
		sta	tmp;
		sta	ext;
		rts;
--		
--		ISR routine
--		Check interrupts pending priority ordered
--

isr:		lda 	itmp;
		addi	#1;
		sta	itmp;
retint:	nop;
		rti;

org 		BASE_ISR;

		ldai 	ISTR_PAGE;
		sta 	ipg_int;
		ldai 	INT_PAGE;
		sta 	ISTR_PAGE; -- ISTR_PAGE needs 2 CLK before to be active => nop;
		nop;
		jmp 	isr; 

__ram;

org 		BASE_OA;

IND_ADD:	;	-- Indirect address
IND_REG:	;	-- Indirect register
IND_INC:	;	-- Indirect register increment
ISTR_PAGE:	;	-- Multi page istruction addressing
DATA_PAGE:	;	-- Multi page data addressing
DATA_EXP:	;	-- Data bus expansion

org 		BASE_RAM;

ipg_int:	;

tmp:		#0;
itmp:		#0;

__reg;

org		BASE_EXT;

ext:		*SIZE_EXT;
