.include "Labels.asm"

.orga 0x80404F3C - 0x7F200000
addiu sp, sp, -0x18
sw ra, 0x14(sp)

beqz a0, renderSettingsAndWarpStrings
nop

;intro sign replacement
lui t9, 0x8039
lhu t1, U16_INTRO_CUTSCENE_TIMER(t9)
li t2, 119
bne t1, t2, wrapTextRenderingPipeline
lb t1, U8_SIGN_REPLACEMENT_TEXT_ADVANCEMENT(t9)

bnez t1, dontSetSignReplacementTextAdv1
li t2, 1

sb t2, U8_SIGN_REPLACEMENT_TEXT_ADVANCEMENT(t9)

dontSetSignReplacementTextAdv1:
jal 0x802d7384
nop

jal 0x802DB3B8
nop

;IA16 STR
;begin display list
lw t0, 0x8033b06c ;g_display_list_head

lui t1, 0x0600
sw t1, 0(t0)

li t1, 0x02011cc8
sw t1, 4(t0)

addiu t0, t0, 8
sw t0, 0x8033b06c

;our calls
la a2, 0x80404ca5
li a0, 36
jal 0x802D77DC
li a1, 18

lui t9, 0x8039
lb t1, U8_SIGN_REPLACEMENT_TEXT_ADVANCEMENT(t9)
li t2, 1
beq t1, t2, intro1
li t2, 2
beq t1, t2, intro2
li t2, 3
beq t1, t2, intro3
li t2, 4
beq t1, t2, intro4
li t2, 5
beq t1, t2, intro5
li t2, 6
beq t1, t2, intro6
li t2, 7
beq t1, t2, intro7
li t2, 8
beq t1, t2, intro8
nop

b intro9
nop

intro1:
lui t9, 0x8039
la a2, 0x8040A000
li a0, 0x48
jal 0x802D77DC
li a1, 0x80

b endIntroDisplayList
nop

intro2:
lui t9, 0x8039
la a2, 0x8040A024
li a0, 0x88
jal 0x802D77DC
li a1, 0xc0

lui t9, 0x8039
la a2, 0x8040A02C
li a0, 0x7e
jal 0x802D77DC
li a1, 0xa0

lui t9, 0x8039
la a2, 0x80404d07
li a0, 0x6D
jal 0x802D77DC
li a1, 0x90

lui t9, 0x8039
la a2, 0x80404d19
li a0, 0x84
jal 0x802D77DC
li a1, 0x80

lui t9, 0x8039
la a2, 0x80404d22
li a0, 0x6d
jal 0x802D77DC
li a1, 0x70

lui t9, 0x8039
la a2, 0x80404d34
li a0, 0x81
jal 0x802D77DC
li a1, 0x60

b endIntroDisplayList
nop

intro3:
lui t9, 0x8039
la a2, 0x8040A024
li a0, 0x88
jal 0x802D77DC
li a1, 0xc0

lui t9, 0x8039
la a2, 0x8040A100
li a0, 0x7a
jal 0x802D77DC
li a1, 0xa0

lui t9, 0x8039
la a2, 0x8040A10C
li a0, 0x6c
jal 0x802D77DC
li a1, 0x90

lui t9, 0x8039
la a2, 0x8040A11E
li a0, 0x78
jal 0x802D77DC
li a1, 0x70

lui t9, 0x8039
la a2, 0x8040A12C
li a0, 0x82
jal 0x802D77DC
li a1, 0x60

b endIntroDisplayList
nop

intro4:
lui t9, 0x8039
la a2, 0x8040A024
li a0, 0x88
jal 0x802D77DC
li a1, 0xc0

lui t9, 0x8039
la a2, 0x8040A134
li a0, 0x20
jal 0x802D77DC
li a1, 0xa0

b endIntroDisplayList
nop

intro5:
lui t9, 0x8039
la a2, 0x8040A17D
li a0, 0x10
jal 0x802D77DC
li a1, 0x80

b endIntroDisplayList
nop

intro6:
lui t9, 0x8039
la a2, 0x8040A1E7
li a0, 0x18
jal 0x802D77DC
li a1, 0x80

b endIntroDisplayList
nop

