death_pause:
  LD HL,$5000

death_loop:
  DEC HL
  LD A,H
  OR L
  JR NZ,death_loop

  RET
