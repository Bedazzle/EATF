  device zxspectrum48

	include "eric_macro.asm"
	include "eric_setup.asm"

	ORG 32768

STARTGAME:
  INCLUDE "/code/8000-8014__start_game.asm"
  INCLUDE "/code/8015-8046__play_melody.asm"

  
game_play:
  LD HL,0
  LD (SCORE),HL
  LD A,START_FLOAT
  LD (FLOATS_NUM),A
  LD A,ERICS_NUMB
  LD (ERICS_LEFT),A

  CALL clear_playfield
  CALL repaint_buffer

  LD HL,SCOREBONUS
  CALL deblocker

  LD HL,ERICDEATH
  CALL deblocker

level_start:
  LD HL,START_TIME
  LD (BONUS_TIME),HL

  XOR A
  LD (NEED_CLEAR),A
  LD (ALL_KILLED),A
  LD (GOLD_CHEST),A
  LD (EXIT_DOOR),A
  LD (EXTRA_DONE),A
  LD (NEED_EXTRA),A
  LD (GOLD_USED),A
  LD (EXIT_USED),A
  LD (LEVEL_EXIT),A
  LD (ERIC_DEAD),A

  LD A,1
  LD (ERIC_FRAME),A

  CALL level_settings
  CALL reset_floaters
  CALL spawn_floaters
  CALL reset_bombs
  CALL clear_playfield
  CALL repaint_buffer
  CALL reset_buffer
  CALL prepare_field	
  CALL random_objects

  XOR A
  LD (GOLD_CHEST),A
  LD (EXIT_DOOR),A

play_loop:
  CALL increase_delays
  CALL copy_buffer
  CALL prepare_field
  CALL animate_bombs
  CALL process_bombs
  CALL drop_bomb
  CALL process_eric
  CALL animate_floater
  CALL show_gold
  CALL show_exit
  CALL process_floats
  CALL pick_gold
  CALL pick_exit
  CALL show_eric
  CALL extra_floaters
  CALL exit_door_check
  CALL process_time
  CALL show_status
  CALL show_auto_bomb

  LD A,(ERIC_DEAD)
  OR A
  JP NZ,minus_life

  LD A,(LEVEL_EXIT)
  OR A
  JP NZ,do_level_exit

  LD A,(ALL_KILLED)
  OR A
  JR Z,play_loop

  LD BC,20
process_loop:
  PUSH BC

  CALL process_full

  POP BC
  DEC BC
  LD A,B
  OR C
  JP NZ,process_loop

  LD HL,(BONUS_TIME)
  LD A,H
  OR L
  JR Z,no_bonus

decrease_time:
  PUSH HL

  CALL process_short

  LD HL,SNDFX_2	;33139
  LD (SOUND_2),HL
  POP HL

  LD BC,BONUS_DECR
  OR A
  SBC HL,BC
  LD (BONUS_TIME),HL

  LD DE,(SCORE)
  INC DE
  LD (SCORE),DE
  LD A,H
  OR L
  JP NZ,decrease_time	; optimize to JR

  CALL process_short
  CALL process_short

no_bonus:
  LD A,(FLOATS_NUM)
  INC A
  LD (FLOATS_NUM),A

  PUSH AF
  AND 3

  LD HL,extra_sprites_1

  CALL Z,switch_extra

  POP AF
  AND 252		; %1111 1100
  JP Z,level_start

  AND 12			; %0000 1100
  LD C,A
  LD B,0
  ADD HL,BC

  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL

  PUSH HL
  EX DE,HL

  CALL deblocker

  POP HL

  LD E,(HL)
  INC HL
  LD D,(HL)

  EX DE,HL

  CALL deblocker

  JP level_start

switch_extra:
  LD HL,extra_sprites_2
  RET


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


process_full:
  CALL increase_delays
  CALL copy_buffer
  CALL prepare_field
  CALL process_bombs
  CALL show_gold
  CALL show_exit
  CALL process_floats
  CALL 35949
  CALL animate_bombs
  CALL show_status
  RET


process_short:
  CALL increase_delays
  CALL copy_buffer
  CALL prepare_field
  CALL show_gold
  CALL show_exit
  CALL 35949
  CALL show_status
  RET


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


; Data block at 34965
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

  
; Routine at 35548
;
process_bombs:
  LD IX,BOMBS
