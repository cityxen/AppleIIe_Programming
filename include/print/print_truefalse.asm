;===========================================================================
; CityXen Apple IIe Library - Print TRUE / FALSE
;===========================================================================

str_true:  !byte "TRUE",  0+$80, 0
str_false: !byte "FALSE", 0+$80, 0

; Apple IIe: strings must have high bit set for Monitor COUT.
; Inline the bytes with $80 offset:
; (ACME !text with a modifier, or list them manually)

str_true_a2:
    !byte $D4,$D2,$D5,$C5,$00      ; TRUE (T=$54|$80, R=$52|$80, U=$55|$80, E=$45|$80)
str_false_a2:
    !byte $C6,$C1,$CC,$D3,$C5,$00  ; FALSE

;---------------------------------------------------------------------------
; il_print_true - Print "TRUE" at current cursor
;---------------------------------------------------------------------------
il_print_true:
    lda #<str_true_a2
    sta ZP_PTR0
    lda #>str_true_a2
    sta ZP_PTR0 + 1
    jsr il_print
    rts

;---------------------------------------------------------------------------
; il_print_false - Print "FALSE" at current cursor
;---------------------------------------------------------------------------
il_print_false:
    lda #<str_false_a2
    sta ZP_PTR0
    lda #>str_false_a2
    sta ZP_PTR0 + 1
    jsr il_print
    rts

;---------------------------------------------------------------------------
; il_print_truefalse - Print "TRUE" if A != 0, "FALSE" if A == 0
;---------------------------------------------------------------------------
il_print_truefalse:
    beq il_print_false
    jmp il_print_true

;===========================================================================
