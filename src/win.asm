TITLE INFORMACOES MODULO, SUPER @ BROS

; Program Description:
; Author:
; Creation Date:


.DATA
; PONTUACAO_TOTAL
; NIVEIS CONLUIDOS
;
	tmp_msg WORD 2000

	win_msg \
	BYTE "                                                  ", 0AH
	BYTE "      _______  _______  ______    _______         ", 0AH
	BYTE "     |       ||   _   ||    _ |  |   _   |        ", 0AH
	BYTE "     |    _  ||  |_|  ||   | ||  |  |_|  |        ", 0AH
	BYTE "     |   |_| ||       ||   |_||_ |       |        ", 0AH
	BYTE "     |    ___||       ||    __  ||       |        ", 0AH
	BYTE "     |   |    |   _   ||   |  | ||   _   |        ", 0AH
	BYTE "     |___|    |__| |__||___|  |_||__| |__|        ", 0AH
	BYTE "       _______  _______  __    _  _______         ", 0AH
	BYTE "      |  _    ||       ||  |  | ||       |        ", 0AH
	BYTE "      | |_|   ||    ___||   |_| ||  _____|        ", 0AH
	BYTE "      |       ||   |___ |       || |_____         ", 0AH
	BYTE "      |  _   | |    ___||  _    ||_____  |        ", 0AH
	BYTE "      | |_|   ||   |___ | | |   | _____| |        ", 0AH
	BYTE "      |_______||_______||_|  |__||_______|        ", 0AH
	BYTE "       __   __   __   __   __   __   __           ", 0AH
	BYTE "      |  | |  | |  | |  | |  | |  | |  |          ", 0AH
	BYTE "      |  | |  | |  | |  | |  | |  | |  |          ", 0AH
	BYTE "      |  | |  | |  | |  | |  | |  | |  |          ", 0AH
	BYTE "      |__| |__| |__| |__| |__| |__| |__|          ", 0AH
	BYTE "       __   __   __   __   __   __   __           ", 0AH
	BYTE "      |__| |__| |__| |__| |__| |__| |__|          ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH, 0
	
	clear_msg_win \
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH, 0


.CODE
;--------------------------------------------------------------;
; NOME:   WIN 						                           ;
; FUNCAO:   procedimento quando finalizar  todos os niveis     ;
; PARAMETROS:                                                  ;
;                                                              ;
;--------------------------------------------------------------;
WIN PROC
	INVOKE PlaySound, OFFSET winnersong, SND_ASYNC, SND_ASYNC
	GOLINE 0
	
	MOV EDX, OFFSET win_msg
	CALL WriteString
	
	;MOVZX ECX, tmp_msg
	;ESPERE:
	
	;LOOP ESPERE
	MOV EAX, 3000
	CALL Delay
	
	GOLINE 0
	
	MOV EDX, OFFSET clear_msg_win
	CALL WriteString
	
	CALL INFO

WIN ENDP

