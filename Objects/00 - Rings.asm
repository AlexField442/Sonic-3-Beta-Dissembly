; ===========================================================================
; ---------------------------------------------------------------------------
; Object 00 - Rings
;
; This just handles ones spawned in debug mode, the actual rings in levels
; are handled using a separate manager
; ---------------------------------------------------------------------------
; Offset_0x0109A4: Obj_0x00_Rings:
Obj00_Rings:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	Rings_Index(pc,d0.w),d1
		jmp	Rings_Index(pc,d1.w) 
; ===========================================================================
; Offset_0x0109B2:
Rings_Index:	dc.w Rings_Init-Rings_Index
		dc.w Rings_Main-Rings_Index
		dc.w Rings_Collect-Rings_Index
		dc.w Rings_Display-Rings_Index
		dc.w Rings_Delete-Rings_Index
; ===========================================================================
; Offset_0x0109BC:
Rings_Init:
		addq.b	#2,routine(a0)
		move.l	#Rings_Mappings,mappings(a0)
		move.w	#$A6BC,Obj_Art_VRAM(a0)
		move.b	#4,render_flags(a0)
		move.w	#$100,Obj_Priority(a0)
		move.b	#$47,Obj_Col_Flags(a0)
		move.b	#8,width_pixels(a0)
		tst.w	(Two_Player_Flag).w
		beq.s	Rings_Main
		move.w	#$63D2,Obj_Art_VRAM(a0)
; Offset_0x0109F2:
Rings_Main:
		move.b	(Object_Frame_Buffer).w,Obj_Map_Id(a0)
		bra.w	MarkObjGone_5
; ===========================================================================
; Offset_0x0109FC:
Rings_Collect:
		addq.b	#2,routine(a0)
		move.b	#0,Obj_Col_Flags(a0)
		move.w	#$80,Obj_Priority(a0)
		bsr.s	CollectRing
; Offset_0x010A0E:
Rings_Display:
		lea	(Rings_Animate_Data).l,a1
		bsr.w	AnimateSprite
		bra.w	DisplaySprite
; ===========================================================================
; Offset_0x010A1C:
Rings_Delete:
		bra.w	DeleteObject

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to collect a ring
; ---------------------------------------------------------------------------
; Offset_0x010A20: Add_Rings_Check_Ring_Status:
CollectRing:
		tst.b	Obj_Player_One_Or_Two(a0)
		bne.s	CollectRing_Tails
; Offset_0x010A26: Add_Rings:
CollectRing_Sonic:
		cmpi.w	#999,(Total_Ring_Count_Address).w
		bcc.s	Offset_0x010A32
		addq.w	#1,(Total_Ring_Count_Address).w

Offset_0x010A32:
		move.w	#Ring_Sfx,d0
		cmpi.w	#999,(Ring_count).w
		bcc.s	Offset_0x010A74
		addq.w	#1,(Ring_count).w
		ori.b	#1,(Update_HUD_rings).w
		cmpi.w	#100,(Ring_count).w
		bcs.s	Offset_0x010A74
		bset	#1,(Extra_life_flags).w
		beq.s	Offset_0x010A68
		cmpi.w	#200,(Ring_count).w
		bcs.s	Offset_0x010A74
		bset	#2,(Extra_life_flags).w
		bne.s	Offset_0x010A74

Offset_0x010A68:
		addq.b	#1,(Life_count).w
		addq.b	#1,(Update_HUD_lives).w
		move.w	#Ring_Lost_Sfx,d0

Offset_0x010A74:
		jmp	(PlaySound).l
		rts
; ---------------------------------------------------------------------------
; Offset_0x010A7C: Add_Rings_Player_Two:
CollectRing_Tails:
		cmpi.w	#999,(Total_Ring_Count_Address_P2).w
		bcc.s	Offset_0x010A88
		addq.w	#1,(Total_Ring_Count_Address_P2).w

Offset_0x010A88:
		cmpi.w	#999,(Ring_Count_Address_P2).w
		bcc.s	Offset_0x010A94
		addq.w	#1,(Ring_Count_Address_P2).w

Offset_0x010A94:
		tst.w	(Two_Player_Flag).w
		beq.s	Offset_0x010A32
		ori.b	#1,(HUD_Rings_Refresh_Flag_P2).w
		move.w	#Ring_Sfx, D0
		cmpi.w	#100,(Ring_Count_Address_P2).w
		bcs.s	Offset_0x010AD0
		bset	#1,(Ring_Status_Flag_P2).w
		beq.s	Offset_0x010AC4
		cmpi.w	#200,(Ring_Count_Address_P2).w
		bcs.s	Offset_0x010AD0
		bset	#2,(Ring_Status_Flag_P2).w
		bne.s	Offset_0x010AD0

Offset_0x010AC4:
		addq.b	#1,(Life_Count_P2).w
		addq.b	#1,(HUD_Life_Refresh_Flag_P2).w
		move.w	#Ring_Lost_Sfx,d0

Offset_0x010AD0:
		jmp	(PlaySound).l
; End of function CollectRing