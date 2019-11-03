animate_bombs:
  LD A,(FLIP_BOMB)	; ingame bomb sprite
  XOR 2
  LD (FLIP_BOMB),A

  LD IX,BOMBS
anim_bomb:
  LD A,(IX+BOMB_ACTIVE)
  INC A
  RET Z

  DEC A
  JR Z,anim_next_bomb

  CP 5
  JR NC,explode

change_fuse:
  LD A,(IX+FUSE_GAP)
  INC A
  LD (IX+FUSE_GAP),A
  CP 7
  JR NZ,anim_next_bomb

explode:
  XOR A
  LD (IX+FUSE_GAP),A
  LD A,(FUSE_DELAY)
  OR A
  JR NZ,anim_next_bomb

  LD A,(IX+BOMB_ACTIVE)
  INC A
  CP 14
  JR Z,remove_bomb

  LD (IX+BOMB_ACTIVE),A
  CP 5
  JR C,anim_next_bomb

  CP 6
  JR Z,bomb_boom_fx

  LD A,(ERIC_FRAME)		; optimize
  CP 6					; optimize
  JR NC,anim_next_bomb	; optimize

  JR anim_next_bomb

remove_bomb:
  XOR A
  LD (IX+BOMB_ACTIVE),A
anim_next_bomb:
  LD BC,4
  ADD IX,BC
  JR anim_bomb

bomb_boom_fx:
  LD HL,SNDFX_3
  LD (SOUND_2),HL
  JR anim_next_bomb
