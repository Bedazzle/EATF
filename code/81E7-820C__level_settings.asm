level_settings:
  LD A,(FLOATS_NUM)
  CP 6				; no more than 5 floaters
  JR C,float_num_ok

  LD A,5
float_num_ok:
  DEC A
  ADD A,A
  LD HL,LEVEL_FLOATERS
  LD C,A
  LD B,0
  ADD HL,BC
  LD A,(HL)
  LD (LEVEL_FLOAT),A
  INC HL
  LD A,(HL)
  LD (LEVEL_SPEED),A

  RET

LEVEL_FLOATERS:
  DEFB 1,16	; floater number, their speed
  DEFB 2,21
  DEFB 3,26
  DEFB 2,31
  DEFB 4,36
