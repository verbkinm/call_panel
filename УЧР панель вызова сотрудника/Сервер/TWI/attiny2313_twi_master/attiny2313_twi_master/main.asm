;
; attiny2313_tm1637.asm
;
; Created: 19.07.2021 11:20:01
; Author : verbkinm
;
; ��������:	
;	��������� ������ �� USART � �������� �� �� ���� TWI

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

	ldi		BYTE, 0x00
	ldi		r17, 0x00

	rcall	twi_write_one_byte
	rcall	twi_stop

	sei
	main:	 
		sleep
		rjmp	main

.include "interrupts.asm"
.include "lib.asm"
.include "twi_mp.asm"
.include "uart.asm"
