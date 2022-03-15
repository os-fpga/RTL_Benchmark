--
-- NiosApex
--

__equ;

BASE_ISR		#3f8h;
BASE_ROM		#0h;
BASE_OA		#0;
BASE_RAM		#8h;

INT_ADDR		#100h;
TX_UART_ADDR	#104h;
RX_UART_ADDR	#108h;
TIMER_ADDR		#10Ch;
DISPLAY_ADDR	#110h;

-- Timer

ENABLE_TIMER	#1h;
RESET_TIMER		#2h;

CNT_NEW		#1;
CNT_OLD		#0;

-- Display

MAX_LEN_D		#16;
INC_DDISP		#1;

RESET_DDISP		#30h;
SET_DDISP		#38h;
ONOFF_DDISP		#8h;
CLEAR_DDISP		#1;
MODE_DDISP		#6h;
ON_DDISP		#ch;
RAW0_DDISP		#80h;
RAW1_DDISP		#c0h;

INC_STR_D		#1;	
TEXT_SIZE		#6;	

CLEAR_CDISP		#0;
DATA_CDISP		#1;
CWRITE_CDISP	#4;
DWRITE_CDISP	#5;

LDELAY		#255;
HDELAY		#64;
DEC_DELAY		#1;
BIT_RAW		#1;
RAW0_LCD		#0;
RAW1_LCD		#1;
CHAR_ZERO		#0c;
CHAR_A		#Ac;

LCD_RS		#1;
LCD_RW		#2;
LCD_E			#4;

-- Interrupt

TX_UART_INT		#1h;
RX_FULL_UART_INT	#2h;
RX_OVR_UART_INT	#4h;
TIMER_INT		#8h;

-- Uart control

TX_UART_115200B	#00010001b;		-- (33.333MHz) / (115200 * 16) = 18 = (d+1) => d = 17 = 00010001 = TX_CLK_DIV
TX_UART_9600B	#11011000b;		-- (33.333MHz) / (9600 * 16) = 217 = (d+1) => d = 216 = 11011000 = TX_CLK_DIV

RX_UART_115200B	#00010001b;		-- (33.333MHz) / (115200 * 16) = 18 = (d+1) => d = 17 = 00010001 = RX_CLK_DIV
RX_UART_9600B	#11011000b;		-- (33.333MHz) / (9600 * 16) = 217 = (d+1) => d = 216 = 11011000 = RX_CLK_DIV

TX_FREE		#1;
TX_BUSY		#0;

__rom;

org		BASE_ROM;

--		
--		Init Parameters
--

		cla;				-- Reset control register
		sta	INT_VAL;		-- Disable interrupts;
	
		ldai	TX_UART_115200B;
		sta	UART_TX_BAUD;
		ldai	RX_UART_115200B;
		sta	UART_RX_BAUD;

		ldai	#1;
		sta	IND_INC;
		ldai	&text;
		sta	IND_REG;
		ldai	#Hc;
		sta	IND_ADD;
		ldai	#ec;
		sta	IND_ADD;
		ldai	#lc;
		sta	IND_ADD;
		ldai	#lc;
		sta	IND_ADD;
		ldai	#oc;
		sta	IND_ADD;
		ldai	#13;
		sta	IND_ADD;
		ldai	&text;
		sta	IND_REG;
		ldai	TEXT_SIZE;
		subi	#1;
		sta	toSend;
		ldai	TX_BUSY;
		sta	stx;
		lda	IND_ADD;
		sta	UART_TX;

--		
--		Init Interrupt
--

		ldai	TX_UART_INT;
		ori	TIMER_INT;
		sta	INT_VAL;

--		
--		Init Display
--

		jms	delay;	-- Delay
		ldai	RESET_DDISP;
		sta	cmd_lcd;
		jms	cmd_disp;	-- Reset display
		jms	cmd_disp;	-- Reset display
		jms	cmd_disp;	-- Reset display
		ldai	SET_DDISP;
		sta	cmd_lcd;
		jms	cmd_disp;	-- Configure display
		ldai	ONOFF_DDISP;
		sta	cmd_lcd;
		jms	cmd_disp;	-- Configure display
		ldai	CLEAR_DDISP;
		sta	cmd_lcd;
		jms	cmd_disp;	-- Clear display
		ldai	MODE_DDISP;
		sta	cmd_lcd;
		jms	cmd_disp;	-- Configure display
		ldai	ON_DDISP;
		sta	cmd_lcd;
		jms	cmd_disp;	-- On display
		ldai	RAW0_LCD;
		sta	raw_lcd;

--
--		Start Timer
--
		ldai	#0;
		sta	timer_c;
		sta	timer_pre;
		ldai	#ffh;
		sta	TIMER_CNT;
		ldai	CNT_NEW;
		sta	ctx;
		ldai	ENABLE_TIMER;
		sta	TIMER_STATUS;

--		
--		Main Task
--
		
start:	lda 	INT_VAL;
		andi	TX_UART_INT;
		sknz;	
		jmp	start;
		lda	toSend;
		sknz;
		jmp	init;
		subi	#1;
		sta   toSend;
		lda	IND_ADD;
		sta	UART_TX;
		jmp	start;		
		ldai	#1;
		sta	IND_INC;
