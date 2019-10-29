float_test_xy:
  LD HL,FLO_CHASE
  LD A,(IX+FLOATER_VECTR)
  ADD A,A
  ADD A,A
  LD C,A
  LD B,0
  ADD HL,BC

  LD A,(IX+FLOATER_Y)
  ADD A,(HL)
  LD B,A			; B=new Y

  INC HL

  LD A,(IX+FLOATER_X)
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
  LD A,(IX+FLOATER_Y)
  ADD A,(HL)
  LD B,A
  INC HL
  LD A,(IX+FLOATER_X)
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
