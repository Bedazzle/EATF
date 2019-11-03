control_eric:
  LD A,(joy_enable)
  OR A
  JR Z,control_by_key

control_by_joy:
  PUSH BC
  LD BC,$EFFE	; 09876 keys
  IN A,(C)
  CPL
  RRCA
  AND 15			; 1111
  POP BC
  RET Z

  PUSH HL
  PUSH BC
  LD C,A
  LD B,0
  LD HL,KEYS_JOYSTICK
  ADD HL,BC
  LD A,(HL)
  POP BC
  POP HL

  RET


KEYS_JOYSTICK:
  DEFB 0,1,5,0,3,2,4,0
  DEFB 7,8,6,0,0,1,5,0


control_by_key:
  CALL inkey

  PUSH HL
  PUSH BC
  LD HL,KEYS_KEYBOARD
  LD B,16
loc_9212:
  CP (HL)
  JR Z,loc_921A

  INC HL
  DJNZ loc_9212

  LD B,18
loc_921A:
  LD A,18
  SUB B
  RRCA
  AND 127
  POP BC
  POP HL

  RET
