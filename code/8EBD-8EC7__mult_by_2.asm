mult_by_2:
  LD A,B
  ADD A,A
  ADD A,1
  LD B,A
  LD A,C
  ADD A,A
  ADD A,1
  LD C,A

  RET
