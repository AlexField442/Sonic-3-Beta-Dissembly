; ===========================================================================
; ---------------------------------------------------------------------------
; Object 01 - Monitors
;
; The power-ups themselves are handled by the next object. This just does the
; monitor collision and graphics.
; ---------------------------------------------------------------------------
; Offset_0x012F44: Obj_0x01_Monitors:
Obj01_Monitors:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	Monitors_Index(pc,d0.w),d1
		jmp	Monitors_Index(pc,d1.w)   
; ===========================================================================
; Offset_0x012F52:
Monitors_Index:	dc.w Monitors_Init-Monitors_Index
		dc.w Monitors_Main-Monitors_Index
		dc.w Monitors_Break-Monitors_Index
		dc.w Monitors_Animate-Monitors_Index
		dc.w Monitors_ChkDel-Monitors_Index
; ===========================================================================
; Offset_0x012F5C:
Monitors_Init:
		addq.b	#2,routine(a0)
		move.b	#$F,y_radius(a0)
		move.b	#$F,x_radius(a0)
		move.l	#Monitors_Mappings,mappings(a0)
		move.w	#$4C4,art_tile(a0)
		move.b	#4,render_flags(a0)
		move.w	#$180,priority(a0)
		move.b	#$E,width_pixels(a0)
		move.b	#$10,height_pixels(a0)
		move.w	respawn_index(a0),a2
		bclr	#7,(a2)
		btst	#0,(a2)				; if this bit is set it means the monitor is already broken
		beq.s	Offset_0x012FAE
		move.b	#8,routine(a0)			; set monitor to 'broken' state
		move.b	#$B,mapping_frame(a0)
		rts
; ---------------------------------------------------------------------------

Offset_0x012FAE:
		move.b	#$46,collision_flags(a0)
		move.b	subtype(a0),anim(a0)	; subtype = icon to display
		tst.w	(Two_Player_Flag).w			; are we in two player mode?
		beq.s	Monitors_Main				; if not, branch
		move.b	#9,anim(a0)			; use '?' icon
; Offset_0x012FC6:
Monitors_Main:
		move.b	objoff_3C(a0),d0
		beq.s	SolidObject_Monitor
		; only when secondary routine isn't 0
		; make monitor fall
		bsr.w	ObjectFall
		tst.w	y_vel(a0)
		bmi.s	SolidObject_Monitor
		jsr	(ObjHitFloor).l
		tst.w	d1					; is the monitor on the ground?
		bpl.w	SolidObject_Monitor			; if not, branch
		add.w	d1,y_pos(a0)				; move monitor out of ground
		clr.w	y_vel(a0)
		clr.b	objoff_3C(a0)			; stop monitor from falling
; Offset_0x012FEE:
SolidObject_Monitor:
		move.w	#$19,d1
		move.w	#$10,d2
		move.w	d2,d3
		addq.w	#1,d3
		move.w	x_pos(a0),d4
		lea	(Obj_Player_One).w,a1
		moveq	#3,d6
		movem.l	d1-d4,-(sp)
		bsr.w	SolidObject_Monitor_Sonic
		movem.l	(sp)+,d1-d4
		lea	(Obj_Player_Two).w,a1
		moveq	#4,d6
		bsr.w	SolidObject_Monitor_Tails
		jsr	(Add_SpriteToCollisionResponseList).l
; Offset_0x013020:
Monitors_Animate:
		lea	(Monitors_AnimateData).l,a1
		bsr.w	AnimateSprite
; Offset_0x01302A:
Monitors_ChkDel:
		bra.w	MarkObjGone
; ===========================================================================
; Offset_0x01302E:
SolidObject_Monitor_Sonic:
		btst	d6,status(a0)			; is Sonic standing on the monitor?
		bne.s	Monitors_ChkOverEdge			; if yes, branch
		cmpi.b	#2,anim(a1)			; is Sonic spinning?
		bne.w	SolidObject_cont			; if not, branch
		rts
; ---------------------------------------------------------------------------
; Offset_0x013040:
SolidObject_Monitor_Tails:
		btst	d6,status(a0)			; is Tails standing on the monitor?
		bne.s	Monitors_ChkOverEdge			; if yes, branch
		tst.w	(Two_Player_Flag).w			; is it two player mode?
		beq.w	SolidObject_cont			; if not, branch
		cmpi.b	#2,anim(a1)			; is Tails spinning?
		bne.w	SolidObject_cont			; if not, branch
		rts
