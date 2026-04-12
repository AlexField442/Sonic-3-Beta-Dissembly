; ===========================================================================
; ---------------------------------------------------------------------------
; Object - Explosion from a monitor or enemy
; ---------------------------------------------------------------------------
; Offset_0x013D7C: Object_Hit:
Obj_Explosion:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	Explosion_Index(pc,d0.w),d1
		jmp	Explosion_Index(pc,d1.w)   
; ===========================================================================
; Offset_0x013D8A:
Explosion_Index:
		dc.w Explosion_Init-Explosion_Index
		dc.w Explosion_Main-Explosion_Index
		dc.w Explosion_Animate-Explosion_Index
; ===========================================================================
; Offset_0x013D90:
Explosion_Init:
		addq.b	#2,routine(a0)
		jsr	(AllocateObject).l
		bne.s	Explosion_Main
		move.l	#Obj_Flickies,(a1)
		move.w	Obj_X(a0),Obj_X(a1)
		move.w	Obj_Y(a0),Obj_Y(a1)
		move.w	Obj_Control_Var_0E(a0),Obj_Control_Var_0E(a1)
; Offset_0x013DB4:
Explosion_Main:
		addq.b	#2,routine(a0)
		move.l	#MapUnc_Explosion,mappings(a0)
		move.w	Obj_Art_VRAM(a0),d0
		andi.w	#$8000,d0
		ori.w	#$5A0,d0
		move.w	d0,Obj_Art_VRAM(a0)
		move.b	#4,render_flags(a0)
		move.w	#$80,priority(a0)
		move.b	#0,Obj_Col_Flags(a0)
		move.b	#$C,width_pixels(a0)
		move.b	#$C,height_pixels(a0)
		move.b	#3,Obj_Ani_Time(a0)
		move.b	#0,Obj_Map_Id(a0)
		moveq	#Object_Hit_Sfx,d0
		jsr	(PlaySound).l
		move.l	#Explosion_Animate,(a0)
; Offset_0x013E08:
Explosion_Animate:
		subq.b	#1,Obj_Ani_Time(a0)
		bpl.s	Explosion_Display
		move.b	#7,Obj_Ani_Time(a0)
		addq.b	#1,Obj_Map_Id(a0)
		cmpi.b	#5,Obj_Map_Id(a0)
		beq.w	DeleteObject
; Offset_0x013E22:
Explosion_Display:
		jmp	(DisplaySprite).l

; ===========================================================================
; ---------------------------------------------------------------------------
; Object - Dissipation effect when the fire shield is submerged, as
; well as a smoke effect for CNZ cannons and LBZ tunnels
; ---------------------------------------------------------------------------
; Offset_0x013E28: Obj_Fire_Shield_Dissipate:
Obj_FireShield_Dissipate:
		move.l	#MapUnc_Explosion,mappings(a0)
		move.w	#$5A0,Obj_Art_VRAM(a0)
		move.b	#4,render_flags(a0)
		move.w	#$280,priority(a0)
		move.b	#$C,width_pixels(a0)
		move.b	#$C,height_pixels(a0)
		move.b	#3,Obj_Ani_Time(a0)
		move.b	#1,Obj_Map_Id(a0)
		move.l	#FireShieldDissipate_Animate,(a0)
; Offset_0x013E60:
FireShieldDissipate_Animate:
		jsr	(SpeedToPos).l
		subq.b	#1,Obj_Ani_Time(a0)
		bpl.s	FireShieldDissipate_Display
		move.b	#3,Obj_Ani_Time(a0)
		addq.b	#1,Obj_Map_Id(a0)
		cmpi.b	#5,Obj_Map_Id(a0)
		beq.w	DeleteObject
; Offset_0x013E80:
FireShieldDissipate_Display:
		jmp	(DisplaySprite).l

; ===========================================================================
; ---------------------------------------------------------------------------
; Object - Smoke effect for falling bridge in AIZ2 cutscene
; ---------------------------------------------------------------------------
; Offset_0x013E86:
Obj_Dissipate:
		move.l	#MapUnc_Explosion,mappings(a0)
		move.w	#$85A0,Obj_Art_VRAM(a0)
		move.b	#4,render_flags(a0)
		move.w	#$100,priority(a0)
		move.b	#$C,width_pixels(a0)
		move.b	#$C,height_pixels(a0)
		move.b	#0,Obj_Map_Id(a0)
		move.l	#Dissipate_Main,(a0)
; Offset_0x013EB8:                
Dissipate_Main:
		subq.b	#1,Obj_Ani_Time(a0)
		bmi.s	Offset_0x013EC0
		rts

Offset_0x013EC0:
		move.b	#3,Obj_Ani_Time(a0)
		move.l	#Dissipate_Animate,(a0)
; Offset_0x013ECC:                
Dissipate_Animate:
		jsr	(SpeedToPos).l
		subq.b	#1,Obj_Ani_Time(a0)
		bpl.s	Dissipate_Display
		move.b	#7,Obj_Ani_Time(a0)
		addq.b	#1,Obj_Map_Id(a0)
		cmpi.b	#5,Obj_Map_Id(a0)
		beq.w	DeleteObject
; Offset_0x013EEC:
Dissipate_Display:
		jmp	(DisplaySprite).l

; ===========================================================================
; ---------------------------------------------------------------------------
; Mappings - Explosions/Smoke
; ---------------------------------------------------------------------------
; Offset_0x013EF2: Object_Hit_Mappings:
MapUnc_Explosion:	include	"data/mappings/XX - Explosion.asm" 