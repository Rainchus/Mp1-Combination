#include "mp1.h"

#define FOREIGN_DRAM 0x80000400
#define FOREIGN_OFF 0x400
#define FOREIGN_SIZE 0xBE940 //TODO: what should this actually be?
#define FOREIGN_CART 0x2001000
#define NORETURN    __attribute__((noreturn))

void cBootFunction(void) {
    crash_screen_init();
}

NORETURN ComboSwitchGame(void) {
    System_DisableInterrupts();
    WaitForSubSystems();
    ComboGameSwitch2(); //doesn't return
}

NORETURN ComboSwitchGame3(void) {
    System_InvalDCache((void*)FOREIGN_DRAM, FOREIGN_SIZE);
    System_InvalICache((void*)FOREIGN_DRAM, FOREIGN_SIZE);
    comboDma_NoCacheInval((void*)FOREIGN_OFF, FOREIGN_CART, FOREIGN_SIZE);
    System_InvalDCache((void*)FOREIGN_DRAM, FOREIGN_SIZE);
    System_InvalICache((void*)FOREIGN_DRAM, FOREIGN_SIZE);
    ComboGameSwitch4(FOREIGN_DRAM);
}