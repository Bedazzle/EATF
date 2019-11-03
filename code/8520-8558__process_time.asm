process_time:
  LD A,(BONUS_DELAY)
  OR A
  RET NZ

  LD HL,(BONUS_TIME)
  LD A,H
  OR L
  JR Z,do_clear

  IFNDEF INFINITE_TIME
	LD BC,10
  ELSE
	LD BC,0
  ENDIF

  SBC HL,BC
  LD (BONUS_TIME),HL
  RET

do_clear:
  LD A,(NEED_CLEAR)
  OR A
  IFNDEF NO_CLEAR
	RET NZ
  ELSE
	RET
  ENDIF

  CALL reset_buffer

  ; optimize start
  LD A,1
  LD (NEED_CLEAR),A
  XOR A				; optimize by moving ld's down and removing this line
  LD (EXIT_DOOR),A	; down
  LD (GOLD_CHEST),A	; down
  LD A,1				; optimize by moving ld's up, and removing this line
  LD (GOLD_USED),A	; up
  LD (EXIT_USED),A	; up
  XOR A
  LD (GOLD_Y),A
  LD (EXIT_X),A
  ; optimize end

  RET