; ---------------------------------------------------------------------------
; Offset_0x01305A:
Monitors_ChkOverEdge:
		move.w	d1,d2
		add.w	d2,d2
		btst	#1,status(a1)			; is the character in the air?
		bne.s	.inAir					; if yes, branch
		; check, if character is standing on
		move.w	x_pos(a1),d0
		sub.w	x_pos(a0),d0
		add.w	d1,d0
		bmi.s	.inAir					; branch, if character is behind the left edge of the monitor
		cmp.w	d2,d0
		bcs.s	Monitors_CharStandOn			; branch, if character is behind the right edge of the monitor
; Offset_0x013076:
.inAir:
		bclr	#3,status(a1)			; clear 'on object' bit
		bset	#1,status(a1)			; set 'in air' bit
		bclr	d6,status(a0)			; clear 'standing on' bit for the current character
		moveq	#0,d4
		rts
; ---------------------------------------------------------------------------
; Offset_0x01308A:
Monitors_CharStandOn:
		move.w	d4,d2
		bsr.w	Player_On_Platform
		moveq	#0,d4
		rts    
; ===========================================================================
; Offset_0x013094:
Monitors_Break:
		move.b	status(a0),d0
		andi.b	#$78,d0					; is someone touching the monitor?
		beq.s	Monitors_SpawnIcon			; if not, branch
		move.b	d0,d1
		andi.b	#$28,d1					; is it the main character?
		beq.s	.TailsBreakMonitor			; if not, branch
		andi.b	#$D7,(Obj_Player_One+status).w
		ori.b	#2,(Obj_Player_One+status).w	; prevent Sonic from walking in the air
; Offset_0x0130B2:
.TailsBreakMonitor:
		andi.b	#$50,d0					; is it the sidekick?
		beq.s	Monitors_SpawnIcon			; if not, branch
		andi.b	#$D7,(Obj_Player_Two+status).w
		ori.b	#2,(Obj_Player_Two+status).w	; prevent Tails from walking in the air
; Offset_0x0130C4:
Monitors_SpawnIcon:
		clr.b	status(a0)
		addq.b	#2,routine(a0)
		move.b	#0,collision_flags(a0)
		bsr.w	AllocateObject
		bne.s	Monitors_SpawnSmoke
		move.l	#Obj_MonitorContents,(a1)		; load Obj_MonitorContents
		move.w	x_pos(a0),x_pos(a1)			; set icon's position
		move.w	y_pos(a0),y_pos(a1)
		move.b	anim(a0),anim(a1)
		move.w	parent(a0),parent(a1)	; parent gets item
; Offset_0x0130F6:
Monitors_SpawnSmoke:
		bsr.w	AllocateObject
		bne.s	Offset_0x013112
		move.l	#Obj_Explosion,(a1)			; load Obj_Explosion
		addq.b	#2,routine(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)

Offset_0x013112:
		move.w	respawn_index(a0),a2
		bset	#0,(a2)					; mark monitor as destroyed
		move.b	#$A,anim(a0)
		bra.w	DisplaySprite

; ===========================================================================
; ---------------------------------------------------------------------------
; Object - Monitor contents (code for power-up behavior and rising image)
; ---------------------------------------------------------------------------
; Offset_0x13120: Monitors_Contents:
Obj_MonitorContents:
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	MonitorContents_Index(pc,d0.w),d1
		jmp	MonitorContents_Index(pc,d1.w)
; ===========================================================================
; Offset_0x013132:
MonitorContents_Index:
		dc.w MonitorContents_Init-MonitorContents_Index
		dc.w MonitorContents_Raise-MonitorContents_Index
		dc.w MonitorContents_Delete-MonitorContents_Index
; ===========================================================================
; Offset_0x013138:
MonitorContents_Init:
		addq.b	#2,routine(a0)
		move.w	#$84C4,art_tile(a0)
		move.b	#$24,render_flags(a0)
		move.w	#$180,priority(a0)
		move.b	#8,width_pixels(a0)
		move.w	#-$300,y_vel(a0)
		moveq	#0,d0
		move.b	anim(a0),d0
		; all of this up to MonitorContents_Icon are remnants from Sonic 2's multiplayer
		tst.w	(Two_Player_Flag).w			; is this two player mode?
		beq.s	MonitorContents_Icon			; if not, branch
		move.w	(Level_frame_counter).w,d0		; use the timer to determine which item
		andi.w	#7,d0					; and 7 means there are 8 different items
		addq.w	#1,d0					; add 1 to prevent getting the static monitor
		tst.w	(Two_Player_Items_Mode).w		; are monitors set to 'teleport only'?
		beq.s	.noTeleport				; if not, branch
		moveq	#8,d0					; force contents to be teleport
