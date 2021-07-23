;
; attiny2313_tm1637.asm
;
; Created: 09.07.2021 14:09:01
; Author : verbkinm
;
; ��������:	
;	

.include "tn2313adef.inc"
.include "config.inc"

.include "vars.asm"

;========================================================
;			 ������ ������������ ����
;========================================================

.cseg		 						; ����� �������� ������������ ����
	.org	0						; ��������� �������� ������ �� ����

start:	
	.include "interrupts_vector.asm"
	.include "initialization.asm"

	;-------------------------- �������� ����������� ���� � �������� ����������

	rcall	LED_0_test
	sei

	;-------------------------- ����

/*	ldi		r17, SERVER_ADDR
	mov		SRC_ADDR, r17

	ldi		r17, OUR_ADDR
	mov		DST_ADDR, r17

	ldi		r17, CMD_QUERY
	mov		DATA, r17

	ldi		STATE, STATE_OK

	ldi		CONN_STATE, CONNECTED

	rcall	input_command*/

	main:	 
		rjmp	main

.include "interrupts.asm"
.include "command_and_state.asm"
.include "uart.asm"
.include "delay.asm"
.include "led.asm"
.include "counter.asm"
.include "tim0.asm"
