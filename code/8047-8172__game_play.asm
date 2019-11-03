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

  LD HL,SNDFX_2
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

extra_goods:
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