intro7:
lui t9, 0x8039
la a2, 0x8040A24C
li a0, 0x0D
jal 0x802D77DC
li a1, 0x80

b endIntroDisplayList
nop

intro8:
lui t9, 0x8039
la a2, 0x8040A289
li a0, 0x18
jal 0x802D77DC
li a1, 0x80

b endIntroDisplayList
nop

intro9:
lui t9, 0x8039
la a2, 0x8040A2EA
li a0, 0x40
jal 0x802D77DC
li a1, 0x80

endIntroDisplayList:
;end display list
lw t0, 0x8033b06c
lui at, 0x600
sw at, 0(t0)

li t1, 0x02011d50
sw t1, 4(t0)

addiu t0, t0, 8
sw t0, 0x8033b06c

b wrapTextRenderingPipeline
nop

renderSettingsAndWarpStrings:
jal 0x802d7384
nop

lui t9, 0x8039
lb t1, U8_MENU_POSITION(t9)
bnez t1, checkSettingsOrQuickWarp
nop

;IA16 STR
;begin display list
lw t0, 0x8033b06c ;g_display_list_head

lui t1, 0x0600
sw t1, 0(t0)

li t1, 0x02011cc8
sw t1, 4(t0)

addiu t0, t0, 8
sw t0, 0x8033b06c

;our calls
la a2, 0x80404be4
li a0, 36
jal 0x802D77DC
li a1, 40

;our calls
la a2, 0x80404bed
li a0, 36
jal 0x802D77DC
li a1, 20

;StarDisplay

;our calls
la a2, 0x80404cde
li a0, 184
jal 0x802D77DC
li a1, 40

;our calls
la a2, 0x80404ceF
li a0, 184
jal 0x802D77DC
li a1, 24

;Courses 1-9
lui t9, 0x8039
sb r0, U8_FOR_LOOP_COUNTER(t9)
li t2, 226
sb t2, U8_STARDISPLAY_Y_POS(t9)

courses1To9ForLoop:
lui t9, 0x8039
lb t1, U8_FOR_LOOP_COUNTER(t9)
addiu t1, t1, 1
sb t1, U8_FOR_LOOP_COUNTER(t9)

li t2, 10
beq t1, t2, courses1To9ForLoopBreak
nop

li a2, 0x80404cae
li t6, 0x0C
sb t6, 0(a2)
sb t1, 1(a2)
li t6, 0x9e
sb t6, 2(a2)

lbu a1, U8_STARDISPLAY_Y_POS(t9)
subiu a1, a1, 16
sb a1, U8_STARDISPLAY_Y_POS(t9)

jal 0x802D77DC
li a0, 16

b courses1To9ForLoop
nop

courses1To9ForLoopBreak:
;Courses 10-15
lui t9, 0x8039
sb r0, U8_FOR_LOOP_COUNTER(t9)
li t2, 226
sb t2, U8_STARDISPLAY_Y_POS(t9)

courses10To15ForLoop:
lui t9, 0x8039
lb t1, U8_FOR_LOOP_COUNTER(t9)
addiu t1, t1, 1
sb t1, U8_FOR_LOOP_COUNTER(t9)

li t2, 4
beq t1, t2, courses10To15ForLoopBreak
nop

li a2, 0x80404cae
li t6, 0x0C
sb t6, 0(a2)
li t6, 0x01
sb t6, 1(a2)
subiu t1, t1, 1
sb t1, 2(a2)

lbu a1, U8_STARDISPLAY_Y_POS(t9)
subiu a1, a1, 16
sb a1, U8_STARDISPLAY_Y_POS(t9)

jal 0x802D77DC
li a0, 105

b courses10To15ForLoop
nop

courses10To15ForLoopBreak:
;Bowsers
lui t9, 0x8039
sb r0, U8_FOR_LOOP_COUNTER(t9)
li t2, 162
sb t2, U8_STARDISPLAY_Y_POS(t9)

bowsersForLoop:
lui t9, 0x8039
lb t1, U8_FOR_LOOP_COUNTER(t9)
addiu t1, t1, 1
sb t1, U8_FOR_LOOP_COUNTER(t9)

li t2, 3
beq t1, t2, bowsersForLoopBreak
nop

