process_bombs:
  LD IX,BOMBS
loop_bombs:
  LD A,(IX+BOMB_ACTIVE)
  INC A
  RET Z

  DEC A
  JR Z,proc_next_bomb

  CP 13
  JR Z,del_bomb_sprite

  CP 5
  JR C,fuse_sprites

boom_sprites:
  ADD A,A
  ADD A,214			; sprite epicentrum
  EXX
  LD D,A
  EXX
  JR do_death_cross

fuse_sprites:
  DEC A
  ADD A,A
  ADD A,A
  LD D,A
  LD A,(FLIP_BOMB)
  ADD A,D
  ADD A,96			; 96=bomb sprite
  LD D,A
  EXX
  LD D,A
  EXX
  LD A,(IX+BOMB_X)
  LD C,A
  EXX
  LD C,A
  EXX
  LD A,(IX+BOMB_Y)
  LD B,A
  EXX
  LD B,A
  EXX

  CALL get_field_addr
  CALL activate_bomb

  INC BC
  INC D

  CALL activate_bomb

  LD HL,31
  ADD HL,BC
  LD B,H
  LD C,L
  LD A,15		; lower part of sprite
  ADD A,D
  LD D,A

  CALL activate_bomb

  INC BC
  INC D

  CALL activate_bomb

  EXX

  CALL calc_buff_addr

  LD A,D

  CALL put_object

  EXX

proc_next_bomb:
  LD BC,4
  ADD IX,BC
  JR loop_bombs


; -----------------------------
activate_bomb:
  LD A,(BC)
  CP 224
  RET C

  LD (IX+BOMB_ACTIVE),4
  LD (IX+FUSE_GAP),6

  RET
; -----------------------------
del_bomb_sprite:
  LD A,(IX+BOMB_X)
  LD C,A
  LD A,(IX+BOMB_Y)
  LD B,A

  CALL get_field_addr

  LD A,32

  CALL put_4x_block

  JR proc_next_bomb
; -----------------------------


do_death_cross:
  LD C,(IX+BOMB_X)
  LD B,(IX+BOMB_Y)

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
  JR C,blank_cross

  LD A,32
blank_cross:
  EXX
  LD E,A
  EXX

  LD HL,DEATH_CROSS
cross_explode:
  LD A,(HL)
  OR A
  JR Z,do_near_cross

check_cross_end:
  ADD A,A				; 128 + 128 = 256 = 0
  OR A
  JR Z,proc_next_bomb


  ; ----------
do_near_cross:
  LD A,(HL)
  INC HL
  ADD A,(IX+BOMB_Y)
  LD B,A
  LD A,(HL)
  INC HL
  ADD A,(IX+BOMB_X)
  LD C,A

  CALL boom_1

  CP 136					; border wall
  JR NZ,do_far_cross
  JR skip_3_blocks

  ; ??? not used start
  DEFB 254,137,32,8		; previous JR can be removed, if these 4 bytes are removed too
  ; cp 137
  ; jr nz,$+8
  ; ??? not used end

skip_3_blocks:
  INC HL
  INC HL
increment:
  INC HL
  INC HL
  INC HL
  INC HL
  JR cross_explode
  ; ----------



  ; ----------
do_far_cross:
  LD A,(HL)
  INC HL
  ADD A,(IX+BOMB_Y)
  LD B,A
  LD A,(HL)
  INC HL
  ADD A,(IX+BOMB_X)
  LD C,A

  CALL boom_1

  CP 128					; brick wall...
  JR C,far_cross

  CP 138					; ...Eric
  JR NC,far_cross

skip_2_blocks:
  INC HL				; optimize by JR increment
  INC HL
  INC HL
  INC HL
  JR cross_explode
  ; ----------


far_cross:
  LD A,(HL)
  INC HL
  ADD A,(IX+BOMB_Y)
  LD B,A
  LD A,(HL)
  INC HL
  ADD A,(IX+BOMB_X)
  LD C,A

  CALL boom_2

  EX AF,AF'
  CP 128				; ...brick wall
  JR C,farest_cross

  CP 138				; Eric...
  JR NC,farest_cross

  EX AF,AF'
skip_1_block:
  INC HL
  INC HL
  JR cross_explode
  ; ----------


farest_cross:
  EX AF,AF'
  LD A,(HL)
  INC HL
  ADD A,(IX+BOMB_Y)
  LD B,A
  LD A,(HL)
  INC HL
  ADD A,(IX+BOMB_X)
  LD C,A

  CALL boom_2

  JR cross_explode
  ; ----------


boom_1:
  PUSH BC

  CALL calc_buff_addr

  LD A,(BC)
  POP BC
  CP 136				; border wall
  RET Z

  CP 137				; concrete wall
  RET Z

  CALL get_field_addr

  LD A,(BC)
  CP 136				; border wall
  RET Z

  CP 128				; ...brick wall
  JR C,explosn_sprite

  CP 138				; Eric...
  JR NC,explosn_sprite	; optimize by change to JR C
  JR do_explosn			; optimize by remove

explosn_sprite:
  EXX
  LD A,E
  EXX
  JR put_tile

do_explosn:
  CALL explode_bomb

  CP 136
  JR NZ,put_tile

clear_tile:
  LD A,32
put_tile:
  LD (BC),A

  RET


; -----------------------------
explode_bomb:
  PUSH AF
  EX (SP),HL
  LD A,(FUSE_DELAY)
  OR A
  JR NZ,bomb_wait

  INC H
bomb_wait:
  EX (SP),HL
  POP AF

  RET
; -----------------------------


boom_2:
  PUSH BC

  CALL calc_buff_addr

  LD A,(BC)
  EX AF,AF'
  LD A,(BC)
  EX AF,AF'
  POP BC
  CP 136				; border wall
  IFNDEF SMALLRANGE
	RET Z
  ELSE
	ret
  ENDIF

  CP 137				; concrete wall
  RET Z

  CALL get_field_addr

  LD A,(BC)
  CP 138				; Eric...
  JR NC,put_tile2

  CP 128				; ...bomb
  JR C,put_tile2

  RET

put_tile2:
  EXX
  LD A,E
  EXX
  LD (BC),A

  RET
