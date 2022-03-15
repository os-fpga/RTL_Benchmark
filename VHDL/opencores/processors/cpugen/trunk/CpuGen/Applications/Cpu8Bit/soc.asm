--
-- Cpu8Bit
--

__equ;

BASE_ISR		#3f8h;
BASE_ROM		#0h;
BASE_OA		#0;
BASE_RAM		#8h;

CTRL_ADDR		#100h;
INT_ADDR		#104h;
REG_ADDR		#108h;
TIMER_ADDR		#10ch;
UART_ADDR		#110h;
						
-- Interrupt controller
	
MASK_ALL_INT	#0h;
UNMASK_INT		#fah;		-- timer, uarts and in3, in1

UNCLEAR_INT		#0h;

EXT_INT0		#1h;
EXT_INT1		#2h;
EXT_INT2		#4h;
EXT_INT3		#8h;
OVR_UART_INT	#10h;
RX_UART_INT		#20h;
TX_UART_INT		#40h;
TIMER_INT		#80h;

-- Timer control

TIMER_COUNT		#1h;
TIMER_ENABLE	#1h;

-- Uart control

UART_115200B	#00001010b;		-- 20.0 MHz / (16 * 115200) =  11 = (d+1) => d = 10 = 00001010 = TX_CLK_DIV = RX_CLK_DIV
TX_UART_FREE	#0;
TX_UART_BUSY	#1;

__rom;

org		BASE_ROM;

--		
--		Init Parameters
--

		cla;				-- Reset control register
		sta	sctrl;		-- Ctrl status
		sta	CTRL;
		
		ldai	MASK_ALL_INT;	-- Mask all interrupt
		sta	INT_MASK;

		ldai	TIMER_COUNT;	-- Set Timer count
		sta	TIMER_C;
	
		ldai	UART_115200B;	-- Set RX/TX UART BAUD (8,N,1 fixed)
		sta	UART_BAUD;

		ldai	#0;
		sta	REG0;
		sta	REG1;
		ldai	TIMER_ENABLE;	-- Enable Timer
		sta	TIMER_S;		

		ldai	UNMASK_INT;		-- UnMask interrupt
		sta	INT_MASK;

		ldai	#1;			-- Inc 1 on indirect address
		sta	IND_INC;
		ldai	&string;		-- string's address
		sta	IND_REG;
		ldai	stringSize;		-- string's size
		subi	#1;
		sta	toSend;		-- num of char to send
		lda	IND_ADD;
		sta	UART_DATA;
		ldai	TX_UART_BUSY;
		sta	stx;
		ldai	#0;
		sta	count;
					
--		
--		Main Task
--
		
init:		lda   count;
		addi	#1;
		sta	count;
		sta	REG1;
		lda	toSend;
		skz;
		jmp	init;		-- Wait sending "Hello" via UART
		lda 	tmp;		-- Read tmp
		addi	#Ah;		-- Add ten
		sta	tmp;		-- Save it	
		ldai	&vec;
		sta	IND_REG;
		lda	REG0;
		sta	IND_ADD;	-- store REG0 in vec[0]
		lda	REG1;
		add	tmp;
		sta	IND_ADD;	-- store (REG1 + tmp) in vec[1]
		ldai	&vec;
		sta	IND_REG;
		lda	IND_ADD;	-- load vec[0]
		sta	tmp;		
		jmp 	init;

--		
--		ISR routine
--		Check interrupts pending priority ordered
--

isr:		ldai	#0;
		sta	sint;
		lda	INT_MASK;
		andi 	EXT_INT0;
		sknz;
		jmp	check_int1;
		lda	sint;
		ori	EXT_INT0;
		sta	sint;
		sta	REG0;
clr_int0:	ldai	EXT_INT0;
		sta	INT_CLR;
		ldai	UNCLEAR_INT;
		sta	INT_CLR;
check_int1: 	lda	INT_MASK;
		andi 	EXT_INT1;
		sknz;
		jmp	check_int2;
		lda	sint;
		ori	EXT_INT1;
		sta	sint;
		sta	REG0;
