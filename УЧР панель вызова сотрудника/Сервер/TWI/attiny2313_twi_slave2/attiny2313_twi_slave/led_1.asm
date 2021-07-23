;========================================================
;			Процедуры для LED RGB
;========================================================

LED_1_off:
	cbi		DDR_LED_1, RED_LED_1
	cbi		DDR_LED_1, BLUE_LED_1
	cbi		DDR_LED_1, GREEN_LED_1

	sbi		PORT_LED_1, RED_LED_1
	sbi		PORT_LED_1, BLUE_LED_1
	sbi		PORT_LED_1, GREEN_LED_1

	;rcall	MCU_wait_10mks

	ret

LED_1_RED_on:
	sbi		DDR_LED_1, RED_LED_1
	cbi		PORT_LED_1, RED_LED_1

	ret

LED_1_GREEN_on:
	sbi		DDR_LED_1, GREEN_LED_1
	cbi		PORT_LED_1, GREEN_LED_1

	ret

LED_1_BLUE_on:
	sbi		DDR_LED_1, BLUE_LED_1
	cbi		PORT_LED_1, BLUE_LED_1

	ret

LED_1_YELLOW_on:
	rcall	LED_1_RED_on
	rcall	LED_1_GREEN_on

	ret

LED_1_MAGENTA_on:
	rcall	LED_1_RED_on
	rcall	LED_1_BLUE_on

	ret

LED_1_WHITE_BLUE_on:
	rcall	LED_1_GREEN_on
	rcall	LED_1_BLUE_on

	ret

LED_1_WHITE_on:
	rcall	LED_1_RED_on
	rcall	LED_1_GREEN_on
	rcall	LED_1_BLUE_on

	ret

;========================================================
;					Тест LED_1
;========================================================

LED_1_test:
	rcall	LED_1_test_ext1
	rcall	LED_1_RED_on
	rcall	LED_1_test_ext2

	rcall	LED_1_test_ext1
	rcall	LED_1_GREEN_on
	rcall	LED_1_test_ext2

	rcall	LED_1_test_ext1
	rcall	LED_1_BLUE_on
	rcall	LED_1_test_ext2

	rcall	LED_1_test_ext1
	rcall	LED_1_YELLOW_on
	rcall	LED_1_test_ext2

	rcall	LED_1_test_ext1
	rcall	LED_1_MAGENTA_on
	rcall	LED_1_test_ext2

	rcall	LED_1_test_ext1
	rcall	LED_1_WHITE_BLUE_on
	rcall	LED_1_test_ext2

	rcall	LED_1_test_ext1
	rcall	LED_1_WHITE_on
	rcall	LED_1_test_ext2

	rcall	LED_1_off

	ret

LED_1_test_ext1:
	rcall	LED_1_off
	rcall	MCU_wait_1000ms

	ret

LED_1_test_ext2:
	rcall	MCU_wait_1000ms

	ret

;========================================================
;	Переключить LED_0 на противоположное состояние.
;========================================================

LED_1_toggle:
	push	r17

	in		r17, DDR_LED_1
	andi	r17, (1 << RED_LED_1) | (1 << GREEN_LED_1) | (1 << BLUE_LED_1) 
	cpi		r17, 0x00
	breq	LED_1_toggle_enable

	rcall	LED_1_off

	rjmp	LED_1_toggle_end

	LED_1_toggle_enable:
		mov		r17, LED_1_cache
		rcall	LED_1_select_cmd

	LED_1_toggle_end:
		pop		r17
		
	ret

;========================================================
;	Выбор команды для LED_0
;	Команда - r17
;========================================================

LED_1_select_cmd:

	cpi		r17, 0x08
	breq	LED_1_select_cmd_toggle

	rcall	LED_1_off

	cpi		r17, 0x01
	breq	LED_1_select_cmd_red

	cpi		r17, 0x02
	breq	LED_1_select_cmd_green

	cpi		r17, 0x03
	breq	LED_1_select_cmd_blue

	cpi		r17, 0x04
	breq	LED_1_select_cmd_yellow

	cpi		r17, 0x05
	breq	LED_1_select_cmd_magenta

	cpi		r17, 0x06
	breq	LED_1_select_cmd_white_blue

	cpi		r17, 0x07
	breq	LED_1_select_cmd_white

	ret

	LED_1_select_cmd_red:
		rcall	LED_1_RED_on
		ldi		r17, 0x01
		mov		LED_1_cache, r17

		ret
	
	LED_1_select_cmd_green:
		rcall	LED_1_GREEN_on
		ldi		r17, 0x02
		mov		LED_1_cache, r17

		ret

	LED_1_select_cmd_blue:
		rcall	LED_1_BLUE_on
		ldi		r17, 0x03
		mov		LED_1_cache, r17

		ret

	LED_1_select_cmd_yellow:
		rcall	LED_1_YELLOW_on
		ldi		r17, 0x04
		mov		LED_1_cache, r17

		ret

	LED_1_select_cmd_magenta:
		rcall	LED_1_MAGENTA_on
		ldi		r17, 0x05
		mov		LED_1_cache, r17

		ret

	LED_1_select_cmd_white_blue:
		rcall	LED_1_WHITE_BLUE_on
		ldi		r17, 0x06
		mov		LED_1_cache, r17

		ret

	LED_1_select_cmd_white:
		rcall	LED_1_WHITE_on
		ldi		r17, 0x07
		mov		LED_1_cache, r17

		ret

	LED_1_select_cmd_toggle:
		rcall	LED_1_toggle

	ret
