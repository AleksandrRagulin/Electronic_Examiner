/*
 * menus.inc
 */ 
	.MACRO SHUFFLE
	push r18
	push r21
	push r23
	push r24
	push ZH
	push ZL
	LCDCLR
	BIG_DELAY
	BIG_DELAY
	LCD_COORD 0,0
	outputs @0,@2,@3,0
	BIG_DELAY
	lds r21,@1
	lds r24,@3
	andi r21,3
	cpi r21,0
	breq $mb0
	cpi r21,1
	breq $mb1
	cpi r21,2
	breq $mb2
	cpi r21,3
	breq $mb3
$mb0:	jmp $jmb0
$mb1:	jmp $jmb1
$mb2:	jmp $jmb2
$mb3:	jmp $jmb3
$jmb0:
    LCD_COORD 20,0
	outputs @0,@2,@3,82
	LCD_COORD 30,0
	outputs @0,@2,@3,94
	LCD_COORD 20,1
	outputs @0,@2,@3,106
	LCD_COORD 30,1
	outputs @0,@2,@3,118
	jmp $nd
$jmb1:

    LCD_COORD 20,0
	outputs @0,@2,@3,118
	LCD_COORD 30,0
	outputs @0,@2,@3,82
	LCD_COORD 20,1
	outputs @0,@2,@3,94
	LCD_COORD 30,1
	outputs @0,@2,@3,106
	jmp $nd
$jmb2:

    LCD_COORD 20,0
	outputs @0,@2,@3,106
	LCD_COORD 30,0
	outputs @0,@2,@3,118
	LCD_COORD 20,1
	outputs @0,@2,@3,82
	LCD_COORD 30,1
	outputs @0,@2,@3,94
	jmp $nd
$jmb3:
    LCD_COORD 20,0
	outputs @0,@2,@3,118
	LCD_COORD 30,0
	outputs @0,@2,@3,82
	LCD_COORD 20,1
	outputs @0,@2,@3,94
	LCD_COORD 30,1
	outputs @0,@2,@3,106
	jmp $nd
$nd:
	lds r21,@1
	inc r21
	andi r21,3
	sts SDVIG,r21
	pop ZL
	pop Zh
	pop r24
	pop r23
	pop r21
	pop r18
	.ENDM

	//====================================================================================================
.MACRO TTT 
	.def points= r19
	ldi points,0
	ldi ZL,low(@0*2+1300) //set pointer on answers database
	ldi ZH,high(@0*2+1300)
cc1:	
	lds r22,tacts
	cpi r22,10
	breq kon
	jmp good1
	kon: jmp konec
good1:
	SHUFFLE @0,SDVIG,130,tacts
	push r18
	lds r18,tacts
	inc r18
	sts tacts,r18
	pop r18
	call onebutton	//catch answer number
	lpm 
	adiw ZL,1
	push r24
	push r23
	lds r24,SDVIG
	//andi r24,3
	add r0,r24
	mov r23,r0
	dec r23
	andi r23,3
	lds r24,cur_key
	cp r24,r23
	//cpi r24,0
	brne false
	inc points
false:	
	pop r23
	pop r24
	jmp cc1
	konec:
	ldi r22,0
	sts tacts,r22
	LCDCLR
	BIG_DELAY
	BIG_DELAY
	LCDCLR
	BIG_DELAY
	BIG_DELAY
	output RES
	LCD_COORD 27,0
	ldi r18,48
	add r18,points
	WR_DATA r18	//number of points
	ldi r18,'/'
	WR_DATA r18
	ldi r18,'1'
	WR_DATA r18
	ldi r18,'0'
	WR_DATA r18
	call onebutton
	.ENDM