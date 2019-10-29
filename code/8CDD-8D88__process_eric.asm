process_eric:
  LD A,(ANI_DELAY)
  OR A
  RET NZ

  LD A,(ERIC_FRAME)
  CP 6
  JR C,eric_alive
  
  CP 13
  JR Z,kill_eric

  LD HL,ERIC_DEATH

  CALL safe_increment

  LD A,(ERIC_DEATH)
  OR A
  RET NZ

  LD A,(ERIC_FRAME)
  INC A
  LD (ERIC_FRAME),A
  ADD A,A
  ADD A,A
  ADD A,A
  LD E,A
  LD D,0

  LD BC,15
  IFDEF SOUND_DEATH
	CALL sound_buzz
  ELSE
    nop
    nop
    nop
  ENDIF

  RET

kill_eric:
  LD A,1
  LD (ERIC_DEAD),A

  RET

eric_alive:
  LD B,2

  CALL control_eric

  CP 5
  JR Z,animate_eric	; go down
  
  INC B
  CP 7
  JR Z,animate_eric	; go left

  INC B
  CP 3
  JR Z,animate_eric	; go right

  INC B
  CP 1
  RET NZ				; ret else go up

animate_eric:
  LD A,(ERIC_SPRITE)
  XOR 2
  LD (ERIC_SPRITE),A

  LD HL,ERIC_MOVE
  LD A,B
  LD E,A
  DEC A
  DEC A
  ADD A,A
  LD B,0
  LD C,A
  ADD HL,BC
  LD A,(ERIC_X)
  ADD A,(HL)
  LD C,A
  LD A,(ERIC_Y)
  INC HL
  ADD A,(HL)
  LD B,A
  PUSH BC

  CALL calc_buff_addr

  LD D,0

  CALL check_passage		; return D>0 if no free passage
  CALL check_passage

  LD HL,30
  ADD HL,BC
  LD B,H
  LD C,L

  CALL check_passage
  CALL check_passage

  LD A,D
  OR A
  POP BC
  RET NZ

  LD A,B
  LD (ERIC_Y),A
  LD A,C
  LD (ERIC_X),A
  LD A,E
  LD (ERIC_FRAME),A
  LD B,8
  LD A,(ERIC_SPRITE)
  SLA A
  SLA A
  SLA A
  OR 64
  LD E,A
  LD D,0
  PUSH BC

  LD BC,5
  IFDEF SOUND_XXX
    CALL sound_buzz
  ELSE
    nop
    nop
    nop
  ENDIF

  POP BC

  RET
