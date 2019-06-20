TITLE DINAMICA DAS CRIATURAS, SUPER @ BROS
TITLE CRIATURAS MODULO, SUPER @ BROS

.CODE
;
;
;
;



;
;
;
;
;
COMMENT !
TIMER::
	MOV COUNTER_CLOCK, 0
	CMP CONTAGEM_PROGRESSIVA, 30
	JNE TIMER_NEXT
	
	CALL GAMEOVER
	
	TIMER_NEXT:
	INC CONTAGEM_PROGRESSIVA
	
	MOVZX ESI, POS_INICIAL_TIMER
	MOV mapa1[ESI], SPACE
	INC POS_INICIAL_TIMER

	JMP INPUT
;END TIMER ROTINA


_CRIATURAS_ PROC
_CRIATURAS::
	
	; verifica se todas as criaturas ja foram alteradas
	CMP ECX, 0
	JE INPUT
	
	

	PUSH ARR_CRIATURAS[EDI].POS
	MOV ESI, ARR_CRIATURAS[EDI].POS
	
	TEST ARR_CRIATURAS[EDI].SENTIDO, 1 ; 1 -> EIXO Y, 0 -> EIXO X
	JZ EIXO_X
	
	; otherwise
	; EIXO Y
	;----------------------------
	TEST ARR_CRIATURAS[EDI].DIR, 1		; se ZF = 1 significa que DIR == 0, e por isso, DESCENDO
	JZ DESCENDO 				;
	SUB ESI,  COLUNAS			;
	JMP LINE					;	 
	DESCENDO:					;
	ADD ESI, COLUNAS			;
	LINE:						;
	;----------------------------
	JMP OVER_EIXO_X
	
	EIXO_X:
	;----------------------------
	TEST ARR_CRIATURAS[EDI].DIR, 1		; se ZF = 1 significa que DIR == 0, e por isso, ESQUERDA
	JZ VOLTANDO 				;
	INC ESI						;
	JMP OVER_VOLTANDO			;	 
	VOLTANDO:					;
	DEC ESI						;
	OVER_VOLTANDO:				;
	;----------------------------
	OVER_EIXO_X:
	
	CMP mapa1[ESI], SPACE
	JNE CAPTUROU
	; se chegou ate aqui, significa que o campo destino estava vazio
	
	; otherwise..
	MOV mapa1[ESI], CRIATURA
	POP ARR_CRIATURAS[EDI].POS
	
	MOV ESI, ARR_CRIATURAS[EDI].POS
	MOV mapa1[ESI], SPACE
	
	TEST ARR_CRIATURAS[EDI].SENTIDO, 1
	JNZ EIXO_Y
	
	; otherwise
	;--------------------------------------------------
	;----------------------------
	TEST ARR_CRIATURAS[EDI].DIR, 1		;
	JZ OVER__VOLTANDO 			;
	INC ARR_CRIATURAS[EDI].POS			;	
	JMP OVER__LINE				;	 					ATUALIZAR POSICAO DA CRIATURA QUE SE MOVIMENTA EM X
	OVER__VOLTANDO:				;
	DEC ARR_CRIATURAS[EDI].POS			;
	OVER__LINE:					;
	;----------------------------	
	JMP OVER_EIXO_Y
	;--------------------------------------------------
	
	;--------------------------------------------------
	EIXO_Y:
	;----------------------------
	TEST ARR_CRIATURAS[EDI].DIR, 1		;
	JZ _DESCENDO 				;
	SUB ARR_CRIATURAS[EDI].POS, COLUNAS;
	JMP _LINE					;	 					ATUALIZAR POSICAO DA CRIATURA QUE SE MOVIMENTA EM Y
	_DESCENDO:					;
	ADD ARR_CRIATURAS[EDI].POS, COLUNAS;
	_LINE:						;
	;----------------------------	
	OVER_EIXO_Y:
	;--------------------------------------------------

	
	DEC ECX
	ADD EDI, TYPE CRIATURA_DINAMICA
	JMP _CRIATURAS				; ESPECIE DE RETORNO
	
CAPTUROU:
	CMP mapa1[ESI], PERSONAGEM
	JNE WALL	
	
	CALL GAMEOVER
	
WALL:
	XOR ARR_CRIATURAS[EDI].DIR, 1 		
	; acrescentei este pop para	
	; reverter o pop feito no	
	; inicio					
	POP EAX						
	JMP _CRIATURAS				
	
; END _CRIATURAS ROTINA

_CRIATURAS_ ENDP
!