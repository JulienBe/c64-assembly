BasicUpstart2(start)                // There is a second variation of the basic upstart macro that also takes care of setting up memory blocks:

* = $4000
start:
    lda #$00
    sta $d020                       // Border color             : 0
    sta $d021                       // Background color         : 0
    lda #$01
    sta $0286                       // Cursor address           : 1
    jsr $e544                       // Clear screen function
    jsr draw_text
    jmp *

msg:
    .text "              hello, world!             "

draw_text:
    ldx #$00

draw_loop:
    lda msg,x
    sta $05e0,x
    inx
    cpx #$28                        // 40 characters per line
    bne draw_loop
    rts