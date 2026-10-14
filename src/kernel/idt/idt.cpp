//src/kernel/idt.cpp

#include "./../main/stdio.h"
#include "idt.h"
#include "./../binary.h"




idtEntry IDT[256];

idtDesc IDTDESCRIPTOR = {sizeof(IDT) - 1, IDT};

extern "C" void __attribute__((cdecl)) idtLoad(idtDesc* desc);
void idtsetGate(int interrupt, void* func, uint16_t segmentDesc, uint8_t flags){

    IDT[interrupt].offset_1 = ((uint32_t )func) & 0xffff;
    IDT[interrupt].selector = segmentDesc;
    IDT[interrupt].zero = 0;
    IDT[interrupt].type_attributes = flags;
    IDT[interrupt].offset_2 = ((uint32_t )func >> 16) & 0xffff;
    

}
void idtEnableGate(int interrupt){

    flagSet(IDT[interrupt].type_attributes, flagPresent);

}
void idtDisableGate(int interrupt){

    flagUnset(IDT[interrupt].type_attributes, flagPresent);

}

void idtInit(){

    idtLoad(&IDTDESCRIPTOR);

}