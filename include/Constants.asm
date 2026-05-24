;===========================================================================
; CityXen Apple IIe Library - Constants
; Apple IIe / 65C02 Hardware Constants and Memory Map
;===========================================================================

;---------------------------------------------------------------------------
; Safe Zero-Page Memory Locations
; Avoid: $00-$05 (ProDOS/Monitor), $FA-$FF (Monitor scratch)
; Generally safe: $06-$09, $1A-$1F, $50-$5F, $E0-$EF
;---------------------------------------------------------------------------

; General-purpose pointer pairs
ZP_PTR0       = $06     ; 2 bytes: general pointer 0
ZP_PTR1       = $08     ; 2 bytes: general pointer 1
ZP_PTR2       = $1A     ; 2 bytes: general pointer 2
ZP_PTR3       = $1C     ; 2 bytes: general pointer 3
ZP_TMP0       = $1E     ; 1 byte:  temporary
ZP_TMP1       = $1F     ; 1 byte:  temporary

; Extended zero-page block (safe for most ProDOS user programs)
ZP_A          = $50     ; 2 bytes
ZP_B          = $52     ; 2 bytes
ZP_C          = $54     ; 2 bytes
ZP_D          = $56     ; 2 bytes
ZP_E          = $58     ; 2 bytes
ZP_F          = $5A     ; 2 bytes
ZP_G          = $5C     ; 2 bytes
ZP_H          = $5E     ; 2 bytes

; IRQ-safe zero-page block (avoid touching from main loop when IRQ active)
ZP_IRQ_A      = $E0     ; 2 bytes
ZP_IRQ_B      = $E2     ; 2 bytes
ZP_IRQ_C      = $E4     ; 2 bytes
ZP_IRQ_D      = $E6     ; 2 bytes

;---------------------------------------------------------------------------
; Cursor / Screen State (Monitor ROM uses these directly)
;---------------------------------------------------------------------------
CURSOR_CH     = $24     ; Current horizontal position (column, 0-39)
CURSOR_CV     = $25     ; Current vertical position (row, 0-23)
CURSOR_BAS    = $28     ; Current row base address (word, $28 lo / $29 hi)

;---------------------------------------------------------------------------
; Text Screen Memory
;---------------------------------------------------------------------------
SCREEN_PAGE1  = $0400   ; Text page 1 base (40x24 = 960 bytes used)
SCREEN_PAGE2  = $0800   ; Text page 2 base
SCREEN_COLS   = 40
SCREEN_ROWS   = 24

; Text screen row base addresses (non-linear interleaved layout)
; Row  0: $0400   Row  8: $0428   Row 16: $0450
; Row  1: $0480   Row  9: $04A8   Row 17: $04D0
; Row  2: $0500   Row 10: $0528   Row 18: $0550
; Row  3: $0580   Row 11: $05A8   Row 19: $05D0
; Row  4: $0600   Row 12: $0628   Row 20: $0650
; Row  5: $0680   Row 13: $06A8   Row 21: $06D0
; Row  6: $0700   Row 14: $0728   Row 22: $0750
; Row  7: $0780   Row 15: $07A8   Row 23: $07D0

;---------------------------------------------------------------------------
; Hi-Res Graphics Memory
;---------------------------------------------------------------------------
HIRES_PAGE1   = $2000   ; Hi-res page 1 (280x192, ~8KB)
HIRES_PAGE2   = $4000   ; Hi-res page 2 (280x192, ~8KB)
HIRES_COLS    = 280
HIRES_ROWS    = 192

; Monitor ROM hi-res state
HCOLOR_REG    = $1C     ; Current HCOLOR (0-7)
HPOSN_LO      = $1D     ; Current hi-res X position (lo byte)
HPOSN_HI      = $1E     ; Current hi-res X position (hi byte, 0 or 1)
VPOSN         = $1F     ; Current hi-res Y position

;---------------------------------------------------------------------------
; Lo-Res Graphics Memory (shares text page addresses)
;---------------------------------------------------------------------------
LORES_PAGE1   = $0400   ; Lo-res page 1 (40x48 color blocks)
LORES_PAGE2   = $0800   ; Lo-res page 2

;---------------------------------------------------------------------------
; Soft Switches ($C000-$CFFF I/O region)
;---------------------------------------------------------------------------

; Keyboard
KBD           = $C000   ; Read: last key (bit 7=strobe, bits 0-6=ASCII key)
KBD_STROBE    = $C010   ; Read or write: clear keyboard strobe

; Mode read switches (bit 7 = state)
RDTEXT        = $C01A   ; Read: bit 7=1 → text mode active
RDMIXED       = $C01B   ; Read: bit 7=1 → mixed mode active
RDPAGE2       = $C01C   ; Read: bit 7=1 → page 2 selected
RDHIRES       = $C01D   ; Read: bit 7=1 → hi-res mode active

