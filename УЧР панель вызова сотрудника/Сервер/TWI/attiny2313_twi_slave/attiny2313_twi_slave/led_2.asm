;========================================================
;			Процедуры для LED RGB
;========================================================

LED_2_off:
	cbi		DDR_LED_2, RED_LED_2
	cbi		DDR_LED_2, BLUE_LED_2
	cbi		DDR_LED_2, GREEN_LED_2

	sbi		PORT_LED_2, RED_LED_2
	sbi		PORT_LED_2, BLUE_LED_2
	sbi		PORT_LED_2, GREEN_LED_2

	;rcall	MCU_wait_10mks

	ret

LED_2_RED_on:
	sbi		DDR_LED_2, RED_LED_2
	cbi		PORT_LED_2, RED_LED_2

	ret

LED_2_GREEN_on:
	sbi		DDR_LED_2, GREEN_LED_2
	cbi		PORT_LED_2, GREEN_LED_2

	ret

LED_2_BLUE_on:
	sbi		DDR_LED_2, BLUE_LED_2
	cbi		PORT_LED_2, BLUE_LED_2

	ret

LED_2_YELLOW_on:
	rcall	LED_2_RED_on
	rcall	LED_2_GREEN_on

	ret

LED_2_MAGENTA_on:
	rcall	LED_2_RED_on
	rcall	LED_2_BLUE_on

	ret

LED_2_WHITE_BLUE_on:
	rcall	LED_2_GREEN_on
	rcall	LED_2_BLUE_on

	ret

LED_2_WHITE_on:
	rcall	LED_2_RED_on
	rcall	LED_2_GREEN_on
	rcall	LED_2_BLUE_on

	ret

;========================================================
;					Тест LED_2
;========================================================

LED_2_test:
	rcall	LED_2_test_ext1
	rcall	LED_2_RED_on
	rcall	LED_2_test_ext2

	rcall	LED_2_test_ext1
	rcall	LED_2_GREEN_on
	rcall	LED_2_test_ext2

	rcall	LED_2_test_ext1
	rcall	LED_2_BLUE_on
	rcall	LED_2_test_ext2

	rcall	LED_2_test_ext1
	rcall	LED_2_YELLOW_on
	rcall	LED_2_test_ext2

	rcall	LED_2_test_ext1
	rcall	LED_2_MAGENTA_on
	rcall	LED_2_test_ext2

	rcall	LED_2_test_ext1
	rcall	LED_2_WHITE_BLUE_on
	rcall	LED_2_test_ext2

	rcall	LED_2_test_ext1
	rcall	LED_2_WHITE_on
	rcall	LED_2_test_ext2

	rcall	LED_2_off

	ret

LED_2_test_ext1:
	rcall	LED_2_off
	rcall	MCU_wait_1000ms

	ret

LED_2_test_ext2:
	rcall	MCU_wait_1000ms

	ret

;========================================================
;	Переключить LED_2 на противоположное состояние.
;========================================================

LED_2_toggle:
	push	r17

	in		r17, DDR_LED_2
	andi	r17, (1 << RED_LED_2) | (1 << GREEN_LED_2) | (1 << BLUE_LED_2) ;0x58
	cpi		r17, 0x00
	breq	LED_2_toggle_enable

	rcall	LED_2_off

	rjmp	LED_2_toggle_end

	LED_2_toggle_enable:
		mov		r17, LED_2_cache
		rcall	LED_2_select_cmd

	LED_2_toggle_end:
		pop		r17
		
	ret

;========================================================
;	Выбор команды для LED_2
;	Команда - r17
;========================================================

LED_2_select_cmd:

	cpi		r17, 0x08
	breq	LED_2_select_cmd_toggle

	rcall	LED_2_off

	cpi		r17, 0x01
	breq	LED_2_select_cmd_red

	cpi		r17, 0x02
	breq	LED_2_select_cmd_green

	cpi		r17, 0x03
	breq	LED_2_select_cmd_blue

	cpi		r17, 0x04
	breq	LED_2_select_cmd_yellow

	cpi		r17, 0x05
	breq	LED_2_select_cmd_magenta

	cpi		r17, 0x06
	breq	LED_2_select_cmd_white_blue

	cpi		r17, 0x07
	breq	LED_2_select_cmd_white

	ret

	LED_2_select_cmd_red:
		rcall	LED_2_RED_on
		ldi		r17, 0x01
		mov		LED_2_cache, r17

		ret
	
	LED_2_select_cmd_green:
		rcall	LED_2_GREEN_on
		ldi		r17, 0x02
		mov		LED_2_cache, r17

		ret

	LED_2_select_cmd_blue:
		rcall	LED_2_BLUE_on
		ldi		r17, 0x03
		mov		LED_2_cache, r17

		ret

	LED_2_select_cmd_yellow:
		rcall	LED_2_YELLOW_on
		ldi		r17, 0x04
		mov		LED_2_cache, r17

		ret

	LED_2_select_cmd_magenta:
		rcall	LED_2_MAGENTA_on
		ldi		r17, 0x05
		mov		LED_2_cache, r17

		ret

	LED_2_select_cmd_white_blue:
		rcall	LED_2_WHITE_BLUE_on
		ldi		r17, 0x06
		mov		LED_2_cache, r17

		ret

	LED_2_select_cmd_white:
		rcall	LED_2_WHITE_on
		ldi		r17, 0x07
		mov		LED_2_cache, r17

		ret

	LED_2_select_cmd_toggle:
		rcall	LED_2_toggle

	ret
