fill_by_byte:
  EX (SP),HL
  CALL fill_loop
  EX (SP),HL
  
  RET
