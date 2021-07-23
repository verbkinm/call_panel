;========================================================
;			Процедуры для LED RGB
;========================================================

LED_4_off:
	cbi		DDR_LED_4RG, RED_LED_4
	cbi		DDR_LED_4B, BLUE_LED_4
	cbi		DDR_LED_4RG, GREEN_LED_4

	sbi		PORT_LED_4RG, RED_LED_4
	sbi		PORT_LED_4B, BLUE_LED_4
	sbi		PORT_LED_4RG, GREEN_LED_4

	;rcall	MCU_wait_10mks

	ret

LED_4_RED_on:
	sbi		DDR_LED_4RG, RED_LED_4
	cbi		PORT_LED_4RG, RED_LED_4

	ret

LED_4_GREEN_on:
	sbi		DDR_LED_4RG, GREEN_LED_4
	cbi		PORT_LED_4RG, GREEN_LED_4

	ret

LED_4_BLUE_on:
	sbi		DDR_LED_4B, BLUE_LED_4
	cbi		PORT_LED_4B, BLUE_LED_4

	ret

LED_4_YELLOW_on:
	rcall	LED_4_RED_on
	rcall	LED_4_GREEN_on

	ret

LED_4_MAGENTA_on:
	rcall	LED_4_RED_on
	rcall	LED_4_BLUE_on

	ret

LED_4_WHITE_BLUE_on:
	rcall	LED_4_GREEN_on
	rcall	LED_4_BLUE_on

	ret

LED_4_WHITE_on:
	rcall	LED_4_RED_on
	rcall	LED_4_GREEN_on
	rcall	LED_4_BLUE_on

	ret

;========================================================
;					Тест LED_4
;========================================================

LED_4_test:
	rcall	LED_4_test_ext1
	rcall	LED_4_RED_on
	rcall	LED_4_test_ext2

	rcall	LED_4_test_ext1
	rcall	LED_4_GREEN_on
	rcall	LED_4_test_ext2

	rcall	LED_4_test_ext1
	rcall	LED_4_BLUE_on
	rcall	LED_4_test_ext2

	rcall	LED_4_test_ext1
	rcall	LED_4_YELLOW_on
	rcall	LED_4_test_ext2

	rcall	LED_4_test_ext1
	rcall	LED_4_MAGENTA_on
	rcall	LED_4_test_ext2

	rcall	LED_4_test_ext1
	rcall	LED_4_WHITE_BLUE_on
	rcall	LED_4_test_ext2

	rcall	LED_4_test_ext1
	rcall	LED_4_WHITE_on
	rcall	LED_4_test_ext2

	rcall	LED_4_off

	ret

LED_4_test_ext1:
	rcall	LED_4_off
	rcall	MCU_wait_1000ms

	ret

LED_4_test_ext2:
	rcall	MCU_wait_1000ms

	ret

;========================================================
;	Переключить LED_4 на противоположное состояние.
;	
;========================================================

LED_4_toggle:
	push	r17
	push	r16

	in		r17, DDR_LED_4RG
	andi	r17, (1 << RED_LED_4) | (1 << GREEN_LED_4)
	in		r16, DDR_LED_4B
	andi	r16, (1 << BLUE_LED_4)

	add		r17, r16

	cpi		r17, 0x00
	breq	LED_4_toggle_enable

	rcall	LED_4_off

	rjmp	LED_4_toggle_end

	LED_4_toggle_enable:
		mov		r17, LED_4_cache
		rcall	LED_4_select_cmd

	LED_4_toggle_end:
		pop		r16
		pop		r17
		
	ret
	
;========================================================
;	Выбор команды для LED_4
;	Команда - r17
;========================================================
LED_4_select_cmd:
	cpi		r17, 0x08
	breq	LED_4_select_cmd_toggle

	rcall	LED_4_off

	cpi		r17, 0x01
	breq	LED_4_select_cmd_red

	cpi		r17, 0x02
	breq	LED_4_select_cmd_green

	cpi		r17, 0x03
	breq	LED_4_select_cmd_blue

	cpi		r17, 0x04
	breq	LED_4_select_cmd_yellow

	cpi		r17, 0x05
	breq	LED_4_select_cmd_magenta

	cpi		r17, 0x06
	breq	LED_4_select_cmd_white_blue

	cpi		r17, 0x07
	breq	LED_4_select_cmd_white

	ret

	LED_4_select_cmd_red:
		rcall	LED_4_RED_on
		ldi		r17, 0x01
		mov		LED_4_cache, r17

		ret
	
	LED_4_select_cmd_green:
		rcall	LED_4_GREEN_on
		ldi		r17, 0x02
		mov		LED_4_cache, r17

		ret

	LED_4_select_cmd_blue:
		rcall	LED_4_BLUE_on
		ldi		r17, 0x03
		mov		LED_4_cache, r17

		ret

	LED_4_select_cmd_yellow:
		rcall	LED_4_YELLOW_on
		ldi		r17, 0x04
		mov		LED_4_cache, r17

		ret

	LED_4_select_cmd_magenta:
		rcall	LED_4_MAGENTA_on
		ldi		r17, 0x05
		mov		LED_4_cache, r17

		ret

	LED_4_select_cmd_white_blue:
		rcall	LED_4_WHITE_BLUE_on
		ldi		r17, 0x06
		mov		LED_4_cache, r17

		ret

	LED_4_select_cmd_white:
		rcall	LED_4_WHITE_on
		ldi		r17, 0x07
		mov		LED_4_cache, r17

		ret

	LED_4_select_cmd_toggle:
		rcall	LED_4_toggle

	ret
