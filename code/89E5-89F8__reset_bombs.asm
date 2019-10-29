reset_bombs:
  LD IX,BOMBS
next_bomb:
  LD A,(IX+FLOATER_ALIVE)
  INC A

  RET Z

  LD (IX+FLOATER_ALIVE),0
  LD BC,4
  ADD IX,BC
  JR next_bomb
