read_keyboard:
  LD A,(joy_enable)
  OR A
  JR NZ,read_keys_6_0

read_space_caps: 
  LD A,$FE
  IN A,($FE)		; CS, z, x, c, v
  AND 1
  CPL
  RET Z
  LD A,$7F
  IN A,($FE)		; SP, SS, m, n, b
  AND 1
  CPL
  RET Z
  XOR A
  RET

read_keys_6_0:
  PUSH BC
  LD BC,$EFFE	;61438  EFFE = keys 6 to 0
  IN A,(C)
  POP BC
  AND 1
  LD A,$FF		;255
  RET Z
  XOR A
  RET

; Routine at 37337
;
control_eric:
  LD A,(joy_enable)
  OR A
  JR Z,control_by_key	;loc_9208	;37384

control_by_joy:
  PUSH BC
  LD BC,$EFFE	;61438
  IN A,(C)
  CPL
  RRCA
  AND 15
  POP BC
  RET Z
  PUSH HL
  PUSH BC
  LD C,A
  LD B,0
  LD HL,DATA_37368
  ADD HL,BC
  LD A,(HL)
  POP BC
  POP HL
  RET

; Data block at 37368
DATA_37368:
  DEFB 0,1,5,0,3,2,4,0
  DEFB 7,8,6,0,0,1,5,0

; Routine at 37384
;
control_by_key:		;loc_9208:
  CALL inkey	
  PUSH HL
  PUSH BC
  LD HL,DATA_37283
  LD B,16
loc_9212:
  CP (HL)
  JR Z,loc_921A		;37402
  INC HL
  DJNZ loc_9212		;37394

  LD B,18
loc_921A:
  LD A,18
  SUB B
  RRCA
  AND 127
  POP BC
  POP HL
  RET


inkey:
  PUSH BC
  PUSH HL
  PUSH DE
  LD HL,key_mapping
  LD BC,$FEFE
scan_keyrows:
  IN A,(C)
  CPL
  AND 31
  JR Z,next_keyrow

loop_keyrow:
  RRCA
  JR C,key_x	

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

  ; 37447
key_x:
  LD D,A
  LD A,(HL)
  CP 32
  JR Z,x 	;37461

  CP 227
  JR Z,x	;37461

  POP DE
  POP HL
  POP BC

  RET

x:
  LD A,D
  AND 127
  JR Z,next_keyrow
  JR next_key
