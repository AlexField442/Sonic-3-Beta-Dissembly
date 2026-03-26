; ===========================================================================
; ---------------------------------------------------------------------------
; Object - Classic Shield (leftover from Sonic 2)
; ---------------------------------------------------------------------------
; Offset_0x00F972: Obj_Classic_Shield:
Obj_ClassicShield:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	ClassicShield_Index(pc,d0.w),d1
		jmp	ClassicShield_Index(pc,d1.w)
; ===========================================================================
; Offset_0x00F980:
ClassicShield_Index:
		dc.w ClassicShield_Init-ClassicShield_Index
		dc.w ClassicShield_Main-ClassicShield_Index
; ===========================================================================
; Offset_0x00F984:
ClassicShield_Init:
		addq.b	#2,routine(a0)
		move.l	#Classic_Shield_Mappings,mappings(a0)
		move.b	#4,render_flags(a0)
		move.w	#$80,Obj_Priority(a0)
		move.b	#$18,width_pixels(a0)
		move.w	#$79C,Obj_Art_VRAM(a0)
; Offset_0x00F9A8:
ClassicShield_Main:
		move.w	Obj_Player_Last(a0),a2
		btst	#1,Obj_Player_Status(a2)
		bne.s	Offset_0x00F9F2
		btst	#0,Obj_Player_Status(a2)
		beq.s	ClassicShield_Delete
		move.w	Obj_X(a2),Obj_X(a0)
		move.w	Obj_Y(a2),Obj_Y(a0)
		move.b	Obj_Status(a2),Obj_Status(a0)
		andi.w	#$7FFF,Obj_Art_VRAM(a0)
		tst.w	Obj_Art_VRAM(a2)
		bpl.s	ClassicShield_Display
		ori.w	#$8000,Obj_Art_VRAM(a0)
; Offset_0x00F9E0:
ClassicShield_Display:
		lea	(Classic_Shield_Animate_Data).l,a1
		jsr	(AnimateSprite).l
		jmp	(DisplaySprite).l

Offset_0x00F9F2:
		rts
; ===========================================================================
; Offset_0x00F9F4:
ClassicShield_Delete:
		jmp	(DeleteObject).l

