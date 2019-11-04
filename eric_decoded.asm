; Eric and the floaters
; full disassembly
; reversed in 2019.11
; sources can be compiled with SjASM+

  device zxspectrum48

	include "eric_macro.asm"
	include "eric_setup.asm"

	ORG $8000	; 32768

STARTGAME:
  INCLUDE "/code/8000-8014__start_game.asm"
  INCLUDE "/code/8015-8046__play_melody.asm"
  INCLUDE "/code/8047-8172__game_play.asm"
  include "/data/8173-8180__sound_score.asm"


extra_sprites_1:
  DEFW m_gun_hi
  DEFW m_gun_lo

  DEFW money_hi
  DEFW money_lo

  DEFW bicycle_hi
  DEFW bicycle_lo

  DEFW car_hi
  DEFW car_lo

extra_sprites_2:
  DEFW tnt_hi
  DEFW tnt_lo

  DEFW coctail_hi
  DEFW coctail_lo

  DEFW coke_hi
  DEFW coke_lo

  DEFW pipe_hi
  DEFW pipe_lo


  include "/code/81A1-81B2__do_level_exit.asm"
  include "/data/81B3-81D6__sound_exit.asm"
  include "/code/81D7-81E6__minus_life.asm"
  include "/code/81E7-820C__level_settings.asm"
  include "/code/820D-821C__no_erics_left.asm"
  include "/code/821D-8251__process_full+short.asm"
  include "/code/8252-82A3__input_select.asm"
  include "/code/82A4-84DD__main_menu.asm"
  include "/code/84DE-84F1__set_menu_bomb.asm"
  include "/code/84F2-8509__set_menu_float.asm"
  include "/code/850A-851F__print_string.asm"
  include "/code/8520-8558__process_time.asm"
  INCLUDE "/code/8559-85A4__check_for_goods.asm"
  INCLUDE "/data/85A5-85B4__sound_gold.asm"
  INCLUDE "/code/85B5-8602__extra_floaters.asm"
  include "/code/8603-8616__reset_floaters.asm"
  include "/code/8617-8643__spawn_floaters.asm"


RESPAWN_PLACES:
  DEFB 1,1,29,1,1,19,29,19


  include "/code/864C-8673__pick_gold.asm"
  include "/code/8674-86B9__show_gold.asm"
  include "/code/86BA-86D7__door_explode.asm"
  include "/code/86D8-8725__pick_exit.asm"
  include "/code/8726-873B__not_empty.asm"
  include "/code/873C-8745__safe_increment.asm"
  include "/code/8746-8763__increase_delays.asm"
  include "/code/8764-8838__animate_floater.asm"
  INCLUDE "/code/8839-8853__move_floater.asm"
  INCLUDE "/code/8854-8894__float_test_xy.asm"


FLO_CHASE:
  DEFB 0,255,1,255	; to left
  DEFB 0,2,1,2		; to right
  DEFB 255,0,255,1	; to up
  DEFB 2,0,2,1		; to down

FLO_MOVE:
  DEFB 0,255		; move left
  DEFB 0,1		; right
  DEFB 255,0		; up
  DEFB 1,0		; down


  include "/code/88AD-897E__process_floats.asm"
  include "/code/897F-89E4__drop_bomb.asm"
  include "/code/89E5-89F8__reset_bombs.asm"
  include "/code/89F9-8A54__animate_bombs.asm"
  include "/data/8A55-8ADB__sound_explosion.asm"

  include "/code/8ADC-8C4E__process_bombs.asm"

  include "/code/8C4F-8C5F__put_object.asm"
  include "/code/8C60-8C6C__put_4x_block.asm"
  include "/code/8C6D-8CD4__show_eric.asm"


ERIC_MOVE:
  DEFB 0,1
  DEFB 255,0
  DEFB 1,0
  DEFB 0,255


  include "/code/8CDD-8D88__process_eric.asm"


  DEFB 201		; ??? not used RET ???


  include "/code/8D8A-8D9A__check_passage.asm"
  include "/code/8D9B-8E0E__show_status.asm"
  include "/code/8E0F-8E43__show_auto_bomb.asm"


TXT_AUTO:
  DEFB 32,32						; "  "
  DEFB 21,22,150,21,32		; 	; "BOMB "
  DEFB 149,24,48,22,32			; "AUTO "
  DEFB 16,20,48,48,151,23,49,32	; "SETTING "
  DEFB 16,48,149,49,20,32		; "STAGE "
  DEFB 0


  include "/code/8E5F-8E9C__prepare_field.asm"
  include "/code/8E9D-8EA7__concrete_block.asm"
  include "/code/8EA8-8EBC__random_coords.asm"
  include "/code/8EBD-8EC7__double_b_c.asm"
  include "/code/8EC8-8F71__random_objects.asm"


WALLS_TABLE:
  DEFB 1,3
  DEFB 3,1

  DEFB 19,1	; reverse ?
  DEFB 21,3	; reverse ?

  DEFB 1,27
  DEFB 3,29

  DEFB 21,27
  DEFB 19,29

  DEFB 255	; table exit


  ; ??? not used start
x_8F83:		; 36739
  CALL get_field_addr
  LD A, 32
  CALL put_4x_block
  RET
  ; ??? not used end


  include "/code/8F8C-8FAB__random.asm"


  ; ??? not used start
l_36780:
  cp      10
  jr      c, loc_8FBA
  ld      h, 0
  ld      l, a
  ld      de, 10
  call    calc_number
  ld      a, l
