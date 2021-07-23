;========================================================
;			Прерывание INT0		
;========================================================

_INT0:
	rcall	MCU_wait_200ms
	sbic	PIN_BUTTON, BUTTON
	reti

	cpi		CONN_STATE, DISCONNECTED
	breq	_INT0_end	

	cpi		STATE, STATE_OK
	breq	_INT0_send_query

	cpi		STATE, STATE_WAITING_RESPONSE
	breq	_INT0_send_cancel

	cpi		STATE, STATE_WAITING_US
	breq	_INT0_send_response

	cpi		STATE, STATE_RECEIVED_RESPONSE
	breq	_INT0_send_query

	cpi		STATE, STATE_ERROR
	breq	_INT0_send_query

	reti

	_INT0_send_query:
		ldi		BYTE, CMD_QUERY
		rcall	USART_send_package
		ldi		STATE, STATE_WAITING_RESPONSE

		reti

	_INT0_send_cancel:
		ldi		BYTE, CMD_CANCEL_QUERY
		rcall	USART_send_package
		ldi		STATE, STATE_OK

		reti

	_INT0_send_response:
		ldi		BYTE, CMD_RESPONSE_TO_QUERY
		rcall	USART_send_package
		ldi		STATE, STATE_OK

	_INT0_end:

	reti

;========================================================
;		Прерывание UART - приём завершен	
;========================================================

_UART_RX:
	push	r17
	push	BYTE

	in		BYTE, UDR

	cp		DST_ADDR, CONST_ZERO			; Если в регистре DST_ADDR ноль, то ожидаем байт адреса получятеля
	breq	_UART_RX_wait_for_dst_addr_byte

	cp		SRC_ADDR, CONST_ZERO			; Если в регистре SRC_ADDR ноль, то ожидаем байт адреса отправителя
	breq	_UART_RX_wait_for_src_addr_byte

	mov		r17, BYTE						; Если адреса заполнены, ожидаем команду
	andi	r17, 0xF0
	cp		r17, CONST_ZERO
	brne	_UART_RX_clear_proto			; Если полученный  байт не байт команды

	mov		DATA, BYTE
	rcall	input_command			
	rjmp	_UART_RX_clear_proto			; После выполнения команды очищаем регистры адресов и данных

	_UART_RX_wait_for_dst_addr_byte:
		cpi		BYTE, OUR_ADDR
		brne	_UART_RX_clear_proto
		mov		DST_ADDR, BYTE

		rjmp	_UART_RX_end

	_UART_RX_wait_for_src_addr_byte:
		cpi		BYTE, SERVER_ADDR
		brne	_UART_RX_clear_proto		; если команда не от сервера, игнорировать

		cpi		BYTE, OUR_ADDR
		breq	_UART_RX_clear_proto		; если отправитель мы, игнорировать

		mov		r17, BYTE
		andi	r17, 0xF0					
		cpi		r17, 0x10
		brne	_UART_RX_clear_proto		; Если полученный  байт не байт адреса, игнорировать
		mov		SRC_ADDR, BYTE

	_UART_RX_end:
		pop		BYTE
		pop		r17

	reti

	_UART_RX_clear_proto:
		clr		SRC_ADDR
		clr		DST_ADDR
		clr		DATA

		rjmp	_UART_RX_end

;========================================================
;			Прерывание по совпадению T1 A	
;========================================================

_TIM1_A:
	push	r17

	rcall	counter_connection
	rcall	counter_blink
	rcall	counter_ping_send

	cpi		STATE, STATE_OK
	breq	LED_0_state_connection

	cpi		STATE, STATE_WAITING_RESPONSE
	breq	LED_0_state_waiting_response

	cpi		STATE, STATE_WAITING_US
	breq	LED_0_state_waiting_us

	cpi		STATE, STATE_RECEIVED_RESPONSE
	breq	LED_0_state_received_response

	;-------------------------- Во всех остальных случаях, ошибка

	ldi		ZH, high(LED_0_MAGENTA_on)
	ldi		ZL, low(LED_0_MAGENTA_on)
	rcall	LED_0_toggle

	rjmp	LED_0_state_end

	;-------------------------- Нет запросов, проверяем соединение

	LED_0_state_connection:
		rcall	LED_0_off
		sbrc	CONN_STATE, 0
		rcall	LED_0_GREEN_on
		sbrs	CONN_STATE, 0
		rcall	LED_0_RED_on

		rjmp	LED_0_state_end

	;-------------------------- Ожидается ответ 

	LED_0_state_waiting_response:
		ldi		ZH, high(LED_0_BLUE_on)
		ldi		ZL, low(LED_0_BLUE_on)
		rcall	LED_0_toggle

		rjmp	LED_0_state_end

	;-------------------------- Ожидается ответ от нас

	LED_0_state_waiting_us:
		ldi		ZH, high(LED_0_RED_on)
		ldi		ZL, low(LED_0_RED_on)
		rcall	change_tim0_to_buzzer_mode
		rcall	LED_0_toggle

		rjmp	LED_0_state_end

	;-------------------------- Получен ответ

	LED_0_state_received_response:
		ldi		ZH, high(LED_0_YELLOW_on)
		ldi		ZL, low(LED_0_YELLOW_on)
		rcall	LED_0_toggle

	LED_0_state_end:
		pop		r17

	reti
