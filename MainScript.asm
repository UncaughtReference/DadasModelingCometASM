.include "Labels.asm"

.orga 0x80409000 - 0x7F200000
addiu sp, sp, -0x18
sw ra, 0x14(sp)

bnez a0, pauseHandling
nop

lui t9, 0x8039
sb r0, U8_MENU_POSITION(t9)
sb r0, U8_SETTINGS_POSITION(t9)
li t1, 190
sb t1, U8_SETTINGS_CURSOR_Y_POS(t9)

lb t1, U8_BUTTON_BOP_TIMER(t9)
addiu t1, t1, 1
sb t1, U8_BUTTON_BOP_TIMER(t9)
li t2, 20
bne t1, t2, dontResetBopTimer
nop

sb r0, U8_BUTTON_BOP_TIMER(t9)

dontResetBopTimer:
lb t1, U8_QUICKWARP_FLAG(t9)
beqz t1, wrapQuickWarp
nop

sb r0, U8_QUICKWARP_FLAG(t9)
lb t1, U8_QUICKWARP_DESTINATION(t9)
li a0, 16
li a1, 1
beqz t1, quickWarp
li t2, 1

li a0, 6
beq t1, t2, quickWarp
addiu t2, t2, 1

li a0, 26
beq t1, t2, quickWarp
addiu t2, t2, 1

li a0, 9
beq t1, t2, quickWarp
li t2, 4

li a0, 24
beq t1, t2, quickWarp
li t2, 5

li a0, 12
beq t1, t2, quickWarp
li t2, 6

li a0, 5
beq t1, t2, quickWarp
addiu t2, t2, 1

li a0, 4
beq t1, t2, quickWarp
addiu t2, t2, 1

li a0, 7
beq t1, t2, quickWarp
addiu t2, t2, 1

li a0, 22
beq t1, t2, quickWarp
addiu t2, t2, 1

li a0, 8
beq t1, t2, quickWarp
addiu t2, t2, 1

li a0, 23
beq t1, t2, quickWarp
addiu t2, t2, 1

li a0, 10
beq t1, t2, quickWarp
addiu t2, t2, 1

li a0, 11
beq t1, t2, quickWarp
addiu t2, t2, 1

li a0, 36
beq t1, t2, quickWarp
addiu t2, t2, 1

li a0, 13
beq t1, t2, quickWarp
addiu t2, t2, 1

li a0, 14
beq t1, t2, quickWarp
addiu t2, t2, 1

li a0, 15
beq t1, t2, quickWarp
addiu t2, t2, 1

li a0, 17
beq t1, t2, quickWarp
addiu t2, t2, 1

li a0, 19
beq t1, t2, quickWarp
addiu t2, t2, 1

li a0, 28
beq t1, t2, quickWarp
addiu t2, t2, 1

li a0, 29
beq t1, t2, quickWarp
addiu t2, t2, 1

li a0, 18
beq t1, t2, quickWarp
addiu t2, t2, 1

li a0, 27
beq t1, t2, quickWarp
addiu t2, t2, 1

li a0, 20
beq t1, t2, quickWarp
addiu t2, t2, 1

li a0, 21
beq t1, t2, quickWarp
addiu t2, t2, 1

li a0, 31
li a1, 3
beq t1, t2, quickWarp
addiu t2, t2, 1

li a0, 31
li a1, 2
beq t1, t2, quickWarp
addiu t2, t2, 1

li a0, 31
li a1, 1
beq t1, t2, quickWarp
addiu t2, t2, 1

quickWarp:
lui t0, 0x8034
lui t9, 0x8039
lb t1, 0xb249(t0)
bne t1, a0, actuallyQuickWarp
sb r0, U8_QUICKWARP_SAME_LEVEL_FLAG(t9)

li t1, 1
sb t1, U8_QUICKWARP_SAME_LEVEL_FLAG(t9)

actuallyQuickWarp:
jal 0x8024A700	
li a2, 10

lui t9, 0x8039
lb t1, U8_QUICKWARP_SAME_LEVEL_FLAG(t9)
beqz t1, wrapQuickWarp
nop

