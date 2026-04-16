; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to run level events including camera resizing and object spawning
; ---------------------------------------------------------------------------
; Offset_0x0124A4: Dyn_Screen_Boss_Loader:
RunDynamicLevelEvents:
		moveq	#0,d0
		move.w	(Current_ZoneAndAct).w,d0
		ror.b	#1,d0
		lsr.w	#6,d0
		; This clamps the level index to prevent levels from accessing random data, but does it
		; way too hard, meaning stages beyond Balloon Park are able to execute early-stage events.
		andi.w	#$3E,d0
		move.w	DynResize_Index(pc,d0.w),d0
		jsr	DynResize_Index(pc,d0.w)
		moveq	#2,d1
		move.w	(Level_Limits_Max_Y).w,d0
		sub.w	(Sonic_Level_Limits_Max_Y).w,d0
		beq.s	Offset_0x0124E8
		bcc.s	Offset_0x0124EA
		neg.w	d1
		move.w	(Camera_Y).w,d0
		cmp.w	(Level_Limits_Max_Y).w,d0
		bls.s	Offset_0x0124DE
		move.w	d0,(Sonic_Level_Limits_Max_Y).w 
		andi.w	#-2,(Sonic_Level_Limits_Max_Y).w

Offset_0x0124DE:
		add.w	d1,(Sonic_Level_Limits_Max_Y).w
		move.b	#1,(Level_Limits_Y_Changing).w

Offset_0x0124E8:
		rts
; ---------------------------------------------------------------------------

Offset_0x0124EA:
		move.w	(Camera_Y).w,d0
		addi.w	#8,d0
		cmp.w	(Sonic_Level_Limits_Max_Y).w,d0
		bcs.s	Offset_0x012504
		btst	#1,(Obj_Player_One+status).w
		beq.s	Offset_0x012504
		add.w	d1,d1
		add.w	d1,d1

Offset_0x012504:
		add.w	d1,(Sonic_Level_Limits_Max_Y).w
		move.b	#1,(Level_Limits_Y_Changing).w
		rts
; End of function RunDynamicLevelEvents

; ===========================================================================
; Offset_0x012510:
DynResize_Index:
		dc.w	DynResize_AIz_1-DynResize_Index
		dc.w	DynResize_AIz_2-DynResize_Index
		dc.w	DynResize_Hz_1-DynResize_Index
		dc.w	DynResize_Hz_2-DynResize_Index
		dc.w	DynResize_MGz_1-DynResize_Index
		dc.w	DynResize_MGz_2-DynResize_Index
		dc.w	DynResize_Null1-DynResize_Index
		dc.w	DynResize_Null1-DynResize_Index
		dc.w	DynResize_Null1-DynResize_Index
		dc.w	DynResize_Null1-DynResize_Index
		dc.w	DynResize_Iz_1-DynResize_Index
		dc.w	DynResize_Null2-DynResize_Index
		dc.w	DynResize_Null2-DynResize_Index
		dc.w	DynResize_LBz_2-DynResize_Index
		dc.w	DynResize_Null3-DynResize_Index
		dc.w	DynResize_Null3-DynResize_Index
		dc.w	DynResize_Null3-DynResize_Index
		dc.w	DynResize_Null3-DynResize_Index
		dc.w	DynResize_Null3-DynResize_Index
		dc.w	DynResize_Null3-DynResize_Index
		dc.w	DynResize_Null3-DynResize_Index
		dc.w	DynResize_Null3-DynResize_Index
		dc.w	DynResize_Null3-DynResize_Index
		dc.w	DynResize_Null3-DynResize_Index
		dc.w	DynResize_Null3-DynResize_Index
		dc.w	DynResize_Null3-DynResize_Index
		dc.w	DynResize_Null3-DynResize_Index
		dc.w	DynResize_Null3-DynResize_Index
		dc.w	DynResize_Null3-DynResize_Index
		dc.w	DynResize_Null3-DynResize_Index
		dc.w	DynResize_Null3-DynResize_Index
		dc.w	DynResize_Null3-DynResize_Index
		dc.w	DynResize_Null3-DynResize_Index		; triggers AIZ1
		dc.w	DynResize_Null3-DynResize_Index		; triggers AIZ2
		dc.w	DynResize_Null3-DynResize_Index		; triggers HCZ1
		dc.w	DynResize_Null3-DynResize_Index		; triggers HCZ2
		dc.w	DynResize_Null3-DynResize_Index		; triggers MGZ1
		dc.w	DynResize_Null3-DynResize_Index		; triggers MGZ2
		dc.w	DynResize_Null3-DynResize_Index		; triggers CNZ1
		dc.w	DynResize_Null3-DynResize_Index		; triggers CNZ2
		dc.w	DynResize_Null3-DynResize_Index		; triggers FBZ1
		dc.w	DynResize_Null3-DynResize_Index		; triggers FBZ2
		dc.w	DynResize_Null3-DynResize_Index		; triggers ICZ1
		dc.w	DynResize_Null3-DynResize_Index		; triggers ICZ2
		dc.w	DynResize_Null3-DynResize_Index		; triggers LBZ1
		dc.w	DynResize_Null3-DynResize_Index		; triggers LBZ2
		dc.w	DynResize_Null3-DynResize_Index		; triggers MVZ1
		dc.w	DynResize_Null3-DynResize_Index		; triggers MVZ2
