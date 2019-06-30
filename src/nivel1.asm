TITLE NIVEL 1, SUPER @ BROS

; Module Description:			cada nível tem uma dinamica diferente, dai a necessidade de
;								separar cada nível por modulo, este contem o nivel 1
;
; Author:
; Creation Date:

.DATA
	;coordenada inicial do personagem
	;coloquei dword pq ela sera atribuiba a um reg esi
	
	CURR_DELAY DWORD 0
	
	ARR_CRIATURAS \
	CRIATURA_DINAMICA 	<506, 1, 1>,
						<507, 1, 1>,
						<653, 1, 1>,
						<654, 1, 1>,
						<723, 1, 1>,
						<725, 1, 1>,
						<996, 1, 1>,
						<779, 1, 0>,
						<1276, 1 ,0>
	
	CURR_PT BYTE 0	
	

	mapa1 \
	BYTE 9 DUP(BLOCK,SPACE), "SUPER @ BROS ",9 DUP(BLOCK,SPACE), BLOCK,0AH
	BYTE BLOCK,"                                                ", BLOCK, 0AH
	BYTE BLOCK,"   NIVEL 1                                      ", BLOCK, 0AH
	BYTE BLOCK,"                                                ", BLOCK, 0AH
	BYTE BLOCK,"   PONTOS: 0000                                 ", BLOCK, 0AH
	BYTE BLOCK,"                                                ", BLOCK, 0AH
	BYTE BLOCK,"   TEMPO :    ",30 DUP(INDICADOR_TEMPO),"    ", BLOCK, 0AH
	BYTE BLOCK,"                                                ", BLOCK, 0AH
	BYTE "##################################################", 0AH
	BYTE "# @                                            OO#", 0AH
	BYTE "#                                                #", 0AH
	BYTE "#     ######################################+    #", 0AH
	BYTE "#     #                                  OO#     #", 0AH
	BYTE "#     #                                    #     #", 0AH
	BYTE "#     #  O+O #      #################      #     #", 0AH
	BYTE "#     #      #O                     #      #     #", 0AH
	BYTE "#     #      #      ############    #      #     #", 0AH
	BYTE "#     #      #     +# $        # +  #      #     #", 0AH
	BYTE "#     #      #      #    +     #    #      #     #", 0AH
	BYTE "#     #      #      #######O   #    #      #     #", 0AH
	BYTE "#     #      #                      #      #     #", 0AH
	BYTE "#     #      ########################      #     #", 0AH
	BYTE "#     #                                    #     #", 0AH
	BYTE "#     #+                                   #     #", 0AH
	BYTE "#     ###############################      #     #", 0AH
	BYTE "#O                                      # +      #", 0AH
	BYTE "#+                                               #", 0AH
	BYTE "##################################################", 0AH, 0


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
				MOVZX EDI, CURR_PT
				MOV DL, PONTUACAO[EDI]
				MOV mapa1[218], DL
				INC CURR_PT
				MOV DX, BONIFICACAO
				ADD PONTUACAO_TOTAL, DX
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
				MOVZX EDI, CURR_PT
				MOV DL, PONTUACAO[EDI]
				MOV mapa1[218], DL
				INC CURR_PT
				MOV DX, BONIFICACAO
				ADD PONTUACAO_TOTAL, DX
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
			MOV  AH, mapa1[ESI]
			
			; caso seja um bonus, apenas soma pontuacao 
			CMP AH, BONUS			
			JNE OVER_BONUS_D
				MOVZX EDI, CURR_PT
				MOV DL, PONTUACAO[EDI]
				MOV mapa1[218], DL
				INC CURR_PT
				MOV DX, BONIFICACAO
				ADD PONTUACAO_TOTAL,DX	
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
				MOVZX EDI, CURR_PT
				MOV DL, PONTUACAO[EDI]
				MOV mapa1[218], DL
				INC CURR_PT
				
				MOV DX, BONIFICACAO
				ADD PONTUACAO_TOTAL, DX		
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
				CALL GAMEOVER


	CHEGADA:	CMP AH, OBJETIVO
				JNE INPUT ; o mesmo que fazer nada
				INC NIVEIS_CONCLUIDOS
				CALL NIVEL2
	
	INPUT::		IMPRIMI_MAPA mapa1
	
				; dinamica de movimenta das criaturas
				CMP CURR_DELAY, DELAY_CRIATURA
				JNE NEXT_INPUT 
	
				; CURR_DELAY == DELAY_CRIATURA
				MOV CURR_DELAY, 0	; zera a contagem
				MOV ECX, 0    
				MOV EDI, 0
				
				MOVIMENTA_CRIATURAS ARR_CRIATURAS, mapa1, INPUT
				
				NEXT_INPUT:
				CMP COUNTER_CLOCK, CLOCK
				JB OVER_TIMER
				
				TIMER mapa1, INPUT
				
				OVER_TIMER:
				
				INC CURR_DELAY
				INC COUNTER_CLOCK
				CALL ReadKey		; look for keyboard input			
				JZ INPUT			; se ZF = 0, significa que nenhuma tecla foi pressionada
	
	; otherwise...
	
	;KEY W
	CMP AL, _w
	JE UP
	CMP AL, W
	JE UP
	
	;KEY D
	CMP AL, _d
	JE RIGHT
	CMP AL, D
	JE RIGHT
	
	;KEY S
	CMP AL, _s
	JE DOWN
	CMP AL, S
	JE DOWN 
	
	;KEY A
	CMP AL, _a
	JE LEFT
	CMP AL, A
	JE LEFT
	
	; nenhuma tecla valida foi pressionada!
	JMP INPUT

NIVEL1 ENDP