li a2, 0x80404cae
li t6, 0x9e
sb t6, 0(a2)
li t6, 0x0B
sb t6, 1(a2)
sb t1, 2(a2)

lbu a1, U8_STARDISPLAY_Y_POS(t9)
subiu a1, a1, 16
sb a1, U8_STARDISPLAY_Y_POS(t9)

jal 0x802D77DC
li a0, 105

b bowsersForLoop
nop

bowsersForLoopBreak:
;Caps
lui t9, 0x8039
sb r0, U8_FOR_LOOP_COUNTER(t9)
li t2, 226
sb t2, U8_STARDISPLAY_Y_POS(t9)

capsForLoop:
lui t9, 0x8039
lb t1, U8_FOR_LOOP_COUNTER(t9)
addiu t1, t1, 1
sb t1, U8_FOR_LOOP_COUNTER(t9)

li t2, 4
beq t1, t2, capsForLoopBreak
nop

li t2, 1
li t6, 0x16
beq t1, t2, capsDone
li t2, 2
li t6, 0x20
beq t1, t2, capsDone
nop
li t6, 0x1F

capsDone:
li a2, 0x80404cae
sb t6, 1(a2)
li t6, 0x0C
sb t6, 2(a2)
li t6, 0x9e
sb t6, 0(a2)

lbu a1, U8_STARDISPLAY_Y_POS(t9)
subiu a1, a1, 16
sb a1, U8_STARDISPLAY_Y_POS(t9)

jal 0x802D77DC
li a0, 184

b capsForLoop
nop

capsForLoopBreak:
;Secrets
lui t9, 0x8039
sb r0, U8_FOR_LOOP_COUNTER(t9)
li t2, 162
sb t2, U8_STARDISPLAY_Y_POS(t9)

secretsForLoop:
lui t9, 0x8039
lb t1, U8_FOR_LOOP_COUNTER(t9)
addiu t1, t1, 1
sb t1, U8_FOR_LOOP_COUNTER(t9)

li t2, 4
beq t1, t2, secretsForLoopBreak
nop

li t2, 1
li t6, 0x11
beq t1, t2, secretsDone
li t7, 0x1C
li t2, 2
li t6, 0x0A
beq t1, t2, secretsDone
li t7, 0x0F
li t6, 0x15
li t7, 0x15

secretsDone:
li a2, 0x80404cae
sb t6, 1(a2)
sb t7, 2(a2)
li t6, 0x9e
sb t6, 0(a2)

lbu a1, U8_STARDISPLAY_Y_POS(t9)
subiu a1, a1, 16
sb a1, U8_STARDISPLAY_Y_POS(t9)

jal 0x802D77DC
li a0, 184

b secretsForLoop
nop

secretsForLoopBreak:
;Overworlds
lui t9, 0x8039
sb r0, U8_FOR_LOOP_COUNTER(t9)
li t2, 114
sb t2, U8_STARDISPLAY_Y_POS(t9)

overworldsForLoop:
lui t9, 0x8039
lb t1, U8_FOR_LOOP_COUNTER(t9)
addiu t1, t1, 1
sb t1, U8_FOR_LOOP_COUNTER(t9)

li t2, 3
beq t1, t2, overworldsForLoopBreak
nop

li a2, 0x80404cae
li t6, 0x18
sb t6, 0(a2)
li t6, 0x20
sb t6, 1(a2)
sb t1, 2(a2)

lbu a1, U8_STARDISPLAY_Y_POS(t9)
subiu a1, a1, 16
sb a1, U8_STARDISPLAY_Y_POS(t9)

jal 0x802D77DC
li a0, 184

b overworldsForLoop
nop

overworldsForLoopBreak:
;Graveyard
la a2, 0x80404cb2
li a0, 16
jal 0x802D77DC
li a1, 66

;Normal Ending
la a2, 0x80404cbc
li a0, 100
jal 0x802D77DC
li a1, 66

;100% Ending
la a2, 0x80404cca
li a0, 184
jal 0x802D77DC
li a1, 66

lw t0, 0x8033b06c
lui t1, 0xfb00
sw t1, 0(t0)
li t1, 0x0abf16FF
sw t1, 4(t0)
addiu t0, t0, 8
sw t0, 0x8033b06c

