--
-- Cpu32BitC
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
--		cla;
--		ldai	#1Fh;		
--		sta	DATA_EXP;	-- 5 bit ENCODING => 5 bit DATA EXPANSION
--		ldai	#7FFFFFFh;
--		sta	tmp;		-- Init ext with FFFFFFFFh
		cla;
		sta	DATA_EXP;	
		ldai	#1;
		sta	tmp;
		shlni	#3;	-- * 8
		subsi	#8;
		adds	btmp;
		sknv;
		jmp	ovr;
		addsi	#2;
		jmp	init;
ovr:		jmp	ovr;

--		
--		Main Task
--
--		COMPUTE N!
--
		
init:		lda	tmp;
		mul	itmp;
		sta	tmp;
		lmuha;
		skz;
		jmp	end;		-- if result > 32 bit exit
		jms	inc;
		jmp 	init;
inc:		lda	itmp;
		addi	#2;
		sta	itmp;
		rts;
end:		jmp end;

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
htmp:		#0;
itmp:		#-2;
btmp:		#80000000h;

__reg;

org		BASE_EXT;

ext:		*SIZE_EXT;
