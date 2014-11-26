;------------------------------------------------------------------------
;-  Written by: Neviksti
;-     There are many times that one just needs to write a quick
;-     program to test this or that.  This is the perfect skeleton
;-     code for that.
;- 
;-     For an example, this code prints "Hello world!!" on the screen,
;-     shows some print functions, and tests the emulator's use of the
;-     decimal flag.
;-
;-     If you use my code, please share your creations with me
;-     as I am always curious :)
;------------------------------------------------------------------------

;=== Include MemoryMap, VectorTable, HeaderInfo ===
.INCLUDE "Hello.inc"

;=== Include Library Routines & Macros ===
.INCLUDE "InitSNES.asm"
.INCLUDE "LoadGraphics.asm"
.INCLUDE "2Input.asm"
.INCLUDE "Strings.asm"
.INCLUDE "QuickSetup.asm"

;=== Global Variables ===

.ENUM $80
	var1	db
	var2	db
.ENDE

;==============================================================================
; main
;==============================================================================

.BANK 0 SLOT 0
.ORG 0
.SECTION "MainCode"

Main:
	InitializeSNES	

	jsr QuickSetup	; set VRAM, the video mode, background and character pointers, 
				; and turn on the screen

	jsr JoyInit		;setup joypads and enable NMI

	PrintString "\n Hello World!!"
	PrintString "\n\n"
	
	lda #125
	sta var1
	PrintNum var1
	PrintString " = $"
	PrintHexNum var1

	;do some math with the decimal flag set
	PrintString "\n\n\nDecimal flag set: $09+$08 = $"
	sep #$08	
	lda #$09
	clc
	adc #$08
	sta var1	
	rep #$08
	PrintHexNum var1

	;do some math with the decimal flag clear
	PrintString "\nDecimal flag clear: 9+8 = "
	lda #9
	clc
	adc #8
	sta var2	
	PrintNum var2


forever:
	wai	;wait for next frame

	;do whatever you feel like here	

	;let's print the current frame number
	SetCursorPos 20, 10
	ldy #FrameNum
	PrintString "Frame num = %d    "

	jmp forever

.ENDS