lui t0, 0x8034
addiu t1, r0, 0x0880
sh t1, 0xB21E(t0)
addiu t1, r0, 0x0000
sh t1, 0xB262(t0)
sh t1, 0xB218(t0)
addiu t1, r0, 0x0002
sb t1, 0xB248(t0)
addiu t1, r0, 0x0101
sh t1, 0xC6D4(t0)
lui t0, 0x8036
addiu t1, r0, 0x0005
sh t1, 0x1414(t0)
addiu t1, r0, 0x0001
sw t1, 0x77AC(t0)
li t0, 0x8033B170
addiu t1, r0, 0x0008
sb t1, 0xB3(t0)

wrapQuickWarp:
lui t9, 0x8039
lhu t1, U16_INTRO_CUTSCENE_TIMER(t9)
bnez t1, introCutsceneLoop
nop

jal 0x8027a16c
nop
andi t1, v0, 0x1
bnez t1, wrapIntroCutscene
nop

lui t9, 0x8039
li t1, 1
sh t1, U16_INTRO_CUTSCENE_TIMER(t9)

introCutsceneLoop:
lb t2, U8_SIGN_REPLACEMENT_TEXT_ADVANCEMENT(t9)
li t3, 10
beq t2, t3, skipCheck
nop
bnez t2, checkAPress
nop

skipCheck:
addiu t1, t1, 1
sh t1, U16_INTRO_CUTSCENE_TIMER(t9)
li t2, 120
beq t2, t1, restoreIntroCutscene
li t2, 121
beq t1, t2, restoreIntroCutsceneNextFrame
nop

b introCutscenePayload
nop

checkAPress:
lui t0, 0x8034
lh t1, 0xafa2(t0)
andi t1, t1, 0x8000
beq t1, r0, introCutscenePayload
nop

lui t9, 0x8039
lb t1, U8_SIGN_REPLACEMENT_TEXT_ADVANCEMENT(t9)
addiu t1, t1, 1
sb t1, U8_SIGN_REPLACEMENT_TEXT_ADVANCEMENT(t9)

li.u a0, 0x70130081
jal 0x802CA190
li.l a0, 0x70130081

introCutscenePayload:
la t0, 0x8033b170
li at, 0xFFFE
lw t3, 0x88(t0)
lh t1, 0x2(t3)
and t2, t1, at
sh t2, 0x2(t3)

la t1, 0x0000130A
lui t0, 0x8034
sw t1, 0xb17c(t0)

li t1, -3732
li t2, 4500
li t3, -7180
mtc1 t1, f1
mtc1 t2, f2
mtc1 t3, f3
cvt.s.w f1, f1
cvt.s.w f2, f2
cvt.s.w f3, f3
swc1 f1, 0xb1ac(t0)
swc1 f2, 0xb1b0(t0)
swc1 f3, 0xb1b4(t0)

lui t9, 0x8039
lb t1, U8_SIGN_REPLACEMENT_TEXT_ADVANCEMENT(t9)
bnez t1, wrapIntroCutscene
nop

lbu a0, U8_INTRO_CUTSCENE_DMC_TEXT_Y_POS(t9)
li a1, 140
jal 0x8028956C ;s16 approach_s16_symmetric(s16 value, s16 target, s16 increment);
li a2, 10

addiu a1, v0, 0
lui t9, 0x8039
sb v0, U8_INTRO_CUTSCENE_DMC_TEXT_Y_POS(t9)

la a2, 0x80404c6d ;pointer to TIME text
li a0, 40 ;x
jal 0x802D6554 ;void print_text_centered(s32 x, s32 y, const char *str)
nop

lui t9, 0x8039
lhu t1, U16_INTRO_CUTSCENE_TIMER(t9)
li t2, 30
blt t1, t2, wrapIntroCutscene
nop

lui t9, 0x8039
lbu a0, U8_INTRO_CUTSCENE_BONNIE_TEXT_Y_POS(t9)
li a1, 120
jal 0x8028956C ;s16 approach_s16_symmetric(s16 value, s16 target, s16 increment);
li a2, 10

