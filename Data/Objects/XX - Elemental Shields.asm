; ===========================================================================
; ---------------------------------------------------------------------------
; Object - Fire Shield
; ---------------------------------------------------------------------------
; Offset_0x0103C6: Obj_Fire_Shield:
Obj_FireShield:
		move.l	#MapUnc_FireShield,Obj_Map(a0)
		move.l	#Fire_Shield_Dyn_Script,Obj_Control_Var_0C(a0)
		move.l	#Art_Fire_Shield,Obj_Control_Var_08(a0)
		move.b	#4,Obj_Flags(a0)
		move.w	#$80,Obj_Priority(a0)
		move.b	#$18,Obj_Width(a0)
		move.b	#$18,Obj_Height(a0)
		move.w	#$79C,Obj_Art_VRAM(a0)
		move.w	#$F380,Obj_Control_Var_10(a0)
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
		move.l	#Lightning_Shield_Mappings,Obj_Map(a0)
		move.l	#Lightning_Shield_Dyn_Script,Obj_Control_Var_0C(a0)
		move.l	#Art_Lightning_Shield,Obj_Control_Var_08(a0)
		move.b	#4,Obj_Flags(a0)
		move.w	#$80,Obj_Priority(a0)
		move.b	#$18,Obj_Width(a0)
		move.b	#$18,Obj_Height(a0)
		move.w	#$79C,Obj_Art_VRAM(a0)
		move.w	#$F380,Obj_Control_Var_10(a0)
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
		move.l	#Water_Shield_Mappings,Obj_Map(a0)
		move.l	#Water_Shield_Dyn_Script,Obj_Control_Var_0C(a0)
		move.l	#Art_Water_Shield,Obj_Control_Var_08(a0)
		move.b	#4,Obj_Flags(a0)
		move.w	#$80,Obj_Priority(a0)
		move.b	#$18,Obj_Width(a0)
		move.b	#$18,Obj_Height(a0)
		move.w	#$79C,Obj_Art_VRAM(a0)
		move.w	#$F380,Obj_Control_Var_10(a0)
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
		cmp.b	Obj_Control_Var_04(a0),d0
		beq.s	Offset_0x010606
		move.b	d0,Obj_Control_Var_04(a0)
		move.l	Obj_Control_Var_0C(a0),a2
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		move.w	(a2)+,d5
		subq.w	#1,d5
		bmi.s	Offset_0x010606
		move.w	Obj_Control_Var_10(a0),d4
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
		add.l	Obj_Control_Var_08(a0),d1
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
; Mappings - Fire Shield
; ---------------------------------------------------------------------------
; Offset_0x010634: Fire_Shield_Mappings:
MapUnc_FireShield:	include	"data/mappings/XX - Fire Shield.asm"

; ===========================================================================
; ---------------------------------------------------------------------------
; Dynamic Pattern Load Cues - Fire Shield
; ---------------------------------------------------------------------------
; Offset_0x010728:
Fire_Shield_Dyn_Script:
		dc.w	Offset_0x01073C-Fire_Shield_Dyn_Script
		dc.w	Offset_0x010746-Fire_Shield_Dyn_Script
		dc.w	Offset_0x010750-Fire_Shield_Dyn_Script
		dc.w	Offset_0x01075A-Fire_Shield_Dyn_Script
		dc.w	Offset_0x010764-Fire_Shield_Dyn_Script
		dc.w	Offset_0x01075A-Fire_Shield_Dyn_Script
		dc.w	Offset_0x010750-Fire_Shield_Dyn_Script
		dc.w	Offset_0x010746-Fire_Shield_Dyn_Script
		dc.w	Offset_0x01073C-Fire_Shield_Dyn_Script
		dc.w	Offset_0x01076A-Fire_Shield_Dyn_Script
Offset_0x01073C:
		dc.w	$0004
		dc.w	$5000, $5006, $500C, $5012
Offset_0x010746:
		dc.w	$0004
		dc.w	$8018, $8021, $802A, $8033
Offset_0x010750:
		dc.w	$0004
		dc.w	$803C, $8045, $804E, $8057
Offset_0x01075A:
		dc.w	$0004
		dc.w	$8060, $8069, $5072, $5078
Offset_0x010764:
		dc.w	$0002
		dc.w	$F07E, $708E
Offset_0x01076A:
		dc.w	$0000

