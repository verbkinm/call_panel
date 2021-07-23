;========================================================
; twi master_transfer
; входящее r17 (usisr_8bit или usisr_1bit)
; исходящее byte
;========================================================
twi_transfer:

	out		usisr, r17
	ldi		r17, (0 << usisie) | (0 << usioie) | (1 << usiwm1) | (0 << usiwm0) | (1 << usics1) | (0 << usics0) | (0 << usiclk) | (1 << usitc)

	loop_send:
		rcall	mcu_wait_10mks
		out		usicr, r17

		sbis	usisr, usioif
		rjmp	loop_send

	rcall	mcu_wait_10mks
	in		byte, usidr

	ret

;========================================================
; TWI recive
; исходящее BYTE
;========================================================

twi_recive_byte:
	push	r17

	cbi		twi_DDR, twi_SDA

	ldi		r17,  USISR_8BIT
	rcall	twi_transfer
	push	BYTE

		pop		BYTE
		pop		r17

	ret

/*;========================================================
; Установка бита NACK_ACK
;========================================================

twi_send_ack:
	push	r17

	ldi		r17, 0x00
	out		USIDR, r17

	sbi		twi_DDR, twi_SDA
	ldi		r17,  USISR_1BIT
	rcall	twi_transfer
	;rcall	mcu_wait_10mks
	cbi		twi_DDR, twi_SDA

	pop		r17

	ret

twi_send_nack:
	push	r17

	ldi		r17, 0xFF
	out		USIDR, r17

	sbi		twi_DDR, twi_SDA
	ldi		r17,  USISR_1BIT
	rcall	twi_transfer
	;rcall	mcu_wait_10mks
	cbi		twi_DDR, twi_SDA

	pop		r17

	ret
*/