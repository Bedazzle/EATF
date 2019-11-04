control_by_key:
  CALL inkey

  PUSH HL
  PUSH BC
  LD HL,KEYS_KEYBOARD
  LD B,16
match_pressed:
  CP (HL)
  JR Z,key_matched

  INC HL
  DJNZ match_pressed

  LD B,18
key_matched:
  LD A,18
  SUB B
  RRCA
  AND 127
  POP BC
  POP HL

  RET
