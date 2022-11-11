BasicUpstart2(start)                    // There is a second variation of the basic upstart macro that also takes care of setting up memory blocks:

start:  inc $d020
        inc $d021
        jmp start