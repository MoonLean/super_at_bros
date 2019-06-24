TITLE NIVEL 3, SUPER @ BROS

; Program Description:
; Author:
; Creation Date:
; other inclusions

.DATA
	GATE_3 WORD 502
	
	CRIATURAS3 \
	CRIATURA_DINAMICA <514, 1, 1>
	
	

	mapa3 \
	BYTE 9 DUP(BLOCK,SPACE), "SUPER @ BROS ",9 DUP(BLOCK,SPACE), BLOCK,0AH
	BYTE BLOCK,"                                                ", BLOCK, 0AH
	BYTE BLOCK,"   NIVEL 3                                      ", BLOCK, 0AH
	BYTE BLOCK,"                                                ", BLOCK, 0AH
	BYTE BLOCK,"   PONTOS: 0000             TAREFA: ___         ", BLOCK, 0AH
	BYTE BLOCK,"                                                ", BLOCK, 0AH
	BYTE BLOCK,"   TEMPO :    ",30 DUP(INDICADOR_TEMPO),"    ", BLOCK, 0AH
	BYTE BLOCK,"                                                ", BLOCK, 0AH
	BYTE "##################################################", 0AH
	BYTE "#                               X          |   $ #", 0AH
	BYTE "#   O#############################################", 0AH
	BYTE "#    #OC  +                                #   @ #", 0AH
	BYTE "#    #  #################################  #     #", 0AH
	BYTE "#    # O#    +++                        #  #     #", 0AH
	BYTE "#    #  #   #########################   #  #     #", 0AH
	BYTE "#    #  #   #                       #   #  #     #", 0AH
	BYTE "#    #  #   #   ##################  #   #  #     #", 0AH
	BYTE "#    #  #   #   # $  #  O        #  #   #  #     #", 0AH
	BYTE "#    #  #   #   #             #     #   #  #     #", 0AH
	BYTE "#    #  #   #   #####################   #  #     #", 0AH
	BYTE "#    #  #   #                           #  #     #", 0AH
	BYTE "#    #  #   #############################O #     #", 0AH
	BYTE "#    #  #                                  #     #", 0AH
	BYTE "#       ################################   #     #", 0AH
	BYTE "#                                          #     #", 0AH
	BYTE "#  O #######################################     #", 0AH
	BYTE "#                                                #", 0AH
	BYTE "##################################################", 0AH, 0
	
	
.CODE

