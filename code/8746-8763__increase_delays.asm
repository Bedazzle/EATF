increase_delays:
  LD HL,ANI_DELAY
  CALL safe_increment

  LD HL,FLOA_DELAY
  CALL safe_increment
  
  LD HL,BONUS_DELAY
  CALL safe_increment
  
  LD HL,FUSE_DELAY
  CALL safe_increment
  
  CALL repaint_buffer
  JP play_melody
