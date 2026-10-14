#include "./../main/stdio.h"
typedef struct{
    uint16_t low;
    uint16_t base1;
    uint8_t base2;
    uint8_t access;
    uint8_t flaglimit1;
    uint8_t base3;


} __attribute__((packed)) gdtEntry;

typedef struct{
    uint16_t limit;
    gdtEntry* gdtPtr;


} __attribute__((packed)) gdtDesc;


typedef enum{

    gdtCodeReadable          = 0x02,
    gdtDataWriteable         = 0x02,
    gdtCodeConforming        = 0x04,
    gdtdataDirNormal         = 0x00,
    gdtdataDirDown           = 0x10,
    gdtDataSeg               = 0x10,
    gdtCodeSeg               = 0x18,
    gdtDescTss               = 0x00,
    gdtRing0                 = 0x00,
    gdtRing1                 = 0x20,
    gdtRing2                 = 0x40,
    gdtRing3                 = 0x60,
    gdtPresent               = 0x80

} gdtAccess;

typedef enum{

    flag64Bit           = 0x20,
    flag32Bit           = 0x40,
    flag16Bit           = 0x00,
    flagGranularity1b   = 0x00,
    flagGranularity4k   = 0x80

} gdtFlags;

#define gdtBaseLow(a)          ((a) & 0xffffff)
#define gdtLow(a)              ((a) & 0xffff)
#define gdtBaseMid(a)          (((a) >> 16) & 0xff)
#define gdtFlagsLimitHi(a, b)  ((((a) >> 16) & 0xF) | ((b) & 0xF0))
#define gdtBaseHi(a)           (((a) >> 24) & 0xff)

#define gdtEntryM(b,l,a,f){\
    gdtLow(l),\
    gdtLow(b),\
    gdtBaseMid(b),\
    a,\
    gdtFlagsLimitHi(l,f),\
    gdtBaseHi(b),\
}

#define GDTCODESEG 0x08
#define GDTDATASEG 0x10

void gdtInit();