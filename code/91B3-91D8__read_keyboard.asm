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
  LD BC,$EFFE	; EFFE = keys 6 to 0
  IN A,(C)
  POP BC
  AND 1
  LD A,255
  RET Z

  XOR A

  RET
