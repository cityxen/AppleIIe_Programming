;===========================================================================
; CityXen Apple IIe Library - Main Include Hub
;
; !source this file once per project to pull in all definitions and macros.
; Then !source CityXenLibCode.asm at the LINK point (once, in a code segment)
; to emit the subroutine implementations.
;
; Usage:
;   !source "../include/CityXenLib.asm"
;   ; ... your code using macros and constants ...
;   +CityXenUpstart my_entry
;   ; at the end of your code segment:
;   !source "../include/CityXenLibCode.asm"
;===========================================================================

!source "Constants.asm"
!source "Macros.asm"
!source "DrawAppleScreen.asm"
;!source "Music.asm"             ; Uncomment to include speaker music system

;===========================================================================
