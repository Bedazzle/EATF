reset_bombs:
  LD IX,BOMBS
next_bomb:
  LD A,(IX+0)
  INC A
  RET Z
  LD (IX+0),0
  LD BC,4
  ADD IX,BC
  JR next_bomb
