BasicUpstart2(start)                // There is a second variation of the basic upstart macro that also takes care of setting up memory blocks:

* = $4000
start:
    lda #$00
    sta $d020                       // Border color             : 0
    sta $d021                       // Background color         : 0

    lda #$01
    sta $0286                       // Cursor address           : 1
    jsr $e544                       // Clear screen function

    lda #$00                        // lsb of $0400
    sta $fa                         //  00 to 0-page fa
    lda #$04                        // msb of $0400
    sta $fb                         //  04 to 0-page fb

    lda #$00
    ldy #$00

    jsr write_loop
    jmp *

msg:
    .text "              hello, world!             "
    .byte $00                       // End of string

write_loop:
    sta ($fa),y                     // Start of loop 1 to increment / points to LSB
    iny                             // increment LSB
    bne write_loop                  // if y != 0 goto clrloop
    ldx $fb                         // load x (MSB) with value from zero page location $fb
                                    // loop 2 for MSB
    inx                             // increment x (MSB)
    stx $fb                         // store x (MSB) in zero page location $fb
    cpx #$08                        // if x != 8
    bne write_loop                  // goto clrloop
    rts

/**
 * DRAW ROUTINE
 */
draw_text:
    ldx #00                         // character: position within the line
draw_loop:
    lda msg,x
    beq draw_loop_end               // if character is zero, we're done
    sta $0400,x                     // $0400 is the start of the screen memory. So store at $0400+x what is in the accumulator
    inx
    bne draw_loop
draw_loop_end:
    rts