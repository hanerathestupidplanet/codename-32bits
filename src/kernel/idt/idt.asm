; scr/kernel/idt.asm
[bits 32]
global idtLoad
idtLoad:
    push ebp
    mov ebp, esp
    mov eax, [ebp + 8]
    lidt [eax]
    mov esp, ebp
    pop ebp
    ret