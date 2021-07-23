.equ 	XTAL = 1000000
.equ 	baudrate = 4800
.equ 	bauddivider = XTAL / (16 * baudrate) - 1

.equ	twi_PORT	=	PORTB
.equ	twi_DDR		=	DDRB
.equ	twi_SCL		=	PB7
.equ	twi_SDA		=	PB5
.equ	twi_PIN		=	PINB

.equ	USISR_8BIT	=	0xF0
.equ	USISR_1BIT	=	0xFE


.equ	OUR_ADDR	=	0x02


;------------------------- Светодиоды

;------------------------- LED_0

.equ	PORT_LED_0		= PORTB
.equ	DDR_LED_0		= DDRB
.equ	PIN_LED_0		= PINB

.equ	RED_LED_0		= PB6
.equ	GREEN_LED_0		= PB4
.equ	BLUE_LED_0		= PB3

;------------------------- LED_1

.equ	PORT_LED_1		= PORTB
.equ	DDR_LED_1		= DDRB
.equ	PIN_LED_1		= PINB

.equ	RED_LED_1		= PB2
.equ	GREEN_LED_1		= PB1
.equ	BLUE_LED_1		= PB0

;------------------------- LED_2

.equ	PORT_LED_2		= PORTD
.equ	DDR_LED_2		= DDRD
.equ	PIN_LED_2		= PIND

.equ	RED_LED_2		= PD4
.equ	GREEN_LED_2		= PD5
.equ	BLUE_LED_2		= PD6

;------------------------- LED_3

.equ	PORT_LED_3		= PORTD
.equ	DDR_LED_3		= DDRD
.equ	PIN_LED_3		= PIND

.equ	RED_LED_3		= PD1
.equ	GREEN_LED_3		= PD2
.equ	BLUE_LED_3		= PD3

;------------------------- LED_4

.equ	PORT_LED_4RG	= PORTA
.equ	PORT_LED_4B		= PORTD
.equ	DDR_LED_4RG		= DDRA
.equ	DDR_LED_4B		= DDRD
.equ	PIN_LED_4RG		= PINA
.equ	PIN_LED_4B		= PIND

.equ	RED_LED_4		= PA0
.equ	GREEN_LED_4		= PA1
.equ	BLUE_LED_4		= PD0
