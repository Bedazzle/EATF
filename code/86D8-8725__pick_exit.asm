pick_exit:
  LD A,(EXIT_USED)
  OR A
  RET NZ

  LD BC,(EXIT_X)
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
  LD (EXIT_DOOR),A
  LD (EXIT_USED),A

show_exit:
  LD A,(EXIT_DOOR)
  OR A
  RET Z
  
  LD BC,(EXIT_X)

  CALL calc_buff_addr

  LD A,14

  CALL door_explode

  INC BC

  INC A

  CALL door_explode

  LD HL,31
  ADD HL,BC
  LD B,H
  LD C,L
  
  ADD A,15

  CALL door_explode

  INC BC

  INC A

  CALL door_explode

  RET
