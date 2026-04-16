; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to setup level tile drawing routines
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; Offset_0x02F25C: Load_Tiles_From_Start:
Setup_TileDrawing:
		clr.b	(Background_Collision_Flag).w
		clr.l	(Plane_Double_Update_Flag).w
		clr.w	(Level_Repeat_Routine).w
		clr.l	(Level_Repeat_Offset).w
		clr.l	(Level_Events_Routine).w
		clr.l	(Foreground_Events_Y_Counter).w
		clr.w	(Earthquake_Flag).w
		clr.l	(Earthquake_Offset).w
		clr.l	(Background_Events).w
		clr.l	(Background_Events+4).w
		clr.l	(Background_Events+8).w
		clr.l	(Background_Events+$C).w
		move.w	#$FFF,(Screen_Wrap_Y).w
		move.w	#$FF0,(Level_Layout_Wrap_Y).w
		move.w	#$7C,(Level_Layout_Wrap_Row).w
		move.w	(Camera_X).w,(Screen_Pos_Buffer_X).w
		move.w	(Camera_Y).w,(Screen_Pos_Buffer_Y).w
		lea	(Plane_Buffer).w,a0
		lea	(Blocks_Mem_Address).w,a2
		lea	(Fg_Mem_Index_Address).w,a3
		move.w	#$C000,d7
		move.w	(Current_ZoneAndAct).w,d0
		ror.b	#2,d0
		lsr.w	#3,d0
		move.l	Load_Tiles_From_Start_Pointers(pc,d0.w),a1
		jsr	(a1)
		addq.w	#2,a3
		move.w	#$E000,d7
		move.w	(Current_ZoneAndAct).w,d0
		ror.b	#2,d0
		lsr.w	#3,d0
		move.l	Load_Tiles_From_Start_Pointers+4(pc,d0.w),a1
		jsr	(a1)
		move.w	(Screen_Pos_Buffer_Y).w,(Vertical_Scroll_Value).w
		move.w	(Screen_Pos_Buffer_Y_2).w,(Vertical_Scroll_Value_2).w
		rts
; End of function Setup_TileDrawing

; ---------------------------------------------------------------------------
; Subroutine to run level tile drawing routines
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; Offset_0x02F2EA: Background_Scroll_Layer:
Run_TileDrawing:
		move.w	(Camera_X).w,(Screen_Pos_Buffer_X).w
		move.w	(Camera_Y).w,(Screen_Pos_Buffer_Y).w
		lea	(Plane_Buffer).w,a0
		lea	(Blocks_Mem_Address).w,a2
		lea	(Fg_Mem_Index_Address).w,a3
		move.w	#$C000,d7
		move.w	(Current_ZoneAndAct).w,d0
		ror.b	#2,d0
		lsr.w	#3,d0
		move.l	Load_Tiles_As_You_Move_Pointers(pc,d0.w),a1
		jsr	(a1)
		addq.w	#2,a3
		move.w	#$E000,d7
		move.w	(Current_ZoneAndAct).w,d0
		ror.b	#2,d0
		lsr.w	#3,d0
		move.l	Load_Tiles_As_You_Move_Pointers+4(pc,d0.w),a1
		jsr	(a1)
		move.w	(Screen_Pos_Buffer_Y).w,(Vertical_Scroll_Value).w
		move.w	(Screen_Pos_Buffer_Y_2).w,(Vertical_Scroll_Value_2).w
		rts
; End of function Run_TileDrawing

; ---------------------------------------------------------------------------
; Offset_0x02F336:
Load_Tiles_From_Start_Pointers:
		dc.l	AIz_1_Events_Init
		dc.l	AIz_1_Events_Init_2
		dc.l	AIZ2_RefreshScreen
		dc.l	AIz_2_Events_Init_2
; Offset_0x02F346:
Load_Tiles_As_You_Move_Pointers:
		dc.l	AIz_1_Events_Run
		dc.l	AIz_1_Events_Run_2
		dc.l	AIZ2_RunScreen
		dc.l	AIz_2_Events_Run_2
;--------------
		dc.l	HCZ1_RefreshScreen
		dc.l	HCZ1_RefreshBackground
		dc.l	HCZ2_RefreshScreen
		dc.l	HCZ2_RefreshBackground
;--------------                 
		dc.l	HCZ1_RunScreen
		dc.l	HCZ1_RunBackground
		dc.l	HCZ2_RunScreen
		dc.l	HCZ2_RunBackground
;--------------                 
		dc.l	MGz_1_Events_Init                      ; Offset_0x031F18
		dc.l	MGz_1_Events_Init_2                    ; Offset_0x031F2C
		dc.l	MGz_2_Events_Init                      ; Offset_0x0320E2
		dc.l	MGz_2_Events_Init_2                    ; Offset_0x032732
;--------------                 
		dc.l	MGz_1_Events_Run                       ; Offset_0x031F20
		dc.l	MGz_1_Events_Run_2                     ; Offset_0x031F44
		dc.l	MGz_2_Events_Run                       ; Offset_0x0320F2
		dc.l	MGz_2_Events_Run_2                     ; Offset_0x0327DE
;--------------                  
		dc.l	CNz_1_Events_Init                      ; Offset_0x032BAE
		dc.l	CNz_1_Events_Init_2                    ; Offset_0x032C8A
		dc.l	CNz_2_Events_Init                      ; Offset_0x032BAE
		dc.l	CNz_2_Events_Init_2                    ; Offset_0x032C8A
;--------------                  
		dc.l	CNz_1_Events_Run                       ; Offset_0x032BB6
		dc.l	CNz_1_Events_Run_2                     ; Offset_0x032CA4
		dc.l	CNz_2_Events_Run                       ; Offset_0x032BB6
		dc.l	CNz_2_Events_Run_2                     ; Offset_0x032CA4
;--------------
		dc.l	Level_RefreshScreen	; FBZ1
		dc.l	Level_RefreshBackground
		dc.l	Level_RefreshScreen	; FBZ2
		dc.l	Level_RefreshBackground
;--------------
		dc.l	Level_RunScreen
		dc.l	Level_RunBackground	; FBZ1
		dc.l	Level_RunScreen
		dc.l	Level_RunBackground	; FBZ2
;--------------                 
		dc.l	Iz_1_Events_Init                       ; Offset_0x032D36
		dc.l	Iz_1_Events_Init_2                     ; Offset_0x032D86
		dc.l	Iz_2_Events_Init                       ; Offset_0x033138
		dc.l	Iz_2_Events_Init_2                     ; Offset_0x033144
;--------------                 
		dc.l	Iz_1_Events_Run                        ; Offset_0x032D50
		dc.l	Iz_1_Events_Run_2                      ; Offset_0x032E00
		dc.l	Iz_2_Events_Run                        ; Offset_0x033140
		dc.l	Iz_2_Events_Run_2                      ; Offset_0x0331AC
;--------------                
		dc.l	LBz_1_Events_Init                      ; Offset_0x033422
		dc.l	LBz_1_Events_Init_2                    ; Offset_0x033736
		dc.l	LBz_2_Events_Init                      ; Offset_0x033900
		dc.l	LBz_2_Events_Init_2                    ; Offset_0x03395A
;--------------                  
		dc.l	LBz_1_Events_Run                       ; Offset_0x03348A
		dc.l	LBZ1_RunBackground
		dc.l	LBz_2_Events_Run                       ; Offset_0x033910
		dc.l	LBz_2_Events_Run_2                     ; Offset_0x03397A
;--------------                 
		dc.l	MVz_1_Events_Init                      ; Offset_0x033C24
		dc.l	MVz_1_Events_Init_2                    ; Offset_0x033C30
		dc.l	MVz_2_Events_Init                      ; Offset_0x033C24
		dc.l	MVz_2_Events_Init_2                    ; Offset_0x033C30
;--------------                   
		dc.l	MVz_1_Events_Run                       ; Offset_0x033C2C
		dc.l	MVz_1_Events_Run_2                     ; Offset_0x033C42
		dc.l	MVz_2_Events_Run                       ; Offset_0x033C2C
		dc.l	MVz_2_Events_Run_2                     ; Offset_0x033C42
;--------------                   
		dc.l	Level_RefreshScreen
		dc.l	Level_RefreshBackground
		dc.l	Level_RefreshScreen
		dc.l	Level_RefreshBackground
;--------------                   
		dc.l	Level_RunScreen
		dc.l	Level_RunBackground
		dc.l	Level_RunScreen
		dc.l	Level_RunBackground
;--------------                  
		dc.l	LRz_1_Events_Init                      ; Offset_0x033C70
		dc.l	LRz_1_Events_Init_2                    ; Offset_0x033C84
		dc.l	LRz_2_Events_Init                      ; Offset_0x033C70
		dc.l	LRz_2_Events_Init_2                    ; Offset_0x033C84
;--------------                  
		dc.l	LRz_1_Events_Run                       ; Offset_0x033C78
		dc.l	LRz_1_Events_Run_2                     ; Offset_0x033CB0
		dc.l	LRz_2_Events_Run                       ; Offset_0x033C78
		dc.l	LRz_2_Events_Run_2                     ; Offset_0x033CB0
;--------------                  
		dc.l	Level_RefreshScreen
		dc.l	Level_RefreshBackground
		dc.l	Level_RefreshScreen
		dc.l	Level_RefreshBackground
;--------------                   
		dc.l	Level_RunScreen
		dc.l	Level_RunBackground
		dc.l	Level_RunScreen
		dc.l	Level_RunBackground
;--------------                   
		dc.l	Level_RefreshScreen
		dc.l	Level_RefreshBackground
		dc.l	Level_RefreshScreen
		dc.l	Level_RefreshBackground
;--------------                  
		dc.l	Level_RunScreen
		dc.l	Level_RunBackground
		dc.l	Level_RunScreen
		dc.l	Level_RunBackground
;--------------                 
		dc.l	Level_RefreshScreen
		dc.l	Level_RefreshBackground
		dc.l	Level_RefreshScreen
		dc.l	Level_RefreshBackground
;--------------                   
		dc.l	Level_RunScreen
		dc.l	Level_RunBackground
		dc.l	Level_RunScreen
		dc.l	Level_RunBackground
;--------------                   
		dc.l	Level_RefreshScreen
		dc.l	Level_RefreshBackground
		dc.l	Level_RefreshScreen
		dc.l	Level_RefreshBackground
;--------------                    
		dc.l	Level_RunScreen
		dc.l	Level_RunBackground
		dc.l	Level_RunScreen
		dc.l	Level_RunBackground
;--------------                    
		dc.l	ALz_Events_Init                        ; Offset_0x033D60
		dc.l	ALz_Events_Init_2                      ; Offset_0x033DF0
		dc.l	ALz_Events_Init                        ; Offset_0x033D60
		dc.l	ALz_Events_Init_2                      ; Offset_0x033DF0
;--------------                  
		dc.l	ALz_Events_Run                         ; Offset_0x033DAE
		dc.l	ALz_Events_Run_2                       ; Offset_0x033E66
		dc.l	ALz_Events_Run                         ; Offset_0x033DAE
		dc.l	ALz_Events_Run_2                       ; Offset_0x033E66
;--------------                  
		dc.l	BPz_Events_Init                        ; Offset_0x033D60
		dc.l	BPz_Events_Init_2                      ; Offset_0x033DF6
		dc.l	BPz_Events_Init                        ; Offset_0x033D60
		dc.l	BPz_Events_Init_2                      ; Offset_0x033DF6 
;--------------                 
		dc.l	BPz_Events_Run                         ; Offset_0x033DAE
		dc.l	BPz_Events_Run_2                       ; Offset_0x033E70
		dc.l	BPz_Events_Run                         ; Offset_0x033DAE
		dc.l	BPz_Events_Run_2                       ; Offset_0x033E70  
;--------------                  
		dc.l	DPz_Events_Init                        ; Offset_0x033D60
		dc.l	DPz_Events_Init_2                      ; Offset_0x033DFC
		dc.l	DPz_Events_Init                        ; Offset_0x033D60
		dc.l	DPz_Events_Init_2                      ; Offset_0x033DFC 
;--------------                 
		dc.l	DPz_Events_Run                         ; Offset_0x033DAE
		dc.l	DPz_Events_Run_2                       ; Offset_0x033EBE
		dc.l	DPz_Events_Run                         ; Offset_0x033DAE
		dc.l	DPz_Events_Run_2                       ; Offset_0x033EBE  
;--------------                  
		dc.l	CGz_Events_Init                        ; Offset_0x033D60
		dc.l	CGz_Events_Init_2                      ; Offset_0x033E02
		dc.l	CGz_Events_Init                        ; Offset_0x033D60
		dc.l	CGz_Events_Init_2                      ; Offset_0x033E02 
;--------------                  
		dc.l	CGz_Events_Run                         ; Offset_0x033DD0
		dc.l	CGz_Events_Run_2                       ; Offset_0x033E7A
		dc.l	CGz_Events_Run                         ; Offset_0x033DD0
		dc.l	CGz_Events_Run_2                       ; Offset_0x033E7A 
;--------------                   
		dc.l	EMz_Events_Init                        ; Offset_0x033D60
		dc.l	EMz_Events_Init_2                      ; Offset_0x033E3E
		dc.l	EMz_Events_Init                        ; Offset_0x033D60
		dc.l	EMz_Events_Init_2                      ; Offset_0x033E3E 
;--------------                
		dc.l	EMz_Events_Run                         ; Offset_0x033DAE
		dc.l	EMz_Events_Run_2                       ; Offset_0x033E84
		dc.l	EMz_Events_Run                         ; Offset_0x033DAE
		dc.l	EMz_Events_Run_2                       ; Offset_0x033E84 
;--------------                
		dc.l	Level_RefreshScreen
		dc.l	Level_RefreshBackground
		dc.l	Level_RefreshScreen
		dc.l	Level_RefreshBackground
;--------------                
		dc.l	Level_RunScreen
		dc.l	Level_RunBackground
		dc.l	Level_RunScreen
		dc.l	Level_RunBackground
;--------------                  
		dc.l	Level_RefreshScreen
		dc.l	Level_RefreshBackground
		dc.l	Level_RefreshScreen
		dc.l	Level_RefreshBackground
;--------------                   
		dc.l	Level_RunScreen
		dc.l	Level_RunBackground
		dc.l	Level_RunScreen
		dc.l	Level_RunBackground
;--------------                   
		dc.l	Level_RefreshScreen
		dc.l	Level_RefreshBackground
		dc.l	Level_RefreshScreen
		dc.l	Level_RefreshBackground
;--------------                 
		dc.l	Level_RunScreen
		dc.l	Level_RunBackground
		dc.l	Level_RunScreen
		dc.l	Level_RunBackground
;--------------                 
		dc.l	Level_RefreshScreen
		dc.l	Level_RefreshBackground
		dc.l	Level_RefreshScreen
		dc.l	Level_RefreshBackground
;--------------                 
		dc.l	Level_RunScreen
		dc.l	Level_RunBackground
		dc.l	Level_RunScreen
		dc.l	Level_RunBackground
;--------------                 
		dc.l	Level_RefreshScreen
		dc.l	Level_RefreshBackground
		dc.l	Level_RefreshScreen
		dc.l	Level_RefreshBackground
;--------------                 
		dc.l	Level_RunScreen
		dc.l	Level_RunBackground
		dc.l	Level_RunScreen
		dc.l	Level_RunBackground

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to draw level tiles in normal gameplay
; ---------------------------------------------------------------------------
; Offset_0x02F636: Vint_Draw_Level:
DrawLevel:
		lea	(VDP_Data_Port).l,a6
		lea	(Plane_Buffer).w,a0

Offset_0x02F640:
		move.w	(a0),d0			; have we finished drawing the screen?
		beq.s	DrawLevel_Done		; if yes, branch
		clr.w	(a0)+
		move.w	(a0)+,d1		; are we moving left/right?
		bmi.s	DrawLevel_Column	; if yes, branch
; DrawLevel_Row:
		move.w	#$8F02,d2		; VRAM increment at 2 bytes (horizontal level write)
		move.w	#$80,d3
		bra.s	DrawLevel_Draw
; ---------------------------------------------------------------------------
; Offset_0x02F654:
DrawLevel_Column:
		move.w	#$8F80,d2		; VRAM increment at $80 bytes (vertical level write)
		moveq	#2,d3
		andi.w	#$7FFF,d1
; Offset_0x02F65E:
DrawLevel_Draw:
		move.w	d2,VDP_Control_Port-VDP_Data_Port(a6)
		move.w	d0,d2
		move.w	d1,d4
		bsr.s	WriteToVRAM
		move.w	d2,d0
		add.w	d3,d0
		move.w	d4,d1
		bsr.s	WriteToVRAM
		bra.s	Offset_0x02F640
; ---------------------------------------------------------------------------
; Offset_0x02F672:
DrawLevel_Done:
		move.w	#$8F02,VDP_Control_Port-VDP_Data_Port(a6)
		rts
; End of function DrawLevel

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to write data to VRAM
; ---------------------------------------------------------------------------
; Offset_0x02F67A: Special_Vint_VRAM_Write:
WriteToVRAM:
		swap.w	d0
		clr.w	d0
		swap.w	d0
		lsl.l	#2,d0
		lsr.w	#2,d0
		ori.w	#$4000,d0
		swap.w	d0
		move.l	d0,VDP_Control_Port-VDP_Data_Port(a6)
; Offset_0x02F68E:
.copyToVRAM:
		move.l	(a0)+,(a6)
		dbf	d1,.copyToVRAM
		rts
; End of function WriteToVRAM

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to draw level tiles in Competition Mode
; ---------------------------------------------------------------------------
; Offset_0x02F696:
DrawLevel_Competition:
		lea	(VDP_Data_Port).l,a6
		lea	(Plane_Buffer).w,a0

Offset_0x02F6A0:
		move.w	(a0),d0			; have we finished drawing the screen?
		beq.s	DrawLevelC_Done		; if yes, branch
		clr.w	(a0)+
		move.w	(a0)+,d1
		move.w	d0,d2
		move.w	d1,d4
		bsr.s	WriteToVRAM
		move.w	d2,d0
		add.w	(VRAM_Add).w,d0
		move.w	d4,d1
		bsr.s	WriteToVRAM
		bra.s	Offset_0x02F6A0
; ---------------------------------------------------------------------------
; Offset_0x02F6BA:
DrawLevelC_Done:
		rts
; End of function DrawLevel_Competition

;===============================================================================
Special_Vint:                                                  ; Offset_0x02F6BC  
		lea	(VDP_Data_Port), A6                          ; $00C00000
		move.w	(Special_Vint_Routine).w, D0                 ; $FFFFEEA6
		jmp	Special_Vint_Index(pc,d0.w)             ; Offset_0x02F6CA
Special_Vint_Index:                                            ; Offset_0x02F6CA
		rts
		bra.s	Special_Vint_VScroll_On                ; Offset_0x02F6DC
		bra.s	Special_Vint_VScroll_Copy              ; Offset_0x02F6E6    
;-------------------------------------------------------------------------------
; Special_Vint_VScroll_Off:                                    ; Offset_0x02F6D0
		move.w	#$8B03, $0004(A6)
		clr.w	(Special_Vint_Routine).w                     ; $FFFFEEA6
		rts                           
;-------------------------------------------------------------------------------
Special_Vint_VScroll_On:                                       ; Offset_0x02F6DC
		move.w	#$8B07, $0004(A6)
		addq.w	#$02, (Special_Vint_Routine).w               ; $FFFFEEA6
;-------------------------------------------------------------------------------                
Special_Vint_VScroll_Copy:                                     ; Offset_0x02F6E6                
		lea	(Vertical_Scroll_Buffer).w, A0               ; $FFFFEEEA
		move.l	#$40000010, $0004(A6)
		moveq	#$13, D0
Special_Vint_VScroll_Copy_Loop:                                ; Offset_0x02F6F4
		move.l	(A0)+, (A6)
		dbf	D0, Special_Vint_VScroll_Copy_Loop     ; Offset_0x02F6F4
		rts 
;=============================================================================== 

; Offset_0x02F6FC: Draw_Tile_Column:
DrawBlockColumn:
		move.w	(A6), D0
		andi.w	#$FFF0, D0
		move.w	(A5), D2
		move.w	D0, (A5)
		move.w	D2, D3
		sub.w	D0, D2
		beq.w	Offset_0x02F888
		tst.b	D2
		bpl.s	Offset_0x02F71A
                neg.w   D2
		move.w	D3, D0
		addi.w	#$0150, D0
Offset_0x02F71A:
		andi.w	#$0030, D2
		cmpi.w	#$0010, D2
                sne     (Plane_Double_Update_Flag).w                 ; $FFFFEEA4
		movem.w	D1/D6, -(A7)
		bsr.s	Setup_Tile_Column_Drawn                ; Offset_0x02F780
		movem.w	(A7)+, D1/D6
		tst.b	(Plane_Double_Update_Flag).w                 ; $FFFFEEA4
		beq.w	Offset_0x02F888
		addi.w	#$0010, D0
		bra.s	Setup_Tile_Column_Drawn                ; Offset_0x02F780
;-------------------------------------------------------------------------------   
Draw_Tile_Column_2:                                            ; Offset_0x02F73E
		move.w	(A6), D0
		andi.w	#$FFF0, D0
		move.w	(A5), D2
		move.w	D0, (A5)
		move.w	D2, D3
		sub.w	D0, D2
		beq.w	Offset_0x02F888
		tst.b	D2
		bpl.s	Offset_0x02F75E
                neg.w   D2
		move.w	D3, D0
		addi.w	#$0150, D0
                swap.w  D1
Offset_0x02F75E:
		andi.w	#$0030, D2
		cmpi.w	#$0010, D2
                sne     (Plane_Double_Update_Flag).w                 ; $FFFFEEA4
		movem.w	D1/D6, -(A7)
		bsr.s	Setup_Tile_Column_Drawn                ; Offset_0x02F780
		movem.w	(A7)+, D1/D6
		tst.b	(Plane_Double_Update_Flag).w                 ; $FFFFEEA4
		beq.w	Offset_0x02F888
		addi.w	#$0010, D0
Setup_Tile_Column_Drawn:                                       ; Offset_0x02F780
		move.w	D1, D2
		andi.w	#$0070, D2
		move.w	D1, D3
		lsl.w	#$04, D3
		andi.w	#$0F00, D3
		asr.w	#$04, D1
		move.w	D1, D4
		asr.w	#$01, D1
		and.w	(Level_Layout_Wrap_Row).w, D1                ; $FFFFEEAE
		andi.w	#$000F, D4
		moveq	#$10, D5
		sub.w	D4, D5
		move.w	D5, D4
		sub.w	D6, D5
		bmi.s	Offset_0x02F7CE
		move.w	D0, D5
		asr.w	#$02, D5
		andi.w	#$007C, D5
		add.w	D7, D5
		add.w	D3, D5
		move.w	D5, (A0)+
		move.w	D6, D5
		subq.w	#$01, D6
		move.w	D6, (A0)+
		bset	#$07, -2(A0)
		lea	(A0), A1
		add.w	D5, D5
		add.w	D5, D5
		adda.w	D5, A0
		jsr	Get_Level_Chunk_Column(PC)             ; Offset_0x02F88A
		bra.s	Offset_0x02F81C
Offset_0x02F7CE:
                neg.w   D5
		move.w	D5, -(A7)
		move.w	D0, D5
		asr.w	#$02, D5
		andi.w	#$007C, D5
		add.w	D7, D5
		add.w	D3, D5
		move.w	D5, (A0)+
		move.w	D4, D6
		subq.w	#$01, D6
		move.w	D6, (A0)+
		bset	#$07, -2(A0)
		lea	(A0), A1
		add.w	D4, D4
		add.w	D4, D4
		adda.w	D4, A0
		jsr	Get_Level_Chunk_Column(PC)             ; Offset_0x02F88A
		bsr.s	Offset_0x02F81C
		move.w	(A7)+, D6
		move.w	D0, D5
		asr.w	#$02, D5
		andi.w	#$007C, D5
		add.w	D7, D5
		move.w	D5, (A0)+
		move.w	D6, D5
		subq.w	#$01, D6
		move.w	D6, (A0)+
		bset	#$07, -2(A0)
		lea	(A0), A1
		add.w	D5, D5
		add.w	D5, D5
		adda.w	D5, A0
Offset_0x02F81C:
                swap.w  D7
Offset_0x02F81E:
		move.w	$00(A5, D2), D3
		move.w	D3, D4
		andi.w	#$03FF, D3
		lsl.w	#$03, D3
		move.w	$00(A2, D3), D5
                swap.w  D5
		move.w	$04(A2, D3), D5
		move.w	$06(A2, D3), D7
		move.w	$02(A2, D3), D3
                swap.w  D3
		move.w	D7, D3
		btst	#$0B, D4
		beq.s	Offset_0x02F856
		eori.l	#$10001000, D5
		eori.l	#$10001000, D3
                swap.w  D5
                swap.w  D3
Offset_0x02F856:
		btst	#$0A, D4
		beq.s	Offset_0x02F86A
		eori.l	#$08000800, D5
		eori.l	#$08000800, D3
		exg.l	D3, D5
Offset_0x02F86A:
		move.l	D5, (A1)+
		move.l	D3, (A0)+
		addi.w	#$0010, D2
		andi.w	#$0070, D2
		bne.s	Offset_0x02F880
		addq.w	#$04, D1
		and.w	(Level_Layout_Wrap_Row).w, D1                ; $FFFFEEAE
		bsr.s	Get_Level_Chunk_Column                 ; Offset_0x02F88A
Offset_0x02F880:
		dbf	D6, Offset_0x02F81E
                swap.w  D7
		clr.w	(A0)
Offset_0x02F888:
		rts
;-------------------------------------------------------------------------------                
Get_Level_Chunk_Column:                                        ; Offset_0x02F88A
		move.w	$00(A3, D1), A4
		move.w	D0, D3
		asr.w	#$07, D3
		adda.w	D3, A4
		moveq	#-$01, D3
		clr.w	D3
		move.b	(A4), D3
		lsl.w	#$07, D3
		move.w	D0, D4
		asr.w	#$03, D4
		andi.w	#$000E, D4
		add.w	D4, D3
		move.l	D3, A5
		rts   
;-------------------------------------------------------------------------------    

; Offset_0x02F8AA: Draw_Tile_Row:
DrawBlockRow:
		move.w	(A6), D0
		and.w	(Level_Layout_Wrap_Y).w, D0                  ; $FFFFEEAC
		move.w	(A5), D2
		move.w	D0, (A5)
		move.w	D2, D3
		sub.w	D0, D2
		beq.w	Offset_0x02FA18
		tst.b	D2
		bpl.s	Offset_0x02F8CC
                neg.w   D2
		move.w	D3, D0
		addi.w	#$00F0, D0
		and.w	(Level_Layout_Wrap_Y).w, D0                  ; $FFFFEEAC
Offset_0x02F8CC:
		andi.w	#$0030, D2
		cmpi.w	#$0010, D2
                sne     (Plane_Double_Update_Flag).w                 ; $FFFFEEA4
		movem.w	D1/D6, -(A7)
		bsr.s	Setup_Tile_Row_Draw                    ; Offset_0x02F93E
		movem.w	(A7)+, D1/D6
		tst.b	(Plane_Double_Update_Flag).w                 ; $FFFFEEA4
		beq.w	Offset_0x02FA18
		addi.w	#$0010, D0
		and.w	(Level_Layout_Wrap_Y).w, D0                  ; $FFFFEEAC
		bra.s	Setup_Tile_Row_Draw                    ; Offset_0x02F93E   
;-------------------------------------------------------------------------------
Draw_Tile_Row_2:                                               ; Offset_0x02F8F4
		move.w	(A6), D0
		and.w	(Level_Layout_Wrap_Y).w, D0                  ; $FFFFEEAC
		move.w	(A5), D2
		move.w	D0, (A5)
		move.w	D2, D3
		sub.w	D0, D2
		beq.w	Offset_0x02FA18
		tst.b	D2
		bpl.s	Offset_0x02F918
                neg.w   D2
		move.w	D3, D0
		addi.w	#$00F0, D0
		and.w	(Level_Layout_Wrap_Y).w, D0                  ; $FFFFEEAC
                swap.w  D1
Offset_0x02F918:
		andi.w	#$0030, D2
		cmpi.w	#$0010, D2
                sne     (Plane_Double_Update_Flag).w                 ; $FFFFEEA4
		movem.w	D1/D6, -(A7)
		bsr.s	Setup_Tile_Row_Draw                    ; Offset_0x02F93E
		movem.w	(A7)+, D1/D6
		tst.b	(Plane_Double_Update_Flag).w                 ; $FFFFEEA4
		beq.w	Offset_0x02FA18
		addi.w	#$0010, D0
		and.w	(Level_Layout_Wrap_Y).w, D0                  ; $FFFFEEAC
;-------------------------------------------------------------------------------
Setup_Tile_Row_Draw:                                           ; Offset_0x02F93E
		asr.w	#$04, D1
		move.w	D1, D2
		move.w	D1, D4
		asr.w	#$03, D1
		add.w	D2, D2
		move.w	D2, D3
		andi.w	#$000E, D2
		add.w	D3, D3
		andi.w	#$007C, D3
		andi.w	#$001F, D4
		moveq	#$20, D5
		sub.w	D4, D5
		move.w	D5, D4
		sub.w	D6, D5
		bmi.s	Offset_0x02F984
		move.w	D0, D5
		andi.w	#$00F0, D5
		lsl.w	#$04, D5
		add.w	D7, D5
		add.w	D3, D5
		move.w	D5, (A0)+
		move.w	D6, D5
		subq.w	#$01, D6
		move.w	D6, (A0)+
		lea	(A0), A1
		add.w	D5, D5
		add.w	D5, D5
		adda.w	D5, A0
		jsr	Get_Chunk_Addr(PC)                     ; Offset_0x02FA1A
		bra.s	Offset_0x02F9C4
Offset_0x02F984:
                neg.w   D5
		move.w	D5, -(A7)
		move.w	D0, D5
		andi.w	#$00F0, D5
		lsl.w	#$04, D5
		add.w	D7, D5
		add.w	D3, D5
		move.w	D5, (A0)+
		move.w	D4, D6
		subq.w	#$01, D6
		move.w	D6, (A0)+
		lea	(A0), A1
		add.w	D4, D4
		add.w	D4, D4
		adda.w	D4, A0
		bsr.s	Get_Chunk_Addr                         ; Offset_0x02FA1A
		bsr.s	Offset_0x02F9C4
		move.w	(A7)+, D6
		move.w	D0, D5
		andi.w	#$00F0, D5
		lsl.w	#$04, D5
		add.w	D7, D5
		move.w	D5, (A0)+
		move.w	D6, D5
		subq.w	#$01, D6
		move.w	D6, (A0)+
		lea	(A0), A1
		add.w	D5, D5
		add.w	D5, D5
		adda.w	D5, A0
Offset_0x02F9C4:
		move.w	$00(A5, D2), D3
		move.w	D3, D4
		andi.w	#$03FF, D3
		lsl.w	#$03, D3
		move.l	$00(A2, D3), D5
		move.l	$04(A2, D3), D3
		btst	#$0B, D4
		beq.s	Offset_0x02F9EC
		eori.l	#$10001000, D5
		eori.l	#$10001000, D3
		exg.l	D3, D5
Offset_0x02F9EC:
		btst	#$0A, D4
		beq.s	Offset_0x02FA02
		eori.l	#$08000800, D5
		eori.l	#$08000800, D3
                swap.w  D5
                swap.w  D3
Offset_0x02FA02:
		move.l	D5, (A1)+
		move.l	D3, (A0)+
		addq.w	#$02, D2
		andi.w	#$000E, D2
		bne.s	Offset_0x02FA12
		addq.w	#$01, D1
		bsr.s	Offset_0x02FA26
Offset_0x02FA12:
		dbf	D6, Offset_0x02F9C4
		clr.w	(A0)
Offset_0x02FA18:                
		rts
;-------------------------------------------------------------------------------                
Get_Chunk_Addr:                                                ; Offset_0x02FA1A
		move.w	D0, D3
		asr.w	#$05, D3
		and.w	(Level_Layout_Wrap_Row).w, D3                ; $FFFFEEAE
		move.w	$00(A3, D3), A4
Offset_0x02FA26:
		moveq	#-$01, D3
		clr.w	D3
		move.b	$00(A4, D1), D3
		lsl.w	#$07, D3
		move.w	D0, D4
		andi.w	#$0070, D4
		add.w	D4, D3
		move.l	D3, A5
		rts
;-------------------------------------------------------------------------------
Offset_0x02FA3C:
		asr.w	#$03, D1
		move.w	D1, D2
		asr.w	#$04, D1
		andi.w	#$000E, D2
		cmpi.w	#$0100, (VRAM_Add).w                         ; $FFFFEEB0
		beq.s	Offset_0x02FA56
		moveq	#$04, D3
		move.w	#$1F80, D4
		bra.s	Offset_0x02FA5C
Offset_0x02FA56:
		moveq	#$05, D3
		move.w	#$1F00, D4
Offset_0x02FA5C:
		move.w	D0, D5
		lsl.w	D3, D5
		and.w	D4, D5
		add.w	D7, D5
		move.w	D5, (A0)+
		move.w	D6, D5
		subq.w	#$01, D6
		move.w	D6, (A0)+
		lea	(A0), A1
		add.w	D5, D5
		add.w	D5, D5
		adda.w	D5, A0
		jsr	Get_Chunk_Addr(PC)                     ; Offset_0x02FA1A
		bra.w	Offset_0x02F9C4 
;-------------------------------------------------------------------------------
Refresh_Plane_Full:                                            ; Offset_0x02FA7C
		moveq	#$0F, D2
Offset_0x02FA7E:
		movem.l	D0-D2/A0, -(A7)
		moveq	#$20, D6
		jsr	Setup_Tile_Row_Draw(PC)                ; Offset_0x02F93E
		jsr	DrawLevel(PC)                    ; Offset_0x02F636
		movem.l	(A7)+, D0-D2/A0
		addi.w	#$0010, D0
		dbf	D2, Offset_0x02FA7E
		rts   
;-------------------------------------------------------------------------------
Refresh_Plane_Tile_Deform:                                     ; Offset_0x02FA9A
		move.w	(A4)+, D2
		moveq	#$0F, D3
Offset_0x02FA9E:
		cmp.w	D2, D0
		bmi.s	Offset_0x02FAA8
		add.w	(A4)+, D2
		addq.w	#$04, A5
		bra.s	Offset_0x02FA9E
Offset_0x02FAA8:
		move.w	(A5), D1
		moveq	#$20, D6
		movem.l	D0/D2/D3/A0/A4/A5, -(A7)
		jsr	Setup_Tile_Row_Draw(PC)                ; Offset_0x02F93E
		jsr	DrawLevel(PC)                    ; Offset_0x02F636
		movem.l	(A7)+, D0/D2/D3/A0/A4/A5
		addi.w	#$0010, D0
		dbf	D3, Offset_0x02FA9E
		rts   
;-------------------------------------------------------------------------------
Offset_0x02FAC6:
		movem.l	D0-D2/D6/A0, -(A7)
		jsr	Offset_0x02FA3C(PC)
		jsr	DrawLevel_Competition(PC)
		movem.l	(A7)+, D0-D2/D6/A0
		addi.w	#$0010, D0
		dbf	D2, Offset_0x02FAC6
		rts                 
;-------------------------------------------------------------------------------             
Refresh_Plane_Screen_Direct:                                   ; Offset_0x02FAE0
		move	#$2700, SR
		move.w	(Screen_Pos_Buffer_Y).w, D0                  ; $FFFFEE84
		move.w	(Screen_Pos_Buffer_X).w, D1                  ; $FFFFEE80
		moveq	#$0E, D2
Offset_0x02FAEE:
		movem.l	D0-D2/A0, -(A7)
		moveq	#$15, D6
		jsr	Setup_Tile_Row_Draw(PC)                ; Offset_0x02F93E
		jsr	DrawLevel(PC)                    ; Offset_0x02F636
		movem.l	(A7)+, D0-D2/A0
		addi.w	#$0010, D0
		dbf	D2, Offset_0x02FAEE
		move	#$2300, SR
		rts

; ---------------------------------------------------------------------------
; Subroutine to load foreground tiles as the player moves
; ---------------------------------------------------------------------------
; Offset_0x02FB0E: LoadTilesAsYouMove:
LoadTilesAsYouMove_Foreground:
		lea	(Screen_Pos_Buffer_X).w,a6
		lea	(Screen_Pos_Rounded_X).w,a5
		move.w	(Screen_Pos_Buffer_Y).w,d1
		moveq	#$F,d6
		jsr	DrawBlockColumn(pc)
		lea	(Screen_Pos_Buffer_Y).w,a6
		lea	(Screen_Pos_Rounded_Y).w,a5
		move.w	(Screen_Pos_Buffer_X).w,d1
		moveq	#$15,d6
		jmp	DrawBlockRow(pc)

; ---------------------------------------------------------------------------
; Subroutine to load background tiles as the player moves
; ---------------------------------------------------------------------------
; Offset_0x02FB32: Load_Tiles_As_You_Move_2:
LoadTilesAsYouMove_Background:
		lea	(Screen_Pos_Buffer_X_2).w,a6
		lea	(Screen_Pos_Rounded_X_2).w,a5
		move.w	(Screen_Pos_Buffer_Y_2).w,d1
		moveq	#$F,d6
		jsr	DrawBlockColumn(pc)
		lea	(Screen_Pos_Buffer_Y_2).w,a6
		lea	(Screen_Pos_Rounded_Y_2).w,a5
		move.w	(Screen_Pos_Buffer_X_2).w,d1
		moveq	#$15,d6
		jmp	DrawBlockRow(pc)

;-------------------------------------------------------------------------------  
; Offset_0x02FB56:
		movem.l	D5/A4/A5, -(A7)
		lea	(Screen_Pos_Buffer_Y).w, A6                  ; $FFFFEE84
		jsr	Get_Deform_Draw_Position_Vertical(PC)  ; Offset_0x02FBF4
		lea	(Screen_Pos_Rounded_Y).w, A5                 ; $FFFFEE8A
		jsr	Draw_Tile_Row_2(PC)                    ; Offset_0x02F8F4
		movem.l	(A7)+, D5/A4/A6
		move.w	(Screen_Pos_Rounded_Y).w, D6                 ; $FFFFEE8A
		bra.s	Draw_Background_D6                     ; Offset_0x02FB90                              
;------------------------------------------------------------------------------- 
Draw_Background:                                               ; Offset_0x02FB74
		movem.l	D5/A4/A5, -(A7)
		lea	(Screen_Pos_Buffer_Y_2).w, A6                ; $FFFFEE90
		jsr	Get_Deform_Draw_Position_Vertical(PC)  ; Offset_0x02FBF4
		lea	(Screen_Pos_Rounded_Y_2).w, A5               ; $FFFFEE96
		jsr	Draw_Tile_Row_2(PC)                    ; Offset_0x02F8F4
		movem.l	(A7)+, D5/A4/A6
		move.w	(Screen_Pos_Rounded_Y_2).w, D6               ; $FFFFEE96
Draw_Background_D6:                                            ; Offset_0x02FB90
		move.w	D6, D1
Offset_0x02FB92:
		sub.w	(A4)+, D6
		bmi.s	Offset_0x02FBA2
		move.w	(A6)+, D0
		andi.w	#$FFF0, D0
		move.w	D0, (A6)+
		subq.w	#$01, D5
		bra.s	Offset_0x02FB92
Offset_0x02FBA2:
                neg.w   D6
		lsr.w	#$04, D6
		moveq	#$0F, D4
		sub.w	D6, D4
		bcc.s	Offset_0x02FBB0
		moveq	#$00, D4
		moveq	#$0F, D6
Offset_0x02FBB0:
		movem.w	D1/D4-D6, -(A7)
		movem.l	A4/A6, -(A7)
		lea	$0002(A6), A5
		jsr	DrawBlockColumn(PC)                   ; Offset_0x02F6FC
		movem.l	(A7)+, A4/A6
		movem.w	(A7)+, D1/D4-D6
		addq.w	#$04, A6
		tst.w	D4
		beq.s	Offset_0x02FBE4
		lsl.w	#$04, D6
		add.w	D6, D1
		subq.w	#$01, D5
		move.w	(A4)+, D6
		lsr.w	#$04, D6
		move.w	D4, D0
		sub.w	D6, D4
		bpl.s	Offset_0x02FBB0
		move.w	D0, D6
		moveq	#$00, D4
		bra.s	Offset_0x02FBB0
Offset_0x02FBE4:
		subq.w	#$01, D5
		beq.s	Offset_0x02FBF2
		move.w	(A6)+, D0
		andi.w	#$FFF0, D0
		move.w	D0, (A6)+
		bra.s	Offset_0x02FBE4
Offset_0x02FBF2:
		rts
;-------------------------------------------------------------------------------
Get_Deform_Draw_Position_Vertical:                             ; Offset_0x02FBF4
		move.w	(A4)+, D2
		move.w	(A6), D0
		bsr.s	Offset_0x02FBFE
		addi.w	#$00E0, D0
Offset_0x02FBFE:
		cmp.w	D2, D0
		bmi.s	Offset_0x02FC08
		add.w	(A4)+, D2
		addq.w	#$04, A5
		bra.s	Offset_0x02FBFE
Offset_0x02FC08:
		move.w	(A5), D1
                swap.w  D1
		rts
;-------------------------------------------------------------------------------
Draw_Tiles_Vertical:                                           ; Offset_0x02FC0E
		movem.l	D5/A4/A5, -(A7)
		lea	(Screen_Pos_Buffer_X).w, A6                  ; $FFFFEE80
		jsr	Get_X_Deform_Range(PC)                 ; Offset_0x02FCAC
		lea	(Screen_Pos_Rounded_X).w, A5                 ; $FFFFEE88
		jsr	Draw_Tile_Column_2(PC)                 ; Offset_0x02F73E
		movem.l	(A7)+, D5/A4/A6
		move.w	(Screen_Pos_Rounded_X).w, D6                 ; $FFFFEE88
		bra.s	Offset_0x02FC48       
;-------------------------------------------------------------------------------
Draw_Tiles_Vertical_2:                                         ; Offset_0x02FC2C:
		movem.l	D5/A4/A5, -(A7)
		lea	(Screen_Pos_Buffer_X_2).w, A6                ; $FFFFEE8C
		jsr	Get_X_Deform_Range(PC)                 ; Offset_0x02FCAC
		lea	(Screen_Pos_Rounded_X_2).w, A5               ; $FFFFEE94
		jsr	Draw_Tile_Column_2(PC)                 ; Offset_0x02F73E
		movem.l	(A7)+, D5/A4/A6
		move.w	(Screen_Pos_Rounded_X_2).w, D6               ; $FFFFEE94
Offset_0x02FC48:                
		move.w	D6, D1
Offset_0x02FC4A:
		sub.w	(A4)+, D6
		bcs.s	Offset_0x02FC5A
		move.w	(A6)+, D0
		and.w	(Level_Layout_Wrap_Y).w, D0                  ; $FFFFEEAC
		move.w	D0, (A6)+
		subq.w	#$01, D5
		bra.s	Offset_0x02FC4A
Offset_0x02FC5A:
                neg.w   D6
		lsr.w	#$04, D6
		moveq	#$15, D4
		sub.w	D6, D4
		bcc.s	Offset_0x02FC68
		moveq	#$00, D4
		moveq	#$15, D6
Offset_0x02FC68:
		movem.w	D1/D4-D6, -(A7)
		movem.l	A4/A6, -(A7)
		lea	$0002(A6), A5
		jsr	DrawBlockRow(PC)                      ; Offset_0x02F8AA
		movem.l	(A7)+, A4/A6
		movem.w	(A7)+, D1/D4-D6
		addq.w	#$04, A6
		tst.w	D4
		beq.s	Offset_0x02FC9C
		lsl.w	#$04, D6
		add.w	D6, D1
		subq.w	#$01, D5
		move.w	(A4)+, D6
		lsr.w	#$04, D6
		move.w	D4, D0
		sub.w	D6, D4
		bcc.s	Offset_0x02FC68
		move.w	D0, D6
		moveq	#$00, D4
		bra.s	Offset_0x02FC68
Offset_0x02FC9C:
		subq.w	#$01, D5
		beq.s	Offset_0x02FCAA
		move.w	(A6)+, D0
		and.w	(Level_Layout_Wrap_Y).w, D0                  ; $FFFFEEAC
		move.w	D0, (A6)+
		bra.s	Offset_0x02FC9C
Offset_0x02FCAA:
		rts          
;-------------------------------------------------------------------------------  
Get_X_Deform_Range:                                            ; Offset_0x02FCAC
		move.w	(A4)+, D2
		move.w	(A6), D0
		bsr.s	Offset_0x02FCB6
		addi.w	#$0140, D0
Offset_0x02FCB6:
		cmp.w	D2, D0
		bcs.s	Offset_0x02FCC0
		add.w	(A4)+, D2
		addq.w	#$04, A5
		bra.s	Offset_0x02FCB6
Offset_0x02FCC0:
		move.w	(A5), D1
                swap.w  D1
		rts
;-------------------------------------------------------------------------------  
Draw_Plane_Vertical_Bottom_Up:                                 ; Offset_0x02FCC6
		movem.w	D1/D2, -(A7)
		bsr.s	Offset_0x02FCD4
		movem.w	(A7)+, D1/D2
		bpl.s	Offset_0x02FCD4
		rts
Offset_0x02FCD4:
		and.w	(Level_Layout_Wrap_Y).w, D2                  ; $FFFFEEAC
		move.w	D2, D3
		addi.w	#$00F0, D3
		and.w	(Level_Layout_Wrap_Y).w, D3                  ; $FFFFEEAC
		move.w	(Draw_Delayed_Position).w, D0                ; $FFFFEEC8
		cmp.w	D2, D0
		bcs.s	Offset_0x02FCF4
		cmp.w	D3, D0
		bhi.s	Offset_0x02FCF4
		moveq	#$20, D6
		jsr	Setup_Tile_Row_Draw(PC)                ; Offset_0x02F93E
Offset_0x02FCF4:
		subi.w	#$0010, (Draw_Delayed_Position).w            ; $FFFFEEC8
		subq.w	#$01, (Draw_Delayed_Position_Rowcount).w     ; $FFFFEECA
		rts 
;-------------------------------------------------------------------------------  
Draw_Plane_Vertical_Bottom_Up_Complex:                         ; Offset_0x02FD00
		movem.l	D1/A4/A5, -(A7)
		bsr.s	Offset_0x02FD0E
		movem.l	(A7)+, D1/A4/A5
		bpl.s	Offset_0x02FD0E
		rts
Offset_0x02FD0E:
		and.w	(Level_Layout_Wrap_Y).w, D1                  ; $FFFFEEAC
		move.w	D1, D2
		addi.w	#$00F0, D2
		and.w	(Level_Layout_Wrap_Y).w, D2                  ; $FFFFEEAC
		move.w	(Draw_Delayed_Position).w, D0                ; $FFFFEEC8
		cmp.w	D1, D0
		bcs.s	Offset_0x02FD36
		cmp.w	D2, D0
		bhi.s	Offset_0x02FD36
Offset_0x02FD28:
		addq.w	#$04, A5
		cmp.w	(A4)+, D0
		bpl.s	Offset_0x02FD28
		move.w	(A5), D1
		moveq	#$20, D6
		jsr	Setup_Tile_Row_Draw(PC)                ; Offset_0x02F93E
Offset_0x02FD36:
		subi.w	#$0010, (Draw_Delayed_Position).w            ; $FFFFEEC8
		subq.w	#$01, (Draw_Delayed_Position_Rowcount).w     ; $FFFFEECA
		rts
;------------------------------------------------------------------------------- 
Plain_Deformation:                                             ; Offset_0x02FD42
		lea	(Horizontal_Scroll_Buffer).w, A1             ; $FFFFE000
		move.w	(Screen_Pos_Buffer_X).w, D0                  ; $FFFFEE80
                neg.w   D0
                swap.w  D0
		move.w	(Screen_Pos_Buffer_X_2).w, D0                ; $FFFFEE8C
                neg.w   D0
		moveq	#$37, D1
Offset_0x02FD56:
		move.l	D0, (A1)+
		move.l	D0, (A1)+
		move.l	D0, (A1)+
		move.l	D0, (A1)+
		dbf	D1, Offset_0x02FD56
		rts 
;-------------------------------------------------------------------------------
Make_Foreground_Deform_Array:                                  ; Offset_0x02FD64
		move.w	D1, D0
		lsr.w	#$01, D0
		bcc.s	Offset_0x02FD70
Offset_0x02FD6A:
		move.w	(A6)+, D5
		add.w	D6, D5
		move.w	D5, (A1)+
Offset_0x02FD70:
		move.w	(A6)+, D5
		add.w	D6, D5
		move.w	D5, (A1)+
		dbf	D0, Offset_0x02FD6A
		rts  
;-------------------------------------------------------------------------------
Apply_Deformation:                                             ; Offset_0x02FD7C
		move.w	#$00DF, D1
Apply_Deformation_D1:                                          ; Offset_0x02FD80
		lea	(Horizontal_Scroll_Buffer).w, A1             ; $FFFFE000
		move.w	(Screen_Pos_Buffer_Y_2).w, D0                ; $FFFFEE90
		move.w	(Screen_Pos_Buffer_X).w, D3                  ; $FFFFEE80
Offset_0x02FD8C:
		move.w	(A4)+, D2
                smi     D4
		bpl.s	Offset_0x02FD96
		andi.w	#$7FFF, D2
Offset_0x02FD96:
		sub.w	D2, D0
		bmi.s	Offset_0x02FDA8
		addq.w	#$02, A5
		tst.b	D4
		beq.s	Offset_0x02FD8C
		subq.w	#$02, A5
		add.w	D2, D2
		adda.w	D2, A5
		bra.s	Offset_0x02FD8C
Offset_0x02FDA8:
		tst.b	D4
		beq.s	Offset_0x02FDB2
		add.w	D0, D2
		add.w	D2, D2
		adda.w	D2, A5
Offset_0x02FDB2:
                neg.w   D0
		move.w	D1, D2
		sub.w	D0, D2
		bcc.s	Offset_0x02FDBE
		move.w	D1, D0
		addq.w	#$01, D0
Offset_0x02FDBE:
                neg.w   D3
                swap.w  D3
Offset_0x02FDC2:
		subq.w	#$01, D0
Offset_0x02FDC4:
		tst.b	D4
		beq.s	Offset_0x02FDDE
		lsr.w	#$01, D0
		bcc.s	Offset_0x02FDD2
Offset_0x02FDCC:
		move.w	(A5)+, D3
                neg.w   D3
		move.l	D3, (A1)+
Offset_0x02FDD2:
		move.w	(A5)+, D3
                neg.w   D3
		move.l	D3, (A1)+
		dbf	D0, Offset_0x02FDCC
		bra.s	Offset_0x02FDEE
Offset_0x02FDDE:
		move.w	(A5)+, D3
                neg.w   D3
		lsr.w	#$01, D0
		bcc.s	Offset_0x02FDE8
Offset_0x02FDE6:
		move.l	D3, (A1)+
Offset_0x02FDE8:
		move.l	D3, (A1)+
		dbf	D0, Offset_0x02FDE6
Offset_0x02FDEE:
		tst.w	D2
		bmi.s	Offset_0x02FE06
		move.w	(A4)+, D0
                smi     D4
		bpl.s	Offset_0x02FDFC
		andi.w	#$7FFF, D0
Offset_0x02FDFC:
		move.w	D2, D3
		sub.w	D0, D2
		bpl.s	Offset_0x02FDC2
		move.w	D3, D0
		bra.s	Offset_0x02FDC4
Offset_0x02FE06:
		rts         
;-------------------------------------------------------------------------------
Apply_All_Deformation:                                         ; Offset_0x02FE08
                swap.w  D7
                swap.w  D3
Offset_0x02FE0C:
		move.w	(A4)+, D3
                smi     D7
		bpl.s	Offset_0x02FE16
		andi.w	#$7FFF, D3
Offset_0x02FE16:
		sub.w	D3, D0
		bmi.s	Offset_0x02FE28
		addq.w	#$02, A5
		tst.b	D7
		beq.s	Offset_0x02FE0C
		subq.w	#$02, A5
		add.w	D3, D3
		adda.w	D3, A5
		bra.s	Offset_0x02FE0C
Offset_0x02FE28:
		tst.b	D7
		beq.s	Offset_0x02FE32
		add.w	D0, D3
		add.w	D3, D3
		adda.w	D3, A5
Offset_0x02FE32:
                swap.w  D3
                neg.w   D0
		move.w	D1, D4
		sub.w	D0, D4
		bcc.s	Offset_0x02FE40
		move.w	D1, D0
		addq.w	#$01, D0
Offset_0x02FE40:
		subq.w	#$01, D0
Offset_0x02FE42:
		tst.b	D7
		beq.s	Offset_0x02FE68
		lsr.w	#$01, D0
		bcc.s	Offset_0x02FE56
Offset_0x02FE4A:
		move.w	(A2)+, D6
                swap.w  D6
		move.w	(A5)+, D6
                neg.w   D6
		add.w	(A6)+, D6
		move.l	D6, (A1)+
Offset_0x02FE56:
		move.w	(A2)+, D6
                swap.w  D6
		move.w	(A5)+, D6
                neg.w   D6
		add.w	(A6)+, D6
		move.l	D6, (A1)+
		dbf	D0, Offset_0x02FE4A
		bra.s	Offset_0x02FE88
Offset_0x02FE68:
		move.w	(A5)+, D5
                neg.w   D5
		lsr.w	#$01, D0
		bcc.s	Offset_0x02FE7A
Offset_0x02FE70:
		move.w	(A2)+, D6
                swap.w  D6
		move.w	(A6)+, D6
		add.w	D5, D6
		move.l	D6, (A1)+
Offset_0x02FE7A:
		move.w	(A2)+, D6
                swap.w  D6
		move.w	(A6)+, D6
		add.w	D5, D6
		move.l	D6, (A1)+
		dbf	D0, Offset_0x02FE70
Offset_0x02FE88:
		tst.w	D4
		bmi.s	Offset_0x02FEA0
		move.w	(A4)+, D0
                smi     D7
		bpl.s	Offset_0x02FE96
		andi.w	#$7FFF, D0
Offset_0x02FE96:
		move.w	D4, D5
		sub.w	D0, D4
		bpl.s	Offset_0x02FE40
		move.w	D5, D0
		bra.s	Offset_0x02FE42
Offset_0x02FEA0:
                swap.w  D7
		rts   
;-------------------------------------------------------------------------------
Apply_Foreground_Vertical_Scroll:                              ; Offset_0x02FEA4
		lea	(Vertical_Scroll_Buffer).w, A1               ; $FFFFEEEA
		move.w	(Screen_Pos_Buffer_Y_2).w, D1                ; $FFFFEE90
		move.w	(Screen_Pos_Buffer_X).w, D0                  ; $FFFFEE80
		move.w	D0, D2
		andi.w	#$000F, D2
		beq.s	Offset_0x02FEBC
		addi.w	#$0010, D0
Offset_0x02FEBC:
		lsr.w	#$04, D0
Offset_0x02FEBE:
		addq.w	#$02, A5
		move.w	(A4)+, D2
		lsr.w	#$04, D2
		sub.w	D2, D0
		bpl.s	Offset_0x02FEBE
                neg.w   D0
		moveq	#$13, D2
		sub.w	D0, D2
		bcc.s	Offset_0x02FED2
		moveq	#$14, D0
Offset_0x02FED2:
		subq.w	#$01, D0
Offset_0x02FED4:
		move.w	(A5)+, D3
Offset_0x02FED6:
		move.w	D3, (A1)+
		move.w	D1, (A1)+
		dbf	D0, Offset_0x02FED6
		tst.w	D2
		bmi.s	Offset_0x02FEF0
		move.w	(A4)+, D0
		lsr.w	#$04, D0
		move.w	D2, D3
		sub.w	D0, D2
		bpl.s	Offset_0x02FED2
		move.w	D3, D0
		bra.s	Offset_0x02FED4
Offset_0x02FEF0:
		rts
;-------------------------------------------------------------------------------
Reset_Tile_Offset_Position_Actual:                             ; Offset_0x02FEF2
		move.w	(Screen_Pos_Buffer_X).w, D0                  ; $FFFFEE80
		move.w	D0, D1
		andi.w	#$FFF0, D0
		move.w	D0, (Screen_Pos_Rounded_X).w                 ; $FFFFEE88
		move.w	(Screen_Pos_Buffer_Y).w, D0                  ; $FFFFEE84
		and.w	(Level_Layout_Wrap_Y).w, D0                  ; $FFFFEEAC
		move.w	D0, (Screen_Pos_Rounded_Y).w                 ; $FFFFEE8A
		rts           
;-------------------------------------------------------------------------------
Reset_Tile_Offset_Position_Actual_2:                           ; Offset_0x02FF0E
		move.w	(Screen_Pos_Buffer_X_2).w, D0                ; $FFFFEE8C
		move.w	D0, D1
		andi.w	#$FFF0, D0
		move.w	D0, D2
		move.w	D0, (Screen_Pos_Rounded_X_2).w               ; $FFFFEE94
		move.w	(Screen_Pos_Buffer_Y_2).w, D0                ; $FFFFEE90
		and.w	(Level_Layout_Wrap_Y).w, D0                  ; $FFFFEEAC
		move.w	D0, (Screen_Pos_Rounded_Y_2).w               ; $FFFFEE96
		rts                   
;------------------------------------------------------------------------------- 
Update_Camera_P2_2:                                            ; Offset_0x02FF2C
		move.w	(Camera_X_P2).w, (Screen_Pos_Buffer_X_P2).w ; $FFFFEE60, $FFFFEE68
		move.w	(Camera_Y_P2).w, (Screen_Pos_Buffer_Y_P2).w ; $FFFFEE64, $FFFFEE6C
		rts        
;------------------------------------------------------------------------------- 
Update_Vertical_Scroll_Value_P2:                               ; Offset_0x02FF3A
		move.w	(Screen_Pos_Buffer_Y_P2).w, D0               ; $FFFFEE6C
		subi.w	#$0070, D0
		move.w	D0, (Vertical_Scroll_Value_P2).w             ; $FFFFF61E
		move.w	(Screen_Pos_Buffer_Y_P2_2).w, D0             ; $FFFFEE74
		subi.w	#$0070, D0
		move.w	D0, (Vertical_Scroll_Value_P2_3).w           ; $FFFFF620
		rts

; ---------------------------------------------------------------------------
; Subroutine to repeat level tile drawing in a level segment
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; Offset_0x02FF54: Load_Tiles_As_You_Move_Loop:
Repeat_TileDrawing:
		cmpi.b	#6,(Obj_Player_One+routine).w
		bcc.s	RepeatTiles_Index
		move.w	(Level_Repeat_Routine).w,d0
		jmp	RepeatTiles_Index(pc,d0.w)
; ===========================================================================
; Offset_0x02FF64:
RepeatTiles_Index:
		; these two instructions make a blank Act 1 entry
		rts
		nop
		bra.w	AIz_Do_Ship_Loop
; ===========================================================================
; Offset_0x02FF6C:
Adjust_Background_During_Loop:
		move.w	(A1), D1
		move.w	D0, (A1)+
		sub.w	D1, D0
		bpl.s	Offset_0x02FF80
                neg.w   D0
		cmp.w	D2, D0
		bcs.s	Offset_0x02FF7C
		sub.w	D3, D0
Offset_0x02FF7C:
		sub.w	D0, (A1)+
		rts
Offset_0x02FF80:
		cmp.w	D2, D0
		bcs.s	Offset_0x02FF86
		sub.w	D3, D0
Offset_0x02FF86:
		add.w	D0, (A1)+
		rts                               
;===============================================================================
; Rotina para recarregar os tiles ao se mover na tela
; <<<-
;===============================================================================
Calc_Screen_Pos_Difference:                                    ; Offset_0x02FF8A
		move.w	(Screen_Pos_Buffer_X).w, D0                  ; $FFFFEE80
		sub.w	(Screen_Pos_Buffer_X_2).w, D0                ; $FFFFEE8C
		move.w	D0, (Camera_X_Difference).w                  ; $FFFFEE3E
		move.w	(Screen_Pos_Buffer_Y).w, D0                  ; $FFFFEE84
		sub.w	(Screen_Pos_Buffer_Y_2).w, D0                ; $FFFFEE90
		move.w	D0, (Camera_Y_Difference).w                  ; $FFFFEE40
		rts
;-------------------------------------------------------------------------------
Earthquake_Setup:                                              ; Offset_0x02FFA4
		move.w	(Earthquake_Offset).w, (Earthquake_Last_Offset).w ; $FFFFEECE, $FFFFEED0
		cmpi.b	#$06, (Obj_Player_One+routine).w         ; $FFFFB005
		bcc.s	Offset_0x02FFDE
		move.w	(Earthquake_Flag).w, D0                      ; $FFFFEECC
		beq.s	Offset_0x02FFDE
		bmi.s	Offset_0x02FFCC
		subq.w	#$01, D0
		move.w	D0, (Earthquake_Flag).w                      ; $FFFFEECC
		move.b	Earthquake_Data(pc,d0.w), D0            ; Offset_0x030008
		ext.w	D0
		move.w	D0, (Earthquake_Offset).w                    ; $FFFFEECE
		rts
Offset_0x02FFCC:
		move.w	(Level_frame_counter).w, D0                    ; $FFFFFE04
		andi.w	#$003F, D0
		move.b	Earthquake_Data_2(pc,d0.w), D0          ; Offset_0x03001C
		move.w	D0, (Earthquake_Offset).w                    ; $FFFFEECE
		rts
Offset_0x02FFDE:
		clr.w	(Earthquake_Offset).w                        ; $FFFFEECE
		rts  
;-------------------------------------------------------------------------------
Calc_Objects_X_Y_During_Transition:                            ; Offset_0x02FFE4
		lea	(Obj_04_Mem_Address).w, A1                   ; $FFFFB128
		moveq	#$59, D2
Offset_0x02FFEA:
		tst.l	(A1)
		beq.s	Offset_0x02FFFE
		btst	#$02, render_flags(A1)                              ; $0004
		beq.s	Offset_0x02FFFE
		sub.w	D0, x_pos(A1)                                    ; $0010
		sub.w	D1, y_pos(A1)                                    ; $0014
Offset_0x02FFFE:
		lea	object_size(A1), A1                                 ; $004A
		dbf	D2, Offset_0x02FFEA
		rts 
;-------------------------------------------------------------------------------
Earthquake_Data:                                               ; Offset_0x030008
		dc.b	$01, $FF, $01, $FF, $02, $FE, $02, $FE
		dc.b	$03, $FD, $03, $FD, $04, $FC, $04, $FC
		dc.b	$05, $FB, $05, $FB
;-------------------------------------------------------------------------------
Earthquake_Data_2:                                             ; Offset_0x03001C
		dc.b	$01, $02, $01, $03, $01, $02, $02, $01
		dc.b	$02, $03, $01, $02, $01, $02, $00, $00
		dc.b	$02, $00, $03, $02, $02, $03, $02, $02
		dc.b	$01, $03, $00, $00, $01, $00, $01, $03
		dc.b	$01, $02, $01, $03, $01, $02, $02, $01
		dc.b	$02, $03, $01, $02, $01, $02, $00, $00
		dc.b	$02, $00, $03, $02, $02, $03, $02, $02
		dc.b	$01, $03, $00, $00, $01, $00, $01, $03
;-------------------------------------------------------------------------------    
AIz_Water_Fg_Deform_Delta:                                     ; Offset_0x03005C            
		dc.b	$00, $01, $00, $01, $00, $01, $00, $01
		dc.b	$00, $01, $00, $01, $00, $01, $00, $01
		dc.b	$00, $01, $00, $01, $00, $01, $00, $01
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $01, $00, $01
		dc.b	$00, $01, $00, $01, $00, $01, $00, $01
		dc.b	$00, $01, $00, $01, $00, $01, $00, $01
		dc.b	$00, $01, $00, $01, $00, $01, $00, $01
		dc.b	$00, $01, $00, $01, $00, $01, $00, $01
		dc.b	$00, $01, $00, $01, $00, $01, $00, $01
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $01, $00, $01
		dc.b	$00, $01, $00, $01, $00, $01, $00, $01
		dc.b	$00, $01, $00, $01, $00, $01, $00, $01
		dc.b	$00, $01, $00, $01, $00, $01, $00, $01
		dc.b	$00, $01, $00, $01, $00, $01, $00, $01
		dc.b	$00, $01, $00, $01, $00, $01, $00, $01
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $01, $00, $01
		dc.b	$00, $01, $00, $01, $00, $01, $00, $01
		dc.b	$00, $01, $00, $01, $00, $01, $00, $01
		dc.b	$00, $01, $00, $01, $00, $01, $00, $01
		dc.b	$00, $01, $00, $01, $00, $01, $00, $01
		dc.b	$00, $01, $00, $01, $00, $01, $00, $01
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $01, $00, $01
		dc.b	$00, $01, $00, $01, $00, $01, $00, $01
		dc.b	$00, $01, $00, $01, $00, $01, $00, $01
		dc.b	$00, $01, $00, $01, $00, $01, $00, $01
		dc.b	$00, $01, $00, $01, $00, $01, $00, $01
		dc.b	$00, $01, $00, $01, $00, $01, $00, $01
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
;-------------------------------------------------------------------------------                
AIz_Water_Bg_Deform_Delta:                                     ; Offset_0x03029C
		dc.b	$00, $00, $00, $00, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
		dc.b	$00, $00, $00, $00, $00, $00, $00, $01
		dc.b	$00, $01, $00, $01, $00, $01, $00, $01
		dc.b	$00, $01, $00, $00, $00, $00, $00, $00
		dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $FF, $FF, $00, $00, $00, $00
		dc.b	$00, $00, $00, $01, $00, $01, $00, $01
		dc.b	$00, $01, $00, $01, $00, $01, $00, $00
		dc.b	$00, $00, $00, $00, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
		dc.b	$00, $00, $00, $00, $00, $00, $00, $01
		dc.b	$00, $01, $00, $01, $00, $01, $00, $01
		dc.b	$00, $01, $00, $00, $FF, $FF, $FF, $FE
		dc.b	$FF, $FE, $FF, $FF, $00, $00, $00, $02
		dc.b	$00, $02, $00, $02, $00, $02, $00, $00
		dc.b	$00, $00, $00, $00, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
		dc.b	$00, $00, $00, $00, $00, $00, $00, $01
		dc.b	$00, $01, $00, $01, $00, $01, $00, $01
		dc.b	$00, $01, $00, $00, $00, $00, $00, $00
		dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $FF, $FF, $00, $00, $00, $00
		dc.b	$00, $00, $00, $01, $00, $01, $00, $01
		dc.b	$00, $01, $00, $01, $00, $01, $00, $00
		dc.b	$00, $00, $00, $00, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
		dc.b	$00, $00, $00, $00, $00, $00, $00, $01
		dc.b	$00, $01, $00, $01, $00, $01, $00, $01
		dc.b	$00, $01, $00, $00, $FF, $FF, $FF, $FE
		dc.b	$FF, $FE, $FF, $FF, $00, $00, $00, $02
		dc.b	$00, $02, $00, $02, $00, $02, $00, $00
		dc.b	$00, $00, $00, $00, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
		dc.b	$00, $00, $00, $00, $00, $00, $00, $01
		dc.b	$00, $01, $00, $01, $00, $01, $00, $01
		dc.b	$00, $01, $00, $00, $00, $00, $00, $00
		dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $FF, $FF, $00, $00, $00, $00
		dc.b	$00, $00, $00, $01, $00, $01, $00, $01
		dc.b	$00, $01, $00, $01, $00, $01, $00, $00
		dc.b	$00, $00, $00, $00, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
		dc.b	$00, $00, $00, $00, $00, $00, $00, $01
		dc.b	$00, $01, $00, $01, $00, $01, $00, $01
		dc.b	$00, $01, $00, $00, $FF, $FF, $FF, $FE
		dc.b	$FF, $FE, $FF, $FF, $00, $00, $00, $02
		dc.b	$00, $02, $00, $02, $00, $02, $00, $00
		dc.b	$00, $00, $00, $00, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
		dc.b	$00, $00, $00, $00, $00, $00, $00, $01
		dc.b	$00, $01, $00, $01, $00, $01, $00, $01
		dc.b	$00, $01, $00, $00, $00, $00, $00, $00
		dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $FF, $FF, $00, $00, $00, $00
		dc.b	$00, $00, $00, $01, $00, $01, $00, $01
;-------------------------------------------------------------------------------                
LBz_Water_Bg_Deform_Delta:                                     ; Offset_0x03045C
		dc.b	$00, $01, $00, $01, $00, $01, $00, $00
		dc.b	$00, $00, $00, $00, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
		dc.b	$00, $00, $00, $00, $00, $00, $00, $01
		dc.b	$00, $01, $00, $01, $00, $01, $00, $01
		dc.b	$00, $01, $00, $00, $FF, $FF, $FF, $FE
		dc.b	$FF, $FE, $FF, $FF, $00, $00, $00, $02
		dc.b	$00, $02, $00, $02, $00, $02, $00, $00
		dc.b	$00, $00, $00, $00, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
		dc.b	$00, $00, $00, $00, $00, $00, $00, $01
		dc.b	$00, $01, $00, $01, $00, $01, $00, $01
		dc.b	$00, $01, $00, $00, $00, $00, $00, $00
		dc.b	$FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $FF, $FF, $00, $00, $00, $00
		dc.b	$00, $00, $00, $01, $00, $01, $00, $01                 

; ===========================================================================
; ---------------------------------------------------------------------------
; Angel Island 1 screen routines
; ---------------------------------------------------------------------------
; Offset_0x0304DC:
AIz_1_Events_Init:
		jsr	Reset_Tile_Offset_Position_Actual(PC)  ; Offset_0x02FEF2
		jmp	Refresh_Plane_Full(PC)                 ; Offset_0x02FA7C
;------------------------------------------------------------------------------- 
AIz_1_Events_Run:                                              ; Offset_0x0304E4
		jsr	LoadTilesAsYouMove_Foreground(PC)             ; Offset_0x02FB0E
		move.w	(Foreground_Events_Y_Counter).w, D0          ; $FFFFEEC4
		beq.w	Offset_0x030580
		cmpi.w	#$0039, D0
		bcc.w	 Offset_0x030582
		cmpi.w	#$0034, D0
		bcs.s	Offset_0x030504
		bsr.w	Offset_0x030596
		bra.s	Offset_0x03051A
Offset_0x030504:
		cmpi.w	#$0024, D0
		bcs.s	Offset_0x030510
		bsr.w	Offset_0x0305A8
		bra.s	Offset_0x03051A
Offset_0x030510:
		cmpi.w	#$0014, D0
		bcs.s	Offset_0x03051A
		bsr.w	Offset_0x0305BA
Offset_0x03051A:
		lea	AIz_Tree_Reveal_Array(PC), A6          ; Offset_0x030682
		btst	#$00, D0
		bne.s	Offset_0x030528
		lea	$0010(A6), A6
Offset_0x030528:
		subq.w	#$01, D0
		lsr.w	#$01, D0
		move.w	D0, (Background_Events).w                    ; $FFFFEED2
		cmpi.w	#$0003, D0
		bcs.s	Offset_0x03053C
		move.w	#$0002, (Background_Events).w                ; $FFFFEED2
Offset_0x03053C:
		lsl.w	#$04, D0
                neg.w   D0
		addi.w	#$0470, D0
Offset_0x030544:
		cmp.w	(Screen_Pos_Rounded_Y).w, D0                 ; $FFFFEE8A
		bcc.s	Offset_0x03055A
		lea	$0020(A6), A6
		addi.w	#$0010, D0
		subq.w	#$01, (Background_Events).w                  ; $FFFFEED2
		bpl.s	Offset_0x030544
		bra.s	Offset_0x030582
Offset_0x03055A:
		move.w	#$2C80, D1
		moveq	#$10, D6
		move.l	A0, -(A7)
		jsr	Setup_Tile_Row_Draw(PC)                ; Offset_0x02F93E
		move.l	(A7)+, A0
		subi.w	#$0280, D0
		moveq	#$00, D1
		moveq	#$0F, D6
		bsr.s	Offset_0x0305CE
		lea	$0010(A6), A6
		addi.w	#$0290, D0
		subq.w	#$01, (Background_Events).w                  ; $FFFFEED2
		bpl.s	Offset_0x030544
Offset_0x030580:
		rts
Offset_0x030582:
		clr.w	(Foreground_Events_Y_Counter).w              ; $FFFFEEC4
		move.w	$0014(A3), A1
		move.w	(A3), A5
		move.b	(A5), $0059(A1)
		move.b	$0001(A5), $005A(A1)
Offset_0x030596:
		move.w	$0018(A3), A1
		move.w	$0004(A3), A5
		move.b	(A5), $0059(A1)
		move.b	$0001(A5), $005A(A1)
Offset_0x0305A8:
		move.w	$001C(A3), A1
		move.w	$0008(A3), A5
		move.b	(A5), $0059(A1)
		move.b	$0001(A5), $005A(A1)
Offset_0x0305BA:
		move.w	$0020(A3), A1
		move.w	$000C(A3), A5
		move.b	(A5), $0059(A1)
		move.b	$0001(A5), $005A(A1)
		rts
Offset_0x0305CE:
		asr.w	#$04, D1
		move.w	D1, D2
		asr.w	#$03, D1
		add.w	D2, D2
		andi.w	#$000E, D2
		addq.w	#$04, A0
		move.l	A0, A1
		lea	$0040(A0), A0
		jsr	Get_Chunk_Addr(PC)                     ; Offset_0x02FA1A
Offset_0x0305E6:
		move.w	$00(A5, D2), D3
		move.w	D3, D4
		andi.w	#$03FF, D3
		lsl.w	#$03, D3
		move.l	$00(A2, D3), D5
		move.l	$04(A2, D3), D3
		btst	#$0B, D4
		beq.s	Offset_0x03060E
		eori.l	#$10001000, D5
		eori.l	#$10001000, D3
		exg.l	D3, D5
Offset_0x03060E:
		btst	#$0A, D4
		beq.s	Offset_0x030624
		eori.l	#$08000800, D5
		eori.l	#$08000800, D3
                swap.w  D5
                swap.w  D3
Offset_0x030624:
		tst.b	(A6)+
		beq.s	Offset_0x03062A
		move.l	D5, (A1)
Offset_0x03062A:
		addq.w	#$04, A1
		tst.b	$000F(A6)
		beq.s	Offset_0x030634
		move.l	D3, (A0)
Offset_0x030634:
		addq.w	#$04, A0
		addq.w	#$02, D2
		andi.w	#$000E, D2
		bne.s	Offset_0x030644
		addq.w	#$01, D1
		jsr	Offset_0x02FA26(PC)
Offset_0x030644:
		dbf	D6, Offset_0x0305E6
		clr.w	(A0)
		rts
;-------------------------------------------------------------------------------
Obj_AIz_Tree_Reveal_Control:                                   ; Offset_0x03064C
		tst.w	objoff_2E(A0)                                    ; $002E
		beq.s	Offset_0x03065E
		tst.w	(Foreground_Events_Y_Counter).w              ; $FFFFEEC4
		bne.s	Offset_0x03065E
		jmp	(DeleteObject)                         ; Offset_0x011138
Offset_0x03065E:
		subq.w	#$01, objoff_2E(A0)                              ; $002E
		move.w	#$0480, D0
		sub.w	(Obj_Player_One+y_pos).w, D0                 ; $FFFFB014
		lsr.w	#$03, D0
		addq.w	#$03, D0
		cmp.w	(Foreground_Events_Y_Counter).w, D0          ; $FFFFEEC4
		bcc.s	Offset_0x03067C
		btst	#Classic_Type, status_secondary(A0)        ; $00, $002F
		beq.s	Offset_0x030680
Offset_0x03067C:
		addq.w	#$01, (Foreground_Events_Y_Counter).w        ; $FFFFEEC4
Offset_0x030680:
		rts                   
;-------------------------------------------------------------------------------
AIz_Tree_Reveal_Array:                                         ; Offset_0x030682
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $01, $01, $01
		dc.b	$01, $01, $01, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $01, $01, $01, $01, $01
		dc.b	$01, $01, $01, $01, $01, $00, $00, $00
		dc.b	$00, $00, $01, $01, $01, $01, $01, $01
		dc.b	$01, $01, $01, $01, $01, $01, $00, $00
		dc.b	$00, $01, $01, $01, $01, $01, $01, $01
		dc.b	$01, $01, $01, $01, $01, $01, $01, $00
		dc.b	$01, $01, $01, $01, $01, $01, $01, $01
		dc.b	$01, $01, $01, $01, $01, $01, $01, $01
		dc.b	$01, $01, $01, $01, $01, $01, $01, $01
		dc.b	$01, $01, $01, $01, $01, $01, $01, $01                
;-------------------------------------------------------------------------------                
AIz_1_Events_Init_2:                                           ; Offset_0x0306F2  
		cmpi.w	#$1400, (Screen_Pos_Buffer_X).w              ; $FFFFEE80
		bcc.s	Offset_0x03071E
		lea	(Horizontal_Scroll_Table).w, A1              ; $FFFFA800
		moveq	#$09, D0
Offset_0x030700:
		clr.l	(A1)+
		dbf	D0, Offset_0x030700
		jsr	AIz_Intro_Deform(PC)                   ; Offset_0x0309F8
		jsr	Reset_Tile_Offset_Position_Actual_2(PC) ; Offset_0x02FF0E
		jsr	Refresh_Plane_Full(PC)                 ; Offset_0x02FA7C
		lea	AIz_Intro_Deform_Array(PC), A4         ; Offset_0x030BF0
		lea	(Horizontal_Scroll_Table+$0028).w, A5        ; $FFFFA828
		jmp	Apply_Deformation(PC)                  ; Offset_0x02FD7C
Offset_0x03071E:
		move.w	#$0008, (Level_Events_Routine_2).w           ; $FFFFEEC2
		jsr	AIz_1_Deform(PC)                       ; Offset_0x030A64
		jsr	Reset_Tile_Offset_Position_Actual_2(PC) ; Offset_0x02FF0E
		clr.l	(Horizontal_Scroll_Table).w                  ; $FFFFA800
		move.w	D2, (Horizontal_Scroll_Table+$0006).w        ; $FFFFA806
		lea	AIz_BG_Draw_Array(PC), A4              ; Offset_0x030C3A
		lea	(Horizontal_Scroll_Table).w, A5              ; $FFFFA800
		jsr	Refresh_Plane_Tile_Deform(PC)          ; Offset_0x02FA9A
		jmp	AIz_Apply_Deform_Water(PC)             ; Offset_0x030AFA
;------------------------------------------------------------------------------- 
AIz_1_Events_Run_2:                                            ; Offset_0x030744
		move.w	(Level_Events_Routine_2).w, D0               ; $FFFFEEC2
		jmp	Offset_0x03074C(pc,d0.w)   
Offset_0x03074C:
		bra.w	AIz_1_Intro                            ; Offset_0x030764
		bra.w	AIz_1_Normal_Refresh                   ; Offset_0x0307BE
		bra.w	AIz_1_Normal                           ; Offset_0x0307DA
		bra.w	AIz_1_Fire_Transition                  ; Offset_0x030832
		bra.w	AIz_1_Fire_Refresh                     ; Offset_0x0308F0
		bra.w	AIz_1_Finish                           ; Offset_0x03091C                
;------------------------------------------------------------------------------- 
AIz_1_Intro:                                                   ; Offset_0x030764
		tst.w	(Level_Events_Buffer_5).w                    ; $FFFFEEC6
		beq.s	Offset_0x03079E
		tst.w	(Kos_decomp_queue_count).w                 ; $FFFFFF0E
		bne.w	Offset_0x03079E
		clr.w	(Level_Events_Buffer_5).w                    ; $FFFFEEC6
		jsr	AIz_1_Deform(PC)                       ; Offset_0x030A64
		jsr	Reset_Tile_Offset_Position_Actual_2(PC) ; Offset_0x02FF0E
		clr.l	(Horizontal_Scroll_Table).w                  ; $FFFFA800
		move.w	D2, (Horizontal_Scroll_Table+$0006).w        ; $FFFFA806
		addi.w	#$00E0, D0
		and.w	(Level_Layout_Wrap_Y).w, D0                  ; $FFFFEEAC
		move.w	D0, (Draw_Delayed_Position).w                ; $FFFFEEC8
		move.w	#$000F, (Draw_Delayed_Position_Rowcount).w   ; $FFFFEECA
		addq.w	#$04, (Level_Events_Routine_2).w             ; $FFFFEEC2
		bra.s	Offset_0x0307C2
Offset_0x03079E:
		jsr	AIz_Intro_Deform(PC)                   ; Offset_0x0309F8
		lea	AIz_Intro_Draw_Array(PC), A4           ; Offset_0x030BDC
		lea	(Horizontal_Scroll_Table).w, A5              ; $FFFFA800
		moveq	#$20, D6
		moveq	#$0A, D5
		jsr	Draw_Background(PC)                    ; Offset_0x02FB74
		lea	AIz_Intro_Deform_Array(PC), A4         ; Offset_0x030BF0
		lea	(Horizontal_Scroll_Table+$0028).w, A5        ; $FFFFA828
		jmp	Apply_Deformation(PC)                  ; Offset_0x02FD7C                 
;------------------------------------------------------------------------------- 
AIz_1_Normal_Refresh:                                          ; Offset_0x0307BE
		jsr	AIz_1_Deform(PC)                       ; Offset_0x030A64
Offset_0x0307C2:                
		lea	AIz_BG_Draw_Array(PC), A4              ; Offset_0x030C3A
		lea	(Horizontal_Scroll_Table-$0004).w, A5        ; $FFFFA7FC
		move.w	(Screen_Pos_Buffer_Y_2).w, D1                ; $FFFFEE90
		jsr	Draw_Plane_Vertical_Bottom_Up_Complex(PC) ; Offset_0x02FD00
		bpl.s	Offset_0x03081E
		addq.w	#$04, (Level_Events_Routine_2).w             ; $FFFFEEC2
		bra.s	Offset_0x03081E                 
;------------------------------------------------------------------------------- 
AIz_1_Normal:                                                  ; Offset_0x0307DA
		tst.w	(Level_Events_Buffer_5).w                    ; $FFFFEEC6
		beq.s	Offset_0x03081A
		clr.w	(Level_Events_Buffer_5).w                    ; $FFFFEEC6
		lea	(Palette_Row_3_Offset+$02).w, A1             ; $FFFFED62
		move.l	#$004E006E, (A1)+
		move.l	#$00AE00CE, (A1)+
		move.l	#$02EE0AEE, (A1)
		move.l	#$00200000, (Screen_Pos_Buffer_Y_2).w        ; $FFFFEE90
		move.w	#$0010, (Screen_Pos_Rounded_Y_2).w           ; $FFFFEE96
		move.w	#$0068, (Background_Events).w                ; $FFFFEED2
		move.w	#$0002, (Special_Vint_Routine).w             ; $FFFFEEA6
		addq.w	#$04, (Level_Events_Routine_2).w             ; $FFFFEEC2
		bra.s	AIz_1_Fire_Transition                  ; Offset_0x030832
Offset_0x03081A:
		jsr	AIz_1_Deform(PC)                       ; Offset_0x030A64
Offset_0x03081E:                
		lea	AIz_BG_Draw_Array(PC), A4              ; Offset_0x030C3A
		lea	(Horizontal_Scroll_Table).w, A5              ; $FFFFA800
		moveq	#$20, D6
		moveq	#$02, D5
		jsr	Draw_Background(PC)                    ; Offset_0x02FB74
		jmp	AIz_Apply_Deform_Water(PC)             ; Offset_0x030AFA
;------------------------------------------------------------------------------- 
AIz_1_Fire_Transition:                                         ; Offset_0x030832
		tst.w	(Background_Events+$02).w                    ; $FFFFEED4
		bne.s	Offset_0x030852
		move.w	(Background_Events).w, D0                    ; $FFFFEED2
                swap.w  D0
		clr.w	D0
		sub.l	(Screen_Pos_Buffer_Y_2).w, D0                ; $FFFFEE90
		asr.l	#$05, D0
		add.l	D0, (Screen_Pos_Buffer_Y_2).w                ; $FFFFEE90
		cmpi.l	#$00001400, D0
		bcc.s	Offset_0x030856
Offset_0x030852:
		jsr	AIz_1_Fire_Rise(PC)                    ; Offset_0x030B78
Offset_0x030856:
		lea	(Screen_Pos_Buffer_Y_2).w, A6                ; $FFFFEE90
		lea	(Screen_Pos_Rounded_Y_2).w, A5               ; $FFFFEE96
		move.w	#$1000, D1
		moveq	#$20, D6
		jsr	DrawBlockRow(PC)                      ; Offset_0x02F8AA
		cmpi.w	#$0190, (Screen_Pos_Buffer_Y_2).w            ; $FFFFEE90
		bcs.s	Offset_0x0308E8
		movem.l	D7/A0/A2/A3, -(A7)
		lea	(Angel_Island_2_Chunks), A1            ; Offset_0x14EA6E
		lea	(M68K_RAM_Start), A2                         ; $FFFF0000
		jsr	(Queue_Kos)          ; Offset_0x0019AE
		lea	(Angel_Island_2_Blocks), A1            ; Offset_0x148128
		lea	(Blocks_Mem_Address).w, A2                   ; $FFFF9000
		jsr	(Queue_Kos)          ; Offset_0x0019AE
		lea	(Angel_Island_2_Blocks_2), A1          ; Offset_0x1489A8
		lea	(Blocks_Mem_Address+$0AA0).w, A2             ; $FFFF9AA0
		jsr	(Queue_Kos)          ; Offset_0x0019AE
		lea	(Angel_Island_2_Tiles), A1             ; Offset_0x1496B8
		move.w	#$0000, D2
		jsr	(Queue_Kos_Module)                 ; Offset_0x0018A8
		lea	(Angel_Island_2_Tiles_2), A1           ; Offset_0x14A1BA
		move.w	#$16A0, D2
		jsr	(Queue_Kos_Module)                 ; Offset_0x0018A8
		lea	(PLC_Spikes_Springs), A1               ; Offset_0x04192C
		jsr	(LoadPLC_Direct)                           ; Offset_0x001502
		movem.l	(A7)+, D7/A0/A2/A3
		move.w	#$00F0, (Draw_Delayed_Position).w            ; $FFFFEEC8
		move.w	#$000F, (Draw_Delayed_Position_Rowcount).w   ; $FFFFEECA
		addq.w	#$04, (Level_Events_Routine_2).w             ; $FFFFEEC2
		bra.s	Offset_0x0308F4
Offset_0x0308E8:
		jsr	AIz_Transition_Wavy_Flame(PC)          ; Offset_0x030B98
		jmp	Plain_Deformation(PC)                  ; Offset_0x02FD42                              
;------------------------------------------------------------------------------- 
AIz_1_Fire_Refresh:                                            ; Offset_0x0308F0
		jsr	AIz_1_Fire_Rise(PC)                    ; Offset_0x030B78
Offset_0x0308F4:                
		lea	(Fg_Mem_Index_Address).w, A3                 ; $FFFF8008
		move.w	#$C000, D7
		move.w	#$0180, D1
		moveq	#$00, D2
		jsr	Draw_Plane_Vertical_Bottom_Up(PC)      ; Offset_0x02FCC6
		bpl.s	Offset_0x030914
		addq.w	#$02, A3
		move.w	#$E000, D7
		addq.w	#$04, (Level_Events_Routine_2).w             ; $FFFFEEC2
		bra.s	Offset_0x030920
Offset_0x030914:
		jsr	AIz_Transition_Wavy_Flame(PC)          ; Offset_0x030B98
		jmp	Plain_Deformation(PC)                  ; Offset_0x02FD42                 
;------------------------------------------------------------------------------- 
AIz_1_Finish:                                                  ; Offset_0x03091C
		jsr	AIz_1_Fire_Rise(PC)                    ; Offset_0x030B78
Offset_0x030920:                
		tst.b	(Kos_modules_left).w                    ; $FFFFFF60
		bne.w	Offset_0x0309F0
		move.w	#AIz_Act_2, (Current_ZoneAndAct).w              ; $0001, $FFFFFE10
		clr.b	(Saved_Level_Flag).w                         ; $FFFFFE30
		clr.b	(Saved_Level_Flag_P2).w                      ; $FFFFFEE0
		clr.b	(Dynamic_Resize_Routine).w                   ; $FFFFEE33
		clr.b	(Object_Pos_Routine).w                       ; $FFFFF76C
		clr.b	(Ring_Pos_Routine).w                         ; $FFFFF710
		clr.b	(Boss_Flag).w                                ; $FFFFF7AA
		clr.l	(Animate_Counters).w                         ; $FFFFF7F0
		clr.w	(Animate_Counters+$04).w                     ; $FFFFF7F4
		movem.l	D7/A0/A2/A3, -(A7)
		jsr	(LoadLevelLayout)                    ; Offset_0x01247C
		jsr	(LoadCollisionIndex)                 ; Offset_0x0049B2
		jsr	(Level_InitWaterLevels)                    ; Offset_0x005056
		moveq	#$0B, D0
		jsr	(PalLoad_Now)                             ; Offset_0x002FBA
		movem.l	(A7)+, D7/A0/A2/A3
		lea	(Palette_Row_3_Offset+$02).w, A1             ; $FFFFED62
		move.l	#$004E006E, (A1)+
		move.l	#$00AE00CE, (A1)+
		move.l	#$02EE0AEE, (A1)
		move.w	#$2F00, D0
		move.w	#$0080, D1
		sub.w	D0, (Obj_Player_One+x_pos).w                 ; $FFFFB010
		sub.w	D1, (Obj_Player_One+y_pos).w                 ; $FFFFB014
		sub.w	D0, (Obj_Player_Two+x_pos).w                 ; $FFFFB05A
		sub.w	D1, (Obj_Player_Two+y_pos).w                 ; $FFFFB05E
		sub.w	D0, (Camera_X).w                             ; $FFFFEE78
		sub.w	D1, (Camera_Y).w                             ; $FFFFEE7C
		sub.w	D0, (Screen_Pos_Buffer_X).w                  ; $FFFFEE80
		sub.w	D1, (Screen_Pos_Buffer_Y).w                  ; $FFFFEE84
		move.l	#$00100010, D0
		move.l	#$00000260, D1
		move.l	D0, (Sonic_Level_Limits_Min_X).w             ; $FFFFEE14
		move.l	D0, (Level_Limits_Min_X).w                   ; $FFFFEE0C
		move.l	D1, (Sonic_Level_Limits_Min_Y).w             ; $FFFFEE18
		move.l	D1, (Level_Limits_Min_Y).w                   ; $FFFFEE10
		move.w	(Screen_Pos_Buffer_X).w, (Level_Events_Buffer_0).w ; $FFFFEE80, $FFFFEEB4
		move.w	(Screen_Pos_Buffer_X).w, (Level_Events_Buffer_1).w ; $FFFFEE80, $FFFFEEB6
		jsr	Reset_Tile_Offset_Position_Actual(PC)  ; Offset_0x02FEF2
		addi.w	#$00E0, D0
		and.w	(Level_Layout_Wrap_Y).w, D0                  ; $FFFFEEAC
		move.w	D0, (Draw_Delayed_Position).w                ; $FFFFEEC8
		move.w	#$000F, (Draw_Delayed_Position_Rowcount).w   ; $FFFFEECA
		clr.w	(Level_Events_Routine_2).w                   ; $FFFFEEC2
Offset_0x0309F0:
		jsr	AIz_Transition_Wavy_Flame(PC)          ; Offset_0x030B98
		jmp	Plain_Deformation(PC)                  ; Offset_0x02FD42
;-------------------------------------------------------------------------------
AIz_Intro_Deform:                                              ; Offset_0x0309F8
		move.w	(Screen_Pos_Buffer_Y).w, (Screen_Pos_Buffer_Y_2).w ; $FFFFEE84, $FFFFEE90
		move.w	(Level_Events_Buffer_1).w, D0                ; $FFFFEEB6
		bmi.s	Offset_0x030A08
		move.w	(Screen_Pos_Buffer_X).w, D0                  ; $FFFFEE80
Offset_0x030A08:
		asr.w	#$01, D0
		lea	(Horizontal_Scroll_Table+$0028).w, A1        ; $FFFFA828
		cmpi.w	#$0580, D0
		blt.s	Offset_0x030A1E
		moveq	#$24, D1
Offset_0x030A16:
		move.w	D0, (A1)+
		dbf	D1, Offset_0x030A16
		bra.s	Offset_0x030A3E
Offset_0x030A1E:
		move.w	D0, (A1)+
		subi.w	#$0580, D0
                swap.w  D0
		clr.w	D0
		move.l	D0, D1
		asr.l	#$05, D1
		moveq	#$23, D2
Offset_0x030A2E:
		add.l	D1, D0
		move.l	D0, D3
                swap.w  D3
		addi.w	#$0580, D3
		move.w	D3, (A1)+
		dbf	D2, Offset_0x030A2E
Offset_0x030A3E:
		lea	(Horizontal_Scroll_Table+$0028).w, A1        ; $FFFFA828
		lea	(Horizontal_Scroll_Table).w, A5              ; $FFFFA800
		move.w	(A1)+, D0
		bpl.s	Offset_0x030A4C
		moveq	#$00, D0
Offset_0x030A4C:
		move.w	D0, (A5)
		addq.w	#$04, A5
		moveq	#$08, D0
Offset_0x030A52:
		move.w	(A1), D1
		bpl.s	Offset_0x030A58
		moveq	#$00, D1
Offset_0x030A58:
		move.w	D1, (A5)
		addq.w	#$08, A1
		addq.w	#$04, A5
		dbf	D0, Offset_0x030A52
		rts
;-------------------------------------------------------------------------------
AIz_1_Deform:                                                  ; Offset_0x030A64
		move.w	(Screen_Pos_Buffer_Y).w, D0                  ; $FFFFEE84
		asr.w	#$01, D0
		move.w	D0, (Screen_Pos_Buffer_Y_2).w                ; $FFFFEE90
		move.w	(Screen_Pos_Buffer_X).w, D0                  ; $FFFFEE80
		subi.w	#$1300, D0
                swap.w  D0
		clr.w	D0
		asr.l	#$05, D0
		move.l	D0, D2
		add.l	D0, D0
		move.l	D0, D1
		lsl.l	#$03, D0
		sub.l	D1, D0
		lea	(Horizontal_Scroll_Table+$0030).w, A1        ; $FFFFA830
                swap.w  D0
		move.w	D0, (A1)
                swap.w  D0
		add.l	D1, D0
                swap.w  D0
		move.w	D0, -$2C(A1)
		move.w	D0, $0002(A1)
		move.w	D0, $000A(A1)
                swap.w  D0
		add.l	D1, D0
                swap.w  D0
		move.w	D0, $0004(A1)
		move.w	D0, $0008(A1)
                swap.w  D0
		add.l	D1, D0
                swap.w  D0
		move.w	D0, $0006(A1)
		lea	(Horizontal_Scroll_Table+$0016).w, A1        ; $FFFFA816
		move.l	D2, D0
                swap.w  D0
		move.w	D0, -(A1)
                swap.w  D0
		move.l	(Horizontal_Scroll_Table+$003C).w, D3        ; $FFFFA83C
		addi.l	#$00002000, (Horizontal_Scroll_Table+$003C).w ; $FFFFA83C
		asr.l	#$01, D0
		moveq	#$05, D1
Offset_0x030AD4:
		add.l	D3, D0
                swap.w  D0
		move.w	D0, -(A1)
                swap.w  D0
		add.l	D2, D0
		dbf	D1, Offset_0x030AD4
		lea	(Horizontal_Scroll_Table+$0016).w, A1        ; $FFFFA816
		move.l	D2, D0
		asr.l	#$03, D2
		moveq	#$0C, D1
Offset_0x030AEC:
		add.l	D2, D0
                swap.w  D0
		move.w	D0, (A1)+
                swap.w  D0
		dbf	D1, Offset_0x030AEC
		rts 
;-------------------------------------------------------------------------------
AIz_Apply_Deform_Water:                                        ; Offset_0x030AFA
		lea	AIz_Deform_Array(PC), A4               ; Offset_0x030C3E
		lea	(Horizontal_Scroll_Table+$0008).w, A5        ; $FFFFA808
		move.w	(Water_Level_Move).w, D1                     ; $FFFFF646
		sub.w	(Screen_Pos_Buffer_Y).w, D1                  ; $FFFFEE84
		cmpi.w	#$00E0, D1
		blt.s	Offset_0x030B14
		jmp	Apply_Deformation(PC)                  ; Offset_0x02FD7C
Offset_0x030B14:
		subq.w	#$01, D1
		jsr	Apply_Deformation_D1(PC)               ; Offset_0x02FD80
		move.l	A1, -(A7)
		lea	(Horizontal_Scroll_Table+$0040).w, A1        ; $FFFFA840
		lea	AIz_Water_Fg_Deform_Delta(PC), A6      ; Offset_0x03005C
		move.w	(Water_Level_Move).w, D0                     ; $FFFFF646
		subi.w	#$00DE, D1
                neg.w   D1
		move.w	(Level_frame_counter).w, D2                    ; $FFFFFE04
		add.w	D0, D2
		add.w	D0, D2
		andi.w	#$007E, D2
		adda.w	D2, A6
		move.w	(Screen_Pos_Buffer_X).w, D6                  ; $FFFFEE80
                neg.w   D6
		jsr	Make_Foreground_Deform_Array(PC)       ; Offset_0x02FD64
		move.l	(A7)+, A1
		lea	(Horizontal_Scroll_Table+$0040).w, A2        ; $FFFFA840
		lea	AIz_Deform_Array(PC), A4               ; Offset_0x030C3E
		lea	(Horizontal_Scroll_Table+$0008).w, A5        ; $FFFFA808
		lea	AIz_Water_Bg_Deform_Delta(PC), A6      ; Offset_0x03029C
		move.w	(Water_Level_Move).w, D0                     ; $FFFFF646
		sub.w	(Screen_Pos_Buffer_Y).w, D0                  ; $FFFFEE84
		add.w	(Screen_Pos_Buffer_Y_2).w, D0                ; $FFFFEE90
		move.w	(Level_frame_counter).w, D2                    ; $FFFFFE04
		asr.w	#$01, D2
		add.w	D0, D2
		add.w	D0, D2
		andi.w	#$007E, D2
		adda.w	D2, A6
		jmp	Apply_All_Deformation(PC)              ; Offset_0x02FE08
;-------------------------------------------------------------------------------
AIz_1_Fire_Rise:                                               ; Offset_0x030B78
		moveq	#$00, D0
		move.w	(Background_Events+$02).w, D0                ; $FFFFEED4
		addi.w	#$0280, D0
		cmpi.w	#$A000, D0
		bcs.s	Offset_0x030B8C
		move.w	#$A000, D0
Offset_0x030B8C:
		move.w	D0, (Background_Events+$02).w                ; $FFFFEED4
		lsl.l	#$04, D0
		add.l	D0, (Screen_Pos_Buffer_Y_2).w                ; $FFFFEE90
		rts                         
;-------------------------------------------------------------------------------
AIz_Transition_Wavy_Flame:                                     ; Offset_0x030B98       
		addq.w	#$06, (AIz_Wavy_Flame_Counter).w             ; $FFFFEE8E
		move.w	(AIz_Wavy_Flame_Counter).w, D0               ; $FFFFEE8E
		andi.w	#$0060, D0
		addi.w	#$1000, D0
		move.w	D0, (Screen_Pos_Buffer_X_2).w                ; $FFFFEE8C
		lea	(Vertical_Scroll_Buffer).w, A1               ; $FFFFEEEA
		lea	AIz_Flame_Vertical_Scroll(PC), A5      ; Offset_0x030C5A
		move.w	(Screen_Pos_Buffer_Y).w, D0                  ; $FFFFEE84
                swap.w  D0
		move.w	(Screen_Pos_Buffer_Y_2).w, D1                ; $FFFFEE90
		move.w	(Level_frame_counter).w, D2                    ; $FFFFFE04
		asr.w	#$02, D2
		moveq	#$13, D3
Offset_0x030BC6:
		addq.w	#$02, D2
		andi.w	#$000F, D2
		move.b	$00(A5, D2), D0
		ext.w	D0
		add.w	D1, D0
		move.l	D0, (A1)+
		dbf	D3, Offset_0x030BC6
		rts
;-------------------------------------------------------------------------------
AIz_Intro_Draw_Array:                                          ; Offset_0x030BDC
		dc.w	$03E0, $0010, $0010, $0010, $0010, $0010, $0010, $0010
		dc.w	$0010, $7FFF
;-------------------------------------------------------------------------------
AIz_Intro_Deform_Array:                                        ; Offset_0x030BF0
		dc.w	$03E0, $0004, $0004, $0004, $0004, $0004, $0004, $0004
		dc.w	$0004, $0004, $0004, $0004, $0004, $0004, $0004, $0004
		dc.w	$0004, $0004, $0004, $0004, $0004, $0004, $0004, $0004
		dc.w	$0004, $0004, $0004, $0004, $0004, $0004, $0004, $0004
		dc.w	$0004, $0004, $0004, $0004, $7FFF
;-------------------------------------------------------------------------------  
AIz_BG_Draw_Array:                                             ; Offset_0x030C3A
		dc.w	$0220, $7FFF
;-------------------------------------------------------------------------------
AIz_Deform_Array:                                              ; Offset_0x030C3E
		dc.w	$00D0, $0020, $0030, $0030, $0010, $0010, $0010, $800D
		dc.w	$000F, $0006, $000E, $0050, $0020, $7FFF 
;------------------------------------------------------------------------------- 
AIz_Flame_Vertical_Scroll:                                     ; Offset_0x030C5A
		dc.w	$00FF, $FEFB, $F8F6, $F3F2, $F1F2, $F3F6, $F9FB, $FEFF

; ===========================================================================
; Offset_0x030C6A: AIz_2_Events_Init:
AIZ2_RefreshScreen:
		jsr	Reset_Tile_Offset_Position_Actual(pc)
		jmp	Refresh_Plane_Full(pc)

; ===========================================================================
; Offset_0x03C72: AIz_2_Events_Run:
AIZ2_RunScreen:
		move.w	(Earthquake_Offset).w, D0                    ; $FFFFEECE
		add.w	D0, (Screen_Pos_Buffer_Y).w                  ; $FFFFEE84
		move.w	(Level_Events_Routine).w, D0                 ; $FFFFEEC0
		jmp	Offset_0x030C82(pc,d0.w) 
;-------------------------------------------------------------------------------
Offset_0x030C82:
		bra.w	AIz_2_Normal                           ; Offset_0x030C96
		bra.w	AIz_2_Ship_Refresh                     ; Offset_0x030CD6
		bra.w	AIz_2_Ship_Redraw                      ; Offset_0x030D36
		bra.w	AIz_2_End_Refresh                      ; Offset_0x030D80
		bra.w	AIz_2_End                              ; Offset_0x030DB6                 
;-------------------------------------------------------------------------------  
AIz_2_Normal:                                                  ; Offset_0x030C96
		tst.w	(Foreground_Events_Y_Counter).w              ; $FFFFEEC4
		beq.s	Offset_0x030CD2
		clr.w	(Foreground_Events_Y_Counter).w              ; $FFFFEEC4
		move.w	#$0180, (Draw_Delayed_Position).w            ; $FFFFEEC8
		move.w	#$0005, (Draw_Delayed_Position_Rowcount).w   ; $FFFFEECA
		clr.l	(Horizontal_Scroll_Table+$01F8).w            ; $FFFFA9F8
		move.w	(Screen_Pos_Buffer_X).w, D0                  ; $FFFFEE80
		andi.w	#$FFF0, D0
		subi.w	#$0010, D0
		move.w	D0, (Horizontal_Scroll_Table+$01FE).w        ; $FFFFA9FE
		move.w	#$0004, (Level_Repeat_Routine).w             ; $FFFFEEB2
		move.b	#$01, (Sonic_Scroll_Lock_Flag).w             ; $FFFFEE0A
		addq.w	#$04, (Level_Events_Routine).w               ; $FFFFEEC0
		bra.s	AIz_2_Ship_Refresh                     ; Offset_0x030CD6
Offset_0x030CD2:
		jmp	LoadTilesAsYouMove_Foreground(PC)             ; Offset_0x02FB0E
;-------------------------------------------------------------------------------                
AIz_2_Ship_Refresh:                                            ; Offset_0x030CD6
		move.w	#$4380, D1
		move.w	(Screen_Pos_Buffer_Y).w, D2                  ; $FFFFEE84
		subi.w	#$0010, D2
		jsr	Draw_Plane_Vertical_Bottom_Up(PC)      ; Offset_0x02FCC6
		bpl.w	Offset_0x030D68
		move.w	#$4020, D0
		move.w	D0, (Horizontal_Scroll_Table+$01F6).w        ; $FFFFA9F6
		move.w	D0, (AIz_Flying_Battery_X).w                 ; $FFFFEE98
		clr.w	(AIz_Flying_Battery_X+$02).w                 ; $FFFFEE9A
		move.w	(Screen_Pos_Buffer_Y).w, D0                  ; $FFFFEE84
		addi.w	#$08F0, D0
		and.w	(Level_Layout_Wrap_Y).w, D0                  ; $FFFFEEAC
		move.w	D0, (AIz_Flying_Battery_Y).w                 ; $FFFFEE9C
		move.w	D0, (AIz_Flying_Battery_Rounded_Y).w         ; $FFFFEEA2
		jsr	(AllocateObject)                     ; Offset_0x011DD8
		bne.s	Offset_0x030D1C
		move.l	#Obj_AIz_Battle_Ship, (A1)             ; Offset_0x0311BC
Offset_0x030D1C:
		st	(Background_Events+$04).w                    ; $FFFFEED6
		move.l	#HInt_Angel_Island_2, (HBlank_Ptr+$02).w ; Offset_0x030DBA, $FFFFF60A
		clr.b	(Water_Level_Flag).w                         ; $FFFFF730
		move.b	#$40, (Scanline_Counter).w                   ; $FFFFF625
		addq.w	#$04, (Level_Events_Routine).w               ; $FFFFEEC0
;-------------------------------------------------------------------------------                
AIz_2_Ship_Redraw:                                             ; Offset_0x030D36
		tst.w	(Foreground_Events_Y_Counter).w              ; $FFFFEEC4
		beq.s	Offset_0x030D52
		clr.w	(Foreground_Events_Y_Counter).w              ; $FFFFEEC4
		move.w	#$0170, (Draw_Delayed_Position).w            ; $FFFFEEC8
		move.w	#$0004, (Draw_Delayed_Position_Rowcount).w   ; $FFFFEECA
		addq.w	#$04, (Level_Events_Routine).w               ; $FFFFEEC0
		bra.s	AIz_2_End_Refresh                      ; Offset_0x030D80
Offset_0x030D52:
		lea	(AIz_Ship_Draw_Array+$04)(PC), A4      ; Offset_0x030DDA
		lea	(Horizontal_Scroll_Table+$01F4).w, A6        ; $FFFFA9F4
		move.w	(AIz_Flying_Battery_X).w, (A6)               ; $FFFFEE98
		moveq	#$02, D5
		move.w	(AIz_Flying_Battery_Rounded_Y).w, D6         ; $FFFFEEA2
		jsr	Draw_Background_D6(PC)                 ; Offset_0x02FB90
Offset_0x030D68:
		lea	AIz_Ship_Draw_Array(PC), A4            ; Offset_0x030DD6
		lea	(Horizontal_Scroll_Table+$01F8).w, A6        ; $FFFFA9F8
		move.w	(Screen_Pos_Buffer_X).w, $0004(A6)           ; $FFFFEE80
		moveq	#$02, D5
		move.w	(Screen_Pos_Rounded_Y).w, D6                 ; $FFFFEE8A
		jmp	Draw_Background_D6(PC)                 ; Offset_0x02FB90
;-------------------------------------------------------------------------------
AIz_2_End_Refresh:                                             ; Offset_0x030D80
		move.w	#$4380, D1
		move.w	(Screen_Pos_Buffer_Y).w, D2                  ; $FFFFEE84
		subi.w	#$0010, D2
		jsr	Draw_Plane_Vertical_Bottom_Up(PC)      ; Offset_0x02FCC6
		bpl.s	Offset_0x030D68
		move.w	(Screen_Pos_Buffer_X).w, D0                  ; $FFFFEE80
		andi.w	#$FFF0, D0
		subi.w	#$0010, D0
		move.w	D0, (Screen_Pos_Rounded_X).w                 ; $FFFFEE88
		move.w	#$46C0, (Background_Events+$02).w            ; $FFFFEED4
		clr.w	(Background_Events+$04).w                    ; $FFFFEED6
		move.b	#$FF, (Scanline_Counter).w                   ; $FFFFF625
		addq.w	#$04, (Level_Events_Routine).w               ; $FFFFEEC0
;-------------------------------------------------------------------------------                
AIz_2_End:                                                     ; Offset_0x030DB6
		jmp	LoadTilesAsYouMove_Foreground(PC)             ; Offset_0x02FB0E           
;------------------------------------------------------------------------------- 
HInt_Angel_Island_2:                                           ; Offset_0x030DBA
		move.w	#$8AFF, (VDP_Control_Port)                   ; $00C00004
		move.l	#$40000010, (VDP_Control_Port)               ; $00C00004
		move.w	(Screen_Pos_Buffer_Y).w, (VDP_Data_Port) ; $FFFFEE84, $00C00000
		rte
;-------------------------------------------------------------------------------
AIz_Ship_Draw_Array:                                           ; Offset_0x030DD6
		dc.w	$0180, $7FFF, $0A80, $7FFF  
;------------------------------------------------------------------------------- 
AIz_2_Events_Init_2:                                           ; Offset_0x030DDE
		move.w	(Screen_Pos_Buffer_X).w, (Level_Events_Buffer_0).w ; $FFFFEE80, $FFFFEEB4
		move.w	(Screen_Pos_Buffer_X).w, (Level_Events_Buffer_1).w ; $FFFFEE80, $FFFFEEB6
		move.w	#$000C, (Level_Events_Routine_2).w           ; $FFFFEEC2
		cmpi.w	#$3E80, (Screen_Pos_Buffer_X).w              ; $FFFFEE80
		bcs.s	Offset_0x030E04
		move.w	#$0014, (Level_Events_Routine_2).w           ; $FFFFEEC2
		move.w	#$4440, (Background_Events+$02).w            ; $FFFFEED4
Offset_0x030E04:
		jsr	AIZ_2_Deform(PC)                       ; Offset_0x031006
		jsr	Reset_Tile_Offset_Position_Actual_2(PC) ; Offset_0x02FF0E
		moveq	#$00, D1
		jsr	Refresh_Plane_Full(PC)                 ; Offset_0x02FA7C
		jmp	AIz_2_Apply_Deform(PC)                 ; Offset_0x03105E
;-------------------------------------------------------------------------------            
AIz_2_Events_Run_2:                                            ; Offset_0x030E16
		lea	(Level_Events_Buffer_0).w, A1                ; $FFFFEEB4
		move.w	(Screen_Pos_Buffer_X).w, D0                  ; $FFFFEE80
		move.w	#$0100, D2
		move.w	#$0200, D3
		jsr	Adjust_Background_During_Loop(PC)      ; Offset_0x02FF6C
		move.w	(Level_Events_Routine_2).w, D0               ; $FFFFEEC2
		jmp	Offset_0x030E32(pc,d0.w)   
;-------------------------------------------------------------------------------  
Offset_0x030E32:
		bra.w	AIz_2_Fire_Redraw                      ; Offset_0x030E4A
		bra.w	AIz_2_Wait_Fire                        ; Offset_0x030E7C
		bra.w	AIz_2_Background_Redraw                ; Offset_0x030F5C
		bra.w	AIz_2_Background_Normal                ; Offset_0x030F72
		bra.w	AIz_2_Ship_Refresh_2                   ; Offset_0x030FC0
		bra.w	AIZ_2_Ship_Move                        ; Offset_0x030FD6    
;-------------------------------------------------------------------------------
AIz_2_Fire_Redraw:                                             ; Offset_0x030E4A
		lea	(Fg_Mem_Index_Address).w, A3                 ; $FFFF8008
		move.w	#$C000, D7
		move.w	(Screen_Pos_Buffer_X).w, D1                  ; $FFFFEE80
		move.w	(Screen_Pos_Buffer_Y).w, D2                  ; $FFFFEE84
		jsr	Draw_Plane_Vertical_Bottom_Up(PC)      ; Offset_0x02FCC6
		bpl.s	Offset_0x030E70
		addq.w	#$02, A3
		move.w	#$E000, D7
		clr.w	(Background_Events).w                        ; $FFFFEED2
		addq.w	#$04, (Level_Events_Routine_2).w             ; $FFFFEEC2
		bra.s	AIz_2_Wait_Fire                        ; Offset_0x030E7C
Offset_0x030E70:
		jsr	AIz_1_Fire_Rise(PC)                    ; Offset_0x030B78
		jsr	AIz_Transition_Wavy_Flame(PC)          ; Offset_0x030B98
		jmp	Plain_Deformation(PC)                  ; Offset_0x02FD42
;-------------------------------------------------------------------------------                
AIz_2_Wait_Fire:                                               ; Offset_0x030E7C
		jsr	AIz_1_Fire_Rise(PC)                    ; Offset_0x030B78
		jsr	AIz_Transition_Wavy_Flame(PC)          ; Offset_0x030B98
		tst.w	(Background_Events).w                        ; $FFFFEED2
		bne.s	Offset_0x030EBA
		move.w	(Screen_Pos_Buffer_Y_2).w, D0                ; $FFFFEE90
		andi.w	#$007F, D0
		cmpi.w	#$0020, D0
		bcs.s	Offset_0x030E9E
		cmpi.w	#$0030, D0
		bcs.s	Offset_0x030EA2
Offset_0x030E9E:
		jmp	Plain_Deformation(PC)                  ; Offset_0x02FD42
Offset_0x030EA2:
		addi.w	#$0180, D0
		move.w	D0, (Screen_Pos_Buffer_Y_2).w                ; $FFFFEE90
		and.w	(Level_Layout_Wrap_Y).w, D0                  ; $FFFFEEAC
		subi.w	#$0010, D0
		move.w	D0, (Screen_Pos_Rounded_Y_2).w               ; $FFFFEE96
		st	(Background_Events).w                        ; $FFFFEED2
Offset_0x030EBA:
		lea	(Screen_Pos_Buffer_Y_2).w, A6                ; $FFFFEE90
		lea	(Screen_Pos_Rounded_Y_2).w, A5               ; $FFFFEE96
		move.w	#$0200, D1
		moveq	#$20, D6
		jsr	DrawBlockRow(PC)                      ; Offset_0x02F8AA
		cmpi.w	#$0310, (Screen_Pos_Buffer_Y_2).w            ; $FFFFEE90
		bcs.s	Offset_0x030F36
		movem.l	D7/A0/A2/A3, -(A7)
		moveq	#$0C, D0
		jsr	(LoadPLC)                              ; Offset_0x0014D0
		move.w	(Current_ZoneAndAct).w, D0                             ; $FFFFFE10
		jsr	(Level_Load_Enemies_Art)               ; Offset_0x024F46
		movem.l	(A7)+, D7/A0/A2/A3
		lea	(Palette_Row_3_Offset+$02).w, A1             ; $FFFFED62
		move.l	#$08EE00AA, (A1)+
		move.l	#$008E004E, (A1)+
		move.l	#$002E000C, (A1)
		move.w	#$6000, D0
		move.w	D0, (Sonic_Level_Limits_Max_X).w             ; $FFFFEE16
		move.w	D0, (Level_Limits_Max_X).w                   ; $FFFFEE0E
		jsr	AIZ_2_Deform(PC)                       ; Offset_0x031006
		jsr	Reset_Tile_Offset_Position_Actual_2(PC) ; Offset_0x02FF0E
		addi.w	#$00E0, D0
		and.w	(Level_Layout_Wrap_Y).w, D0                  ; $FFFFEEAC
		move.w	D0, (Draw_Delayed_Position).w                ; $FFFFEEC8
		move.w	#$000F, (Draw_Delayed_Position_Rowcount).w   ; $FFFFEECA
		move.w	#$0006, (Special_Vint_Routine).w             ; $FFFFEEA6
		addq.w	#$04, (Level_Events_Routine_2).w             ; $FFFFEEC2
		bra.s	Offset_0x030F60
Offset_0x030F36:
		jsr	AIz_2_Apply_Deform(PC)                 ; Offset_0x03105E
		lea	(Horizontal_Scroll_Buffer+$0002).w, A1       ; $FFFFE002
		move.w	(Screen_Pos_Buffer_X_2).w, D0                ; $FFFFEE8C
                neg.w   D0
		moveq	#$37, D1
Offset_0x030F46:
		move.w	D0, (A1)
		addq.w	#$04, A1
		move.w	D0, (A1)
		addq.w	#$04, A1
		move.w	D0, (A1)
		addq.w	#$04, A1
		move.w	D0, (A1)
		addq.w	#$04, A1
		dbf	D1, Offset_0x030F46
		rts
;-------------------------------------------------------------------------------                
AIz_2_Background_Redraw:                                       ; Offset_0x030F5C
		jsr	AIZ_2_Deform(PC)                       ; Offset_0x031006
Offset_0x030F60:
		moveq	#$00, D1
		move.w	(Screen_Pos_Buffer_Y_2).w, D2                ; $FFFFEE90
		jsr	Draw_Plane_Vertical_Bottom_Up(PC)      ; Offset_0x02FCC6
		bpl.s	Offset_0x030FA8
		addq.w	#$04, (Level_Events_Routine_2).w             ; $FFFFEEC2
		bra.s	Offset_0x030FA8
;-------------------------------------------------------------------------------                
AIz_2_Background_Normal:                                       ; Offset_0x030F72
		jsr	AIZ_2_Deform(PC)                       ; Offset_0x031006
		tst.w	(Level_Events_Buffer_5).w                    ; $FFFFEEC6
		beq.s	Offset_0x030FA8
		clr.w	(Level_Events_Buffer_5).w                    ; $FFFFEEC6
		addi.w	#$00A8, (Screen_Pos_Buffer_Y_2).w            ; $FFFFEE90
		jsr	Reset_Tile_Offset_Position_Actual_2(PC) ; Offset_0x02FF0E
		addi.w	#$00E0, D0
		and.w	(Level_Layout_Wrap_Y).w, D0                  ; $FFFFEEAC
		move.w	D0, (Draw_Delayed_Position).w                ; $FFFFEEC8
		move.w	#$000F, (Draw_Delayed_Position_Rowcount).w   ; $FFFFEECA
		move.w	#$4440, (Background_Events+$02).w            ; $FFFFEED4
		addq.w	#$04, (Level_Events_Routine_2).w             ; $FFFFEEC2
		bra.s	Offset_0x030FC4
Offset_0x030FA8:
		lea	(Screen_Pos_Buffer_Y_2).w, A6                ; $FFFFEE90
		lea	(Screen_Pos_Rounded_Y_2).w, A5               ; $FFFFEE96
		moveq	#$00, D1
		moveq	#$20, D6
		jsr	DrawBlockRow(PC)                      ; Offset_0x02F8AA
		jsr	AIz_2_Apply_Deform(PC)                 ; Offset_0x03105E
		jmp	Earthquake_Setup(PC)                   ; Offset_0x02FFA4
;-------------------------------------------------------------------------------                
AIz_2_Ship_Refresh_2:                                          ; Offset_0x030FC0
		jsr	AIZ_2_Deform(PC)                       ; Offset_0x031006
Offset_0x030FC4:
		moveq	#$00, D1
		move.w	(Screen_Pos_Buffer_Y_2).w, D2                ; $FFFFEE90
		jsr	Draw_Plane_Vertical_Bottom_Up(PC)      ; Offset_0x02FCC6
		bpl.s	Offset_0x030FDA
		addq.w	#$04, (Level_Events_Routine_2).w             ; $FFFFEEC2
		bra.s	Offset_0x030FDA
;-------------------------------------------------------------------------------                
AIZ_2_Ship_Move:                                               ; Offset_0x030FD6
		jsr	AIZ_2_Deform(PC)                       ; Offset_0x031006
Offset_0x030FDA:
		lea	(Screen_Pos_Buffer_Y_2).w, A6                ; $FFFFEE90
		lea	(Screen_Pos_Rounded_Y_2).w, A5               ; $FFFFEE96
		moveq	#$00, D1
		moveq	#$20, D6
		jsr	DrawBlockRow(PC)                      ; Offset_0x02F8AA
		jsr	AIz_2_Apply_Deform(PC)                 ; Offset_0x03105E
		tst.w	(Background_Events+$04).w                    ; $FFFFEED6
		beq.s	Offset_0x031002
		move.w	(AIz_Flying_Battery_Y).w, (Vertical_Scroll_Value).w ; $FFFFEE9C, $FFFFF616
		move.w	(Screen_Pos_Buffer_Y_2).w, (Vertical_Scroll_Value_2).w ; $FFFFEE90, $FFFFF618
		addq.w	#$04, A7
Offset_0x031002:
		jmp	Earthquake_Setup(PC)                   ; Offset_0x02FFA4
;-------------------------------------------------------------------------------                    
AIZ_2_Deform:                                                  ; Offset_0x031006
		move.w	(Screen_Pos_Buffer_Y).w, D0                  ; $FFFFEE84
		move.w	(Earthquake_Offset).w, D1                    ; $FFFFEECE
		sub.w	D1, D0
		asr.w	#$01, D0
		add.w	D1, D0
		move.w	D0, (Screen_Pos_Buffer_Y_2).w                ; $FFFFEE90
		cmpi.w	#$0010, (Level_Events_Routine_2).w           ; $FFFFEEC2
		bcs.s	Offset_0x031026
		addi.w	#$00A8, (Screen_Pos_Buffer_Y_2).w            ; $FFFFEE90
Offset_0x031026:
		move.w	(Level_Events_Buffer_1).w, D0                ; $FFFFEEB6
                swap.w  D0
		clr.w	D0
		asr.l	#$01, D0
		move.l	D0, D1
		asr.l	#$05, D1
		move.l	D1, D2
		add.l	D1, D1
		add.l	D2, D1
		lea	(Horizontal_Scroll_Table+$01C0).w, A1        ; $FFFFA9C0
		lea	AIz_2_Background_Deform_Make(PC), A5   ; Offset_0x0315FE
		moveq	#$00, D2
Offset_0x031044:
		move.b	(A5)+, D3
		bmi.s	Offset_0x03105C
		ext.w	D3
                swap.w  D0
Offset_0x03104C:
		move.b	(A5)+, D2
		move.w	D0, $00(A1, D2)
		dbf	D3, Offset_0x03104C
                swap.w  D0
		add.l	D1, D0
		bra.s	Offset_0x031044
Offset_0x03105C:
		rts    
;------------------------------------------------------------------------------- 
AIz_2_Apply_Deform:                                            ; Offset_0x03105E
		lea	(Horizontal_Scroll_Table).w, A1              ; $FFFFA800
		lea	AIz_2_Deform_Delta(PC), A6             ; Offset_0x031620
		move.w	(Screen_Pos_Buffer_Y).w, D0                  ; $FFFFEE84
		move.w	#$00DF, D1
		move.w	(Level_frame_counter).w, D2                    ; $FFFFFE04
		add.w	D0, D2
		add.w	D0, D2
		moveq	#$3E, D3
		move.w	(Screen_Pos_Buffer_X).w, D6                  ; $FFFFEE80
                neg.w   D6
		move.w	(Water_Level_Move).w, D4                     ; $FFFFF646
		sub.w	D0, D4
		bls.s	Offset_0x0310A8
		cmp.w	D1, D4
		bhi.s	Offset_0x0310AE
		move.w	D4, D1
		subq.w	#$01, D1
		and.w	D3, D2
		adda.w	D2, A6
		jsr	Make_Foreground_Deform_Array(PC)       ; Offset_0x02FD64
		move.w	(Water_Level_Move).w, D0                     ; $FFFFF646
		subi.w	#$00DE, D1
                neg.w   D1
		move.w	(Level_frame_counter).w, D2                    ; $FFFFFE04
		add.w	D0, D2
		add.w	D0, D2
Offset_0x0310A8:
		lea	AIz_Water_Fg_Deform_Delta(PC), A6      ; Offset_0x03005C
		moveq	#$7E, D3
Offset_0x0310AE:
		and.w	D3, D2
		adda.w	D2, A6
		jsr	Make_Foreground_Deform_Array(PC)       ; Offset_0x02FD64
		lea	(Horizontal_Scroll_Buffer).w, A1             ; $FFFFE000
		lea	(Horizontal_Scroll_Table).w, A2              ; $FFFFA800
		lea	AIz_2_Background_Deform_Array(PC), A4  ; Offset_0x0315CC
		lea	(Horizontal_Scroll_Table+$01C0).w, A5        ; $FFFFA9C0
		lea	Default_Background_Deform_Delta(PC), A6 ; Offset_0x031820
		move.w	(Screen_Pos_Buffer_Y_2).w, D0                ; $FFFFEE90
		move.w	#$00DF, D1
		move.w	(Level_frame_counter).w, D2                    ; $FFFFFE04
		asr.w	#$01, D2
		add.w	D0, D2
		add.w	D0, D2
		moveq	#$3E, D3
		move.w	(Water_Level_Move).w, D4                     ; $FFFFF646
		sub.w	(Screen_Pos_Buffer_Y).w, D4                  ; $FFFFEE84
		bls.s	Offset_0x03111C
		cmp.w	D1, D4
		bhi.s	Offset_0x031122
		move.w	D4, D1
		subq.w	#$01, D1
		and.w	D3, D2
		adda.w	D2, A6
		jsr	Apply_All_Deformation(PC)              ; Offset_0x02FE08
		lea	AIz_2_Background_Deform_Array(PC), A4  ; Offset_0x0315CC
		lea	(Horizontal_Scroll_Table+$01C0).w, A5        ; $FFFFA9C0
		move.w	(Water_Level_Move).w, D0                     ; $FFFFF646
		sub.w	(Screen_Pos_Buffer_Y).w, D0                  ; $FFFFEE84
		add.w	(Screen_Pos_Buffer_Y_2).w, D0                ; $FFFFEE90
		subi.w	#$00DE, D1
                neg.w   D1
		move.w	(Level_frame_counter).w, D2                    ; $FFFFFE04
		asr.w	#$01, D2
		add.w	D0, D2
		add.w	D0, D2
Offset_0x03111C:
		lea	AIz_Water_Bg_Deform_Delta(PC), A6      ; Offset_0x03029C
		moveq	#$7E, D3
Offset_0x031122:
		and.w	D3, D2
		adda.w	D2, A6
		jsr	Apply_All_Deformation(PC)              ; Offset_0x02FE08
		tst.w	(Background_Events+$04).w                    ; $FFFFEED6
		beq.s	Offset_0x031150
		lea	(Horizontal_Scroll_Buffer).w, A1             ; $FFFFE000
		move.w	(AIz_Flying_Battery_X).w, D0                 ; $FFFFEE98
                neg.w   D0
		moveq	#$0F, D1
Offset_0x03113C:
		move.w	D0, (A1)
		addq.w	#$04, A1
		move.w	D0, (A1)
		addq.w	#$04, A1
		move.w	D0, (A1)
		addq.w	#$04, A1
		move.w	D0, (A1)
		addq.w	#$04, A1
		dbf	D1, Offset_0x03113C
Offset_0x031150:
		rts
;-------------------------------------------------------------------------------
AIz_Do_Ship_Loop:                                              ; Offset_0x031152    
		clr.w	(Level_Repeat_Offset).w                      ; $FFFFEEBC
		move.w	(Camera_X).w, D0                             ; $FFFFEE78
		addq.w	#$04, D0
		cmp.w	(Background_Events+$02).w, D0                ; $FFFFEED4
		bcs.s	Offset_0x031186
		move.w	#$0200, D1
		move.w	D1, (Level_Repeat_Offset).w                  ; $FFFFEEBC
		sub.w	D1, (Obj_Player_One+x_pos).w                 ; $FFFFB010
		sub.w	D1, (Obj_Player_Two+x_pos).w                 ; $FFFFB05A
		sub.w	D1, D0
		move.w	D0, D1
		andi.w	#$FFF0, D1
		subi.w	#$0010, D1
		move.w	D1, (Screen_Pos_Rounded_X).w                 ; $FFFFEE88
		move.w	D1, (Horizontal_Scroll_Table+$01FE).w        ; $FFFFA9FE
Offset_0x031186:
		move.w	D0, (Camera_X).w                             ; $FFFFEE78
		move.w	D0, (Screen_Pos_Buffer_X).w                  ; $FFFFEE80
		move.w	D0, (Sonic_Level_Limits_Min_X).w             ; $FFFFEE14
		move.w	D0, (Sonic_Level_Limits_Max_X).w             ; $FFFFEE16
		addi.w	#$0018, D0
		cmp.w	(Obj_Player_One+x_pos).w, D0                 ; $FFFFB010
		bls.s	Offset_0x0311AC
		move.w	D0, (Obj_Player_One+x_pos).w                 ; $FFFFB010
		move.w	#$0400, (Obj_Player_One+inertia).w       ; $FFFFB01C
		bra.s	Offset_0x0311BA
Offset_0x0311AC:
		addi.w	#$0088, D0
		cmp.w	(Obj_Player_One+x_pos).w, D0                 ; $FFFFB010
		bhi.s	Offset_0x0311BA
		move.w	D0, (Obj_Player_One+x_pos).w                 ; $FFFFB010
Offset_0x0311BA:
		rts
;-------------------------------------------------------------------------------
Obj_AIz_Battle_Ship:                                           ; Offset_0x0311BC
                include 'data\objects\aiz_bshp.asm'                
;-------------------------------------------------------------------------------  
AIz_2_Background_Deform_Array:                                 ; Offset_0x0315CC
		dc.b	$00, $10, $00, $20, $00, $38, $00, $58
		dc.b	$00, $28, $00, $40, $00, $38, $00, $18
		dc.b	$00, $18, $00, $90, $00, $48, $00, $10
		dc.b	$00, $18, $00, $20, $00, $38, $00, $58
		dc.b	$00, $28, $00, $40, $00, $38, $00, $18
		dc.b	$00, $18, $00, $90, $00, $48, $00, $10
		dc.b	$7F, $FF
;-------------------------------------------------------------------------------
AIz_2_Background_Deform_Make:                                  ; Offset_0x0315FE
		dc.b	$01, $12, $2A, $03, $10, $14, $28, $2C
		dc.b	$03, $0E, $16, $26, $2E, $04, $00, $0C
		dc.b	$18, $24, $30, $03, $02, $0A, $1A, $22
		dc.b	$03, $04, $08, $1C, $20, $01, $06, $1E
		dc.b	$FF, $00
;------------------------------------------------------------------------------- 
AIz_2_Deform_Delta:                                            ; Offset_0x031620
		dc.b	$00, $00, $00, $00, $00, $01, $00, $01
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $01, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $01, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $01, $00, $00, $00, $00
		dc.b	$00, $01, $00, $01, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $01, $00, $01
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $01, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $01, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $01, $00, $00, $00, $00
		dc.b	$00, $01, $00, $01, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $01, $00, $01
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $01, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $01, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $01, $00, $00, $00, $00
		dc.b	$00, $01, $00, $01, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $01, $00, $01
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $01, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $01, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $01, $00, $00, $00, $00
		dc.b	$00, $01, $00, $01, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $01, $00, $01
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $01, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $01, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $01, $00, $00, $00, $00
		dc.b	$00, $01, $00, $01, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $01, $00, $01
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $01, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $01, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $01, $00, $00, $00, $00
		dc.b	$00, $01, $00, $01, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $01, $00, $01
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $01, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $01, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $01, $00, $00, $00, $00
		dc.b	$00, $01, $00, $01, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $01, $00, $01
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $01, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $01, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $00, $00, $00, $00, $00
		dc.b	$00, $00, $00, $01, $00, $00, $00, $00
		dc.b	$00, $01, $00, $01, $00, $00, $00, $00  
;-------------------------------------------------------------------------------  
Default_Background_Deform_Delta:                               ; Offset_0x031820
		dc.b	$FF, $FE, $00, $01, $00, $02, $00, $02
		dc.b	$FF, $FF, $00, $02, $00, $02, $00, $01
		dc.b	$00, $02, $FF, $FF, $FF, $FE, $FF, $FE
		dc.b	$FF, $FE, $00, $01, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $00, $00, $FF, $FE, $00, $00
		dc.b	$00, $00, $00, $00, $FF, $FE, $00, $00
		dc.b	$FF, $FE, $00, $02, $00, $00, $FF, $FE
		dc.b	$00, $02, $00, $02, $FF, $FF, $FF, $FE
		dc.b	$FF, $FE, $00, $01, $00, $02, $00, $02
		dc.b	$FF, $FF, $00, $02, $00, $02, $00, $01
		dc.b	$00, $02, $FF, $FF, $FF, $FE, $FF, $FE
		dc.b	$FF, $FE, $00, $01, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $00, $00, $FF, $FE, $00, $00
		dc.b	$00, $00, $00, $00, $FF, $FE, $00, $00
		dc.b	$FF, $FE, $00, $02, $00, $00, $FF, $FE
		dc.b	$00, $02, $00, $02, $FF, $FF, $FF, $FE
		dc.b	$FF, $FE, $00, $01, $00, $02, $00, $02
		dc.b	$FF, $FF, $00, $02, $00, $02, $00, $01
		dc.b	$00, $02, $FF, $FF, $FF, $FE, $FF, $FE
		dc.b	$FF, $FE, $00, $01, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $00, $00, $FF, $FE, $00, $00
		dc.b	$00, $00, $00, $00, $FF, $FE, $00, $00
		dc.b	$FF, $FE, $00, $02, $00, $00, $FF, $FE
		dc.b	$00, $02, $00, $02, $FF, $FF, $FF, $FE
		dc.b	$FF, $FE, $00, $01, $00, $02, $00, $02
		dc.b	$FF, $FF, $00, $02, $00, $02, $00, $01
		dc.b	$00, $02, $FF, $FF, $FF, $FE, $FF, $FE
		dc.b	$FF, $FE, $00, $01, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $00, $00, $FF, $FE, $00, $00
		dc.b	$00, $00, $00, $00, $FF, $FE, $00, $00
		dc.b	$FF, $FE, $00, $02, $00, $00, $FF, $FE
		dc.b	$00, $02, $00, $02, $FF, $FF, $FF, $FE
		dc.b	$FF, $FE, $00, $01, $00, $02, $00, $02
		dc.b	$FF, $FF, $00, $02, $00, $02, $00, $01
		dc.b	$00, $02, $FF, $FF, $FF, $FE, $FF, $FE
		dc.b	$FF, $FE, $00, $01, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $00, $00, $FF, $FE, $00, $00
		dc.b	$00, $00, $00, $00, $FF, $FE, $00, $00
		dc.b	$FF, $FE, $00, $02, $00, $00, $FF, $FE
		dc.b	$00, $02, $00, $02, $FF, $FF, $FF, $FE
		dc.b	$FF, $FE, $00, $01, $00, $02, $00, $02
		dc.b	$FF, $FF, $00, $02, $00, $02, $00, $01
		dc.b	$00, $02, $FF, $FF, $FF, $FE, $FF, $FE
		dc.b	$FF, $FE, $00, $01, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $00, $00, $FF, $FE, $00, $00
		dc.b	$00, $00, $00, $00, $FF, $FE, $00, $00
		dc.b	$FF, $FE, $00, $02, $00, $00, $FF, $FE
		dc.b	$00, $02, $00, $02, $FF, $FF, $FF, $FE
		dc.b	$FF, $FE, $00, $01, $00, $02, $00, $02
		dc.b	$FF, $FF, $00, $02, $00, $02, $00, $01
		dc.b	$00, $02, $FF, $FF, $FF, $FE, $FF, $FE
		dc.b	$FF, $FE, $00, $01, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $00, $00, $FF, $FE, $00, $00
		dc.b	$00, $00, $00, $00, $FF, $FE, $00, $00
		dc.b	$FF, $FE, $00, $02, $00, $00, $FF, $FE
		dc.b	$00, $02, $00, $02, $FF, $FF, $FF, $FE
		dc.b	$FF, $FE, $00, $01, $00, $02, $00, $02
		dc.b	$FF, $FF, $00, $02, $00, $02, $00, $01
		dc.b	$00, $02, $FF, $FF, $FF, $FE, $FF, $FE
		dc.b	$FF, $FE, $00, $01, $FF, $FF, $FF, $FF
		dc.b	$FF, $FF, $00, $00, $FF, $FE, $00, $00
		dc.b	$00, $00, $00, $00, $FF, $FE, $00, $00
		dc.b	$FF, $FE, $00, $02, $00, $00, $FF, $FE
		dc.b	$00, $02, $00, $02, $FF, $FF, $FF, $FE                   
;-------------------------------------------------------------------------------  
Pal_AIz_Battleship:                                            ; Offset_0x031A20  
		dc.w	$0000, $0EEE, $02AE, $006E, $004C, $00EE, $0088, $0224
		dc.w	$00CA, $0066, $0042, $0020, $0CAA, $0866, $0644, $0044
;-------------------------------------------------------------------------------  
Pal_AIz_Boss_Small:                                            ; Offset_0x031A40  
		dc.w	$0EEE, $0CAA, $0E26, $0222, $00EE, $0000, $0008, $02AE
		dc.w	$004C, $0006, $0020, $0C68, $0A24, $0622
;-------------------------------------------------------------------------------  
AIz_Battleship_Bobbing_Motion:                                 ; Offset_0x031A5C  
		dc.b	$04, $04, $03, $03, $02, $01, $01, $00
		dc.b	$00, $00, $01, $01, $02, $03, $03, $04
;-------------------------------------------------------------------------------  
AIz_FBz_Bomb_Script:                                           ; Offset_0x031A6C 
		dc.w	$001E, $3F5C
		dc.w	$001E, $3F2C
		dc.w	$001E, $3F5C
		dc.w	$001E, $3F2C
		dc.w	$001E, $3F5C
		dc.w	$000F, $3F2C
		dc.w	$001E, $3EDC
		dc.w	$001E, $3EAC
		dc.w	$001E, $3EDC
		dc.w	$001E, $3EAC
		dc.w	$001E, $3EDC
		dc.w	$000F, $3EAC
		dc.w	$001E, $3E5C
		dc.w	$001E, $3E2C
		dc.w	$001E, $3E5C
		dc.w	$001E, $3E2C
		dc.w	$001E, $3E5C
		dc.w	$000F, $3E2C
		dc.w	$003C, $3DEC
		dc.w	$003C, $3DEC
		dc.w	$003C, $3DEC
		dc.w	$FFFF  
;------------------------------------------------------------------------------- 
AIz_FBz_Bomb_Explosion_Data:                                   ; Offset_0x031AC2
		dc.w	$0000, $FFC4, $0000, $000A, $0000, $FFF4, $0101, $0009
		dc.w	$FFFC, $FFCC, $0000, $0008, $000C, $FFFC, $0101, $0007
		dc.w	$FFF4, $FFFC, $0101, $0005, $0008, $FFDC, $0000, $0004
		dc.w	$FFF8, $FFE4, $0000, $0002, $0000, $FFF4, $0000, $0000   
;------------------------------------------------------------------------------- 
AIz_Make_Tree_Script:                                          ; Offset_0x031B02
		dc.w	$0000, $0280
		dc.w	$0032, $0380
		dc.w	$008E, $0280
		dc.w	$0103, $0380
		dc.w	$0179, $0280
		dc.w	$01C6, $0380
		dc.w	$0233, $0280
		dc.w	$02A0, $0380
		dc.w	$030A, $0280
		dc.w	$037C, $0380
		dc.w	$03C7, $0280
		dc.w	$0401, $0380
		dc.w	$0439, $0280
		dc.w	$046E, $0380
		dc.w	$04CA, $0280
		dc.w	$050C, $0380
		dc.w	$0557, $0280
		dc.w	$FFFF   
;------------------------------------------------------------------------------- 
AIz_Battleship_Propeller_Mappings:                             ; Offset_0x031B48  
		dc.w	Offset_0x031B50-AIz_Battleship_Propeller_Mappings
		dc.w	Offset_0x031B58-AIz_Battleship_Propeller_Mappings
		dc.w	Offset_0x031B60-AIz_Battleship_Propeller_Mappings
		dc.w	Offset_0x031B68-AIz_Battleship_Propeller_Mappings
Offset_0x031B50:
		dc.w	$0001
		dc.w	$F003, $A000, $FFFC
Offset_0x031B58:
		dc.w	$0001
		dc.w	$F402, $A004, $FFFC
Offset_0x031B60:
		dc.w	$0001
		dc.w	$FC00, $A007, $FFFC
Offset_0x031B68:
		dc.w	$0001
		dc.w	$F402, $B004, $FFFC
;------------------------------------------------------------------------------- 
AIz_Battleship_Propeller_Animate_Data:                         ; Offset_0x031B70
		dc.w	Offset_0x031B72-AIz_Battleship_Propeller_Animate_Data
Offset_0x031B72:
		dc.b	$02, $00, $01, $02, $03, $FF  
;------------------------------------------------------------------------------- 
AIz_FBz_Ship_Bomb_Main_Mappings:                               ; Offset_0x031B78 
		dc.w	Offset_0x031B90-AIz_FBz_Ship_Bomb_Main_Mappings
		dc.w	Offset_0x031B98-AIz_FBz_Ship_Bomb_Main_Mappings
		dc.w	Offset_0x031BA0-AIz_FBz_Ship_Bomb_Main_Mappings
		dc.w	Offset_0x031BA8-AIz_FBz_Ship_Bomb_Main_Mappings
		dc.w	Offset_0x031BB0-AIz_FBz_Ship_Bomb_Main_Mappings
		dc.w	Offset_0x031BB8-AIz_FBz_Ship_Bomb_Main_Mappings
		dc.w	Offset_0x031BC0-AIz_FBz_Ship_Bomb_Main_Mappings
		dc.w	Offset_0x031BC8-AIz_FBz_Ship_Bomb_Main_Mappings
		dc.w	Offset_0x031BD0-AIz_FBz_Ship_Bomb_Main_Mappings
		dc.w	Offset_0x031BD8-AIz_FBz_Ship_Bomb_Main_Mappings
		dc.w	Offset_0x031BE0-AIz_FBz_Ship_Bomb_Main_Mappings
		dc.w	Offset_0x031BE8-AIz_FBz_Ship_Bomb_Main_Mappings
Offset_0x031B90:
		dc.w	$0001
		dc.w	$F00B, $2008, $FFF4
Offset_0x031B98:
		dc.w	$0001
		dc.w	$FC0E, $0014, $FFF0
Offset_0x031BA0:
		dc.w	$0001
		dc.w	$F40F, $0020, $FFF0
Offset_0x031BA8:
		dc.w	$0001
		dc.w	$F40F, $0030, $FFF0
Offset_0x031BB0:
		dc.w	$0001
		dc.w	$F40E, $0040, $FFF0
Offset_0x031BB8:
		dc.w	$0001
		dc.w	$F40E, $004C, $FFF0
Offset_0x031BC0:
		dc.w	$0001
		dc.w	$0005, $0058, $FFF8
Offset_0x031BC8:
		dc.w	$0001
		dc.w	$FC0A, $005C, $FFF4
Offset_0x031BD0:
		dc.w	$0001
		dc.w	$FC0A, $0065, $FFF4
Offset_0x031BD8:
		dc.w	$0001
		dc.w	$FC0A, $006E, $FFF4
Offset_0x031BE0:
		dc.w	$0001
		dc.w	$FC0A, $0077, $FFF4
Offset_0x031BE8:
		dc.w	$0001
		dc.w	$FC09, $0080, $FFF4
;------------------------------------------------------------------------------- 
AIz_FBz_Bomb_Explosion_Animate_Data:                           ; Offset_0x031BF0     
		dc.w	Offset_0x031BF4-AIz_FBz_Bomb_Explosion_Animate_Data
		dc.w	Offset_0x031C00-AIz_FBz_Bomb_Explosion_Animate_Data
Offset_0x031BF4:
		dc.b	$01, $03, $02, $04, $03, $05, $04, $05
		dc.b	$05, $05, $FC, $00
Offset_0x031C00:
		dc.b	$06, $02, $07, $03, $08, $04, $09, $05
		dc.b	$0A, $05, $0B, $05, $FC, $00
;------------------------------------------------------------------------------- 
AIz_Background_Tree_Mappings:                                  ; Offset_0x031C0E
		dc.w	Offset_0x031C10-AIz_Background_Tree_Mappings
Offset_0x031C10:
		dc.w	$0004
		dc.w	$C007, $4000, $0000
		dc.w	$E007, $4000, $0000
		dc.w	$0007, $4000, $0000
		dc.w	$2007, $4000, $0000   
;------------------------------------------------------------------------------- 
AIz_Boss_Small_Mappings:                                       ; Offset_0x031C2A
		dc.w	Offset_0x031C2C-AIz_Boss_Small_Mappings
Offset_0x031C2C:
		dc.w	$0006
		dc.w	$E40E, $2086, $FFF0
		dc.w	$F400, $2092, $FFE8
		dc.w	$F400, $2093, $0010
		dc.w	$FC0E, $2094, $FFE0
		dc.w	$FC0E, $20A0, $0000
		dc.w	$140C, $20AC, $FFF0             

; ===========================================================================
; ---------------------------------------------------------------------------
; Hydrocity 1 screen routines
; ---------------------------------------------------------------------------
; Offset_0x031C52: Hz_1_Events_Init:
HCZ1_RefreshScreen:
		jsr	Reset_Tile_Offset_Position_Actual(pc)
		jmp	Refresh_Plane_Full(pc)
; ===========================================================================
; Offset_0x031C5A: Hz_1_Events_Run:
HCZ1_RunScreen:
		jmp	LoadTilesAsYouMove_Foreground(pc)
; ===========================================================================
; Offset_0x031C5E: Hz_1_Events_Init_2:
HCZ1_RefreshBackground:
		jsr	HCZ1_Deform(pc)
		jsr	Reset_Tile_Offset_Position_Actual_2(pc)
		moveq	#0,d1
		jsr	Refresh_Plane_Full(pc)
		jmp	Plain_Deformation(pc)
; ===========================================================================
; Offset_0x031C70: Hz_1_Events_Run_2:
HCZ1_RunBackground:
		jsr	HCZ1_Deform(pc)
		lea	(Screen_Pos_Buffer_Y_2).w,a6
		lea	(Screen_Pos_Rounded_Y_2).w,a5
		moveq	#0,d1
		moveq	#32,d6
		jsr	DrawBlockRow(pc)
		jmp	Plain_Deformation(pc)
; ===========================================================================
; Offset_0x031C88: Hz_1_Deform:
HCZ1_Deform:
		move.w	(Screen_Pos_Buffer_Y).w,d0
		subi.w	#1552,d0
		move.w	d0,d1
                swap.w  d0
		clr.w	d0
		asr.l	#4,d0
		move.l	d0,d2
		add.l	d0,d0
		add.l	d2,d0
                swap.w  d0
		move.w	d0,d2
		addi.w	#272,d0
		move.w	d0,(Screen_Pos_Buffer_Y_2).w
		sub.w	d1,d2
		move.w	d2,(Background_Events+$10).w
		move.w	(Screen_Pos_Buffer_X).w,d0
		asr.w	#1,d0
		move.w	d0,(Screen_Pos_Buffer_X_2).w
		rts
; End of function HCZ1_Deform

; ===========================================================================
; ---------------------------------------------------------------------------
; Hydrocity 2 screen routines
; ---------------------------------------------------------------------------
; Offset_0x031CBC: Hz_2_Events_Init:
HCZ2_RefreshScreen:
		jsr	Reset_Tile_Offset_Position_Actual(pc)
		jmp	Refresh_Plane_Full(pc)
; ===========================================================================
; Offset_0x031CC4: Hz_2_Events_Run:
HCZ2_RunScreen:
		move.w	(Earthquake_Offset).w,d0
		add.w	d0,(Screen_Pos_Buffer_Y).w
		jmp	LoadTilesAsYouMove_Foreground(pc)
; ===========================================================================
; Offset_0x031CD0: Hz_2_Events_Init_2:
HCZ2_RefreshBackground:
		cmpi.w	#$C00,(Screen_Pos_Buffer_X).w
		bcc.s	Offset_0x031CF0
		cmpi.w	#$500,(Screen_Pos_Buffer_Y).w
		bcs.s	Offset_0x031CF0
		jsr	Hz_2_Wall_Move_2(pc)
		jsr	Reset_Tile_Offset_Position_Actual_2(pc)
		jsr	Refresh_Plane_Full(pc)
		jmp	Plain_Deformation(pc)

Offset_0x031CF0:
		move.w	#$C,(Level_Events_Routine_2).w
		jsr	Hz_2_Deform(pc)
		jsr	Reset_Tile_Offset_Position_Actual_2(pc)
		moveq	#0,d1
		jsr	Refresh_Plane_Full(pc)
		lea	Hz_2_Deform_Array(pc),a4
		lea	(Horizontal_Scroll_Table).w,a5
		jmp	Apply_Deformation(pc)
; ===========================================================================
; Offset_0x031D10: Hz_2_Events_Run_2:
HCZ2_RunBackground:
		move.w	(Level_Events_Routine_2).w,d0
		jmp	HCZ2_BackgroundIndex(pc,d0.w)
; ===========================================================================
; Offset_0x031D18:
HCZ2_BackgroundIndex:
		bra.w	HCZ2_MoveWall
		bra.w	Hz_2_Normal_Transition
		bra.w	Hz_2_Normal_Refresh
		bra.w	Hz_2_Normal
; ===========================================================================
; Offset_0x031D28: Hz_2_Wall_Move:
HCZ2_MoveWall:
		tst.w	(Level_Events_Buffer_5).w
		beq.s	HCZ2_SetupWall
		clr.w	(Level_Events_Buffer_5).w
		tst.w	(Earthquake_Flag).w
		bpl.s	HCZ2_RemoveWall
		clr.w	(Earthquake_Flag).w
; Offset_0x031D3C:
HCZ2_RemoveWall:
		clr.b	(Background_Collision_Flag).w
		move.w	#$E0,(Draw_Delayed_Position).w
		move.w	#$F,(Draw_Delayed_Position_Rowcount).w
		addq.w	#4,(Level_Events_Routine_2).w
		bra.s	Hz_2_Normal_Transition
; Offset_0x031D52:
HCZ2_SetupWall:
		jsr	Hz_2_Wall_Move_2(pc)
		jsr	LoadTilesAsYouMove_Background(pc)
		jsr	Plain_Deformation(pc)
		st	(Background_Collision_Flag).w
		jsr	Calc_Screen_Pos_Difference(pc)
		jmp	Earthquake_Setup(pc)

;-------------------------------------------------------------------------------   
Hz_2_Normal_Transition:                                        ; Offset_0x031D6A
		move.w	#$0400, D1
		move.w	#$0000, D2
		jsr	Draw_Plane_Vertical_Bottom_Up(PC)      ; Offset_0x02FCC6
		bpl.w	Plain_Deformation                      ; Offset_0x02FD42
		jsr	Hz_2_Deform(PC)                        ; Offset_0x031E26
		jsr	Reset_Tile_Offset_Position_Actual_2(PC) ; Offset_0x02FF0E
		addi.w	#$00E0, D0
		and.w	(Level_Layout_Wrap_Y).w, D0                  ; $FFFFEEAC
		move.w	D0, (Draw_Delayed_Position).w                ; $FFFFEEC8
		move.w	#$000F, (Draw_Delayed_Position_Rowcount).w   ; $FFFFEECA
		addq.w	#$04, (Level_Events_Routine_2).w             ; $FFFFEEC2
		bra.s	Offset_0x031D9E             
;-------------------------------------------------------------------------------   
Hz_2_Normal_Refresh:                                           ; Offset_0x031D9A
		jsr	Hz_2_Deform(PC)                        ; Offset_0x031E26
Offset_0x031D9E:
		moveq	#$00, D1
		move.w	(Screen_Pos_Buffer_Y_2).w, D2                ; $FFFFEE90
		jsr	Draw_Plane_Vertical_Bottom_Up(PC)      ; Offset_0x02FCC6
		bpl.s	Offset_0x031DB4
		addq.w	#$04, (Level_Events_Routine_2).w             ; $FFFFEEC2
		bra.s	Offset_0x031DB4         
;-------------------------------------------------------------------------------   
Hz_2_Normal:                                                   ; Offset_0x031DB0
		jsr	Hz_2_Deform(PC)                        ; Offset_0x031E26
Offset_0x031DB4:
		lea	(Screen_Pos_Buffer_Y_2).w, A6                ; $FFFFEE90
		lea	(Screen_Pos_Rounded_Y_2).w, A5               ; $FFFFEE96
		moveq	#$00, D1
		moveq	#$20, D6
		jsr	DrawBlockRow(PC)                      ; Offset_0x02F8AA
		lea	Hz_2_Deform_Array(PC), A4              ; Offset_0x031ECA
		lea	(Horizontal_Scroll_Table).w, A5              ; $FFFFA800
		jmp	Apply_Deformation(PC)                  ; Offset_0x02FD7C 
;-------------------------------------------------------------------------------   
Hz_2_Wall_Move_2:                                              ; Offset_0x031DD0
		cmpi.b	#$06, (Obj_Player_One+routine).w         ; $FFFFB005
		bcc.s	Offset_0x031E08
		move.l	#$0000E000, D0
		move.w	(Background_Events).w, D1                    ; $FFFFEED2
		beq.s	Offset_0x031DF8
		cmpi.w	#$FA00, D1
		bgt.s	Offset_0x031E04
		tst.w	(Earthquake_Flag).w                          ; $FFFFEECC
		bpl.s	Offset_0x031E08
		move.w	#$000E, (Earthquake_Flag).w                  ; $FFFFEECC
		bra.s	Offset_0x031E08
Offset_0x031DF8:
		cmpi.w	#$0688, (Obj_Player_One+x_pos).w             ; $FFFFB010
		bcs.s	Offset_0x031E08
		st	(Earthquake_Flag).w                          ; $FFFFEECC
Offset_0x031E04:
		sub.l	D0, (Background_Events).w                    ; $FFFFEED2
Offset_0x031E08:
		move.w	(Screen_Pos_Buffer_Y).w, D0                  ; $FFFFEE84
		subi.w	#$0500, D0
		move.w	D0, (Screen_Pos_Buffer_Y_2).w                ; $FFFFEE90
		move.w	(Screen_Pos_Buffer_X).w, D0                  ; $FFFFEE80
		subi.w	#$0200, D0
		add.w	(Background_Events).w, D0                    ; $FFFFEED2
		move.w	D0, (Screen_Pos_Buffer_X_2).w                ; $FFFFEE8C
		rts
;-------------------------------------------------------------------------------   
Hz_2_Deform:                                                   ; Offset_0x031E26
		move.w	(Screen_Pos_Buffer_Y).w, D0                  ; $FFFFEE84
		asr.w	#$02, D0
		move.w	D0, (Screen_Pos_Buffer_Y_2).w                ; $FFFFEE90
		move.w	(Screen_Pos_Buffer_X).w, D0                  ; $FFFFEE80
                swap.w  D0
		clr.w	D0
		asr.l	#$01, D0
		move.l	D0, D1
		asr.l	#$03, D1
		lea	(Horizontal_Scroll_Table).w, A1              ; $FFFFA800
		lea	Hz_2_Deform_Index(PC), A5              ; Offset_0x031EF8
		moveq	#$00, D2
Offset_0x031E48:
		move.b	(A5)+, D3
		bmi.s	Offset_0x031E62
		beq.s	Offset_0x031E5E
		ext.w	D3
                swap.w  D0
Offset_0x031E52:
		move.b	(A5)+, D2
		move.w	D0, $00(A1, D2)
		dbf	D3, Offset_0x031E52
                swap.w  D0
Offset_0x031E5E:
		sub.l	D1, D0
		bra.s	Offset_0x031E48
Offset_0x031E62:
		move.w	$0012(A1), D0
		sub.w	$000A(A1), D0
		move.w	D0, (Background_Events+$10).w                ; $FFFFEEE2
		move.w	$0006(A1), D0
		sub.w	$0012(A1), D0
		move.w	D0, (Background_Events+$12).w                ; $FFFFEEE4
		move.w	$0004(A1), D0
		sub.w	$0012(A1), D0
		move.w	D0, (Background_Events+$14).w                ; $FFFFEEE6
		rts
;-------------------------------------------------------------------------------
; Offset_0x031E88:  ; Left over ???
		nop
		nop
		cmpi.w	#$0004, (Level_Events_Routine_2).w           ; $FFFFEEC2
		bcs.s	Offset_0x031E9A
		jmp	(DeleteObject)                         ; Offset_0x011138
Offset_0x031E9A:
		move.w	(Background_Events).w, D4                    ; $FFFFEED2
                neg.w   D4
		addi.w	#$05C0, D4
		move.w	D4, x_pos(A0)                                    ; $0010
		move.w	#$0700, y_pos(A0)                                ; $0014
		move.b	#$40, width_pixels(A0)                              ; $0007
		bset	#$07, status(A0)                             ; $002A
		moveq	#$4B, D1
		move.w	#$0100, D2
		move.w	#$0100, D3
		jmp	(Solid_Object_2)                       ; Offset_0x0135B6                 
;------------------------------------------------------------------------------- 
Hz_2_Deform_Array:                                             ; Offset_0x031ECA
		dc.w	$0008, $0008, $0090, $0010, $0008, $0030, $0018, $0008
		dc.w	$0008, $00A8, $0030, $0018, $0008, $0008, $00A8, $0030
		dc.w	$0018, $0008, $0008, $00B0, $0010, $0008, $7FFF 
;------------------------------------------------------------------------------- 
Hz_2_Deform_Index:                                             ; Offset_0x031EF8
		dc.b	$03, $0A, $14, $1E, $2C, $02, $0C, $16
		dc.b	$20, $05, $00, $08, $0E, $18, $22, $2A
		dc.b	$03, $02, $10, $1A, $24, $01, $12, $1C
		dc.b	$01, $06, $28, $01, $04, $26, $FF, $00
;------------------------------------------------------------------------------- 
MGz_1_Events_Init:                                             ; Offset_0x031F18
		jsr	Reset_Tile_Offset_Position_Actual(PC)  ; Offset_0x02FEF2
		jmp	Refresh_Plane_Full(PC)                 ; Offset_0x02FA7C  
;------------------------------------------------------------------------------- 
MGz_1_Events_Run:                                              ; Offset_0x031F20
		move.w	(Earthquake_Offset).w, D0                    ; $FFFFEECE
		add.w	D0, (Screen_Pos_Buffer_Y).w                  ; $FFFFEE84
		jmp	LoadTilesAsYouMove_Foreground(PC)             ; Offset_0x02FB0E  
;-------------------------------------------------------------------------------                                      
MGz_1_Events_Init_2:                                           ; Offset_0x031F2C
		jsr	MGz_1_Deform(PC)                       ; Offset_0x032068
		moveq	#$00, D0
		moveq	#$00, D1
		jsr	Refresh_Plane_Full(PC)                 ; Offset_0x02FA7C
		lea	MGz_1_Deform_Array(PC), A4             ; Offset_0x0320C6
		lea	(Horizontal_Scroll_Table).w, A5              ; $FFFFA800
		jmp	Apply_Deformation(PC)                  ; Offset_0x02FD7C  
;------------------------------------------------------------------------------- 
MGz_1_Events_Run_2:                                            ; Offset_0x031F44  
		move.w	(Level_Events_Routine_2).w, D0               ; $FFFFEEC2
		jmp	Offset_0x031F4C(pc,d0.w)
;-------------------------------------------------------------------------------  
Offset_0x031F4C:
		bra.w	MGz_1_Normal                           ; Offset_0x031F54
		bra.w	MGz_1_Transition                       ; Offset_0x031FB8  
;------------------------------------------------------------------------------- 
MGz_1_Normal:                                                  ; Offset_0x031F54
		tst.w	(Level_Events_Buffer_5).w                    ; $FFFFEEC6
		beq.s	Offset_0x031FA4
		clr.w	(Level_Events_Buffer_5).w                    ; $FFFFEEC6
		movem.l	D7/A0/A2/A3, -(A7)
		lea	(Marble_Garden_2_Chunks_2), A1         ; Offset_0x16403A
		lea	(M68K_RAM_Start+$6B80), A2                   ; $FFFF6B80
		jsr	(Queue_Kos)          ; Offset_0x0019AE
		lea	(Marble_Garden_2_Blocks_2), A1         ; Offset_0x162E58
		lea	(Blocks_Mem_Address+$0C78).w, A2             ; $FFFF9C78
		jsr	(Queue_Kos)          ; Offset_0x0019AE
		lea	(Marble_Garden_2_Tiles_2), A1          ; Offset_0x1632A8
		move.w	#$4FC0, D2
		jsr	(Queue_Kos_Module)                 ; Offset_0x0018A8
		moveq	#$14, D0
		jsr	(LoadPLC)                              ; Offset_0x0014D0
		movem.l	(A7)+, D7/A0/A2/A3
		addq.w	#$04, (Level_Events_Routine_2).w             ; $FFFFEEC2
Offset_0x031FA4:
		jsr	MGz_1_Deform(PC)                       ; Offset_0x032068
		lea	MGz_1_Deform_Array(PC), A4             ; Offset_0x0320C6
		lea	(Horizontal_Scroll_Table).w, A5              ; $FFFFA800
		jsr	Apply_Deformation(PC)                  ; Offset_0x02FD7C
		jmp	Earthquake_Setup(PC)                   ; Offset_0x02FFA4
;-------------------------------------------------------------------------------                
MGz_1_Transition:                                              ; Offset_0x031FB8
		tst.b	(Kos_modules_left).w                    ; $FFFFFF60
		bne.w	Offset_0x032054
		move.w	#MGz_Act_2, (Current_ZoneAndAct).w              ; $0201, $FFFFFE10
		clr.b	(Saved_Level_Flag).w                         ; $FFFFFE30
		clr.b	(Saved_Level_Flag_P2).w                      ; $FFFFFEE0
		clr.b	(Dynamic_Resize_Routine).w                   ; $FFFFEE33
		clr.b	(Object_Pos_Routine).w                       ; $FFFFF76C
		clr.b	(Ring_Pos_Routine).w                         ; $FFFFF710
		clr.b	(Boss_Flag).w                                ; $FFFFF7AA
		clr.l	(Animate_Counters).w                         ; $FFFFF7F0
		clr.w	(Animate_Counters+$04).w                     ; $FFFFF7F4
		movem.l	D7/A0/A2/A3, -(A7)
		jsr	(LoadLevelLayout)                    ; Offset_0x01247C
		jsr	(LoadCollisionIndex)                 ; Offset_0x0049B2
		moveq	#$0F, D0
		jsr	(PalLoad_Now)                             ; Offset_0x002FBA
		movem.l	(A7)+, D7/A0/A2/A3
		move.w	#$2E00, D0
		move.w	#$0600, D1
		sub.w	D0, (Obj_Player_One+x_pos).w                 ; $FFFFB010
		sub.w	D1, (Obj_Player_One+y_pos).w                 ; $FFFFB014
		sub.w	D0, (Obj_Player_Two+x_pos).w                 ; $FFFFB05A
		sub.w	D1, (Obj_Player_Two+y_pos).w                 ; $FFFFB05E
		jsr	Calc_Objects_X_Y_During_Transition(PC) ; Offset_0x02FFE4
		sub.w	D0, (Camera_X).w                             ; $FFFFEE78
		sub.w	D1, (Camera_Y).w                             ; $FFFFEE7C
		sub.w	D0, (Screen_Pos_Buffer_X).w                  ; $FFFFEE80
		sub.w	D1, (Screen_Pos_Buffer_Y).w                  ; $FFFFEE84
		sub.w	D0, (Sonic_Level_Limits_Min_X).w             ; $FFFFEE14
		sub.w	D0, (Sonic_Level_Limits_Max_X).w             ; $FFFFEE16
		sub.w	D1, (Sonic_Level_Limits_Min_Y).w             ; $FFFFEE18
		sub.w	D1, (Sonic_Level_Limits_Max_Y).w             ; $FFFFEE1A
		move.w	(Sonic_Level_Limits_Max_Y).w, (Level_Limits_Max_Y).w ; $FFFFEE1A, $FFFFEE12
		jsr	Reset_Tile_Offset_Position_Actual(PC)  ; Offset_0x02FEF2
		clr.l	(Background_Events+$10).w                    ; $FFFFEEE2
		clr.w	(Background_Events+$14).w                    ; $FFFFEEE6
		clr.w	(Level_Events_Routine_2).w                   ; $FFFFEEC2
Offset_0x032054:
		jsr	MGz_1_Deform(PC)                       ; Offset_0x032068
		lea	MGz_1_Deform_Array(PC), A4             ; Offset_0x0320C6
		lea	(Horizontal_Scroll_Table).w, A5              ; $FFFFA800
		jsr	Apply_Deformation(PC)                  ; Offset_0x02FD7C
		jmp	Earthquake_Setup(PC)                   ; Offset_0x02FFA4                  
;-------------------------------------------------------------------------------  
MGz_1_Deform:                                                  ; Offset_0x032068
		move.w	(Earthquake_Offset).w, (Screen_Pos_Buffer_Y_2).w ; $FFFFEECE, $FFFFEE90
		move.w	(Screen_Pos_Buffer_X).w, D0                  ; $FFFFEE80
                swap.w  D0
		clr.w	D0
		asr.l	#$02, D0
		move.l	D0, D1
		asr.l	#$04, D1
		lea	(Horizontal_Scroll_Table+$001C).w, A1        ; $FFFFA81C
		moveq	#$08, D2
Offset_0x032082:
                swap.w  D0
		move.w	D0, -(A1)
                swap.w  D0
		sub.l	D1, D0
		dbf	D2, Offset_0x032082
		lea	(Horizontal_Scroll_Table).w, A1              ; $FFFFA800
		move.l	(Horizontal_Scroll_Table+$001C).w, D2        ; $FFFFA81C
		addi.l	#$00000500, (Horizontal_Scroll_Table+$001C).w  ; $FFFFA81C
		asr.l	#$01, D0
		moveq	#$04, D3
Offset_0x0320A2:
		add.l	D2, D0
		addi.l	#$00000500, D2
                swap.w  D0
		move.w	D0, (A1)+
                swap.w  D0
		add.l	D1, D0
		dbf	D3, Offset_0x0320A2
		move.w	-2(A1), D0
		move.w	-4(A1), -2(A1)
		move.w	D0, -4(A1)
		rts                         
;-------------------------------------------------------------------------------  
MGz_1_Deform_Array:                                            ; Offset_0x0320C6
		dc.w	$0010, $0004, $0004, $0008, $0008, $0008, $000D, $0013
		dc.w	$0008, $0008, $0008, $0008, $0018, $7FFF
;------------------------------------------------------------------------------- 
MGz_2_Events_Init:                                             ; Offset_0x0320E2  
		clr.l	(Background_Events+$10).w                    ; $FFFFEEE2
		clr.w	(Background_Events+$14).w                    ; $FFFFEEE6
		jsr	Reset_Tile_Offset_Position_Actual(PC)  ; Offset_0x02FEF2
		jmp	Refresh_Plane_Full(PC)                 ; Offset_0x02FA7C
;------------------------------------------------------------------------------- 
MGz_2_Events_Run:                                              ; Offset_0x0320F2
		move.w	(Earthquake_Offset).w, D0                    ; $FFFFEECE
		add.w	D0, (Screen_Pos_Buffer_Y).w                  ; $FFFFEE84
		move.w	(Level_Events_Routine).w, D0                 ; $FFFFEEC0
		jmp	Offset_0x032102(pc,d0.w)          
;-------------------------------------------------------------------------------    
Offset_0x032102:
		bra.w	MGz_2_Normal                           ; Offset_0x03210E
		bra.w	MGz_2_Collapse                         ; Offset_0x03212E
		bra.w	MGz_2_Move_Background                  ; Offset_0x03214C
;-------------------------------------------------------------------------------  
MGz_2_Normal:                                                 ;  Offset_0x03210E
		tst.w	(Foreground_Events_Y_Counter).w              ; $FFFFEEC4
		bne.s	Offset_0x032120
		jsr	MGz_2_Quake(PC)                        ; Offset_0x0322B0
		jsr	MGz_2_Chunk(PC)                        ; Offset_0x03247A
		jmp	LoadTilesAsYouMove_Foreground(PC)             ; Offset_0x02FB0E
Offset_0x032120:
		clr.w	(Foreground_Events_Y_Counter).w              ; $FFFFEEC4
		move.w	#$0014, (Earthquake_Flag).w                  ; $FFFFEECC
		addq.w	#$04, (Level_Events_Routine).w               ; $FFFFEEC0
;-------------------------------------------------------------------------------                
MGz_2_Collapse:                
		jsr	MGz_2_Collapse_2(PC)                   ; Offset_0x03216C
		tst.w	(Earthquake_Flag).w                          ; $FFFFEECC
		bmi.s	Offset_0x03213C
		jmp	LoadTilesAsYouMove_Foreground(PC)             ; Offset_0x02FB0E
Offset_0x03213C:
		lea	MGz_2_Vertical_Scroll_Array(PC), A4    ; Offset_0x03271E
		lea	(Horizontal_Scroll_Table+$0100).w, A5        ; $FFFFA900
		moveq	#$0F, D6
		moveq	#$0A, D5
		jmp	Draw_Tiles_Vertical(PC)                ; Offset_0x02FC0E 
;------------------------------------------------------------------------------- 
MGz_2_Move_Background:                                         ; Offset_0x03214C
		move.l	(Background_Events+$08).w, D0                ; $FFFFEEDA
		cmpi.l	#$00050000, D0
		bcc.s	Offset_0x032162
		addi.l	#$00000800, D0
		move.l	D0, (Background_Events+$08).w                ; $FFFFEEDA
Offset_0x032162:
                swap.w  D0
		add.w	D0, (Background_Events+$0C).w                ; $FFFFEEDE
		jmp	LoadTilesAsYouMove_Foreground(PC)             ; Offset_0x02FB0E 
;-------------------------------------------------------------------------------  
MGz_2_Collapse_2:                                              ; Offset_0x03216C
		cmpi.b	#$06, (Obj_Player_One+routine).w         ; $FFFFB005
		bcc.w	 Offset_0x0322AE
		tst.w	(Earthquake_Flag).w                          ; $FFFFEECC
		bmi.w	Offset_0x032228
		bne.w	Offset_0x0322AE
		move.w	$0038(A3), A1
		lea	$0079(A1), A1
		move.w	-8(A3), D0
		subq.w	#$03, D0
		moveq	#$02, D1
Offset_0x032192:
		clr.b	(A1)+
		clr.b	(A1)+
		clr.b	(A1)+
		adda.w	D0, A1
		dbf	D1, Offset_0x032192
		lea	(Horizontal_Scroll_Table+$0102).w, A1        ; $FFFFA902
		lea	(Horizontal_Scroll_Table+$013C).w, A5        ; $FFFFA93C
		lea	$0028(A5), A6
		move.w	(Screen_Pos_Buffer_Y).w, D0                  ; $FFFFEE84
		and.w	(Level_Layout_Wrap_Y).w, D0                  ; $FFFFEEAC
		moveq	#$09, D1
Offset_0x0321B4:
		move.w	D0, (A1)
		addq.w	#$04, A1
		clr.l	(A5)+
		clr.l	(A6)+
		dbf	D1, Offset_0x0321B4
		jsr	(AllocateObject)                     ; Offset_0x011DD8
		bne.s	Offset_0x03221A
		move.w	#$3C90, D1
		move.l	#$05C00790, D2
		move.l	#$FFFFA93C, D3
		moveq	#$09, D4
Offset_0x0321DA:
		move.l	#Obj_Earthquake_Tiles_Attributes, (A1) ; Offset_0x0325CE
		move.w	D1, x_pos(A1)                                    ; $0010
		move.w	D2, objoff_2E(A1)                                ; $002E
		move.l	D3, objoff_30(A1)                       ; $0030
                swap.w  D2
		jsr	(AllocateObject_Immediate)               ; Offset_0x011DC8
		bne.s	Offset_0x03221A
		move.l	#Obj_Earthquake_Tiles_Attributes, (A1) ; Offset_0x0325CE
		move.w	D1, x_pos(A1)                                    ; $0010
		move.w	D2, objoff_2E(A1)                                ; $002E
		move.l	D3, objoff_30(A1)                       ; $0030
		addi.w	#$0020, D1
                swap.w  D2
		addq.l	#$04, D3
		jsr	(AllocateObject_Immediate)               ; Offset_0x011DC8
		dbne	D4, Offset_0x0321DA
Offset_0x03221A:
		st	(Earthquake_Flag).w                          ; $FFFFEECC
		clr.w	(Background_Events+$06).w                    ; $FFFFEED8
		move.w	#$0002, (Special_Vint_Routine).w             ; $FFFFEEA6
Offset_0x032228:
		lea	(Horizontal_Scroll_Table+$0100).w, A1        ; $FFFFA900
		lea	$0028(A1), A4
		lea	$0014(A4), A5
		lea	MGz_2_Collapse_Scroll_Delay(PC), A6    ; Offset_0x03270A
		move.w	(Background_Events+$06).w, D0                ; $FFFFEED8
		addq.w	#$01, (Background_Events+$06).w              ; $FFFFEED8
		moveq	#$0A, D1
		moveq	#$09, D2
Offset_0x032244:
		cmp.w	(A6)+, D0
		bcs.s	Offset_0x032250
		addi.l	#$00000500, $0064(A1)
Offset_0x032250:
		move.l	$0064(A1), D3
		add.l	D3, (A5)+
		move.w	-4(A5), D3
		cmpi.w	#$02E0, D3
		bcs.s	Offset_0x032266
		move.w	#$02E0, D3
		subq.w	#$01, D1
Offset_0x032266:
		move.w	(Screen_Pos_Buffer_Y).w, D4                  ; $FFFFEE84
		sub.w	D3, D4
		move.w	D4, (A4)+
		move.w	D4, (A1)
		addq.w	#$04, A1
		dbf	D2, Offset_0x032244
		tst.w	D1
		bne.s	Offset_0x0322AE
		move.w	$002C(A3), A1
		lea	$0079(A1), A1
		move.w	-8(A3), D0
		subq.w	#$03, D0
		moveq	#$02, D1
Offset_0x03228A:
		clr.b	(A1)+
		clr.b	(A1)+
		clr.b	(A1)+
		adda.w	D0, A1
		dbf	D1, Offset_0x03228A
		clr.w	(Earthquake_Flag).w                          ; $FFFFEECC
		clr.l	(Background_Events+$08).w                    ; $FFFFEEDA
		move.w	(Screen_Pos_Buffer_X).w, (Background_Events+$0C).w ; $FFFFEE80, $FFFFEEDE
		move.w	#$0006, (Special_Vint_Routine).w             ; $FFFFEEA6
		addq.w	#$04, (Level_Events_Routine).w               ; $FFFFEEC0
Offset_0x0322AE:
		rts
;------------------------------------------------------------------------------- 
MGz_2_Quake:                                                   ; Offset_0x0322B0
		move.w	(Obj_Player_One+x_pos).w, D0                 ; $FFFFB010
		move.w	(Obj_Player_One+y_pos).w, D1                 ; $FFFFB014
		move.w	(Background_Events+$10).w, D2                ; $FFFFEEE2
		jmp	Offset_0x0322C0(pc,d2.w)                                
;-------------------------------------------------------------------------------    
Offset_0x0322C0:
		bra.w	MGz_Quake_0                            ; Offset_0x0322DC
		bra.w	MGz_Quake_1                            ; Offset_0x03233E
		bra.w	MGz_Quake_2                            ; Offset_0x032382
		bra.w	MGz_Quake_3                            ; Offset_0x0323CC
		bra.w	MGz_Quake_4                            ; Offset_0x032434
		bra.w	MGz_Quake_5                            ; Offset_0x03243E
		bra.w	MGz_Quake_6                            ; Offset_0x03245E
;-------------------------------------------------------------------------------  
MGz_Quake_0:                                                   ; Offset_0x0322DC
		lea	(Background_Events+$12).w, A5                ; $FFFFEEE4
		lea	MGz_Quake_Array(PC), A1                ; Offset_0x032606
		moveq	#$04, D2
		moveq	#$02, D3
Offset_0x0322E8:
		tst.b	(A5)
		bne.s	Offset_0x032330
		cmp.w	(A1), D0
		bcs.s	Offset_0x032330
		cmp.w	$0002(A1), D0
		bcc.s	Offset_0x032330
		cmp.w	render_flags(A1), D1                                ; $0004
		bcs.s	Offset_0x032330
		cmp.w	height_pixels(A1), D1                               ; $0006
		bcc.s	Offset_0x032330
		move.w	D2, (Background_Events+$10).w                ; $FFFFEEE2
		move.w	priority(A1), D0                             ; $0008
		move.w	D0, (Sonic_Level_Limits_Max_Y).w             ; $FFFFEE1A
		move.w	D0, (Level_Limits_Max_Y).w                   ; $FFFFEE12
		move.w	art_tile(A1), D0                             ; $000A
		cmpi.w	#$0004, D2
		bne.s	Offset_0x032326
		move.w	D0, (Sonic_Level_Limits_Max_X).w             ; $FFFFEE16
		move.w	D0, (Level_Limits_Max_X).w                   ; $FFFFEE0E
		rts
Offset_0x032326:
		move.w	D0, (Sonic_Level_Limits_Min_X).w             ; $FFFFEE14
		move.w	D0, (Level_Limits_Min_X).w                   ; $FFFFEE0C
		rts
Offset_0x032330:
		lea	mappings(A1), A1                                  ; $000C
		addq.w	#$01, A5
		addq.w	#$04, D2
		dbf	D3, Offset_0x0322E8
		rts                                                           
;-------------------------------------------------------------------------------
MGz_Quake_1:                                                   ; Offset_0x03233E
		cmpi.w	#$0780, D0
		bcs.w	Offset_0x032414
		move.w	(Sonic_Level_Limits_Max_X).w, D0             ; $FFFFEE16
		cmp.w	(Camera_X).w, D0                             ; $FFFFEE78
		bhi.s	Offset_0x032380
		move.w	D0, (Sonic_Level_Limits_Min_X).w             ; $FFFFEE14
		move.w	D0, (Level_Limits_Min_X).w                   ; $FFFFEE0C
		st	(Background_Events+$12).w                    ; $FFFFEEE4
		addi.w	#$000C, (Background_Events+$10).w            ; $FFFFEEE2
		st	(Earthquake_Flag).w                          ; $FFFFEECC
		jsr	(AllocateObject)                     ; Offset_0x011DD8
		bne.s	Offset_0x032380
		move.l	#Obj_0xAF_MGz_Drill_Mobile, (A1)       ; Offset_0x039920
		move.w	#$08E0, x_pos(A1)                                ; $0010
		move.w	#$0690, y_pos(A1)                                ; $0014
Offset_0x032380:
		rts 
;-------------------------------------------------------------------------------  
MGz_Quake_2:                                                   ; Offset_0x032382   
		cmpi.w	#$3200, D0
		bcc.w	 Offset_0x032414
		move.w	(Sonic_Level_Limits_Min_X).w, D0             ; $FFFFEE14
		cmp.w	(Camera_X).w, D0                             ; $FFFFEE78
		bcs.s	Offset_0x0323CA
		move.w	D0, (Sonic_Level_Limits_Max_X).w             ; $FFFFEE16
		move.w	D0, (Level_Limits_Max_X).w                   ; $FFFFEE0E
		st	(Background_Events+$13).w                    ; $FFFFEEE5
		addi.w	#$000C, (Background_Events+$10).w            ; $FFFFEEE2
		st	(Earthquake_Flag).w                          ; $FFFFEECC
		jsr	(AllocateObject)                     ; Offset_0x011DD8
		bne.s	Offset_0x0323CA
		move.l	#Obj_0xAF_MGz_Drill_Mobile, (A1)       ; Offset_0x039920
		bset	#$00, render_flags(A1)                              ; $0004
		move.w	#$3320, x_pos(A1)                                ; $0010
		move.w	#$0790, y_pos(A1)                                ; $0014
Offset_0x0323CA:
		rts       
;------------------------------------------------------------------------------- 
MGz_Quake_3:                                                   ; Offset_0x0323CC  
		cmpi.w	#$3480, D0
		bcc.s	Offset_0x032414
		move.w	(Sonic_Level_Limits_Min_X).w, D0             ; $FFFFEE14
		cmp.w	(Camera_X).w, D0                             ; $FFFFEE78
		bcs.s	Offset_0x032412
		move.w	D0, (Sonic_Level_Limits_Max_X).w             ; $FFFFEE16
		move.w	D0, (Level_Limits_Max_X).w                   ; $FFFFEE0E
		st	(Background_Events+$14).w                    ; $FFFFEEE6
		addi.w	#$000C, (Background_Events+$10).w            ; $FFFFEEE2
		st	(Earthquake_Flag).w                          ; $FFFFEECC
		jsr	(AllocateObject)                     ; Offset_0x011DD8
		bne.s	Offset_0x032412
		move.l	#Obj_0xAF_MGz_Drill_Mobile, (A1)       ; Offset_0x039920
		bset	#$00, render_flags(A1)                              ; $0004
		move.w	#$3300, x_pos(A1)                                ; $0010
		move.w	#$0780, y_pos(A1)                                ; $0014
Offset_0x032412:
		rts
Offset_0x032414:
		move.w	#$1000, D0
		move.w	D0, (Sonic_Level_Limits_Max_Y).w             ; $FFFFEE1A
		move.w	D0, (Level_Limits_Max_Y).w                   ; $FFFFEE12
		move.l	#$00006000, D0
		move.l	D0, (Sonic_Level_Limits_Min_X).w             ; $FFFFEE14
		move.l	D0, (Level_Limits_Min_X).w                   ; $FFFFEE0C
		clr.w	(Background_Events+$10).w                    ; $FFFFEEE2
		rts 
;------------------------------------------------------------------------------- 
MGz_Quake_4:                                                   ; Offset_0x032434  
		cmpi.w	#$0980, (Obj_Player_One+x_pos).w             ; $FFFFB010
		bcc.s	Offset_0x032468
		rts
;------------------------------------------------------------------------------- 
MGz_Quake_5:                                                   ; Offset_0x03243E
		cmpi.w	#$0100, (Obj_Player_One+y_pos).w             ; $FFFFB014
		bcc.s	Offset_0x03245C
		cmpi.w	#$2F80, (Obj_Player_One+x_pos).w             ; $FFFFB010
		bcs.s	Offset_0x03245C
		move.w	#$6000, D0
		move.w	D0, (Sonic_Level_Limits_Max_X).w             ; $FFFFEE16
		move.w	D0, (Level_Limits_Max_X).w                   ; $FFFFEE0E
		bra.s	Offset_0x032468
Offset_0x03245C:
		rts  
;------------------------------------------------------------------------------- 
MGz_Quake_6:                                                   ; Offset_0x03245E
		cmpi.w	#$3200, (Obj_Player_One+x_pos).w             ; $FFFFB010
		bcs.s	Offset_0x032468
		rts
Offset_0x032468:
		move.w	#$1000, D0
		move.w	D0, (Sonic_Level_Limits_Max_Y).w             ; $FFFFEE1A
		move.w	D0, (Level_Limits_Max_Y).w                   ; $FFFFEE12
		clr.w	(Background_Events+$10).w                    ; $FFFFEEE2
		rts
;------------------------------------------------------------------------------- 
MGz_2_Chunk:                                                   ; Offset_0x03247A
		move.w	(Background_Events+$04).w, D0                ; $FFFFEED6
		jmp	Offset_0x032482(pc,d0.w)  
;-------------------------------------------------------------------------------
Offset_0x032482:
		bra.w	MGz_Chunk_0                            ; Offset_0x032498
		bra.w	MGz_Chunk_1                            ; Offset_0x0324EE
		bra.w	MGz_Chunk_2                            ; Offset_0x03250C
		bra.w	MGz_Chunk_3                            ; Offset_0x03250C
		bra.w	MGz_Chunk_4                            ; Offset_0x03258A  
; Offset_0x032496:
		rts                
;-------------------------------------------------------------------------------  
MGz_Chunk_0:                                                   ; Offset_0x032498 
		move.w	(Obj_Player_One+x_pos).w, D0                 ; $FFFFB010
		move.w	(Obj_Player_One+y_pos).w, D1                 ; $FFFFB014
		lea	MGz_Chunk_Array(PC), A1                ; Offset_0x03262A
		moveq	#$04, D2
		moveq	#$02, D3
Offset_0x0324A8:
		cmp.w	(A1), D0
		bcs.s	Offset_0x0324CA
		cmp.w	$0002(A1), D0
		bcc.s	Offset_0x0324CA
		cmp.w	$0004(A1), D1
		bcs.s	Offset_0x0324CA
		cmp.w	$0006(A1), D1
		bcc.s	Offset_0x0324CA
		cmpi.w	#$0004, D2
		bne.s	Offset_0x0324D6
		tst.w	(Earthquake_Flag).w                          ; $FFFFEECC
		bmi.s	Offset_0x0324D6
Offset_0x0324CA:
		lea	$000C(A1), A1
		addq.w	#$04, D2
		dbf	D3, Offset_0x0324A8
		rts
Offset_0x0324D6:
		move.w	D2, (Background_Events+$04).w                ; $FFFFEED6
		clr.w	(Background_Events+$06).w                    ; $FFFFEED8
		clr.w	(Background_Events+$08).w                    ; $FFFFEEDA
		move.w	$0008(A1), (Background_Events+$0A).w         ; $FFFFEEDC
		move.w	$000A(A1), (Background_Events+$0C).w         ; $FFFFEEDE
;------------------------------------------------------------------------------- 
MGz_Chunk_1:                                                   ; Offset_0x0324EE                 
		move.w	(Background_Events+$06).w, D0                ; $FFFFEED8
		cmpi.w	#$005C, D0
		bcs.s	Offset_0x03252A
		clr.w	(Earthquake_Flag).w                          ; $FFFFEECC
		clr.w	(Sonic_Level_Limits_Min_X).w                 ; $FFFFEE14
		clr.w	(Level_Limits_Min_X).w                       ; $FFFFEE0C
		move.w	#$0010, (Background_Events+$04).w            ; $FFFFEED6
		rts   
;------------------------------------------------------------------------------- 
MGz_Chunk_2:                                                   ; Offset_0x03250C
MGz_Chunk_3:                                                   ; Offset_0x03250C
		move.w	(Background_Events+$06).w, D0                ; $FFFFEED8
		cmpi.w	#$005C, D0
		bcs.s	Offset_0x03252A
		move.w	#$6000, D0
		move.w	D0, (Sonic_Level_Limits_Max_X).w             ; $FFFFEE16
		move.w	D0, (Level_Limits_Max_X).w                   ; $FFFFEE0E
		move.w	#$0014, (Background_Events+$04).w            ; $FFFFEED6
		rts
Offset_0x03252A:
		subq.w	#$01, (Background_Events+$08).w              ; $FFFFEEDA
		bpl.s	Offset_0x032588
		move.w	#$0006, (Background_Events+$08).w            ; $FFFFEEDA
		move.w	D0, D2
		bsr.s	MGz_Change_Chunk                       ; Offset_0x03259C
		move.w	(Background_Events+$0A).w, D0                ; $FFFFEEDC
		addi.w	#$0080, D0
		sub.w	(Screen_Pos_Buffer_X).w, D0                  ; $FFFFEE80
		bcs.s	Offset_0x032588
		cmpi.w	#$01C0, D0
		bcc.s	Offset_0x032588
		move.w	(Background_Events+$0C).w, D0                ; $FFFFEEDE
		lea	MGz_2_Screen_Redraw_Array(PC), A1      ; Offset_0x03264E
		add.w	$00(A1, D2), D0
		move.w	$02(A1, D2), D2
Offset_0x03255E:
		move.w	(Screen_Pos_Buffer_Y).w, D3                  ; $FFFFEE84
		and.w	(Level_Layout_Wrap_Y).w, D3                  ; $FFFFEEAC
		cmp.w	D3, D0
		bcs.s	Offset_0x032580
		addi.w	#$00F0, D3
		cmp.w	D3, D0
		bcc.s	Offset_0x032580
		move.w	(Background_Events+$0A).w, D1                ; $FFFFEEDC
		moveq	#$08, D6
                swap.w  D2
		jsr	Setup_Tile_Row_Draw(PC)                ; Offset_0x02F93E
                swap.w  D2
Offset_0x032580:
		addi.w	#$0010, D0
		dbf	D2, Offset_0x03255E
Offset_0x032588:
		rts   
;------------------------------------------------------------------------------- 
MGz_Chunk_4:                                                   ; Offset_0x03258A
		cmpi.w	#$2A00, (Obj_Player_One+x_pos).w             ; $FFFFB010
		bcs.s	Offset_0x03259A
		clr.w	(Background_Events+$04).w                    ; $FFFFEED6
		moveq	#$5C, D0
		bra.s	MGz_Change_Chunk                       ; Offset_0x03259C
Offset_0x03259A:
		rts
;-------------------------------------------------------------------------------                 
MGz_Change_Chunk:                                              ; Offset_0x03259C
		lea	MGz_2_Chunk_Replace_Array(PC), A1      ; Offset_0x0326AA
		lea	((M68K_RAM_Start+$5900)&$00FFFFFF), A5       ; $00FF5900
		bsr.s	Offset_0x0325AE
		lea	((M68K_RAM_Start+$7500)&$00FFFFFF), A5       ; $00FF7500
Offset_0x0325AE:
		lea	(Marble_Garden_2_Dynamic_Chunks), A4   ; Offset_0x1649DA
		adda.w	$00(A1, D0), A4
		moveq	#$07, D1
Offset_0x0325BA:
		move.l	(A4)+, (A5)+
		move.l	(A4)+, (A5)+
		move.l	(A4)+, (A5)+
		move.l	(A4)+, (A5)+
		dbf	D1, Offset_0x0325BA
		addq.w	#$02, D0
		move.w	D0, (Background_Events+$06).w                ; $FFFFEED8
		rts   
;-------------------------------------------------------------------------------  
Obj_Earthquake_Tiles_Attributes:                               ; Offset_0x0325CE
                include 'data\objects\earthqka.asm'
;------------------------------------------------------------------------------- 
MGz_Quake_Array:                                               ; Offset_0x032606
		dc.w	$0780, $07C0, $0580, $0600, $05A0, $07E0, $31C0, $3200
		dc.w	$01C0, $0280, $01E0, $2F60, $3440, $3480, $0680, $0700
		dc.w	$06A0, $32C0   
;------------------------------------------------------------------------------- 
MGz_Chunk_Array:                                               ; Offset_0x03262A
		dc.w	$0F6C, $0F78, $0538, $0580, $0F00, $0500, $3680, $3700
		dc.w	$02F0, $0380, $3700, $0280, $3000, $3080, $0770, $0800
		dc.w	$3080, $0700
;-------------------------------------------------------------------------------  
MGz_2_Screen_Redraw_Array:                                     ; Offset_0x03264E
		dc.w	$0040, $0003, $0050, $0003, $0050, $0004, $0060, $0004
		dc.w	$0060, $0003, $0070, $0002, $0070, $0003, $0080, $0003
		dc.w	$0080, $0003, $0080, $0004, $0080, $0004, $0080, $0004
		dc.w	$0080, $0005, $0090, $0005, $00A0, $0004, $0090, $0006
		dc.w	$0080, $0006, $0090, $0006, $00A0, $0005, $00B0, $0004
		dc.w	$00C0, $0003, $00D0, $0002, $00E0, $0001
;------------------------------------------------------------------------------- 
MGz_2_Chunk_Replace_Array:                                     ; Offset_0x0326AA
		dc.w	$0100, $0500, $0180, $0580, $0200, $0600, $0280, $0680
		dc.w	$0300, $0700, $0380, $0780, $0000, $0800, $0000, $0880
		dc.w	$0000, $0900, $0000, $0980, $0000, $0A00, $0000, $0A80
		dc.w	$0000, $0B00, $0000, $0B80, $0000, $0C00, $0000, $0C80
		dc.w	$0000, $0D00, $0000, $0D80, $0000, $0E00, $0000, $0E80
		dc.w	$0000, $0F00, $0000, $0F80, $0000, $1000, $0080, $0480 
;------------------------------------------------------------------------------- 
MGz_2_Collapse_Scroll_Delay:                                   ; Offset_0x03270A
		dc.w	$000A, $0010, $0002, $0008, $000E, $0006, $0000, $000C
		dc.w	$0012, $0004  
;------------------------------------------------------------------------------- 
MGz_2_Vertical_Scroll_Array:                                   ; Offset_0x03271E
		dc.w	$3CA0, $0020, $0020, $0020, $0020, $0020, $0020, $0020
		dc.w	$0020, $7FFF
;-------------------------------------------------------------------------------
MGz_2_Events_Init_2:                                           ; Offset_0x032732
		jsr	MGz_2_Clear_Bottom_Background(PC)      ; Offset_0x032968
		move.w	#$0004, (Level_Events_Routine_2).w           ; $FFFFEEC2
		move.w	(Obj_Player_One+x_pos).w, D0                 ; $FFFFB010
		move.w	(Obj_Player_One+y_pos).w, D1                 ; $FFFFB014
		cmpi.w	#$0500, D1
		bcc.s	Offset_0x03276A
		cmpi.w	#$3800, D0
		bcs.s	Offset_0x0327B6
		move.w	#$0004, (Background_Events).w                ; $FFFFEED2
		move.l	#Obj_MGz_2_Move_Bg_Knuckles_Path, D1   ; Offset_0x032A6A
		cmpi.w	#$3A80, D0
		bcs.s	Offset_0x0327AC
		move.w	#$0220, (Background_Events+$02).w            ; $FFFFEED4
		bra.s	Offset_0x0327B6
Offset_0x03276A:
		cmpi.w	#$0800, D1
		bcs.s	Offset_0x032790
		cmpi.w	#$34C0, D0
		bcs.s	Offset_0x0327B6
		move.w	#$0008, (Background_Events).w                ; $FFFFEED2
		move.l	#Obj_MGz_2_Move_Bg_Sonic_Path, D1      ; Offset_0x032A7E
		cmpi.w	#$3800, D0
		bcs.s	Offset_0x0327AC
		move.w	#$01D0, (Background_Events+$02).w            ; $FFFFEED4
		bra.s	Offset_0x0327B6
Offset_0x032790:
		cmpi.w	#$3900, D0
		bcs.s	Offset_0x0327B6
		move.w	#$000C, (Background_Events).w                ; $FFFFEED2
		move.w	#$01D0, (Background_Events+$02).w            ; $FFFFEED4
		st	(Background_Events+$0E).w                    ; $FFFFEEE0
		clr.l	(Horizontal_Scroll_Table+$0038).w            ; $FFFFA838
		bra.s	Offset_0x0327B6
Offset_0x0327AC:
		jsr	(AllocateObject)                     ; Offset_0x011DD8
		bne.s	Offset_0x0327B6
		move.l	D1, (A1)
Offset_0x0327B6:
		jsr	MGz_2_Deform(PC)                       ; Offset_0x03287A
		jsr	Reset_Tile_Offset_Position_Actual_2(PC) ; Offset_0x02FF0E
		clr.l	(Horizontal_Scroll_Table).w                  ; $FFFFA800
		move.w	D2, (Horizontal_Scroll_Table+$0006).w        ; $FFFFA806
		lea	MGz_2_Draw_Array(PC), A4               ; Offset_0x032B2E
		lea	(Horizontal_Scroll_Table).w, A5              ; $FFFFA800
		jsr	Refresh_Plane_Tile_Deform(PC)          ; Offset_0x02FA9A
		lea	MGz_2_Deform_Array(PC), A4             ; Offset_0x032B32
		lea	(Horizontal_Scroll_Table+$0008).w, A5        ; $FFFFA808
		jmp	Apply_Deformation(PC)                  ; Offset_0x02FD7C  
;-------------------------------------------------------------------------------    
MGz_2_Events_Run_2:                                            ; Offset_0x0327DE
		move.w	(Level_Events_Routine_2).w, D0               ; $FFFFEEC2
		jmp	Offset_0x0327E6(pc,d0.w) 
;-------------------------------------------------------------------------------
Offset_0x0327E6:
		bra.w	MGz_2_Refresh                          ; Offset_0x0327F2
		bra.w	MGz_2_Normal_2                         ; Offset_0x032800
		bra.w	MGz_2_Refresh_2                        ; Offset_0x03285E   
;-------------------------------------------------------------------------------  
MGz_2_Refresh:                                                 ; Offset_0x0327F2
		jsr	MGz_2_Clear_Bottom_Background(PC)      ; Offset_0x032968
		clr.l	(Horizontal_Scroll_Table).w                  ; $FFFFA800
		addq.w	#$04, (Level_Events_Routine_2).w             ; $FFFFEEC2
		bra.s	Offset_0x03283A   
;------------------------------------------------------------------------------- 
MGz_2_Normal_2:                                                ; Offset_0x032800
		jsr	MGz_2_Event_Trigger(PC)                ; Offset_0x03297A
		bne.s	Offset_0x03283A
		jsr	MGz_2_Deform(PC)                       ; Offset_0x03287A
Offset_0x03280A:                
		lea	MGz_2_Draw_Array(PC), A4               ; Offset_0x032B2E
		lea	(Horizontal_Scroll_Table).w, A5              ; $FFFFA800
		moveq	#$20, D6
		moveq	#$02, D5
		jsr	Draw_Background(PC)                    ; Offset_0x02FB74
		lea	MGz_2_Deform_Array(PC), A4             ; Offset_0x032B32
		lea	(Horizontal_Scroll_Table+$0008).w, A5        ; $FFFFA808
		jsr	Apply_Deformation(PC)                  ; Offset_0x02FD7C
		lea	MGz_2_Vertical_Scroll_Array(PC), A4    ; Offset_0x03271E
		lea	(Horizontal_Scroll_Table+$0126).w, A5        ; $FFFFA926
		jsr	Apply_Foreground_Vertical_Scroll(PC)   ; Offset_0x02FEA4
		jsr	Calc_Screen_Pos_Difference(PC)         ; Offset_0x02FF8A
		jmp	Earthquake_Setup(PC)                   ; Offset_0x02FFA4
Offset_0x03283A:
		jsr	MGz_2_Deform(PC)                       ; Offset_0x03287A
		jsr	Reset_Tile_Offset_Position_Actual_2(PC) ; Offset_0x02FF0E
		move.w	D2, (Horizontal_Scroll_Table+$0006).w        ; $FFFFA806
		addi.w	#$00E0, D0
		and.w	(Level_Layout_Wrap_Y).w, D0                  ; $FFFFEEAC
		move.w	D0, (Draw_Delayed_Position).w                ; $FFFFEEC8
		move.w	#$000F, (Draw_Delayed_Position_Rowcount).w   ; $FFFFEECA
		addq.w	#$04, (Level_Events_Routine_2).w             ; $FFFFEEC2
		bra.s	Offset_0x032862        
;------------------------------------------------------------------------------- 
MGz_2_Refresh_2:                                               ; Offset_0x03285E
		jsr	MGz_2_Deform(PC)                       ; Offset_0x03287A
Offset_0x032862:
		lea	MGz_2_Draw_Array(PC), A4               ; Offset_0x032B2E
		lea	(Horizontal_Scroll_Table-$0004).w, A5        ; $FFFFA7FC
		move.w	(Screen_Pos_Buffer_Y_2).w, D1                ; $FFFFEE90
		jsr	Draw_Plane_Vertical_Bottom_Up_Complex(PC) ; Offset_0x02FD00
		bpl.s	Offset_0x03280A
		subq.w	#$04, (Level_Events_Routine_2).w             ; $FFFFEEC2
		bra.s	Offset_0x03280A 
;------------------------------------------------------------------------------- 
MGz_2_Deform:                                                  ; Offset_0x03287A
		move.w	(Background_Events).w, D0                    ; $FFFFEED2
		jmp	Offset_0x032882(pc,d0.w)   
;------------------------------------------------------------------------------- 
Offset_0x032882:
		bra.w	MGz_2_Deform_0                         ; Offset_0x0328C8
		bra.w	MGz_2_Deform_1                         ; Offset_0x03289E
		bra.w	MGz_2_Deform_2                         ; Offset_0x032894 
; Offset_0x03288E:
		move.w	#$0500, D1
		bra.s	Offset_0x0328CA
;------------------------------------------------------------------------------- 
MGz_2_Deform_2:                                                ; Offset_0x032894 
		move.w	#$08F0, D1
		move.w	#$3200, D2
		bra.s	Offset_0x0328A6
;------------------------------------------------------------------------------- 
MGz_2_Deform_1:                                                ; Offset_0x03289E  
		move.w	#$01E0, D1
		move.w	#$3580, D2
Offset_0x0328A6:
		move.w	(Screen_Pos_Buffer_Y).w, D0                  ; $FFFFEE84
		sub.w	D1, D0
		add.w	(Background_Events+$02).w, D0                ; $FFFFEED4
		move.w	D0, (Screen_Pos_Buffer_Y_2).w                ; $FFFFEE90
		move.w	(Screen_Pos_Buffer_X).w, D0                  ; $FFFFEE80
		sub.w	D2, D0
		move.w	D0, (Screen_Pos_Buffer_X_2).w                ; $FFFFEE8C
		move.w	D0, (Horizontal_Scroll_Table+$0004).w        ; $FFFFA804
		move.w	D0, (Horizontal_Scroll_Table+$0036).w        ; $FFFFA836
		bra.s	Offset_0x0328F6
;------------------------------------------------------------------------------- 
MGz_2_Deform_0:                                                ; Offset_0x0328C8  
		moveq	#$00, D1
Offset_0x0328CA:
		move.w	(Screen_Pos_Buffer_Y).w, D0                  ; $FFFFEE84
		move.w	(Earthquake_Offset).w, D2                    ; $FFFFEECE
		sub.w	D2, D0
		sub.w	D1, D0
                swap.w  D0
		clr.w	D0
		asr.l	#$04, D0
		move.l	D0, D1
		add.l	D0, D0
		add.l	D1, D0
                swap.w  D0
		add.w	D2, D0
		move.w	D0, (Screen_Pos_Buffer_Y_2).w                ; $FFFFEE90
		clr.w	(Screen_Pos_Buffer_X_2).w                    ; $FFFFEE8C
		clr.w	(Horizontal_Scroll_Table+$0004).w            ; $FFFFA804
		clr.w	(Horizontal_Scroll_Table+$0036).w            ; $FFFFA836
Offset_0x0328F6:
		move.w	(Screen_Pos_Buffer_X).w, D0                  ; $FFFFEE80
		cmpi.w	#$0008, (Level_Events_Routine).w             ; $FFFFEEC0
		bne.s	Offset_0x032906
		move.w	(Background_Events+$0C).w, D0                ; $FFFFEEDE
Offset_0x032906:
                swap.w  D0
		clr.w	D0
		asr.l	#$01, D0
		move.l	D0, D1
		asr.l	#$03, D1
		move.l	D1, D2
		asr.l	#$02, D2
		lea	(Horizontal_Scroll_Table+$0036).w, A1        ; $FFFFA836
		moveq	#$07, D3
Offset_0x03291A:
                swap.w  D0
		move.w	D0, -(A1)
                swap.w  D0
		sub.l	D1, D0
		dbf	D3, Offset_0x03291A
		tst.w	(Background_Events+$0E).w                    ; $FFFFEEE0
		bne.s	Offset_0x032934
		addi.l	#$00000800, (Horizontal_Scroll_Table+$0038).w ; $FFFFA838
Offset_0x032934:
		move.l	(Horizontal_Scroll_Table+$0038).w, D1        ; $FFFFA838
		lea	(Horizontal_Scroll_Table+$0008).w, A1        ; $FFFFA808
		lea	MGz_2_Deform_Index(PC), A5             ; Offset_0x032B62
		move.l	D2, D0
		asr.l	#$01, D2
		moveq	#$0E, D3
Offset_0x032946:
		move.w	(A5)+, D4
		add.l	D1, D0
                swap.w  D0
		move.w	D0, $00(A1, D4)
                swap.w  D0
		add.l	D2, D0
		dbf	D3, Offset_0x032946
		lea	MGz_2_Deform_Offset(PC), A5            ; Offset_0x032B80
		moveq	#$16, D0
Offset_0x03295E:
		move.w	(A5)+, D1
		add.w	D1, (A1)+
		dbf	D0, Offset_0x03295E
		rts                    
;-------------------------------------------------------------------------------  
MGz_2_Clear_Bottom_Background:                                 ; Offset_0x032968
		move.w	(A3), D0
		addq.w	#$08, D0
		move.w	D0, $0074(A3)
		move.w	D0, $0078(A3)
		move.w	D0, $007C(A3)
		rts 
;-------------------------------------------------------------------------------  
MGz_2_Event_Trigger:                                           ; Offset_0x03297A
		move.w	(Obj_Player_One+x_pos).w, D0                 ; $FFFFB010
		move.w	(Obj_Player_One+y_pos).w, D1                 ; $FFFFB014
		move.w	(Background_Events).w, D2                    ; $FFFFEED2
		jmp	Offset_0x03298A(pc,d2.w) 
;------------------------------------------------------------------------------- 
Offset_0x03298A:
		bra.w	Event_Trigger_0                        ; Offset_0x032A18
		bra.w	Event_Trigger_1                        ; Offset_0x0329EA
		bra.w	Event_Trigger_2                        ; Offset_0x0329B2 
; Offset_0x032996:
		clr.b	(Background_Collision_Flag).w                ; $FFFFF664
		cmpi.w	#$0800, D1
		bcs.w	Offset_0x032A66
		cmpi.w	#$3A40, D0
		bcs.w	Offset_0x032A66
		move.w	#$0008, (Background_Events).w                ; $FFFFEED2
		rts
;-------------------------------------------------------------------------------  
Event_Trigger_2:                                               ; Offset_0x0329B2  
		st	(Background_Collision_Flag).w                ; $FFFFF664
		cmpi.w	#$0800, D1
		bcc.s	Offset_0x0329D0
		cmpi.w	#$3900, D0
		bcs.w	Offset_0x032A66
		st	(Background_Events+$0E).w                    ; $FFFFEEE0
		clr.l	(Horizontal_Scroll_Table+$0038).w            ; $FFFFA838
		moveq	#$0C, D0
		bra.s	Offset_0x0329E2
Offset_0x0329D0:
		cmpi.w	#$0900, D1
		bcc.w	 Offset_0x032A66
		cmpi.w	#$34C0, D0
		bcc.w	 Offset_0x032A66
		moveq	#$00, D0
Offset_0x0329E2:
		move.w	D0, (Background_Events).w                    ; $FFFFEED2
		moveq	#-$01, D0
		rts
;-------------------------------------------------------------------------------                
Event_Trigger_1:                                               ; Offset_0x0329EA 
		st	(Background_Collision_Flag).w                ; $FFFFF664
		cmpi.w	#$0100, D1
		bcc.s	Offset_0x0329FE
		cmpi.w	#$3C00, D0
		bcs.s	Offset_0x0329FE
		clr.b	(Background_Collision_Flag).w                ; $FFFFF664
Offset_0x0329FE:
		cmpi.w	#$0080, D1
		bcs.s	Offset_0x032A66
		cmpi.w	#$0180, D1
		bcc.s	Offset_0x032A66
		cmpi.w	#$3800, D0
		bcc.s	Offset_0x032A66
		clr.w	(Background_Events).w                        ; $FFFFEED2
		moveq	#-$01, D0
		rts
;-------------------------------------------------------------------------------                
Event_Trigger_0:                                               ; Offset_0x032A18
		clr.b	(Background_Collision_Flag).w                ; $FFFFF664
		cmpi.w	#$0080, D1
		bcs.s	Offset_0x032A66
		cmpi.w	#$0180, D1
		bcc.s	Offset_0x032A38
		cmpi.w	#$3800, D0
		bcs.s	Offset_0x032A66
		moveq	#$04, D0
		move.l	#Obj_MGz_2_Move_Bg_Knuckles_Path, D1   ; Offset_0x032A6A
		bra.s	Offset_0x032A52
Offset_0x032A38:
		cmpi.w	#$0800, D1
		bcs.s	Offset_0x032A66
		cmpi.w	#$0900, D1
		bcc.s	Offset_0x032A66
		cmpi.w	#$34C0, D0
		bcs.s	Offset_0x032A66
		moveq	#$08, D0
		move.l	#Obj_MGz_2_Move_Bg_Sonic_Path, D1      ; Offset_0x032A7E
Offset_0x032A52:
		move.w	D0, (Background_Events).w                    ; $FFFFEED2
		clr.w	(Background_Events+$02).w                    ; $FFFFEED4
		jsr	(AllocateObject)                     ; Offset_0x011DD8
		bne.s	Offset_0x032A64
		move.l	D1, (A1)
Offset_0x032A64:
		rts
Offset_0x032A66:
		moveq	#$00, D0
		rts
;-------------------------------------------------------------------------------
; Obj_MGz_2_Move_Bg_Knuckles_Path:                             ; Offset_0x032A6A 
; Obj_MGz_2_Move_Bg_Sonic_Path:                                ; Offset_0x032A7E
                include 'data\objects\mgz_mvbg.asm' 
;------------------------------------------------------------------------------- 
MGz_2_Draw_Array:                                              ; Offset_0x032B2E
		dc.w	$0200, $7FFF  
;------------------------------------------------------------------------------- 
MGz_2_Deform_Array:                                            ; Offset_0x032B32
		dc.w	$0010, $0010, $0010, $0010, $0010, $0018, $0008, $0010
		dc.w	$0008, $0008, $0010, $0008, $0008, $0008, $0005, $002B
		dc.w	$000C, $0006, $0006, $0008, $0008, $0018, $00D8, $7FFF
;------------------------------------------------------------------------------- 
MGz_2_Deform_Index:                                            ; Offset_0x032B62
		dc.w	$001C, $0018, $001A, $000C, $0006, $0014, $0002, $0010
		dc.w	$0016, $0012, $000A, $0000, $0008, $0004, $000E 
;-------------------------------------------------------------------------------  
MGz_2_Deform_Offset:                                           ; Offset_0x032B80
		dc.w	$FFFB, $FFF8, $0009, $000A, $0002, $FFF4, $0003, $0010
		dc.w	$FFFF, $000D, $FFF1, $0006, $FFF5, $FFFC, $000E, $FFF8
		dc.w	$0010, $0008, $0000, $FFF8, $0010, $0008, $0000 
;------------------------------------------------------------------------------- 
CNz_1_Events_Init:                                             ; Offset_0x032BAE
CNz_2_Events_Init:                                             ; Offset_0x032BAE  
		jsr	Reset_Tile_Offset_Position_Actual(PC)  ; Offset_0x02FEF2
		jmp	Refresh_Plane_Full(PC)                 ; Offset_0x02FA7C 
;------------------------------------------------------------------------------- 
CNz_1_Events_Run:                                              ; Offset_0x032BB6
CNz_2_Events_Run:                                              ; Offset_0x032BB6   
		tst.w	(Background_Events+$06).w                    ; $FFFFEED8
		beq.s	Offset_0x032BC4
		clr.w	(Background_Events+$06).w                    ; $FFFFEED8
		jmp	Refresh_Plane_Screen_Direct(PC)        ; Offset_0x02FAE0
Offset_0x032BC4:
		jsr	Offset_0x032BCC(PC)
		jmp	LoadTilesAsYouMove_Foreground(PC)             ; Offset_0x02FB0E
;-------------------------------------------------------------------------------
Offset_0x032BCC:
		lea	(Background_Events).w, A5                    ; $FFFFEED2
		tst.l	(A5)
		beq.w	Offset_0x032C88
		move.w	(A5)+, D0
		move.w	(A5), D1
		clr.l	-2(A5)
		move.w	D0, D2
		move.w	D1, D3
		asr.w	#$03, D2
		move.w	D2, D4
		asr.w	#$04, D2
		move.w	D3, D5
		asr.w	#$05, D3
		and.w	(Level_Layout_Wrap_Row).w, D3                ; $FFFFEEAE
		move.w	$00(A3, D3), A4
		moveq	#-$01, D6
		clr.w	D6
		move.b	$00(A4, D2), D6
		lsl.w	#$07, D6
		andi.w	#$000C, D4
		andi.w	#$0060, D5
		add.w	D4, D6
		add.w	D5, D6
		move.l	D6, A4
		clr.l	(A4)
		clr.l	$0010(A4)
		asr.w	#$02, D0
		andi.w	#$0078, D0
		lsl.w	#$04, D1
		andi.w	#$0E00, D1
		add.w	D1, D0
		add.w	D7, D0
		moveq	#$00, D1
		move.w	D0, (A0)+
		move.w	#$0001, (A0)+
		move.l	D1, (A0)+
		move.l	D1, (A0)+
		move.l	D1, (A0)+
		move.l	D1, (A0)+
		addi.w	#$0100, D0
		move.w	D0, (A0)+
		move.w	#$0001, (A0)+
		move.l	D1, (A0)+
		move.l	D1, (A0)+
		move.l	D1, (A0)+
		move.l	D1, (A0)+
		clr.w	(A0)
		move.w	$0018(A3), A4
		lea	$0064(A4), A4
		moveq	#$00, D1
		clr.w	(Background_Events+$04).w                    ; $FFFFEED6
		moveq	#$03, D3
Offset_0x032C56:
		lea	(A4), A5
		moveq	#$02, D2
Offset_0x032C5A:
		moveq	#-$01, D0
		clr.w	D0
		move.b	(A5)+, D0
		lsl.w	#$07, D0
		add.w	D1, D0
		move.l	D0, A6
		tst.l	(A6)+
		bne.s	Offset_0x032C88
		tst.l	(A6)+
		bne.s	Offset_0x032C88
		tst.l	(A6)+
		bne.s	Offset_0x032C88
		tst.l	(A6)
		bne.s	Offset_0x032C88
		dbf	D2, Offset_0x032C5A
		addi.w	#$0020, D1
		addi.w	#$0020, (Background_Events+$04).w            ; $FFFFEED6
		dbf	D3, Offset_0x032C56
Offset_0x032C88:
		rts   
;------------------------------------------------------------------------------- 
CNz_1_Events_Init_2:                                           ; Offset_0x032C8A
CNz_2_Events_Init_2:                                           ; Offset_0x032C8A 
		jsr	CNz_Deform(PC)                         ; Offset_0x032CC4
		jsr	Reset_Tile_Offset_Position_Actual_2(PC) ; Offset_0x02FF0E
		moveq	#$00, D1
		jsr	Refresh_Plane_Full(PC)                 ; Offset_0x02FA7C
		lea	CNz_Deform_Array(PC), A4               ; Offset_0x032D2C
		lea	(Horizontal_Scroll_Table).w, A5              ; $FFFFA800
		jmp	Apply_Deformation(PC)                  ; Offset_0x02FD7C
;------------------------------------------------------------------------------- 
CNz_1_Events_Run_2:                                            ; Offset_0x032CA4
CNz_2_Events_Run_2:                                            ; Offset_0x032CA4
		jsr	CNz_Deform(PC)                         ; Offset_0x032CC4
		lea	(Screen_Pos_Buffer_Y_2).w, A6                ; $FFFFEE90
		lea	(Screen_Pos_Rounded_Y_2).w, A5               ; $FFFFEE96
		moveq	#$00, D1
		moveq	#$20, D6
		jsr	DrawBlockRow(PC)                      ; Offset_0x02F8AA
		lea	CNz_Deform_Array(PC), A4               ; Offset_0x032D2C
		lea	(Horizontal_Scroll_Table).w, A5              ; $FFFFA800
		jmp	Apply_Deformation(PC)                  ; Offset_0x02FD7C
;------------------------------------------------------------------------------- 
CNz_Deform:                                                    ; Offset_0x032CC4
		move.w	(Screen_Pos_Buffer_Y).w, D0                  ; $FFFFEE84
                swap.w  D0
		clr.w	D0
		asr.l	#$04, D0
		move.l	D0, D1
		asr.l	#$01, D1
		add.l	D1, D0
		asr.l	#$02, D1
		add.l	D1, D0
                swap.w  D0
		move.w	D0, (Screen_Pos_Buffer_Y_2).w                ; $FFFFEE90
		move.w	(Screen_Pos_Buffer_X).w, D0                  ; $FFFFEE80
                swap.w  D0
		clr.w	D0
		asr.l	#$01, D0
		move.l	D0, D1
		asr.l	#$03, D1
		lea	(Horizontal_Scroll_Table+$000A).w, A1        ; $FFFFA80A
                swap.w  D0
		move.w	D0, -(A1)
                swap.w  D0
		sub.l	D1, D0
                swap.w  D0
		move.w	D0, (Screen_Pos_Buffer_X_2).w                ; $FFFFEE8C
		move.w	D0, -(A1)
                swap.w  D0
		sub.l	D1, D0
		sub.l	D1, D0
                swap.w  D0
		move.w	D0, (Background_Events+$10).w                ; $FFFFEEE2
                swap.w  D0
		sub.l	D1, D0
                swap.w  D0
		move.w	D0, -(A1)
                swap.w  D0
		sub.l	D1, D0
		sub.l	D1, D0
                swap.w  D0
		move.w	D0, -(A1)
                swap.w  D0
		sub.l	D1, D0
		asr.l	#$01, D1
		sub.l	D1, D0
                swap.w  D0
		move.w	D0, -(A1)
		rts 
;-------------------------------------------------------------------------------                 
CNz_Deform_Array:                                              ; Offset_0x032D2C
		dc.w	$0080, $0030, $0060, $00C0, $7FFF
;-------------------------------------------------------------------------------   
Iz_1_Events_Init:                                              ; Offset_0x032D36
		move.w	#$07FF, (Screen_Wrap_Y).w                    ; $FFFFEEAA
		move.w	#$07F0, (Level_Layout_Wrap_Y).w              ; $FFFFEEAC
		move.w	#$003C, (Level_Layout_Wrap_Row).w            ; $FFFFEEAE
		jsr	Reset_Tile_Offset_Position_Actual(PC)  ; Offset_0x02FEF2
		jmp	Refresh_Plane_Full(PC)                 ; Offset_0x02FA7C
;-------------------------------------------------------------------------------  
Iz_1_Events_Run:                                               ; Offset_0x032D50
		move.w	(Level_Events_Routine_2).w, D0               ; $FFFFEEC2
		jmp	Offset_0x032D58(pc,d0.w)                    
;-------------------------------------------------------------------------------
Offset_0x032D58:
		bra.w	Iz_1_Init                              ; Offset_0x032D70
		bra.w	Iz_1_Wait_Quake                        ; Offset_0x032D7A
		bra.w	Iz_1_Normal                            ; Offset_0x032D82
		bra.w	Iz_1_Normal                            ; Offset_0x032D82
		bra.w	Iz_1_Normal                            ; Offset_0x032D82
		bra.w	Iz_1_Normal                            ; Offset_0x032D82 
;-------------------------------------------------------------------------------
Iz_1_Init:                                                     ; Offset_0x032D70
		move.w	(Earthquake_Offset).w, D0                    ; $FFFFEECE
		add.w	D0, (Screen_Pos_Buffer_X).w                  ; $FFFFEE80
		bra.s	Iz_1_Normal                            ; Offset_0x032D82         
;-------------------------------------------------------------------------------
Iz_1_Wait_Quake:                                               ; Offset_0x032D7A
		move.w	(Earthquake_Offset).w, D0                    ; $FFFFEECE
		add.w	D0, (Screen_Pos_Buffer_Y).w                  ; $FFFFEE84    
;-------------------------------------------------------------------------------
Iz_1_Normal:                                                   ; Offset_0x032D82
		jmp	LoadTilesAsYouMove_Foreground(PC)             ; Offset_0x02FB0E   
;------------------------------------------------------------------------------- 
Iz_1_Events_Init_2:                                            ; Offset_0x032D86
		lea	(A3), A1
		moveq	#$07, D0
Offset_0x032D8A:
		move.w	(A1), $0020(A1)
		addq.w	#$04, A1
		dbf	D0, Offset_0x032D8A
		move.w	(Screen_Pos_Buffer_Y).w, (Level_Events_Buffer_0).w ; $FFFFEE84, $FFFFEEB4
		move.w	(Screen_Pos_Buffer_Y).w, (Level_Events_Buffer_1).w ; $FFFFEE84, $FFFFEEB6
		cmpi.w	#$3940, (Screen_Pos_Buffer_X).w              ; $FFFFEE80
		bcc.s	Offset_0x032DE2
		cmpi.w	#$3600, (Screen_Pos_Buffer_X).w              ; $FFFFEE80
		bcs.s	Offset_0x032DB6
		addi.w	#$2800, (Level_Events_Buffer_1).w            ; $FFFFEEB6
Offset_0x032DB6:
		cmpi.w	#$0580, (Screen_Pos_Buffer_Y).w              ; $FFFFEE84
		bcc.s	Offset_0x032DE2
		clr.w	(Background_Events+$16).w                    ; $FFFFEEE8
		jsr	Iz_1_Set_Intro_Pal(PC)                 ; Offset_0x0330B4
		jsr	Iz_1_Intro_Deform(PC)                  ; Offset_0x032FF0
		jsr	Reset_Tile_Offset_Position_Actual_2(PC) ; Offset_0x02FF0E
		move.w	#$1880, D1
		jsr	Refresh_Plane_Full(PC)                 ; Offset_0x02FA7C
		lea	Iz_1_Intro_Deform_Array(PC), A4        ; Offset_0x03311C
		lea	(Horizontal_Scroll_Table).w, A5              ; $FFFFA800
		jmp	Apply_Deformation(PC)                  ; Offset_0x02FD7C
Offset_0x032DE2:
		move.w	#$0010, (Level_Events_Routine_2).w           ; $FFFFEEC2
		st	(Background_Events+$16).w                    ; $FFFFEEE8
		jsr	Iz_1_Set_Indoor_Pal(PC)                ; Offset_0x0330EE
		jsr	Iz_1_Deform(PC)                        ; Offset_0x03308E
		jsr	Reset_Tile_Offset_Position_Actual_2(PC) ; Offset_0x02FF0E
		jsr	Refresh_Plane_Full(PC)                 ; Offset_0x02FA7C
		jmp	Plain_Deformation(PC)                  ; Offset_0x02FD42  
;------------------------------------------------------------------------------- 
Iz_1_Events_Run_2:                                             ; Offset_0x032E00
		move.w	(Level_Events_Routine_2).w, D0               ; $FFFFEEC2
		jmp	Offset_0x032E08(pc,d0.w)  
;-------------------------------------------------------------------------------
Offset_0x032E08:
		bra.w	Iz_1_Intro                             ; Offset_0x032E20
		bra.w	Iz_1_Snow_Fall                         ; Offset_0x032E66
		bra.w	Iz_1_Refresh                           ; Offset_0x032E92
		bra.w	Iz_1_Refresh_2                         ; Offset_0x032EC2
		bra.w	Iz_1_Normal_2                          ; Offset_0x032EE2
		bra.w	Iz_1_Transition                        ; Offset_0x032F3C  
;-------------------------------------------------------------------------------
Iz_1_Intro:                                                    ; Offset_0x032E20
		tst.w	(Level_Events_Buffer_5).w                    ; $FFFFEEC6
		beq.s	Offset_0x032E40
		clr.w	(Level_Events_Buffer_5).w                    ; $FFFFEEC6
		clr.l	(Background_Events).w                        ; $FFFFEED2
		clr.l	(Background_Events+$04).w                    ; $FFFFEED6
		jsr	Iz_1_Big_Snow_Fall(PC)                 ; Offset_0x033046
		jsr	Reset_Tile_Offset_Position_Actual_2(PC) ; Offset_0x02FF0E
		addq.w	#$04, (Level_Events_Routine_2).w             ; $FFFFEEC2
		bra.s	Offset_0x032E86
Offset_0x032E40:
		jsr	Iz_1_Intro_Deform(PC)                  ; Offset_0x032FF0
		lea	(Screen_Pos_Buffer_Y_2).w, A6                ; $FFFFEE90
		lea	(Screen_Pos_Rounded_Y_2).w, A5               ; $FFFFEE96
		move.w	#$1880, D1
		moveq	#$20, D6
		jsr	DrawBlockRow(PC)                      ; Offset_0x02F8AA
		lea	Iz_1_Intro_Deform_Array(PC), A4        ; Offset_0x03311C
		lea	(Horizontal_Scroll_Table).w, A5              ; $FFFFA800
		jsr	Apply_Deformation(PC)                  ; Offset_0x02FD7C
		jmp	Earthquake_Setup(PC)                   ; Offset_0x02FFA4
;-------------------------------------------------------------------------------                
Iz_1_Snow_Fall:                                                ; Offset_0x032E66
		tst.w	(Level_Events_Buffer_5).w                    ; $FFFFEEC6
		beq.s	Offset_0x032E82
		clr.w	(Level_Events_Buffer_5).w                    ; $FFFFEEC6
		move.w	#$02E0, (Draw_Delayed_Position).w            ; $FFFFEEC8
		move.w	#$000F, (Draw_Delayed_Position_Rowcount).w   ; $FFFFEECA
		addq.w	#$04, (Level_Events_Routine_2).w             ; $FFFFEEC2
		bra.s	Iz_1_Refresh                           ; Offset_0x032E92
Offset_0x032E82:
		jsr	Iz_1_Big_Snow_Fall(PC)                 ; Offset_0x033046
Offset_0x032E86:
		jsr	LoadTilesAsYouMove_Background(PC)           ; Offset_0x02FB32
		jsr	Plain_Deformation(PC)                  ; Offset_0x02FD42
		jmp	Earthquake_Setup(PC)                   ; Offset_0x02FFA4
;-------------------------------------------------------------------------------                
Iz_1_Refresh:                                                  ; Offset_0x032E92  
		move.w	#$1880, D1
		move.w	#$0200, D2
		jsr	Draw_Plane_Vertical_Bottom_Up(PC)      ; Offset_0x02FCC6
		bpl.w	Plain_Deformation                      ; Offset_0x02FD42
		jsr	Iz_1_Deform(PC)                        ; Offset_0x03308E
		jsr	Reset_Tile_Offset_Position_Actual_2(PC) ; Offset_0x02FF0E
		addi.w	#$00E0, D0
		and.w	(Level_Layout_Wrap_Y).w, D0                  ; $FFFFEEAC
		move.w	D0, (Draw_Delayed_Position).w                ; $FFFFEEC8
		move.w	#$000F, (Draw_Delayed_Position_Rowcount).w   ; $FFFFEECA
		addq.w	#$04, (Level_Events_Routine_2).w             ; $FFFFEEC2
		bra.s	Offset_0x032EC6
;-------------------------------------------------------------------------------                
Iz_1_Refresh_2:                                                ; Offset_0x032EC2
		jsr	Iz_1_Deform(PC)                        ; Offset_0x03308E
Offset_0x032EC6:
		move.w	(Screen_Pos_Buffer_X_2).w, D1                ; $FFFFEE8C
		move.w	(Screen_Pos_Buffer_Y_2).w, D2                ; $FFFFEE90
		jsr	Draw_Plane_Vertical_Bottom_Up(PC)      ; Offset_0x02FCC6
		bpl.s	Offset_0x032F34
		st	(Background_Events+$16).w                    ; $FFFFEEE8
		jsr	Iz_1_Set_Indoor_Pal(PC)                ; Offset_0x0330EE
		addq.w	#$04, (Level_Events_Routine_2).w             ; $FFFFEEC2
		bra.s	Offset_0x032F34
;-------------------------------------------------------------------------------                
Iz_1_Normal_2:                                                 ; Offset_0x032EE2
		cmpi.w	#$6900, (Screen_Pos_Buffer_X).w              ; $FFFFEE80
		bcs.s	Offset_0x032F30
		movem.l	D7/A0/A2/A3, -(A7)
		lea	(Icecap_2_Chunks_2), A1                ; Offset_0x182746
		lea	(M68K_RAM_Start+$0B80), A2                   ; $FFFF0B80
		jsr	(Queue_Kos)          ; Offset_0x0019AE
		lea	(Icecap_2_Blocks_2), A1                ; Offset_0x17FB24
		lea	(Blocks_Mem_Address+$0418).w, A2             ; $FFFF9418
		jsr	(Queue_Kos)          ; Offset_0x0019AE
		lea	(Icecap_2_Tiles_2), A1                 ; Offset_0x180734
		move.w	#$23E0, D2
		jsr	(Queue_Kos_Module)                 ; Offset_0x0018A8
		moveq	#$20, D0
		jsr	(LoadPLC)                              ; Offset_0x0014D0
		movem.l	(A7)+, D7/A0/A2/A3
		addq.w	#$04, (Level_Events_Routine_2).w             ; $FFFFEEC2
Offset_0x032F30:
		jsr	Iz_1_Deform(PC)                        ; Offset_0x03308E
Offset_0x032F34:
		jsr	LoadTilesAsYouMove_Background(PC)           ; Offset_0x02FB32
		jmp	Plain_Deformation(PC)                  ; Offset_0x02FD42
;-------------------------------------------------------------------------------                
Iz_1_Transition:                                               ; Offset_0x032F3C
		tst.w	(Kos_decomp_queue_count).w                 ; $FFFFFF0E
		bne.w	Offset_0x032FE8
		move.w	#Iz_Act_2, (Current_ZoneAndAct).w               ; $0501, $FFFFFE10
		clr.b	(Saved_Level_Flag).w                         ; $FFFFFE30
		clr.b	(Saved_Level_Flag_P2).w                      ; $FFFFFEE0
		clr.b	(Dynamic_Resize_Routine).w                   ; $FFFFEE33
		clr.b	(Object_Pos_Routine).w                       ; $FFFFF76C
		clr.b	(Ring_Pos_Routine).w                         ; $FFFFF710
		clr.b	(Boss_Flag).w                                ; $FFFFF7AA
		clr.l	(Animate_Counters).w                         ; $FFFFF7F0
		clr.w	(Animate_Counters+$04).w                     ; $FFFFF7F4
		movem.l	D7/A0/A2/A3, -(A7)
		jsr	(LoadLevelLayout)                    ; Offset_0x01247C
		jsr	(LoadCollisionIndex)                 ; Offset_0x0049B2
		moveq	#$15, D0
		jsr	(PalLoad_Now)                             ; Offset_0x002FBA
		movem.l	(A7)+, D7/A0/A2/A3
		move.w	#$6880, D0
		move.w	#$FF00, D1
		sub.w	D0, (Obj_Player_One+x_pos).w                 ; $FFFFB010
		sub.w	D1, (Obj_Player_One+y_pos).w                 ; $FFFFB014
		sub.w	D0, (Obj_Player_Two+x_pos).w                 ; $FFFFB05A
		sub.w	D1, (Obj_Player_Two+y_pos).w                 ; $FFFFB05E
		jsr	Calc_Objects_X_Y_During_Transition(PC) ; Offset_0x02FFE4
		sub.w	D0, (Camera_X).w                             ; $FFFFEE78
		sub.w	D1, (Camera_Y).w                             ; $FFFFEE7C
		sub.w	D0, (Screen_Pos_Buffer_X).w                  ; $FFFFEE80
		sub.w	D1, (Screen_Pos_Buffer_Y).w                  ; $FFFFEE84
		move.l	#$00007000, D0
		move.l	D0, (Sonic_Level_Limits_Min_X).w             ; $FFFFEE14
		move.l	D0, (Level_Limits_Min_X).w                   ; $FFFFEE0C
		move.l	#$00000B20, D0
		move.l	D0, (Sonic_Level_Limits_Min_Y).w             ; $FFFFEE18
		move.l	D0, (Level_Limits_Min_Y).w                   ; $FFFFEE10
		move.w	#$0FFF, (Screen_Wrap_Y).w                    ; $FFFFEEAA
		move.w	#$0FF0, (Level_Layout_Wrap_Y).w              ; $FFFFEEAC
		move.w	#$007C, (Level_Layout_Wrap_Row).w            ; $FFFFEEAE
		jsr	Reset_Tile_Offset_Position_Actual(PC)  ; Offset_0x02FEF2
		clr.w	(Level_Events_Routine_2).w                   ; $FFFFEEC2
Offset_0x032FE8:
		jsr	Iz_1_Deform(PC)                        ; Offset_0x03308E
		jmp	Plain_Deformation(PC)                  ; Offset_0x02FD42    
;------------------------------------------------------------------------------- 
Iz_1_Intro_Deform:                                             ; Offset_0x032FF0
		lea	(Level_Events_Buffer_0).w, A1                ; $FFFFEEB4
		move.w	(Screen_Pos_Buffer_Y).w, D0                  ; $FFFFEE84
		move.w	#$0400, D2
		move.w	#$0800, D3
		jsr	Adjust_Background_During_Loop(PC)      ; Offset_0x02FF6C
		move.w	(Level_Events_Buffer_1).w, D0                ; $FFFFEEB6
		asr.w	#$07, D0
		move.w	D0, (Screen_Pos_Buffer_Y_2).w                ; $FFFFEE90
		move.w	(Screen_Pos_Buffer_X).w, D0                  ; $FFFFEE80
		move.w	(Earthquake_Offset).w, D3                    ; $FFFFEECE
		sub.w	D3, D0
                swap.w  D0
		clr.w	D0
		asr.l	#$05, D0
		move.l	D0, D1
                swap.w  D0
		add.w	D3, D0
                swap.w  D0
		lea	(Horizontal_Scroll_Table).w, A1              ; $FFFFA800
		moveq	#$04, D2
		bsr.s	Offset_0x033038
		add.l	D1, D0
		move.l	D1, D2
		asr.l	#$01, D2
		add.l	D2, D1
		moveq	#$08, D2
Offset_0x033038:
                swap.w  D0
		move.w	D0, (A1)+
                swap.w  D0
		add.l	D1, D0
		dbf	D2, Offset_0x033038
		rts 
;-------------------------------------------------------------------------------  
Iz_1_Big_Snow_Fall:                                            ; Offset_0x033046
		cmpi.w	#$FEE0, (Background_Events).w                ; $FFFFEED2
		ble.s	Offset_0x033064
		st	(Earthquake_Flag).w                          ; $FFFFEECC
		addi.l	#$00002400, (Background_Events+$04).w        ; $FFFFEED6
		move.l	(Background_Events+$04).w, D0                ; $FFFFEED6
		sub.l	D0, (Background_Events).w                    ; $FFFFEED2
		bra.s	Offset_0x033070
Offset_0x033064:
		tst.w	(Earthquake_Flag).w                          ; $FFFFEECC
		bpl.s	Offset_0x033070
		move.w	#$0004, (Earthquake_Flag).w                  ; $FFFFEECC
Offset_0x033070:
		move.w	(Screen_Pos_Buffer_Y).w, D0                  ; $FFFFEE84
		subi.w	#$0460, D0
		add.w	(Background_Events).w, D0                    ; $FFFFEED2
		move.w	D0, (Screen_Pos_Buffer_Y_2).w                ; $FFFFEE90
		move.w	(Screen_Pos_Buffer_X).w, D0                  ; $FFFFEE80
		subi.w	#$1D40, D0
		move.w	D0, (Screen_Pos_Buffer_X_2).w                ; $FFFFEE8C
		rts
;-------------------------------------------------------------------------------  
Iz_1_Deform:                                                   ; Offset_0x03308E
		move.w	(Screen_Pos_Buffer_Y).w, D0                  ; $FFFFEE84
		asr.w	#$01, D0
		move.w	D0, (Screen_Pos_Buffer_Y_2).w                ; $FFFFEE90
		asr.w	#$01, D0
		move.w	D0, (Background_Events+$12).w                ; $FFFFEEE4
		move.w	(Screen_Pos_Buffer_X).w, D0                  ; $FFFFEE80
		asr.w	#$01, D0
		subi.w	#$1D80, D0
		move.w	D0, (Screen_Pos_Buffer_X_2).w                ; $FFFFEE8C
		asr.w	#$01, D0
		move.w	D0, (Background_Events+$10).w                ; $FFFFEEE2
		rts                   
;-------------------------------------------------------------------------------   
Iz_1_Set_Intro_Pal:                                            ; Offset_0x0330B4
		lea	(Palette_Row_3_Offset+$02).w, A1             ; $FFFFED62
		bsr.s	Offset_0x0330BE
		lea	(Palette_Row_3_Data_Target+$02).w, A1        ; $FFFFEDE2
Offset_0x0330BE:
		move.l	#$0EEE0EEC, (A1)+
		move.l	#$0EEA0ECA, (A1)+
		move.l	#$0EC80EA6, (A1)+
		move.l	#$0E860E64, (A1)+
		move.l	#$0E400E00, (A1)+
		move.l	#$0C000000, (A1)+
		move.l	#$0AEC0CEA, (A1)+
		move.w	#$0E80, (A1)
		rts
;------------------------------------------------------------------------------- 
Iz_1_Set_Indoor_Pal:                                           ; Offset_0x0330EE
		lea	(Palette_Row_3_Offset+$02).w, A1             ; $FFFFED62
		bsr.s	Offset_0x0330F8
		lea	(Palette_Row_3_Data_Target+$02).w, A1        ; $FFFFEDE2
Offset_0x0330F8:
		move.l	#$0EC00E40, (A1)+
		move.l	#$0E040C00, (A1)+
		move.l	#$06000200, (A1)+
		move.l	#$00000E64, (A1)+
		move.l	#$0E240A02, (A1)+
		move.w	#$0402, (A1)
		rts   
;-------------------------------------------------------------------------------  
Iz_1_Intro_Deform_Array:                                       ; Offset_0x03311C
		dc.w	$0044, $000C, $000B, $000D, $0018, $0050, $0002, $0006
		dc.w	$0008, $0010, $0018, $0020, $0028, $7FFF
;------------------------------------------------------------------------------- 
Iz_2_Events_Init:                                              ; Offset_0x033138
		jsr	Reset_Tile_Offset_Position_Actual(PC)  ; Offset_0x02FEF2
		jmp	Refresh_Plane_Full(PC)                 ; Offset_0x02FA7C   
;------------------------------------------------------------------------------- 
Iz_2_Events_Run:                                               ; Offset_0x033140
		jmp	LoadTilesAsYouMove_Foreground(PC)             ; Offset_0x02FB0E 
;------------------------------------------------------------------------------- 
Iz_2_Events_Init_2:                                            ; Offset_0x033144
		move.w	#$0004, (Level_Events_Routine_2).w           ; $FFFFEEC2
		cmpi.w	#$3600, (Screen_Pos_Buffer_X).w              ; $FFFFEE80
		bcc.s	Offset_0x03316A
		cmpi.w	#$0720, (Screen_Pos_Buffer_Y).w              ; $FFFFEE84
		bcc.s	Offset_0x03318A
		cmpi.w	#$1000, (Screen_Pos_Buffer_X).w              ; $FFFFEE80
		bcc.s	Offset_0x03316A
		cmpi.w	#$0580, (Screen_Pos_Buffer_Y).w              ; $FFFFEE84
		bcc.s	Offset_0x03318A
Offset_0x03316A:
		clr.w	(Background_Events+$16).w                    ; $FFFFEEE8
		jsr	Iz_2_Set_Outdoors_Pal(PC)              ; Offset_0x0333B0
		jsr	Iz_2_Out_Deform(PC)                    ; Offset_0x0332C8
		moveq	#$00, D0
		moveq	#$00, D1
		jsr	Refresh_Plane_Full(PC)                 ; Offset_0x02FA7C
		lea	Iz_2_Out_Deform_Array(PC), A4          ; Offset_0x033408
		lea	(Horizontal_Scroll_Table).w, A5              ; $FFFFA800
		jmp	Apply_Deformation(PC)                  ; Offset_0x02FD7C
Offset_0x03318A:
		st	(Background_Events+$16).w                    ; $FFFFEEE8
		jsr	Iz_2_Set_Indoors_Pal(PC)               ; Offset_0x0333DA
		jsr	Iz_2_Set_In_Deform(PC)                 ; Offset_0x033340
		jsr	Reset_Tile_Offset_Position_Actual_2(PC) ; Offset_0x02FF0E
		moveq	#$00, D1
		jsr	Refresh_Plane_Full(PC)                 ; Offset_0x02FA7C
		lea	Iz_2_In_Deform_Array(PC), A4           ; Offset_0x033410
		lea	(Horizontal_Scroll_Table).w, A5              ; $FFFFA800
		jmp	Apply_Deformation(PC)                  ; Offset_0x02FD7C  
;------------------------------------------------------------------------------- 
Iz_2_Events_Run_2:                                             ; Offset_0x0331AC
		move.w	(Level_Events_Routine_2).w, D0               ; $FFFFEEC2
		jmp	Offset_0x0331B4(pc,d0.w)                
;-------------------------------------------------------------------------------    
Offset_0x0331B4:
		bra.w	Iz_2_From_Iz_1                         ; Offset_0x0331C0
		bra.w	Iz_2_Normal                            ; Offset_0x0331CE
		bra.w	Iz_2_Refresh                           ; Offset_0x033292
;-------------------------------------------------------------------------------
Iz_2_From_Iz_1:                                                ; Offset_0x0331C0
		addq.w	#$04, (Level_Events_Routine_2).w             ; $FFFFEEC2
		cmpi.w	#$0580, (Screen_Pos_Buffer_Y).w              ; $FFFFEE84
		bcc.s	Offset_0x0331EC
		bra.s	Offset_0x03324A     
;-------------------------------------------------------------------------------
Iz_2_Normal:                                                   ; Offset_0x0331CE
		tst.w	(Background_Events+$16).w                    ; $FFFFEEE8
		bne.s	Offset_0x033226
		move.w	(Screen_Pos_Buffer_X).w, D0                  ; $FFFFEE80
		cmpi.w	#$1000, D0
		bcs.s	Offset_0x033216
		cmpi.w	#$3600, D0
		bcc.s	Offset_0x033216
		cmpi.w	#$0720, (Screen_Pos_Buffer_Y).w              ; $FFFFEE84
		bcs.s	Offset_0x033216
Offset_0x0331EC:
		st	(Background_Events+$16).w                    ; $FFFFEEE8
		jsr	Iz_2_Set_Indoors_Pal(PC)               ; Offset_0x0333DA
		jsr	Iz_2_Set_In_Deform(PC)                 ; Offset_0x033340
		jsr	Reset_Tile_Offset_Position_Actual_2(PC) ; Offset_0x02FF0E
		addi.w	#$00E0, D0
		and.w	(Level_Layout_Wrap_Y).w, D0                  ; $FFFFEEAC
		move.w	D0, (Draw_Delayed_Position).w                ; $FFFFEEC8
		move.w	#$000F, (Draw_Delayed_Position_Rowcount).w   ; $FFFFEECA
		addq.w	#$04, (Level_Events_Routine_2).w             ; $FFFFEEC2
		bra.w	Offset_0x0332B6
Offset_0x033216:
		jsr	Iz_2_Out_Deform(PC)                    ; Offset_0x0332C8
Offset_0x03321A:
		lea	Iz_2_Out_Deform_Array(PC), A4          ; Offset_0x033408
		lea	(Horizontal_Scroll_Table).w, A5              ; $FFFFA800
		jmp	Apply_Deformation(PC)                  ; Offset_0x02FD7C
Offset_0x033226:
		move.w	(Screen_Pos_Buffer_X).w, D0                  ; $FFFFEE80
		cmpi.w	#$1900, D0
		bcs.s	Offset_0x033236
		cmpi.w	#$1B80, D0
		bcs.s	Offset_0x033272
Offset_0x033236:
		cmpi.w	#$1000, D0
		bcs.s	Offset_0x033272
		cmpi.w	#$3600, D0
		bcc.s	Offset_0x033272
		cmpi.w	#$0720, (Screen_Pos_Buffer_Y).w              ; $FFFFEE84
		bcc.s	Offset_0x033272
Offset_0x03324A:
		clr.w	(Background_Events+$16).w                    ; $FFFFEEE8
		jsr	Iz_2_Set_Outdoors_Pal(PC)              ; Offset_0x0333B0
		jsr	Iz_2_Out_Deform(PC)                    ; Offset_0x0332C8
		jsr	Reset_Tile_Offset_Position_Actual_2(PC) ; Offset_0x02FF0E
		addi.w	#$00E0, D0
		and.w	(Level_Layout_Wrap_Y).w, D0                  ; $FFFFEEAC
		move.w	D0, (Draw_Delayed_Position).w                ; $FFFFEEC8
		move.w	#$000F, (Draw_Delayed_Position_Rowcount).w   ; $FFFFEECA
		addq.w	#$04, (Level_Events_Routine_2).w             ; $FFFFEEC2
		bra.s	Offset_0x03329C
Offset_0x033272:
		jsr	Iz_2_Set_In_Deform(PC)                 ; Offset_0x033340
Offset_0x033276:
		lea	(Screen_Pos_Buffer_Y_2).w, A6                ; $FFFFEE90
		lea	(Screen_Pos_Rounded_Y_2).w, A5               ; $FFFFEE96
		moveq	#$00, D1
		moveq	#$20, D6
		jsr	DrawBlockRow(PC)                      ; Offset_0x02F8AA
		lea	Iz_2_In_Deform_Array(PC), A4           ; Offset_0x033410
		lea	(Horizontal_Scroll_Table).w, A5              ; $FFFFA800
		jmp	Apply_Deformation(PC)                  ; Offset_0x02FD7C
;-------------------------------------------------------------------------------                
Iz_2_Refresh:                                                  ; Offset_0x033292
		tst.w	(Background_Events+$16).w                    ; $FFFFEEE8
		bne.s	Offset_0x0332B2
		jsr	Iz_2_Out_Deform(PC)                    ; Offset_0x0332C8
Offset_0x03329C:
		moveq	#$00, D1
		move.w	(Screen_Pos_Buffer_Y_2).w, D2                ; $FFFFEE90
		jsr	Draw_Plane_Vertical_Bottom_Up(PC)      ; Offset_0x02FCC6
		bpl.w	Offset_0x03321A
		subq.w	#$04, (Level_Events_Routine_2).w             ; $FFFFEEC2
		bra.w	Offset_0x03321A
Offset_0x0332B2:
		jsr	Iz_2_Set_In_Deform(PC)                 ; Offset_0x033340
Offset_0x0332B6:
		moveq	#$00, D1
		move.w	(Screen_Pos_Buffer_Y_2).w, D2                ; $FFFFEE90
		jsr	Draw_Plane_Vertical_Bottom_Up(PC)      ; Offset_0x02FCC6
		bpl.s	Offset_0x033276
		subq.w	#$04, (Level_Events_Routine_2).w             ; $FFFFEEC2
		bra.s	Offset_0x033276   
;------------------------------------------------------------------------------- 
Iz_2_Out_Deform:                                               ; Offset_0x0332C8
		clr.w	(Screen_Pos_Buffer_Y_2).w                    ; $FFFFEE90
		move.w	(Screen_Pos_Buffer_X).w, D0                  ; $FFFFEE80
		move.w	(Level_frame_counter).w, D1                    ; $FFFFFE04
		asr.w	#$01, D1
		add.w	D1, D0
                swap.w  D0
		clr.w	D0
		asr.l	#$01, D0
		andi.l	#$007FFFFF, D0
		move.l	D0, D1
		asr.l	#$06, D1
		lea	(Horizontal_Scroll_Table+$0064).w, A1        ; $FFFFA864
		moveq	#$27, D2
Offset_0x0332EE:
                swap.w  D0
		move.w	D0, -(A1)
                swap.w  D0
		sub.l	D1, D0
		dbf	D2, Offset_0x0332EE
		lea	(Horizontal_Scroll_Table).w, A1              ; $FFFFA800
		move.w	(Screen_Pos_Buffer_X).w, D0                  ; $FFFFEE80
                swap.w  D0
		clr.w	D0
		asr.l	#$01, D0
		move.l	D0, D1
		asr.l	#$01, D0
		add.l	D0, D1
		move.l	D1, $0064(A1)
		asr.l	#$02, D0
		move.l	D0, D1
                swap.w  D0
		move.w	D0, (A1)+
                swap.w  D0
		add.l	D1, D0
                swap.w  D0
		move.w	D0, (A1)+
		move.w	(Level_frame_counter).w, D1                    ; $FFFFFE04
		lsr.w	#$02, D1
		andi.w	#$003E, D1
		lea	Default_Background_Deform_Delta(PC), A5 ; Offset_0x031820
		adda.w	D1, A5
		moveq	#$07, D1
Offset_0x033334:
		move.w	(A5)+, D2
		add.w	D0, D2
		move.w	D2, (A1)+
		dbf	D1, Offset_0x033334
		rts             
;-------------------------------------------------------------------------------   
Iz_2_Set_In_Deform:                                            ; Offset_0x033340
		move.w	(Screen_Pos_Buffer_Y).w, D0                  ; $FFFFEE84
		subi.w	#$0700, D0
		asr.w	#$02, D0
		addi.w	#$0118, D0
		move.w	D0, (Screen_Pos_Buffer_Y_2).w                ; $FFFFEE90
		lea	(Horizontal_Scroll_Table).w, A1              ; $FFFFA800
		move.w	(Screen_Pos_Buffer_X).w, D0                  ; $FFFFEE80
                swap.w  D0
		clr.w	D0
		asr.l	#$01, D0
		move.l	D0, D1
		asr.l	#$03, D1
                swap.w  D0
		move.w	D0, (A1)
		move.w	D0, $0010(A1)
                swap.w  D0
		sub.l	D1, D0
                swap.w  D0
		move.w	D0, $0002(A1)
		move.w	D0, $000E(A1)
                swap.w  D0
		sub.l	D1, D0
                swap.w  D0
		move.w	D0, $0004(A1)
		move.w	D0, $000C(A1)
                swap.w  D0
		sub.l	D1, D0
                swap.w  D0
		move.w	D0, $0006(A1)
		move.w	D0, $000A(A1)
                swap.w  D0
		sub.l	D1, D0
                swap.w  D0
		move.w	D0, (Screen_Pos_Buffer_X_2).w                ; $FFFFEE8C
		move.w	D0, $0008(A1)
                swap.w  D0
		sub.l	D1, D0
                swap.w  D0
		move.w	D0, (Background_Events+$10).w                ; $FFFFEEE2
		rts            
;------------------------------------------------------------------------------- 
Iz_2_Set_Outdoors_Pal:                                         ; Offset_0x0333B0
		lea	(Palette_Row_3_Offset+$02).w, A1             ; $FFFFED62
		bsr.s	Offset_0x0333BA
		lea	(Palette_Row_3_Data_Target+$02).w, A1        ; $FFFFEDE2
Offset_0x0333BA:
		move.l	#$0EEE0EEA, (A1)+
		move.l	#$0EC80EA4, (A1)+
		move.l	#$0C820C60, (A1)+
		move.l	#$0C400E20, (A1)+
		move.l	#$0A000E00, (A1)
		rts                
;-------------------------------------------------------------------------------     
Iz_2_Set_Indoors_Pal:                                          ; Offset_0x0333DA
		lea	(Palette_Row_3_Offset+$02).w, A1             ; $FFFFED62
		bsr.s	Offset_0x0333E4
		lea	(Palette_Row_3_Data_Target+$02).w, A1        ; $FFFFEDE2
Offset_0x0333E4:
		move.l	#$0EE20E24, (A1)+
		move.l	#$0E040C02, (A1)+
		move.l	#$06020400, (A1)+
		move.l	#$02000E20, (A1)+
		move.l	#$0E400840, (A1)+
		move.w	#$0600, (A1)
		rts              
;-------------------------------------------------------------------------------  
Iz_2_Out_Deform_Array:                                         ; Offset_0x033408
		dc.w	$005A, $0026, $8030, $7FFF              
;-------------------------------------------------------------------------------  
Iz_2_In_Deform_Array:                                          ; Offset_0x033410
		dc.w	$01A0, $0040, $0020, $0018, $0040, $0008, $0008, $0018
		dc.w	$7FFF            
;-------------------------------------------------------------------------------   
LBz_1_Events_Init:                                             ; Offset_0x033422
		move.w	$0004(A3), D0
		subi.w	#$0076, D0
		move.w	D0, $0074(A3)
		move.w	D0, $0078(A3)
		move.w	D0, $007C(A3)
		lea	(Horizontal_Scroll_Table+$0148).w, A1        ; $FFFFA948
		moveq	#$0D, D0
Offset_0x03343C:
		clr.l	(A1)+
		dbf	D0, Offset_0x03343C
		jsr	LBz_1_Vertical_Scroll(PC)              ; Offset_0x033512
		lea	(Horizontal_Scroll_Table+$0100).w, A1        ; $FFFFA900
		moveq	#$0B, D0
Offset_0x03344C:
		move.w	(A1)+, D1
		and.w	(Level_Layout_Wrap_Y).w, D1                  ; $FFFFEEAC
		move.w	D1, (A1)+
		dbf	D0, Offset_0x03344C
		cmpi.w	#$3B60, (Screen_Pos_Buffer_X).w              ; $FFFFEE80
		bcs.s	Offset_0x033474
		jsr	(AllocateObject)                     ; Offset_0x011DD8
		bne.s	Offset_0x03346E
		move.l	#Obj_LBz_1_Invisible_Block, (A1)       ; Offset_0x0336A6
Offset_0x03346E:
		move.w	(A3), A5
		jsr	LBz_1_Do_Mod_3(PC)                     ; Offset_0x03364E
Offset_0x033474:
		move.w	(Obj_Player_One+x_pos).w, D0                 ; $FFFFB010
		move.w	(Obj_Player_One+y_pos).w, D1                 ; $FFFFB014
		moveq	#$00, D2
		jsr	LBz_1_Check_Layout_Mod(PC)             ; Offset_0x0335CA
		jsr	Reset_Tile_Offset_Position_Actual(PC)  ; Offset_0x02FEF2
		jmp	Refresh_Plane_Full(PC)                 ; Offset_0x02FA7C  
;------------------------------------------------------------------------------- 
LBz_1_Events_Run:                                              ; Offset_0x03348A
		move.w	(Earthquake_Offset).w, D0                    ; $FFFFEECE
		add.w	D0, (Screen_Pos_Buffer_Y).w                  ; $FFFFEE84
		move.w	(Obj_Player_One+x_pos).w, D0                 ; $FFFFB010
		move.w	(Obj_Player_One+y_pos).w, D1                 ; $FFFFB014
		move.w	(Background_Events).w, D2                    ; $FFFFEED2
		bne.s	Offset_0x0334AC
		jsr	LBz_1_Check_Layout_Mod(PC)             ; Offset_0x0335CA
		tst.w	D3
		bmi.s	Offset_0x0334FE
		jmp	Refresh_Plane_Screen_Direct(PC)        ; Offset_0x02FAE0
Offset_0x0334AC:
		lea	(LBz_1_Layout_Mod_Exit_Range-$04)(PC), A1  ; Offset_0x033712
		adda.w	D2, A1
		cmp.w	(A1)+, D0
		bcs.s	Offset_0x0334BC
		cmp.w	(A1)+, D0
		bhi.s	Offset_0x0334BC
		bra.s	Offset_0x0334FE
Offset_0x0334BC:
		clr.w	(Background_Events).w                        ; $FFFFEED2
		lsr.w	#$01, D2
		jsr	(Offset_0x0334CA-$02)(pc,d2.w)
		jmp	Refresh_Plane_Screen_Direct(PC)        ; Offset_0x02FAE0  
;-------------------------------------------------------------------------------
Offset_0x0334CA:
		bra.s	LBz_1_Layout_Exit_Mod_1                ; Offset_0x0334D2
		bra.s	LBz_1_Layout_Exit_Mod_2                ; Offset_0x0334DC
		bra.s	LBz_1_Layout_Exit_Mod_3                ; Offset_0x0334E8
		bra.s	LBz_1_Layout_Exit_Mod_4                ; Offset_0x0334F2    
;-------------------------------------------------------------------------------
LBz_1_Layout_Exit_Mod_1:                                       ; Offset_0x0334D2
		move.w	(A3), A5
		lea	$0088(A5), A5
		bra.w	LBz_1_Do_Mod_1                         ; Offset_0x033688           
;-------------------------------------------------------------------------------
LBz_1_Layout_Exit_Mod_2:                                       ; Offset_0x0334DC
		move.w	$0024(A3), A5
		lea	$008A(A5), A5
		bra.w	LBz_1_Do_Mod_2                         ; Offset_0x033668   
;-------------------------------------------------------------------------------
LBz_1_Layout_Exit_Mod_3:                                       ; Offset_0x0334E8
		move.w	(A3), A5
		lea	$0098(A5), A5
		bra.w	LBz_1_Do_Mod_3                         ; Offset_0x03364E   
;-------------------------------------------------------------------------------
LBz_1_Layout_Exit_Mod_4:                                       ; Offset_0x0334F2
		move.w	$0030(A3), A5
		lea	$009A(A5), A5
		bra.w	LBz_1_Do_Mod_4                         ; Offset_0x033632     
;-------------------------------------------------------------------------------
Offset_0x0334FE:
		jsr	LBz_1_Vertical_Scroll(PC)              ; Offset_0x033512
		lea	LBz_1_Vertical_Scroll_Array(PC), A4    ; Offset_0x0336DE
		lea	(Horizontal_Scroll_Table+$0100).w, A5        ; $FFFFA900
		moveq	#$0F, D6
		moveq	#$0C, D5
		jmp	Draw_Tiles_Vertical(PC)                ; Offset_0x02FC0E     
;------------------------------------------------------------------------------- 
LBz_1_Vertical_Scroll:                                         ; Offset_0x033512
		tst.w	(Foreground_Events_Y_Counter).w              ; $FFFFEEC4
		beq.w	Offset_0x0335A6
		bpl.s	Offset_0x033536
		move.w	#$0001, (Foreground_Events_Y_Counter).w      ; $FFFFEEC4
		move.w	#$0002, (Special_Vint_Routine).w             ; $FFFFEEA6
		jsr	(AllocateObject)                     ; Offset_0x011DD8
		bne.s	Offset_0x033536
		move.l	#Obj_LBz_1_Invisible_Block, (A1)       ; Offset_0x0336A6
Offset_0x033536:
		lea	(Horizontal_Scroll_Table+$014C).w, A1        ; $FFFFA94C
		lea	LBz_1_Collapse_Scroll_Speed(PC), A5    ; Offset_0x033726
		move.l	$002C(A1), D0
		addi.l	#$00000100, $002C(A1)
		move.w	$0030(A1), D1
		addq.w	#$01, $0030(A1)
		asr.w	#$06, D1
		moveq	#$0A, D2
		moveq	#$09, D3
Offset_0x033558:
		addq.w	#$02, D1
		andi.w	#$000E, D1
		move.w	$00(A5, D1), D4
		ext.l	D4
		lsl.l	#$04, D4
		move.l	(A1), D5
		sub.l	D4, D5
		sub.l	D0, D5
                swap.w  D5
		cmpi.w	#$FD00, D5
		bgt.s	Offset_0x03357A
		move.w	#$FD00, D5
		subq.w	#$01, D2
Offset_0x03357A:
                swap.w  D5
		move.l	D5, (A1)+
		dbf	D3, Offset_0x033558
		tst.w	D2
		bne.s	Offset_0x0335A6
		clr.w	(Earthquake_Flag).w                          ; $FFFFEECC
		clr.w	(Foreground_Events_Y_Counter).w              ; $FFFFEEC4
		move.w	#$0006, (Special_Vint_Routine).w             ; $FFFFEEA6
		move.w	(A3), A5
		jsr	LBz_1_Do_Mod_3(PC)                     ; Offset_0x03364E
		lea	(Horizontal_Scroll_Table+$0148).w, A1        ; $FFFFA948
		moveq	#$0D, D0
Offset_0x0335A0:
		clr.l	(A1)+
		dbf	D0, Offset_0x0335A0
Offset_0x0335A6:
		lea	(Horizontal_Scroll_Table+$0100).w, A1        ; $FFFFA900
		lea	(Horizontal_Scroll_Table+$0130).w, A4        ; $FFFFA930
		lea	(Horizontal_Scroll_Table+$0148).w, A5        ; $FFFFA948
		move.w	(Screen_Pos_Buffer_Y).w, D0                  ; $FFFFEE84
		moveq	#$0B, D1
Offset_0x0335B8:
		move.w	(A5), D2
		add.w	D0, D2
		move.w	D2, (A1)
		move.w	D2, (A4)+
		addq.w	#$04, A1
		addq.w	#$04, A5
		dbf	D1, Offset_0x0335B8
		rts 
;-------------------------------------------------------------------------------  
LBz_1_Check_Layout_Mod:                                        ; Offset_0x0335CA
		lea	LBz_1_Layout_Mod_Range(PC), A1         ; Offset_0x0336F6
		moveq	#$03, D3
Offset_0x0335D0:
		lea	(A1), A5
		cmp.w	(A5)+, D0
		bcs.s	Offset_0x0335F2
		cmp.w	(A5)+, D0
		bhi.s	Offset_0x0335F2
		cmp.w	(A5)+, D1
		bcs.s	Offset_0x0335F2
		cmp.w	(A5)+, D1
		bhi.s	Offset_0x0335F2
		tst.w	D2
		bne.s	Offset_0x0335FC
		cmpi.w	#$1580, D0
		bcs.s	Offset_0x0335FC
		cmpi.w	#$0400, D1
		bcs.s	Offset_0x0335FC
Offset_0x0335F2:
		addq.w	#$08, A1
		addq.w	#$04, D2
		dbf	D3, Offset_0x0335D0
		rts
Offset_0x0335FC:
		addq.w	#$04, D2
		move.w	D2, (Background_Events).w                    ; $FFFFEED2
		lsr.w	#$01, D2
		jmp	(Offset_0x033608-$02)(pc,d2.w)
;-------------------------------------------------------------------------------
Offset_0x033608:
		bra.s	LBz_1_Layout_Mod_1                     ; Offset_0x033610
		bra.s	LBz_1_Layout_Mod_2                     ; Offset_0x033618
		bra.s	LBz_1_Layout_Mod_3                     ; Offset_0x033622
		bra.s	LBz_1_Layout_Mod_4                     ; Offset_0x03362A   
;-------------------------------------------------------------------------------
LBz_1_Layout_Mod_1:                                            ; Offset_0x033610
		move.w	(A3), A5
		lea	$0080(A5), A5
		bra.s	LBz_1_Do_Mod_1                         ; Offset_0x033688      
;-------------------------------------------------------------------------------
LBz_1_Layout_Mod_2:                                            ; Offset_0x033618
		move.w	$0024(A3), A5
		lea	$0080(A5), A5
		bra.s	LBz_1_Do_Mod_2                         ; Offset_0x033668      
;-------------------------------------------------------------------------------
LBz_1_Layout_Mod_3:                                            ; Offset_0x033622
		move.w	(A3), A5
		lea	$0094(A5), A5
		bra.s	LBz_1_Do_Mod_3                         ; Offset_0x03364E        
;-------------------------------------------------------------------------------
LBz_1_Layout_Mod_4:                                            ; Offset_0x03362A
		move.w	$0030(A3), A5
		lea	$0094(A5), A5
;-------------------------------------------------------------------------------
LBz_1_Do_Mod_4:                                                ; Offset_0x033632                
		move.w	(A3), A1
		lea	$007A(A1), A1
		move.w	-8(A3), D0
		subq.w	#$06, D0
		moveq	#$05, D1
Offset_0x033640:
		move.l	(A5)+, (A1)+
		move.w	(A5)+, (A1)+
		adda.w	D0, A5
		adda.w	D0, A1
		dbf	D1, Offset_0x033640
		rts
;-------------------------------------------------------------------------------  
LBz_1_Do_Mod_3:                                                ; Offset_0x03364E
		move.w	(A3), A1
		lea	$0074(A1), A1
		move.w	-8(A3), D0
		subq.w	#$04, D0
		moveq	#$0B, D1
Offset_0x03365C:
		move.l	(A5)+, (A1)+
		adda.w	D0, A5
		adda.w	D0, A1
		dbf	D1, Offset_0x03365C
		rts
;-------------------------------------------------------------------------------    
LBz_1_Do_Mod_2:                                                ; Offset_0x033668
		move.w	(A3), A1
		lea	$0042(A1), A1
		move.w	-8(A3), D0
		subi.w	#$000A, D0
		moveq	#$0D, D1
Offset_0x033678:
		move.l	(A5)+, (A1)+
		move.l	(A5)+, (A1)+
		move.w	(A5)+, (A1)+
		adda.w	D0, A5
		adda.w	D0, A1
		dbf	D1, Offset_0x033678
		rts
;-------------------------------------------------------------------------------  
LBz_1_Do_Mod_1:                                                ; Offset_0x033688
		move.w	$0008(A3), A1
		lea	$0026(A1), A1
		move.w	-8(A3), D0
		subq.w	#$08, D0
		moveq	#$08, D1
Offset_0x033698:
		move.l	(A5)+, (A1)+
		move.l	(A5)+, (A1)+
		adda.w	D0, A5
		adda.w	D0, A1
		dbf	D1, Offset_0x033698
		rts   
;-------------------------------------------------------------------------------  
Obj_LBz_1_Invisible_Block:                                     ; Offset_0x0336A6 
                include 'data\objects\invblock.asm'
;------------------------------------------------------------------------------- 
LBz_1_Vertical_Scroll_Array:                                   ; Offset_0x0336DE
		dc.w	$3B60, $0010, $0010, $0010, $0010, $0010, $0010, $0010
		dc.w	$0010, $0010, $0010, $7FFF 
;-------------------------------------------------------------------------------  
LBz_1_Layout_Mod_Range:                                        ; Offset_0x0336F6
		dc.w	$13E0, $16A0, $0100, $0580
		dc.w	$2160, $2520, $0000, $0700
		dc.w	$3A60, $3BA0, $0000, $0600
		dc.w	$3DE0, $3FA0, $0000, $0300
;-------------------------------------------------------------------------------  
LBz_1_Layout_Mod_Exit_Range:                                   ; Offset_0x033716
		dc.w	$1376, $170A, $20F6, $258A
		dc.w	$39F6, $3C0A, $3D76, $400A
;-------------------------------------------------------------------------------   
LBz_1_Collapse_Scroll_Speed:                                   ; Offset_0x033726
		dc.w	$01EE, $01F2, $00C7, $01B3, $01B7, $0198, $000E, $0139
;------------------------------------------------------------------------------- 
LBz_1_Events_Init_2:                                           ; Offset_0x033736
		jsr	LBZ1_Deform(PC)                       ; Offset_0x033884
		jsr	Reset_Tile_Offset_Position_Actual_2(PC) ; Offset_0x02FF0E
		move.w	D2, (Horizontal_Scroll_Table+$0002).w        ; $FFFFA802
		clr.l	(Horizontal_Scroll_Table+$0004).w            ; $FFFFA804
		lea	LBz_1_Draw_Array(PC), A4               ; Offset_0x0338F2
		lea	(Horizontal_Scroll_Table).w, A5              ; $FFFFA800
		jsr	Refresh_Plane_Tile_Deform(PC)          ; Offset_0x02FA9A
		lea	LBz_1_Deform_Array(PC), A4             ; Offset_0x0338F6
		lea	(Horizontal_Scroll_Table+$0008).w, A5        ; $FFFFA808
		jmp	Apply_Deformation(PC)                  ; Offset_0x02FD7C
; ===========================================================================
; Offset_0x03375E: LBz_1_Events_Run_2:
LBZ1_RunBackground:
		move.w	(Level_Events_Routine_2).w,d0
		jmp	LBZ1_BackgroundIndex(pc,d0.w) 
; ===========================================================================
; Offset_0x033766:
LBZ1_BackgroundIndex:
		bra.w	LBZ1_NormalBackground
		bra.w	LBZ1_LevelTransition
; ===========================================================================
; Offset_0x03376E: LBz_1_Normal:
LBZ1_NormalBackground:
		tst.w	(Level_Events_Buffer_5).w
		beq.s	.normalDeform
		clr.w	(Level_Events_Buffer_5).w

; LBZ1_BeginLoadingAct2:
		; The level transition appears to have been programmed for a much earlier build
		; of the game due to several oddities that cause it to break, as documented below
		movem.l	d7-a0/a2-a3,-(sp)
		lea	(Launch_Base_2_Chunks).l,a1
		lea	(M68K_RAM_Start).l,a2
		jsr	(Queue_Kos).l
		lea	(Launch_Base_2_Blocks_2).l,a1
		lea	(Blocks_Mem_Address+$628).w,a2
		jsr	(Queue_Kos).l
		; These tiles are decompressed to the wrong VRAM location; they
		; should be loaded at $2CA0, not $2D60
		lea	(Launch_Base_2_Tiles_2).l,a1
		move.w	#$2D60,d2
		jsr	(Queue_Kos_Module).l
		moveq	#$24,d0
		jsr	(LoadPLC).l
		moveq	#$25,d0
		jsr	(LoadPLC).l
		movem.l	(sp)+,d7-a0/a2-a3
		addq.w	#4,(Level_Events_Routine_2).w
; Offset_0x0337C6:
.normalDeform:
		jsr	LBZ1_Deform(pc)
		lea	LBz_1_Draw_Array(pc),a4
		lea	(Horizontal_Scroll_Table).w,a5
		moveq	#$20,d6
		moveq	#2,d5
		jsr	Draw_Background(pc)
		lea	LBz_1_Deform_Array(pc),a4
		lea	(Horizontal_Scroll_Table+8).w,a5
		jsr	Apply_Deformation(pc)
		lea	LBz_1_Vertical_Scroll_Array(pc),a4
		lea	(Horizontal_Scroll_Table+$12E).w,a5
		jsr	Apply_Foreground_Vertical_Scroll(pc)
		jmp	Earthquake_Setup(pc)
; ===========================================================================
; Offset_0x0337F6: LBz_1_Transition:
LBZ1_LevelTransition:
		tst.b	(Kos_modules_left).w
		bne.w	.normalDeform
		move.w	#LBz_Act_2,(Current_ZoneAndAct).w
		clr.b	(Saved_Level_Flag).w
		clr.b	(Saved_Level_Flag_P2).w
		clr.b	(Dynamic_Resize_Routine).w
		clr.b	(Object_Pos_Routine).w
		clr.b	(Ring_Pos_Routine).w
		clr.b	(Boss_Flag).w
		clr.l	(Animate_Counters).w
		clr.w	(Animate_Counters+4).w
		movem.l	d7-a0/a2-a3,-(sp)
		jsr	(LoadLevelLayout).l
		jsr	(LoadCollisionIndex).l
		jsr	(Level_InitWaterLevels).l
		; Since this was written when Act 1 still had water, it does not enable
		; the water VDP flag here
		moveq	#$17,d0
		jsr	(PalLoad_Now).l
		movem.l	(sp)+,d7-a0/a2-a3
		move.w	#$3A00,d0
		; This seems to have been written with an earlier version of the routine
		; in mind as it does not reset camera boundaries
		moveq	#0,d1
		sub.w	d0,(Obj_Player_One+x_pos).w
		sub.w	d1,(Obj_Player_One+y_pos).w
		sub.w	d0,(Obj_Player_Two+x_pos).w
		sub.w	d1,(Obj_Player_Two+y_pos).w
		jsr	Calc_Objects_X_Y_During_Transition(pc)
		sub.w	d0,(Camera_X).w
		sub.w	d1,(Camera_Y).w
		sub.w	d0,(Screen_Pos_Buffer_X).w
		sub.w	d1,(Screen_Pos_Buffer_Y).w
		jsr	Reset_Tile_Offset_Position_Actual(pc)
		clr.w	(Level_Events_Routine_2).w
; Offset_0x033878:
.normalDeform:
		lea	LBz_1_Deform_Array(pc),a4
		lea	(Horizontal_Scroll_Table+8).w,a5
		jmp	Apply_Deformation(pc)
; ===========================================================================
; Offset_0x033884: LBz_1_Deform:
LBZ1_Deform:
		; setup vertical scrolling
		move.w	(Screen_Pos_Buffer_Y).w,d0
		move.w	(Earthquake_Offset).w,d1
		sub.w	d1,d0
		asr.w	#4,d0
		add.w	d1,d0
		move.w	d0,(Screen_Pos_Buffer_Y_2).w
		; setup horizontal scrolling
		move.w	(Screen_Pos_Buffer_X).w,d0
                swap.w  d0
		clr.w	d0
		asr.l	#4,d0
		move.l	d0,d1
		asr.l	#1,d0
		swap.w	d0
		move.w	d0,(Background_Events+$10).w
		swap.w	d0
		swap.w	d1
		move.w	d1,(Screen_Pos_Buffer_X_2).w
		; the Death Egg and supports
		move.w	d1,(Horizontal_Scroll_Table).w
		move.w	d1,(Horizontal_Scroll_Table+8).w
		swap.w	d1
		; bushes (or trees?)
		lea	(Horizontal_Scroll_Table+$A).w,a1
		add.l	d0,d1
		add.l	d0,d1
		asr.l	#2,d0
		moveq	#4-1,d2

Offset_0x0338C8:
		swap.w	d1
		move.w	d1,(a1)+
		swap.w	d1
		add.l	d0,d1
		dbf	d2,Offset_0x0338C8
		moveq	#$A,d0
		add.w	d0,(Background_Events+$10).w
		add.w	d0,(Screen_Pos_Buffer_X_2).w
		add.w	d0,(Horizontal_Scroll_Table).w
		add.w	d0,(Horizontal_Scroll_Table+8).w
		lea	(Horizontal_Scroll_Table+$A).w,a1
		addq.w	#4,(a1)+
		subq.w	#2,(a1)+
		addq.w	#7,(a1)
		rts
; ===========================================================================
; Offset_0x0338F2:
LBz_1_Draw_Array:
		dc.w	$D0, $7FFF 
; Offset_0x0338F6:
LBz_1_Deform_Array:
		dc.w	$D0			; the Death Egg and supports
		dc.w	$18, 8, 8, $7FFF	; bushes/trees
; End of function LBZ1_Deform

;------------------------------------------------------------------------------- 
LBz_2_Events_Init:                                             ; Offset_0x033900
		move.w	#$0004, (Level_Events_Routine).w             ; $FFFFEEC0
		bsr.s	LBz_2_Layout_Mod                       ; Offset_0x033936
		jsr	Reset_Tile_Offset_Position_Actual(PC)  ; Offset_0x02FEF2
		jmp	Refresh_Plane_Full(PC)                 ; Offset_0x02FA7C  
;------------------------------------------------------------------------------- 
LBz_2_Events_Run:                                              ; Offset_0x033910
		move.w	(Level_Events_Routine).w, D0                 ; $FFFFEEC0
		jmp	Offset_0x033918(pc,d0.w) 
;-------------------------------------------------------------------------------
Offset_0x033918:
		bra.w	LBz_2_From_Transition                  ; Offset_0x033920
		bra.w	LBz_2_Normal                           ; Offset_0x033956 
;------------------------------------------------------------------------------- 
LBz_2_From_Transition:                                         ; Offset_0x033920
		cmpi.w	#$060A, (Obj_Player_One+x_pos).w             ; $FFFFB010
		bcs.s	Offset_0x033932
		bsr.s	LBz_2_Layout_Mod                       ; Offset_0x033936
		addq.w	#$04, (Level_Events_Routine).w               ; $FFFFEEC0
		jmp	Refresh_Plane_Screen_Direct(PC)        ; Offset_0x02FAE0
Offset_0x033932:
		jmp	LoadTilesAsYouMove_Foreground(PC)             ; Offset_0x02FB0E   
;------------------------------------------------------------------------------- 
LBz_2_Layout_Mod:                                              ; Offset_0x033936
		move.w	(A3), A5
		lea	$0094(A5), A5
		move.w	(A3), A1
		addq.w	#$06, A1
		move.w	-8(A3), D0
		subq.w	#$06, D0
		moveq	#$05, D1
Offset_0x033948:
		move.l	(A5)+, (A1)+
		move.w	(A5)+, (A1)+
		adda.w	D0, A5
		adda.w	D0, A1
		dbf	D1, Offset_0x033948
		rts  
;------------------------------------------------------------------------------- 
LBz_2_Normal:                                                  ; Offset_0x033956
		jmp	LoadTilesAsYouMove_Foreground(PC)             ; Offset_0x02FB0E    
;-------------------------------------------------------------------------------  
LBz_2_Events_Init_2:                                           ; Offset_0x03395A
		move.w	#$0008, (Level_Events_Routine_2).w           ; $FFFFEEC2
		jsr	LBz_2_Deform(PC)                       ; Offset_0x0339E4
		jsr	Reset_Tile_Offset_Position_Actual_2(PC) ; Offset_0x02FF0E
		moveq	#$00, D1
		jsr	Refresh_Plane_Full(PC)                 ; Offset_0x02FA7C
		lea	LBz_2_Deform_Array(PC), A4             ; Offset_0x033BDC
		lea	(Horizontal_Scroll_Table).w, A5              ; $FFFFA800
		jmp	Apply_Deformation(PC)                  ; Offset_0x02FD7C 
;-------------------------------------------------------------------------------   
LBz_2_Events_Run_2:                                            ; Offset_0x03397A
		move.w	(Level_Events_Routine_2).w, D0               ; $FFFFEEC2
		jmp	Offset_0x033982(pc,d0.w)  
;-------------------------------------------------------------------------------
Offset_0x033982:
		bra.w	LBz_2_From_Transition_2                ; Offset_0x03398E
		bra.w	LBz_2_Refresh                          ; Offset_0x0339AE
		bra.w	LBz_2_Normal_2                         ; Offset_0x0339C4    
;-------------------------------------------------------------------------------   
LBz_2_From_Transition_2:                                       ; Offset_0x03398E
		jsr	LBz_2_Deform(PC)                       ; Offset_0x0339E4
		jsr	Reset_Tile_Offset_Position_Actual_2(PC) ; Offset_0x02FF0E
		addi.w	#$00E0, D0
		and.w	(Level_Layout_Wrap_Y).w, D0                  ; $FFFFEEAC
		move.w	D0, (Draw_Delayed_Position).w                ; $FFFFEEC8
		move.w	#$000F, (Draw_Delayed_Position_Rowcount).w   ; $FFFFEECA
		addq.w	#$04, (Level_Events_Routine_2).w             ; $FFFFEEC2
		bra.s	Offset_0x0339B2   
;-------------------------------------------------------------------------------  
LBz_2_Refresh:                                                 ; Offset_0x0339AE
		jsr	LBz_2_Deform(PC)                       ; Offset_0x0339E4
Offset_0x0339B2:
		moveq	#$00, D1
		move.w	(Screen_Pos_Buffer_Y_2).w, D2                ; $FFFFEE90
		jsr	Draw_Plane_Vertical_Bottom_Up(PC)      ; Offset_0x02FCC6
		bpl.s	Offset_0x0339C8
		addq.w	#$04, (Level_Events_Routine_2).w             ; $FFFFEEC2
		bra.s	Offset_0x0339C8 
;-------------------------------------------------------------------------------   
LBz_2_Normal_2:                                                ; Offset_0x0339C4
		jsr	LBz_2_Deform(PC)                       ; Offset_0x0339E4
Offset_0x0339C8:
		lea	(Screen_Pos_Buffer_Y_2).w, A6                ; $FFFFEE90
		lea	(Screen_Pos_Rounded_Y_2).w, A5               ; $FFFFEE96
		moveq	#$00, D1
		moveq	#$20, D6
		jsr	DrawBlockRow(PC)                      ; Offset_0x02F8AA
		lea	LBz_2_Deform_Array(PC), A4             ; Offset_0x033BDC
		lea	(Horizontal_Scroll_Table).w, A5              ; $FFFFA800
		jmp	Apply_Deformation(PC)                  ; Offset_0x02FD7C
;------------------------------------------------------------------------------- 
LBz_2_Deform:                                                  ; Offset_0x0339E4
		move.w	(Screen_Pos_Buffer_Y).w, D0                  ; $FFFFEE84
		subi.w	#$05F0, D0
		move.w	D0, D1
                swap.w  D0
		clr.w	D0
		asr.l	#$01, D0
		move.l	D0, D2
		asr.l	#$03, D2
		sub.l	D2, D0
		asr.l	#$02, D2
		sub.l	D2, D0
                swap.w  D0
		move.w	D0, D2
		addi.w	#$02C0, D0
		move.w	D0, (Screen_Pos_Buffer_Y_2).w                ; $FFFFEE90
		sub.w	D1, D2
		move.w	D2, (Background_Events+$10).w                ; $FFFFEEE2
		move.w	(Screen_Pos_Buffer_X).w, D0                  ; $FFFFEE80
                swap.w  D0
		clr.w	D0
		tst.w	D2
		beq.w	Offset_0x033ACE
		move.l	D0, D1
		move.l	D0, D3
		asr.l	#$06, D3
		move.l	D3, D4
		asr.l	#$03, D4
		sub.l	D4, D3
		moveq	#$1F, D4
		cmpi.w	#$FFC0, D2
		bgt.s	Offset_0x033A4E
		lea	(Horizontal_Scroll_Table+$001E).w, A1        ; $FFFFA81E
Offset_0x033A36:
                swap.w  D1
		move.w	D1, (A1)+
                swap.w  D1
		sub.l	D3, D1
                swap.w  D1
		move.w	D1, (A1)+
                swap.w  D1
		sub.l	D3, D1
		dbf	D4, Offset_0x033A36
		bra.w	Offset_0x033ACE
Offset_0x033A4E:
		lea	(Horizontal_Scroll_Table+$011E).w, A1        ; $FFFFA91E
Offset_0x033A52:
                swap.w  D1
		move.w	D1, -(A1)
                swap.w  D1
		sub.l	D3, D1
                swap.w  D1
		move.w	D1, -(A1)
                swap.w  D1
		sub.l	D3, D1
		dbf	D4, Offset_0x033A52
		cmpi.w	#$0040, D2
		bge.s	Offset_0x033ACE
		lea	(Horizontal_Scroll_Table+$009E).w, A1        ; $FFFFA89E
		lea	(A1), A5
		lea	(Water_Surface_Scroll_Data), A6        ; Offset_0x1C8000
		move.w	D2, D1
		bmi.s	Offset_0x033AA6
		move.w	D1, D3
                neg.w   D3
		addi.w	#$0040, D3
		lsl.w	#$06, D3
		adda.w	D3, A6
		subq.w	#$01, D1
		moveq	#$00, D3
		lsr.w	#$01, D1
		bcc.s	Offset_0x033A98
Offset_0x033A90:
		move.b	(A6)+, D3
		add.w	D3, D3
		move.w	$00(A5, D3), (A1)+
Offset_0x033A98:
		move.b	(A6)+, D3
		add.w	D3, D3
		move.w	$00(A5, D3), (A1)+
		dbf	D1, Offset_0x033A90
		bra.s	Offset_0x033ACE
Offset_0x033AA6:
		move.w	D1, D3
		addi.w	#$0040, D3
		lsl.w	#$06, D3
		adda.w	D3, A6
                neg.w   D1
		subq.w	#$01, D1
		moveq	#$00, D3
		lsr.w	#$01, D1
		bcc.s	Offset_0x033AC2
Offset_0x033ABA:
		move.b	(A6)+, D3
		add.w	D3, D3
		move.w	$00(A5, D3), -(A1)
Offset_0x033AC2:
		move.b	(A6)+, D3
		add.w	D3, D3
		move.w	$00(A5, D3), -(A1)
		dbf	D1, Offset_0x033ABA
Offset_0x033ACE:
		lea	(Horizontal_Scroll_Table+$01E2).w, A1        ; $FFFFA9E2
		move.l	D0, D1
		asr.l	#$01, D1
		move.l	D1, D3
		asr.l	#$03, D3
                swap.w  D1
		move.w	D1, (Screen_Pos_Buffer_X_2).w                ; $FFFFEE8C
		move.w	D1, -(A1)
                swap.w  D1
		sub.l	D3, D1
                swap.w  D1
		move.w	D1, (Background_Events+$12).w                ; $FFFFEEE4
		move.w	D1, -(A1)
                swap.w  D1
		lea	LBz_2_Underwater_Deform_Array(PC), A5  ; Offset_0x033C1A
		sub.l	D3, D1
		moveq	#$04, D4
Offset_0x033AF8:
		sub.l	D3, D1
                swap.w  D1
		move.w	(A5)+, D5
Offset_0x033AFE:
		move.w	D1, -(A1)
		move.w	D1, -(A1)
		move.w	D1, -(A1)
		move.w	D1, -(A1)
		dbf	D5, Offset_0x033AFE
                swap.w  D1
		dbf	D4, Offset_0x033AF8
		moveq	#$3F, D3
		tst.w	D2
		bmi.s	Offset_0x033B1A
		sub.w	D2, D3
		bcs.s	Offset_0x033B28
Offset_0x033B1A:
                swap.w  D1
		lsr.w	#$01, D3
		bcc.s	Offset_0x033B22
Offset_0x033B20:
		move.w	D1, -(A1)
Offset_0x033B22:
		move.w	D1, -(A1)
		dbf	D3, Offset_0x033B20
Offset_0x033B28:
		lea	(Horizontal_Scroll_Table).w, A1              ; $FFFFA800
		lea	LBz_2_Cloud_Deform_Array(PC), A5       ; Offset_0x033C00
		move.l	D0, D1
		asr.l	#$06, D1
		move.l	D1, D3
		move.l	(Horizontal_Scroll_Table+$01E2).w, D4        ; $FFFFA9E2
		addi.l	#$00000E00, (Horizontal_Scroll_Table+$01E2).w ; $FFFFA9E2
		moveq	#$0C, D5
Offset_0x033B44:
		move.w	(A5)+, D6
		add.l	D4, D1
                swap.w  D1
		move.w	D1, $00(A1, D6)
                swap.w  D1
		add.l	D3, D1
		dbf	D5, Offset_0x033B44
		move.l	D0, D1
		asr.l	#$04, D1
		move.l	D1, D3
		asr.l	#$01, D3
		lea	(Horizontal_Scroll_Table+$001A).w, A1        ; $FFFFA81A
                swap.w  D1
		move.w	D1, (A1)+
                swap.w  D1
		add.l	D3, D1
                swap.w  D1
		move.w	D1, (A1)+
		tst.w	D2
		bpl.s	Offset_0x033B84
		moveq	#$3F, D4
		add.w	D2, D4
		bmi.s	Offset_0x033BA2
		cmpi.w	#$0030, D4
		bcs.s	Offset_0x033B96
		subi.w	#$0030, D4
		bra.s	Offset_0x033B86
Offset_0x033B84:
		moveq	#$0F, D4
Offset_0x033B86:
		moveq	#$17, D5
Offset_0x033B88:
		move.w	D1, (A1)+
		move.w	D1, (A1)+
		dbf	D5, Offset_0x033B88
                swap.w  D1
		add.l	D3, D1
                swap.w  D1
Offset_0x033B96:
		lsr.w	#$01, D4
		bcc.s	Offset_0x033B9C
Offset_0x033B9A:
		move.w	D1, (A1)+
Offset_0x033B9C:
		move.w	D1, (A1)+
		dbf	D4, Offset_0x033B9A
Offset_0x033BA2:
		moveq	#$3F, D0
		sub.w	D2, D0
		bmi.s	Offset_0x033BDA
		addi.w	#$0060, D0
		cmpi.w	#$00E0, D0
		bcs.s	Offset_0x033BB6
		move.w	#$00DF, D0
Offset_0x033BB6:
		lea	(Horizontal_Scroll_Table+$01DE).w, A1        ; $FFFFA9DE
		lea	LBz_Water_Bg_Deform_Delta(PC), A5      ; Offset_0x03045C
		move.w	(Level_frame_counter).w, D1                    ; $FFFFFE04
		asr.w	#$01, D1
		andi.w	#$007E, D1
		adda.w	D1, A5
		lsr.w	#$01, D0
		bcc.s	Offset_0x033BD2
Offset_0x033BCE:
		move.w	-(A5), D3
		add.w	D3, -(A1)
Offset_0x033BD2:
		move.w	-(A5), D3
		add.w	D3, -(A1)
		dbf	D0, Offset_0x033BCE
Offset_0x033BDA:
		rts 
;------------------------------------------------------------------------------- 
LBz_2_Deform_Array:                                            ; Offset_0x033BDC
		dc.w	$00C0, $0040, $0038, $0018, $0028, $0010, $0010, $0010
		dc.w	$0018, $0040, $0020, $0010, $0020, $0070, $0030, $80E0
		dc.w	$0020, $7FFF      
;------------------------------------------------------------------------------- 
LBz_2_Cloud_Deform_Array:                                      ; Offset_0x033C00
		dc.w	$0016, $000E, $000A, $0014, $000C, $0006, $0018, $0010
		dc.w	$0012, $0002, $0008, $0004, $0000   
;------------------------------------------------------------------------------- 
LBz_2_Underwater_Deform_Array:                                 ; Offset_0x033C1A       
		dc.w	$0007, $0001, $0003, $0001, $0007
;-------------------------------------------------------------------------------
MVz_1_Events_Init:                                             ; Offset_0x033C24
MVz_2_Events_Init:                                             ; Offset_0x033C24
		jsr	Reset_Tile_Offset_Position_Actual(PC)  ; Offset_0x02FEF2
		jmp	Refresh_Plane_Full(PC)                 ; Offset_0x02FA7C               
;------------------------------------------------------------------------------- 
MVz_1_Events_Run:                                              ; Offset_0x033C2C
MVz_2_Events_Run:                                              ; Offset_0x033C2C
		jmp	LoadTilesAsYouMove_Foreground(PC)             ; Offset_0x02FB0E               
;------------------------------------------------------------------------------- 
MVz_1_Events_Init_2:                                           ; Offset_0x033C30
MVz_2_Events_Init_2:                                           ; Offset_0x033C30
		jsr	MVz_Deform(PC)                         ; Offset_0x033C5A
		jsr	Reset_Tile_Offset_Position_Actual_2(PC) ; Offset_0x02FF0E
		moveq	#$00, D1
		jsr	Refresh_Plane_Full(PC)                 ; Offset_0x02FA7C
		jmp	Plain_Deformation(PC)                  ; Offset_0x02FD42                
;------------------------------------------------------------------------------- 
MVz_1_Events_Run_2:                                            ; Offset_0x033C42
MVz_2_Events_Run_2:                                            ; Offset_0x033C42
		jsr	MVz_Deform(PC)                         ; Offset_0x033C5A
		lea	(Screen_Pos_Buffer_Y_2).w, A6                ; $FFFFEE90
		lea	(Screen_Pos_Rounded_Y_2).w, A5               ; $FFFFEE96
		moveq	#$00, D1
		moveq	#$20, D6
		jsr	DrawBlockRow(PC)                      ; Offset_0x02F8AA
		jmp	Plain_Deformation(PC)                  ; Offset_0x02FD42                
;-------------------------------------------------------------------------------  
MVz_Deform:                                                    ; Offset_0x033C5A
		move.w	(Screen_Pos_Buffer_X).w, D0                  ; $FFFFEE80
		asr.w	#$01, D0
		move.w	D0, (Screen_Pos_Buffer_X_2).w                ; $FFFFEE8C
		move.w	(Screen_Pos_Buffer_Y).w, D0                  ; $FFFFEE84
		asr.w	#$01, D0
		move.w	D0, (Screen_Pos_Buffer_Y_2).w                ; $FFFFEE90
		rts
;------------------------------------------------------------------------------- 
LRz_1_Events_Init:                                             ; Offset_0x033C70
LRz_2_Events_Init:                                             ; Offset_0x033C70
		jsr	Reset_Tile_Offset_Position_Actual(PC)  ; Offset_0x02FEF2
		jmp	Refresh_Plane_Full(PC)                 ; Offset_0x02FA7C 
;-------------------------------------------------------------------------------
LRz_1_Events_Run:                                              ; Offset_0x033C78
LRz_2_Events_Run:                                              ; Offset_0x033C78
		move.w	(Earthquake_Offset).w, D0                    ; $FFFFEECE
		add.w	D0, (Screen_Pos_Buffer_Y).w                  ; $FFFFEE84
		jmp	LoadTilesAsYouMove_Foreground(PC)             ; Offset_0x02FB0E 
;-------------------------------------------------------------------------------
LRz_1_Events_Init_2:                                           ; Offset_0x033C84
LRz_2_Events_Init_2:                                           ; Offset_0x033C84
		jsr	LRz_Deform(PC)                         ; Offset_0x033CD4
		jsr	Reset_Tile_Offset_Position_Actual_2(PC) ; Offset_0x02FF0E
		clr.l	(Horizontal_Scroll_Table).w                  ; $FFFFA800
		move.w	D2, (Horizontal_Scroll_Table+$0006).w        ; $FFFFA806
		clr.l	(Horizontal_Scroll_Table+$0008).w            ; $FFFFA808
		lea	LRz_Deform_Array(PC), A4               ; Offset_0x033D40
		lea	(Horizontal_Scroll_Table).w, A5              ; $FFFFA800
		jsr	Refresh_Plane_Tile_Deform(PC)          ; Offset_0x02FA9A
		lea	LRz_Deform_Array_2(PC), A4             ; Offset_0x033D46
		lea	(Horizontal_Scroll_Table+$000C).w, A5        ; $FFFFA80C
		jmp	Apply_Deformation(PC)                  ; Offset_0x02FD7C 
;-------------------------------------------------------------------------------
LRz_1_Events_Run_2:                                            ; Offset_0x033CB0
LRz_2_Events_Run_2:                                            ; Offset_0x033CB0  
		jsr	LRz_Deform(PC)                         ; Offset_0x033CD4
		lea	LRz_Deform_Array(PC), A4               ; Offset_0x033D40
		lea	(Horizontal_Scroll_Table).w, A5              ; $FFFFA800
		moveq	#$20, D6
		moveq	#$03, D5
		jsr	Draw_Background(PC)                    ; Offset_0x02FB74
		lea	LRz_Deform_Array_2(PC), A4             ; Offset_0x033D46
		lea	(Horizontal_Scroll_Table+$000C).w, A5        ; $FFFFA80C
		jsr	Apply_Deformation(PC)                  ; Offset_0x02FD7C
		jmp	Earthquake_Setup(PC)                   ; Offset_0x02FFA4
;-------------------------------------------------------------------------------
LRz_Deform:                                                    ; Offset_0x033CD4
		move.w	(Screen_Pos_Buffer_Y).w, D0                  ; $FFFFEE84
		move.w	(Earthquake_Offset).w, D1                    ; $FFFFEECE
		sub.w	D1, D0
		asr.w	#$03, D0
		add.w	D1, D0
		move.w	D0, (Screen_Pos_Buffer_Y_2).w                ; $FFFFEE90
		move.w	(Screen_Pos_Buffer_X).w, D0                  ; $FFFFEE80
                swap.w  D0
		clr.w	D0
		asr.l	#$03, D0
		move.l	D0, D1
		move.l	D0, D2
		asr.l	#$02, D0
                swap.w  D1
		move.w	D1, (Screen_Pos_Buffer_X_2).w                ; $FFFFEE8C
		move.w	D1, (Horizontal_Scroll_Table+$0004).w        ; $FFFFA804
                swap.w  D1
		sub.l	D0, D1
                swap.w  D1
		move.w	D1, (Background_Events+$10).w                ; $FFFFEEE2
                swap.w  D1
		sub.l	D0, D1
                swap.w  D1
		move.w	D1, (Background_Events+$12).w                ; $FFFFEEE4
		lea	(Horizontal_Scroll_Table+$001C).w, A1        ; $FFFFA81C
		move.l	D2, D1
		moveq	#$07, D3
Offset_0x033D1C:
                swap.w  D1
		move.w	D1, -(A1)
                swap.w  D1
		add.l	D0, D1
		dbf	D3, Offset_0x033D1C
		lea	(Horizontal_Scroll_Table+$001C).w, A1        ; $FFFFA81C
		add.l	D0, D2
		add.l	D0, D0
		moveq	#$04, D3
Offset_0x033D32:
                swap.w  D2
		move.w	D2, (A1)+
                swap.w  D2
		add.l	D0, D2
		dbf	D3, Offset_0x033D32
		rts 
;-------------------------------------------------------------------------------  
LRz_Deform_Array:                                              ; Offset_0x033D40
		dc.w	$00B0, $0100, $7FFF  
;------------------------------------------------------------------------------- 
LRz_Deform_Array_2:                                            ; Offset_0x033D46
		dc.w	$0040, $0020, $0010, $0010, $0010, $0010, $0010, $0100
		dc.w	$0010, $0010, $0010, $0020, $7FFF
;-------------------------------------------------------------------------------
ALz_Events_Init:                                               ; Offset_0x033D60
BPz_Events_Init:                                               ; Offset_0x033D60
DPz_Events_Init:                                               ; Offset_0x033D60
CGz_Events_Init:                                               ; Offset_0x033D60
EMz_Events_Init:                                               ; Offset_0x033D60
		jsr	Update_Camera_P2_2(PC)                 ; Offset_0x02FF2C
		move.w	(Screen_Pos_Buffer_X).w, D0                  ; $FFFFEE80
		move.w	D0, (Level_Events_Buffer_0).w                ; $FFFFEEB4
		move.w	D0, (Level_Events_Buffer_1).w                ; $FFFFEEB6
		move.w	(Screen_Pos_Buffer_X_P2).w, D0               ; $FFFFEE68
		move.w	D0, (Level_Events_Buffer_0_P2).w             ; $FFFFEEB8
		move.w	D0, (Level_Events_Buffer_1_P2).w             ; $FFFFEEBA
		moveq	#$00, D0
		move.b	(Current_Zone).w, D0                             ; $FFFFFE10
		lsl.w	#$04, D0
		lea	(Competition_Screen_Init_Array-$E0)(PC), A1 ; Offset_0x034050
		adda.w	D0, A1
		move.w	(A1)+, (Screen_Wrap_X).w                     ; $FFFFEEA8
		move.w	(A1)+, (Screen_Wrap_Y).w                     ; $FFFFEEAA
		move.w	(A1)+, (Level_Layout_Wrap_Y).w               ; $FFFFEEAC
		move.w	(A1)+, (Level_Layout_Wrap_Row).w             ; $FFFFEEAE
		move.w	(A1)+, (VRAM_Add).w                          ; $FFFFEEB0
		move.w	(A1)+, D0
		move.w	(A1)+, D2
		move.w	(A1)+, D6
		moveq	#$00, D1
		move.w	#$8000, D7
		jmp	Offset_0x02FAC6(PC) 
;-------------------------------------------------------------------------------
ALz_Events_Run:                                                ; Offset_0x033DAE
BPz_Events_Run:                                                ; Offset_0x033DAE
DPz_Events_Run:                                                ; Offset_0x033DAE
CGz_Events_Run_Main:                                           ; Offset_0x033DAE
EMz_Events_Run:                                                ; Offset_0x033DAE
		jsr	Update_Camera_P2_2(PC)                 ; Offset_0x02FF2C
		move.w	(Screen_Wrap_X).w, D2                        ; $FFFFEEA8
		addq.w	#$01, D2
		move.w	D2, D3
		lsr.w	#$01, D2
		lea	(Level_Events_Buffer_0).w, A1                ; $FFFFEEB4
		move.w	(Screen_Pos_Buffer_X).w, D0                  ; $FFFFEE80
		jsr	Adjust_Background_During_Loop(PC)      ; Offset_0x02FF6C
		move.w	(Screen_Pos_Buffer_X_P2).w, D0               ; $FFFFEE68
		jmp	Adjust_Background_During_Loop(PC)      ; Offset_0x02FF6C 
;-------------------------------------------------------------------------------
CGz_Events_Run:                                                ; Offset_0x033DD0
		bsr.s	CGz_Events_Run_Main                    ; Offset_0x033DAE
		move.w	(Screen_Wrap_Y).w, D2                        ; $FFFFEEAA
		addq.w	#$01, D2
		move.w	D2, D3
		lsr.w	#$01, D2
		lea	(Background_Events).w, A1                    ; $FFFFEED2
		move.w	(Screen_Pos_Buffer_Y).w, D0                  ; $FFFFEE84
		jsr	Adjust_Background_During_Loop(PC)      ; Offset_0x02FF6C
		move.w	(Screen_Pos_Buffer_Y_P2).w, D0               ; $FFFFEE6C
		jmp	Adjust_Background_During_Loop(PC)      ; Offset_0x02FF6C
;-------------------------------------------------------------------------------
ALz_Events_Init_2:                                             ; Offset_0x033DF0
		jsr	ALz_Events_Run_2(PC)                   ; Offset_0x033E66
		bra.s	Competition_Event_Init                 ; Offset_0x033E42 
;-------------------------------------------------------------------------------
BPz_Events_Init_2:                                             ; Offset_0x033DF6
		jsr	BPz_Events_Run_2(PC)                   ; Offset_0x033E70
		bra.s	Competition_Event_Init                 ; Offset_0x033E42 
;------------------------------------------------------------------------------- 
DPz_Events_Init_2:                                             ; Offset_0x033DFC
		jsr	DPz_Events_Run_2(PC)                   ; Offset_0x033EBE
		bra.s	Competition_Event_Init                 ; Offset_0x033E42
;-------------------------------------------------------------------------------   
CGz_Events_Init_2:                                             ; Offset_0x033E02
		move.w	(Screen_Pos_Buffer_Y).w, D0                  ; $FFFFEE84
		move.w	D0, (Background_Events).w                    ; $FFFFEED2
		move.w	D0, (Background_Events+$02).w                ; $FFFFEED4
		move.w	(Screen_Pos_Buffer_Y_P2).w, D0               ; $FFFFEE6C
		move.w	D0, (Background_Events+$04).w                ; $FFFFEED6
		move.w	D0, (Background_Events+$06).w                ; $FFFFEED8
		move.w	#$0005, (Background_Events+$0A).w            ; $FFFFEEDC
		move.w	(Background_Events+$0A).w, D0                ; $FFFFEEDC
		addq.w	#$01, D0
		lsl.w	#$08, D0
		subi.w	#$0070, D0
		move.l	#$00900000, D1
		divu.w	D0, D1
		move.w	D1, (Background_Events+$08).w                ; $FFFFEEDA
		jsr	CGz_Events_Run_2(PC)                   ; Offset_0x033E7A
		bra.s	Competition_Event_Init                 ; Offset_0x033E42
;-------------------------------------------------------------------------------
EMz_Events_Init_2:                                             ; Offset_0x033E3E
		jsr	EMz_Events_Run_2(PC)                   ; Offset_0x033E84
;-------------------------------------------------------------------------------                
Competition_Event_Init:                                        ; Offset_0x033E42
		move.l	(Vertical_Scroll_Value_P2).w, (Vertical_Scroll_Value_P2_2).w ; $FFFFF61E, $FFFFEE3A
		moveq	#$00, D0
		move.b	(Current_Zone).w, D0                             ; $FFFFFE10
		lsl.w	#$04, D0
		lea	(Competition_Screen_Init_Array-$D4)(PC), A1 ; Offset_0x03405C
		adda.w	D0, A1
		move.w	(A1)+, D2
		move.w	(A1)+, D6
		moveq	#$00, D0
		moveq	#$00, D1
		move.w	#$A000, D7
		jmp	Offset_0x02FAC6(PC)  
;------------------------------------------------------------------------------- 
ALz_Events_Run_2:                                              ; Offset_0x033E66
		jsr	ALz_Deform(PC)                         ; Offset_0x033EF8
		lea	ALz_Deform_Array(PC), A4               ; Offset_0x034180
		bra.s	Offset_0x033E8C
;-------------------------------------------------------------------------------
BPz_Events_Run_2:                                              ; Offset_0x033E70
		jsr	BPz_Deform(PC)                         ; Offset_0x033FB6
		lea	BPz_Deform_Array(PC), A4               ; Offset_0x034196
		bra.s	Offset_0x033E8C 
;-------------------------------------------------------------------------------
CGz_Events_Run_2:                                              ; Offset_0x033E7A
		jsr	CGz_Deform(PC)                         ; Offset_0x03404C
		lea	CGz_Deform_Array(PC), A4               ; Offset_0x0341A4
		bra.s	Offset_0x033E8C      
;-------------------------------------------------------------------------------
EMz_Events_Run_2:                                              ; Offset_0x033E84
		jsr	EMz_Deform(PC)                         ; Offset_0x0340A8
		lea	EMz_Deform_Array(PC), A4               ; Offset_0x0341AE
Offset_0x033E8C:
		lea	(Horizontal_Scroll_Buffer).w, A1             ; $FFFFE000
		move.l	A4, A6
		lea	(Horizontal_Scroll_Table).w, A5              ; $FFFFA800
		move.w	(Screen_Pos_Buffer_Y_2).w, D0                ; $FFFFEE90
		move.w	(Screen_Pos_Buffer_X).w, D3                  ; $FFFFEE80
		moveq	#$6B, D1
		jsr	Offset_0x02FD8C(PC)
		move.l	A6, A4
		lea	(Horizontal_Scroll_Table+$0100).w, A5        ; $FFFFA900
		move.w	(Screen_Pos_Buffer_Y_P2_2).w, D0             ; $FFFFEE74
		subq.w	#$04, D0
		move.w	(Screen_Pos_Buffer_X_P2).w, D3               ; $FFFFEE68
		moveq	#$73, D1
		jsr	Offset_0x02FD8C(PC)
		jmp	Update_Vertical_Scroll_Value_P2(PC)    ; Offset_0x02FF3A
;-------------------------------------------------------------------------------
DPz_Events_Run_2:                                              ; Offset_0x033EBE
		jsr	DPz_Deform(PC)                         ; Offset_0x034004
		lea	(Horizontal_Scroll_Buffer).w, A1             ; $FFFFE000
		move.w	(Screen_Pos_Buffer_X).w, D0                  ; $FFFFEE80
		move.w	(Screen_Pos_Buffer_X_2).w, D1                ; $FFFFEE8C
		moveq	#$1A, D2
		bsr.s	Offset_0x033EE2
		move.w	(Screen_Pos_Buffer_X_P2).w, D0               ; $FFFFEE68
		move.w	(Screen_Pos_Buffer_X_P2_2).w, D1             ; $FFFFEE70
		moveq	#$1C, D2
		bsr.s	Offset_0x033EE2
		jmp	Update_Vertical_Scroll_Value_P2(PC)    ; Offset_0x02FF3A
Offset_0x033EE2:
                neg.w   D0
                swap.w  D0
                neg.w   D1
		move.w	D1, D0
Offset_0x033EEA:
		move.l	D0, (A1)+
		move.l	D0, (A1)+
		move.l	D0, (A1)+
		move.l	D0, (A1)+
		dbf	D2, Offset_0x033EEA
		rts  
;-------------------------------------------------------------------------------
ALz_Deform:                                                    ; Offset_0x033EF8
		move.w	(Screen_Pos_Buffer_Y).w, D0                  ; $FFFFEE84
		bsr.s	Offset_0x033F30
		move.w	D0, (Screen_Pos_Buffer_Y_2).w                ; $FFFFEE90
		move.w	(Screen_Pos_Buffer_Y_P2).w, D0               ; $FFFFEE6C
		bsr.s	Offset_0x033F30
		move.w	D0, (Screen_Pos_Buffer_Y_P2_2).w             ; $FFFFEE74
		addq.w	#$03, (Background_Events).w                  ; $FFFFEED2
		addi.l	#$00001000, (Background_Events+$02).w        ; $FFFFEED4
		lea	Default_Background_Deform_Delta(PC), A4 ; Offset_0x031820
		lea	(Horizontal_Scroll_Table).w, A1              ; $FFFFA800
		move.w	(Level_Events_Buffer_1).w, D0                ; $FFFFEEB6
		bsr.s	Offset_0x033F46
		lea	(Horizontal_Scroll_Table+$0100).w, A1        ; $FFFFA900
		move.w	(Level_Events_Buffer_1_P2).w, D0             ; $FFFFEEBA
		bra.s	Offset_0x033F46
Offset_0x033F30:
		subi.w	#$0148, D0
                swap.w  D0
		clr.w	D0
		move.l	D0, D1
		asr.l	#$02, D1
		sub.l	D1, D0
                swap.w  D0
		addi.w	#$0048, D0
		rts
Offset_0x033F46:
                swap.w  D0
		clr.w	D0
		asr.l	#$01, D0
		move.l	D0, $0090(A1)
		asr.l	#$03, D0
		lea	$000C(A1), A5
		move.l	D0, D1
		asr.l	#$02, D1
		move.l	D1, D2
		move.l	(Background_Events+$02).w, D3                ; $FFFFEED4
		moveq	#$05, D4
Offset_0x033F62:
		add.l	D3, D1
                swap.w  D1
		move.w	D1, -(A5)
                swap.w  D1
		add.l	D2, D1
		dbf	D4, Offset_0x033F62
		movem.w	(A5), D1-D6
		move.w	D2, (A5)+
		move.w	D6, (A5)+
		move.w	D1, (A5)+
		move.w	D4, (A5)+
		move.w	D3, (A5)+
		move.w	D5, (A5)
		lea	$000C(A1), A5
		move.l	D0, D1
		move.l	D1, D2
		asr.l	#$01, D2
		moveq	#$02, D3
Offset_0x033F8C:
                swap.w  D1
		move.w	D1, (A5)+
                swap.w  D1
		add.l	D2, D1
		dbf	D3, Offset_0x033F8C
		move.w	(Background_Events).w, D1                    ; $FFFFEED2
		lsr.w	#$03, D1
		andi.w	#$003E, D1
		lea	$00(A4, D1), A6
                swap.w  D0
		moveq	#$3E, D1
Offset_0x033FAA:
		move.w	(A6)+, D2
		add.w	D0, D2
		move.w	D2, (A5)+
		dbf	D1, Offset_0x033FAA
		rts  
;-------------------------------------------------------------------------------  
BPz_Deform:                                                    ; Offset_0x033FB6
		move.w	(Screen_Pos_Buffer_Y).w, D0                  ; $FFFFEE84
		bsr.s	Offset_0x033FDE
		move.w	D0, (Screen_Pos_Buffer_Y_2).w                ; $FFFFEE90
		move.w	(Screen_Pos_Buffer_Y_P2).w, D0               ; $FFFFEE6C
		bsr.s	Offset_0x033FDE
		move.w	D0, (Screen_Pos_Buffer_Y_P2_2).w             ; $FFFFEE74
		lea	(Horizontal_Scroll_Table+$000E).w, A1        ; $FFFFA80E
		move.w	(Level_Events_Buffer_1).w, D0                ; $FFFFEEB6
		bsr.s	Offset_0x033FEA
		lea	(Horizontal_Scroll_Table+$010E).w, A1        ; $FFFFA90E
		move.w	(Level_Events_Buffer_1_P2).w, D0             ; $FFFFEEBA
		bsr.s	Offset_0x033FEA
Offset_0x033FDE:
		subi.w	#$02C8, D0
		asr.w	#$01, D0
		addi.w	#$0090, D0
		rts
Offset_0x033FEA:
                swap.w  D0
		clr.w	D0
		asr.l	#$01, D0
		move.l	D0, D1
		asr.l	#$03, D1
		moveq	#$06, D2
Offset_0x033FF6:
                swap.w  D0
		move.w	D0, -(A1)
                swap.w  D0
		sub.l	D1, D0
		dbf	D2, Offset_0x033FF6
		rts  
;------------------------------------------------------------------------------- 
DPz_Deform:                                                    ; Offset_0x034004
		move.w	(Screen_Pos_Buffer_Y).w, D0                  ; $FFFFEE84
		bsr.s	Offset_0x03403A
		move.w	D0, (Screen_Pos_Buffer_Y_2).w                ; $FFFFEE90
		move.w	(Screen_Pos_Buffer_Y_P2).w, D0               ; $FFFFEE6C
		bsr.s	Offset_0x03403A
		addi.w	#$0080, D0
		move.w	D0, (Screen_Pos_Buffer_Y_P2_2).w             ; $FFFFEE74
		move.w	(Level_Events_Buffer_1).w, D0                ; $FFFFEEB6
		bsr.s	Offset_0x034044
		move.w	D0, (Screen_Pos_Buffer_X_2).w                ; $FFFFEE8C
		move.w	D1, (Background_Events+$10).w                ; $FFFFEEE2
		move.w	(Level_Events_Buffer_1_P2).w, D0             ; $FFFFEEBA
		bsr.s	Offset_0x034044
		move.w	D0, (Screen_Pos_Buffer_X_P2_2).w             ; $FFFFEE70
		move.w	D1, (Background_Events+$12).w                ; $FFFFEEE4
		rts
Offset_0x03403A:
		subi.w	#$0148, D0
		asr.w	#$04, D0
		addq.w	#$08, D0
		rts
Offset_0x034044:
		asr.w	#$01, D0
		move.w	D0, D1
		asr.w	#$02, D1
		rts  
;------------------------------------------------------------------------------- 
CGz_Deform:                                                    ; Offset_0x03404C
		move.w	(Background_Events+$02).w, D0                ; $FFFFEED4
		bsr.s	Offset_0x034074
		move.w	D0, (Screen_Pos_Buffer_Y_2).w                ; $FFFFEE90
		move.w	(Background_Events+$06).w, D0                ; $FFFFEED8
		bsr.s	Offset_0x034074
		move.w	D0, (Screen_Pos_Buffer_Y_P2_2).w             ; $FFFFEE74
		lea	(Horizontal_Scroll_Table+$000A).w, A1        ; $FFFFA80A
		move.w	(Level_Events_Buffer_1).w, D0                ; $FFFFEEB6
		bsr.s	Offset_0x034084
		lea	(Horizontal_Scroll_Table+$010A).w, A1        ; $FFFFA90A
		move.w	(Level_Events_Buffer_1_P2).w, D0             ; $FFFFEEBA
		bsr.s	Offset_0x034084
Offset_0x034074:
		bmi.s	Offset_0x034080
		move.w	(Background_Events+$08).w, D1                ; $FFFFEEDA
		mulu.w	D1, D0
                swap.w  D0
		rts
Offset_0x034080:
		moveq	#$00, D0
		rts
Offset_0x034084:
                swap.w  D0
		clr.w	D0
		asr.l	#$01, D0
		move.l	D0, D1
		asr.l	#$02, D1
		moveq	#$03, D2
Offset_0x034090:
                swap.w  D0
		move.w	D0, -(A1)
                swap.w  D0
		sub.l	D1, D0
		dbf	D2, Offset_0x034090
		asr.l	#$02, D1
                swap.w  D1
		addi.w	#$0100, D1
		move.w	D1, -(A1)
		rts  
;------------------------------------------------------------------------------- 
EMz_Deform:                                                    ; Offset_0x0340A8
		move.w	(Screen_Pos_Buffer_Y).w, D0                  ; $FFFFEE84
		bsr.s	Offset_0x0340D0
		move.w	D0, (Screen_Pos_Buffer_Y_2).w                ; $FFFFEE90
		move.w	(Screen_Pos_Buffer_Y_P2).w, D0               ; $FFFFEE6C
		bsr.s	Offset_0x0340D0
		move.w	D0, (Screen_Pos_Buffer_Y_P2_2).w             ; $FFFFEE74
		lea	(Horizontal_Scroll_Table).w, A1              ; $FFFFA800
		move.w	(Level_Events_Buffer_1).w, D0                ; $FFFFEEB6
		bsr.s	Offset_0x0340E6
		lea	(Horizontal_Scroll_Table+$0100).w, A1        ; $FFFFA900
		move.w	(Level_Events_Buffer_1_P2).w, D0             ; $FFFFEEBA
		bsr.s	Offset_0x0340E6
Offset_0x0340D0:
		subi.w	#$0148, D0
                swap.w  D0
		clr.w	D0
		move.l	D0, D1
		asr.l	#$02, D1
		sub.l	D1, D0
                swap.w  D0
		addi.w	#$0048, D0
		rts
Offset_0x0340E6:
                swap.w  D0
		clr.w	D0
		asr.l	#$03, D0
		move.l	D0, D1
                swap.w  D0
		move.w	D0, $000E(A1)
                swap.w  D0
		add.l	D1, D0
                swap.w  D0
		move.w	D0, $000C(A1)
		move.w	D0, $0010(A1)
                swap.w  D0
		add.l	D1, D0
                swap.w  D0
		move.w	D0, $0006(A1)
		move.w	D0, $000A(A1)
		move.w	D0, $0012(A1)
                swap.w  D0
		add.l	D1, D0
                swap.w  D0
		move.w	D0, (A1)
		move.w	D0, $0004(A1)
		move.w	D0, $0008(A1)
                swap.w  D0
		add.l	D1, D0
                swap.w  D0
		move.w	D0, $0002(A1)
		rts          
;-------------------------------------------------------------------------------
Competition_Screen_Init_Array:                                 ; Offset_0x034130
		dc.w	$03FF, $01FF, $01F0, $000C, $0100, $0100, $000F, $0040
		dc.w	$01FF, $03FF, $03F0, $001C, $0080, $0200, $001F, $0020
		dc.w	$03FF, $01FF, $01F0, $000C, $0100, $0100, $000F, $0040
		dc.w	$03FF, $00FF, $00F0, $0004, $0100, $0100, $000F, $0040
		dc.w	$03FF, $01FF, $01F0, $000C, $0100, $0100, $000F, $0040 
;-------------------------------------------------------------------------------
ALz_Deform_Array:                                              ; Offset_0x034180                
		dc.w	$0018, $0008, $0008, $0008, $0008, $0008, $002E, $0006
		dc.w	$000D, $803F, $7FFF 
;-------------------------------------------------------------------------------
BPz_Deform_Array:                                              ; Offset_0x034196
		dc.w	$0088, $0016, $000A, $0028, $0010, $0008, $7FFF         
;-------------------------------------------------------------------------------
CGz_Deform_Array:                                              ; Offset_0x0341A4
		dc.w	$0050, $0008, $0010, $0010, $7FFF                       
;------------------------------------------------------------------------------- 
EMz_Deform_Array:                                              ; Offset_0x0341AE
		dc.w	$0010, $0010, $0010, $0010, $0008, $000C, $0024, $0038
		dc.w	$0020, $7FFF

; ===========================================================================
; ---------------------------------------------------------------------------
; Generic level screen routines
; ---------------------------------------------------------------------------
; Offset_0x0341C2: LevelFGSetup_Null:
Level_RefreshScreen:
		jsr	Reset_Tile_Offset_Position_Actual(pc)
		jmp	Refresh_Plane_Full(pc)
; ===========================================================================
; Offset_0x0341CA: LevelFGRun_Null:
Level_RunScreen:
		jmp	LoadTilesAsYouMove_Foreground(pc)
; ===========================================================================
; Offset_0x0341CE: LevelBGSetup_Null:
Level_RefreshBackground:
		jsr	Level_Deform(pc)
		jsr	Reset_Tile_Offset_Position_Actual_2(pc)
		jsr	Refresh_Plane_Full(pc)
		jmp	Plain_Deformation(pc)
; ===========================================================================
; Offset_0x0341DE: LevelBGRun_Null:
Level_RunBackground:
		jsr	Level_Deform(pc)
		jsr	LoadTilesAsYouMove_Background(pc)
		jmp	Plain_Deformation(pc)
; ===========================================================================
; Offset_0x0341EA: Default_Deform:
Level_Deform:
		move.w	(Screen_Pos_Buffer_X).w,d0
		asr.w	#3,d0
		move.w	d0,(Screen_Pos_Buffer_X_2).w
		move.w	(Screen_Pos_Buffer_Y).w,d0
		asr.w	#3,d0
		move.w	d0,(Screen_Pos_Buffer_Y_2).w
		rts
; End of function Level_Deform