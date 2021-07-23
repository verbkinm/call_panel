;========================================================
;		Инкремент\сброс счетчика для определения 
;				состояния соединения		
;========================================================

counter_connection:
	push	r17
	inc		counter_CONN_STATE
	mov		r17, counter_CONN_STATE
	cpi		r17, 20
	brsh	counter_connection_clear
	rjmp	counter_connection_end

	counter_connection_clear:
		clr		counter_CONN_STATE
		ldi		CONN_STATE, DISCONNECTED
		ldi		STATE, STATE_OK

	counter_connection_end:
		pop		r17

	ret

;========================================================
;		Инкремент\сброс счетчика для определения 
;				состояния мигания led		
;========================================================

counter_blink:
	push	r17

	cpi		STATE, STATE_RECEIVED_RESPONSE
	brne	counter_blink_end

	inc		counter_BLINK_TIME
	mov		r17, counter_BLINK_TIME
	cpi		r17, 20
	brsh	counter_blink_clear
	rjmp	counter_blink_end

	counter_blink_clear:
		clr		counter_BLINK_TIME
		ldi		STATE, STATE_OK

	counter_blink_end:
		pop		r17

	ret

;========================================================
;			Инкремент\сброс счетчика для 
;				отправки PING		
;========================================================

counter_ping_send:
	push	r17

	inc		counter_PING
	mov		r17, counter_PING
	cpi		r17, 10
	brsh	counter_ping_send_clear

	rjmp	counter_ping_send_end

	counter_ping_send_clear:
		clr		counter_PING
		ldi		BYTE, CMD_PING
		rcall	USART_send_package

	counter_ping_send_end:
		pop		r17

	ret