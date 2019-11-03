move_floater:
  LD A,(IX+FLOATER_VECTR)
  ADD A,A
  LD HL,FLO_MOVE
  LD B,0
  LD C,A
  ADD HL,BC

  LD A,(IX+FLOATER_Y)
  ADD A,(HL)
  LD (IX+FLOATER_Y),A	; move vertically

  INC HL

  LD A,(IX+FLOATER_X)
  ADD A,(HL)
  LD (IX+FLOATER_X),A	; move horizontally

  RET