lui t9, 0x8039
sb r0, U8_FOR_LOOP_COUNTER(t9)
sb r0, U8_STARDISPLAY_STAR_ID(t9)
li t2, 32
sh t2, U16_STARDISPLAY_X_POS(t9)
li t2, 3
sb t2, U8_STARDISPLAY_MAX_STARS(t9)
li t2, 210
sb t2, U8_STARDISPLAY_Y_POS(t9)

b starCheckingForLoop
nop

getStarSymbolsByCourse:
addiu a1, a0, 0

lui a0, 0x8033
lh a0, 0xddf4(a0)
jal 0x8027A1C8
addiu a0, a0, 0xFFFF

lui t9, 0x8039
addiu t5, t9, ARRAY64_STAR_GLYPHS_PER_COURSE
li t2, 0xFD
li t3, 0xFA 
andi t1, v0, 0x0001
beqz t1, checkStar2
sb t2, 0(t5)
sb t3, 0(t5)
checkStar2:
andi t1, v0, 0x0002
beqz t1, checkStar3
sb t2, 1(t5)
sb t3, 1(t5)
checkStar3:
andi t1, v0, 0x0004
beqz t1, checkStar4
sb t2, 2(t5)
sb t3, 2(t5)
checkStar4:
andi t1, v0, 0x0008
beqz t1, checkStar5
sb t2, 3(t5)
sb t3, 3(t5)
checkStar5:
andi t1, v0, 0x0010
beqz t1, checkStar6
sb t2, 4(t5)
sb t3, 4(t5)
checkStar6:
andi t1, v0, 0x0020
beqz t1, checkStar7
sb t2, 5(t5)
sb t3, 5(t5)
checkStar7:
andi t1, v0, 0x0040
beqz t1, renderCourseStarDisplay
sb t2, 6(t5)
sb t3, 6(t5)

b renderCourseStarDisplay
nop

starCheckingForLoop:
lui t9, 0x8039
b getStarSymbolsByCourse
lb a0, U8_FOR_LOOP_COUNTER(t9)

renderCourseStarDisplay:
lui t9, 0x8039
li a2, 0x80404caa
li t6, 0x8038f210
lb t1, U8_STARDISPLAY_STAR_ID(t9)
add t6, t6, t1
lbu t1, 0(t6)
sb t1, 0(a2)

lb t1, U8_FOR_LOOP_COUNTER(t9)
li t2, 22
bne t1, t2, normalXPosPayload
nop

lb t1, U8_STARDISPLAY_STAR_ID(t9)
li t2, 70
beqz t1, setSpecialXPos
li t3, 1
beq t1, t3, setSpecialXPos
li t2, 174

li t2, 286

setSpecialXPos:
sh t2, U16_STARDISPLAY_X_POS(t9)

normalXPosPayload:
lhu a0, U16_STARDISPLAY_X_POS(t9)

skipNormalXPosPayload:
jal 0x802D77DC
lbu a1, U8_STARDISPLAY_Y_POS(t9)

lui t9, 0x8039
lhu a0, U16_STARDISPLAY_X_POS(t9)
addiu a0, a0, 12
sh a0, U16_STARDISPLAY_X_POS(t9)

lb t1, U8_STARDISPLAY_STAR_ID(t9)
addiu t1, t1, 1
sb t1, U8_STARDISPLAY_STAR_ID(t9)
lb t2, U8_STARDISPLAY_MAX_STARS(t9)
bne t1, t2, starCheckingForLoop
nop

lb t1, U8_FOR_LOOP_COUNTER(t9)
addiu t1, t1, 1
sb t1, U8_FOR_LOOP_COUNTER(t9)

sb r0, U8_STARDISPLAY_STAR_ID(t9)

;Course 2
li t4, 1
li t2, 32
li t3, 194
li t5, 3
beq t1, t4, updateStarDisplayXYPos
li t4, 2

;Course 3
li t2, 32
subiu t3, t3, 16
li t5, 5
beq t1, t4, updateStarDisplayXYPos
li t4, 3

;Course 4
li t2, 32
subiu t3, t3, 16
li t5, 2
beq t1, t4, updateStarDisplayXYPos
li t4, 4

