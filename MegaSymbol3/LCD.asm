	
;=========== LCD Define ==================================================================
			.equ	DATA_PORT	= PORTF	; LCD Data Port
			.equ	DATA_PIN	= PINF
			.equ	DATA_DDR	= DDRF

			.equ	CMD_PORT	= PORTA	; LCD Control Port
			.equ	CMD_PIN		= PINA
			.equ	CMD_DDR		= DDRA

			.equ	E		= 2
			.equ	RW		= 1
			.equ	RS		= 0

			.equ	SPEED	= 14	; 14 для XTAL=16MHz, 10 для XTAL=8MHz,  
									; 6 для XTAL=4MHz, 5 для XTAL<4MHz
;=========================================================================================
/*Timer0_OV:
	push r17
	push r18
	push r19
	lds r17,tacts
	lds r18,ds
	lds r19,seconds
	inc r17
	cpi r17,200
	brlo nots
	ldi r17,0
	inc r18
	cpi r18,20
	brlo nots
	ldi r18,0
	inc r19
	sts seconds,r19
	LCD_COORD 0,19
	ldi r18,48
	WR_DATA r19
nots:
	sts tacts,r17
	sts ds,r18
	pop r19
	pop r18
	pop r17
		reti*/
;=========== LCD Proc ====================================================================
InitHW:		CBI		CMD_PORT,RS
			CBI		CMD_PORT,RW
			CBI		CMD_PORT,E

			SBI		CMD_DDR,RS
			SBI		CMD_DDR,RW
			SBI		CMD_DDR,E
			
			LCD_PORT_IN
			RET

;=========================================================================================
BusyWait:	;LCD_PORT_IN
			CBI		CMD_PORT,RS
			SBI		CMD_PORT,RW
BusyLoop:	SBI		CMD_PORT,E
			
			RCALL	LCD_Delay

			CBI		CMD_PORT,E

			IN		R16,DATA_PIN
			ANDI	R16,0x80

			BRNE	BusyLoop
			RET
;=========================================================================================
; Запись команды в дисплей. Код команды в R17
CMD_WR:		CLI
			RCALL	BusyWait

			CBI		CMD_PORT,RS
			RJMP	WR_END

;-----------------------------------------------------------------------------------------
; Запись данных в дисплей. Код данных в R17
DATA_WR:	CLI
			RCALL	BusyWait
			
			SBI		CMD_PORT,RS
WR_END:		CBI		CMD_PORT,RW			
			SBI		CMD_PORT,E	
			
			LCD_PORT_OUT
			OUT		DATA_PORT,R17

			RCALL	LCD_Delay

			CBI		CMD_PORT,E
			LCD_PORT_IN		

			SEI
			RET

;=========================================================================================
; Чтение команды из дисплея. Результат в R17
CMD_RD:		CLI
			RCALL	BusyWait
		;	LCD_PORT_IN					;

			CBI		CMD_PORT,RS
			
			RJMP	RD_END

;-----------------------------------------------------------------------------------------
; Чтение команды из дисплея. Результат в R17
DATA_RD:	CLI
			RCALL	BusyWait
		;	LCD_PORT_IN					;

			SBI		CMD_PORT,RS
RD_END:		SBI		CMD_PORT,RW

			SBI		CMD_PORT,E
			RCALL	LCD_Delay
			IN		R17,DATA_PIN
			CBI		CMD_PORT,E
			
			SEI
			RET

;=========================================================================================
PortIn:		
			LDI		R16,0			; LCD Data Port
			OUT		DATA_DDR,R16	; Выставить на вход

			LDI		R16,0xFF		; Установить подтяжку
			OUT		DATA_PORT,R16
		
			RET		
;=========================================================================================	
LCD_Delay:	LDI		R16,SPEED
L_loop:		DEC		R16
			BRNE	L_loop
			RET

; Fill Screen ============================================================================
