; ===========================================================================
; ---------------------------------------------------------------------------
; Object - Robotnik Head in Hydrocity, Marble Garden, Carnival Night, and IceCap
; ---------------------------------------------------------------------------
; Offset_0x03605E: Robotnik_Head:
Obj_RobotnikHead:
		jsr	(Refresh_Child_Position_Adjusted).l
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	RobotnikHead_Index(pc,d0.w),d1
		jsr	RobotnikHead_Index(pc,d1.w)
		jmp	(Child_Display_Or_Delete_2).l
; ===========================================================================
; Offset_0x036078:
RobotnikHead_Index:
		dc.w RobotnikHead_Init-RobotnikHead_Index
		dc.w RobotnikHead_Main-RobotnikHead_Index
		dc.w RobotnikHead_Delete-RobotnikHead_Index
; ===========================================================================
; Offset_0x03607E:
RobotnikHead_Init:
		lea	RobotnikHead_ObjData(pc),a1
		jsr	(SetupObjectAttributes).l
		jsr	(Boss_Test_And_Set_Layer_Flag).l
		move.w	Obj_Child_Ref(a0),a1
		move.w	Obj_Child_Ref(a1),Obj_Height_3(a0)

Offset_0x036098:
		rts
; ===========================================================================
; Offset_0x03609A:
RobotnikHead_Main:
		lea	RobotnikHead_AnimateData(pc),a1
		jsr	(Animate_Raw_A1).l
		move.w	Obj_Height_3(a0),a1
		btst	#7,Obj_Status(a1)	; has Robotnik been defeated?
		bne.s	RobotnikHead_Defeated	; if yes, branch
		btst	#6,Obj_Status(a1)	; has Robotnik been hit?
		beq.s	Offset_0x0360BE		; if not, branch
		move.b	#2,Obj_Map_Id(A0)	; use "hit" frame

Offset_0x0360BE:
		rts
; ---------------------------------------------------------------------------
; Offset_0x0360C0:
RobotnikHead_Defeated:
		move.b	#4,routine(a0)
		move.b	#3,Obj_Map_Id(a0)	; use "defeated" frame
		rts  
; ===========================================================================
; Offset_0x0360CE:
RobotnikHead_Delete:
		jmp	(Refresh_Child_Position_Adjusted).l

; ===========================================================================
; ---------------------------------------------------------------------------
; Object - Robotnik Head in Angel Island
; ---------------------------------------------------------------------------
; Offset_0x0360D4:
Obj_AIZRobotnikHead:
		jsr	(Refresh_Child_Position_Adjusted).l
		jsr	(Boss_Test_And_Set_Layer_Flag).l
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	AIZRobotnikHead_Index(pc,d0.w),d1
		jsr	AIZRobotnikHead_Index(pc,d1.w)
		btst	#6,Obj_Control_Var_08(a0)
		bne.w	Offset_0x036098
		jmp	(Child_Display_Or_Delete_2).l
; ===========================================================================
; Offset_0x0360FE:
AIZRobotnikHead_Index:
		dc.w RobotnikHead_Init-AIZRobotnikHead_Index
		dc.w RobotnikHead_Main-AIZRobotnikHead_Index
		dc.w RobotnikHead_Delete-AIZRobotnikHead_Index

; ===========================================================================
; ---------------------------------------------------------------------------
; Object - Robotnik Head in Flying Duracell
; ---------------------------------------------------------------------------
; Offset_0x036104: FBz_Robotnik_Head:
Obj_FBZRobotnikHead:
		jsr	(Refresh_Child_Position_Adjusted).l
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	FBZRobotnikHead_Index(pc,d0.w),d1
		jsr	FBZRobotnikHead_Index(pc,d1.w)
		jsr	(Child_Get_Priority).l
		jmp	(Child_Display_Or_Delete_2).l
