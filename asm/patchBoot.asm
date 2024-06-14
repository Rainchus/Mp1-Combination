.headersize 0x7FFFF400 //ran once on boot
.org 0x80000400
    //clear bss
    LUI t0, 0x800D
    ADDIU t0, t0, 0xCE50
    LUI t1, 0x0003
    ADDIU t1, t1, 0x9790
    bss_clear_loop:
    SD r0, 0x0000 (t0)
    ADDI t1, t1, 0xFFF8
    BNEZ t1, bss_clear_loop
    ADDI t0, t0, 0x0008

    //dma our custom code to expansion pak ram
    LUI sp, 0x800F
    ADDIU sp, sp, 0x2A70
    ADDU a0, r0, r0
    LI a1, 0x1CED500
    //these ram symbols are defined in main.asm
    LI a2, PAYLOAD_START_RAM
    LI a3, PAYLOAD_END_RAM - PAYLOAD_START_RAM
    JAL osPiRawStartDma
    NOP

//fallthrough to normal function after game entry


.org 0x800175C0 //LoadOverlay patch
J LoadOverlayHook
NOP

.headersize 0x7DFFF400 //ROM Addr of combination rom, 0x3EFDB00
//.org 0x8004D9F8
//J HuStartDmaHook
//NOP

.org 0x8000C2C0 //patch mp3 save check
NOP

.org 0x80072950
J osEPiRawStartDmaHook
NOP

.org 0x80000400
//mp3 boot patches
    //LUI t0, 0x800B
    //ADDIU t0, t0, 0x8AF0
    //LUI t1, 0x0003
    //ADDIU t1, t1, 0xE080
    //mp3_bss_clear_loop:
    //SD r0, 0x0000 (t0)
    //ADDI t1, t1, 0xFFF8
    //BNEZ t1, mp3_bss_clear_loop
    //ADDI t0, t0, 0x0008

    //LUI sp, 0x800D
    //ADDIU sp, sp, 0x300
    //ADDU a0, r0, r0
    //LI a1, 0x3EFDB00
    ////these ram symbols are defined in main.asm
    //LI a2, 0x80500000
    //LI a3, 0x80510000 - 0x80500000
    //JAL osPiRawStartDmaMp3
    //NOP

//fallthrough to normal function after game entry