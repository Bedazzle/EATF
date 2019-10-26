set_menu_bomb:
  CALL reset_bombs	;35301
  LD IX,BOMBS		;49243
  LD (IX+0),1		; present
  LD (IX+1),12		; x
  LD (IX+2),10		; y
  RET