;Course 5
li t2, 32
subiu t3, t3, 16
li t5, 4
beq t1, t4, updateStarDisplayXYPos
li t4, 5

;Course 6
li t2, 32
subiu t3, t3, 16
li t5, 3
beq t1, t4, updateStarDisplayXYPos
li t4, 6

;Course 7
li t2, 32
subiu t3, t3, 16
li t5, 3
beq t1, t4, updateStarDisplayXYPos
li t4, 7

;Course 8
li t2, 32
subiu t3, t3, 16
li t5, 2
beq t1, t4, updateStarDisplayXYPos
li t4, 8

;Course 9
li t2, 32
subiu t3, t3, 16
li t5, 3
beq t1, t4, updateStarDisplayXYPos
li t4, 9

;Course 10
li t2, 127
li t3, 210
li t5, 3
beq t1, t4, updateStarDisplayXYPos
li t4, 10

;Course 11
li t2, 127
subiu t3, t3, 16
li t5, 5
beq t1, t4, updateStarDisplayXYPos
li t4, 11

;Course 12
li t2, 127
subiu t3, t3, 16
li t5, 3
beq t1, t4, updateStarDisplayXYPos
li t4, 12

bne t1, t4, starDisplayDontJump1
nop

lui t9, 0x8039
li t4, 15
sb t4, U8_FOR_LOOP_COUNTER(t9)
addiu t1, t4, 0

starDisplayDontJump1:
;Bowser 1
li t2, 127
subiu t3, t3, 32
li t5, 2
beq t1, t4, updateStarDisplayXYPos
li t4, 16

;Bowser 2
li t2, 127
subiu t3, t3, 16
li t5, 2
beq t1, t4, updateStarDisplayXYPos
li t4, 17

;LL
li t2, 208
li t3, 114
li t5, 2
beq t1, t4, updateStarDisplayXYPos
li t4, 18

;HS
li t2, 208
li t3, 146
li t5, 2
beq t1, t4, updateStarDisplayXYPos
li t4, 19

;MC
li t2, 208
li t3, 210
li t5, 4
beq t1, t4, updateStarDisplayXYPos
li t4, 20

;WC
li t2, 208
subiu t3, t3, 16
li t5, 2
beq t1, t4, updateStarDisplayXYPos
li t4, 21

;VC
li t2, 208
subiu t3, t3, 16
li t5, 2
beq t1, t4, updateStarDisplayXYPos
li t4, 22

;Graveyard & Endings
li t2, 208
li t3, 66
li t5, 3
beq t1, t4, updateStarDisplayXYPos
li t4, 23

;AF
li t2, 208
li t3, 130
li t5, 4
beq t1, t4, updateStarDisplayXYPos
li t4, 24

b starCheckingForLoopBreak
nop

updateStarDisplayXYPos:
sh t2, U16_STARDISPLAY_X_POS(t9)
sb t3, U8_STARDISPLAY_Y_POS(t9)
sb t5, U8_STARDISPLAY_MAX_STARS(t9)

b starCheckingForLoop
nop

starCheckingForLoopBreak:
jal 0x8027A16C

lui t9, 0x8039
li a2, 0x80404caa

li t2, 0x01000000
and t1, v0, t2

li t3, 0xFD
beqz t1, setCorrespondingStarGlyph1
nop

li t3, 0xFA

setCorrespondingStarGlyph1:
sb t3, 0(a2)

li a2, 0x80404caa
li a0, 208
jal 0x802D77DC
li a1, 98

jal 0x8027A16C

lui t9, 0x8039
li a2, 0x80404caa

li t2, 0x04000000
and t1, v0, t2

li t3, 0xFD
beqz t1, setCorrespondingStarGlyph2
nop

li t3, 0xFA

setCorrespondingStarGlyph2:
sb t3, 0(a2)

li a2, 0x80404caa
li a0, 208
jal 0x802D77DC
li a1, 82

lw t0, 0x8033b06c
lui t1, 0xfb00
sw t1, 0(t0)
li t1, 0x1272ccFF
sw t1, 4(t0)
addiu t0, t0, 8
sw t0, 0x8033b06c

;BETA STARS