; Offset_0x013178:
.noTeleport:
		; keep teleport monitor from causing unwanted effects
		cmpi.w	#8,d0					; is it the teleport monitor?
		bne.s	Offset_0x01318E				; if not, branch
		move.b	(Update_HUD_timer).w,d1
		add.b	(HUD_Timer_Refresh_Flag_P2).w,d1
		cmpi.b	#2,d1					; is either player done with the act?
		beq.s	Offset_0x01318E				; if not, branch
		moveq	#7,d0					; give invincibility instead

Offset_0x01318E:
		move.b	d0,anim(a0)

; Offset_0x013192:
MonitorContents_Icon:
		; determine correct mappings offset
		addq.b	#1,d0
		move.b	d0,mapping_frame(a0)
		move.l	#Monitors_Mappings,a1
		add.b	d0,d0
		adda.w	(a1,d0.w),a1
		addq.w	#2,a1
		move.l	a1,mappings(a0)
; Offset_0x0131AA:
MonitorContents_Raise:
		bsr.s	MonitorContents_Move
		bra.w	DisplaySprite
; ===========================================================================
; Offset_0x0131B0:
MonitorContents_Move:
		tst.w	y_vel(a0)				; is the icon still floating up?
		bpl.w	MonitorContents_Main			; if not, branch
		bsr.w	SpeedToPos
		addi.w	#$18,y_vel(a0)
		rts
; ---------------------------------------------------------------------------
; Offset_0x0131C4:
MonitorContents_Main:
		addq.b	#2,routine(a0)
		move.w	#$1D,anim_frame_duration(a0)
		move.w	parent(a0),a1
		lea	(Monitors_Broken).w,a2
		cmpa.w	#Obj_Player_One,a1			; did Sonic break the monitor?
		beq.s	MonitorContents_CheckType		; if yes, branch
		lea	(Monitors_Broken_P2).w,a2
; Offset_0x0131E0:
MonitorContents_CheckType:
		moveq	#0,d0
		move.b	anim(a0),d0
		add.w	d0,d0
		move.w	MonitorContents_Type(pc,d0.w),d0
		jmp	MonitorContents_Type(pc,d0.w)
; ===========================================================================
; Offset_0x0131F0:
MonitorContents_Type:
		dc.w MonitorContents_Eggman-MonitorContents_Type
		dc.w MonitorContents_SonicLife-MonitorContents_Type
		dc.w MonitorContents_Eggman-MonitorContents_Type
		dc.w MonitorContents_Rings-MonitorContents_Type
		dc.w MonitorContents_SpeedShoes-MonitorContents_Type
		dc.w MonitorContents_FireShield-MonitorContents_Type
		dc.w MonitorContents_LightningShield-MonitorContents_Type
		dc.w MonitorContents_BubbleShield-MonitorContents_Type
		dc.w MonitorContents_Invincibility-MonitorContents_Type
		dc.w MonitorContents_SuperSonic-MonitorContents_Type
; ===========================================================================
; Offset_0x013204: Monitor_Static: Monitor_Robotnik: S2_Monitor_Miles_Life:
MonitorContents_Eggman:
		addq.w	#1,(a2)
		bra.w	Hurt_Player_A1
; ===========================================================================
; Offset_0x1320A: Monitor_Sonic_Life:
MonitorContents_SonicLife:
		addq.w	#1,(Monitors_Broken).w
		addq.b	#1,(Life_count).w
		addq.b	#1,(Update_HUD_lives).w
		moveq	#Extra_Life_Snd,d0
		jmp	(PlaySound).l
; ===========================================================================
; Offset_0x01321E: Monitor_Rings:
MonitorContents_Rings:
		addq.w	#1,(a2)
		lea	(Ring_count).w,a2
		lea	(Update_HUD_rings).w,a3
		lea	(Extra_life_flags).w,a4
		lea	(Total_Ring_Count_Address).w,a5
		; another Sonic 2 leftover
		cmpa.w	#Obj_Player_One,a1
		beq.s	.notTails
		lea	(Ring_Count_Address_P2).w,a2
		lea	(HUD_Rings_Refresh_Flag_P2).w,a3
		lea	(Ring_Status_Flag_P2).w,a4
		lea	(Total_Ring_Count_Address_P2).w,a5
; Offset_0x013246:
.notTails:
		; these two functions cap ring collection at 999 rings
		addi.w	#10,(a5)
		cmpi.w	#999,(a5)
		bcs.s	.under999Rings
		move.w	#999,(a5)
