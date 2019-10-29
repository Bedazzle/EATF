parse_digits:
  LD DE,10000
  CALL calc_number

  LD DE,1000
  CALL calc_number

  LD DE,100
  CALL calc_number

  LD DE,10
  CALL calc_number

  LD A,L
  LD (BC),A
  INC BC
  XOR A
  LD (BC),A
  INC BC

  RET


calc_number:
  XOR A
count_digits:
  OR A
  SBC HL,DE
  JR C,put_digits

  INC A
  JR count_digits

put_digits:
  ADD HL,DE
  LD (BC),A
  INC BC

  RET
