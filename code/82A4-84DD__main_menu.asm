main_menu:
  CALL clear_playfield
  CALL repaint_buffer	;37212
  LD HL,block_3			;37570	DE=0  BC=900
  CALL deblocker
  CALL set_menu_float
  CALL set_menu_bomb

  LD A,255
  LD (KEY_CHECK),A
menu_loop:
  CALL choose_keyjoy

  LD HL,KEY_CHECK
  CP (HL)
  CALL NZ,input_select
  CALL increase_delays

  LD BC,PLAYFIELD
  LD D,16 * 12	;x * y = 192
  LD E,137	; BRICK	sprite $89
menu_fill:
  LD A,E
  LD (BC),A
  INC BC
  DEC D
  JR NZ,menu_fill

  LD BC,SCR_ATTR + 18*32 + 18	;23122
  CALL fill_by_byte
  DEFS 13, PAP_WHT + CL_BLK + CL_BRIGHT
  DEFB $00

  LD BC,SCR_ATTR + 19*32 + 18	;23154
  CALL fill_by_byte
  DEFS 13, PAP_WHT + CL_BLK + CL_BRIGHT
  DEFB $00

  LD BC,SCR_ATTR + 20*32 + 18	;23186
  CALL fill_by_byte
  DEFS 13, PAP_WHT + CL_BLK + CL_BRIGHT
  DEFB $00

  CALL print_string
L33601:
  TEXT 1, 12, "        "
L33612:
  TEXT 2, 12, "  ERIC  "
L33623:
  TEXT 3, 6,  "                    "
L33646:
  TEXT 4, 6,  "  AND THE FLOATERS  "
L33669:
  TEXT 11, 14, "BOMB"
L33676:
  TEXT 18, 19, "PRESS SPACE"
L33690:
  TEXT 19, 19, "  KEY TO   "
L33704:
  TEXT 20, 19, "START GAME "
L33718:
  TEXT 10, 7, "UP"
  
  BUTTON_GENERAL $0B, $05, "W I"	; "W", $19, "I"
  TEXT $12, $0B, "BOMB"
  BUTTON $13, $0A, "SPACE"
  TEXT $0D, $01, "LEFT"
  BUTTON_GENERAL $0E, $00, "A J"
  TEXT $0D, $0A, "RIGHT"
  BUTTON_GENERAL $0E, $0A, "D L"
  TEXT $0E, $14, "HIGH"
  TEXT $0F, $14, "SCORE!"

  DEFB $FF
  
  LD HL,(HIGHSCORE)
  CALL parse_digits
  CALL print_string
  
  TEXT $11, $05, "DOWN"
  BUTTON_GENERAL $12, $05, "X M"
  TEXT $0B, $14, "LAST"
  TEXT $0C, $14, "SCORE!"

  DEFB $FF

  LD HL,(SCORE)
  CALL parse_digits
  CALL print_string
  
  DEFB $17, $05
  DEFM "[ HUDSON  SOFT    "
  DEFB $01, $09, $08, $03
  DEFB $00
  
  TEXT $07, $02, "ERIC   FLOATER  BONUS   EXIT"
  TEXT $08, $12, "POINTS  PORTAL"
  
  DEFB $FF

  LD BC, PLAYFIELD + 7*32	; x=0, y=7
  LD A,140			; ERIC 140-141, 155-156
  CALL put_object

  CALL process_bombs
  CALL process_floats

  LD A,(ANI_DELAY)
  OR A
  JR NZ,show_gold_exit

  LD A,(FLIP_BOMB)	; menu bomb sprite
  XOR 2
  LD (FLIP_BOMB),A

  LD A,(FLIP_FLOAT)	; menu floater sprite
  XOR 2
  LD (FLIP_FLOAT),A

show_gold_exit:
  LD BC, PLAYFIELD + 7*32 + 16	; x=16, y=7
  LD A,10			; GOLD 10-11, 26-27
  CALL put_object
  
  LD BC, PLAYFIELD + 7*32 + 24	; x=24, y=7
  LD A,14			; EXIT 14-15, 30-31
					; BOMB 96-97, 112-113
  CALL put_object

  JP menu_loop
