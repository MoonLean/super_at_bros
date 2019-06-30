TITLE SOUND MODULO, SUPER @ BROS

; Module Description:			
;								
; Author:
; Creation Date:

INCLUDELIB Winmm.lib

.DATA
	SND_ALIAS    DWORD 00010000h
	SND_RESOURCE DWORD 00040005h
	SND_ASYNC	 DWORD 1h
	SND_FILENAME DWORD 00020000h

	winnersong BYTE "c:\\winner.wav",0
	meme_credits BYTE "c:\\meme_credits.wav",0

