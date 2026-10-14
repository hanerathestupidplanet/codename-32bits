; alot of this is from an osdev tutorial, im
; sorry if thats like bad or something-
; src/kernelEntry.asm


section .text
    [bits 32]
    [extern main]
    call main
    jmp $