fill_loop:
  LD A,(HL)
  INC HL
  OR A
  RET Z
  LD (BC),A
  INC BC
  JR fill_loop
