;========================================================
;				 ������ �������������
;========================================================

init:

	;-------------------------- ������������� �����
	
	ldi		r17, RAMEND			; ����� ������ ������� ����� 
	out		SPL, r17			; ������ ��� � ������� �����

	;--------------------------- ������������� �����������

	ldi 	r17, 0x80			; ���������� �����������
	out		ACSR, r17

	;-------------------------- ������������� �������� ������������

	ldi		r17, 0x80		    ; 
	out		CLKPR, r17			; 
	ldi		r17, 0x03			; ���������� 3 � ������� r17
	out		CLKPR, r17			; ���������� ��� ����� � CLKPR, ��������, ��� �� ����� ������� �� 8.

	;-------------------------- ������������� ������ �� �� ��������� (�� ���� � ������������� ����������)

	ser		r17
	out		PORTA, r17
	out		PORTB, r17
	out		PORTD, r17

	out		DDRA, CONST_ZERO
	out		DDRB, CONST_ZERO
	out		DDRD, CONST_ZERO

	;-------------------------- ������������� TWI

	sbi		twi_DDR, twi_SCL
	sbi		twi_DDR, twi_SDA

	ldi		r17, (0<<USISIE)|(0<<USIOIE)|(1<<USIWM1)|(0<<USIWM0)|(1<<USICS1)|(0<<USICS0)|(1<<USICLK)|(0<<USITC)
	out		USICR, r17

	ldi		r17, (1<<USISIF)|(1<<USIOIF)|(1<<USIPF)|(1<<USIDC)|(0x0<<USICNT0)
	out		USISR, r17

	sbi		twi_PORT, twi_SCL
	sbi		twi_PORT, twi_SDA

	;--------------------------- ��������� ����� ��� (idle)

	ldi		r17, 1 << SE
	out		MCUCR, r17
	
	;--------------------------- ������������� USART

	ldi 	r17, low(bauddivider)
	out 	UBRRL, r17
	ldi 	r17, high(bauddivider)
	out 	UBRRH, r17
 
	out 	UCSRA, r17
 
	ldi 	r17, (1 << RXEN) | (1 << TXEN) | (1 << RXCIE) | (0 << TXCIE) | (0 << UDRIE) | (0 << UCSZ2) ; �������� � ���� ���������, ���������� �� ����� ����� ��������.
	out 	UCSRB, r17
	
	;������ ����� - 8 ���, ����� � ������� ucsrc, �� ��� �������� ��� ��������
	ldi 	r17, (0 << UMSEL0) | (0 << UMSEL1) | (1 << UCSZ0) | (1 << UCSZ1) | (0 << UPM1) | (0 << UPM0) | (0 << USBS) | (0 << UCPOL)
	out 	UCSRC, r17
		