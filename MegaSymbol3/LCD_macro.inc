;===============================================================================================
; LCD Init
			.equ 	LCD_CLR          	= 0      ; DB0: clear display
			.equ 	LCD_HOME         	= 1      ; DB1: return to home position

			.equ  	LCD_ENTRY_MODE   	= 2      ; DB2: set entry mode
			.equ 	LCD_ENTRY_INC    	= 1      ;   DB1: increment
			.equ 	LCD_ENTRY_SHIFT  	= 0      ;   DB2: shift

			.equ 	LCD_ON		      	= 3      ; DB3: turn lcd/cursor on
			.equ  	LCD_ON_DISPLAY   	= 2      ;   DB2: turn display on
			.equ  	LCD_ON_CURSOR     	= 1      ;   DB1: turn cursor on
			.equ  	LCD_ON_BLINK      	= 0      ;   DB0: blinking cursor

			.equ  	LCD_MOVE          	= 4      ; DB4: move cursor/display
			.equ 	LCD_MOVE_DISP       = 3      ;   DB3: move display (0-> move cursor)
			.equ  	LCD_MOVE_RIGHT      = 2      ;   DB2: move right (0-> left)

			.equ  	LCD_F		        = 5      ; DB5: function set
			.equ 	LCD_F_8B		   	= 4      ;   DB4: set 8BIT mode (0->4BIT mode)
			.equ  	LCD_F_2L			= 3      ;   DB3: two lines (0->one line)
			.equ  	LCD_F_10D			= 2      ;   DB2: 5x10 font (0->5x7 font)
			.equ  	LCD_CGRAM           = 6      ; DB6: set CG RAM address
			.equ  	LCD_DDRAM           = 7      ; DB7: set DD RAM address
 
			.equ	SCR_L				= 0b00011000
			.equ	SCR_R				= 0b00011100
			
			.equ	CUR_L				= 0b00010000 
			.equ	CUR_R				= 0b00010100
//===========================================================================================
; Output String
			.MACRO OUTPUT
			push ZL
			push ZH
			push r22
			SM_DELAY
			//LCDCLR
			SM_DELAY
			//LCD_COORD 0,0	//set cursor at the biginning
			ldi ZL,low(@0*2)	//read address of string
			ldi ZH,high(@0*2)	//
			$go:
			LPM	//read value from address Z to R0
			INC ZL	//next element
			mov r22,r0	
			cpi R22,33	//'!'-is end of string
			breq $not	//if not '!'- next element
			WR_DATA R0	//write on the screem
			rjmp $go
			$not:
			pop r22
			pop ZH
			pop ZL
			.ENDM 
//============================================================================================
; Output String
			.MACRO OUTPUTS //outputs @0- 0point @1- shift sixe @2 number of shifts( quest number-1) @3-shoft fron questino 
			push ZL
			push ZH
			push r22
			push r23
			push r25
			lds r22,@2	//how many sizes we shift
			ldi ZL,low(@0*2)
			ldi ZH,high(@0*2)
			ldi r23,@1	//size of 1 shift
			$GENADDR:	//create shifted address
			cpi r22,0   //
			breq $norms  //
			dec r22	 
			clc	//clear flag carry
			add ZL,r23
			BRCC $GENADDR	//check carry
			inc ZH
			jmp $GENADDR
			$norms:
			ldi r25,@3
			clc
			add ZL,r25
			brcc $gos
			inc ZH
			//
			$gos:
			LPM
			INC ZL
			cpi ZL,0
			brne bos
			inc ZH
			bos:			
			mov r22,r0
			cpi R22,33
			breq $nots
			WR_DATA R0
			rjmp $gos
			$nots:
			pop r25
			pop r23
			pop r22
			pop ZH
			pop ZL
			.ENDM 
;==========================================================
; Init Config
			.MACRO	INIT_LCD
			//RCALL	InitHW
			CALL	InitHW
			WR_CMD	(1<<LCD_F)|(1<<LCD_F_8B)|(1<<LCD_F_2L)									;0x38
			WR_CMD	(1<<LCD_CLR)															;0x01
			WR_CMD	(1<<LCD_ENTRY_MODE)|(1<<LCD_ENTRY_INC)									;0x06
			WR_CMD	(1<<LCD_ON)|(1<<LCD_ON_DISPLAY)|(0<<LCD_ON_CURSOR)|(0<<LCD_ON_BLINK)	;0x0C
			WR_CMD	(1<<LCD_HOME)															;0x02
			.ENDM

;===============================================================================================
;Write Data
			.MACRO	WR_DATA
			MOV R17,@0
			;LDI		R17,@0
			//RCALL	DATA_WR
			CALL	DATA_WR
			.ENDM
;===============================================================================================
;Write CMD
			.MACRO	WR_CMD
			LDI		R17,@0
			//RCALL	CMD_WR
			CALL	CMD_WR
			.ENDM
;===============================================================================================
; Read Data
			.MACRO	RD_DATA
			RCALL	DATA_RD
			.ENDM
;===============================================================================================
; Read CMD
			.MACRO	RD_CMD
			RCALL	CMD_RD
			.ENDM
;===============================================================================================
; Set DATA Port OUT
			.MACRO LCD_PORT_OUT
			LDI		R16,0xFF
			OUT		DATA_DDR,R16
			.ENDM
;===============================================================================================
; Set DATA Port IN
			.MACRO LCD_PORT_IN
			RCALL	PortIn
			.ENDM

;===============================================================================================
;Set COORD
;Syntax LCD_COORD X,Y
			.MACRO LCD_COORD
			LDI		R17,(1<<LCD_DDRAM)|(@0+0x40*@1)
			//RCALL	CMD_WR
			CALL	CMD_WR
			.ENDM
;===============================================================================================
;Shift SCREEN/CURSOR
			.MACRO	SHIFT
			LDI		R17,@0
			RCALL	CMD_WR
			.ENDM

;===============================================================================================
;LCD Clear

			.MACRO	LCDCLR
			LDI 	R17,(1<<LCD_CLR)
			CALL	CMD_WR
			.ENDM

;===============================================================================================
;Write CGRAM

			.MACRO WR_CGADR
			LDI		R17,(1<<LCD_CGRAM)|(@0)
			RCALL	CMD_WR
			.ENDM

;Write DDRAM
			.MACRO WR_DDADR
			LDI		R17,(1<<LCD_DDRAM)|(@0)
			RCALL	CMD_WR
			.ENDM
;BigDelay
	.MACRO BIG_DELAY
	push r20
	push r21
	push r22
	ldi r20,20
	D1:
		ldi r21,255
		D2:
			ldi r22,255
			D3:
			dec r22
			cpi r22,0
			brne D3
		dec r21
		cpi r21,0
		brne D2
	dec r20
	cpi r20,0
	brne D1
	pop r22
	pop r21
	pop r20
	.ENDM
	//===========
	.MACRO SM_DELAY
	push r20
	ldi r20,255
	SD1:
	dec r20
	cpi r20,0
	brne SD1
	pop r20
	.ENDM