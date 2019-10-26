show_gold:
  LD A,(GOLD_CHEST)
  OR A
  RET Z

  LD DE,(GOLD_X)
  LD B,D
  LD C,E

  CALL calc_buff_addr

  LD A,10		; gold sprite

  CALL check_gold_part

  INC BC
  INC A

  CALL check_gold_part

  LD HL,31
  ADD HL,BC
  LD B,H
  LD C,L
  ADD A,15

  CALL check_gold_part

  INC BC
  INC A
  JP check_gold_part		; optimize by removing

check_gold_part:
  PUSH AF
  LD A,(BC)
  CP 224				; explosion sprite
  JR C,put_gold_part

  XOR A
  LD (GOLD_CHEST),A
  LD A,(GOLD_X)
  LD (FRACTION_X),A
  LD A,(GOLD_Y)
  LD (FRACTION_Y),A
  LD A,1
  LD (NEED_EXTRA),A

put_gold_part:
  POP AF
  LD (BC),A

  RET