clr_int1:	ldai	EXT_INT1;
		sta	INT_CLR;
		ldai	UNCLEAR_INT;
		sta	INT_CLR;
check_int2: 	lda	INT_MASK;
		andi 	EXT_INT2;
		sknz;
		jmp	check_int3;
		lda	sint;
		ori	EXT_INT2;
		sta	sint;
		sta	REG0;
clr_int2:	ldai	EXT_INT2;
		sta	INT_CLR;
		ldai	UNCLEAR_INT;
		sta	INT_CLR;
check_int3: 	lda	INT_MASK;
		andi 	EXT_INT3;
		sknz;
		jmp	check_int4;
		lda	sint;
		ori	EXT_INT3;
		sta	sint;
		sta	REG0;
clr_int3:	ldai	EXT_INT3;
		sta	INT_CLR;
		ldai	UNCLEAR_INT;
		sta	INT_CLR;
check_int4: 	lda	INT_MASK;		-- Overrun Uart
		andi 	OVR_UART_INT;
		sknz;
		jmp	check_int5;
clr_int4:	ldai	OVR_UART_INT;
		sta	INT_CLR;
		ldai	UNCLEAR_INT;
		sta	INT_CLR;
check_int5: 	lda	INT_MASK;		-- RX Uart
		andi 	RX_UART_INT;
		sknz;
		jmp	check_int6;
		lda	UART_DATA;		-- Read RX UART data and clear RX interrupts 
		add	tmp;			-- Add tmp 
		sta	REG0;			-- Put it on REG0
clr_int5:	ldai	RX_UART_INT;
		sta	INT_CLR;
		ldai	UNCLEAR_INT;
		sta	INT_CLR;
check_int6: 	lda	INT_MASK;		-- TX Uart
		andi 	TX_UART_INT;
		sknz;
		jmp	check_int7;
		ldai	TX_UART_FREE;
		sta	stx;
		lda	toSend;
		sknz;
		jmp	clr_int6;
		subi	#1;
		sta   toSend;
		lda	IND_ADD;
		sta	UART_DATA;
		ldai	TX_UART_BUSY;
		sta	stx;
clr_int6:	ldai	TX_UART_INT;
		sta	INT_CLR;
		ldai	UNCLEAR_INT;
		sta	INT_CLR;
check_int7: 	lda	INT_MASK;		-- Timer
		andi 	TIMER_INT;
		sknz;
		jmp	retint;
		lda	stx;		
		andi 	TX_UART_BUSY;	
		skz;
		jmp	clr_int7;
		lda	tmp;		-- Send current tmp on UART if timer elapsed and tx uart free;
		sta	UART_DATA;
		ldai	TX_UART_BUSY;
		sta	stx;
clr_int7:	ldai	TIMER_INT;
		sta	INT_CLR;
		ldai	UNCLEAR_INT;
		sta	INT_CLR;
-- retsint:	lda 	ipg_int;
--		sta 	ISTR_PAGE;
retint:	rti;

org 		BASE_ISR;

--		ldai 	ISTR_PAGE;
--		sta 	ipg_int;
--		ldai 	INT_PAGE;
--		sta 	ISTR_PAGE;
--		nop;
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

--ipg_int:	;	-- BackUp Istruction page
tmp:		;
sctrl:	;
string:	#Hello<13>s;
stringSize:	#6;
toSend:	;
vec:		*4;
stx:		;	-- TX uart status
sint:		;	-- Interrupt line status
count:	;	-- Loop counter

__reg;

org		CTRL_ADDR;

CTRL:		;

org		INT_ADDR;

INT_MASK:	;
INT_CLR:	;

org		REG_ADDR;

REG0:		;
REG1:		;

org		TIMER_ADDR;

TIMER_C:	;	-- Timer Count register
TIMER_S:	;	-- Timer Status register

org		UART_ADDR;

UART_DATA:	;
UART_BAUD:	;
