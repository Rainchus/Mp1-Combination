DisplacedBootCode:
JAL cBootFunction
NOP

LUI at, 0x800E
SW s1, 0x8910 (at)
JAL mallocPerm
ADDIU a0, r0, 0x0010
ADDU s0, v0, r0
ADDU a0, s1, r0
ADDU a1, s0, r0
JAL 0x80061FE8
ADDIU a2, r0, 0x0010
J 0x8005B708
NOP

LoadOverlayHook:
ADDIU sp, sp, -0x20 //restore from hook
SW ra, 0x0018 (sp) //restore from hook
ORI t0, r0, 0x0081 //title screen overlay ID
BNE t0, a0, normalExit
NOP
//not normal exit, swap game
JAL ComboSwitchGame
NOP
normalExit:
J 0x800175C8
NOP

osEPiRawStartDmaHook:
ADDIU sp, sp, -0x28
SW s0, 0x0010 (sp)

LI t0, 0x2000000
ADDU a2, a2, t0

J 0x80072958
NOP

HuStartDmaHook:
ADDIU sp, sp, -0x18
SW ra, 0x0010 (sp)
LI t0, 0x2000000
ADDU a3, a3, t0
J 0x8004DA00
NOP
