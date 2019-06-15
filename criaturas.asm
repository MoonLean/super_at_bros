TITLE DINAMICA DAS CRIATURAS

INCLUDE keys.inc


.CODE

;
;	PROCEDIMENTO PARA IMPRIMIR MAPA
;
PRINT_MAPA PROC

	MOV DX, 00h
	CALL Gotoxy
	
	MOV EDX, OFFSET mapa1
	CALL WriteString
	
	RET
PRINT_MAPA ENDP

_CRIATURAS_ PROC
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
	TEST VERTIC[EDI].DIR, 1		;
	JZ _DESCENDO 				;
	SUB VERTIC[EDI].POS, COLUNAS;
	JMP _LINE					;	 
	_DESCENDO:					;
	ADD VERTIC[EDI].POS, COLUNAS;
	_LINE:						;
	;----------------------------

	
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



