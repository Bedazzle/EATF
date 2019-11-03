prepare_field:
  LD A,136			; sprite $88
  LD B,32
  LD HL,PLAYFIELD
fill_top:
  LD (HL),A			; top border
  INC HL
  DJNZ fill_top

  LD B,32
  LD HL,PLAYFIELD + 736
fill_bottom:
  LD (HL),A			; bottom border
  INC HL
  DJNZ fill_bottom

fill_vertical:
  LD B,23
  LD HL,PLAYFIELD + 31
  LD DE,31
loop_vertical:
  LD (HL),A			; right border
  INC HL
  LD (HL),A			; left border
  ADD HL,DE
  DJNZ loop_vertical

put_concretes:
  LD HL,PLAYFIELD	+ 99	; 32 status line + 2x32 empty row + 1 left border + 2 empty columns
  LD C,5				; height
  LD A,137			; concrete
loop_concretes:
  LD B,7				; width
fill_concrete:
  CALL concrete_block

  OR A
  LD DE,29
  SBC HL,DE
  DJNZ fill_concrete

  LD DE,100
  ADD HL,DE
  DEC C
  JR NZ,loop_concretes

  RET
