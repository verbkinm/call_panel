;========================================================
;			???????????? ???????????? ????????
;				??? ??????? ?? ? 1???
;========================================================

;========================================================
;						10 ???
;========================================================

MCU_wait_10mks:						
	nop
	nop
	nop

	ret

;========================================================
;			???????????? ???????????? ????????
;				199?096 ?????? ~ 200 ??
;========================================================

MCU_wait_200ms:						
	push	r17
	push	r16

	ldi		r17, 60
	ser		r16

	MCU_wait_200ms_loop_L:
		rcall	MCU_wait_10mks
		dec		r16
		brne	MCU_wait_200ms_loop_L

	MCU_wait_200ms_loop_H:
		ser		r16
		dec		r17
		brne	MCU_wait_200ms_loop_L

	pop		r16
	pop		r17

	ret

;========================================================
;			???????????? ???????????? ????????
;				995 487 ?????? ~ 1 ???.
;========================================================
MCU_wait_1000ms:
	rcall	MCU_wait_200ms
	rcall	MCU_wait_200ms
	rcall	MCU_wait_200ms
	rcall	MCU_wait_200ms
	rcall	MCU_wait_200ms

	ret

