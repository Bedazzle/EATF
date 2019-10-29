random_objects:
  ; ---------------------------
  ; setup Eric coords
  CALL random_coords
  LD A,C
  LD (SOME_X),A

  CP 2
  JR C,random_objects

  CP 13
  JR NC,random_objects

  LD A,B
  LD (SOME_Y),A

  CP 2
  JR C,random_objects

  CP 9
  JR NC,random_objects

  CALL mult_by_2

  PUSH BC

  CALL calc_buff_addr

  LD A,(BC)
  CP 32				; is empty
  POP BC
  JR NZ,random_objects

  LD A,C
  LD (ERIC_X),A
  LD A,B
  LD (ERIC_Y),A

  ; ---------------------------
  ; setup walls
  LD A,WALLS_NUMB

new_wall:
  EX AF,AF'
new_wall_coords:
  CALL random_coords

  LD D,B
  LD E,C
  LD A,(SOME_X)
  SUB E
  JR NC,l_36616

  NEG

l_36616:
  CP FREE_AROUND
  JR NC,l_36634

  LD A,(SOME_Y)
  SUB D
  JR NC,l_36628

  NEG

l_36628:
  CP FREE_AROUND
  JR NC,l_36634
  JR new_wall_coords

l_36634:
  LD A,C
  BIT 0,A
  JR Z,l_36646

  LD A,B
  BIT 0,A
  JR NZ,new_wall_coords
  JR l_36651

l_36646:
  LD A,B
  BIT 0,A
  JR Z,new_wall_coords

l_36651:
  CALL mult_by_2

  LD HL,SOME_TABLE
get_from_table:
  LD A,(HL)
  INC A
  JR Z,setup_gold

  DEC A
  CP B
  JR NZ,next_hl

  INC HL
  LD A,(HL)
  CP C
  JR Z,new_wall_coords
  JR next_hl2

next_hl:
  INC HL
next_hl2:
  INC HL
  JR get_from_table

  ; ---------------------------
setup_gold:
  LD A,(GOLD_CHEST)
  OR A
  JR NZ,setup_exit
  LD A,B
  LD (GOLD_Y),A
  LD A,C
  LD (GOLD_X),A
  LD A,1
  LD (GOLD_CHEST),A

  ; ---------------------------
setup_exit:
  LD A,B
  LD (EXIT_Y),A
  LD A,C
  LD (EXIT_X),A
  LD A,1
  LD (EXIT_DOOR),A

  CALL get_field_addr

  LD A,128			; brick wall
  CALL put_4x_block

  EX AF,AF'
  DEC A
  JP NZ,new_wall

  RET
