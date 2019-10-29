safe_increment:
  LD A,(HL)
  INC A
  INC HL
  CP (HL)
  JR C,no_reset

  XOR A
no_reset:
  DEC HL
  LD (HL),A

  RET