loop_bombs:
  LD A,(IX+0)
  INC A
  RET Z

  DEC A
  JR Z,35642
  CP 13
  JR Z,35662
  CP 5
  JR C,35576
  ADD A,A
  ADD A,214
  EXX
  LD D,A
  EXX
  JR 35680
  DEC A
  ADD A,A
  ADD A,A
  LD D,A
  LD A,(FLIP_BOMB)
  ADD A,D
  ADD A,96
  LD D,A
  EXX
  LD D,A
  EXX
  LD A,(IX+1)
  LD C,A
  EXX
  LD C,A
  EXX
  LD A,(IX+2)
  LD B,A
  EXX
  LD B,A
  EXX
  CALL get_field_addr
  CALL loc_35649
  INC BC
  INC D
  CALL loc_35649
  LD HL,31
  ADD HL,BC
  LD B,H
  LD C,L
  LD A,15
  ADD A,D
  LD D,A
  CALL loc_35649
  INC BC
  INC D
  CALL loc_35649
  EXX
  CALL calc_buff_addr
  LD A,D
  CALL put_object
  EXX

;L_35642:
loc_8B3A:
  LD BC,4
  ADD IX,BC
  JR loop_bombs

; Routine at 35649
;
loc_35649:
  LD A,(BC)
  CP 224
  RET C
  LD (IX+0),4	; bomb active
  LD (IX+3),6	; fuse gap
  
  RET
  
  


; Routine at 35662
;
  LD A,(IX+1)
  LD C,A
  LD A,(IX+2)
  LD B,A
  CALL get_field_addr

  LD A,32
  CALL put_4x_block	;35936
  JR loc_8B3A		;L_35642	;35642

; Routine at 35680
;
  LD C,(IX+1)
  LD B,(IX+2)
  CALL get_field_addr
  EXX
  LD A,D
  EXX
  CALL put_object
  EXX
  LD A,D
  EXX
  INC A
  INC A
  CP 240
  JR C,35706

  LD A,32
  EXX
  LD E,A
  EXX

  LD HL,l_36902
loc_8B80:
  LD A,(HL)
  OR A
  JR Z,loc_8B88		;35720

  ADD A,A
  OR A
  JR Z,loc_8B3A		;35642

loc_8B88:
  LD A,(HL)
  INC HL
  ADD A,(IX+2)	; bomb y
  LD B,A
  LD A,(HL)
  INC HL
  ADD A,(IX+1)	; bomb x
  LD C,A
  CALL sub_8BF5		;35829
  CP 136
  JR NZ,loc_8BA9		;35753
  JR loc_8BA1		;35745

; Data block at 35741
  DEFB 254,137,32,8		; previous JR can be removed, if these 4 bytes are placed in different location

; Routine at 35745
;
loc_8BA1:
  INC HL
  INC HL
  INC HL
  INC HL
  INC HL
  INC HL
  JR loc_8B80

; Routine at 35753
;
loc_8BA9:
  LD A,(HL)
  INC HL
  ADD A,(IX+2)
  LD B,A
  LD A,(HL)
  INC HL
  ADD A,(IX+1)
  LD C,A
  CALL sub_8BF5		;35829
  CP 128
  JR C,35782

  CP 138
  JR NC,35782

  INC HL
  INC HL
  INC HL
  INC HL
  JR loc_8B80

  LD A,(HL)
  INC HL
  ADD A,(IX+2)
  LD B,A
  LD A,(HL)
  INC HL
  ADD A,(IX+1)
  LD C,A
  CALL 35886
  EX AF,AF'
  CP 128
  JR C,35811
  CP 138
  JR NC,35811
  EX AF,AF'
  INC HL
  INC HL
  JR loc_8B80

  EX AF,AF'
  LD A,(HL)
  INC HL
  ADD A,(IX+2)
  LD B,A
  LD A,(HL)
  INC HL
  ADD A,(IX+1)
  LD C,A
  CALL 35886
  JR loc_8B80

; Routine at 35829
;
sub_8BF5:
  PUSH BC
  CALL calc_buff_addr
  LD A,(BC)
  POP BC
  CP 136
  RET Z
  CP 137
  RET Z
  CALL get_field_addr
  LD A,(BC)
  CP 136
  RET Z
  CP 128
  JR C,loc_8C12		;35858
  CP 138
  JR NC,loc_8C12		;35858
  JR loc_8C17		;35863

