inkey:
  PUSH BC
  PUSH HL
  PUSH DE
  LD HL,key_mapping
  LD BC,$FEFE
scan_keyrows:
  IN A,(C)
  CPL
  AND 31				; 1 1111
  JR Z,next_keyrow

loop_keyrow:
  RRCA
  JR C,key_pressed

next_key:
  INC HL
  JR loop_keyrow

next_keyrow:
  INC HL
  INC HL
  INC HL
  INC HL
  INC HL
  RLC B
  JR C,scan_keyrows	; loop through FE->FD->FB->F7->EF->DF->BF->7F

  XOR A
  POP DE
  POP HL
  POP BC

  RET

key_pressed:
  LD D,A
  LD A,(HL)
  CP 32					; Space
  JR Z,space_or_caps

  CP 227					; Caps Shift
  JR Z,space_or_caps

  POP DE
  POP HL
  POP BC

  RET

space_or_caps:
  LD A,D
  AND 127
  JR Z,next_keyrow
  JR next_key