; Offset_0x013254:
.under999Rings:
		addi.w	#10,(a2)
		cmpi.w	#999,(a2)
		bcs.s	.under999Rings2
		move.w	#999,(a2)
; Offset_0x013262:
.under999Rings2:
		ori.b	#1,(a3)
		cmpi.w	#100,(a2)
		bcs.s	.playSound
		bset	#1,(a4)
		beq.s	MonitorContents_SonicOrTails
		cmpi.w	#200,(a2)
		bcs.s	.playSound
		bset	#2,(a4)
		beq.s	MonitorContents_SonicOrTails
; Offset_0x01327E:
.playSound:
		moveq	#Ring_Sfx,d0
		jmp	(PlaySound).l
; ---------------------------------------------------------------------------
; Hilariously, this function is still used in the final, complete with the
; (now incorrect) jump to the Eggman monitor if the player is P2 Tails
; Offset_0x013286: Monitor_Add_Life_To_P1_Or_P2:
MonitorContents_SonicOrTails:
		cmpa.w	#Obj_Player_One,a1
		beq.w	MonitorContents_SonicLife
		bra.w	MonitorContents_Eggman
; ===========================================================================
; Offset_0x013292: Monitor_Shoes:
MonitorContents_SpeedShoes:
		addq.w	#1,(a2)
		bset	#Speed_Type, status_secondary(a1)
		move.b	#$96,speedshoes_time(a1)
		cmpa.w	#Obj_Player_One,a1
		bne.s	.notSonic
		cmpi.w	#2,(Player_Selected_Flag).w
		beq.s	.notSonic
		move.w	#$C00,(Sonic_Max_Speed).w
		move.w	#$18,(Sonic_Acceleration).w
		move.w	#$80,(Sonic_Deceleration).w
		bra.s	.playMusic
; Offset_0x0132C2:
.notSonic:
		move.w	#$C00,(Miles_Max_Speed).w
		move.w	#$18,(Miles_Acceleration).w
		move.w	#$80,(Miles_Deceleration).w
; Offset_0x0132D4:
.playMusic:
		moveq	#Invincibility_Snd,d0
		jmp	(PlaySound).l
; ===========================================================================
; Offset_0x0132DC: Monitor_Fire_Shield:
MonitorContents_FireShield:
		addq.w	#1,(a2)
		bset	#Classic_Type,status_secondary(a1)
		bset	#Fire_Type,status_secondary(a1)
		moveq	#Got_Fire_Shield_Sfx,d0
		jsr	(PlaySound).l
		tst.b	parent+1(a0)
		bne.s	.notSonic
		move.l	#Obj_FireShield,(Obj_P1_Shield).w
		move.w	a1,(Obj_P1_Shield+parent).w
		rts
; Offset_0x013306:
.notSonic:
		move.l	#Obj_FireShield,(Obj_P2_Shield).w
		move.w	a1,(Obj_P2_Shield+parent).w
		rts
; ===========================================================================
; Offset_0x013314: Monitor_Lightning_Shield:
MonitorContents_LightningShield:
		addq.w	#1,(a2)
		bset	#Classic_Type,status_secondary(a1)
		bset	#Lightning_Type,status_secondary(a1)
		moveq	#Got_Lightning_Shield_Sfx,d0
		jsr	(PlaySound).l
		tst.b	parent+1(a0)
		bne.s	.notSonic
		move.l	#Obj_LightningShield,(Obj_P1_Shield).w
		move.w	a1,(Obj_P1_Shield+parent).w
		rts
; Offset_0x01333E:
.notSonic:
		move.l	#Obj_LightningShield,(Obj_P2_Shield).w
		move.w	a1,(Obj_P2_Shield+parent).w
		rts
; ===========================================================================
; Offset_0x01334C: Monitor_Water_Shield:
MonitorContents_BubbleShield:
		addq.w	#1,(a2)
		bset	#Classic_Type,status_secondary(a1)
		bset	#Water_Type,status_secondary(a1)
		moveq	#Got_Water_Shield_Sfx,d0
		jsr	(PlaySound).l
		tst.b	parent+1(a0)
		bne.s	.notSonic
		move.l	#Obj_BubbleShield,(Obj_P1_Shield).w
		move.w	a1,(Obj_P1_Shield+parent).w
		rts
; Offset_0x013376:
.notSonic:
		move.l	#Obj_BubbleShield,(Obj_P2_Shield).w
		move.w	a1,(Obj_P2_Shield+parent).w
		rts
