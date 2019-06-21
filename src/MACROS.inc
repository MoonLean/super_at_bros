TITLE MACROS, SUPER @ BROS

; Modulo Description:
; Author:
; Creation Date:

.NOLIST
;--------------------------------------------------------------;
; NOME:   IMPRIMI_MAPA                                         ;
; FUNCAO: move o cursor para o inicio da tela e imprime o mapa ;
; PARAMETROS: mapa                                             ;
;                                                              ;
;--------------------------------------------------------------;
IMPRIMI_MAPA MACRO mapa
	MOV DX, 0
	CALL Gotoxy
	MOV EDX, OFFSET mapa
	CALL WriteString
ENDM

;--------------------------------------------------------------;
; NOME:   TIMER                                                ;
; FUNCAO: move o cursor para o inicio da tela e imprime o mapa ;
; PARAMETROS: arranjo_de_criaturas, mapa, rotina_de_retorno    ;
;                                                              ;
;--------------------------------------------------------------;
TIMER MACRO mapa, retorno
	MOV COUNTER_CLOCK, 0
	CMP CONTAGEM_PROGRESSIVA, 30
	JNE TIMER_NEXT
	
	CALL GAMEOVER
	
	TIMER_NEXT:
	INC CONTAGEM_PROGRESSIVA
	
	MOVZX ESI, POS_INICIAL_TIMER
	MOV mapa[ESI], SPACE
	INC POS_INICIAL_TIMER

	JMP retorno
ENDM

;--------------------------------------------------------------;
; NOME:   ALTERA_CREDITO                                       ;
; FUNCAO: 													   ;
; PARAMETROS: 												   ;
;                                                              ;
;--------------------------------------------------------------;
ALTERA_CREDITO MACRO source, target
	PUSH ECX
	CLD
	MOVZX ECX, QTD_CARACTERES_CREDITOS	
	LEA ESI, source
	LEA EDI, target
	REP MOVSB
	ADD PONTEIRO_CREDITO_ATUAL, QTD_CARACTERES_CREDITOS
	POP ECX
ENDM

;--------------------------------------------------------------;
; NOME:   PlaySound                                            ;
; FUNCAO: 													   ;
; PARAMETROS: 												   ;
;                                                              ;
;--------------------------------------------------------------;
PlaySound PROTO,
        pszSound:PTR BYTE, 
        hmod:DWORD, 
        fdwSound:DWORD

;--------------------------------------------------------------;
; NOME:   MOVIMENTA_CRIATURAS                                  ;
; FUNCAO: move o cursor para o inicio da tela e imprime o mapa ;
; PARAMETROS: arranjo_de_criaturas, mapa, rotina_de_retorno    ;
;                                                              ;
;--------------------------------------------------------------;
MOVIMENTA_CRIATURAS MACRO ARR, mapa, RETORNO
	PONTO:

	CMP ECX, LENGTHOF ARR
	JE RETORNO
	
	PUSH ARR[EDI].POS
	MOV ESI, ARR[EDI].POS
	
	TEST ARR[EDI].SENTIDO, 1 ; 1 -> EIXO Y, 0 -> EIXO X
	JZ EIXO_X
	
	; otherwise
	; EIXO Y
	;----------------------------
	TEST ARR[EDI].DIR, 1		; se ZF = 1 significa que DIR == 0, e por isso, DESCENDO
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
	TEST ARR[EDI].DIR, 1		; se ZF = 1 significa que DIR == 0, e por isso, ESQUERDA
	JZ VOLTANDO 				;
	INC ESI						;
	JMP OVER_VOLTANDO			;	 
	VOLTANDO:					;
	DEC ESI						;
	OVER_VOLTANDO:				;
	;----------------------------
	OVER_EIXO_X:
	
	CMP mapa[ESI], SPACE
	JNE CAPTUROU
	; se chegou ate aqui, significa que o campo destino estava vazio
	
	; otherwise..
	MOV mapa[ESI], CRIATURA
	POP ARR[EDI].POS
	
	MOV ESI, ARR[EDI].POS
	MOV mapa[ESI], SPACE
	
	TEST ARR[EDI].SENTIDO, 1
	JNZ EIXO_Y
	
	; otherwise
	;--------------------------------------------------
	;----------------------------
	TEST ARR[EDI].DIR, 1		;
	JZ OVER__VOLTANDO 			;
	INC ARR[EDI].POS			;	
	JMP OVER__LINE				;	 					ATUALIZAR POSICAO DA CRIATURA QUE SE MOVIMENTA EM X
	OVER__VOLTANDO:				;
	DEC ARR[EDI].POS			;
	OVER__LINE:					;
	;----------------------------	
	JMP OVER_EIXO_Y
	;--------------------------------------------------
	
	;--------------------------------------------------
	EIXO_Y:
	;----------------------------
	TEST ARR[EDI].DIR, 1		;
	JZ _DESCENDO 				;
	SUB ARR[EDI].POS, COLUNAS;
	JMP _LINE					;	 					ATUALIZAR POSICAO DA CRIATURA QUE SE MOVIMENTA EM Y
	_DESCENDO:					;
	ADD ARR[EDI].POS, COLUNAS;
	_LINE:						;
	;----------------------------	
	OVER_EIXO_Y:
	;--------------------------------------------------

	
	INC ECX
	ADD EDI, TYPE CRIATURA_DINAMICA
	JMP PONTO				; ESPECIE DE RETORNO
	
CAPTUROU:
	CMP mapa[ESI], PERSONAGEM
	JNE WALL	
	
	CALL GAMEOVER
	
WALL:
	XOR ARR[EDI].DIR, 1 		
	; acrescentei este pop para	
	; reverter o pop feito no	
	; inicio					
	POP EAX						
	JMP PONTO
ENDM

.LIST