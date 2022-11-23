BasicUpstart2(start)                // There is a second variation of the basic upstart macro that also takes care of setting up memory blocks:

.label screen_pointer_lo = $fa
.label screen_pointer_hi = $fb
.label char_lo = $fc
.label char_hi = $fd

* = $4000

start:
    lda #$00;    sta $d020;    sta $d021    // Border & Background  color         : 0
    lda #$01;    sta $0286                  // Cursor address           : 1
    jsr $e544                               // Clear screen function

    jsr write_start
    jmp *

msg:
    .text "123456789     hello, world!             "
    .byte $00                       // End of string


write_start:
    lda #$00;    sta screen_pointer_lo           //  00 to 0-page fa
    lda #$04;    sta screen_pointer_hi           //  04 to 0-page fb
    ldy #$00
write_loop:
    lda msg,y;   sta (screen_pointer_lo),y       // load msg + y in a; put char to screen pointer low       // Start of loop 1 to increment / points to LSB
    iny;         bne write_loop                  // increment LSB; if y != 0 goto clrloop
    ldx screen_pointer_hi                        // load x (MSB) with value from zero page location $fb
                                                 // loop 2 for MSB
    inx;         stx screen_pointer_hi           // store x (MSB) in zero page location $fb
    cpx #$08;    bne write_loop                  // if x != 8; goto clrloop
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