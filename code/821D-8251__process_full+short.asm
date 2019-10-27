process_full:
  CALL increase_delays
  CALL copy_buffer
  CALL prepare_field
  CALL process_bombs
  CALL show_gold
  CALL show_exit
  CALL process_floats
  CALL show_eric
  CALL animate_bombs
  CALL show_status

  RET


process_short:
  CALL increase_delays
  CALL copy_buffer
  CALL prepare_field
  CALL show_gold
  CALL show_exit
  CALL show_eric
  CALL show_status

  RET
