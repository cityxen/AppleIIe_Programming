;===========================================================================
; CityXen Apple IIe - Base Project Template
; Assemble with ACME: acme -f plain -o main.bin main.asm
;===========================================================================

!cpu 65c02
* = $0803               ; typical load address for ProDOS binary

!source "../include/CityXenLib.asm"

; ---- Entry Point ---------------------------------------------------------
main:
    +ClearScreen
    ; TODO: your code here
    rts

; ---- Library Code (link once per binary) ---------------------------------
!source "../include/CityXenLibCode.asm"
