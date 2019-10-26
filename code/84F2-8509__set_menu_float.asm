set_menu_float:
  CALL reset_floaters	;34307
  LD IX,FLOATERS
  LD (IX+0),1		; present
  LD (IX+1),7		; x
  LD (IX+2),7		; y
  LD (IX+3),1		; rage
  RET
