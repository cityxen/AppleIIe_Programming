;===========================================================================
; CityXen Apple IIe Library - Print Subroutines
;
; All strings passed to these routines must be stored with the high bit
; SET ($80+ASCII) for normal video, per Monitor ROM convention.
; Use CHR_NORMAL ($80) offset when defining string data.
;
; Cursor positioning uses Monitor ROM variables CURSOR_CH ($24),
; CURSOR_CV ($25), and BASCALC ($FBC1) to update the base address.
;===========================================================================

;---------------------------------------------------------------------------
; il_print - Print null-terminated string pointed to by ZP_PTR0
;   Characters must have high bit set (Monitor COUT convention).
;   Advances cursor naturally via COUT.
;---------------------------------------------------------------------------
il_print:
    ldy #0
.ip_loop:
    lda (ZP_PTR0), y
    beq .ip_done
    jsr COUT
    iny
    bne .ip_loop
    inc ZP_PTR0 + 1
    bra .ip_loop
.ip_done:
    rts

;---------------------------------------------------------------------------
; il_poke_string - Write ZP_PTR0 string directly to screen RAM at cursor
;   Bypasses Monitor ROM; faster than COUT for bulk writes.
;   Characters stored as-is (caller must include CHR_NORMAL if needed).
;   Destination is CURSOR_BAS ($28/$29) + CURSOR_CH ($24).
;---------------------------------------------------------------------------
il_poke_string:
    lda #CHR_NORMAL
    sta ZP_TMP0         ; default video attribute
il_poke_string_color:
    ; ZP_TMP0 = character video attribute (CHR_NORMAL, CHR_INVERSE, etc.)
    ldx CURSOR_CH
    ldy #0
.ips_loop:
    lda (ZP_PTR0), y
    beq .ips_done
    and #$7F            ; strip any existing high bits
    ora ZP_TMP0         ; apply video attribute
    sta (CURSOR_BAS), x
    inx
    iny
    bne .ips_loop
.ips_done:
    rts

;---------------------------------------------------------------------------
; Print - Convenience macro: print string at address, using Monitor COUT
; Usage: +Print string_addr
;---------------------------------------------------------------------------
!macro Print string_addr {
    lda #<string_addr
    sta ZP_PTR0
    lda #>string_addr
    sta ZP_PTR0 + 1
    jsr il_print
}

;---------------------------------------------------------------------------
; PrintXY - Print string at absolute (col, row) position
; Usage: +PrintXY col, row, string_addr
;---------------------------------------------------------------------------
!macro PrintXY col, row, string_addr {
    lda #col
    sta CURSOR_CH
    lda #row
    sta CURSOR_CV
    jsr BASCALC
    +Print string_addr
}

;---------------------------------------------------------------------------
; PrintChr - Print a single character (high bit set)
; Usage: +PrintChr char_val
;---------------------------------------------------------------------------
!macro PrintChr char_val {
    lda #char_val | CHR_NORMAL
    jsr COUT
}

;---------------------------------------------------------------------------
; PrintLF - Print a carriage return (advance to next line)
;---------------------------------------------------------------------------
!macro PrintLF {
    jsr CROUT
}

;---------------------------------------------------------------------------
; PrintClear - Clear screen and home cursor
;---------------------------------------------------------------------------
!macro PrintClear {
    jsr HOME
}

;---------------------------------------------------------------------------
; PrintHome - Home cursor without clearing screen
;---------------------------------------------------------------------------
!macro PrintHome {
    stz CURSOR_CH
    stz CURSOR_CV
    jsr BASCALC
}

;---------------------------------------------------------------------------
; PrintColor - Apple IIe text mode has no per-character color registers.
;   Text color is controlled by character encoding (normal/inverse/flash)
;   and the monochrome vs. composite color output setting.
;   This macro sets the "video attribute" used by subsequent PokeString calls.
; Usage: +PrintColor attr  (CHR_NORMAL, CHR_INVERSE, or CHR_FLASH)
;---------------------------------------------------------------------------
!macro PrintColor attr {
    lda #attr
    sta ZP_TMP0
}

;---------------------------------------------------------------------------
; PrintReverseOn / PrintReverseOff - Toggle inverse video for COUT output
;   Uses Monitor ROM inverse flag at $32 (INVFLG): $FF = inverse, $3F = normal
;---------------------------------------------------------------------------
INVFLG = $32

!macro PrintReverseOn {
    lda #$FF
    sta INVFLG
}

!macro PrintReverseOff {
    lda #$3F
    sta INVFLG
}

;---------------------------------------------------------------------------
; PrintUpperCase / PrintLowerCase - Toggle case translation
;   Monitor ROM LCASE flag at $9E: bit 5 set = lower case enabled
;---------------------------------------------------------------------------
LCASE_FLAG = $9E

!macro PrintUpperCase {
    lda LCASE_FLAG
    and #%11011111
    sta LCASE_FLAG
}

!macro PrintLowerCase {
    lda LCASE_FLAG
    ora #%00100000
    sta LCASE_FLAG
}

;===========================================================================
