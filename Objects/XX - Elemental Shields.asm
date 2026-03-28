; OST:
shield_lastloadedDPLC:	equ Obj_Control_Var_04
shield_art:		equ Obj_Control_Var_08
shield_DPLC:		equ Obj_Control_Var_0C
shield_VRAM:		equ Obj_Control_Var_10

; ===========================================================================
; ---------------------------------------------------------------------------
; Object - Fire Shield
; ---------------------------------------------------------------------------
; Offset_0x0103C6: Obj_Fire_Shield:
Obj_FireShield:
		move.l	#MapUnc_FireShield,mappings(a0)
		move.l	#DPLC_FireShield,shield_DPLC(a0)
		move.l	#Art_Fire_Shield,shield_art(a0)
		move.b	#4,render_flags(a0)
		move.w	#$80,Obj_Priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.w	#$79C,Obj_Art_VRAM(a0)
		move.w	#$F380,shield_VRAM(a0)
		btst	#7,(Obj_Player_One+Obj_Art_VRAM).w
		beq.s	.notHighPriority
		bset	#7,Obj_Art_VRAM(a0)
; Offset_0x010410:
.notHighPriority:
		move.l	#FireShield_Main,(a0)
; Offset_0x010416:
FireShield_Main:
		move.w	Obj_Player_Last(a0),a2
		btst	#Invincibility_Type,Obj_Player_Status(a2)
		bne.s	Offset_0x010464
		btst	#Classic_Type,Obj_Player_Status(a2)
		beq.s	FireShield_Delete
		move.w	Obj_X(a2),Obj_X(a0)
		move.w	Obj_Y(a2),Obj_Y(a0)
		move.b	Obj_Status(a2),Obj_Status(a0)
		andi.w	#$7FFF,Obj_Art_VRAM(a0)
		tst.w	Obj_Art_VRAM(A2)
		bpl.s	FireShield_Display
		ori.w	#$8000,Obj_Art_VRAM(a0)
; Offset_0x01044E: .notHighPriority:
FireShield_Display:
		lea	(FireShield_AnimateData).l,a1
		jsr	(AnimateSprite).l
		bsr.w	LoadShieldDynamicPLC
		jmp	(DisplaySprite).l

Offset_0x010464:
		rts
; ===========================================================================
; Offset_0x010466:
FireShield_Delete:
		jmp     (DeleteObject).l

; ===========================================================================
; ---------------------------------------------------------------------------
; Object - Lightning Shield (or Thunder Shield :P)
; ---------------------------------------------------------------------------
; Offset_0x01046C: Obj_Lightning_Shield:
Obj_LightningShield:
		move.l	#MapUnc_LightningShield,mappings(a0)
		move.l	#DPLC_LightningShield,shield_DPLC(a0)
		move.l	#Art_Lightning_Shield,shield_art(a0)
		move.b	#4,render_flags(a0)
		move.w	#$80,Obj_Priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.w	#$79C,Obj_Art_VRAM(a0)
		move.w	#$F380,shield_VRAM(a0)
		btst	#7,(Obj_Player_One+Obj_Art_VRAM).w
		beq.s	.notHighPriority
		bset	#7,Obj_Art_VRAM(a0)
; Offset_0x0104B6:
.notHighPriority:
		move.l	#LightningShield_Main,(a0)
; Offset_0x0104BC:
LightningShield_Main:
		move.w	Obj_Player_Last(a0),a2
		btst	#Invincibility_Type,Obj_Player_Status(a2)
		bne.s	Offset_0x01050A
		btst	#Classic_Type,Obj_Player_Status(a2)
		beq.s	LightningShield_Delete
		move.w	Obj_X(a2),Obj_X(a0)
		move.w	Obj_Y(a2),Obj_Y(a0)
		move.b	Obj_Status(a2),Obj_Status(a0)
		andi.w	#$7FFF,Obj_Art_VRAM(a0)
		tst.w	Obj_Art_VRAM(A2)
		bpl.s	LightningShield_Display
		ori.w	#$8000,Obj_Art_VRAM(a0)
; Offset_0x0104F4: .notHighPriority:
LightningShield_Display:
		lea	(LightningShield_AnimateData).l,a1
		jsr	(AnimateSprite).l
		bsr.w	LoadShieldDynamicPLC
		jmp	(DisplaySprite).l

Offset_0x01050A:
		rts
; ===========================================================================
; Offset_0x01050C:
LightningShield_Delete:
		jmp     (DeleteObject).l

; ===========================================================================
; ---------------------------------------------------------------------------
; Object - Bubble Shield
; ---------------------------------------------------------------------------
; Offset_0x010512: Obj_Water_Shield:
Obj_BubbleShield:
		move.l	#MapUnc_BubbleShield,mappings(a0)
		move.l	#DPLC_BubbleShield,shield_DPLC(a0)
		move.l	#Art_Water_Shield,shield_art(a0)
		move.b	#4,render_flags(a0)
		move.w	#$80,Obj_Priority(a0)
		move.b	#$18,width_pixels(a0)
		move.b	#$18,height_pixels(a0)
		move.w	#$79C,Obj_Art_VRAM(a0)
		move.w	#$F380,shield_VRAM(a0)
		btst	#7,(Obj_Player_One+Obj_Art_VRAM).w
		beq.s	.notHighPriority
		bset	#7,Obj_Art_VRAM(a0)