; ===========================================================================
; Offset_0x012570:
DynResize_AIz_1:
		moveq	#0,d0
		move.b	(Dynamic_Resize_Routine).w,d0
		move.w	DynResize_AIZ1_Index(pc,d0.w),d0
		jmp	DynResize_AIZ1_Index(pc,d0.w)
; ===========================================================================
; Offset_0x01257E:
DynResize_AIZ1_Index:
		dc.w	DynResize_AIZ1_LoadKnux-DynResize_AIZ1_Index
		dc.w	DynResize_AIZ1_LoadArt-DynResize_AIZ1_Index
		dc.w	Offset_0x012614-DynResize_AIZ1_Index
		dc.w	DynResize_AIZ1_LoadFlames-DynResize_AIZ1_Index
		dc.w	DynResize_AIZ1_End-DynResize_AIZ1_Index
; ===========================================================================
; Offset_0x012588:
DynResize_AIZ1_LoadKnux:
		move.b	#0,(Palette_Cycle_Flag).w
		cmpi.w	#$1000,(Camera_X).w
		bcs.s	Offset_0x0125D8
		move.b	#1,(Palette_Cycle_Flag).w
		cmpi.w	#$1300,(Camera_X).w
		bcs.s	Offset_0x0125D8
		jsr	(AllocateObject).l
		bne.s	Offset_0x0125BE
		move.l	#Obj_Knuckles,(a1)
		move.w	#$1450,x_pos(a1)
		move.w	#$419,y_pos(a1)

Offset_0x0125BE:
		moveq	#5,d0
		jsr	(PalLoad_Now).l
		move.w	#$1300,(Sonic_Level_Limits_Min_X).w
		moveq	#$B,d0
		jsr	(LoadPLC).l
		addq.b	#2,(Dynamic_Resize_Routine).w

Offset_0x0125D8:
		rts
; ---------------------------------------------------------------------------
; Offset_0x0125DA:
DynResize_AIZ1_LoadArt:
		cmpi.w	#$1400,(Camera_X).w
		bcs.s	Offset_0x012612
		lea	(Angel_Island_1_Blocks_3).l,a1
		lea	(Blocks_Mem_Address+$268).w,a2
		jsr	(Queue_Kos).l
		lea	(Angel_Island_1_Tiles_3).l,a1
		move.w	#$1760,d2
		jsr	(Queue_Kos_Module).l
		moveq	#$2A,d0
		jsr	(PalLoad_Now).l
		st	(Level_Events_Buffer_5).w
		addq.b	#2,(Dynamic_Resize_Routine).w

Offset_0x012612:
		rts
; ---------------------------------------------------------------------------

Offset_0x012614:
		lea	(Offset_0x01267E).l,a1
		bsr.w	Resize_MaxYFromX
		move.w	#$020E,(Palette_Row_2_Offset+$1E).w
		cmpi.w	#$2B00,(Camera_X).w
		bcs.s	Offset_0x012632
		move.w	#$0004,(Palette_Row_2_Offset+$1E).w

Offset_0x012632:
		cmpi.w	#$2D80,(Camera_X).w
		bcs.s	Offset_0x01264C
		move.w	#$0C02,(Palette_Row_2_Offset+$1E).w
		moveq	#$5A,d0
		jsr	(LoadPLC).l
		addq.b	#2,(Dynamic_Resize_Routine).w

Offset_0x01264C:
		rts 
