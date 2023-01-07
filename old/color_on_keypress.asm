.import source "vic2consts.asm"

.label color = $0002
.label two = $00FB

BasicUpstart2(start)    // 10 sys$0810
    * = $1000 "Main Program"
start:
    lda #BLACK
    sta BORDER_COLOR
    sta SCREEN_COLOR
loop:    
    Joystick JOYSTICK_2 : on_left : on_right : on_up : on_down : on_fire
    jmp loop

on_fire:
    jmp loop
on_up:
    jmp loop
on_down:
    jmp loop
on_left:
    inc color
    jmp color_update
    
on_right:
    lsr color
    jmp color_update

color_update:
    sta color
    sta BORDER_COLOR
    sta SCREEN_COLOR
    jmp loop

.pseudocommand Joystick port : left : right : up : down : fire {
    clc
    lda port
    lsr
    bcc up
    lsr
    bcc down
    lsr
    bcc left
    lsr
    bcc right
    lsr
    bcc fire
}
