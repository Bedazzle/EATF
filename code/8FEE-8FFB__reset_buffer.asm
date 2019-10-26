reset_buffer:
  LD HL,SOME_BUFFER
  LD DE,SOME_BUFFER+1
  LD BC,BUFFER_SIZE-1	;767
  LD (HL),' '			;32
  LDIR

  RET
