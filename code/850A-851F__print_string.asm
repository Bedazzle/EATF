print_string:
  EX (SP),HL
  CALL print_loop
  INC HL
  EX (SP),HL
  RET

print_loop:
  LD A,(HL)
  INC A
  RET Z
  LD B,(HL)	; screen row
  INC HL
  LD C,(HL)	; screen column
  INC HL
  CALL calc_buff_addr
  CALL fill_loop
  JR print_loop
