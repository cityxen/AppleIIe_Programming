;===========================================================================
; CityXen Apple IIe Library - Speaker Music Configuration
;
; The Apple IIe speaker is a 1-bit device driven by toggling $C030.
; Tones are produced by toggling at the target frequency.
; Music playback requires a tight timing loop or IRQ-based driver.
;
; This module provides constants and minimal stubs.
; A full speaker music driver is beyond this stub — link an external
; driver (e.g. Mockingboard support or a pure-speaker PWM engine).
;===========================================================================

; Set CONFIG_MUSIC = 1 to enable music integration in timers.il.asm
CONFIG_MUSIC = 0

; Note frequency table index constants (for a future music engine)
NOTE_C3  = 0
NOTE_D3  = 1
NOTE_E3  = 2
NOTE_F3  = 3
NOTE_G3  = 4
NOTE_A3  = 5
NOTE_B3  = 6
NOTE_C4  = 7   ; middle C
NOTE_D4  = 8
NOTE_E4  = 9
NOTE_F4  = 10
NOTE_G4  = 11
NOTE_A4  = 12
NOTE_B4  = 13
NOTE_C5  = 14
NOTE_REST = 15

;---------------------------------------------------------------------------
; il_music_init - Initialize music engine (stub)
;   Replace body with actual speaker music driver init.
;---------------------------------------------------------------------------
il_music_init:
    rts

;---------------------------------------------------------------------------
; il_music_play_note - Queue a note (stub)
;   A = note index
;---------------------------------------------------------------------------
il_music_play_note:
    rts

;---------------------------------------------------------------------------
; il_music_stop - Stop music playback (stub)
;---------------------------------------------------------------------------
il_music_stop:
    rts

;===========================================================================