addiu a1, v0, 0
lui t9, 0x8039
sb v0, U8_INTRO_CUTSCENE_BONNIE_TEXT_Y_POS(t9)

la a2, 0x80404c82 ;pointer to TIME text
li a0, 70 ;x
jal 0x802D6554 ;void print_text_centered(s32 x, s32 y, const char *str)
nop

lui t9, 0x8039
lbu a0, U8_INTRO_CUTSCENE_DADA_TEXT_Y_POS(t9)
li a1, 90
jal 0x8028956C ;s16 approach_s16_symmetric(s16 value, s16 target, s16 increment);
li a2, 10

addiu a1, v0, 0
lui t9, 0x8039
sb v0, U8_INTRO_CUTSCENE_DADA_TEXT_Y_POS(t9)

la a2, 0x80404c91 ;pointer to TIME text
li a0, 40 ;x
jal 0x802D6554 ;void print_text_centered(s32 x, s32 y, const char *str)
nop

b wrapIntroCutscene
nop

restoreIntroCutscene:
la a0, 0x13002F74
jal 0x8029F95C
nop

lui t0, 0x8034
li t1, -5712
li t2, -85
li t3, -7377
mtc1 t1, f1
mtc1 t2, f2
mtc1 t3, f3
cvt.s.w f1, f1
cvt.s.w f2, f2
cvt.s.w f3, f3
swc1 f1, 0xb1ac(t0)
swc1 f2, 0xb1b0(t0)
swc1 f3, 0xb1b4(t0)

la a0, 0x8033B204
jal 0x80286F68 ;void reset_camera(struct Camera *c);
nop

b wrapIntroCutscene
nop

restoreIntroCutsceneNextFrame:
sh r0, U16_INTRO_CUTSCENE_TIMER(t9)
sb r0, U8_SIGN_REPLACEMENT_TEXT_ADVANCEMENT(t9)

la t1, 0x0C400201
lui t0, 0x8034
sw t1, 0xb17c(t0)

la t0, 0x8033b170
lw t3, 0x88(t0)
li t2, 0x21
sh t2, 0x2(t3)

jal 0x8027A0A8
li a0, 0x1

wrapIntroCutscene:
li a0, 0
jal 0x80408000
li a1, 0

bnez v0, wrapStarRadar
nop

li.u a0, 0x13003E3C
jal 0x8029F95C
li.l a0, 0x13003E3C

beqz v0, wrapStarRadar
nop

lw t1, 0x94(v0)
bnez t1, wrapStarRadar
nop

addu a0, r0, v0
lui t9, 0x8034
lw a1, 0xB1F8(t9)

jal 0x8029E2F8
nop
	
cvt.w.s f2, f0
mfc1 a3, f2
srl a3, a3, 9

lui t9, 0x8039
lb t1, U8_SIGN_REPLACEMENT_TEXT_ADVANCEMENT(t9)
li a1, 20
beqz t1, renderStarRadar
nop

li a1, 40

renderStarRadar:
li a0, 36
lui a2, 0x8034
jal 0x802D62D8         
addiu a2, a2, 0x8388

lui t0, 0x802D
la t1, 0x2D000000
sw t1, 0xb250(t0)

lui t9, 0x8039
lb t1, U8_SIGN_REPLACEMENT_TEXT_ADVANCEMENT(t9)
li a1, 20
beqz t1, renderStarIcon
nop

li a1, 40

renderStarIcon:
la a2, 0x802cb250 ;pointer to TIME text
jal 0x802D6554 ;void print_text_centered(s32 x, s32 y, const char *str)
li a0, 20

wrapStarRadar:
lui t9, 0x8039
lb t1, U8_SIGN_REPLACEMENT_TEXT_ADVANCEMENT(t9)
beqz t1, wrapSignReplacement
nop

lui t0, 0x802D
la t1, 0x41000000
sw t1, 0xb250(t0)

lui t9, 0x8039
lb t1, U8_BUTTON_BOP_TIMER(t9)
li t2, 10
li a1, 20
blt t1, t2, renderAButton
nop

li a1, 18