; ===========================================================================
; ---------------------------------------------------------------------------
; Object - Invincibility Stars (that don't display properly :P)
; ---------------------------------------------------------------------------
; Offset_0x00F9FA:
Obj_Invincibility:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	Invincibility_Index(pc,d0.w),d1
		jmp	Invincibility_Index(pc,d1.w)
; ===========================================================================
; Offset_0x00FA08:
Invincibility_Index:
		dc.w Invincibility_Init-Invincibility_Index
		dc.w Invincibility_BigStars-Invincibility_Index
		dc.w Invincibility_TrailingStars-Invincibility_Index
; ===========================================================================

Offset_0x00FA0E:
		dc.l	Offset_0x00FC11
		dc.w	$B
		dc.l	Offset_0x00FC26
		dc.w	$160D
		dc.l	Offset_0x00FC3F
		dc.w	$2C0D
; ===========================================================================
; Offset_0x00FA20:
Invincibility_Init:
		; This code is missing, meaning that the invincibility will only display if something else
		; (such as the Game/Time Over text) is loaded into its VRAM. Uncomment this to fix this.
		;move.l	#Art_Invincibility,d1
		;move.w	#$F380,d2
		;move.w	#$200,d3
		;jsr	(QueueDMATransfer).l
		moveq	#0,d2
		lea	Offset_0x00FA0E-6(pc),a2
		lea	(a0),a1
		moveq	#3,d1

Offset_0x00FA2A:
		move.l	(a0),(a1)
		move.b	#4,routine(a1)
		move.l	#Invincibility_Mappings,mappings(a1)
		move.w	#$79C,Obj_Art_VRAM(a1)
		move.w	#$80,Obj_Priority(a1)
		move.b	#4,render_flags(a1)
		bset	#6,render_flags(a1)
		move.b	#$10,width_pixels(a1)
		move.w	#2,Obj_Sub_Y(a1)
		move.w	Obj_Player_Last(a0),Obj_Player_Last(a1)
		move.b	d2,Obj_Control_Var_06(a1)
		addq.w	#1,d2
		move.l	(a2)+,Obj_Control_Var_00(a1)
		move.w	(a2)+,Obj_Control_Var_04(a1)
		lea	Obj_Size(a1),a1
		dbf	d1,Offset_0x00FA2A

		move.b	#2,routine(a0)
		move.b	#4,Obj_Control_Var_04(a0)
; Offset_0x00FA86:
Invincibility_BigStars:
		; These two lines were added since Sonic 2, which fixes an oversight where transforming
		; Super while invincible would keep the invincibility stars.
		tst.b	(Super_Sonic_flag).w
		bne.w	DeleteObject
		move.w	Obj_Player_Last(a0),a1
		btst	#Invincibility_Type,Obj_Player_Status(a1)
		beq.w	DeleteObject
		move.w	Obj_X(a1),d0
		move.w	D0, Obj_X(a0)
		move.w	Obj_Y(a1),d1
		move.w	d1,Obj_Y(a0)
		lea	Obj_Speed_X(a0),a2
		lea	Offset_0x00FC04(pc),a3
		moveq	#0,d5

Offset_0x00FAB6:
		move.w	Obj_Control_Var_08(a0),d2
		move.b	(a3,d2.w),d5
		bpl.s	Offset_0x00FAC6
		clr.w	Obj_Control_Var_08(a0)
		bra.s	Offset_0x00FAB6

Offset_0x00FAC6:
		addq.w	#1,Obj_Control_Var_08(a0)
		lea	Invincibility_StarPositions(pc),a6
		move.b	Obj_Control_Var_04(a0),d6
		jsr	Offset_0x00FBAE(pc)
		move.w	d2,(a2)+
		move.w	d3,(a2)+
		move.w	d5,(a2)+
		addi.w	#$20,d6
		jsr	Offset_0x00FBAE(pc)
		move.w	d2,(a2)+
		move.w	d3,(a2)+
		move.w	d5,(a2)+
		moveq	#$12,d0
		btst	#0,Obj_Status(a1)
		beq.s	Offset_0x00FAF6
		neg.w	d0

Offset_0x00FAF6:
		add.b	d0,Obj_Control_Var_04(a0)
		bra.w	DisplaySprite
; ===========================================================================
; Offset_0x00FAFE:
Invincibility_TrailingStars:
		; Same thing as above, but for the smaller, trailing stars behind the player.
		tst.b	(Super_Sonic_flag).w
		bne.w	DeleteObject
		move.w	Obj_Player_Last(a0),a1
		btst	 #Invincibility_Type, Obj_Player_Status(a1)
		beq.w	DeleteObject
		cmpi.w	#Miles_Alone, (Player_Selected_Flag).w
		beq.s	Offset_0x00FB2A
		lea	(Position_Table_Index).w,a5
		lea	(Position_Table_Data).w,a6
		tst.b	Obj_Player_One_Or_Two_2(a0)
		beq.s	Offset_0x00FB32

Offset_0x00FB2A:
		lea	(Position_Table_Index_2P).w,a5
		lea	(Position_Table_Data_P2).w,a6

Offset_0x00FB32:
		move.b	Obj_Control_Var_06(a0),d1
		lsl.b	#2,d1
		move.w	d1,d2
		add.w	d1,d1
		add.w	d2,d1
		move.w	(a5),d0
		sub.b	d1,d0
		lea	(a6,d0.w),a2
		move.w	(a2)+,d0
		move.w	(a2)+,d1
		move.w	d0,Obj_X(a0)
		move.w	d1,Obj_Y(a0)
		lea	Obj_Speed_X(a0),a2
		move.l	Obj_Control_Var_00(a0),a3

Offset_0x00FB5A:
		move.w	Obj_Control_Var_08(a0),d2
		move.b	(a3,d2.w),d5
		bpl.s	Offset_0x00FB6A
		clr.w	Obj_Control_Var_08(A0)
		bra.s	Offset_0x00FB5A

Offset_0x00FB6A:
		swap.w	d5
		add.b	Obj_P_Invcbility_Time(a0),d2
		move.b	(a3,d2.w),d5
		addq.w	#1,Obj_Control_Var_08(a0)
		lea	Invincibility_StarPositions(pc),a6
		move.b	Obj_Control_Var_04(a0),d6
		jsr	Offset_0x00FBAE(pc)
		move.w	d2,(a2)+
		move.w	d3,(a2)+
		move.w	d5,(a2)+
		addi.w	#$20,d6
		swap.w	d5
		jsr	Offset_0x00FBAE(pc)
		move.w	d2,(a2)+
		move.w	d3,(a2)+
		move.w	d5,(a2)+
		moveq	#2,d0
		btst	#0,Obj_Status(a1)
		beq.s	Offset_0x00FBA6
		neg.w	d0

Offset_0x00FBA6:
		add.b	d0,Obj_Control_Var_04(a0)
		bra.w	DisplaySprite
; ===========================================================================

Offset_0x00FBAE:
		andi.w	#$3E,d6
		move.b	(a6,d6.w),d2
		move.b	1(a6,d6.w),d3
		ext.w	d2
		ext.w	d3
		add.w	d0,d2
		add.w	d1,d3
		rts
; ===========================================================================
; This table seems to store the positions for each star
; Offset_0x00FBC4:
Invincibility_StarPositions:
		dc.b	$0F, $00, $0F, $03, $0E, $06, $0D, $08
		dc.b	$0B, $0B, $08, $0D, $06, $0E, $03, $0F
		dc.b	$00, $10, $FC, $0F, $F9, $0E, $F7, $0D
		dc.b	$F4, $0B, $F2, $08, $F1, $06, $F0, $03
		dc.b	$F0, $00, $F0, $FC, $F1, $F9, $F2, $F7
		dc.b	$F4, $F4, $F7, $F2, $F9, $F1, $FC, $F0
		dc.b	$FF, $F0, $03, $F0, $06, $F1, $08, $F2
		dc.b	$0B, $F4, $0D, $F7, $0E, $F9, $0F, $FC

; And these tables are the animation scripts
Offset_0x00FC04:
		dc.b	$08, $05, $07, $06, $06, $07, $05, $08
		dc.b	$06, $07, $07, $06, $FF

Offset_0x00FC11:
		dc.b	$08, $07, $06, $05, $04, $03, $04, $05
		dc.b	$06, $07, $FF, $03, $04, $05, $06, $07
		dc.b	$08, $07, $06, $05, $04

Offset_0x00FC26:
		dc.b	$08, $07, $06, $05, $04, $03, $02, $03
		dc.b	$04, $05, $06, $07, $FF, $02, $03, $04
		dc.b	$05, $06, $07, $08, $07, $06, $05, $04
		dc.b	$03

Offset_0x00FC3F:
		dc.b	$07, $06, $05, $04, $03, $02, $01, $02
		dc.b	$03, $04, $05, $06, $FF, $01, $02, $03
		dc.b	$04, $05, $06, $07, $06, $05, $04, $03
		dc.b	$02

; ===========================================================================
; ---------------------------------------------------------------------------
; Animation Script - Classic Shield
; ---------------------------------------------------------------------------
; Offset_0x00FC58:
Classic_Shield_Animate_Data:
		dc.w	.main-Classic_Shield_Animate_Data
; Offset_0x00FC5A:
.main:		dc.b	0, 5, 0, 5, 1, 5, 2, 5
		dc.b	3, 5, 4,$FF
		even

; ===========================================================================
; ---------------------------------------------------------------------------
; Mappings - Classic Shield
; ---------------------------------------------------------------------------
; Offset_0x00FC66:
Classic_Shield_Mappings:
		dc.w	Offset_0x00FC72-Classic_Shield_Mappings
		dc.w	Offset_0x00FC8C-Classic_Shield_Mappings
		dc.w	Offset_0x00FCA6-Classic_Shield_Mappings
		dc.w	Offset_0x00FCC0-Classic_Shield_Mappings
		dc.w	Offset_0x00FCDA-Classic_Shield_Mappings
		dc.w	Offset_0x00FCF4-Classic_Shield_Mappings
Offset_0x00FC72:
		dc.w	$0004
		dc.w	$F005, $0000, $FFF0
		dc.w	$F005, $0800, $0000
		dc.w	$0005, $1000, $FFF0
		dc.w	$0005, $1800, $0000
Offset_0x00FC8C:
		dc.w	$0004
		dc.w	$F005, $0004, $FFF0
		dc.w	$F005, $0804, $0000
		dc.w	$0005, $1004, $FFF0
		dc.w	$0005, $1804, $0000
Offset_0x00FCA6:
		dc.w	$0004
		dc.w	$F005, $0008, $FFF0
		dc.w	$F005, $0808, $0000
		dc.w	$0005, $1008, $FFF0
		dc.w	$0005, $1808, $0000
Offset_0x00FCC0:
		dc.w	$0004
		dc.w	$F005, $000C, $FFF0
		dc.w	$F005, $080C, $0000
		dc.w	$0005, $100C, $FFF0
		dc.w	$0005, $180C, $0000
Offset_0x00FCDA:
		dc.w	$0004
		dc.w	$F005, $0010, $FFF0
		dc.w	$F005, $0810, $0000
		dc.w	$0005, $1010, $FFF0
		dc.w	$0005, $1810, $0000
Offset_0x00FCF4:
		dc.w	$0004
		dc.w	$E00B, $0014, $FFE8
		dc.w	$E00B, $0814, $0000
		dc.w	$000B, $1014, $FFE8
		dc.w	$000B, $1814, $0000

; ===========================================================================
; ---------------------------------------------------------------------------
; Mappings - Invincibility Stars
; ---------------------------------------------------------------------------
; Offset_0x00FD0E:
Invincibility_Mappings:
		dc.w	Offset_0x00FD20-Invincibility_Mappings
		dc.w	Offset_0x00FD22-Invincibility_Mappings
		dc.w	Offset_0x00FD2A-Invincibility_Mappings
		dc.w	Offset_0x00FD32-Invincibility_Mappings
		dc.w	Offset_0x00FD3A-Invincibility_Mappings
		dc.w	Offset_0x00FD42-Invincibility_Mappings
		dc.w	Offset_0x00FD4A-Invincibility_Mappings
		dc.w	Offset_0x00FD52-Invincibility_Mappings
		dc.w	Offset_0x00FD5A-Invincibility_Mappings
Offset_0x00FD20:
		dc.w	$0000
Offset_0x00FD22:
		dc.w	$0001
		dc.w	$F801, $0000, $FFFC
Offset_0x00FD2A:
		dc.w	$0001
		dc.w	$F801, $0002, $FFFC
Offset_0x00FD32:
		dc.w	$0001
		dc.w	$F801, $0004, $FFFC
Offset_0x00FD3A:
		dc.w	$0001
		dc.w	$F801, $0006, $FFFC
Offset_0x00FD42:
		dc.w	$0001
		dc.w	$F801, $0008, $FFFC
Offset_0x00FD4A:
		dc.w	$0001
		dc.w	$F805, $000A, $FFF8
Offset_0x00FD52:
		dc.w	$0001
		dc.w	$F805, $000E, $FFF8
Offset_0x00FD5A:
		dc.w	$0001
		dc.w	$F00F, $0012, $FFF0