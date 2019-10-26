show_status:
  ; compare if new score beats hiscore
  LD BC,(SCORE)
  LD HL,(HIGHSCORE)
  SBC HL,BC
  JR NC,no_highscore

  LD (HIGHSCORE),BC

no_highscore:
  LD BC,PLAYFIELD + 1	;50061
  CALL fill_by_byte
  DEFB $20, $10, $11, $12, $13, $14, $21, $20	; " SCORE: "
  DEFB $00
  
  LD HL,(SCORE)
  CALL parse_digits

  CALL fill_by_byte
  DEFB $20, $20, $20, $15, $16, $17, $18, $19, $21, $20	; "   BONUS: "
  DEFB $00

; Routine at 36301
  LD HL,(BONUS_TIME)
  CALL parse_digits

  DEC BC
  CALL fill_by_byte
  DEFB $20
  DEFB $00

  LD BC,PLAYFIELD + 768-31
  CALL fill_by_byte
  DEFB $20, $20, $20, $20, $20, $10, $30, $95, $31, $14, $21, $20	; "     STAGE: "
  DEFB $00

  LD A,(FLOATS_NUM)
  LD (BC),A
  INC BC
  CALL fill_by_byte
  DEFB $20, $20, $20, $20, $14, $13, $97, $11, $10, $21, $20	; "    ERICS: "
  DEFB $00  
  
  LD A,(ERICS_LEFT)
  LD (BC),A
  INC BC
  CALL fill_by_byte
  DEFB $20, $20, $20, $20, $20	; "     "
  DEFB $00
  
  RET