; Display mode switches (any read/write toggles)
SW_GRAPHICS   = $C050   ; Enable graphics (lo-res default)
SW_TEXT       = $C051   ; Enable text mode
SW_FULLSCR    = $C052   ; Full-screen graphics (no text rows)
SW_MIXED      = $C053   ; Mixed graphics + 4 text rows at bottom
SW_PAGE1      = $C054   ; Select display page 1
SW_PAGE2      = $C055   ; Select display page 2
SW_LORES      = $C056   ; Lo-res graphics
SW_HIRES      = $C057   ; Hi-res graphics

; Audio
SPEAKER       = $C030   ; Toggle speaker (any access clicks the speaker)
CASSETTE_OUT  = $C020   ; Toggle cassette output

; Annunciator outputs (game port auxiliary)
AN0_OFF       = $C058
AN0_ON        = $C059
AN1_OFF       = $C05A
AN1_ON        = $C05B
AN2_OFF       = $C05C
AN2_ON        = $C05D
AN3_OFF       = $C05E
AN3_ON        = $C05F

; Pushbuttons / Apple keys (bit 7 = pressed)
PB0           = $C061   ; Open Apple key / joystick button 0
PB1           = $C062   ; Closed Apple key / joystick button 1
PB2           = $C063   ; Joystick button 2 (if present)

; Paddle / Joystick analog (read while bit 7 high = comparator charging)
PDL0          = $C064   ; Paddle 0 / Joystick 1 X axis
PDL1          = $C065   ; Paddle 1 / Joystick 1 Y axis
PDL2          = $C066   ; Paddle 2 / Joystick 2 X axis
PDL3          = $C067   ; Paddle 3 / Joystick 2 Y axis
PTRIG         = $C070   ; Paddle trigger: resets comparator (start timing)

; 80-Column Card Soft Switches
COL80_OFF     = $C00C
COL80_ON      = $C00D
ALTCHR_OFF    = $C00E
ALTCHR_ON     = $C00F

;---------------------------------------------------------------------------
; Language Card / Extended RAM Switches
;---------------------------------------------------------------------------
LCBANK2       = $C080   ; Read LC bank 2, write disabled
LCROMREAD     = $C081   ; Read ROM, write LC bank 2 (2 accesses needed)
LC_OFF        = $C082   ; Read ROM, write disabled
LCBANK1       = $C083   ; Read/write LC bank 1
; Alternate (even address = single access, odd = double access needed)
LCBANK2B      = $C084
LCROMREADB    = $C085
LC_OFFB       = $C086
LCBANK1B      = $C087

;---------------------------------------------------------------------------
; Monitor ROM Subroutines
;---------------------------------------------------------------------------

; Output
COUT          = $FDED   ; Print char in A (high bit set) to current cursor
COUT1         = $FDF0   ; Print char in A (no special char handling)
CROUT         = $FD8E   ; Print carriage return (advances line, scrolls)
PRBYTE        = $FDDA   ; Print A as two ASCII hex digits
PRHEX         = $FDE3   ; Print low nibble of A as one hex digit

; Input
RDKEY         = $FD0C   ; Read keypress into A, waits, clears strobe (high bit set)
KEYIN         = $FD1B   ; Alternate key input entry point

; Cursor / Screen
HOME          = $FC58   ; Clear screen and home cursor (text page 1)
VTAB          = $FC22   ; Move cursor to row in CV ($25), update BAS
BASCALC       = $FBC1   ; Calculate screen row base: A=row → $28/$29 = base

; Timing
WAIT          = $FCA8   ; Delay: approx 26.5 * A * A / 2 microseconds
BELL          = $FF3A   ; Ring bell

; Hi-Res
HCLR          = $F3F6   ; Clear hi-res page 1 to black
HPLOT0        = $F457   ; Plot point at HPOSN/VPOSN in HCOLOR
HLIN          = $F53A   ; Draw hi-res horizontal line
HVLIN         = $F5CB   ; Draw hi-res vertical line

; Lo-Res
PLOT          = $F800   ; Plot lo-res block: Y=row, X=col, A=color
HLINE         = $F819   ; Draw lo-res horizontal line

; Utility
SETPWRC       = $FB2F   ; Set power-on byte (Applesoft detect)

;---------------------------------------------------------------------------
; ProDOS Machine Language Interface (MLI)
;---------------------------------------------------------------------------
PRODOS_MLI    = $BF00   ; MLI call entry point: JSR PRODOS_MLI / !byte cmd / !word param_ptr

