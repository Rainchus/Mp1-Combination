#include "mp1.h"

#define ICACHELINE 0x20
#define DCACHELINE 0x10

void System_InvalICache(void* addr, u32 size)
{
    u32 iaddr;
    u32 iend;
    u32 count;

    iaddr = (u32)addr & ~(ICACHELINE - 1);
    iend = (u32)addr + size;
    count = (iend - iaddr + (ICACHELINE - 1)) / ICACHELINE;

    for (u32 i = 0; i < count; ++i)
    {
        __asm__ __volatile__("cache 0x10, 0(%0)" :: "r"(iaddr));
        iaddr += ICACHELINE;
    }
}

void System_InvalDCache(void* addr, u32 size)
{
    u32 daddr;
    u32 dend;
    u32 count;

    daddr = (u32)addr & ~(DCACHELINE - 1);
    dend = (u32)addr + size;
    count = (dend - daddr + (DCACHELINE - 1)) / DCACHELINE;

    for (u32 i = 0; i < count; ++i)
    {
        __asm__ __volatile__("cache 0x11, 0(%0)" :: "r"(daddr));
        daddr += DCACHELINE;
    }
}