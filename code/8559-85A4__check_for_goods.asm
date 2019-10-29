check_for_goods:
  
exit_door_check:
  LD BC,(ERIC_X)		; C=x, B=y
  LD A,(EXIT_DOOR)
  OR A
  JR Z,gold_check
  LD A,(EXIT_Y)
  CP B
  JR NZ,gold_check
  LD A,(EXIT_X)
  CP C
  JR NZ,gold_check

exit_reached:
  XOR A
  LD (EXIT_DOOR),A
  LD A,1
  LD (LEVEL_EXIT),A

  RET

gold_check:
  LD A,(GOLD_CHEST)
  OR A
  RET Z

  LD A,(GOLD_Y)
  CP B
  RET NZ

  LD A,(GOLD_X)
  CP C
  RET NZ

gold_collected:
  XOR A
  LD (GOLD_CHEST),A

  CALL random

  AND 63
  ADD A,A
  SET 4,A
  LD C,A
  LD B,0
  LD HL,(SCORE)
  ADD HL,BC
  LD (SCORE),HL

  LD HL,SNDFX_1
  LD (SOUND_1),HL

  RET
