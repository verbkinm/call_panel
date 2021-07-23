;========================================================
;				 Модуль инициализации
;========================================================

init:
	;-------------------------- Инициализация стека
	
	ldi		r17, RAMEND			; Выбор адреса вершины стека 
	out		SPL, r17			; Запись его в регистр стека

	;--------------------------- Инициализация компаратора

	ldi 	r17, 0x80			; Выключение компаратора
	out		ACSR, r17

	;-------------------------- Инициализация Главного предделителя.

	ldi		r17, 0x80		    ; 
	out		CLKPR, r17			; 
	ldi		r17, 0x03			; Записываем 3 в регистр r17
	out		CLKPR, r17			; Записываем это число в CLKPR, указывая, что мы делим частоту на 8.

	;-------------------------- Инициализация портов ВВ по умолчанию (на вход с подтягивающим резистором)

	ser		r17
	out		PORTA, r17
	out		PORTB, r17
	out		PORTD, r17

	out		DDRA, CONST_ZERO
	out		DDRB, CONST_ZERO
	out		DDRD, CONST_ZERO

	;--------------------------- Инициализация USART. Формат кадра - 8 бит, передача и приём разрешены, прерывания по приёму.

	ldi 	r17, low(bauddivider)
	out 	UBRRL, r17
	ldi 	r17, high(bauddivider)
	out 	UBRRH, r17
 
	out 	UCSRA, r17
 
	ldi 	r17, (1 << RXEN) | (1 << TXEN) | (1 << RXCIE) | (0 << TXCIE) | (0 << UDRIE) | (0 << UCSZ2) 
	out 	UCSRB, r17
	
	ldi 	r17, (0 << UMSEL0) | (0 << UMSEL1) | (1 << UCSZ0) | (1 << UCSZ1) | (0 << UPM1) | (0 << UPM0) | (0 << USBS) | (0 << UCPOL)
	out 	UCSRC, r17

	;-------------------------- Инициализация кнопок

	cbi		DDR_BUTTON, BUTTON

	;-------------------------- Инициализация buzzer

	cbi		PORT_BUZZER, BUZZER
	sbi		DDR_BUZZER, BUZZER

	;-------------------------- Инициализация таймера TIM1 A

	ldi		r17, (1 << WGM12) | (1 << CS12) | (0 << CS11) | (1 << CS10) ; Выбор режима таймера (СТС, предделитель = 1024) 
	out		TCCR1B, r17

	ldi		r17, high(kdel1)	;
	out		OCR1AH, r17
	ldi		r17, low(kdel1)		 
	out		OCR1AL, r17

	;-------------------------- Инициализация таймера TIM0 A

	rcall	change_tim0_off

	;--------------------------- Разрешаем прерывание от таймеров

	ldi 	r17, (1 << OCIE1A) | (0 << OCIE0A)
	out		TIMSK, r17

	;--------------------------- Разрешаем прерывание INT0 и INT1 по заднему фронту

	ldi		r17, (1 << ISC01) | (0 << ISC00); | (1 << ISC11) | (0 << ISC10) 
	out		MCUCR, r17

	ldi		r17, (1 << INT0)
	out		GIMSK, r17

	;-------------------------- Очистка всех РОН

	clr		CONST_ZERO

	ldi		ZH, 0
	ldi		ZL, 2

	ldi		r17, 29					
	mov		r1, r17

	clear_reg:
		dec		r1
		breq	clear_reg_end
		st		Z+, CONST_ZERO
		rjmp	clear_reg
	clear_reg_end:

	clr ZL
