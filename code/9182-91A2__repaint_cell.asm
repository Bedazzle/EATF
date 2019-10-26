repaint_cell:  
  EXX
  PUSH DE
  LD E,A
  LD D,0
  LD L,E
  LD H,D
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  ADD HL,DE				; HL = HL*9
  LD DE,GFX_BUFFER
  ADD HL,DE
  POP DE
  LD E,C
  PUSH BC
  LD C,D
  LD B,8

draw_cell:
  LD A,(HL)
  LD (DE),A
  INC HL
  INC D
  DJNZ draw_cell	
  
  LD D,C
  POP BC
  LD A,(HL)
  LD (BC),A
  EXX

  RET
