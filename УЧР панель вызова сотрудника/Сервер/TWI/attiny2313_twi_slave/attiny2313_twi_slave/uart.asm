;========================================================
;		��������� �������� ����� �� �������� BYTE
;========================================================
USART_Transmit:	
	sbis 	UCSRA, UDRE		; ������� ���� ��� ����� ����������
	rjmp	USART_Transmit 	; ���� ���������� - ����� udre
 
	out		UDR, BYTE	; ��� ����

	ret					
