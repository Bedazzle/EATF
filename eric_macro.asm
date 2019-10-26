CL_BRIGHT	EQU %01000000
CL_FLASH	EQU %10000000

CL_BLK EQU 0	; black
CL_BLU EQU 1	; blue
CL_RED EQU 2	; red
CL_MGN EQU 3	; magenta
CL_GRN EQU 4	; green
CL_SKY EQU 5	; skyblue
CL_YEL EQU 6	; yellow
CL_WHT EQU 7	; white

PAP_BLK	EQU CL_BLK << 3
PAP_BLU	EQU CL_BLU << 3
PAP_RED	EQU CL_RED << 3
PAP_MGN	EQU CL_MGN << 3
PAP_GRN	EQU CL_GRN << 3
PAP_SKY	EQU CL_SKY << 3
PAP_YEL	EQU CL_YEL << 3
PAP_WHT	EQU CL_WHT << 3

;	MACRO GETLEN txt
;.savedorg equ $
;		
;		ORG 0
;		DEFB txt
;		
;strlen equ $
;		
;		ORG .savedorg
;	ENDM

	MACRO TEXT y, x, txt
		DEFB y, x
		DEFM txt
		DEFB 0
	ENDM

	MACRO BUTTON y, x, txt
.savedorg equ $
		ORG 0
		DEFB txt
.strlen equ $
		ORG .savedorg
		; -----------

		DEFB y, x
		DEFB $10		; LT corner
		

		DUP .strlen
			DEFB $14	; horizontal line
		EDUP
		
		DEFB $11		; RT corner
		DEFB 0

		DEFB y+1, x
		DEFB $15		; left vertical line
		DEFM txt
		
		DEFB $16		; right vertical line
		DEFB 0

		DEFB y+2, x
		DEFB $12		; LB corner
		
		DUP .strlen
			DEFB $14
		EDUP
		
		DEFB $13		; RB corner
		DEFB 0
	ENDM
	
	MACRO BUTTON_GENERAL y, x, txt
.savedorg equ $
		ORG 0
		DEFB txt
.strlen equ $
		ORG .savedorg
		; -----------

		DEFB y, x
		DEFB $10		; LT corner
		
		DUP .strlen
			DEFB $14	; horizontal line
		EDUP
		
		DEFB $11		; RT corner
		DEFB 0

		DEFB y+1, x
		DEFB $15		; left vertical line

.xorg equ $
		DEFM txt
		
		org .xorg + 1
		DEFB $19
		
		org .xorg + 3

		DEFB $16		; right vertical line
		DEFB 0

		DEFB y+2, x
		DEFB $12		; LB corner
		
		DUP .strlen
			DEFB $14
		EDUP
		
		
		DEFB $13		; RB corner
		DEFB 0
	ENDM
