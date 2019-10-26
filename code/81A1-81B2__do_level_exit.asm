do_level_exit:
  LD B, 10
  LD HL, SNDFX_4
  LD (SOUND_3),HL

loop_exit_sound:
  PUSH BC

  CALL process_full

  POP BC

  DJNZ loop_exit_sound
  
  JP level_start