renderAButton:
la a2, 0x802cb250 ;pointer to TIME text
jal 0x802D6554 ;void print_text_centered(s32 x, s32 y, const char *str)
li a0, 20

wrapSignReplacement:
lui t0, 0x8034
lh t1, 0xb21a(t0)
li t2, 70
blt t1, t2, wrap
nop

li t1, 0x0066
sh t1, 0x8007EC38
li t1, 0x0700
sh t1, 0x8007EC3A
li t1, 0x00FF
sh t1, 0x8007EC40
li t1, 0x1E00
sh t1, 0x8007EC42
li t1, 0x0066
sh t1, 0x8007EC3C 
li t1, 0x0700
sh t1, 0x8007EC3E
li t1, 0x00FF
sh t1, 0x8007EC44
li t1, 0x1e00
sh t1, 0x8007EC46

li t1, 0x0000
sh t1, 0x8007EC20
li t1, 0x7f00
sh t1, 0x8007EC22
li t1, 0x33FF
sh t1, 0x8007EC28
li t1, 0x4100
sh t1, 0x8007EC2A
li t1, 0x0000
sh t1, 0x8007EC24
li t1, 0x7f00
sh t1, 0x8007EC26
li t1, 0x33ff
sh t1, 0x8007EC2C
li t1, 0x4100
sh t1, 0x8007EC2E

b wrap
nop

pauseHandling:
lui t9, 0x8039
lb t1, U8_BUTTON_BOP_TIMER(t9)
addiu t1, t1, 1
sb t1, U8_BUTTON_BOP_TIMER(t9)
li t2, 20
bne t1, t2, dontResetBopTimer2
nop

sb r0, U8_BUTTON_BOP_TIMER(t9)

dontResetBopTimer2:
lb t1, U8_MENU_POSITION(t9)
beqz t1, checkMenuPresses
li t2, 1
beq t1, t2, checkSettingsPresses
nop

;checkQuickWarpPresses:
lui t0, 0x8034
lh t1, 0xafa2(t0)
andi t1, t1, 0x8000
bnez t1, APressed
lh t1, 0xafa2(t0)
andi t1, t1, 0x0002
bnez t1, CLeftPressed
lh t1, 0xafa2(t0)
andi t1, t1, 0x0001
bnez t1, CRightPressed
nop

b checkMenuPresses
nop

APressed:
li t1, 1
sb t1, U8_QUICKWARP_FLAG(t9)

b checkMenuPresses
nop

CLeftPressed:
lui t9, 0x8039
lb t1, U8_QUICKWARP_DESTINATION(t9)
beqz t1, checkMenuPresses
subiu t1, t1, 1
li t2, 17
bne t1, t2, dontSkipQuickWarp2
nop

li t1, 14

dontSkipQuickWarp2:
sb t1, U8_QUICKWARP_DESTINATION(t9)

b updateQuickWarpText
nop

CRightPressed:
lui t9, 0x8039
lb t1, U8_QUICKWARP_DESTINATION(t9)
li t2, 28
beq t1, t2, checkMenuPresses
addiu t1, t1, 1
li t2, 15
bne t1, t2, dontSkipQuickWarp1
nop

li t1, 18

dontSkipQuickWarp1:
sb t1, U8_QUICKWARP_DESTINATION(t9)

updateQuickWarpText:
la t3, 0x80404c69

li t4, 3
blt t1, t4, quickWarpOverworlds
li t4, 12
blt t1, t4, quickWarpCourses1To9
li t4, 18
blt t1, t4, quickWarpCourses10to15
li t4, 20
blt t1, t4, quickWarpBowsers
li t4, 23
blt t1, t4, quickWarpCaps
li t4, 26
blt t1, t4, quickWarpSecrets
nop

;quickWarpEndingsAndGraveyard
li t2, 26
li t6, 0x10 
li t7, 0x22
beq t1, t2, quickWarpWriteEndings
li t8, 0xFF

li t2, 27
li t6, 0x17
li t7, 0xe
beq t1, t2, quickWarpWriteEndings
li t8, 0xFF

