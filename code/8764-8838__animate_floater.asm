animate_floater:
  LD A,(FLOA_DELAY)
  OR A

  IFDEF FREEZE_FLOAT
	RET
  ELSE
	RET NZ
  ENDIF

  LD A,(FLIP_FLOAT)	; ingame floater sprite 
  XOR 2
  LD (FLIP_FLOAT),A

  LD IX,FLOATERS
next_floater:
  LD A,(IX+FLOATER_ALIVE)
  INC A
  RET Z

  DEC A
  CP 1
  JP NZ,inc_floater

  LD A,(IX+FLOATER_SPEED)
  DEC A
  LD D,A
  CP 255
  JR NZ,set_speed

  LD A,(IX+FLOATER_ANGRY)
  DEC A
  CP 255
  JR NZ,set_angry

  LD A,3
set_angry:
  LD (IX+FLOATER_ANGRY),A

  LD A,(LEVEL_SPEED)
  LD D,A
set_speed:
  LD A,D
  LD (IX+FLOATER_SPEED),A

  LD A,(IX+FLOATER_ANGRY)
  OR A
  JR Z,set_angry_speed

  LD A,(FLOA_DELAY)
  AND 3
  JP NZ,inc_floater
  
set_angry_speed:
  LD A,(IX+FLOATER_ANGRY)
  OR A
  IFNDEF ANGRY_FLOAT
	JR Z,collide_eric
  ELSE
	jr collide_eric
  ENDIF

  LD A,(IX+FLOATER_SPEED)
  AND 15
  OR A
  JR Z,collide_eric

  AND 3
  OR A
  JR Z,floater_3

  CALL float_test_xy	

  CP 128
  JR NC,floater_2

  CALL move_floater

  JR inc_floater

  ;------------------------
floater_2:
  CALL random

  AND 3
  LD (IX+FLOATER_VECTR),A

  CALL float_test_xy	

  CP 128
  JR NC,inc_floater

  CALL move_floater	

  JR inc_floater

  ;------------------------
floater_3:
  CALL random

  AND 3
  LD (IX+FLOATER_VECTR),A

  CALL float_test_xy	

  CP 128
  JR NC,inc_floater

  CALL move_floater
  
  JR inc_floater
  ;------------------------

collide_eric:
  LD A,(ERIC_X)
  LD B,A
  LD A,(IX+FLOATER_X)
  CP B
  JR Z,chase_to_y	; same X
  JR NC,chase_left	; floater at right

chase_right:
  LD (IX+FLOATER_VECTR),1
  JR chase_horz

chase_left:
  LD (IX+FLOATER_VECTR),0
chase_horz:
  CALL float_test_xy	

  CP 128
  JR C,do_float_move

chase_to_y:
  LD A,(ERIC_Y)
  LD B,A
  LD A,(IX+FLOATER_Y)
  CP B
  JR Z,inc_floater	; same y
  JR NC,chase_up		; floater at bottom

chase_down:
  LD (IX+FLOATER_VECTR),3
  JR chase_vert

chase_up:
  LD (IX+FLOATER_VECTR),2
chase_vert:
  CALL float_test_xy	

  CP 128
  JP NC,inc_floater

do_float_move:
  CALL move_floater

inc_floater:
  LD BC,7
  ADD IX,BC

  JP next_floater
