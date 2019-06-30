; CARACTERES ASCII E SEUS RESPECTIVOS CODIGOS HEXADECIMAIS
.NOLIST

;--------------------------------------------------------------;
;						 C	O	N	S	T	S                  ;
;--------------------------------------------------------------;


SPACE				= 20h 		; espaço	
BLOCK				= 0FEh
INDICADOR_TEMPO		= 0DBh
COMERCIAL			= 0B8h		; simbolo comercial
CLOCK				= 300
CLOCKER				= CLOCK + 500
OBJ_IMOVEL			= 23h		; #
PERSONAGEM			= 40h		; @
OBJETIVO			= 24h		; $
CRIATURA			= 4Fh		; O	 
LINHAS				= 20d
COLUNAS				= 51d
BONUS 				= 2Bh		; +
BONIFICACAO			= 10d		; cada simbolo bonus vale 10pts
_w					= 77h		;'w'
_d					= 64h		;'d'
_s					= 73h 		;'s'
_a					= 61h		;'a'
W					= 057h		;'W'
D					= 044h		;'D'
S					= 053h		;'S'
A					= 041h		;'A'

DELAY_CRIATURA		= 50		; a cada n prints de tela a posicao da criatura eh atualizada
								; sendo DELAY_CRIATURA = n
								
;--------------------------------------------------------------;
;						S	T	R	U	C	T	S              ;
;--------------------------------------------------------------;

;--------------------------------------------------------------;
; NOME:   CRIATURA_DINAMICA                                    ;
; FUNCAO: 													   ;
; PARAMETROS: 												   ;
;                                                              ;
;--------------------------------------------------------------;
CRIATURA_DINAMICA STRUCT
	POS DWORD ?
	DIR BYTE ?			; 0 (<- OU DESCE); 1 (-> OU SOBE)
	SENTIDO BYTE ?		; 0 = eixo x; 1 = eixo y
CRIATURA_DINAMICA ENDS

.LIST ; reabilita listfile
