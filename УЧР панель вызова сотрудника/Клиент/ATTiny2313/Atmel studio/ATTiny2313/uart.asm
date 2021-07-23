;========================================================
;		��������� �������� ����� �� �������� BYTE
;========================================================

USART_Transmit:	
	sbis 	UCSRA, UDRE		; ������� ���� ��� ����� ����������
	rjmp	USART_Transmit 	; ���� ���������� - ����� udre
 
	out		UDR, BYTE		; ��� ����

	ret					

;========================================================
;		��������� �������� ������� �� ��� �������
;				�������� - BYTE 
;========================================================

USART_send_package:
	push	BYTE

	ldi		BYTE, SERVER_ADDR
	rcall	USART_Transmit

	ldi		BYTE, OUR_ADDR
	rcall	USART_Transmit

	pop		BYTE
	rcall	USART_Transmit

	ret
