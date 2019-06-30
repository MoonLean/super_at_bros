TITLE MENU, SUPER @ BROS

COL = COLUNAS-1

.DATA

	opt		BYTE 		0
	linha 	BYTE 		17
	

	play BYTE 		"                 P L A Y                          ",
					"                 C O M O  J O G A R               ",
					"                 C R E D I T O S                  ", 0
	menu \
	BYTE "                                                  ", 0AH
	BYTE "       ____    _   _   ____    _____   ____       ", 0AH
	BYTE "      / ___|  | | | | |  _ \  | ____| |  _ \      ", 0AH
	BYTE "      \___ \  | | | | | |_) | |  _|   | |_) |     ", 0AH
	BYTE "       ___) | | |_| | |  __/  | |___  |  _ <      ", 0AH
	BYTE "      |____/   \___/  |_|     |_____| |_| \_\     ", 0AH
	BYTE "       ____      ____    ____     ___    ____     ", 0AH
	BYTE "      / __ \    | __ )  |  _ \   / _ \  / ___|    ", 0AH
	BYTE "     / / _` |   |  _ \  | |_) | | | | | \___ \    ", 0AH
	BYTE "    | | (_| |   | |_) | |  _ <  | |_| |  ___) |   ", 0AH
	BYTE "     \ \__,_|   |____/  |_| \_\  \___/  |____/    ", 0AH
	BYTE "      \____/                                      ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                 P L A Y                          ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                 C O M O  J O G A R               ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                 C R E D I T O S                  ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "                                                  ", 0AH, 0

.CODE
MENU_INICIAL PROC
	MOV opt, 0
	MOV linha, 17

	MOV EDX, OFFSET menu
	CALL WriteString
	
	mov  dl, 0  ;column
    mov  dh, 17 ;row
    call Gotoxy 
	
	MOV EAX, white+(lightGreen*16) ; fundo verde claro e letras cores branca
	CALL SETTEXTCOLOR
	
	MOV ECX, COL
	MOV ESI, 0
	
	WRITE:
		MOV AL, play[ESI]
		CALL WRITECHAR
		INC ESI
	LOOP WRITE
	
	JMP INP
	
	UP:		MOV EAX, white+(black*16)
			CALL SETTEXTCOLOR
			
			GOLINE linha		
			CALL PRINT_MENU						
			
			MOV EAX, white+(lightGreen*16) ; fundo verde claro e letras cores branca
			CALL SETTEXTCOLOR
			
			CMP opt, 0
			JE NEXTTT
			
			SUB linha, 2
			DEC opt
			
			GOLINE linha
			CALL PRINT_MENU
			
			JMP INP
			
			NEXTTT:
			
			ADD linha, 4
			MOV opt, 2
			
			GOLINE linha
			CALL PRINT_MENU
			
			JMP INP
	
	DOWN: 	MOV EAX, white+(black*16)
			CALL SETTEXTCOLOR
			
			GOLINE linha		
			CALL PRINT_MENU						
			
			MOV EAX, white+(lightGreen*16) ; fundo verde claro e letras cores branca
			CALL SETTEXTCOLOR
			
			CMP opt, 2
			JE NEXTT
			
			ADD linha, 2
			INC opt
			
			GOLINE linha
			CALL PRINT_MENU
			
			JMP INP
			
			NEXTT:
			
			SUB linha, 4
			MOV opt, 0
			
			GOLINE linha
			CALL PRINT_MENU
			
	INP:
		MOV EAX, 20
		CALL Delay
		CALL ReadKey		
		JZ INP
	
	CMP AL, _w
	JE UP
	CMP AL, W
	JE UP
	
	CMP AL, _s
	JE DOWN
	CMP AL, S
	JE DOWN
	
	CMP AL, 0Dh	; "enter"
	JNE INP
	
				; PLAY
	CMP opt, 0
	JNE COMO_JOGAR	
		MOV EAX, white+(black*16)
		CALL SETTEXTCOLOR
		CALL NIVEL1
		
				; COMO JOGAR
	COMO_JOGAR:
	CMP opt, 1
	JNE _CREDITOS_
		MOV EAX, white+(black*16)
		CALL SETTEXTCOLOR
		CALL COMOJOGAR
	
				; CREDITOS
	_CREDITOS_:
		MOV EAX, white+(black*16)
		CALL SETTEXTCOLOR
		CALL CREDITOS__
	
MENU_INICIAL ENDP

PRINT_MENU PROC
			MOV EAX, COL
			MOVZX EDX, opt
			MUL EDX
			
			MOV ECX, COL
			MOV ESI, EAX
			WRITE:
				MOV AL, play[ESI]
				CALL WRITECHAR
				INC ESI
			LOOP WRITE
	
			MOV DX, 0
			CALL Gotoxy
	RET
PRINT_MENU ENDP