; ===========================================================================
; Offset_0x013384: Monitor_Invincibility:
MonitorContents_Invincibility:
		addq.w	#1,(a2)
		tst.b	(Super_Sonic_flag).w
		bne.s	Offset_0x0133CE
		bset	#Invincibility_Type,status_secondary(a1)
		move.b	#$96,invincibility_time(a1)
		tst.b	(Boss_Flag).w
		bne.s	Offset_0x0133AE
		cmpi.b	#$C,subtype(a1)
		bls.s	Offset_0x0133AE
		moveq	#Invincibility_Snd,d0
		jsr	(PlaySound).l

Offset_0x0133AE:
		tst.b	parent+1(a0)
		bne.s	.notSonic
		move.l	#Obj_Invincibility,(Obj_P1_Invincibility).w
		move.w	a1,(Obj_P1_Invincibility+parent).w
		rts
; Offset_0x0133C2:
.notSonic:
		move.l	#Obj_Invincibility,(Obj_P2_Invincibility).w
		move.w	a1,(Obj_P2_Invincibility+parent).w

Offset_0x0133CE:
		rts
; ===========================================================================
; Offset_0x133D0: Monitor_Super_Sonic:
MonitorContents_SuperSonic:
		addq.w	#1,(a2)
		addi.w	#50,(Ring_count).w
		move.b	#1,(Super_Sonic_Palette_Status).w
		move.b	#$F,(Super_Sonic_Palette_Timer).w
		move.b	#1,(Super_Sonic_flag).w
		move.b	#$81,(Obj_Player_One+objoff_2E).w
		move.b	#$1F,(Obj_Player_One+anim).w
		move.l	#Obj_Super_Sonic_Stars,(Obj_Super_Sonic_Stars_RAM).w
		move.w	#$A00,(Sonic_Max_Speed).w
		move.w	#$30,(Sonic_Acceleration).w
		move.w	#$100,(Sonic_Deceleration).w
		move.b	#0,(Obj_Player_One+invincibility_time).w
		bset	#Invincibility_Type,status_secondary(a1)
		moveq	#Hyper_Form_Change_Sfx,d0
		jsr	(PlaySound).l
		moveq	#Invincibility_Snd,d0
		jmp	(PlaySound).l
		rts
; ===========================================================================
; Offset_0x01342E: Monitor_Delete_Object:
MonitorContents_Delete:
		subq.w	#1,anim_frame_duration(a0)
		bmi.w	DeleteObject
		bra.w	DisplaySprite

; ===========================================================================
; ---------------------------------------------------------------------------
; Animation script for Monitors
; ---------------------------------------------------------------------------
; Offset_0x01343A:
Monitors_AnimateData:
		dc.w	MonAni_Static-Monitors_AnimateData
		dc.w	MonAni_Sonic-Monitors_AnimateData
		dc.w	MonAni_Eggman-Monitors_AnimateData
		dc.w	MonAni_Rings-Monitors_AnimateData
		dc.w	MonAni_SpeedShoes-Monitors_AnimateData
		dc.w	MonAni_FireShield-Monitors_AnimateData
		dc.w	MonAni_LightningShield-Monitors_AnimateData
		dc.w	MonAni_BubbleShield-Monitors_AnimateData
		dc.w	MonAni_Invincibility-Monitors_AnimateData
		dc.w	MonAni_SuperSonic-Monitors_AnimateData
		dc.w	MonAni_Broken-Monitors_AnimateData
MonAni_Static:		dc.b	  1,  0,  1,$FF
MonAni_Sonic:		dc.b	  1,  0,  2,  2,  1,  2,  2,$FF
MonAni_Eggman:		dc.b	  1,  0,  3,  3,  1,  3,  3,$FF
MonAni_Rings:		dc.b	  1,  0,  4,  4,  1,  4,  4,$FF
MonAni_SpeedShoes:	dc.b	  1,  0,  5,  5,  1,  5,  5,$FF
MonAni_FireShield:	dc.b	  1,  0,  6,  6,  1,  6,  6,$FF
MonAni_LightningShield:	dc.b	  1,  0,  7,  7,  1,  7,  7,$FF
MonAni_BubbleShield:	dc.b	  1,  0,  8,  8,  1,  8,  8,$FF
MonAni_Invincibility:	dc.b	  1,  0,  9,  9,  1,  9,  9,$FF
MonAni_SuperSonic:	dc.b	  1,  0, $A, $A,  1, $A, $A,$FF
MonAni_Broken:		dc.b	  2,  0,  1, $B,$FE,  1
		even
; ---------------------------------------------------------------------------
; Sprite mappings for Monitors and Monitor Contents
; ---------------------------------------------------------------------------
; Offset_0x0134A2:
Monitors_Mappings:	include	"data/mappings/01 - Monitors.asm"