;------------------------- USART

.equ 	XTAL = 1000000
.equ 	baudrate = 4800
.equ 	bauddivider = XTAL / (16 * baudrate) - 1

;------------------------- Предделители для таймеров

.equ	kdel1			= 487		; (0,5 сек. для 16-битного таймера на 1МГц)
.equ	kdel2			= 58593		; (60 сек. для 16-битного таймера на 1МГц)
.equ	kdel3			= 233		; (240 мс для 8-битного таймера на 1МГц)
.equ	kdel4			= 125		; (1000 Гц для 8-битного таймера на 1МГц)


;------------------------- Светодиоды

.equ	PORT_LED_0		= PORTB
.equ	DDR_LED_0		= DDRB
.equ	PIN_LED_0		= PINB

.equ	RED_LED_0		= PB5
.equ	GREEN_LED_0		= PB6
.equ	BLUE_LED_0		= PB7

;------------------------- Регистры/описания для зуммера

.equ	PORT_BUZZER		= PORTB
.equ	DDR_BUZZER		= DDRB
.equ	PIN_BUZZER		= PINB
.equ	BUZZER			= PB2

;------------------------- Регистры/описания для работы с кнопками

.equ	PORT_BUTTON		= PORTD
.equ	DDR_BUTTON		= DDRD
.equ	PIN_BUTTON		= PIND
.equ	BUTTON			= PD2
