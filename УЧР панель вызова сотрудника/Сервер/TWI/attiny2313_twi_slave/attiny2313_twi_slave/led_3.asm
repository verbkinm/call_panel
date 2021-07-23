;========================================================
;			Процедуры для LED RGB
;========================================================

LED_3_off:
	cbi		DDR_LED_3, RED_LED_3
	cbi		DDR_LED_3, BLUE_LED_3
	cbi		DDR_LED_3, GREEN_LED_3

	sbi		PORT_LED_3, RED_LED_3
	sbi		PORT_LED_3, BLUE_LED_3
	sbi		PORT_LED_3, GREEN_LED_3

	;rcall	MCU_wait_10mks

	ret

LED_3_RED_on:
	sbi		DDR_LED_3, RED_LED_3
	cbi		PORT_LED_3, RED_LED_3

	ret

LED_3_GREEN_on:
	sbi		DDR_LED_3, GREEN_LED_3
	cbi		PORT_LED_3, GREEN_LED_3

	ret

LED_3_BLUE_on:
	sbi		DDR_LED_3, BLUE_LED_3
	cbi		PORT_LED_3, BLUE_LED_3

	ret

LED_3_YELLOW_on:
	rcall	LED_3_RED_on
	rcall	LED_3_GREEN_on

	ret

LED_3_MAGENTA_on:
	rcall	LED_3_RED_on
	rcall	LED_3_BLUE_on

	ret

LED_3_WHITE_BLUE_on:
	rcall	LED_3_GREEN_on
	rcall	LED_3_BLUE_on

	ret

LED_3_WHITE_on:
	rcall	LED_3_RED_on
	rcall	LED_3_GREEN_on
	rcall	LED_3_BLUE_on

	ret

;========================================================
;					Тест LED_3
;========================================================

LED_3_test:
	rcall	LED_3_test_ext1
	rcall	LED_3_RED_on
	rcall	LED_3_test_ext2

	rcall	LED_3_test_ext1
	rcall	LED_3_GREEN_on
	rcall	LED_3_test_ext2

	rcall	LED_3_test_ext1
	rcall	LED_3_BLUE_on
	rcall	LED_3_test_ext2

	rcall	LED_3_test_ext1
	rcall	LED_3_YELLOW_on
	rcall	LED_3_test_ext2

	rcall	LED_3_test_ext1
	rcall	LED_3_MAGENTA_on
	rcall	LED_3_test_ext2

	rcall	LED_3_test_ext1
	rcall	LED_3_WHITE_BLUE_on
	rcall	LED_3_test_ext2

	rcall	LED_3_test_ext1
	rcall	LED_3_WHITE_on
	rcall	LED_3_test_ext2

	rcall	LED_3_off

	ret

LED_3_test_ext1:
	rcall	LED_3_off
	rcall	MCU_wait_1000ms

	ret

LED_3_test_ext2:
	rcall	MCU_wait_1000ms

	ret

;========================================================
;	Переключить LED_3 на противоположное состояние.
;========================================================

LED_3_toggle:
	push	r17

	in		r17, DDR_LED_3
	andi	r17, (1 << RED_LED_3) | (1 << GREEN_LED_3) | (1 << BLUE_LED_3) ;0x58
	cpi		r17, 0x00
	breq	LED_3_toggle_enable

	rcall	LED_3_off

	rjmp	LED_3_toggle_end

	LED_3_toggle_enable:
		mov		r17, LED_3_cache
		rcall	LED_3_select_cmd

	LED_3_toggle_end:
		pop		r17
		
	ret

;========================================================
;	Выбор команды для LED_3
;	Команда - r17
;========================================================

LED_3_select_cmd:

	cpi		r17, 0x08
	breq	LED_3_select_cmd_toggle

	rcall	LED_3_off

	cpi		r17, 0x01
	breq	LED_3_select_cmd_red

	cpi		r17, 0x02
	breq	LED_3_select_cmd_green

	cpi		r17, 0x03
	breq	LED_3_select_cmd_blue

	cpi		r17, 0x04
	breq	LED_3_select_cmd_yellow

	cpi		r17, 0x05
	breq	LED_3_select_cmd_magenta

	cpi		r17, 0x06
	breq	LED_3_select_cmd_white_blue

	cpi		r17, 0x07
	breq	LED_3_select_cmd_white

	ret

	LED_3_select_cmd_red:
		rcall	LED_3_RED_on
		ldi		r17, 0x01
		mov		LED_3_cache, r17

		ret
	
	LED_3_select_cmd_green:
		rcall	LED_3_GREEN_on
		ldi		r17, 0x02
		mov		LED_3_cache, r17

		ret

	LED_3_select_cmd_blue:
		rcall	LED_3_BLUE_on
		ldi		r17, 0x03
		mov		LED_3_cache, r17

		ret

	LED_3_select_cmd_yellow:
		rcall	LED_3_YELLOW_on
		ldi		r17, 0x04
		mov		LED_3_cache, r17

		ret

	LED_3_select_cmd_magenta:
		rcall	LED_3_MAGENTA_on
		ldi		r17, 0x05
		mov		LED_3_cache, r17

		ret

	LED_3_select_cmd_white_blue:
		rcall	LED_3_WHITE_BLUE_on
		ldi		r17, 0x06
		mov		LED_3_cache, r17

		ret

	LED_3_select_cmd_white:
		rcall	LED_3_WHITE_on
		ldi		r17, 0x07
		mov		LED_3_cache, r17

		ret

	LED_3_select_cmd_toggle:
		rcall	LED_3_toggle

	ret
