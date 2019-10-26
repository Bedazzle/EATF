repaint_buffer:
  LD DE,PLAYFIELD
  LD HL,BUFFER_MORE
  EXX
  LD D,64
  LD BC,SCR_ATTR
repaint_loop:
  EXX
  LD A,(DE)
  CP (HL)
  LD (HL),A

  CALL NZ,repaint_cell

  LD A,32
  LD (DE),A
  INC DE
  INC HL
  EXX
  INC C
  JR NZ,repaint_loop

  INC B
  LD A,D
  ADD A,8
  LD D,A
  CP 88
  JR C,repaint_loop

  RET
