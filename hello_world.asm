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
    .byte $00                       // End of string

draw_text:
    ldx #00                         // character: position within the line

draw_loop:
    lda msg,x
    beq draw_loop_end               // if character is zero, we're done
    sta $0400,x                     // $0400 is the start of the screen memory
    inx
    bne draw_loop
draw_loop_end:
    rts