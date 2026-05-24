;===========================================================================
; CityXen Apple IIe Library - Music / Speaker Sound
;
; The Apple IIe has a single 1-bit speaker driven by accessing $C030.
; Each access toggles the speaker cone; rapid toggling produces tones.
; Frequency is controlled by the delay between toggles.
;
; This system uses IRQ-driven music playback via ProDOS interrupt manager
; or a custom IRQ handler. See music.il.asm for implementation.
;===========================================================================

!source "music.il.asm"

;---------------------------------------------------------------------------
; InitializeMusic - Set up the speaker music IRQ handler
;   Install the music routine into the ProDOS interrupt manager and
;   configure the timing constants for the desired tempo.
;
; Usage: +InitializeMusic
;---------------------------------------------------------------------------
!macro InitializeMusic {
    jsr il_music_init
}

;---------------------------------------------------------------------------
; PlayNote - Queue a note for the music engine
; Usage: +PlayNote note_id
;---------------------------------------------------------------------------
!macro PlayNote note_id {
    lda #note_id
    jsr il_music_play_note
}

;---------------------------------------------------------------------------
; StopMusic - Silence the speaker and stop music playback
;---------------------------------------------------------------------------
!macro StopMusic {
    jsr il_music_stop
}

;===========================================================================
