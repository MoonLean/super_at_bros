TITLE CREDITOS E COMO JOGAR, SUPER @ BROS


.DATA

	how_play \
	BYTE "                                         _                                ", 0AH
	BYTE "   ___    ___    _ __ ___     ___       (_)   ___     __ _    __ _   _ __ ", 0AH
	BYTE "  / __|  / _ \  | '_ ` _ \   / _ \      | |  / _ \   / _` |  / _` | | '__|", 0AH
	BYTE " | (__  | (_) | | | | | | | | (_) |     | | | (_) | | (_| | | (_| | | |   ", 0AH
	BYTE "  \___|  \___/  |_| |_| |_|  \___/     _/ |  \___/   \__, |  \__,_| |_|   ", 0AH
	BYTE "                                      |__/           |___/                ", 0AH
	BYTE "                                                                          ", 0AH
	BYTE "->   mova o personagem ( @ ), utlizando as teclas A (esquerda), W (cima), ", 0AH
	BYTE "      D (direita), S (baixo).                                             ", 0AH
	BYTE "                                                                          ", 0AH
	BYTE "->  chegue ao objetivo ( $ ), antes que o seu                             ", 0AH
	BYTE "                                                                          ", 0AH
	BYTE "                 TEMPO:      ",30 DUP(INDICADOR_TEMPO),"               ", 0AH
	BYTE "      se esgote !!                                                        ", 0AH
	BYTE "                                                                          ", 0AH
	BYTE "->  desvie das criatudas que estao andando pelo mapa:                     ", 0AH
	BYTE "    #   O                                          #                      ", 0AH
	BYTE "                                                                          ", 0AH
	BYTE "                                                                          ", 0AH
	BYTE "->  Aumente seu Score coletando os Bonus ( + )                            ", 0AH
	BYTE "                                                                          ", 0AH
	BYTE "->  colete as letras 'S', 'C' e 'X' para abrir o portao (------)          ", 0AH
	BYTE "                                                                          ", 0AH
	BYTE "                  pressione qualquer tecla p/ voltar                      ", 0AH, 0 ; 23
	
	clear_how_play \
	BYTE "                                                                          ", 0AH
	BYTE "                                                                          ", 0AH
	BYTE "                                                                          ", 0AH
	BYTE "                                                                          ", 0AH
	BYTE "                                                                          ", 0AH
	BYTE "                                                                          ", 0AH
	BYTE "                                                                          ", 0AH
	BYTE "                                                                          ", 0AH
	BYTE "                                                                          ", 0AH
	BYTE "                                                                          ", 0AH
	BYTE "                                                                          ", 0AH
	BYTE "                                                                          ", 0AH
	BYTE "                                                                          ", 0AH
	BYTE "                                                                          ", 0AH
	BYTE "                                                                          ", 0AH
	BYTE "                                                                          ", 0AH
	BYTE "                                                                          ", 0AH
	BYTE "                                                                          ", 0AH
	BYTE "                                                                          ", 0AH
	BYTE "                                                                          ", 0AH
	BYTE "                                                                          ", 0AH
	BYTE "                                                                          ", 0AH
	BYTE "                                                                          ", 0AH
	BYTE "                                                                          ", 0AH
	BYTE "                                                                          ", 0AH, 0
	
	creditos \
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
	BYTE "    EH UM JOGO ASCII ARCADE, DESENVOLVIDO EM      ", 0AH
	BYTE "    ASSEMBLY, PARA A DISCIPLINA 'ARQUITETURA      ", 0AH
	BYTE "    E ORGANIZACAO DE COMPUTADORES II' PELOS       ", 0AH
	BYTE "    ALUNOS:                                       ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "    LUAN V. MORAES                                ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "    ANTONIO CAIQUE DOS SANTOS                     ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "    PROF.: LUCIANO NERIS                          ", 0AH
	BYTE "                                                  ", 0Ah
	BYTE "    2019 © todos os direitor reservados           ", 0AH
	BYTE "                                                  ", 0AH
	BYTE "       pressione qualquer tecla p/ voltar         ", 0AH, 0

.CODE
CREDITOS__ PROC
	
	MOV EDX, OFFSET creditos
	CALL WriteString
	
	INPT:
		MOV EAX, 20
		CALL Delay
		CALL ReadKey		
		JZ INPT
		
	GOLINE 0
	
	CALL MENU_INICIAL	
CREDITOS__ ENDP

COMOJOGAR PROC

	MOV EDX, OFFSET how_play
	CALL WriteString

	INPT:
		MOV EAX, 20
		CALL Delay
		CALL ReadKey		
		JZ INPT
	
	GOLINE 0
	MOV EDX, OFFSET clear_how_play
	CALL WriteString
	
	COMMENT &
	MOV EAX, 23
	MUL EDX
	
	MOV ECX, EAX
	MOV AL, SPACE
	MOV EDI, OFFSET how_play
	REP STOSB
	
	MOV EDX, OFFSET how_play
	CALL WriteString
	&
	
	GOLINE 0
	
	CALL MENU_INICIAL
COMOJOGAR ENDP