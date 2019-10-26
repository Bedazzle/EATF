;  display /A, $
; Routine at 33362
;
; Used by the routine at 33444.
input_select:
  LD (HL),A
  OR A
  RET Z
  CALL choose_keyjoy	
  OR A
  JR NZ,input_select	;33362
  POP HL
choose_loop:
  CALL choose_keyjoy
  OR A
  JR NZ,choose_loop	;33372
  CALL clear_playfield

loop_joykey:
  CALL repaint_buffer	;37212
  CALL print_string
  
  TEXT 5, 12, "SELECT"
  TEXT 7, 7, "KEYBOARD OR JOYSTICK"
  TEXT 9, 10, "PRESS K OR J"

  RST MASK_INT	;56
  CALL choose_keyjoy
  OR A
  JR Z, loop_joykey
  JP game_play	;32839
  ;display /A, $-1
