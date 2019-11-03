; out:
;	C = x
;	B = y
random_coords:
  CALL random

  AND 31
  CP FIELD_W
  JR NC,random_coords

  LD C,A
gen_coord_y:
  CALL random

  AND 31
  CP FIELD_H
  JR NC,gen_coord_y

  LD B,A

  RET
