deblocker:
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL
  PUSH HL
  LD HL,GFX_BUFFER
  ADD HL,DE
  EX DE,HL
  POP HL
  LDIR

  RET
