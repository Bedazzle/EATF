; used once when game is loaded to decode code and data

dexoring:
  LD HL, STARTGAME
  LD BC, dexoring-STARTGAME	;1FD0h
xor_loop:
  LD A,(HL)
  XOR L
  LD (HL),A
  INC HL
  DEC BC
  LD A,B
  OR C
  JR NZ, xor_loop

  RET
