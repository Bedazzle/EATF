show_eric:
  LD A,(ERIC_FRAME)
  CP 6
  JR NC,show_dead_eric

  CP 2
  JR NC,show_eric_move

  OR A
  JR NZ,show_front

  INC A
  LD (ERIC_FRAME),A
  LD E,138			; ERIC drop bomb sprite
  JR show_eric_spr

show_front:
  LD E,140			; ERIC sprite
  JR show_eric_spr

show_eric_move:
  DEC A
  DEC A
  ADD A,A
  ADD A,A
  ADD A,160
  LD E,A
  LD A,(ERIC_SPRITE)
  ADD A,E
  LD E,A
  JR show_eric_spr

show_dead_eric
  SUB 6
  ADD A,A
  LD E,A
  LD A,78
  SUB E
  LD E,A

show_eric_spr:
  LD A,(ERIC_Y)
  LD B,A
  LD A,(ERIC_X)
  LD C,A

  CALL calc_buff_addr

  CALL change_eric_spr
  CALL change_eric_spr

  LD HL,30
  ADD HL,BC
  LD B,H
  LD C,L
  LD A,E
  ADD A,14
  LD E,A

  CALL change_eric_spr
  CALL change_eric_spr

  RET

change_eric_spr:
  LD A,(BC)
  LD D,A
  LD A,E
  LD (BC),A
  INC BC
  INC E
  LD A,D
  CP 192
  RET C
  LD A,(ERIC_FRAME)
  CP 6
  RET NC
  LD A,6
  IFNDEF IMMUNE_ERIC
	LD (ERIC_FRAME),A
  ELSE
	nop
	nop
	nop
  ENDIF
  
  RET
