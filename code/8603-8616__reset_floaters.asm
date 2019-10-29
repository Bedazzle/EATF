reset_floaters:
  LD IX,FLOATERS
next_float:
  LD A,(IX+FLOATER_ALIVE)
  INC A
  RET Z

  LD (IX+FLOATER_ALIVE),0
  LD BC,7
  ADD IX,BC
  JR next_float
