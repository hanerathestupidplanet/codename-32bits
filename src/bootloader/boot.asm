; src/boot.asm
[org 0x7c00]
kernel equ 0x1000


; alot of this is from an osdev tutorial, im
; sorry if thats like bad or something-

; from osdev wiki, thanks :3
xor ax, ax    ; make it zero
mov ds, ax   ; DS=0
mov ss, ax   ; stack starts at 0
mov sp, 0x9c00



jmp main

    xor si, si
    xor di, di

    ; read the disk to load the kernel




    ;   code segment descriptor
    ;   base: 0
    ;   limit = 0xfffff (0b11111111111111111111)
    ;   
    ;   present = 1
    ;   privilege = 00 - highest priv.
    ;   type = 1 - code = 1, data = 0
    ;
    ;   flags
    ;   type - {1, 0, 1, 0}
    ;   code, conforming, readable, accessed
    ;   other - {1, 1, 0, 0} 
    ;
    ;   data segment descriptor
    ;
    ;   present = 1
    ;   privilege = 00 - highest priv.
    ;   type = 0 - code = 1, data = 0
    ;
    ;   flags
    ;   type - {0, 0, 1, 0}
    ;   code, conforming, readable, accessed
    ;   other - {1, 1, 0, 0} 

    GDTSTART:
        null_desc: dd 0 
            dd 0
        code_desc:
            dw 0xffff  ;limit
            dw 0
            db 0
            db 0b10011010 ; pres,priv & type, flags
            db 0b11001111 ; other flags and last 4 bits of limit
            db 0
        data_desc:
            dw 0xffff  ;limit
            dw 0
            db 0
            db 0b10010010 ; pres,priv & type, flags
            db 0b11001111 ; other flags and last 4 bits of limit
            db 0
        gdt_desc:
            dw GDTEND - GDTSTART - 1 ;size
            dd GDTSTART
            CODESEG equ code_desc - GDTSTART
            DATASEG equ data_desc - GDTSTART
        GDTEND:

diskError: ; im too lazy to actually print it like a normal person FUCK you
    mov al, 'D'
    mov ah, 0x0E
    int 0x10
    mov al, 'I'
    int 0x10
    mov al, 'S'
    int 0x10
    mov al, 'K'
    int 0x10
    mov al, ' '
    int 0x10
    mov al, '1'
    int 0x10
    jmp $


bootdisk: db 0
main:
    mov [bootdisk], dl
    xor ax,ax
    mov es,ax
    mov ds, ax
    mov bp, 0x8000
    mov sp, bp

    mov bx, kernel
    mov dh, 21 ;sectors
    mov ah, 0x02
    mov al, dh
    mov ch, 0
    mov dh, 0
    mov cl, 2
    mov dl, [bootdisk]
    jc diskError
    int 0x13

    mov ah, 0
    
    mov al, 3
    
    int 0x10
    
    cli
    
    lgdt [gdt_desc]

    mov eax, cr0
    or eax, 1
    mov cr0, eax
    jmp CODESEG:start



[bits 32]

;print:
;    mov al, [msg + edi]
;    mov ah, 0x0f ; white on black
;    or al, al
;    jz return
;    mov [0xb8000 + esi], ax
;    add esi, 2
;    inc edi
;    jmp print
return:
    ret

start:
    mov ax, DATASEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000
    mov esp, ebp
    jmp kernel

    jmp $

times 510-($-$$) db 0 ; 2 bytes less now
dw 0xAA55