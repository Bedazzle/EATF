play_melody:
  LD IY,SOUND_1
  CALL play_sound

  LD IY,SOUND_2
  CALL play_sound

  LD IY,SOUND_3
play_sound:
  LD L,(IY+0)
  LD H,(IY+1)
  LD A,(HL)
  OR A
  RET Z

loop_sound:
  LD E,(HL)
  INC HL
  LD D,(HL)
  INC HL
  LD C,(HL)
  INC HL
  LD B,(HL)
  INC HL

  CALL sound_buzz

  LD A,(HL)
  OR A
  JR NZ,loop_sound

  INC HL
  LD (IY+0),L
  LD (IY+1),H

  RET
