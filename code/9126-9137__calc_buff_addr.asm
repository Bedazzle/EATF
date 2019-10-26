;
; calculate address in playfield buffer $C38C (50060) (like screen, 32x24)
; in: 
;     B = row
;     C = column
;     HL = ?
; out:
;     BC = calculated address
calc_buff_addr:
  PUSH HL
  LD L,B			; screen row
  LD H,0
  LD B,H	
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  ADD HL,BC		; add screen column
  LD BC,PLAYFIELD
  ADD HL,BC
  EX (SP),HL
  POP BC
  RET