; ---------------------------------------------------------------------------
; Offset_0x01264E:
DynResize_AIZ1_LoadFlames:
		lea	(Offset_0x01267E).l,a1
		bsr.w	Resize_MaxYFromX
		cmpi.w	#$2E00,(Camera_X).w
		bcs.s	Offset_0x01267A
		tst.b	(Kos_modules_left).w
		bne.s	Offset_0x01267A
		lea	(Angel_Island_1_Flames).l,a1
		move.w	#$A000,d2
		jsr	(Queue_Kos_Module).l
		addq.b	#2,(Dynamic_Resize_Routine).w

Offset_0x01267A:
		rts
;-------------------------------------------------------------------------------
; Offset_0x01267C:
DynResize_AIZ1_End:
		rts
;-------------------------------------------------------------------------------
Offset_0x01267E:
		dc.w	$8390, $1650
		dc.w	$83B0, $1B00
		dc.w	$8430, $2000
		dc.w	$84C0, $2B00
		dc.w	$83B0, $2D80
		dc.w	$82E0, $FFFF
;===============================================================================
DynResize_AIz_2:                                               ; Offset_0x012696     
		moveq	#$00, D0
		move.b	(Dynamic_Resize_Routine).w, D0               ; $FFFFEE33
		move.w	Offset_0x0126A4(pc,d0.w), D0
		jmp	Offset_0x0126A4(pc,d0.w)  
;-------------------------------------------------------------------------------
Offset_0x0126A4:
		dc.w	Offset_0x0126B6-Offset_0x0126A4
		dc.w	Offset_0x0126D0-Offset_0x0126A4
		dc.w	Offset_0x012750-Offset_0x0126A4
		dc.w	Offset_0x01276A-Offset_0x0126A4
		dc.w	Offset_0x0127BA-Offset_0x0126A4
		dc.w	Offset_0x0127D4-Offset_0x0126A4
		dc.w	Offset_0x0127EE-Offset_0x0126A4
		dc.w	Offset_0x012800-Offset_0x0126A4
		dc.w	Offset_0x01280E-Offset_0x0126A4 
;-------------------------------------------------------------------------------
Offset_0x0126B6:
		cmpi.w	#$0380, (Camera_X).w                         ; $FFFFEE78
		bcs.s	Offset_0x0126CE
		move.w	#$04F0, D0
		move.w	D0, (Sonic_Level_Limits_Max_Y).w             ; $FFFFEE1A
		move.w	D0, (Level_Limits_Max_Y).w                   ; $FFFFEE12
		addq.b	#$02, (Dynamic_Resize_Routine).w             ; $FFFFEE33
Offset_0x0126CE:
		rts   
;-------------------------------------------------------------------------------
Offset_0x0126D0:
		cmpi.w	#$0300, (Camera_Y).w                         ; $FFFFEE7C
		bcc.s	Offset_0x012724
		move.w	#$04F0, D0
		cmpi.w	#$0ED0, (Camera_X).w                         ; $FFFFEE78
		bcs.s	Offset_0x0126E8
		move.w	#$02B8, D0
Offset_0x0126E8:
		move.w	D0, (Sonic_Level_Limits_Max_Y).w             ; $FFFFEE1A
		move.w	D0, (Level_Limits_Max_Y).w                   ; $FFFFEE12
		cmpi.w	#$0F50, (Camera_X).w                         ; $FFFFEE78
		bcs.s	Offset_0x012722
		move.w	#$0F50, (Sonic_Level_Limits_Min_X).w         ; $FFFFEE14
		tst.w	(Debug_placement_mode).w                    ; $FFFFFE08
		bne.s	Offset_0x01271E
		jsr	(AllocateObject)                     ; Offset_0x011DD8
		bne.s	Offset_0x01271E
		move.l	#Obj_0xAC_AIz_Fire_Breath, (A1)        ; Offset_0x036AB4
		move.w	#$11F0, x_pos(A1)                                ; $0010
		move.w	#$0289, y_pos(A1)                                ; $0014
Offset_0x01271E:
		addq.b	#$02, (Dynamic_Resize_Routine).w             ; $FFFFEE33
Offset_0x012722:
		rts
Offset_0x012724:
		move.w	#$04F0, D0
		cmpi.w	#$0ED0, (Camera_X).w                         ; $FFFFEE78
		bcs.s	Offset_0x012734
		move.w	#$0450, D0
