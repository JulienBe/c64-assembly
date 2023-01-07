.import source "vic2consts.asm"

.label color = $0002
.label m_just_pressed = $00FB
.label temp = $00FC
.label port = JOYSTICK_2

.const KOALA_TEMPLATE = "C64FILE, Bitmap=$0000, ScreenRam=$1f40, ColorRam=$2328, BackgroundColor = $2710"
.var picture = LoadBinary("picture.kla", KOALA_TEMPLATE)

BasicUpstart2(start)    // 10 sys$0810
    * = $1000 "Main Program"
start:
    lda #BLACK    
    sta color
    sta BORDER_COLOR
    sta SCREEN_COLOR
    sta m_just_pressed
    lda #$38
    sta $d018
    lda #$d8
    sta $d016
    lda #$3b
    sta $d011
    load_image(picture)

control:
    clc
    lda port
    and #%00011111
    cmp m_just_pressed
    bne inc_border
    jmp control

inc_border:
    sta m_just_pressed
    inc BORDER_COLOR
    jmp control

.macro load_image(pic) {
        lda #0
        sta $d020
        lda #pic.getBackgroundColor()
        sta $d021
        ldx #0
    !loop:
        .for (var i=0; i<4; i++) {
            lda colorRam+i*$100,x
            sta $d800+i*$100,x
        }
        inx
        bne !loop-
        jmp *

    *=$0c00;            .fill pic.getScreenRamSize(), pic.getScreenRam(i)
    *=$1c00; colorRam:  .fill pic.getColorRamSize(), pic.getColorRam(i)
    *=$2000;            .fill pic.getBitmapSize(), pic.getBitmap(i)
}
