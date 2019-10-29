set_menu_bomb:
  CALL reset_bombs

  LD IX,BOMBS
  LD (IX+BOMB_ACTIVE),1		; present
  LD (IX+BOMB_X),12
  LD (IX+BOMB_Y),10

  RET
