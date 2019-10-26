move_floater:
  LD A,(IX+5)
  ADD A,A
  LD HL,FLO_MOVE	
  LD B,0
  LD C,A
  ADD HL,BC

  LD A,(IX+2)
  ADD A,(HL)
  LD (IX+2),A	; move floater vertically

  INC HL

  LD A,(IX+1)
  ADD A,(HL)
  LD (IX+1),A	; move floater horizontally
  RET
