//src/kernel/idt.h
#include "./../main/stdio.h"
typedef struct {
   uint16_t offset_1;        // offset bits 0..15
   uint16_t selector;        // a code segment selector in GDT or LDT
   uint8_t  zero;            // unused, set to 0
   uint8_t  type_attributes; // gate type, dpl, and p fields
   uint16_t offset_2;        // offset bits 16..31
}__attribute__((packed)) idtEntry;

typedef struct {
   uint16_t limit;        
   idtEntry* pointer;
}__attribute__((packed)) idtDesc;

typedef enum{ // gate type, task/interrupt/trap gate 
              // trap gate - when exception, retry to execute inst
              // int. gate - goes to next instruction
    gateTask            =   0x5,
    gate16bint          =   0x6,
    gate16btrap         =   0x7,
    gate32bint          =   0xe,
    gate32btrap         =   0xf,

    flagR0              = (0<<5),
    flagR1              = (1<<5),
    flagR2              = (2<<5),
    flagR3              = (3<<5),

    flagPresent         =   0x80
} idtFlags;

void idtsetGate(int interrupt, void* func, uint16_t segmentDesc, uint8_t flags);
void idtEnableGate(int interrupt);
void idtDisableGate(int interrupt);
void idtInit();