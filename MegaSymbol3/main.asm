;
; MegaSymbol3.asm
; Created: 10.01.2020 18:34:31
; Author : User
.dseg
	old_key: 	.BYTE 1	//for terminating
	cur_key:	.BYTE 1	//current key
	answers:	.BYTE 10	//space for answers
	tacts:		.BYTE 1 ///1-tact 250mcs  *200
	ds:			.BYTE 1 // 1-ds - 0.05s *20
	SDVIG:		.BYTE 1	//shift numbers
	.cseg
	 	.ORG   INT_VECTORS_SIZE      	; Конец таблицы прерываний
	.include "menus.inc"
	.include "LCD_macro.inc"
	.DEF subj=r22	//string number
start:
	ldi r23,0
	sts cur_key,r23
	sts tacts,r23
	sts SDVIG,r23
    INIT_LCD		; Инициализируем
	ldi r22,0
	sts tacts,r22
	
LOOP:	
    LCDCLR
	BIG_DELAY
	BIG_DELAY
	BIG_DELAY
	BIG_DELAY
	LCDCLR
	output sbj
	BIG_DELAY
	call onebutton
	LDS R22,cur_key
	cpi r22,0
	breq b1
	cpi r22,1
	breq b2
	cpi r22,2
	breq b3
	cpi r22,3
	breq b4
	b1:	jmp bt1
	b2: jmp bt2
	b3:	jmp bt3
	b4:	jmp bt4
	bt1:
	TTT T0A
	jmp endT
	bt2:
	TTT P0A
	jmp endT
	bt3:
	TTT H0A
	jmp endT
	bt4:
	TTT L0A
	jmp endT
	endT:
	JMP LOOP
	.include "LCD.asm"
	.include "Test.asm"
	