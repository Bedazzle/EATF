no_erics_left:
  LD BC,5
some_loop:
  PUSH BC

  CALL process_full

  POP BC
  DEC BC
  LD A,B
  OR C
  JR NZ,some_loop

  JP main_menu