loc_8C12:
  EXX
  LD A,E
  EXX
  JR loc_8C20		;35872

loc_8C17:
  CALL 35874
  CP 136
  JR NZ,loc_8C20		;35872

  LD A,32
loc_8C20:
  LD (BC),A
  RET

; Routine at 35874
;
  PUSH AF
  EX (SP),HL
  LD A,(FUSE_DELAY)
  OR A
  JR NZ,L_35883
  INC H
L_35883:
  EX (SP),HL
  POP AF
  RET

; Routine at 35886
;
  PUSH BC
  CALL calc_buff_addr
  LD A,(BC)
  EX AF,AF'
  LD A,(BC)
  EX AF,AF'
  POP BC
  CP 136
  RET Z
  CP 137
  RET Z
  CALL get_field_addr
  LD A,(BC)
  CP 138
  JR NC,35914
  CP 128
  JR C,35914
  RET
  EXX
  LD A,E
  EXX
  LD (BC),A
  RET


  include "/code/8C4F-8C5F__put_object.asm"
  include "/code/8C60-8C6C__put_4x_block.asm"
  include "/code/8C6D-8CD4__show_eric.asm"


ERIC_MOVE:
  DEFB 0,1
  DEFB 255,0
  DEFB 1,0
  DEFB 0,255


  include "/code/8CDD-8D88__process_eric.asm"


; Data block at 36233
  DEFB 201		; ??? not used RET ???


  include "/code/8D8A-8D9A__check_passage.asm"
  include "/code/8D9B-8E0E__show_status.asm"
  include "/code/8E0F-8E43__show_auto_bomb.asm"


TXT_AUTO:
  DEFB 32,32,21,22,150,21,32,149		; "  BOMB A"
  DEFB 24,48,22,32,16,20,48,48		; "UTO SETT"
  DEFB 151,23,49,32,16,48,149,49		; "ING STAG"
  DEFB 20,32							; "E "
  DEFB 0
  

  include "/code/8E5F-8E9C__prepare_field.asm"
  include "/code/8E9D-8EA7__concrete_block.asm"
  include "/code/8EA8-8EBC__random_coords.asm"
  include "/code/8EBD-8EC7__mult_by_2.asm"
  include "/code/8EC8-8F71__random_objects.asm"


; Data block at 36722
SOME_TABLE:
  DEFB 1,3
  DEFB 3,1

  DEFB 19,1	; reverse ?
  DEFB 21,3	; reverse ?

  DEFB 1,27
  DEFB 3,29

  DEFB 21,27
  DEFB 19,29
 
  DEFB 255
  
  CALL get_field_addr
  LD A, 32
  CALL put_4x_block	;35936
  RET


  include "/code/8F8C-8FAB__random.asm"

  
; block at 36780
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


  include "/code/8FBC-8FC1__fill_by_byte.asm"
  include "/code/8FC2-8FED__parse_digits.asm"
  include "/code/8FEE-8FFB__reset_buffer.asm"
  include "/code/8FFC-9007__copy_buffer.asm"
  include "/code/9008-9013__get_field_addr.asm"
  include "/code/9014-901C__death_pause.asm"


  ; block at 36893
  ; ??? not used ???
pause_400:
  LD HL,$400
pause_400_loop:
  DEC HL
  LD A,H
  OR L
  JR NZ,pause_400_loop
  RET
  ; ??? not used ???

l_36902:  
  DEFB 0,255,0,254,0,253,0,252
  DEFB 1,255,1,254,1,253,1,252
  DEFB 0,2,0,3,0,4,0,5
  DEFB 1,2,1,3,1,4,1,5
  DEFB 255,0,254,0,253,0,252,0
  DEFB 255,1,254,1,253,1,252,1
  DEFB 2,0,3,0,4,0,5,0
  DEFB 2,1,3,1,4,1,5,1

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

 
; Message at 37283
DATA_37283:
  DEFM "WIEODLC"
  DEFB 14
  DEFM "XMZNAJQU"


  INCLUDE "/code/91B3-925B__read_keyboard.asm"


; Data block at 37468
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


block_3:
  DEFB 0,0,0,9

  include "/data/eric_gfx.asm"

  include "/code/9FD0-9FDF__dexoring.asm"

  savebin "eric_decoded.bin",STARTGAME,$-STARTGAME
  savesna "eric_decoded.sna",STARTGAME
