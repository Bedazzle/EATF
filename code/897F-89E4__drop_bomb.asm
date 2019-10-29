drop_bomb:
  LD A,(ERIC_FRAME)
  CP 6
  RET NC

  LD A,(FLOATS_NUM)
  AND 3
  JR Z,find_free_bomb

  CALL read_keyboard

  INC A
  RET NZ

find_free_bomb:
  LD IX,BOMBS
process_bomb:
  LD A,(IX+FLOATER_ALIVE)
  INC A
  RET Z

  DEC A
  OR A
  JR NZ,bomb_next

  LD BC,(ERIC_X)		; C=x, B=y
  LD (IX+FLOATER_X),C
  LD (IX+FLOATER_Y),B

  CALL get_field_addr

  LD D,B
  LD E,C

  CALL match_space

  RET NZ

  INC BC

  CALL match_space

  RET NZ

  LD HL,31
  ADD HL,BC
  LD B,H
  LD C,L

  CALL match_space

  RET NZ

  INC BC

  CALL match_space

  RET NZ

  LD B,D
  LD C,E
  LD A,96		; bomb sprite

  CALL put_object

  LD A,1
  LD (IX+FLOATER_ALIVE),A
  XOR A
  LD (IX+FLOATER_ANGRY),A
  LD (ERIC_FRAME),A

  RET

bomb_next:
  LD BC,4
  ADD IX,BC
  JP process_bomb	; ?? optimize by JR

match_space:
  LD A,(BC)
  CP 32

  RET
