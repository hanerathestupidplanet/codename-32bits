#include "./../main/stdio.h"
#include "gdt.h"


gdtEntry GDT[] = {
    gdtEntryM(0,0,0,0), // null
    gdtEntryM(0,0xfffff,
        gdtPresent | gdtRing0 | gdtCodeSeg | gdtCodeReadable,
        flag32Bit | flagGranularity4k
    ), // code

    gdtEntryM(0,0xfffff,
        gdtPresent | gdtRing0 | gdtDataSeg | gdtDataWriteable,
        flag32Bit | flagGranularity4k
    ), // data

};

gdtDesc gdtDescriptor = {sizeof(GDT) - 1, GDT};
extern "C" void __attribute__((cdecl)) gdtLoad(gdtDesc* desc, uint16_t CodeSeg, uint16_t DataSeg);
void gdtInit(){

    gdtLoad(&gdtDescriptor, GDTCODESEG, GDTDATASEG);

}