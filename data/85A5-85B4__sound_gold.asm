SNDFX_1:
  IFNDEF SOUND_GOLD
	DEFS 16, 0
  ELSE
	DEFB 212,0		; DE inner loop for sound wave
	DEFB 20,0		; BC outer loop for sound wave
	DEFB 0
	
	DEFB 178,0,20,0
	DEFB 0
	
	DEFB 142,0,20,0
	DEFB 0
	DEFB 0
  ENDIF