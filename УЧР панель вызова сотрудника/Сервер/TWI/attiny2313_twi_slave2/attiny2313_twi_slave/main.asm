;
; attiny2313_tm1637.asm
;
; Created: 30.06.2020 14:09:01
; Author : verbkinm
;
; ��������:	
;	����������� ������� � ���� �� 4-� ���������� ������� � ����� TM1637, ������ ������� ds1302. 		
;	���������� ����� ��������, ���� ���������.

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
	.include "interrupts.asm"
	.include "initialization.asm"

	;-------------------------- �������� ����������� ���� � �������� ����������

/*	rcall	LED_0_RED_on
	ldi		r17, 0x01
	mov		LED_0_cache, r17
	rcall	MCU_wait_200ms
	rcall	LED_0_toggle
	rcall	MCU_wait_200ms
	rcall	LED_0_toggle*/

	sei
	main:	 
		;sleep
		rjmp	main

.include "lib.asm"
.include "twi_mp.asm"
;.include "uart.asm"
.include "delay.asm"

.include "led_0.asm"
.include "led_1.asm"
.include "led_2.asm"
.include "led_3.asm"
.include "led_4.asm"