Offset_0x012734:
		cmpi.w	#$11A0, (Camera_X).w                         ; $FFFFEE78
		bcs.s	Offset_0x012746
		move.w	#$0820, D0
		move.w	D0, (Level_Limits_Max_Y).w                   ; $FFFFEE12
		rts
Offset_0x012746:
		move.w	D0, (Sonic_Level_Limits_Max_Y).w             ; $FFFFEE1A
		move.w	D0, (Level_Limits_Max_Y).w                   ; $FFFFEE12
		rts       
;-------------------------------------------------------------------------------
Offset_0x012750:
		cmpi.w	#$1500, (Camera_X).w                         ; $FFFFEE78
		bcs.s	Offset_0x012768
		move.w	#$0630, (Sonic_Level_Limits_Max_Y).w         ; $FFFFEE1A
		move.w	#$0630, (Level_Limits_Max_Y).w               ; $FFFFEE12
		addq.b	#$02, (Dynamic_Resize_Routine).w             ; $FFFFEE33
Offset_0x012768:
		rts  
;-------------------------------------------------------------------------------
Offset_0x01276A:
		cmpi.w	#$3C00, (Camera_X).w                         ; $FFFFEE78
		bcs.s	Offset_0x0127B8
		tst.b	(Kos_modules_left).w                    ; $FFFFFF60
		bne.s	Offset_0x0127B8
		lea	(Angel_Island_2_Blocks_3), A1          ; Offset_0x149448
		lea	(Blocks_Mem_Address+$0AA0).w, A2             ; $FFFF9AA0
		jsr	(Queue_Kos)          ; Offset_0x0019AE
		lea	(Angel_Island_2_Tiles_3), A1           ; Offset_0x14CA3C
		move.w	#$16A0, D2                       
		jsr	(Queue_Kos_Module)                 ; Offset_0x0018A8
		lea	(Angel_Island_2_Boss_Ship), A1         ; Offset_0x1397B0
		move.w	#$A000, D2
		jsr	(Queue_Kos_Module)                 ; Offset_0x0018A8
		moveq	#$30, D0
		jsr	(PalLoad_Now)                             ; Offset_0x002FBA
		st	(Level_Events_Buffer_5).w                    ; $FFFFEEC6
		addq.b	#$02, (Dynamic_Resize_Routine).w             ; $FFFFEE33
Offset_0x0127B8:
		rts  
;-------------------------------------------------------------------------------
Offset_0x0127BA:
		cmpi.w	#$3F00, (Camera_X).w                         ; $FFFFEE78
		bcs.s	Offset_0x0127D2
		move.w	#$015A, D0
		move.w	D0, (Sonic_Level_Limits_Min_Y).w             ; $FFFFEE18
		move.w	D0, (Level_Limits_Min_Y).w                   ; $FFFFEE10
		addq.b	#$02, (Dynamic_Resize_Routine).w             ; $FFFFEE33
Offset_0x0127D2:
		rts   
;-------------------------------------------------------------------------------
Offset_0x0127D4:
		cmpi.w	#$4000, (Camera_X).w                         ; $FFFFEE78
		bcs.s	Offset_0x0127EC
		move.w	#$015A, D0
		move.w	D0, (Sonic_Level_Limits_Max_Y).w             ; $FFFFEE1A
		move.w	D0, (Level_Limits_Max_Y).w                   ; $FFFFEE12
		addq.b	#$02, (Dynamic_Resize_Routine).w             ; $FFFFEE33
Offset_0x0127EC:
		rts  
;-------------------------------------------------------------------------------
Offset_0x0127EE:
		cmpi.w	#$4160, (Camera_X).w                         ; $FFFFEE78
		bcs.s	Offset_0x0127FE
		st	(Foreground_Events_Y_Counter).w              ; $FFFFEEC4
		addq.b	#$02, (Dynamic_Resize_Routine).w             ; $FFFFEE33
Offset_0x0127FE:
		rts     
;-------------------------------------------------------------------------------
Offset_0x012800:
		cmpi.w	#$4780, (Camera_X).w                         ; $FFFFEE78
		bcs.s	Offset_0x01280C
		addq.b	#$02, (Dynamic_Resize_Routine).w             ; $FFFFEE33
Offset_0x01280C:
		rts 
;-------------------------------------------------------------------------------
Offset_0x01280E:
		rts
;===============================================================================
DynResize_Hz_1:                                                ; Offset_0x012810
		rts                                                                
