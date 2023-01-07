.var char_in=$ffe4
.var screen_mem=$0400
        BasicUpstart2(start)    // 10 sys$0810
        *= $2000 "Program"
start:
char_loop:
        jsr char_in
        cmp #$00
        beq char_loop
        sec             // set carry
        sbc #$40        // subsctract from acc
        ldx #$00
screen_loop:        
        adc #1
        sta screen_mem, x
        sta screen_mem+$ff, x
        sta screen_mem+$ff+$ff, x
        sta screen_mem+$2e8, x
        inx
        bne screen_loop
        jmp char_loop