; ===========================================================================
; ---------------------------------------------------------------------------
; Mappings - Lightning Shield
; ---------------------------------------------------------------------------
; Offset_0x1076C:
Lightning_Shield_Mappings:
		dc.w	Offset_0x01077C-Lightning_Shield_Mappings
		dc.w	Offset_0x010790-Lightning_Shield_Mappings
		dc.w	Offset_0x01079E-Lightning_Shield_Mappings
		dc.w	Offset_0x0107B2-Lightning_Shield_Mappings
		dc.w	Offset_0x0107C6-Lightning_Shield_Mappings
		dc.w	Offset_0x0107D4-Lightning_Shield_Mappings
		dc.w	Offset_0x0107EE-Lightning_Shield_Mappings
		dc.w	Offset_0x010808-Lightning_Shield_Mappings
Offset_0x01077C:
		dc.w	$0003
		dc.w	$E80C, $0000, $FFF0
		dc.w	$F007, $0004, $0000
		dc.w	$100C, $000C, $FFF0
Offset_0x010790:
		dc.w	$0002
		dc.w	$E80A, $0000, $FFF4
		dc.w	$000A, $0009, $FFF4
Offset_0x01079E:
		dc.w	$0003
		dc.w	$E808, $0000, $FFF0
		dc.w	$F00B, $0003, $FFF8
		dc.w	$1008, $000F, $FFF0
Offset_0x0107B2:
		dc.w	$0003
		dc.w	$E808, $0000, $FFF0
		dc.w	$F00E, $0003, $FFF0
		dc.w	$0809, $000F, $FFF0
Offset_0x0107C6:
		dc.w	$0002
		dc.w	$E807, $0000, $FFF8
		dc.w	$0805, $0008, $FFF8
Offset_0x0107D4:
		dc.w	$0004
		dc.w	$E80A, $0000, $FFE8
		dc.w	$E80A, $0009, $0000
		dc.w	$000A, $1812, $FFE8
		dc.w	$000A, $181B, $0000
Offset_0x0107EE:
		dc.w	$0004
		dc.w	$E80A, $0000, $FFE8
		dc.w	$E80A, $0009, $0000
		dc.w	$000A, $1812, $FFE8
		dc.w	$000A, $181B, $0000
Offset_0x010808:
		dc.w	$0004
		dc.w	$E80A, $0000, $FFE8
		dc.w	$E80A, $0809, $0000
		dc.w	$000A, $1012, $FFE8
		dc.w	$000A, $181B, $0000

; ===========================================================================
; ---------------------------------------------------------------------------
; Dynamic Pattern Load Cues - Lightning Shield
; ---------------------------------------------------------------------------
; Offset_0x010822:
Lightning_Shield_Dyn_Script:
		dc.w	Offset_0x010832-Lightning_Shield_Dyn_Script
		dc.w	Offset_0x01083A-Lightning_Shield_Dyn_Script
		dc.w	Offset_0x010840-Lightning_Shield_Dyn_Script
		dc.w	Offset_0x010848-Lightning_Shield_Dyn_Script
		dc.w	Offset_0x010850-Lightning_Shield_Dyn_Script
		dc.w	Offset_0x010856-Lightning_Shield_Dyn_Script
		dc.w	Offset_0x010860-Lightning_Shield_Dyn_Script
		dc.w	Offset_0x01086A-Lightning_Shield_Dyn_Script
Offset_0x010832:
		dc.w	$0003
		dc.w	$3000, $7004, $300C
Offset_0x01083A:
		dc.w	$0002
		dc.w	$8010, $8019
Offset_0x010840:
		dc.w	$0003
		dc.w	$2022, $B025, $2031
Offset_0x010848:
		dc.w	$0003
		dc.w	$2034, $B037, $5043
Offset_0x010850:
		dc.w	$0002
		dc.w	$7049, $3051
Offset_0x010856:
		dc.w	$0004
		dc.w	$8055, $805E, $805E, $8055
Offset_0x010860:
		dc.w	$0004
		dc.w	$8067, $8070, $8070, $8067
Offset_0x01086A:
		dc.w	$0004
		dc.w	$8079, $8079, $8079, $8079  

; ===========================================================================
; ---------------------------------------------------------------------------
; Mappings - Bubble Shield
; ---------------------------------------------------------------------------
; Offset_0x010874:
Water_Shield_Mappings:
		dc.w	Offset_0x01088C-Water_Shield_Mappings
		dc.w	Offset_0x01089A-Water_Shield_Mappings
		dc.w	Offset_0x0108A8-Water_Shield_Mappings
		dc.w	Offset_0x0108B6-Water_Shield_Mappings
		dc.w	Offset_0x0108C4-Water_Shield_Mappings
		dc.w	Offset_0x0108D2-Water_Shield_Mappings
		dc.w	Offset_0x0108E0-Water_Shield_Mappings
		dc.w	Offset_0x0108EE-Water_Shield_Mappings
		dc.w	Offset_0x0108FC-Water_Shield_Mappings
		dc.w	Offset_0x010916-Water_Shield_Mappings
		dc.w	Offset_0x010930-Water_Shield_Mappings
		dc.w	Offset_0x010938-Water_Shield_Mappings
