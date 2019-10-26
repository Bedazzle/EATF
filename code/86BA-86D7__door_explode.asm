door_explode:
  PUSH AF
  LD A,(BC)
  CP 224
  JR C,end_explosion

  XOR A
  LD (EXIT_DOOR),A
  LD A,(EXIT_X)
  LD (FRACTION_X),A
  LD A,(EXIT_Y)
  LD (FRACTION_Y),A
  LD A,1
  LD (NEED_EXTRA),A

end_explosion:
  POP AF
  LD (BC),A

  RET