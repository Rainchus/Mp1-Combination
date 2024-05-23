osWritebackDCacheAll:
/* 3CCD0 800618D0 3C088000 */  lui       $t0, 0x8000
/* 3CCD4 800618D4 240A2000 */  addiu     $t2, $zero, 0x2000
/* 3CCD8 800618D8 010A4821 */  addu      $t1, $t0, $t2
/* 3CCDC 800618DC 2529FFF0 */  addiu     $t1, $t1, -0x10
L800618E0:
/* 3CCE0 800618E0 BD010000 */  cache     1, ($t0)
/* 3CCE4 800618E4 0109082B */  sltu      $at, $t0, $t1
/* 3CCE8 800618E8 1420FFFD */  bnez      $at, L800618E0
/* 3CCEC 800618EC 25080010 */   addiu    $t0, $t0, 0x10
/* 3CCF0 800618F0 03E00008 */  jr        $ra
/* 3CCF4 800618F4 00000000 */   nop

osViRepeatLine:
ADDIU          SP, SP, -0x18
SW             S0, 0x0010 (SP)
SW             RA, 0x0014 (SP)
JAL            0x80093520 //__osDisableInt
ADDU           S0, A0, R0
ANDI           S0, S0, 0x00FF
BEQZ           S0, label1
ADDU           A0, V0, R0
LUI            V1, 0x800C
LW             V1, 0x77B4 (V1)
LHU            V0, 0x0000 (V1)
J              label0
ORI            V0, V0, 0x0040
label1:
LUI            V1, 0x800C
LW             V1, 0x77B4 (V1)
LHU            V0, 0x0000 (V1)
ANDI           V0, V0, 0xFFBF
label0:
JAL            0x80093590 //__osRestoreInt
SH             V0, 0x0000 (V1)
LW             RA, 0x0014 (SP)
LW             S0, 0x0010 (SP)
JR             RA
ADDIU          SP, SP, 0x18

crash_screen_sleep: //takes arg a0, ms to sleep
ADDIU sp, sp, -0x20
ORI v0, r0, 0xB71B
MULT a0, v0
DADDU a0, r0, r0
DADDU a1, r0, r0
SW ra, 0x0018 (sp)
SW s1, 0x0014 (sp)
SW s0, 0x0010 (sp)
MFHI s0
MFLO s1
JAL osSetTime
NOP
crashScreenLoop:
JAL osGetTime
NOP
DADDU a0, v0, r0
DADDU a1, v1, r0
SLTU v0, a0, s0
BNEZ v0, crashScreenLoop
NOP
BNE s0, a0, exitCrashFunc
SLTU v0, a1, s1
BNEZ v0, crashScreenLoop
NOP
exitCrashFunc:
LW ra, 0x0018 (sp)
LW s1, 0x0014 (sp)
LW s0, 0x0010 (sp)
JR RA
ADDIU sp, sp, 0x20

//so emulator wont close the game upon infinite loop
infiniteLoop:
NOP
J infiniteLoop
NOP