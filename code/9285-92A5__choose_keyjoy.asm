choose_keyjoy:
  CALL inkey

  CP 'K'
  JR Z,disable_joy

  CP 'J'
  JR Z,enable_joy

  CALL read_space_caps

  OR A
  JR NZ,disable_joy

  CALL read_keys_6_0

  OR A
  RET Z

enable_joy:
  LD A,1
set_keyjoy:
  LD (joy_enable),A
  LD A,255

  RET

disable_joy:
  XOR A
  JR set_keyjoy
