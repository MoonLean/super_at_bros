TITLE NIVEL 1, SUPER @ BROS

; Module Description:
; Author:
; Creation Date:

.DATA
	;coordenada inicial do personagem
	;coloquei dword pq ela sera atribuiba a um reg esi
	PERSON DWORD 461

	VERTIC	\
	CRI_VERTICAL <506, 1, 1>, <507, 1, 1>,<653, 1, 1>,<654, 1, 1>,<723, 1, 1>,<725, 1, 1>,<996, 1, 1>,<779, 1, 0>,<1276, 1 ,0>
	
	CURR_DELAY DWORD 0
	
	GAME_OVER BYTE "VOCÊ PERDEU!", 0AH
	SUCESSO BYTE "PARABENS MEU CONSGRADO", 0AH
	

	mapa1 \
	BYTE 9 DUP(BLOCK,SPACE), "SUPER @ BROS ",9 DUP(BLOCK,SPACE), BLOCK,0AH
	BYTE BLOCK,"                                                ", BLOCK, 0AH
	BYTE BLOCK,"   NIVEL 1                                      ", BLOCK, 0AH
	BYTE BLOCK,"                                                ", BLOCK, 0AH
	BYTE BLOCK,"   PONTOS: 0000             TEMPO: 000          ", BLOCK, 0AH
	BYTE BLOCK,"                                                ", BLOCK, 0AH
	BYTE BLOCK,"   TAREFA:                                      ", BLOCK, 0AH
	BYTE BLOCK,"                                                ", BLOCK, 0AH
	BYTE "##################################################", 0AH
	BYTE "# @                                            OO#", 0AH
	BYTE "#                                                #", 0AH
	BYTE "#     ######################################     #", 0AH
	BYTE "#     #                                  OO#     #", 0AH
	BYTE "#     #                                    #     #", 0AH
	BYTE "#     #  O O #      #################      #     #", 0AH
	BYTE "#     #      #O                     #      #     #", 0AH
	BYTE "#     #      #      ############    #      #     #", 0AH
	BYTE "#     #      #      # $        #    #      #     #", 0AH
	BYTE "#     #      #      #          #    #      #     #", 0AH
	BYTE "#     #      #      #######O   #    #      #     #", 0AH
	BYTE "#     #      #                      #      #     #", 0AH
	BYTE "#     #      ########################      #     #", 0AH
	BYTE "#     #                                    #     #", 0AH
	BYTE "#     #                                    #     #", 0AH
	BYTE "#     ###############################      #     #", 0AH
	BYTE "#O                                      #        #", 0AH
	BYTE "#                                                #", 0AH
	BYTE "##################################################", 0AH

.CODE

NIVEL1 PROC
; pula para a rotina que aguarda a leitura do teclado

	JMP INPUT
	
	; IMPLEMENTAR O SWITCH CASE
	
UP:
	MOV ESI, PERSON
	SUB ESI, COLUNAS
	MOV AH, mapa1[ESI]
	
	CMP AH, SPACE
	JNE	CREATURE
	; otherwise
	
	; posiciona personagem
	MOV mapa1[ESI], PERSONAGEM
	; atualiza posicao
	MOV PERSON, ESI
	
	ADD ESI, COLUNAS
	MOV mapa1[ESI], SPACE	
		
	JMP INPUT
	
RIGHT:
	MOV ESI, PERSON
	INC ESI
	MOV AH, mapa1[ESI]
	
	CMP AH, SPACE
	JNE	CREATURE
	; otherwise
	
	; posiciona personagem
	MOV mapa1[ESI], PERSONAGEM
	; atualiza posicao
	MOV PERSON, ESI
	
	DEC ESI
	MOV mapa1[ESI], SPACE
	
	JMP INPUT	
DOWN:
	MOV ESI, PERSON
	ADD ESI, COLUNAS
	MOV AH, mapa1[ESI]
	
	CMP AH, SPACE
	JNE	CREATURE
	; otherwise
	
	; posiciona personagem
	MOV mapa1[ESI], PERSONAGEM
	; atualiza posicao
	MOV PERSON, ESI
	
	SUB ESI, COLUNAS
	MOV mapa1[ESI], SPACE

	JMP INPUT	
	
LEFT:
	MOV ESI, PERSON
	DEC ESI
	MOV AH, mapa1[ESI]
	
	CMP AH, SPACE
	JNE	CREATURE
	; otherwise
	
	; posiciona personagem
	MOV mapa1[ESI], PERSONAGEM
	; atualiza posicao
	MOV PERSON, ESI
	
	INC ESI
	MOV mapa1[ESI], SPACE
	
	JMP INPUT

CREATURE:
	CMP AH, CRIATURA
	JNE CHEGADA
	
	CALL Clrscr
	MOV EDX, OFFSET GAME_OVER
	CALL WriteString
	;JMP QUIT


CHEGADA:
	CMP AH, OBJETIVO
	JNE INPUT ; o mesmo que fazer nada
	
	; PULA PARA PROXIMA FASE
	CALL Clrscr
	MOV EDX, OFFSET SUCESSO
	CALL WriteString
	
	JMP QUIT
	
	
INPUT::
	; procedimento responsavel por printar o mapa
	CALL PRINT_MAPA
	
	; dinamica de movimenta das criaturas
	CMP CURR_DELAY, DELAY_CRIATURA
	JNE NEXT_INPUT 
	
	; do contrario
	MOV CURR_DELAY, 0	; zera a contagem
	MOV ECX, LENGTHOF VERTIC
	MOV EDI, 0
	JMP _CRIATURAS
	
	
	NEXT_INPUT:
	INC CURR_DELAY
	CALL ReadKey		; look for keyboard input			
	JZ INPUT			; se ZF = 0, significa que nenhuma tecla foi pressionada
	
	; otherwise...
	CMP AL, 'w'
		JE UP ; UP 
		
	KEY_D:
		CMP AL, 'd'
		JE RIGHT ; RIGHT
	
	KEY_S:
		CMP AL, 's'
		JE DOWN ; DOWN
	
	KEY_A:
		CMP AL, 'a'
		JE LEFT ; LEFT
	
	; se chegou até aqui, nenhuma tecla válida foi pressionada
	; por isso simplesmente segue p/ INPUT
	JMP INPUT

NIVEL1 ENDP


