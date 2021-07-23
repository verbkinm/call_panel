;========================================================
;		Прерывание UART - приём завершен	
;========================================================

_UART_RX:
	push	r17
	push	BYTE

	in		BYTE, UDR	
	ldi		r17, 0x04

	rcall	twi_write_one_byte
	rcall	twi_stop
	
	_UART_RX_end:
		pop		BYTE
		pop		r17

	reti
