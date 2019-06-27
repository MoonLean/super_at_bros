TITLE VARIAVEIS MODULO, SUPER @ BROS

; Program Description:	ALGUMAS VARIAVEIS QUE SAO UTILIZADAS AO LONGO DE TODO O JOGO
; Author:
; Creation Date:


.DATA
		PONTUACAO_TOTAL 			WORD 0					;guarda a soma da quantidade de bonus pegos em todas as telas
	
		PONTUACAO 					BYTE "123456789"		;adaptacao para alterar display de pontos

		NIVEIS_CONCLUIDOS 			BYTE 0					;incrementa a cada nivel concluido
		
		TEMPO_TOTAL					WORD 0					;a soma dos tempos gastos em cada mapa
	
		PERSON 						DWORD 461				;guarda a posicao do personagem, inicialmente no nivel 1
	
	;manipulacao de tempo
		POS_INICIAL_TIMER 			WORD 321				;local no mapa onde esta o primeiro elemento da barra de tempo
		CONTAGEM_PROGRESSIVA 		BYTE 0					;de 0 a 30
		COUNTER_CLOCK 				WORD 0					;contador auxiliar de tempo
