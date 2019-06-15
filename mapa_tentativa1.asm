TITLE mapa tentativa um

; formula para me retornar o elemento no array mapa1:
;			começando em 0
;			mapa1[x + (y * (COLUNAS+1))]
;

INCLUDE Irvine32.inc
INCLUDE keys.inc
INCLUDE Macros.inc
INCLUDE criaturas.asm


.DATA
	;coordenada inicial do personagem
	;coloquei dword pq ela sera atribuiba a um reg esi
	PERSON DWORD 53

	VERTIC CRI_VERTICAL <98, 1>,<99, 1>;,<245, 1>,<264, 1>,<315, 1>,<317, 1>,<588, 1>
	CURR_DELAY DWORD 0
	
	GAME_OVER BYTE "VOCÊ PERDEU!", 0AH
	SUCESSO BYTE "PARABENS MEU CONSGRADO", 0AH
	

	mapa1 \
	BYTE "##################################################", 0AH
	BYTE "# @                                            OO#", 0AH
	BYTE "#                                                #", 0AH
	BYTE "#     ######################################     #", 0AH
	BYTE "#     #                                  OO#     #", 0AH
	BYTE "#     #                                    #     #", 0AH
	BYTE "#     #  O O #      #################      #     #", 0AH
	BYTE "#     #      #                      #      #     #", 0AH
	BYTE "#     #      #      ############    #      #     #", 0AH
	BYTE "#     #      #      # $        #    #      #     #", 0AH
	BYTE "#     #      #      #          #    #      #     #", 0AH
	BYTE "#     #      #      #######O   #    #      #     #", 0AH
	BYTE "#     #      #                      #      #     #", 0AH
	BYTE "#     #      ########################      #     #", 0AH
	BYTE "#     #                                    #     #", 0AH
	BYTE "#     #                                    #     #", 0AH
	BYTE "#     ###############################      #     #", 0AH
	BYTE "#                                                #", 0AH
	BYTE "#                                                #", 0AH
	BYTE "##################################################", 0AH

.CODE
MAIN PROC
	
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



_CRIATURAS::
	
	; verifica se todas as criaturas verticais ja foram alteradas
	CMP ECX, 0
	JE INPUT
	
	

	PUSH VERTIC[EDI].POS
	MOV ESI, VERTIC[EDI].POS
	
	;----------------------------
	TEST VERTIC[EDI].DIR, 1		; se ZF = 1 significa que DIR == 0, e por isso, DESCENDO
	JZ DESCENDO 				;
	SUB ESI,  COLUNAS			;
	JMP LINE					;	 
	DESCENDO:					;
	ADD ESI, COLUNAS			;
	LINE:						;
	;----------------------------
	
	CMP mapa1[ESI], SPACE
	JNE CAPTUROU
	
	; otherwise..
	MOV mapa1[ESI], CRIATURA
	POP VERTIC[EDI].POS

	MOV EDX, VERTIC[EDI].POS
	
	MOV ESI, VERTIC[EDI].POS
	MOV mapa1[ESI], SPACE
	
	;----------------------------
	TEST VERTIC[EDI].DIR, 1		; se ZF = 1 significa que DIR == 0, e por isso, DESCENDO
	JZ _DESCENDO 				;
	SUB VERTIC[EDI].POS, COLUNAS;
	JMP _LINE					;	 
	_DESCENDO:					;
	ADD VERTIC[EDI].POS, COLUNAS;
	_LINE:						;
	;----------------------------
		
	MOV CURR_DELAY, 0	; zera a contagem
	
	DEC ECX
	ADD EDI, TYPE CRI_VERTICAL
	JMP _CRIATURAS				; ESPECIE DE RETORNO
	
CAPTUROU:
	CMP mapa1[ESI], PERSONAGEM
	JNE WALL
	; otherwise
	JMP QUIT
	
WALL:
								;----------------------------
	XOR VERTIC[EDI].DIR, 1 		; TEST VERTIC.DIR, 1		; 
	; acrescentei este pop para	;
	; reverter o pop feito no	;
	; inicio					;
	POP EAX						;JZ _DESCENDO 				;
	JMP _CRIATURAS				;MOV	VERTIC.DIR, 2		;
								;JMP _LINE					;
								;_DESCENDO:					;
								;MOV VERTIC.DIR, 1			;
								;_LINE:						;
								;----------------------------	
; END _CRIATURAS ROTINA

QUIT::
	EXIT
	
MAIN ENDP
END MAIN



