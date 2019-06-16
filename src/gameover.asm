TITLE GAME OVER MODULO, SUPER @ BROS

; Program Description:
; Author:
; Creation Date:

.DATA
	; insert variables
	; 81 COLUNAS
	; 896 primeiro elemento do cogumelo
	;
	
	GAME_OVER_MSG \
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

.CODE


; procedimento:			GAMEOVER
; funcao:				
; entrada:				
; saida:				
; parametros:
GAMEOVER PROC
	; instuctions
	CALL Clrscr
	
	MOV EDX, OFFSET GAME_OVER_MSG
	CALL WriteString
	
	JMP QUIT
GAMEOVER ENDP

