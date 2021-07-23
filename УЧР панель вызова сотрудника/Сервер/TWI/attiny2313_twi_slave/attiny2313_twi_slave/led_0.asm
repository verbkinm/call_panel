;========================================================
;			Процедуры для LED RGB
;========================================================

LED_0_off:
	cbi		DDR_LED_0, RED_LED_0
	cbi		DDR_LED_0, BLUE_LED_0
	cbi		DDR_LED_0, GREEN_LED_0

	sbi		PORT_LED_0, RED_LED_0
	sbi		PORT_LED_0, BLUE_LED_0
	sbi		PORT_LED_0, GREEN_LED_0

	;rcall	MCU_wait_10mks

	ret

LED_0_RED_on:
	sbi		DDR_LED_0, RED_LED_0
	cbi		PORT_LED_0, RED_LED_0

	ret

LED_0_GREEN_on:
	sbi		DDR_LED_0, GREEN_LED_0
	cbi		PORT_LED_0, GREEN_LED_0

	ret

LED_0_BLUE_on:
	sbi		DDR_LED_0, BLUE_LED_0
	cbi		PORT_LED_0, BLUE_LED_0

	ret

LED_0_YELLOW_on:
	rcall	LED_0_RED_on
	rcall	LED_0_GREEN_on

	ret

LED_0_MAGENTA_on:
	rcall	LED_0_RED_on
	rcall	LED_0_BLUE_on

	ret

LED_0_WHITE_BLUE_on:
	rcall	LED_0_GREEN_on
	rcall	LED_0_BLUE_on

	pop		r17

	ret

LED_0_WHITE_on:
	rcall	LED_0_RED_on
	rcall	LED_0_GREEN_on
	rcall	LED_0_BLUE_on

	ret

;========================================================
;					Тест LED_0
;========================================================

LED_0_test:
	rcall	LED_0_test_ext1
	rcall	LED_0_RED_on
	rcall	LED_0_test_ext2

	rcall	LED_0_test_ext1
	rcall	LED_0_GREEN_on
	rcall	LED_0_test_ext2

	rcall	LED_0_test_ext1
	rcall	LED_0_BLUE_on
	rcall	LED_0_test_ext2

	rcall	LED_0_test_ext1
	rcall	LED_0_YELLOW_on
	rcall	LED_0_test_ext2

	rcall	LED_0_test_ext1
	rcall	LED_0_MAGENTA_on
	rcall	LED_0_test_ext2

	rcall	LED_0_test_ext1
	rcall	LED_0_WHITE_BLUE_on
	rcall	LED_0_test_ext2

	rcall	LED_0_test_ext1
	rcall	LED_0_WHITE_on
	rcall	LED_0_test_ext2

	rcall	LED_0_off

	ret

LED_0_test_ext1:
	rcall	LED_0_off
	rcall	MCU_wait_1000ms

	ret

LED_0_test_ext2:
	rcall	MCU_wait_1000ms

	ret

;========================================================
;	Переключить LED_0 на противоположное состояние.
;========================================================

LED_0_toggle:
	push	r17

	in		r17, DDR_LED_0
	andi	r17, (1 << RED_LED_0) | (1 << GREEN_LED_0) | (1 << BLUE_LED_0) ;0x58
	cpi		r17, 0x00
	breq	LED_0_toggle_enable

	rcall	LED_0_off

	rjmp	LED_0_toggle_end

	LED_0_toggle_enable:
		mov		r17, LED_0_cache
		rcall	LED_0_select_cmd

	LED_0_toggle_end:
		pop		r17
		
	ret

;========================================================
;	Выбор команды для LED_0
;	Команда - r17
;========================================================

LED_0_select_cmd:

	cpi		r17, 0x08
	breq	LED_0_select_cmd_toggle

	rcall	LED_0_off

	cpi		r17, 0x01
	breq	LED_0_select_cmd_red

	cpi		r17, 0x02
	breq	LED_0_select_cmd_green

	cpi		r17, 0x03
	breq	LED_0_select_cmd_blue

	cpi		r17, 0x04
	breq	LED_0_select_cmd_yellow

	cpi		r17, 0x05
	breq	LED_0_select_cmd_magenta

	cpi		r17, 0x06
	breq	LED_0_select_cmd_white_blue

	cpi		r17, 0x07
	breq	LED_0_select_cmd_white

	ret

	LED_0_select_cmd_red:
		rcall	LED_0_RED_on
		ldi		r17, 0x01
		mov		LED_0_cache, r17

		ret
	
	LED_0_select_cmd_green:
		rcall	LED_0_GREEN_on
		ldi		r17, 0x02
		mov		LED_0_cache, r17

		ret

	LED_0_select_cmd_blue:
		rcall	LED_0_BLUE_on
		ldi		r17, 0x03
		mov		LED_0_cache, r17

		ret

	LED_0_select_cmd_yellow:
		rcall	LED_0_YELLOW_on
		ldi		r17, 0x04
		mov		LED_0_cache, r17

		ret

	LED_0_select_cmd_magenta:
		rcall	LED_0_MAGENTA_on
		ldi		r17, 0x05
		mov		LED_0_cache, r17

		ret

	LED_0_select_cmd_white_blue:
		rcall	LED_0_WHITE_BLUE_on
		ldi		r17, 0x06
		mov		LED_0_cache, r17

		ret

	LED_0_select_cmd_white:
		rcall	LED_0_WHITE_on
		ldi		r17, 0x07
		mov		LED_0_cache, r17

		ret

	LED_0_select_cmd_toggle:
		rcall	LED_0_toggle

	ret
