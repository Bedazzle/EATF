show_auto_bomb:
  LD A,(FLOATS_NUM)
  AND 3
  RET NZ		; each 4th stage have bomb auto setting
 
  LD BC,PLAYFIELD + 768-31	; last line of screen

  LD A,(BLINK_SHOW)
  OR A
  JR Z,clear_auto_text
  
  LD HL,BLINK_SHOW
  CALL safe_increment

  LD HL,TXT_AUTO
  JP fill_loop

clear_auto_text:
  LD H,B
  LD L,C

  LD B,26
clear_loop:
  LD (HL),32
  INC HL
  DJNZ clear_loop

  LD HL,BLINK_HIDE
  CALL safe_increment

  LD A,(BLINK_HIDE)
  OR A
  RET NZ

  LD HL,BLINK_SHOW
  JP safe_increment
