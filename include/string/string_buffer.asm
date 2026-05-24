;===========================================================================
; CityXen Apple IIe Library - String Buffer
;
; General-purpose 256-byte string working buffer.
;===========================================================================

string_buffer: !fill 256, 0        ; 256-byte scratch buffer

;---------------------------------------------------------------------------
; ClearStringBuffer - Zero the string buffer
;---------------------------------------------------------------------------
!macro ClearStringBuffer {
    ldx #0
    txa
.csb_loop:
    sta string_buffer, x
    inx
    bne .csb_loop
}

;===========================================================================
