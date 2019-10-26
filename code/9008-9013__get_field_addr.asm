get_field_addr:
  PUSH HL

  CALL calc_buff_addr

  LD HL,FIELD
  ADD HL,BC
  LD B,H
  LD C,L
  POP HL

  RET
