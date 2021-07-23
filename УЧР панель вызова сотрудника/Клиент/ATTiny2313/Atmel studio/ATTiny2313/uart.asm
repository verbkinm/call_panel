;========================================================
;		Процедура отправки байта из регистра BYTE
;========================================================

USART_Transmit:	
	sbis 	UCSRA, UDRE		; пропуск если нет флага готовности
	rjmp	USART_Transmit 	; ждем готовности - флага udre
 
	out		UDR, BYTE		; шлём байт

	ret					

;========================================================
;		Процедура отправки команды от нас серверу
;				Входящее - BYTE 
;========================================================

USART_send_package:
	push	BYTE

	ldi		BYTE, SERVER_ADDR
	rcall	USART_Transmit

	ldi		BYTE, OUR_ADDR
	rcall	USART_Transmit

	pop		BYTE
	rcall	USART_Transmit

	ret
