first_run:
  IM 1
  EI
  CALL clear_playfield

  LD A,0
  OUT (254),A

  LD IY,0
  LD HL,block_3
  CALL deblocker

  JP repaint_buffer
