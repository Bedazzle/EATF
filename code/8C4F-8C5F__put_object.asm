put_object:
  LD (BC),A	; left top sprite
  INC BC
  INC A
  LD (BC),A	; right top sprite
  LD HL,31	; next line
  ADD HL,BC
  LD B,H
  LD C,L
  ADD A,15
  LD (BC),A	; bottom left sprite
  INC BC
  INC A
  LD (BC),A	; bottom right sprite

  RET