;Course 2
li a1, 1
lui a0, 0x8033
lh a0, 0xddf4(a0)
jal 0x8027A1C8
addiu a0, a0, 0xFFFF

lui t9, 0x8039
li a2, 0x80404caa

andi t1, v0, 0x0040

li t3, 0xFD
beqz t1, setCorrespondingStarGlyph4
nop

li t3, 0xFA

setCorrespondingStarGlyph4:
sb t3, 0(a2)

li a2, 0x80404caa
li a0, 92
jal 0x802D77DC
li a1, 194

;Course 3
li a1, 2
lui a0, 0x8033
lh a0, 0xddf4(a0)
jal 0x8027A1C8
addiu a0, a0, 0xFFFF

lui t9, 0x8039
li a2, 0x80404caa

andi t1, v0, 0x0040

li t3, 0xFD
beqz t1, setCorrespondingStarGlyph5
nop

li t3, 0xFA

setCorrespondingStarGlyph5:
sb t3, 0(a2)

li a2, 0x80404caa
li a0, 92
jal 0x802D77DC
li a1, 178

;Course 4
li a1, 3
lui a0, 0x8033
lh a0, 0xddf4(a0)
jal 0x8027A1C8
addiu a0, a0, 0xFFFF

lui t9, 0x8039
li a2, 0x80404caa

andi t1, v0, 0x0040

li t3, 0xFD
beqz t1, setCorrespondingStarGlyph6
nop

li t3, 0xFA

setCorrespondingStarGlyph6:
sb t3, 0(a2)

li a2, 0x80404caa
li a0, 92
jal 0x802D77DC
li a1, 162

;Course 5
li a1, 4
lui a0, 0x8033
lh a0, 0xddf4(a0)
jal 0x8027A1C8
addiu a0, a0, 0xFFFF

lui t9, 0x8039
li a2, 0x80404caa

andi t1, v0, 0x0040

li t3, 0xFD
beqz t1, setCorrespondingStarGlyph7
nop

li t3, 0xFA

setCorrespondingStarGlyph7:
sb t3, 0(a2)

li a2, 0x80404caa
li a0, 92
jal 0x802D77DC
li a1, 146

;Course 7
li a1, 6
lui a0, 0x8033
lh a0, 0xddf4(a0)
jal 0x8027A1C8
addiu a0, a0, 0xFFFF

lui t9, 0x8039
li a2, 0x80404caa

andi t1, v0, 0x0040

li t3, 0xFD
beqz t1, setCorrespondingStarGlyph8
nop

li t3, 0xFA

setCorrespondingStarGlyph8:
sb t3, 0(a2)

li a2, 0x80404caa
li a0, 92
jal 0x802D77DC
li a1, 114

;Course 8
li a1, 7
lui a0, 0x8033
lh a0, 0xddf4(a0)
jal 0x8027A1C8
addiu a0, a0, 0xFFFF

lui t9, 0x8039
li a2, 0x80404caa

andi t1, v0, 0x0040

li t3, 0xFD
beqz t1, setCorrespondingStarGlyph9
nop

li t3, 0xFA

setCorrespondingStarGlyph9:
sb t3, 0(a2)

li a2, 0x80404caa
li a0, 92
jal 0x802D77DC
li a1, 98

;MC
li a1, 19
lui a0, 0x8033
lh a0, 0xddf4(a0)
jal 0x8027A1C8
addiu a0, a0, 0xFFFF

lui t9, 0x8039
li a2, 0x80404caa

andi t1, v0, 0x0040

li t3, 0xFD
beqz t1, setCorrespondingStarGlyph10
nop

li t3, 0xFA

setCorrespondingStarGlyph10:
sb t3, 0(a2)

li a2, 0x80404caa
li a0, 256
jal 0x802D77DC
li a1, 210

;WC
li a1, 20
lui a0, 0x8033
lh a0, 0xddf4(a0)
jal 0x8027A1C8
addiu a0, a0, 0xFFFF

lui t9, 0x8039
li a2, 0x80404caa

andi t1, v0, 0x0040

li t3, 0xFD
beqz t1, setCorrespondingStarGlyph11
nop

li t3, 0xFA

setCorrespondingStarGlyph11:
sb t3, 0(a2)

