;
; attiny2313_tm1637.asm
;
; Created: 09.07.2021 14:09:01
; Author : verbkinm
;
; Описание:	
;	

.include "tn2313adef.inc"
.include "config.inc"

.include "vars.asm"

;========================================================
;			 Начало программного кода
;========================================================

.cseg		 						; Выбор сегмента программного кода
	.org	0						; Установка текущего адреса на ноль

start:	
	.include "interrupts_vector.asm"
	.include "initialization.asm"

	;-------------------------- Основной бесконечный цикл в ожидании прерывания

	rcall	LED_0_test
	sei

	;-------------------------- Тест

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
