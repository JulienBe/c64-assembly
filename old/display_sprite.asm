.import source "vic2consts.asm"

    BasicUpstart2(start)    // 10 sys$0810
    *=$1000 "Program"
start:
    lda #$C8
    sta SPRITE_POINTER_0
    lda #black
    sta SPRITE_MULTICOLOR_3_0
    lda #44
    sta SPRITE_0_X
    lda #120
    sta SPRITE_0_Y
    lda #%00000001
    sta SPRITE_ENABLE
    lda #grey
    sta BORDER_COLOR
    sta SCREEN_COLOR
    rts

*=$3200
// sprite 0 / singlecolor / color: $0f
sprite_0:
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $3c,$10,$00,$7e,$18,$00,$7a,$0c
.byte $00,$3f,$16,$00,$7f,$22,$00,$fc
.byte $40,$00,$fe,$80,$00,$fe,$00,$00
.byte $ff,$00,$00,$ff,$00,$00,$fe,$00
.byte $00,$52,$00,$00,$52,$00,$00,$52
.byte $00,$00,$51,$00,$00,$7f,$00,$0f
