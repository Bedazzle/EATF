not_empty:
  LD A,(BC)
  CP ' '
  RET NZ

  INC BC
  LD A,(BC)
  CP ' '
  RET NZ

  LD HL,31
  ADD HL,BC
  LD B,H
  LD C,L
  LD A,(BC)
  CP ' '
  RET NZ

  INC BC
  LD A,(BC)
  
  RET	; last block is checked outside this procedure
