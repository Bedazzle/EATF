concrete_block:
  LD (HL),A	; top left
  INC HL
  LD (HL),A	; top right
  LD DE,31
  ADD HL,DE
  LD (HL),A	; bottom left
  INC HL
  LD (HL),A	; bottom right

  RET
