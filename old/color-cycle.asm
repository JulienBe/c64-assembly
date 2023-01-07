        *= $0801 "Basic Upstart"
        BasicUpstart(start)    // 10 sys$0810

        *= $0810 "Program"
start:
        lda $d012
        cmp #$00
        bne start
        inx
        cpx	#$40
        bne start
        inc $d020
        dec $d021
        jmp start
