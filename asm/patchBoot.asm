//ROM 0x15070
.headersize 0x7FFFF400
.org 0x8005B6E4
LI a0, 0x2000000 //ROM addr to read from
LI a1, START //RAM addr to write to
LI a2, END - START //size to DMA
JAL dmaCopy2
NOP
J DisplacedBootCode
NOP