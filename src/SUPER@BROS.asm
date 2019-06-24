
TITLE SUPER@BROS - JOGO BASEADO EM ASSEMBLY

; Program Description:		Um jogo arcade ASCII desenvolvido na línguagem Assembly como requisito parcial
;							para aprovação na disciplina Arquitetura e Organização de Computadores II
;							da Universidade Federal de Sao Carlos, curso: Engenharia de Computacao
;
; Authors:					Luan V. Moraes	-	744342
;							Antonio Caique	-	744332
;
; Creation Date:			28 de Maio de 2019


INCLUDE Irvine32.inc		;
INCLUDE Macros.inc			;
INCLUDE keys.inc			;
INCLUDE MACROS.inc			;
INCLUDE sound.asm			;
INCLUDE variaveis.asm		;
INCLUDE info.asm			;
INCLUDE gameover.asm		;
INCLUDE nivel1.asm			;
INCLUDE nivel2.asm			;
INCLUDE nivel3.asm

; other inclusions

.DATA	

.CODE
main PROC


	CALL NIVEL1

	QUIT::	
EXIT
main ENDP
	
END main 