li t6, 0x1
li t7, 0x19
li t8, 0xe

sb t6, 0(t3)
sb t7, 1(t3)
sb t8, 2(t3)

b playSound
nop

quickWarpWriteEndings:
sb t6, 0(t3)
sb t7, 1(t3)
li t8, 0xFF
sb t8, 2(t3)

b playSound
nop

quickWarpOverworlds:
li t5, 0x18
sb t5, 0(t3)
li t5, 0x20
sb t5, 1(t3)
addiu t1, t1, 1
sb t1, 2(t3)

b playSound
nop

quickWarpCourses1To9:
li t5, 0xc
sb t5, 0(t3)
subiu t1, t1, 2
sb t1, 1(t3)
li t5, 0xFF
sb t5, 2(t3)

b playSound
nop

quickWarpCourses10to15:
li t5, 0xc
sb t5, 0(t3)
li t5, 0x1
sb t5, 1(t3)
subiu t1, t1, 12
sb t1, 2(t3)

b playSound
nop

quickWarpBowsers:
li t5, 0xb
sb t5, 0(t3)
subiu t1, t1, 17
sb t1, 1(t3)
li t5, 0xFF
sb t5, 2(t3)

b playSound
nop

quickWarpCaps:
li t2, 20
beq t1, t2, quickWarpWriteCaps
li t6, 0x16
li t2, 21
beq t1, t2, quickWarpWriteCaps
li t6, 0x20

li t6, 0x12

quickWarpWriteCaps:
sb t6, 0(t3)
li t5, 0xc
sb t5, 1(t3)
li t5, 0xFF
sb t5, 2(t3)

b playSound
nop

quickWarpSecrets:
li t2, 23
li t6, 0x11
beq t1, t2, quickWarpWriteSecrets
li t7, 0x1c

li t2, 24
li t6, 0xa
beq t1, t2, quickWarpWriteSecrets
li t7, 0xf

li t6, 0x15
li t7, 0x15

quickWarpWriteSecrets:
sb t6, 0(t3)
sb t7, 1(t3)
li t5, 0xFF
sb t5, 2(t3)

b playSound
nop

playSound:
li.u a0, 0x70080081
jal 0x802CA190
li.l a0, 0x70080081

b checkMenuPresses
nop

checkSettingsPresses:
lui t0, 0x8034
lh t1, 0xafa2(t0)
andi t1, t1, 0x0004
bnez t1, CDownPressed
lh t1, 0xafa2(t0)
andi t1, t1, 0x0008
bnez t1, CUpPressed
lh t1, 0xafa2(t0)
andi t1, t1, 0x0002
bnez t1, changeSetting
lh t1, 0xafa2(t0)
andi t1, t1, 0x0001
bnez t1, changeSetting
nop

b calculateSettingsCursorYPos
nop

CDownPressed:
lui t9, 0x8039
lb t1, U8_SETTINGS_POSITION(t9)
bnez t1, calculateSettingsCursorYPos
li t1, 1
sb t1, U8_SETTINGS_POSITION(t9)

li.u a0, 0x7000F881
jal 0x802CA190
li.l a0, 0x7000F881

b calculateSettingsCursorYPos
nop

CUpPressed:
lui t9, 0x8039
lb t1, U8_SETTINGS_POSITION(t9)
beqz t1, calculateSettingsCursorYPos
nop
sb r0, U8_SETTINGS_POSITION(t9)

li.u a0, 0x7000F881
jal 0x802CA190
li.l a0, 0x7000F881

b calculateSettingsCursorYPos
nop

changeSetting:
li.u a0, 0x70080081
jal 0x802CA190
li.l a0, 0x70080081

lui t9, 0x8039
lb t1, U8_SETTINGS_POSITION(t9)
beqz t1, switchStarRadarSetting
nop

;switchStarSFXSetting:
li a0, 0
jal 0x80408000
li a1, 1
bnez v0, clearStarSFXFlag
nop

li a0, 1
li a1, 1
jal 0x80408000
li a2, 1

;jal 0x8027A0A8
;li a0, 0x4

b calculateSettingsCursorYPos
nop

