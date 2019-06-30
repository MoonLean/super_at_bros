TITLE INFORMACOES MODULO, SUPER @ BROS

; Program Description:
; Author:
; Creation Date:


.DATA
	info_msg_nivel \
	BYTE "                                                                                 ", 0AH
	BYTE "                                  F I M  D E J O G O                             ", 0AH
	BYTE "                                                                                 ", 0AH
	BYTE "               > NIVEIS CONCLUIDOS:  ",0
	
	info_msg_pontuacao \
	BYTE " / 3                                       ", 0AH
	BYTE "                                                                                 ", 0AH
	BYTE "               > PONTUACAO TOTAL:    ",0
	
	info_msg_tempo \
	BYTE 0AH
	BYTE "                                                                                 ", 0AH
	BYTE "               > TEMPO TOTAL:        ",0
	
	info_msg_sair \
	BYTE "                                                                                 ", 0AH
	BYTE "                                                                                 ", 0AH
	BYTE "                                                                                 ", 0AH
	BYTE "                                                                                 ", 0AH
	BYTE "                                                                                 ", 0AH
	BYTE "                                                                                 ", 0AH
	BYTE "                                                                                 ", 0AH
	BYTE "                                                                                 ", 0AH
	BYTE "                pressione qualquer tecla p/ sair", 0AH, 0


.CODE
;--------------------------------------------------------------;
; NOME:   INFO						                           ;
; FUNCAO:                                                      ;
; PARAMETROS:                                                  ;
;                                                              ;
;--------------------------------------------------------------;
;	PONTUACAO TOTAL
;	TEMPO GASTO	
;	NIVEL ALCANCADO     n / 3
INFO PROC
	
	MOV DX, 0
	CALL Gotoxy

	MOV EAX, 0
	
	MOV EDX, OFFSET info_msg_nivel
	CALL WriteString
	
	MOVZX EAX, NIVEIS_CONCLUIDOS
	CALL WriteDec
	
	MOV EDX, OFFSET info_msg_pontuacao
	CALL WriteString
	
	MOV AX, PONTUACAO_TOTAL
	CALL WriteDec
	
	MOV EDX, OFFSET info_msg_tempo
	CALL WriteString
	
	MOV EAX, TEMPO_TOTAL
	CALL WriteDec
	
	MOV EDX, OFFSET info_msg_sair
	CALL WriteString
	
	
	INPUT_KEY:
		CALL ReadKey
		JZ INPUT_KEY
	;após qquer tecla pressionada
	JMP QUIT
INFO ENDP