; MLI Command Codes
MLI_QUIT      = $65
MLI_READ_BLK  = $80
MLI_WRITE_BLK = $81
MLI_GET_TIME  = $82
MLI_CREATE    = $C0
MLI_DESTROY   = $C1
MLI_RENAME    = $C2
MLI_SET_INFO  = $C3
MLI_GET_INFO  = $C4
MLI_ONLINE    = $C5
MLI_SET_PFX   = $C6
MLI_GET_PFX   = $C7
MLI_OPEN      = $C8
MLI_NEWLINE   = $C9
MLI_READ      = $CA
MLI_WRITE     = $CB
MLI_CLOSE     = $CC
MLI_FLUSH     = $CD
MLI_SET_MARK  = $CE
MLI_GET_MARK  = $CF
MLI_SET_EOF   = $D0
MLI_GET_EOF   = $D1

; ProDOS Global Page (system variables)
PRODOS_DATELO = $BF90
PRODOS_DATEHI = $BF91
PRODOS_TIMELO = $BF92
PRODOS_TIMEHI = $BF93

; ProDOS File Types
FTYPE_TXT     = $04
FTYPE_BIN     = $06
FTYPE_SYS     = $FF

; ProDOS Access Flags
ACCESS_READ   = $01
ACCESS_WRITE  = $02
ACCESS_RDWR   = $03

; ProDOS Error Codes
ERR_NONE      = $00
ERR_BADCALL   = $01
ERR_BADPCOUNT = $04
ERR_BADPATH   = $40
ERR_NODEV     = $28
ERR_EOF       = $4C
ERR_NOROOM    = $48

;---------------------------------------------------------------------------
; Keyboard Key Constants (ASCII, high bit clear, as returned by RDKEY - 1)
;---------------------------------------------------------------------------
KEY_RETURN    = $0D
KEY_BACKSPACE = $08     ; Left arrow / backspace
KEY_RIGHT     = $15     ; Right arrow (Control-U)
KEY_UP        = $0B     ; Up arrow (Control-K)
KEY_DOWN      = $0A     ; Down arrow (line feed)
KEY_DELETE    = $7F     ; Delete / Rubout
KEY_SPACE     = $20
KEY_ESCAPE    = $1B
KEY_CTRL_C    = $03
; Open Apple / Closed Apple read via PB0/PB1 soft switches (not ASCII)

;---------------------------------------------------------------------------
; Joystick Direction Bit Flags (returned by input routines)
;---------------------------------------------------------------------------
JOY_UP        = %00000001
JOY_DOWN      = %00000010
JOY_LEFT      = %00000100
JOY_RIGHT     = %00001000
JOY_FIRE      = %00010000   ; Open Apple button (PB0)
JOY_FIRE2     = %00100000   ; Closed Apple button (PB1)

JOY_THRESHOLD = 48          ; Units from center (0-127 scale each side)
JOY_CENTER    = 128         ; Nominal center value

;---------------------------------------------------------------------------
; Lo-Res Color Constants (nibble pairs; both nibbles same for solid block)
;---------------------------------------------------------------------------
BLACK         = $00
MAGENTA       = $11
DARK_BLUE     = $22
PURPLE        = $33
DARK_GREEN    = $44
GREY1         = $55
MEDIUM_BLUE   = $66
LIGHT_BLUE    = $77
BROWN         = $88
ORANGE        = $99
GREY2         = $AA
PINK          = $BB
GREEN         = $CC
YELLOW        = $DD
AQUA          = $EE
WHITE         = $FF

;---------------------------------------------------------------------------
; Hi-Res HCOLOR Values (0-7 for Monitor ROM HPLOT calls)
;---------------------------------------------------------------------------
HCLR_BLACK    = 0
HCLR_GREEN    = 1
HCLR_VIOLET   = 2
HCLR_WHITE    = 3
HCLR_BLACK2   = 4
HCLR_ORANGE   = 5
HCLR_BLUE     = 6
HCLR_WHITE2   = 7

;---------------------------------------------------------------------------
; Apple IIe Text Character Encoding
; Screen RAM stores: $00-$3F = inverse, $40-$7F = flash, $80-$FF = normal
;---------------------------------------------------------------------------
CHR_INVERSE   = $00     ; Add to ASCII code for inverse video
CHR_FLASH     = $40     ; Add to ASCII code for flashing
CHR_NORMAL    = $80     ; Add to ASCII code for normal video (most common)

;---------------------------------------------------------------------------
; IRQ Vector (Apple IIe)
;---------------------------------------------------------------------------
IRQ_VECTOR_LO = $03FE
IRQ_VECTOR_HI = $03FF

;===========================================================================
