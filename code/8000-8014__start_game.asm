  LD SP,STACK
  CALL init_variables
  CALL first_run
  
  ; reset score and hiscore
  LD HL,0
  LD (HIGHSCORE),HL
  LD (SCORE),HL

  JP main_menu
