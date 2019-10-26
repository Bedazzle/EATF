; set D > 0 if there is no free passage

check_passage:
  IFNDEF WALKTHROUGH
	LD A,(BC)

	INC BC
  ELSE
    inc bc
	ret
  ENDIF

  CP 136			; ???
  JR NZ,check_concrete
  
  INC D

check_concrete:
  CP 137			; concrete
  JR NZ,check_brick	

  INC D

check_brick:
  CP 128			; brick
  RET NZ

  INC D

  RET