li a2, 0x80404caa
li a0, 256
jal 0x802D77DC
li a1, 194

;end display list
lw t0, 0x8033b06c
lui at, 0x600
sw at, 0(t0)

li t1, 0x02011d50
sw t1, 4(t0)

addiu t0, t0, 8
sw t0, 0x8033b06c

;COLORFUL STR
;begin display list
lw t0, 0x8033b06c ;g_display_list_head
lui t1, 0x0600
sw t1, 0(t0)

li t1, 0x02011b60
sw t1, 4(t0)

addiu t0, t0, 8
sw t0, 0x8033b06c

;our calls
lui t9, 0x8039
lb t1, U8_BUTTON_BOP_TIMER(t9)
li t2, 10
li a2, 183
blt t1, t2, renderRButton
nop

li a2, 185

renderRButton:
la a3, 0x80404BE0
li a0, 2
jal 0x802D7b84
li a1, 16

lui t9, 0x8039
lb t1, U8_BUTTON_BOP_TIMER(t9)
li t2, 10
li a2, 204
blt t1, t2, renderLButton
nop

li a2, 206

renderLButton:
la a3, 0x80404BE2
li a0, 2
jal 0x802D7b84
li a1, 16

;end display list
lw t0, 0x8033b06c
lui at, 0x600
sw at, 0(t0)

li t1, 0x02011bc8
sw t1, 4(t0)

addiu t0, t0, 8
sw t0, 0x8033b06c

b wrapTextRenderingPipeline
nop

checkSettingsOrQuickWarp:
li t2, 1
beq t1, t2, renderSettings
nop

;renderQuickWarp
;IA16 STR
;begin display list
lw t0, 0x8033b06c ;g_display_list_head

lui t1, 0x0600
sw t1, 0(t0)

li t1, 0x02011cc8
sw t1, 4(t0)

addiu t0, t0, 8
sw t0, 0x8033b06c

;our calls
la a2, 0x80404c4c
li a0, 16
jal 0x802D77DC
li a1, 190

la a2, 0x80404c55
li a0, 16
jal 0x802D77DC
li a1, 160

la a2, 0x80404c1c
li a0, 16
jal 0x802D77DC
li a1, 140

;ARROWS
lw t0, 0x8033b06c
lui t1, 0xfb00
sw t1, 0(t0)
li t1, 0xfcba03FF
sw t1, 4(t0)
addiu t0, t0, 8
sw t0, 0x8033b06c

la a2, 0x80404c40
li a0, 70
jal 0x802D77DC
li a1, 190

la a2, 0x80404c42
li a0, 120
jal 0x802D77DC
li a1, 190

;end display list
lw t0, 0x8033b06c
lui at, 0x600
sw at, 0(t0)

li t1, 0x02011d50
sw t1, 4(t0)

addiu t0, t0, 8
sw t0, 0x8033b06c

;COLORFUL STR
;begin display list
lw t0, 0x8033b06c ;g_display_list_head

lui t1, 0x0600
sw t1, 0(t0)

li t1, 0x02011b60
sw t1, 4(t0)

addiu t0, t0, 8
sw t0, 0x8033b06c

;our calls
la a3, 0x80404c69
li a0, 2

lui t9, 0x8039
lb t1, U8_QUICKWARP_DESTINATION(t9)
li t2, 3
blt t1, t2, renderQuickWarpText
li a1, 80
li t2, 12
blt t1, t2, renderQuickWarpText
li a1, 86
li t2, 18
blt t1, t2, renderQuickWarpText
li a1, 80
li t2, 28
blt t1, t2, renderQuickWarpText
li a1, 86

li a1, 80

renderQuickWarpText:
jal 0x802D7b84
li a2, 34

;end display list
lw t0, 0x8033b06c
lui at, 0x600
sw at, 0(t0)

li t1, 0x02011bc8
sw t1, 4(t0)

addiu t0, t0, 8
sw t0, 0x8033b06c

b renderBackText
nop

renderSettings:
;IA16 STR
;begin display list
lw t0, 0x8033b06c ;g_display_list_head

lui t1, 0x0600
sw t1, 0(t0)

li t1, 0x02011cc8
sw t1, 4(t0)

