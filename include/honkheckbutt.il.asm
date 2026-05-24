;===========================================================================
; CityXen Apple IIe Library - Honk Heck Butt Controller Mapping
;
; Maps the Honk Heck Butt custom controller buttons to Apple IIe joystick
; inputs.  The HHB controller connects via the game port (PDL0/PDL1/PB0-2).
;
; Button layout (same physical buttons as C64 port):
;   BUTTON_RED    - analog joystick pushed left (X < threshold)
;   BUTTON_GREEN  - analog joystick pushed right (X > threshold)
;   BUTTON_YELLOW - analog joystick pushed up (Y < threshold)
;   BUTTON_BLUE   - analog joystick pushed down (Y > threshold)
;   BUTTON_WHITE  - Open Apple (PB0)
;
; Joystick mapping (mirror C64 port naming):
;   J1_B_RED    = j1_left
;   J1_B_GREEN  = j1_right
;   J1_B_YELLOW = j1_up
;   J1_B_BLUE   = j1_down
;   J1_B_WHITE  = j1_button   (Open Apple)
;===========================================================================

; Button constants (bit positions in j1_state)
BUTTON_RED    = JOY_LEFT
BUTTON_GREEN  = JOY_RIGHT
BUTTON_YELLOW = JOY_UP
BUTTON_BLUE   = JOY_DOWN
BUTTON_WHITE  = JOY_FIRE

; Aliases mapping HHB names to joystick direction variables
J1_B_RED    = j1_left
J1_B_GREEN  = j1_right
J1_B_YELLOW = j1_up
J1_B_BLUE   = j1_down
J1_B_WHITE  = j1_button

; Action masks for game logic (same semantics as C64 port)
MASK_POW      = BUTTON_WHITE
MASK_MISS     = BUTTON_RED
MASK_GAME_OVER = BUTTON_WHITE | BUTTON_RED

;===========================================================================
