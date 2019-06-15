TITLE NIVEL 1, SUPER @ BROS

; Module Description:			cada nível tem uma dinamica diferente, dai a necessidade de
;								separar cada nível por modulo, este contem o nivel 1
;
; Author:
; Creation Date:

.DATA
	;coordenada inicial do personagem
	;coloquei dword pq ela sera atribuiba a um reg esi
	PERSON DWORD 461
	
	ARR_CRIATURAS \
	CRIATURA_DINAMICA <506, 1, 1>, <507, 1, 1>,<653, 1, 1>,<654, 1, 1>,<723, 1, 1>,<725, 1, 1>,<996, 1, 1>,<779, 1, 0>,<1276, 1 ,0>
	
	;
	CURR_DELAY DWORD 0
	
	PONTUACAO BYTE 0d
	
	MISSAO BYTE "_ _ _"
	
	GAME_OVER BYTE "VOCÊ PERDEU!", 0AH
	SUCESSO BYTE "PARABENS MEU CONSGRADO", 0AH
	

	mapa1 \
	BYTE 9 DUP(BLOCK,SPACE), "SUPER @ BROS ",9 DUP(BLOCK,SPACE), BLOCK,0AH
	BYTE BLOCK,"                                                ", BLOCK, 0AH
	BYTE BLOCK,"   NIVEL 1                                      ", BLOCK, 0AH
	BYTE BLOCK,"                                                ", BLOCK, 0AH
	BYTE BLOCK,"   PONTOS: 0000             TEMPO: 000          ", BLOCK, 0AH
	BYTE BLOCK,"                                                ", BLOCK, 0AH
	BYTE BLOCK,"   TAREFA: ",MISSAO,"                                ", BLOCK, 0AH
	BYTE BLOCK,"                                                ", BLOCK, 0AH
	BYTE "##################################################", 0AH
	BYTE "# @                                            OO#", 0AH
	BYTE "#     +                                          #", 0AH
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


; procedimento:			NIVEL1
; funcao:				
; entrada:				
; saida:				
; parametros:			
NIVEL1 PROC
	
	; rotina com a leitura do teclado
	JMP INPUT
	
	
	UP:		MOV ESI, PERSON
			SUB ESI, COLUNAS
			MOV AH, mapa1[ESI]
			
			; caso seja um bonus, apenas soma pontuacao 
			CMP AH, BONUS			
			JNE OVER_BONUS_U
			
			ADD PONTUACAO, BONIFICACAO			
			MOV AH, SPACE
			OVER_BONUS_U:
	
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
	
	RIGHT:	MOV ESI, PERSON
			INC ESI
			MOV AH, mapa1[ESI]
			
			; caso seja um bonus, apenas soma pontuacao 
			CMP AH, BONUS			
			JNE OVER_BONUS_R
			
			ADD PONTUACAO, BONIFICACAO			
			MOV AH, SPACE
			OVER_BONUS_R:
	
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
	
	DOWN:	MOV ESI, PERSON
			ADD ESI, COLUNAS
			MOV AH, mapa1[ESI]
			
			; caso seja um bonus, apenas soma pontuacao 
			CMP AH, BONUS			
			JNE OVER_BONUS_D
			
			ADD PONTUACAO, BONIFICACAO			
			MOV AH, SPACE
			OVER_BONUS_D:
	
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
	
	LEFT:	MOV ESI, PERSON
			DEC ESI
			MOV AH, mapa1[ESI]
			
			; caso seja um bonus, apenas soma pontuacao 
			CMP AH, BONUS			
			JNE OVER_BONUS_L
			MOV MISSAO[0], 'X'
			ADD PONTUACAO, BONIFICACAO			
			MOV AH, SPACE
			OVER_BONUS_L:
	
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

	CREATURE:	CMP AH, CRIATURA
				JNE CHEGADA
				
				; se chegou aqui, esbarrou com criatura, prosseguir para tela GAME_OVER
				;CALL Clrscr
				;MOV EDX, OFFSET GAME_OVER
				;ALL WriteString
				JMP QUIT


	CHEGADA:	CMP AH, OBJETIVO
				JNE INPUT ; o mesmo que fazer nada
	
				; PULA PARA PROXIMA FASE
				CALL Clrscr
				MOV EDX, OFFSET SUCESSO
				CALL WriteString
	
				JMP QUIT
	
	
	INPUT::		CALL PRINT_MAPA
	
				; dinamica de movimenta das criaturas
				CMP CURR_DELAY, DELAY_CRIATURA
				JNE NEXT_INPUT 
	
				; CURR_DELAY == DELAY_CRIATURA
				MOV CURR_DELAY, 0	; zera a contagem
				MOV ECX, LENGTHOF ARR_CRIATURAS
				MOV EDI, 0
				JMP _CRIATURAS
				
				NEXT_INPUT:	INC CURR_DELAY
							CALL ReadKey		; look for keyboard input			
							JZ INPUT			; se ZF = 0, significa que nenhuma tecla foi pressionada
	
	; otherwise...
	
	MOV DL, PONTUACAO
	
	;KEY W
	CMP AL, 'w'
	JE UP
	
	;KEY D
	CMP AL, 'd'
	JE RIGHT
	
	;KEY S
	CMP AL, 's'
	JE DOWN 
	
	;KEY A
	CMP AL, 'a'
	JE LEFT
	
	; nenhuma tecla valida foi pressionada!
	JMP INPUT

NIVEL1 ENDP


