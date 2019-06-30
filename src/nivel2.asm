TITLE NIVEL 2, SUPER @ BROS

; Program Description:
; Author:
; Creation Date:
; other inclusions

CLOCKWILSON = CLOCK + 250

.DATA
	GATE_2 WORD 728,729,730,731,732,733
	
	TASK BYTE 0
	
	CRIATURAS2 \
	CRIATURA_DINAMICA 	<460, 1, 1>,
	<512, 1, 1>,
	<556, 1, 1>,
	<564, 1, 1>,
	<606, 1, 1>,
	<656, 1, 1>,
	<891, 1, 1>,
	<1072, 1, 1>,
	<1082, 1, 0>,
	<1124, 1, 1>,
	<1176, 1, 1>,
	<1228, 1, 1>,	
	<1281, 1, 1>,
	<1283, 1, 1>,
	<1285, 1, 1>,
	<1333, 1, 1>,
	<1335, 1, 1>,
	<1337, 1, 1>,
	<1028, 1, 0>
	
	

	mapa2 \
	BYTE 9 DUP(BLOCK,SPACE), "SUPER @ BROS ",9 DUP(BLOCK,SPACE), BLOCK,0AH
	BYTE BLOCK,"                                                ", BLOCK, 0AH
	BYTE BLOCK,"   NIVEL 2                                      ", BLOCK, 0AH
	BYTE BLOCK,"                                                ", BLOCK, 0AH
	BYTE BLOCK,"   PONTOS: 0000             TAREFA: ___         ", BLOCK, 0AH
	BYTE BLOCK,"                                                ", BLOCK, 0AH
	BYTE BLOCK,"   TEMPO :    ",30 DUP(INDICADOR_TEMPO),"    ", BLOCK, 0AH
	BYTE BLOCK,"                                                ", BLOCK, 0AH
	BYTE "##################################################", 0AH
	BYTE "#O    @                        +                 #", 0AH
	BYTE "# O                                        X  O  #", 0AH
	BYTE "#  O  ###################################### O   #", 0AH
	BYTE "#     #                                    #O    #", 0AH
	BYTE "#     #                                    #     #", 0AH
	BYTE "#     #      #------#################      #     #", 0AH
	BYTE "#     #      #                      #      #     #", 0AH
	BYTE "#     #      ###########            #      #     #", 0AH
	BYTE "#### ##      #          O           #      #     #", 0AH
	BYTE "#    +#      #          #############      #     #", 0AH
	BYTE "#    +#      #            +         #      #     #", 0AH
	BYTE "#    +# O    #            +        $#      #     #", 0AH
	BYTE "#O   +#    O ########################      #     #", 0AH ;21
	BYTE "# O  +#                                    #     #", 0AH
	BYTE "#  O +#   C                                #     #", 0AH
	BYTE "#   OS###############################      #     #", 0AH
	BYTE "#     O O O                                      #", 0AH
	BYTE "#      O O O                                     #", 0AH
	BYTE "##################################################", 0AH, 0
	
	
.CODE