;===============================================================================
DynResize_Hz_2:                                                ; Offset_0x012812
		moveq	#$00, D0
		move.b	(Dynamic_Resize_Routine).w, D0               ; $FFFFEE33
		move.w	Offset_0x012820(pc,d0.w), D0
		jmp	Offset_0x012820(pc,d0.w)     
;-------------------------------------------------------------------------------
Offset_0x012820:
		dc.w	Offset_0x012824-Offset_0x012820
		dc.w	Offset_0x012836-Offset_0x012820   
;-------------------------------------------------------------------------------  
Offset_0x012824:
		cmpi.w	#$0C00, (Camera_X).w                         ; $FFFFEE78
		bcs.s	Offset_0x012834
		st	(Level_Events_Buffer_5).w                    ; $FFFFEEC6
		addq.b	#$02, (Dynamic_Resize_Routine).w             ; $FFFFEE33
Offset_0x012834:
		rts 
;-------------------------------------------------------------------------------  
Offset_0x012836:
		rts
;===============================================================================
DynResize_MGz_1:                                               ; Offset_0x012838
DynResize_MGz_2:                                               ; Offset_0x012838  
		moveq	#$00, D0
		move.b	(Dynamic_Resize_Routine).w, D0               ; $FFFFEE33
		move.w	Offset_0x012846(pc,d0.w), D0
		jmp	Offset_0x012846(pc,d0.w)  
;-------------------------------------------------------------------------------
Offset_0x012846:
		dc.w	Offset_0x01284C-Offset_0x012846
		dc.w	Offset_0x01288A-Offset_0x012846
		dc.w	Offset_0x0128E4-Offset_0x012846  
;-------------------------------------------------------------------------------
Offset_0x01284C:
		move.w	(Camera_Y).w, D0                             ; $FFFFEE7C
		cmpi.w	#$0600, D0
		bcs.s	Offset_0x012888
		cmpi.w	#$0700, D0
		bcc.s	Offset_0x012888
		cmpi.w	#$3A00, (Camera_X).w                         ; $FFFFEE78
		bcs.s	Offset_0x012888
		move.w	#$06A0, D0
		move.w	D0, (Sonic_Level_Limits_Min_Y).w             ; $FFFFEE18
		move.w	D0, (Level_Limits_Min_Y).w                   ; $FFFFEE10
		move.w	D0, (Sonic_Level_Limits_Max_Y).w             ; $FFFFEE1A
		move.w	D0, (Level_Limits_Max_Y).w                   ; $FFFFEE12
		move.w	#$3C80, D0
		move.w	D0, (Sonic_Level_Limits_Max_X).w             ; $FFFFEE16
		move.w	D0, (Level_Limits_Max_X).w                   ; $FFFFEE0E
		addq.b	#$02, (Dynamic_Resize_Routine).w             ; $FFFFEE33
Offset_0x012888:
		rts  
;-------------------------------------------------------------------------------
Offset_0x01288A:
		cmpi.w	#$3A00, (Camera_X).w                         ; $FFFFEE78
		bcs.s	Offset_0x0128C4
		move.w	#$3C80, D0
		cmp.w	(Camera_X).w, D0                             ; $FFFFEE78
		bhi.s	Offset_0x0128E2
		move.w	D0, (Sonic_Level_Limits_Min_X).w             ; $FFFFEE14
		move.w	D0, (Level_Limits_Min_X).w                   ; $FFFFEE0C
		jsr	(AllocateObject)                     ; Offset_0x011DD8
		bne.s	Offset_0x0128BE
		move.l	#Obj_0xB0_MGz_Drill_Mobile, (A1)       ; Offset_0x039C7E
		move.w	#$3D20, x_pos(A1)                                ; $0010
		move.w	#$0668, y_pos(A1)                                ; $0014
Offset_0x0128BE:
		addq.b	#$02, (Dynamic_Resize_Routine).w             ; $FFFFEE33
		rts
Offset_0x0128C4:
		move.l	#$00001000, D0
		move.l	D0, (Sonic_Level_Limits_Min_Y).w             ; $FFFFEE18
		move.l	D0, (Level_Limits_Min_Y).w                   ; $FFFFEE10
		move.w	#$6000, D0
		move.w	D0, (Sonic_Level_Limits_Max_X).w             ; $FFFFEE16
		move.w	D0, (Level_Limits_Max_X).w                   ; $FFFFEE0E
		subq.b	#$02, (Dynamic_Resize_Routine).w             ; $FFFFEE33
