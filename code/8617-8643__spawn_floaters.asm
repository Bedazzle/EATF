spawn_floaters:
  LD A,(LEVEL_FLOAT)
  LD B,A
  LD IX,FLOATERS
rnd_floaters:
  LD HL,RESPAWN_PLACES

  CALL random

  AND 3
  ADD A,A
  ADD A,L
  LD L,A
  LD A,0
  ADC A,H
  LD H,A
  LD A,(HL)
  LD (IX+FLOATER_X),A
  INC HL
  LD A,(HL)
  LD (IX+FLOATER_Y),A
  LD (IX+FLOATER_ALIVE),1
 
  LD DE,7
  ADD IX,DE
  DEC B
  JR NZ,rnd_floaters

  RET
