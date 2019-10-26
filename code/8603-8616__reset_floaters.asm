reset_floaters:
  LD IX,FLOATERS
next_float:
  LD A,(IX+0)
  INC A
  RET Z
  LD (IX+0),0
  LD BC,7
  ADD IX,BC
  JR next_float
