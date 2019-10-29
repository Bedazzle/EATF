extra_floaters:
  LD A,(NEED_EXTRA)
  OR A
  IFNDEF SAFE_BOOM
	RET Z
  ELSE
	RET
  ENDIF

  LD A,(EXTRA_DONE)
  OR A
  RET NZ

  LD BC,(FRACTION_X)

  CALL get_field_addr
  CALL not_empty

  CP ' '
  RET NZ

  LD A,(LEVEL_FLOAT)
  ADD A,EXTRA_FLOAT
  LD (LEVEL_FLOAT),A

  LD IX,FLOATERS
  LD D,EXTRA_FLOAT
process_floater:
  LD A,(IX+FLOATER_ALIVE)
  INC A
  JR Z,floaters_added

  DEC A
  JR NZ,add_float

  LD (IX+FLOATER_ALIVE),1
  LD A,(FRACTION_X)
  LD (IX+FLOATER_X),A
  LD A,(FRACTION_Y)
  LD (IX+FLOATER_Y),A
  DEC D
  JR Z,floaters_added

add_float:
  LD BC,7
  ADD IX,BC
  JR process_floater

floaters_added:
  LD A,1
  LD (EXTRA_DONE),A
  RET
