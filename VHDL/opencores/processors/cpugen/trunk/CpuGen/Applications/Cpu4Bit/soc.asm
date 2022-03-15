--
-- Cpu4Bit
--

__equ;

BASE_ROM		#0h;
BASE_OA		#0;
BASE_RAM		#8h;
BASE_REG		#10h;

ROM_PAGE0		#0h;
ROM_PAGE1		#40h;
ROM_PAGE2		#80h;
ROM_PAGE3		#c0h;

ROM_NUM0		#0h;
ROM_NUM1		#1h;
ROM_NUM2		#2h;
ROM_NUM3		#3h;

ONE			#1;

PWM_DISABLE		#0;
PWM_ENABLE		#1;

PWMPL_INI		#0;
PWMPH_INI		#1;
PWMLL_INI		#2;
PWMLH_INI		#0;

THR1_PWM		#2h;
THR2_PWM		#4h;
THR3_PWM		#6h;
THR4_PWM		#8h;

PWMLL1		#2h;
PWMLL2		#6h;
PWMLL3		#ah;
PWMLL4		#eh;

__rom;


org		BASE_ROM;

--		
--		Init Parameters
--

		ldai	ROM_NUM1;
		sta	ISTR_PAGE;
		nop;			-- NOTE:ISTR_PAGE and DATA_PAGE become valide two clock after update   
		jms	init;
		ldai	ROM_NUM0;
		sta	ISTR_PAGE;
--		
--		Main Task
--
		
start:	ldai	ROM_NUM2;
		sta	ISTR_PAGE;
		ldai	PWMLH_INI;	
		sta	PWMLH;
		lda 	CTRL;		-- Read reg
		subi	THR1_PWM;	-- check thresold 1
		sknc;
		jmp	set_pwm1;
		lda 	CTRL;		-- Read reg
		subi	THR2_PWM;	-- check thresold 2
		sknc;
		jmp	set_pwm2;
		lda 	CTRL;		-- Read reg
		subi	THR3_PWM;	-- check thresold 3
		sknc;
		jmp	set_pwm3;
		lda 	CTRL;		-- Read reg
		subi	THR4_PWM;	-- check thresold 4
		sknc;
		jmp	set_pwm4;
		jmp 	start;

org		ROM_PAGE1;

init:		ldai	PWM_DISABLE;
		sta	CTRL;
		ldai	PWMPH_INI;	
		sta	PWMPH;
		ldai	PWMPL_INI;	
		sta	PWMPL;
		ldai	PWMLH_INI;	
		sta	PWMLH;
		ldai	PWMLL_INI;	
		sta	PWMLL;
		ldai	PWM_ENABLE;
		sta	CTRL;
		rts;

org		ROM_PAGE2;

set_pwm1:	ldai	PWMLL1;
		sta	PWMLL;
		ldai	#1;
		shl;
		addi	PWM_ENABLE;
		sta	CTRL;
		jmp	ret_start;

set_pwm2:	ldai	PWMLL2;
		sta	PWMLL;
		ldai	#2;
		shl;
		addi	PWM_ENABLE;
		sta	CTRL;
		jmp	ret_start;

set_pwm3:	ldai	PWMLL3;
		sta	PWMLL;
		ldai	#3;
		shl;
		addi	PWM_ENABLE;
		sta	CTRL;
		jmp	ret_start;

set_pwm4:	ldai	PWMLL4;
		sta	PWMLL;
		ldai	#4;
		shl;
		addi	PWM_ENABLE;
		sta	CTRL;
		jmp	ret_start;

ret_start:  lda	ROM_NUM0;
		sta	ISTR_PAGE;
		nop;			-- NOTE:ISTR_PAGE and DATA_PAGE become valide two clock after update   
		jmp	start;

__ram;

org 		BASE_OA;

IND_ADD:	;	-- Indirect address
IND_REG:	;	-- Indirect register
IND_INC:	;	-- Indirect register increment
ISTR_PAGE:	;	-- Multi page istruction addressing
DATA_PAGE:	;	-- Multi page data addressing
DATA_EXP:	;	-- Data bus expansion

org 		BASE_RAM;	-- page dependent memory

ram_vec:	*8;	

__reg;

org 		BASE_REG;

CTRL:		;
DUMMY:	;
PWMPL:	;
PWMPH:	;
PWMLL:	;
PWMLH:	;

