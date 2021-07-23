;========================================================
;		Прерывание UART - приём завершен	
;========================================================

_TWI_start:
	push	r17

	rcall	twi_recive_byte
	;rcall	USART_Transmit
	mov		ADDR, BYTE

	rcall	MCU_wait_10mks
	rcall	twi_recive_byte
	;rcall	USART_Transmit
	mov		LED, BYTE

	rcall	MCU_wait_10mks
	rcall	twi_recive_byte
	;rcall	USART_Transmit
	mov		COLOR, BYTE

	cpi		ADDR, OUR_ADDR
	brne	_TWI_start_end

	cpi		LED, LED_0
	breq	LED_0_cmd

	cpi		LED, LED_1
	breq	LED_1_cmd

	cpi		LED, LED_2
	breq	LED_2_cmd

	cpi		LED, LED_3
	breq	LED_3_cmd

	cpi		LED, LED_4
	breq	LED_4_cmd

	rjmp	_TWI_start_end

	LED_0_cmd:
		mov		r17, COLOR
		rcall	LED_0_select_cmd

		rjmp	_TWI_start_end

	LED_1_cmd:
		mov		r17, COLOR
		rcall	LED_1_select_cmd

		rjmp	_TWI_start_end

	LED_2_cmd:
		mov		r17, COLOR
		rcall	LED_2_select_cmd

		rjmp	_TWI_start_end

	LED_3_cmd:
		mov		r17, COLOR
		rcall	LED_3_select_cmd

		rjmp	_TWI_start_end

	LED_4_cmd:
		mov		r17, COLOR
		rcall	LED_4_select_cmd

	_TWI_start_end:

		ldi		r17, ( 1 << USISIF ) | ( 1 << USIOIF ) | ( 1 << USIPF ) | ( 1 << USIDC ) | ( 0 << USICNT0 )
		out		USISR, r17

		ldi		r17, ( 1 << USISIE ) | ( 0 << USIOIE ) | ( 1 << USIWM1 ) | ( 0 << USIWM0 ) | ( 1 << USICS1 ) | ( 0 << USICS0 ) | ( 0 << USICLK ) | ( 0 << USITC )
		out		USICR, r17

		pop		r17

	reti