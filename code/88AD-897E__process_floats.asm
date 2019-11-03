process_floats:
  LD IX,FLOATERS
next_bubble:
  LD A,(IX+FLOATER_ALIVE)
  INC A
  RET Z

  DEC A
  JP Z,get_next_bubble

  CP 1
  JP Z,is_floater_hit

  LD C,(IX+FLOATER_X)
  LD B,(IX+FLOATER_Y)

  CALL calc_buff_addr

  LD A,(IX+FLOATER_ALIVE)
  ADD A,A
  ADD A,30
  CP 48
  JR C,killed_floater

  LD A,32

  CALL put_4x_block

  JR put_floater

killed_floater:
  CALL put_object

put_floater:
  PUSH HL

  LD HL,FLOA_DEATH

  CALL safe_increment

  POP HL
  LD A,(FLOA_DEATH)
  OR A
  JP NZ,get_next_bubble

  LD A,(IX+FLOATER_ALIVE)
  INC A
  CP 10
  JR Z,remove_floater

  LD (IX+FLOATER_ALIVE),A
  ADD A,A
  ADD A,A
  ADD A,A
  ADD A,A
  LD E,A
  LD D,0
  PUSH BC

  LD BC,15
  IFDEF SOUND_KILL
	CALL sound_buzz
  ELSE
    nop
    nop
    nop
  ENDIF

  POP BC
  JP get_next_bubble

  ; --------------------
remove_floater:
  XOR A
  LD (IX+FLOATER_ALIVE),A
  LD A,(IX+FLOATER_ANGRY)
  ADD A,A
  ADD A,A
  INC A
  INC A
  LD B,A

  CALL random

  AND 3
  INC A
  ADD A,B
  LD C,A
  LD B,0
  LD HL,(SCORE)
  ADD HL,BC
  LD (SCORE),HL

  ; --------------------

  LD A,(ERIC_FRAME)
  CP 6
  JR NC,get_next_bubble

  LD A,(LEVEL_FLOAT)
  DEC A
  LD (LEVEL_FLOAT),A
  JR NZ,get_next_bubble

  LD A,(ALL_KILLED)
  INC A
  LD (ALL_KILLED),A
  JR get_next_bubble

  ;------------------------
is_floater_hit:
  LD C,(IX+FLOATER_X)
  LD B,(IX+FLOATER_Y)

  CALL calc_buff_addr

  LD A,(IX+FLOATER_ANGRY)
  ADD A,A
  ADD A,A
  ADD A,192					; floater sprite
  LD HL,FLIP_FLOAT
  ADD A,(HL)

  CALL floater_hit

  INC A
  INC BC

  CALL floater_hit

  LD HL,31
  ADD HL,BC
  LD B,H
  LD C,L
  ADD A,15

  CALL floater_hit

  INC BC
  INC A

  CALL floater_hit

get_next_bubble:
  LD BC,7
  ADD IX,BC
  JP next_bubble


floater_hit:
  PUSH AF
  LD A,(BC)
  CP 224						; explosion sprite
  JR C,no_change

  LD (IX+FLOATER_ALIVE),2	; remove floater

no_change:
  POP AF
  LD (BC),A

  RET