;--------------------------------------------------------------;
; NOME:                                                        ;
; FUNCAO:                                                      ;
; PARAMETROS:                                                  ;
;                                                              ;
;--------------------------------------------------------------;
NIVEL3 PROC
	; ALGUMAS VARIAVEIS DO NIVEL 1 QUE POSEM SER REAPROVEITADAS
	; DEVEM SER ZERADAS AQUI
	; ...
	MOV CONTAGEM_PROGRESSIVA, 0
	MOV PERSON, 608
	MOV POS_INICIAL_TIMER, 321
	MOV TASK, 0

	JMP INPUT_NIVEL_3
	
	UP:		MOV ESI, PERSON
			SUB ESI, COLUNAS
			MOV AH, mapa3[ESI]
			
			; verifica se a missao foi cumprida
			;----------------------------------------
			CMP AH, 'X'
			JNE _CU
				INC TASK
				MOV AH, SPACE
				MOV mapa3[241], 'X'
			_CU:
			CMP AH, 'C'
			JNE SU_
				INC TASK
				MOV AH, SPACE
				MOV mapa3[242], 'C'
			SU_:
			CMP AH, 'S'
			JNE CMPMISSAOU
				INC TASK
				MOV AH, SPACE
				MOV mapa3[243], 'S'
			CMPMISSAOU:
			CMP TASK, 3
			JNE NAO_CUMPRIDAU
				REMOVE_PORTAO GATE_3, mapa3
			NAO_CUMPRIDAU:
			;----------------------------------------
			
			; caso seja um bonus, apenas soma pontuacao 
			CMP AH, BONUS			
			JNE OVER_BONUS_U
				MOVZX EDI, CURR_PT
				MOV DL, PONTUACAO[EDI]
				MOV mapa3[218], DL
				INC CURR_PT
				
				MOV DX, BONIFICACAO
				ADD PONTUACAO_TOTAL, DX
			MOV AH, SPACE
			OVER_BONUS_U:
	
			CMP AH, SPACE
			JNE	CREATURE
			
			; otherwise
	
			; posiciona personagem
			MOV mapa3[ESI], PERSONAGEM
			; atualiza posicao
			MOV PERSON, ESI
	
			ADD ESI, COLUNAS
			MOV mapa3[ESI], SPACE	
		
			JMP INPUT_NIVEL_3
	
	RIGHT:	MOV ESI, PERSON
			INC ESI
			MOV AH, mapa3[ESI]
			
			; verifica se a missao foi cumprida
			;----------------------------------------
			CMP AH, 'X'
			JNE _CR
				INC TASK
				MOV AH, SPACE
				MOV mapa3[241], 'X'
			_CR:
			CMP AH, 'C'
			JNE SR_
				INC TASK
				MOV AH, SPACE
				MOV mapa3[242], 'C'
			SR_:
			CMP AH, 'S'
			JNE CMPMISSAOR
				INC TASK
				MOV AH, SPACE
				MOV mapa3[243], 'S'
			CMPMISSAOR:
			CMP TASK, 3
			JNE NAO_CUMPRIDAR
				REMOVE_PORTAO GATE_3, mapa3
			NAO_CUMPRIDAR:
			;----------------------------------------
			
			; caso seja um bonus, apenas soma pontuacao 
			CMP AH, BONUS			
			JNE OVER_BONUS_R
				MOVZX EDI, CURR_PT
				MOV DL, PONTUACAO[EDI]
				MOV mapa3[218], DL
				INC CURR_PT
				
				MOV DX, BONIFICACAO
				ADD PONTUACAO_TOTAL, DX
			MOV AH, SPACE
			OVER_BONUS_R:
	
			CMP AH, SPACE
			JNE	CREATURE
			; otherwise
	
			; posiciona personagem
			MOV mapa3[ESI], PERSONAGEM
			; atualiza posicao
			MOV PERSON, ESI
	
			DEC ESI
			MOV mapa3[ESI], SPACE
	
			JMP INPUT_NIVEL_3	
	
	DOWN:	MOV ESI, PERSON
			ADD ESI, COLUNAS
			MOV  AH, mapa3[ESI]
			
			; verifica se a missao foi cumprida
			;----------------------------------------
			CMP AH, 'X'
			JNE _CD
				INC TASK
				MOV AH, SPACE
				MOV mapa3[241], 'X'
			_CD:
			CMP AH, 'C'
			JNE SD_
				INC TASK
				MOV AH, SPACE
				MOV mapa3[242], 'C'
			SD_:
			CMP AH, 'S'
			JNE CMPMISSAOD
				INC TASK
				MOV AH, SPACE
				MOV mapa3[243], 'S'
			CMPMISSAOD:
			CMP TASK, 3
			JNE NAO_CUMPRIDAD
				REMOVE_PORTAO GATE_3, mapa3
			NAO_CUMPRIDAD:
			;----------------------------------------
			
			; caso seja um bonus, apenas soma pontuacao 
			CMP AH, BONUS			
			JNE OVER_BONUS_D
				MOVZX EDI, CURR_PT
				MOV DL, PONTUACAO[EDI]
				MOV mapa3[218], DL
				INC CURR_PT
				
				MOV DX, BONIFICACAO
				ADD PONTUACAO_TOTAL, DX	
			MOV AH, SPACE
			OVER_BONUS_D:
	
			CMP AH, SPACE
			JNE	CREATURE
			; otherwise
	
			; posiciona personagem
			MOV mapa3[ESI], PERSONAGEM
			; atualiza posicao
			MOV PERSON, ESI
	
			SUB ESI, COLUNAS
			MOV mapa3[ESI], SPACE

			JMP INPUT_NIVEL_3	
	
	LEFT:	MOV ESI, PERSON
			DEC ESI
			MOV AH, mapa3[ESI]
			
			; verifica se a missao foi cumprida
			;----------------------------------------
			CMP AH, 'X'
			JNE _CL
				INC TASK
				MOV AH, SPACE
				MOV mapa3[241], 'X'
			_CL:
			CMP AH, 'C'
			JNE SL_
				INC TASK
				MOV AH, SPACE
				MOV mapa3[242], 'C'
			SL_:
			CMP AH, 'S'
			JNE CMPMISSAO
				INC TASK
				MOV AH, SPACE
				MOV mapa3[243], 'S'
			CMPMISSAO:
			CMP TASK, 3
			JNE NAO_CUMPRIDAL
				REMOVE_PORTAO GATE_3, mapa3
			NAO_CUMPRIDAL:
			;----------------------------------------
				
			; caso seja um bonus, apenas soma pontuacao 
			CMP AH, BONUS			
			JNE OVER_BONUS_L
				MOVZX EDI, CURR_PT
				MOV DL, PONTUACAO[EDI]
				MOV mapa3[218], DL
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
			MOV mapa3[ESI], SPACE
	
			JMP INPUT_NIVEL_3

	CREATURE:	CMP AH, CRIATURA
				JNE CHEGADA
				
				CALL GAMEOVER


	CHEGADA:	CMP AH, OBJETIVO				
				JNE INPUT_NIVEL_3 ; o mesmo que fazer nada
				INC NIVEIS_CONCLUIDOS
	
				;CALL NIVEL3

INPUT_NIVEL_3::	IMPRIMI_MAPA mapa3
	
				; dinamica de movimenta das criaturas
				CMP CURR_DELAY, DELAY_CRIATURA
				JNE NEXT_INPUT 
	
				; CURR_DELAY == DELAY_CRIATURA
				MOV CURR_DELAY, 0	; zera a contagem
				MOV ECX, 0    ;LENGTHOF ARR_CRIATURAS
				MOV EDI, 0
				
				MOVIMENTA_CRIATURAS CRIATURAS3, mapa3, INPUT_NIVEL_3
				
				NEXT_INPUT:
				CMP COUNTER_CLOCK, CLOCK
				JB OVER_TIMER
				
				TIMER mapa3, INPUT_NIVEL_3
				
				OVER_TIMER:
				
				INC CURR_DELAY
				INC COUNTER_CLOCK
				CALL ReadKey				; look for keyboard input			
				JZ INPUT_NIVEL_3			; se ZF = 0, significa que nenhuma tecla foi pressionada
	
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
	JMP INPUT_NIVEL_3
NIVEL3 ENDP
