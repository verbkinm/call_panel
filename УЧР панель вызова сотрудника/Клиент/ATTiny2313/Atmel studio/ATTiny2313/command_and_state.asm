;========================================================
;			 Выполнение полученной команды
;========================================================

input_command:
	push	r17

	mov		r17, DATA

	cpi		r17, CMD_PING
	breq	input_command_ping

	cpi		CONN_STATE, CONNECTED
	brne	input_command_end

	cpi		r17, CMD_QUERY
	breq	input_command_query

	cpi		r17, CMD_CANCEL_QUERY
	breq	input_command_cancel_query

	cpi		r17, CMD_RESPONSE_TO_QUERY
	breq	input_command_response_to_request

	rjmp	input_command_end

	;-------------------------- Пришел пинг

	input_command_ping:
		ldi		CONN_STATE, CONNECTED
		clr		counter_CONN_STATE

		rjmp	input_command_end

	;-------------------------- Пришел запрос

	input_command_query:
		cpi		STATE, STATE_OK
		breq	input_command_query_ok
		cpi		STATE, STATE_RECEIVED_RESPONSE
		breq	input_command_query_ok
		cpi		STATE, STATE_ERROR
		breq	input_command_query_ok

		rjmp	input_command_error

		input_command_query_ok:
			ldi		STATE, STATE_WAITING_US

		rjmp	input_command_end

	;-------------------------- Пришла команда отмены

	input_command_cancel_query:
		cpi		STATE, STATE_WAITING_US
		brne	input_command_error
		ldi		STATE, STATE_OK

		rjmp	input_command_end

	;-------------------------- Пришел ответ

	input_command_response_to_request:
		cpi		STATE, STATE_WAITING_RESPONSE
		brne	input_command_error

		ldi		STATE, STATE_RECEIVED_RESPONSE

	input_command_end:
		pop		r17

	ret

input_command_error:
	ldi		STATE, STATE_ERROR

	rjmp	input_command_end