Offset_0x0128E2:
		rts     
;-------------------------------------------------------------------------------
Offset_0x0128E4:
		rts

; ===========================================================================
; Offset_0x0128E6:
DynResize_Null1:
		rts

;===============================================================================
DynResize_Iz_1:                                                ; Offset_0x0128E8
		moveq	#$00, D0
		move.b	(Dynamic_Resize_Routine).w, D0               ; $FFFFEE33
		move.w	Offset_0x0128F6(pc,d0.w), D0
		jmp	Offset_0x0128F6(pc,d0.w)    
;-------------------------------------------------------------------------------
Offset_0x0128F6:
		dc.w	Offset_0x0128FC-Offset_0x0128F6
		dc.w	Offset_0x012916-Offset_0x0128F6
		dc.w	Offset_0x012928-Offset_0x0128F6     
;-------------------------------------------------------------------------------
Offset_0x0128FC:
		cmpi.w	#$3700, (Camera_X).w                         ; $FFFFEE78
		bcs.s	Offset_0x012914
		cmpi.w	#$068C, (Camera_Y).w                         ; $FFFFEE7C
		bcs.s	Offset_0x012914
		st	(Level_Events_Buffer_5).w                    ; $FFFFEEC6
		addq.b	#$02, (Dynamic_Resize_Routine).w             ; $FFFFEE33
Offset_0x012914:
		rts     
;-------------------------------------------------------------------------------
Offset_0x012916:
		cmpi.w	#$3940, (Camera_X).w                         ; $FFFFEE78
		bcs.s	Offset_0x012926
		st	(Level_Events_Buffer_5).w                    ; $FFFFEEC6
		addq.b	#$02, (Dynamic_Resize_Routine).w             ; $FFFFEE33
Offset_0x012926:
		rts  
;-------------------------------------------------------------------------------
Offset_0x012928:
		rts

; ===========================================================================
; Offset_0x01292A:
DynResize_Null2:
		rts

; ===========================================================================
; Offset_0x01292C:
DynResize_LBz_2:
		moveq	#0,d0
		move.b	(Dynamic_Resize_Routine).w,d0
		move.w	DynResize_LBZ2_Index(pc,d0.w),d0
		jmp	DynResize_LBZ2_Index(pc,d0.w)  
; ===========================================================================
; Offset_0x01293A:
DynResize_LBZ2_Index:
		dc.w DynResize_LBZ2_LoadDeathEgg-DynResize_LBZ2_Index
		dc.w DynResize_LBZ2_End-DynResize_LBZ2_Index
; ===========================================================================
; Offset_0x01293E:
DynResize_LBZ2_LoadDeathEgg:
		cmpi.w	#$3BC0,(Camera_X).w
		bcs.s	Offset_0x012982
		cmpi.w	#$500,(Camera_Y).w
		; ??? missing branch here, meaning that the Y camera check is pointless
		;bcs.s	Offset_0x012982
		addq.b	#2,(Dynamic_Resize_Routine).w
		lea	(Launch_Base_2_Blocks_3).l,a1
		lea	(Blocks_Mem_Address).w,a2
		jsr	(Queue_Kos).l
		lea	(Launch_Base_2_Chunks_3).l,a1
		lea	(M68K_RAM_Start).l,a2
		jsr	(Queue_Kos).l
		lea	(Launch_Base_2_Tiles_3).l,a1
		move.w	#0,d2
		jsr	(Queue_Kos_Module).l

Offset_0x012982:
		rts
; ---------------------------------------------------------------------------
; Offset_0x012984:
DynResize_LBZ2_End:
		rts

; ===========================================================================
; Offset_0x012986:
DynResize_Null3:
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to resize maximum Y coordinates
; ---------------------------------------------------------------------------
; Offset_0x012988: Resize_Max_Y_From_X:
Resize_MaxYFromX:
		move.w	(Camera_X).w,d0

Offset_0x01298C:
		move.l	(a1)+,d1
		cmp.w	d1,d0
		bhi.s	Offset_0x01298C
                swap.w	d1
		tst.w	d1
		bpl.s	Offset_0x0129A0
		andi.w	#$7FFF,d1
		move.w	d1,(Sonic_Level_Limits_Max_Y).w

Offset_0x0129A0:
		move.w	d1,(Level_Limits_Max_Y).w
		move.w	d1,(Miles_Level_Limits_Max_Y).w
		rts
; End of function Resize_Max_Y_From_X