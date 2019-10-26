pick_gold:
  LD A,(GOLD_USED)
  OR A

  IFNDEF INFINITE_GOLD
	RET NZ
  ELSE
	nop
  ENDIF
  
  LD BC,(GOLD_X)
  LD D,B
  LD E,C

  CALL get_field_addr
  CALL not_empty

  CP 32
  RET NZ

  LD B,D
  LD C,E

  CALL calc_buff_addr
  CALL not_empty

  CP 32
  RET NZ

  LD A,1
  LD (GOLD_CHEST),A
  LD (GOLD_USED),A

  RET
