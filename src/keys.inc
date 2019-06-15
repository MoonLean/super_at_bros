; CARACTERES ASCII E SEUS RESPECTIVOS CODIGOS HEXADECIMAIS
.NOLIST

;---------------------------------------------------------------------
;						C	O	N	S	T	S
;---------------------------------------------------------------------


SPACE				= 20h 		; espaço
BLOCK				= 2Ah
OBJ_IMOVEL			= 23h		; #
PERSONAGEM			= 40h		; @
OBJETIVO			= 24h		; $
CRIATURA			= 4Fh		; O	 
LINHAS				= 20d
COLUNAS				= 51d
BONUS 				= 43h		; +
w					= 'w'		;
d					= 'd'		; 
s					= 73h 		;'s'
a					= 'a'		; 
W					= 'W'		; 119h		; w
D					= 'D'		; 100h		; d
S					= 'S'		; 115h		; s
A					= 'A'		; 97h		; a

DELAY_CRIATURA		= 50		; a cada n prints de tela a posicao da criatura eh atualizada
								; sendo DELAY_CRIATURA = n

;---------------------------------------------------------------------
;						S	T	R	U	C	T	S
;---------------------------------------------------------------------

CRI_VERTICAL STRUCT
	POS DWORD ?
	DIR BYTE ?		; 1 SUBINDO, 0 DESCENDO
	SENTIDO BYTE ?
CRI_VERTICAL ENDS

.LIST ; reabilita listfile