loc_8FBA:
  ld      (bc), a
  ret
  ; ??? not used end


  include "/code/8FBC-8FC1__fill_by_byte.asm"
  include "/code/8FC2-8FED__parse_digits.asm"
  include "/code/8FEE-8FFB__reset_buffer.asm"
  include "/code/8FFC-9007__copy_buffer.asm"
  include "/code/9008-9013__get_field_addr.asm"
  include "/code/9014-901C__death_pause.asm"


  ; ??? not used start
pause_400:
  LD HL,$400
pause_400_loop:
  DEC HL
  LD A,H
  OR L
  JR NZ,pause_400_loop
  RET
  ; ??? not used end


DEATH_CROSS:
  ; left ray
  DEFB 0, -1	; BOMB_Y/X
  DEFB 0, -2	;
  DEFB 0, -3;
  DEFB 0, -4

  DEFB 1, -1
  DEFB 1, -2
  DEFB 1, -3
  DEFB 1, -4

  ; right ray
  DEFB 0,2
  DEFB 0,3
  DEFB 0,4
  DEFB 0,5

  DEFB 1,2
  DEFB 1,3
  DEFB 1,4
  DEFB 1,5

  ; upper ray
  DEFB -1,0
  DEFB -2,0
  DEFB -3,0
  DEFB -4,0

  DEFB -1,1
  DEFB -2,1
  DEFB -3,1
  DEFB -4,1

  ; lower ray
  DEFB 2,0
  DEFB 3,0
  DEFB 4,0
  DEFB 5,0

  DEFB 2,1
  DEFB 3,1
  DEFB 4,1
  DEFB 5,1

  ; cross end
  DEFB 128,128,128,128


  include "/code/906A-9075__init_variables.asm"
  include "/data/9076-90FC__VAR_SETUP.asm"
  include "/code/90FD-9113__first_run.asm"
  include "/code/9114-9125__deblocker.asm"
  include "/code/9126-9137__calc_buff_addr.asm"
  include "/code/9138-913F__fill_loop.asm"
  include "/code/9140-915B__clear_playfield.asm"
  INCLUDE "/code/915C-9181__repaint_buffer.asm"
  INCLUDE "/code/9182-91A2__repaint_cell.asm"


KEYS_KEYBOARD:
  DEFM "W"	; 16	; up = (18-16)/2 = 1
  DEFM "I"	; 15	; up
  DEFM "E"	; 14
  DEFM "O"	; 13
  DEFM "D"	; 12	; right = (18-12)/2 = 3
  DEFM "L"	; 11	; right
  DEFM "C"	; 10
  DEFB 14	; 9		; Symbol Shift
  DEFM "X"	; 8		; down = (18-8)/2 = 5
  DEFM "M"	; 7		; down
  DEFM "Z"	; 6
  DEFM "N"	; 5
  DEFM "A"	; 4		; left = (18-4)/2 = 7
  DEFM "J"	; 3		; left
  DEFM "Q"	; 2
  DEFM "U"	; 1


  INCLUDE "/code/91B3-91D8__read_keyboard.asm"
  INCLUDE "/code/91D9-91F8__control_eric.asm"


KEYS_JOYSTICK:
  DEFB 0		; 0
  DEFB 1		; 1		; up
  DEFB 5		; 2		; down
  DEFB 0		; 3
  DEFB 3		; 4		; right
  DEFB 2		; 5
  DEFB 4		; 6
  DEFB 0		; 7
  DEFB 7		; 8		; left
  DEFB 8		; 9
  DEFB 6		; 10
  DEFB 0		; 11
  DEFB 0		; 12
  DEFB 1		; 13	; left+right+up = up
  DEFB 5		; 14	; left+right+down = down
  DEFB 0		; 15


  INCLUDE "/code/9208-9222__control_by_key.asm"
  INCLUDE "/code/9223-925B__inkey.asm"


key_mapping:
  DEFB 227		; $FEFE	; 1111 1110	; Caps Shift
  DEFM "ZXCV"

  DEFM "ASDFG"	; $FDFE	; 1111 1101
  DEFM "QWERT"	; $FBFE	; 1111 1011
  DEFM "12345"	; $F7FE	; 1111 0111
  DEFM "09876"	; $EFFE	; 1110 1111
  DEFM "POIUY"	; $DFFE	; 1101 1111

  DEFB 13		; $BFFE	; 1011 1111	; Enter
  DEFM "LKJH"

  DEFM " "		; $7FFE	; 0111 1111
  DEFB 14		; Symbol Shift
  DEFM "MNB"

joy_enable:
  DEFS 1


  include "/code/9285-92A5__choose_keyjoy.asm"
  include "/code/92A6-92C1__sound_buzz.asm"
  include "/data/eric_gfx_main.asm"
  include "/data/eric_gfx_scorebonus.asm"

; not used start
	DB	0	; ........	9C24	39972
	DB	0	; ........	9C25	39973
	DB	9	; ....#..#	9C26	39974
	DB	0	; ........	9C27	39975
; not used end

  include "/data/eric_gfx_death.asm"

; not used start
	DB	0	; ........	9E6C	40556
	DB	0	; ........	9E6D	40557
	DB	9	; ....#..#	9E6E	40558
	DB	0	; ........	9E6F	40559
; not used end

  include "/data/eric_gfx_extra.asm"

  include "/code/9FD0-9FDF__dexoring.asm"

  savebin "eric_decoded.bin",STARTGAME,$-STARTGAME
  savesna "eric_decoded.sna",STARTGAME
