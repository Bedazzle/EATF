first_run:
  IM 1
  EI

  CALL clear_playfield

  LD A,0
  OUT (254),A		; black border

  LD IY,0

  LD HL,MAIN_SPRITES

  CALL deblocker

  JP repaint_buffer
