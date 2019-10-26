float_test_xy:
  LD HL,FLO_CHASE
  LD A,(IX+5)		; vector
  ADD A,A
  ADD A,A
  LD C,A
  LD B,0
  ADD HL,BC

  LD A,(IX+2)	; floater_y
  ADD A,(HL)
  LD B,A			; B=new Y

  INC HL

  LD A,(IX+1)	; floater_x
  ADD A,(HL)
  LD C,A			; C=new X

  PUSH BC
  CALL calc_buff_addr
  LD A,(BC)
  POP BC
  CP 128
  RET NC

  CALL get_field_addr
  LD A,(BC)
  CP 128
  RET NC

  INC HL
  LD A,(IX+2)
  ADD A,(HL)
  LD B,A
  INC HL
  LD A,(IX+1)
  ADD A,(HL)
  LD C,A

  PUSH BC
  CALL calc_buff_addr
  LD A,(BC)
  POP BC
  CP 128
  RET NC

  CALL get_field_addr
  LD A,(BC)

  RET
