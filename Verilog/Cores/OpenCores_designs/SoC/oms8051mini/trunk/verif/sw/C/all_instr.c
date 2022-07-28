
#include <8051.h>

void main()
{
	
	__asm // Add
	ADD A,#03
	MOV A,#10
	MOV R1,#20
	ADDC A,R1 
	JC CHere
	CHere : NOP
	ADDC A,@R1 
	ADDC A,30
	CJNE A,#30,NEXT
	NEXT : NOP
	
	SUBB A,#01
	MOV A,#30 // SUb
	MOV R2,#10
	SUBB A,R2
	//SUBB A,@R3
	SUBB A,44
	
	
	MOV A, #30 //Inc
	INC A	
	INC 34
	INC DPTR
	MOV R1,#20
	INC R1
	
	MOV A, #30 //Dec
	DEC A
	DEC 34
	//DEC DPTR
	MOV R3,#20
	DEC R3
	
	MOV A,#5 //Mul
	MOV B,#4
	MUL AB
	
	MOV A,#10 //Div
	MOV B,#2
	DIV AB
	
	
	MOV A,#30 //AND
	MOV B,#2
	ANL A,B
	ANL A,#30
	MOV R1,#3
	ANL A,@R1
	ANL A,#20
	ANL A,R1
	ANL 30,#33
	ANL 30,A
	
	
	
	
	MOV A,#30 //OR
	MOV B,#2
	ORL A,B
	
	ORL A,#30
	MOV R1,#3
	ORL A,@R1
	ORL A,#20
	ORL A,R1
	ORL 30,#33
	ORL 30,A
	
	
	MOV A,#30 // XOR
	MOV B,#2
	XRL A,B
	
	XRL A,#30
	MOV R1,#3
	XRL A,@R1
	XRL A,#20
	XRL A,R1
	XRL 30,#33
	XRL 30,A
	
	MOV A,#65 //RLC
	RLC A
	RL A
	RR A
	RRC A
	
	MOV A,#65 //Swap
	SWAP A
	
	MOV DPTR,#9000
	MOVC A,@A+DPTR // Dptr
	
	MOV A,#47 //DA decimal adjustment
	MOV B,#25
	ADD A,B
	DA A
	
	AJMP MPLABEL 
	MPLABEL : NOP
	
	
	ACALL ALABEL 
	ALABEL : NOP
	
	LCALL SLABEL 
	SLABEL : NOP
	
	MOV A,#01
	MOV R1,#01
	ADDC A,R1 
	JNC NHere
	NHere : NOP
	
	JB 45,JHere
	NOP
	JHere : NOP
	
	JBC 45,JBCHere
	NOP
	JBCHere : NOP
	
	MOV A,#0
	JZ AZHere
	AZHere : NOP
	
	MOV A,#1
	JNZ ANZHere
	ANZHere : NOP
	
	JMP @A+DPTR
	
	MOV A,#55
	CJNE A,#01, CJHere
	CJHere : NOP
	
	CJNE R1,#99,CRHere
	CRHere : NOP
	
	MOV R1,#3
	DJNZ R1, DJHere
	DJHere : NOP
	
	MOV DPTR,#30
	
	MOVC A,@A+DPTR
	
	MOVC A,@A+PC
	
	MOVX A,@R1
	
	MOVX A,@DPTR
	
	MOVX @R1,A
	
	MOVX @DPTR,A
	
	PUSH 03
	POP 03
	
	MOV A,#30
	MOV R1,#50
	XCH A,R1
	XCH A,33
	XCH A,@R1
	XCHD A,@R1
	
	MOV A,#30
	ADDC A,#30
	
	CLR C
	CLR 01
	
	SETB C
	SETB 63
	
	CPL C
	CPL 63
	
	ANL C,01
	ANL C,/22
	ORL C, 02
	ORL C,/22
	
	MOV C, 01
	MOV 01, C 
	
	//ISR 
	
	SETB P1.3
	MOV R3,#255
	
	BACK : DJNZ R3, BACK
	CLR P1.3
	RETI
	
	
	
	
	__endasm;
	
	while(1) { }
	
	
}