;--------------------------------------------------------------;
; NOME:                                                        ;
; FUNCAO:                                                      ;
; PARAMETROS:                                                  ;
;                                                              ;
;--------------------------------------------------------------;
NIVEL2 PROC
	; ALGUMAS VARIAVEIS DO NIVEL 1 QUE POSEM SER REAPROVEITADAS
	; DEVEM SER ZERADAS AQUI
	; ...
	MOV CONTAGEM_PROGRESSIVA, 0
	MOV PERSON, 465
	MOV POS_INICIAL_TIMER, 321
	MOV CURR_PT, 0

	JMP INPUT_NIVEL_2
	
	UP:		MOV ESI, PERSON
			SUB ESI, COLUNAS
			MOV AH, mapa2[ESI]
			
			; verifica se a missao foi cumprida
			;----------------------------------------
			CMP AH, 'X'
			JNE _CU
				INC TASK
				MOV AH, SPACE
				MOV mapa2[241], 'X'
			_CU:
			CMP AH, 'C'
			JNE SU_
				INC TASK
				MOV AH, SPACE
				MOV mapa2[242], 'C'
			SU_:
			CMP AH, 'S'
			JNE CMPMISSAOU
				INC TASK
				MOV AH, SPACE
				MOV mapa2[243], 'S'
			CMPMISSAOU:
			CMP TASK, 3
			JNE NAO_CUMPRIDAU
				REMOVE_PORTAO GATE_2, mapa2
			NAO_CUMPRIDAU:
			;----------------------------------------

			
			; caso seja um bonus, apenas soma pontuacao 
			CMP AH, BONUS			
			JNE OVER_BONUS_U
				MOVZX EDI, CURR_PT
				MOV DL, PONTUACAO[EDI]
				MOV mapa2[218], DL
				INC CURR_PT
				
				MOV DX, BONIFICACAO
				ADD PONTUACAO_TOTAL, DX	
			MOV AH, SPACE
			OVER_BONUS_U:
	
			CMP AH, SPACE
			JNE	CREATURE
			
			; otherwise
	
			; posiciona personagem
			MOV mapa2[ESI], PERSONAGEM
			; atualiza posicao
			MOV PERSON, ESI
	
			ADD ESI, COLUNAS
			MOV mapa2[ESI], SPACE	
		
			JMP INPUT_NIVEL_2
	
	RIGHT:	MOV ESI, PERSON
			INC ESI
			MOV AH, mapa2[ESI]
			
			; verifica se a missao foi cumprida
			;----------------------------------------
			CMP AH, 'X'
			JNE _CR
				INC TASK
				MOV AH, SPACE
				MOV mapa2[241], 'X'
			_CR:
			CMP AH, 'C'
			JNE SR_
				INC TASK
				MOV AH, SPACE
				MOV mapa2[242], 'C'
			SR_:
			CMP AH, 'S'
			JNE CMPMISSAOR
				INC TASK
				MOV AH, SPACE
				MOV mapa2[243], 'S'
			CMPMISSAOR:
			CMP TASK, 3
			JNE NAO_CUMPRIDAR
				REMOVE_PORTAO GATE_2, mapa2
			NAO_CUMPRIDAR:
			;----------------------------------------
			
			; caso seja um bonus, apenas soma pontuacao 
			CMP AH, BONUS			
			JNE OVER_BONUS_R			
				MOVZX EDI, CURR_PT
				MOV DL, PONTUACAO[EDI]
				MOV mapa2[218], DL
				INC CURR_PT				
				
				MOV DX, BONIFICACAO
				ADD PONTUACAO_TOTAL, DX	
			MOV AH, SPACE
			OVER_BONUS_R:
	
			CMP AH, SPACE
			JNE	CREATURE
			; otherwise
	
			; posiciona personagem
			MOV mapa2[ESI], PERSONAGEM
			; atualiza posicao
			MOV PERSON, ESI
	
			DEC ESI
			MOV mapa2[ESI], SPACE
	
			JMP INPUT_NIVEL_2	
	
	DOWN:	MOV ESI, PERSON
			ADD ESI, COLUNAS
			MOV  AH, mapa2[ESI]
			
			; verifica se a missao foi cumprida
			;----------------------------------------
			CMP AH, 'X'
			JNE _CD
				INC TASK
				MOV AH, SPACE
				MOV mapa2[241], 'X'
			_CD:
			CMP AH, 'C'
			JNE SD_
				INC TASK
				MOV AH, SPACE
				MOV mapa2[242], 'C'
			SD_:
			CMP AH, 'S'
			JNE CMPMISSAOD
				INC TASK
				MOV AH, SPACE
				MOV mapa2[243], 'S'
			CMPMISSAOD:
			CMP TASK, 3
			JNE NAO_CUMPRIDAD
				REMOVE_PORTAO GATE_2, mapa2
			NAO_CUMPRIDAD:
			;----------------------------------------
			
			; caso seja um bonus, apenas soma pontuacao 
			CMP AH, BONUS			
			JNE OVER_BONUS_D
				MOVZX EDI, CURR_PT
				MOV DL, PONTUACAO[EDI]
				MOV mapa2[218], DL
				INC CURR_PT
				
				MOV DX, BONIFICACAO
				ADD PONTUACAO_TOTAL, DX
			MOV AH, SPACE
			OVER_BONUS_D:
	
			CMP AH, SPACE
			JNE	CREATURE
			; otherwise
	
			; posiciona personagem
			MOV mapa2[ESI], PERSONAGEM
			; atualiza posicao
			MOV PERSON, ESI
	
			SUB ESI, COLUNAS
			MOV mapa2[ESI], SPACE

			JMP INPUT_NIVEL_2	
	
	LEFT:	MOV ESI, PERSON
			DEC ESI
			MOV AH, mapa2[ESI]
			
			; verifica se a missao foi cumprida
			;----------------------------------------
			CMP AH, 'X'
			JNE _CL
				INC TASK
				MOV AH, SPACE
				MOV mapa2[241], 'X'
			_CL:
			CMP AH, 'C'
			JNE SL_
				INC TASK
				MOV AH, SPACE
				MOV mapa2[242], 'C'
			SL_:
			CMP AH, 'S'
			JNE CMPMISSAO
				INC TASK
				MOV AH, SPACE
				MOV mapa2[243], 'S'
			CMPMISSAO:
			CMP TASK, 3
			JNE NAO_CUMPRIDAL
				REMOVE_PORTAO GATE_2, mapa2
			NAO_CUMPRIDAL:
			;----------------------------------------
				
			; caso seja um bonus, apenas soma pontuacao 
			CMP AH, BONUS			
			JNE OVER_BONUS_L
				MOVZX EDI, CURR_PT
				MOV DL, PONTUACAO[EDI]
				MOV mapa2[218], DL
				INC CURR_PT
				
				MOV DX, BONIFICACAO
				ADD PONTUACAO_TOTAL, DX	
			MOV AH, SPACE
			OVER_BONUS_L:
	
			CMP AH, SPACE
			JNE	CREATURE
			; otherwise
	
			; posiciona personagem
			MOV mapa2[ESI], PERSONAGEM
			; atualiza posicao
			MOV PERSON, ESI
	
			INC ESI
			MOV mapa2[ESI], SPACE
	
			JMP INPUT_NIVEL_2

	CREATURE:	CMP AH, CRIATURA
				JNE CHEGADA
				
				CALL GAMEOVER


	CHEGADA:	CMP AH, OBJETIVO
				JNE INPUT_NIVEL_2
				INC NIVEIS_CONCLUIDOS
				CALL NIVEL3
							

	 
	
	
				

INPUT_NIVEL_2::	IMPRIMI_MAPA mapa2
	
				; dinamica de movimenta das criaturas
				CMP CURR_DELAY, DELAY_CRIATURA
				JNE NEXT_INPUT 
	
				; CURR_DELAY == DELAY_CRIATURA
				MOV CURR_DELAY, 0	; zera a contagem
				MOV ECX, 0    ;LENGTHOF ARR_CRIATURAS
				MOV EDI, 0
				
				MOVIMENTA_CRIATURAS CRIATURAS2, mapa2, INPUT_NIVEL_2
				
				NEXT_INPUT:
				CMP COUNTER_CLOCK, CLOCKWILSON
				JB OVER_TIMER
				
				TIMER mapa2, INPUT_NIVEL_2
				
				OVER_TIMER:
				
				INC CURR_DELAY
				INC COUNTER_CLOCK
				CALL ReadKey		; look for keyboard input			
				JZ INPUT_NIVEL_2			; se ZF = 0, significa que nenhuma tecla foi pressionada
	
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
NIVEL2 ENDP