Offset_0x01088C:
		dc.w	$0002
		dc.w	$E808, $0000, $FFE8
		dc.w	$E808, $0803, $0000
Offset_0x01089A:
		dc.w	$0002
		dc.w	$E809, $0000, $FFE8
		dc.w	$E809, $0806, $0000
Offset_0x0108A8:
		dc.w	$0002
		dc.w	$E80A, $0000, $FFE8
		dc.w	$E80A, $0809, $0000
Offset_0x0108B6:
		dc.w	$0002
		dc.w	$E80A, $0000, $FFE8
		dc.w	$E80A, $0809, $0000
Offset_0x0108C4:
		dc.w	$0002
		dc.w	$F00B, $0000, $FFE8
		dc.w	$F00B, $080C, $0000
Offset_0x0108D2:
		dc.w	$0002
		dc.w	$000A, $0000, $FFE8
		dc.w	$000A, $0809, $0000
Offset_0x0108E0:
		dc.w	$0002
		dc.w	$000A, $0000, $FFE8
		dc.w	$000A, $0809, $0000
Offset_0x0108EE:
		dc.w	$0002
		dc.w	$0809, $0000, $FFE8
		dc.w	$0809, $0806, $0000
Offset_0x0108FC:
		dc.w	$0004
		dc.w	$E80A, $0000, $FFE8
		dc.w	$E80A, $0809, $0000
		dc.w	$000A, $1012, $FFE8
		dc.w	$000A, $181B, $0000
Offset_0x010916:
		dc.w	$0004
		dc.w	$E80A, $0000, $FFE8
		dc.w	$E80A, $0809, $0000
		dc.w	$000A, $1012, $FFE8
		dc.w	$000A, $181B, $0000
Offset_0x010930:
		dc.w	$0001
		dc.w	$FC00, $0000, $FFFC
Offset_0x010938:
		dc.w	$0001
		dc.w	$FC00, $0000, $FFFC

; ===========================================================================
; ---------------------------------------------------------------------------
; Dynamic Pattern Load Cues - Bubble Shield
; ---------------------------------------------------------------------------
; Offset_0x010940:
Water_Shield_Dyn_Script:
		dc.w	Offset_0x010958-Water_Shield_Dyn_Script
		dc.w	Offset_0x01095E-Water_Shield_Dyn_Script
		dc.w	Offset_0x010964-Water_Shield_Dyn_Script
		dc.w	Offset_0x01096A-Water_Shield_Dyn_Script
		dc.w	Offset_0x010970-Water_Shield_Dyn_Script
		dc.w	Offset_0x010976-Water_Shield_Dyn_Script
		dc.w	Offset_0x01097C-Water_Shield_Dyn_Script
		dc.w	Offset_0x010982-Water_Shield_Dyn_Script
		dc.w	Offset_0x010988-Water_Shield_Dyn_Script
		dc.w	Offset_0x010992-Water_Shield_Dyn_Script
		dc.w	Offset_0x01099C-Water_Shield_Dyn_Script
		dc.w	Offset_0x0109A0-Water_Shield_Dyn_Script
Offset_0x010958:
		dc.w	$0002
		dc.w	$2000, $2000
Offset_0x01095E:
		dc.w	$0002
		dc.w	$5003, $5003
Offset_0x010964:
		dc.w	$0002
		dc.w	$8009, $8009
Offset_0x01096A:
		dc.w	$0002
		dc.w	$8012, $8012
Offset_0x010970:
		dc.w	$0002
		dc.w	$B01B, $B01B
Offset_0x010976:
		dc.w	$0002
		dc.w	$8027, $8027
Offset_0x01097C:
		dc.w	$0002
		dc.w	$8030, $8030
Offset_0x010982:
		dc.w	$0002
		dc.w	$5039, $5039
Offset_0x010988:
		dc.w	$0004
		dc.w	$803F, $803F, $803F, $803F
Offset_0x010992:
		dc.w	$0004
		dc.w	$8048, $8048, $8048, $8048
Offset_0x01099C:
		dc.w	$0001
		dc.w	$0051
Offset_0x0109A0:
		dc.w	$0001
		dc.w	$0052