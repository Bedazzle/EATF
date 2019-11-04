control_eric:
  LD A,(joy_enable)
  OR A
  JR Z,control_by_key

control_by_joy:
  PUSH BC
  LD BC,$EFFE	; 09876 keys
  IN A,(C)
  CPL			; pressed = bit set
  RRCA			; throw out bit for "0" key (fire)
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
