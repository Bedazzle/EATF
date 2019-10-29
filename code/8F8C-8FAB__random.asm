random:
  PUSH HL
  PUSH DE
  PUSH BC
  LD HL,(RND_SEED)
  LD A,H
  RLA
  RLA
  XOR L
  RRA
  PUSH AF
  LD A,H
  XOR L
  LD H,A
  LD A,R
  XOR L
  LD L,A
  POP AF
  RL L
  RL H
  LD (RND_SEED),HL
  LD A,L
  POP BC
  POP DE
  POP HL

  RET