; ===========================================================================
; Offset_0x036124:
FBZRobotnikHead_Index:
		dc.w FBZRobotnikHead_Init-FBZRobotnikHead_Index
		dc.w FBZRobotnikHead_Main-FBZRobotnikHead_Index
		dc.w RobotnikHead_Delete-FBZRobotnikHead_Index
; ===========================================================================
; Offset_0x03612A:
FBZRobotnikHead_Init:
		lea	FBZRobotnikHead_ObjData(pc),a1
		jsr	(SetupObjectAttributes).l
		move.w	Obj_Child_Ref(a0),a1
		move.w	Obj_Child_Ref(a1),Obj_Height_3(a0)
		rts      
; ===========================================================================
; Offset_0x036140:
FBZRobotnikHead_Main:
		move.w	x_pos(a0),d0
		bclr	#0,render_flags(a0)
		cmp.w	(Obj_Player_One+x_pos).w,d0	; is player to Robotnik's right?
		bcc.s	Offset_0x036156			; if not, branch
		bset	#0,render_flags(a0)		; flip Robotnik's head

Offset_0x036156:
		clr.b	Obj_Map_Id(a0)
		move.w	Obj_Height_3(a0),a1
		; This should be using a1; as a result, the forward-facing
		; Robotnik head goes unused, OOPS
		btst	#2,Obj_Control_Var_08(a0)	; is Robotnik swinging round and round?
		beq.s	Offset_0x03616C			; if yes, branch
		move.b	#1,Obj_Map_Id(a0)		; use "forward" frame

Offset_0x03616C:
		btst	#7,Obj_Status(a1)	; has Robotnik been defeated?
		bne.s	Offset_0x036184		; if yes, branch
		btst	#6,Obj_Status(a1)	; has Robotnik been hit?
		beq.s	Offset_0x036182		; if not, branch
		move.b	#2,Obj_Map_Id(a0)	; use "hit" frame

Offset_0x036182:
		rts
; ---------------------------------------------------------------------------

Offset_0x036184:
		move.b	#4,routine(a0)
		move.b	#3,Obj_Map_Id(a0)	; use "defeated" frame
		rts

; ===========================================================================
; ---------------------------------------------------------------------------
; Object - Robotnik Head in Launch Base
; ---------------------------------------------------------------------------
; Offset_0x036192: LBz_Robotnik_Ship:
Obj_LBZRobotnikHead:
		jsr	(Refresh_Child_Position_Adjusted).l
		moveq	#0,d0
		move.b	routine(a0),d0
		move.w	LBZRobotnikHead_Index(pc,d0.w),d1
		jsr	LBZRobotnikHead_Index(pc,d1.w)
		jmp	(Child_Display_Or_Delete_2).l
; ===========================================================================  
; Offset_0x0361AC:
LBZRobotnikHead_Index:
		dc.w LBZRobotnikHead_Init-LBZRobotnikHead_Index
		dc.w LBZRobotnikHead_Main-LBZRobotnikHead_Index
		dc.w RobotnikHead_Delete-LBZRobotnikHead_Index
; ===========================================================================
; Offset_0x0361B2:
LBZRobotnikHead_Init:
		lea	RobotnikHead_ObjData(pc),a1
		jmp	(SetupObjectAttributes).l
; ===========================================================================
; Offset_0x0361BC:
LBZRobotnikHead_Main:
		lea	RobotnikHead_AnimateData(pc),a1
		jsr	(Animate_Raw_A1).l
		move.w	Obj_Child_Ref(a0),a1
		btst	#7,Obj_Status(a1)	; has Robotnik been defeated?
		bne.s	Offset_0x0361E2		; if yes, branch
		btst	#6,Obj_Status(a1)	; has Robotnik been hit?
		beq.s	Offset_0x0361E0		; if not, branch
		move.b	#2,Obj_Map_Id(a0)	; use "forward" frame

Offset_0x0361E0:
		rts
; ---------------------------------------------------------------------------

Offset_0x0361E2:
		move.b	#4,routine(a0)
		move.b	#3,Obj_Map_Id(a0)	; use "defeated" frame
		rts