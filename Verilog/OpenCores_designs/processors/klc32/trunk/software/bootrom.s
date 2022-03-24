KEYBD		EQU		$FFDC0000
KEYBDSTAT	EQU		$FFDC0002

	ORG	$FFFF0000

	ORI 	R1,R0,#$FFD00000
	ORI 	R2,R0,#5
	ORI 	R3,R0,#32
	PUSH	R1/R2/R3
	JSR		$FFFF0060
	POP		R3/R2/R1
	STOP

	ORG $FFFF0060
	LINK	R30,#24
	ORI 	R1,R0,#$FFD00000
	ORI 	R2,R0,#5
	ORI 	R3,R0,#32
J1:
	SH		R3,0(R1)
	ADDI	R1,R1,#2
	SUBI	R2,R2,#1
	BNE		CR0,J1
	UNLK	R30
	RTS		#0,#0

CheckForKey:
	LB		R1,KEYBD
	SMI		CR0,R1
	RTS

GetKey:
	LB		R1,KEYBD
	LB		R0,KEYBDSTAT	; clear keyboard strobe
	RTS

