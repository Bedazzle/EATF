init_variables:
  LD HL,VAR_SETUP
  LD DE,VARIABLES	;SOUND_1
  LD BC,146			; real var length = 135 !
  LDIR

  RET
