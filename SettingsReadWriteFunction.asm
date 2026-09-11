.orga 0x80408000 - 0x7F200000 ;get settings
addiu sp, sp, -0x18
sw ra, 0x14(sp)

;File detection
lui t0, 0x8033
lh t2, 0xddf4(t0) ;read file
li t1, 1
beq t1, t2, fileA
nop
li t1, 2
beq t1, t2, fileB
nop
li t1, 3
beq t1, t2, fileC
nop

;fileD
la t5, 0x80207850

b checkA0
nop

fileA:
la t5, 0x80207700
b checkA0
nop

fileB:
la t5, 0x80207770
b checkA0
nop

fileC:
la t5, 0x802077E0

checkA0:
lui t9, 0x8039
beqz a0, check
nop

;write
beqz a1, writeStarRadar
nop

sb a2, 0x32(t5)

b wrapFileCheck
nop

writeStarRadar:
sb a2, 0x31(t5)

b wrapFileCheck
nop

check:
beqz a1, checkStarRadar
lb v0, 0x32(t5)

b wrapFileCheck
nop

checkStarRadar:
lb v0, 0x31(t5)

b wrapFileCheck
nop

wrapFileCheck:
lw ra, 0x14(sp)
jr ra
addiu sp, sp, 0x18