init:		lda	ctx;
		andi 	CNT_NEW;
		sknz;
		jmp 	uart;
		ldai	CNT_OLD;
		sta	ctx;
		ldai	&str_lcd;
		sta	IND_REG;
		lda	timer_c;
		andi	#f0h;
		shr;
		shr;
		shr;
		shr;
		sta	hex_lcd;
		jms	nib2hex;
		lda	hex_lcd;
		sta	IND_ADD;
		lda	timer_c;
		andi	#0fh;
		sta	hex_lcd;
		jms	nib2hex;
		lda	hex_lcd;
		sta	IND_ADD;
		ldai	#2;		-- 1 byte len = 2 char
		sta	str_len;	
		jms	str_disp;	-- Write on display
uart:		lda 	INT_VAL;
		andi	RX_FULL_UART_INT;
		sknz;	
		jmp	init;
		lda 	UART_RX;
		sta	tmp;
		lda	stx;
		andi 	TX_FREE;
		sknz;	
		jmp	init;
		ldai	TX_BUSY;
		sta	stx;
		lda	tmp;
		addi	#1;
		sta	UART_TX;
		jmp 	init;

--		
--	Routine Nibble2Hex for Display
--

nib2hex:	lda	hex_lcd;
		subi	#10;
		skc;
		jmp	add_a;
		addi	#10;
		addi	CHAR_ZERO;
		sta	hex_lcd;
		rts;
add_a:	addi	CHAR_A;
		sta	hex_lcd;
		rts;

--		
--	Routine Delay Display
--

delay:	ldai	HDELAY;
		sta	delay_h;
lloop:	ldai	LDELAY;	-- Delay: times 33ns
dloop:	sknz;
		jmp	exit_l;
		subi	DEC_DELAY;
		jmp 	dloop;
exit_l:	lda	delay_h;
		sknz;		
		rts;
		subi	DEC_DELAY;
		sta	delay_h;
		jmp	lloop;

--		
--		Command to Display
--

cmd_disp:	lda 	cmd_lcd;
		sta 	cdisp;
		jms	delay;
		rts;

--		
--		Character to Display
--

wr_disp:	lda 	char_lcd;
		sta 	ddisp;
		jms	delay;
		rts;

--		
--		String to Display
--

str_disp:	lda	raw_lcd;
		andi	BIT_RAW;
		skz;
		jmp	jmp1_disp;
jmp0_disp:	ldai	RAW0_DDISP;
		sta	cmd_lcd;
		jms	cmd_disp;	-- Go display raw 0
		jmp	wr_str;
jmp1_disp:	ldai	RAW1_DDISP;
		sta	cmd_lcd;
		jms	cmd_disp;	-- Go display raw 1
wr_str:	ldai	&str_lcd;
		sta	IND_REG;
		ldai	INC_STR_D;
		sta	IND_INC;
		lda	str_len;
loop_lcd:	sta	len_lcd;
		lda	IND_ADD;
		sta	char_lcd;
		jms  	wr_disp;
		lda	len_lcd;
		subi	#1;
		skz;
		jmp	loop_lcd;
		rts;

--		
--		ISR routine
--		Check interrupts pending priority ordered
--

isr:		lda	INT_VAL;
		andi	TX_UART_INT;
		sknz;
		jmp	int_timer;
		sta	INT_CLR;
		ldai	#0;
		sta	INT_CLR;
		ldai	TX_FREE;
		sta	stx;
int_timer: 	lda	INT_VAL;
		andi	TIMER_INT;
		sknz;
		rti;
		sta	INT_CLR;
		ldai	#0;
		sta	INT_CLR;
		lda	timer_pre;
		addi	#1;
		sta	timer_pre;
		skz;
		rti;
		lda	timer_c;
		addi	#1;
		sta	timer_c;
		ldai	CNT_NEW;
		sta	ctx;
		rti;
test:		jmp	test;

org 		BASE_ISR;

		jmp 	isr;
 		jmp	test;
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
text:		*TEXT_SIZE;	-- #Hello<13>s;
toSend:	;
timer_pre:	;
timer_c:	;
delay_h:	;	-- delay for display
char_lcd:	;	-- character to display
cmd_lcd:	;	-- command to display
raw_lcd:	;	-- raw of display
hex_lcd:	;	-- nibbleToHex of display
len_lcd:	;
inc_lcd:	;
reg_lcd:	;
str_len:	;			-- length string for display
str_lcd:	*MAX_LEN_D;		-- string for display
data:		;
stx:		;
ctx:		;

__reg;

org		INT_ADDR;

INT_VAL:	;
INT_CLR:	;

org		TX_UART_ADDR;

UART_TX:		;
UART_TX_BAUD:	;

org		RX_UART_ADDR;

UART_RX:		;
UART_RX_BAUD:	;

org		TIMER_ADDR;

TIMER_CNT:		;
TIMER_STATUS:	;

org		DISPLAY_ADDR;

cdisp:		;
ddisp:		;
