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

