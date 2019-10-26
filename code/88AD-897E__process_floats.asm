process_floats:
  LD IX,FLOATERS
next_bubble:
  LD A,(IX+0)
  INC A
  RET Z

  DEC A
  JP Z,get_next_bubble

  CP 1
  JP Z,loc_893E

  LD C,(IX+1)
  LD B,(IX+2)
  CALL calc_buff_addr

  LD A,(IX+0)
  ADD A,A
  ADD A,30
  CP 48
  JR C,loc_88D9

  LD A,32
  CALL put_4x_block

  JR loc_88DC

loc_88D9:
  CALL put_object

loc_88DC:
  PUSH HL

  LD HL,FLOA_DEATH
  CALL safe_increment

  POP HL
  LD A,(FLOA_DEATH)
  OR A
  JP NZ,get_next_bubble

  LD A,(IX+0)
  INC A
  CP 10
  JR Z,loc_8908

  LD (IX+0),A
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
loc_8908:
  XOR A
  LD (IX+0),A
  LD A,(IX+3)
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
loc_893E:
  LD C,(IX+1)
  LD B,(IX+2)
  CALL calc_buff_addr
  
  LD A,(IX+3)
  ADD A,A
  ADD A,A
  ADD A,192
  LD HL,FLIP_FLOAT
  ADD A,(HL)
  CALL check_224
  
  INC A
  INC BC
  CALL check_224
  
  LD HL,31
  ADD HL,BC
  LD B,H
  LD C,L
  ADD A,15
  CALL check_224
  
  INC BC
  INC A
  CALL check_224

get_next_bubble:
  LD BC,7
  ADD IX,BC
  JP next_bubble

;------------------------
; Routine at 35186
;
check_224:
  PUSH AF
  LD A,(BC)
  CP 224
  JR C,no_change

  LD (IX+0),2	; remove floater

no_change:
  POP AF
  LD (BC),A
  RET
