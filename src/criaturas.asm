TITLE DINAMICA DAS CRIATURAS, SUPER @ BROS

INCLUDE keys.inc


.CODE

;
;	PROCEDIMENTO PARA IMPRIMIR MAPA
;
;
PRINT_MAPA PROC

	MOV DX, 00h
	CALL Gotoxy
	
	MOV EDX, OFFSET mapa1
	CALL WriteString
	
	RET
PRINT_MAPA ENDP

;
;
;
;
;
_CRIATURAS_ PROC
_CRIATURAS::
	
	; verifica se todas as criaturas verticais ja foram alteradas
	CMP ECX, 0
	JE INPUT
	
	

	PUSH VERTIC[EDI].POS
	MOV ESI, VERTIC[EDI].POS
	
	TEST VERTIC[EDI].SENTIDO, 1 ; 1 -> EIXO Y, 0 -> EIXO X
	JZ EIXO_X
	
	; otherwise
	; EIXO Y
	;----------------------------
	TEST VERTIC[EDI].DIR, 1		; se ZF = 1 significa que DIR == 0, e por isso, DESCENDO
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
	TEST VERTIC[EDI].DIR, 1		; se ZF = 1 significa que DIR == 0, e por isso, DESCENDO
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
	POP VERTIC[EDI].POS
	
	MOV ESI, VERTIC[EDI].POS
	MOV mapa1[ESI], SPACE
	
	TEST VERTIC[EDI].SENTIDO, 1
	JNZ EIXO_Y
	
	; otherwise
	;--------------------------------------------------
	;----------------------------
	TEST VERTIC[EDI].DIR, 1		;
	JZ OVER__VOLTANDO 			;
	INC VERTIC[EDI].POS			;	
	JMP OVER__LINE				;	 					ATUALIZAR POSICAO DA CRIATURA QUE SE MOVIMENTA EM X
	OVER__VOLTANDO:				;
	DEC VERTIC[EDI].POS			;
	OVER__LINE:					;
	;----------------------------	
	JMP OVER_EIXO_Y
	;--------------------------------------------------
	
	;--------------------------------------------------
	EIXO_Y:
	;----------------------------
	TEST VERTIC[EDI].DIR, 1		;
	JZ _DESCENDO 				;
	SUB VERTIC[EDI].POS, COLUNAS;
	JMP _LINE					;	 					ATUALIZAR POSICAO DA CRIATURA QUE SE MOVIMENTA EM Y
	_DESCENDO:					;
	ADD VERTIC[EDI].POS, COLUNAS;
	_LINE:						;
	;----------------------------	
	OVER_EIXO_Y:
	;--------------------------------------------------

	
	DEC ECX
	ADD EDI, TYPE CRI_VERTICAL
	JMP _CRIATURAS				; ESPECIE DE RETORNO
	
CAPTUROU:
	CMP mapa1[ESI], PERSONAGEM
	JNE WALL
	; otherwise
	JMP QUIT
	
WALL:
	XOR VERTIC[EDI].DIR, 1 		
	; acrescentei este pop para	
	; reverter o pop feito no	
	; inicio					
	POP EAX						
	JMP _CRIATURAS				
	
; END _CRIATURAS ROTINA

_CRIATURAS_ ENDP