addiu t0, t0, 8
sw t0, 0x8033b06c

;our calls
la a2, 0x80404c1c
li a0, 16
jal 0x802D77DC
li a1, 130

la a2, 0x80404c00
li a0, 16
jal 0x802D77DC
li a1, 190

la a2, 0x80404c0c
li a0, 16
jal 0x802D77DC
li a1, 170

;ARROWS
lw t0, 0x8033b06c
lui t1, 0xfb00
sw t1, 0(t0)
li t1, 0xfcba03FF
sw t1, 4(t0)
addiu t0, t0, 8
sw t0, 0x8033b06c

la a2, 0x80404c40
li a0, 110
jal 0x802D77DC
li a1, 190

la a2, 0x80404c40
li a0, 110
jal 0x802D77DC
li a1, 170

la a2, 0x80404c42
li a0, 160
jal 0x802D77DC
li a1, 190

la a2, 0x80404c42
li a0, 160
jal 0x802D77DC
li a1, 170

lui t9, 0x8039
li a1, 190
lbu a1, U8_SETTINGS_CURSOR_Y_POS(t9)
la a2, 0x80404c42
jal 0x802D77DC
li a0, 6

;end display list
lw t0, 0x8033b06c
lui at, 0x600
sw at, 0(t0)

li t1, 0x02011d50
sw t1, 4(t0)

addiu t0, t0, 8
sw t0, 0x8033b06c

;COLORFUL STR
;begin display list
lw t0, 0x8033b06c ;g_display_list_head

lui t1, 0x0600
sw t1, 0(t0)

li t1, 0x02011b60
sw t1, 4(t0)

addiu t0, t0, 8
sw t0, 0x8033b06c

;our calls

li a0, 0
jal 0x80408000
li a1, 0

li a1, 125
la a3, 0x80404c44 ;on
beqz v0, renderStarRadarOffOn
nop

la a3, 0x80404c48 ;off
li a1, 121

renderStarRadarOffOn:
li a0, 2
jal 0x802D7b84
li a2, 34

li a0, 0
jal 0x80408000
li a1, 1

li a1, 125
la a3, 0x80404c44 ;on
beqz v0, renderStarSFXOffOn
nop

la a3, 0x80404c48 ;off
li a1, 121

renderStarSFXOffOn:
li a0, 2
jal 0x802D7b84
li a2, 54

;end display list
lw t0, 0x8033b06c
lui at, 0x600
sw at, 0(t0)

li t1, 0x02011bc8
sw t1, 4(t0)

addiu t0, t0, 8
sw t0, 0x8033b06c

b renderBackText
nop

renderBackText:
;IA16 STR
;begin display list
lw t0, 0x8033b06c ;g_display_list_head

lui t1, 0x0600
sw t1, 0(t0)

li t1, 0x02011cc8
sw t1, 4(t0)

addiu t0, t0, 8
sw t0, 0x8033b06c

;our calls
la a2, 0x80404bfb
li a1, 20
jal 0x802D77DC
li a0, 36

;end display list
lw t0, 0x8033b06c
lui at, 0x600
sw at, 0(t0)

li t1, 0x02011d50
sw t1, 4(t0)

addiu t0, t0, 8
sw t0, 0x8033b06c

;COLORFUL STR
;begin display list
lw t0, 0x8033b06c ;g_display_list_head

lui t1, 0x0600
sw t1, 0(t0)

li t1, 0x02011b60
sw t1, 4(t0)

addiu t0, t0, 8
sw t0, 0x8033b06c

;our calls
lui t9, 0x8039
lb t1, U8_BUTTON_BOP_TIMER(t9)
li t2, 10
li a2, 204
blt t1, t2, renderBButton
nop

li a2, 206

renderBButton:
la a3, 0x80404Bf9
li a0, 2
jal 0x802D7b84
li a1, 16

;end display list
lw t0, 0x8033b06c
lui at, 0x600
sw at, 0(t0)

li t1, 0x02011bc8
sw t1, 4(t0)

addiu t0, t0, 8
sw t0, 0x8033b06c

b wrapTextRenderingPipeline
nop

wrapTextRenderingPipeline:
lw ra, 0x14(sp)
jr ra
addiu sp, sp, 0x18