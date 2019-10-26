put_4x_block:
  LD (BC),A
  INC BC
  LD (BC),A
  LD HL,31
  ADD HL,BC
  LD B,H
  LD C,L
  LD (BC),A
  INC BC
  LD (BC),A

  RET
