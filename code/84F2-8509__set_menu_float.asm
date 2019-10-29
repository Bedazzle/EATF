set_menu_float:
  CALL reset_floaters

  LD IX,FLOATERS
  LD (IX+FLOATER_ALIVE),1		; present
  LD (IX+FLOATER_X),7
  LD (IX+FLOATER_Y),7
  LD (IX+FLOATER_ANGRY),1

  RET
