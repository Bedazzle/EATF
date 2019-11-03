; set D > 0 if there is no free passage

check_passage:
  IFNDEF WALKTHROUGH
	LD A,(BC)

	INC BC
  ELSE
    inc bc
	ret
  ENDIF

  CP 136				; border wall
  JR NZ,check_concrete

  INC D

check_concrete:
  CP 137				; concrete wall
  JR NZ,check_brick

  INC D

check_brick:
  CP 128				; brick wall
  RET NZ

  INC D

  RET
