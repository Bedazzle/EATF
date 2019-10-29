minus_life:
  CALL death_pause

  LD A,(ERICS_LEFT)

  IFNDEF INFINITE_ERICS
	DEC A
  ELSE
	NOP
  ENDIF
  
  OR A
  LD (ERICS_LEFT),A
  JR Z,no_erics_left

  JP level_start
