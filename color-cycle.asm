	*=$0801
loop:
	lda $d012
	cmp #$00
	bne loop
	inx
	cpx	#$40
	bne loop
	inc $d020
	dec $d021
	jmp loop	