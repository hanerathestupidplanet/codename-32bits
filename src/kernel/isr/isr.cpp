#include "isr.h"
#include "./../idr/idt.h"
#include "./../gdt/gdt.h"
#include "./../main/stdio.h"

void extern "C" __attribute__((cdecl)) isrHandler(reg* registers){

    printf(tostring(regs->interrupt));
    putc('\n',0);
}