; Offset_0x01055C:
.notHighPriority:
		move.l	#BubbleShield_Main,(a0)
; Offset_0x010562:
BubbleShield_Main:
		move.w	Obj_Player_Last(a0),a2
		btst	#Invincibility_Type,Obj_Player_Status(a2)
		bne.s	Offset_0x0105B0
		btst	#Classic_Type,Obj_Player_Status(a2)
		beq.s	BubbleShield_Delete
		move.w	Obj_X(a2),Obj_X(a0)
		move.w	Obj_Y(a2),Obj_Y(a0)
		move.b	Obj_Status(a2),Obj_Status(a0)
		andi.w	#$7FFF,Obj_Art_VRAM(a0)
		tst.w	Obj_Art_VRAM(A2)
		bpl.s	BubbleShield_Display
		ori.w	#$8000,Obj_Art_VRAM(a0)
; Offset_0x01059A: .notHighPriority:
BubbleShield_Display:
		lea	(BubbleShield_AnimateData).l,a1
		jsr	(AnimateSprite).l
		bsr.w	LoadShieldDynamicPLC
		jmp	(DisplaySprite).l

Offset_0x0105B0:
		rts
; ===========================================================================
; Offset_0x0105B2:
BubbleShield_Delete:
		jmp     (DeleteObject).l

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to load shield graphics into VRAM dynamically
; ---------------------------------------------------------------------------
; Offset_0x0105B8: Load_Shield_Dynamic_PLC:
LoadShieldDynamicPLC:
		moveq	#0,d0
		move.b	Obj_Map_Id(a0),d0
		cmp.b	shield_lastloadedDPLC(a0),d0
		beq.s	Offset_0x010606
		move.b	d0,shield_lastloadedDPLC(a0)
		move.l	shield_DPLC(a0),a2
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	Offset_0x010606
		move.w	shield_VRAM(a0),d4
; Offset_0x0105DC: Loop_Load_Shield_Dynamic_PLC:
.loop:
		moveq	#0,d1
		move.w	(a2)+,d1
		move.w	d1,d3
		lsr.w	#8,d3
		andi.w	#$F0,d3
		addi.w	#$10,d3
		andi.w	#$FFF,d1
		lsl.l	#5,d1
		add.l	shield_art(a0),d1
		move.w	d4,d2
		add.w	d3,d4
		add.w	d3,d4
		jsr	(QueueDMATransfer).l
		dbf	d5,.loop

Offset_0x010606:
		rts
; End of function LoadShieldDynamicPLC

; ===========================================================================
; ---------------------------------------------------------------------------
; Animation Script - Fire Shield
; ---------------------------------------------------------------------------
; Offset_0x010680: Fire_Shield_Animate_Data:
FireShield_AnimateData:
		dc.w	.main-FireShield_AnimateData
; Offset_0x01060A:
.main:		dc.b	3,  0,  1,  2,  3,  4,  5,  6
		dc.b	7,  8,  9,  9,$FF
		even

; ===========================================================================
; ---------------------------------------------------------------------------
; Animation Script - Lightning Shield
; ---------------------------------------------------------------------------
; Offset_0x010618: Lightning_Shield_Animate_Data:
LightningShield_AnimateData:
		dc.w	.main-LightningShield_AnimateData
; Offset_0x01061A:
.main:		dc.b	3, 0, 1, 2, 3, 4, 5, 6
		dc.b	7, $FF
		even

; ===========================================================================
; ---------------------------------------------------------------------------
; Animation Script - Bubble Shield
; ---------------------------------------------------------------------------
; Offset_0x010624: Water_Shield_Animate_Data:
BubbleShield_AnimateData:
		dc.w	.main-BubbleShield_AnimateData
; Offset_0x010626:
.main:		dc.b	3, 0, 1, 2, 3, 4, 5, 6
		dc.b	7, 8, 9, $A, $B, $FF
		even

; ===========================================================================
; ---------------------------------------------------------------------------
; Mappings/DPLC - Fire Shield
; ---------------------------------------------------------------------------
; Offset_0x010634: Fire_Shield_Mappings:
MapUnc_FireShield:	include	"data/mappings/XX - Fire Shield.asm"
; Offset_0x010728: Fire_Shield_Dyn_Script:
DPLC_FireShield:	include	"data/mappings/XX - Fire Shield DPLC.asm"

; ===========================================================================
; ---------------------------------------------------------------------------
; Mappings/DPLC - Lightning Shield
; ---------------------------------------------------------------------------
; Offset_0x1076C: Lightning_Shield_Mappings:
MapUnc_LightningShield:	include	"data/mappings/XX - Lightning Shield.asm"
; Offset_0x010822: Lightning_Shield_Dyn_Script:
DPLC_LightningShield:	include	"data/mappings/XX - Lightning Shield DPLC.asm"

; ===========================================================================
; ---------------------------------------------------------------------------
; Mappings/DPLC - Bubble Shield
; ---------------------------------------------------------------------------
; Offset_0x010874: Water_Shield_Mappings:
MapUnc_BubbleShield:	include	"data/mappings/XX - Bubble Shield.asm"
; Offset_0x010940: Water_Shield_Dyn_Script:
DPLC_BubbleShield:	include	"data/mappings/XX - Bubble Shield DPLC.asm"