clearStarSFXFlag:
li a0, 1
li a1, 1
jal 0x80408000
li a2, 0

;jal 0x8027A0F4
;li a0, 0x4

b calculateSettingsCursorYPos
nop

switchStarRadarSetting:
li a0, 0
jal 0x80408000
li a1, 0
bnez v0, clearStarRadarFlag
nop

li a0, 1
li a1, 0
jal 0x80408000
li a2, 1

;jal 0x8027A0A8
;li a0, 0x2

b calculateSettingsCursorYPos
nop

clearStarRadarFlag:
li a0, 1
li a1, 0
jal 0x80408000
li a2, 0

;jal 0x8027A0F4
;li a0, 0x2

b calculateSettingsCursorYPos
nop

calculateSettingsCursorYPos:
lui t9, 0x8039
lb t1, U8_SETTINGS_POSITION(t9)
li a1, 190
beqz t1, setSettingsCursorYPos
nop

li a1, 170

setSettingsCursorYPos:
lbu a0, U8_SETTINGS_CURSOR_Y_POS(t9)
jal 0x8028956C ;s16 approach_s16_symmetric(s16 value, s16 target, s16 increment);
li a2, 2

lui t9, 0x8039
sb v0, U8_SETTINGS_CURSOR_Y_POS(t9)

b checkMenuPresses
nop

checkMenuPresses:
lui t9, 0x8039
lb t3, U8_MENU_POSITION(t9)
lui t0, 0x8034
bnez t3, onlyCheckB
lh t1, 0xafa2(t0)
andi t1, t1, 0x0020
bnez t1, LPressed
lh t1, 0xafa2(t0)
andi t1, t1, 0x0010
bnez t1, RPressed
nop
onlyCheckB:
lh t1, 0xafa2(t0)
andi t1, t1, 0x4000
bnez t1, BPressed
nop

b wrapPauseHandling
nop

LPressed:
li t2, 2
beq t2, t3, wrapPauseHandling
nop
sb t2, U8_MENU_POSITION(t9)

li.u a0, 0x7000F881
jal 0x802CA190
li.l a0, 0x7000F881

b wrapPauseHandling
nop

RPressed:
li t2, 1
beq t2, t3, wrapPauseHandling
nop
sb t2, U8_MENU_POSITION(t9)

li.u a0, 0x7000F881
jal 0x802CA190
li.l a0, 0x7000F881

b wrapPauseHandling
nop

BPressed:
beqz t3, wrapPauseHandling
nop
sb r0, U8_MENU_POSITION(t9)

li.u a0, 0x7000F881
jal 0x802CA190
li.l a0, 0x7000F881

b wrapPauseHandling
nop

wrapPauseHandling:
lui s5, 0x8034
b wrap
lh t6, 0xbace(s5)

wrap:
lw ra, 0x14(sp)
jr ra
addiu sp, sp, 0x18

.orga 0x802F25B8 - 0x80245000
jal 0x80403800
nop 

.orga 0x1203800
addiu sp, sp, -0x18
sw ra, 0x14(sp)

li a0, 0
jal 0x80408000
li a1, 1

bnez v0, wrapStarSound
nop

;Check interaction
lui t0, 0x8036
lw t0, 0x1160(t0)
li a3, 0x0B9a
lwc1 f12, 0xa0(t0)
lwc1 f14, 0xa4(t0)

;s32 is_point_within_radius_of_mario(f32 x, f32 y, f32 z, s32 dist);
jal 0x802E5208
lw a2, 0xa8(t0)

beqz v0, resetTimer
lui t6, 0x8036

lw t6, 0x1160(t6)
lw t1, 0x154(t6)
li t2, 30
bne t1, t2, wrapStarSound
li.u a0, 0x30160091

sw r0, 0x154(t6)

jal 0x802CA190
li.l a0, 0x30160091

b wrapStarSound
nop

resetTimer:
lw t6, 0x1160(t6)
sw r0, 0x154(t6)

wrapStarSound:
lw t6, 0x80361160

lw ra, 0x14(sp)
jr ra
addiu sp, sp, 0x18