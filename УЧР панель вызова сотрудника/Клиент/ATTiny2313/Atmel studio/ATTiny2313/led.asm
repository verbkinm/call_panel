;========================================================
;			Процедуры для LED RGB
;========================================================

LED_0_off:
	rcall	change_tim0_off

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
	rcall	change_tim0_to_buzzer_mode
	rcall	MCU_wait_1000ms

	ret

;========================================================
;	Переключить LED_0 на противоположное состояние.
;	Входящее: Z - адрес процедуры для включения LED_0
;========================================================

LED_0_toggle:
	push	r17

	in		r17, DDR_LED_0
	andi	r17, 0xE0
	cpi		r17, 0x00
	breq	LED_0_toggle_enable

	rcall	LED_0_off

	rjmp	LED_0_state_end

	LED_0_toggle_enable:
		icall

	LED_0_toggle_end:
		pop		r17
		
	ret