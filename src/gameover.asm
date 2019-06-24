TITLE GAME OVER MODULO, SUPER @ BROS

; Program Description:
; Author:
; Creation Date:


.DATA
	
	
	; insert variables
	; 81 COLUNAS
	; 896 primeiro elemento do cogumelo
	PONTEIRO_CREDITO_ATUAL 	WORD 0
	QTD_CARACTERES_CREDITOS WORD 162
	DELAY_TROCA_CREDITO		DWORD 100
	
	CREDITS \
	BYTE "                                 Executive Producer                             ", 0AH
	BYTE "                                    MORAES LUAN                                 ", 0AH
	BYTE "                                 Executive Producer                             ", 0AH
	BYTE "                                    JEFF GARLIN                                 ", 0AH
	BYTE "                                 Executive Producer                             ", 0AH
	BYTE "                                   GAVING POLONE                                ", 0AH
	BYTE "                               Co-Executive Producer                            ", 0AH
	BYTE "                                  ROBERT B. WEIDE                               ", 0AH
	BYTE "                                    Produced by                                 ", 0AH
	BYTE "                                    TIM GIBBONS                                 ", 0AH
	BYTE "                                    Co-Producer                                 ", 0AH
	BYTE "                                   CAIQUE ANTONIO                               ", 0AH
	BYTE "                                 Executive Producer                             ", 0AH
	BYTE "                                    LARRY DAIVD                                 ", 0AH
	BYTE "                                 Executive Producer                             ", 0AH
	BYTE "                                    JEFF GARLIN                                 ", 0AH
	BYTE "                                 Executive Producer                             ", 0AH
	BYTE "                                   GAVING POLONE                                ", 0AH
	BYTE "                               Co-Executive Producer                            ", 0AH
	BYTE "                                  ROBERT B. WEIDE                               ", 0AH
	BYTE "                                    Produced by                                 ", 0AH
	BYTE "                                    TIM GIBBONS                                 ", 0AH
	BYTE "                                    Co-Producer                                 ", 0AH
	BYTE "                                   CAIQUE ANTONIO                               ", 0AH,0
	
	GAME_OVER_MSG \
	BYTE "                                                                                ", 0AH
	BYTE "                                                                                ", 0AH
	BYTE "                                                                                ", 0AH
	BYTE "                                                                                ", 0AH
	BYTE "                                                                                ", 0AH
	BYTE "                                                                                ", 0AH
	BYTE "                                                                                ", 0AH
	BYTE "                                                                                ", 0AH
	BYTE "   ___       _       __  __     ___        ___     __   __    ___     ___     _ ", 0AH
	BYTE "  / __|     /_\     |  \/  |   | __|      / _ \    \ \ / /   | __|   | _ \   | |", 0AH
	BYTE " | (_ |    / _ \    | |\/| |   | _|      | (_) |    \ V /    | _|    |   /   |_|", 0AH
	BYTE "  \___|   /_/ \_\   |_|  |_|   |___|      \___/      \_/     |___|   |_|_\   (_)", 0AH
	BYTE "                                                                                ", 0AH
	BYTE "                                                                                ", 0AH
	BYTE "                                                                                ", 0AH
	BYTE "                                                                                ", 0AH
	BYTE "                                                                                ", 0AH
	BYTE "     ________                                                                   ", 0AH
	BYTE "    /   ...  \                                                                  ", 0AH
	BYTE "   /.. .... ..\                                                                 ", 0AH
	BYTE "  /..   ..  ...\                                                                ", 0AH
	BYTE "  \.  ______  ./                                                                ", 0AH
	BYTE "   \_/  _ _ \_/                                                                 ", 0AH
	BYTE "     \__!_!_/                                                                   ", 0AH
	BYTE "                                                                                ", 0AH
	BYTE "                                                                                ", 0AH
	BYTE "                                                                                ", 0AH
	BYTE "                                                                                ", 0
	
	GAME_OVER_CREDIT_MSG \
	BYTE "                                                                                ", 0AH
	BYTE "                                                                                ", 0AH
	BYTE "                                                                                ", 0AH
	BYTE "                                                                                ", 0AH
	BYTE "                                                                                ", 0AH
	BYTE "                                                                                ", 0AH
	BYTE "                                                                                ", 0AH
	BYTE "                                                                                ", 0AH
	BYTE "                                                                                ", 0AH
	BYTE "                                                                                ", 0AH
	BYTE "                                                                                ", 0AH
	BYTE "                                   Directed by                                  ", 0AH
	BYTE "                                  LUAN V. MORAES                                ", 0AH	
	BYTE "                                                                                ", 0AH
	BYTE "                                                                                ", 0AH
	BYTE "                                                                                ", 0AH
	BYTE "                                                                                ", 0AH
	BYTE "                                                                                ", 0AH
	BYTE "                                                                                ", 0AH
	BYTE "                                                                                ", 0AH
	BYTE "                                                                                ", 0AH
	BYTE "                                                                                ", 0AH
	BYTE "                                                                                ", 0AH
	BYTE "                                                                                ", 0AH
	BYTE "                                                                                ", 0AH
	BYTE "                                                                                ", 0AH
	BYTE "                                                                                ", 0AH
	BYTE "                                                                                ", 0AH,0

.CODE


; procedimento:			GAMEOVER
; funcao:				
; entrada:				
; saida:				
; parametros:
GAMEOVER PROC
	
	INVOKE PlaySound, OFFSET meme_credits, SND_ASYNC, SND_ASYNC
	

	
	MOV ECX, 6000d
	MOV DELAY_TROCA_CREDITO, ECX
	SUB DELAY_TROCA_CREDITO, 500

	PRINT:
		CMP ECX, DELAY_TROCA_CREDITO
		JNE OVER
			CALL AUX
		OVER:
		IMPRIMI_MAPA GAME_OVER_CREDIT_MSG
	LOOP PRINT
	
	CALL INFO
GAMEOVER ENDP

AUX PROC
			MOVZX ESI, PONTEIRO_CREDITO_ATUAL
			MOV EDI, 891
			MOV BX, 0
			MUDA_CREDITS:
				CMP BX, QTD_CARACTERES_CREDITOS
				JE MUDA
				MOV AH, CREDITS[ESI]
				MOV GAME_OVER_CREDIT_MSG[EDI], AH
				INC ESI
				INC EDI
				INC BX
			JMP MUDA_CREDITS			
			
			MUDA:
			ADD PONTEIRO_CREDITO_ATUAL, 162
			SUB DELAY_TROCA_CREDITO, 500
RET
AUX ENDP

