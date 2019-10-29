sound_buzz:
  PUSH HL
loop_buzz:
  LD A,16
  CALL out_beeper

  LD A,0
  CALL out_beeper

  DEC BC
  LD A,C
  OR B
  JR NZ,loop_buzz

  POP HL

  RET

out_beeper:
  OUT (254),A
  LD H,D
  LD L,E
loop_beeper:
  DEC HL
  LD A,H
  OR L
  JR NZ,loop_beeper

  RET
