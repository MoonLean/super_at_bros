TITLE SOUND MODULO, SUPER @ BROS

; Module Description:			
;								
;
; Author:
; Creation Date:

INCLUDELIB Winmm.lib

.DATA
	SND_ALIAS    DWORD 00010000h
	SND_RESOURCE DWORD 00040005h
	SND_ASYNC	 DWORD 1h
	SND_FILENAME DWORD 00020000h

	deviceConnect BYTE "DeviceConnect",0
	narutowav BYTE "c:\\narutoflauta.wav",0
	meme_credits BYTE "c:\\meme_credits.wav",0
	meme_iririmaue BYTE "c:\\users\\oks\\desktop\\songs\\meme_iririmaue.wav",0
	meme_arnold BYTE "c:\\users\\oks\\desktop\\songs\\meme_arnold.wav",0

