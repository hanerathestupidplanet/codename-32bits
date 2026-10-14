; src/kernel/gdt/gdt.asm
[bits 32]
global gdtLoad

gdtLoad:

    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    lgdt [eax]

    mov eax, [ebp + 12]
    push eax
    push .reloadCodeSeg
    retf
.reloadCodeSeg:


    mov ax, [ebp + 16]
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax


    
    mov esp, ebp
    pop ebp
    ret