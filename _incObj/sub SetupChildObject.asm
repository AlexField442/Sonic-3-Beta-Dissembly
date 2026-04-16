; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to setup a child object
; ---------------------------------------------------------------------------
; Offset_0x041D9A: Load_Child_Object_A2:
SetupChildObject:
		moveq	#0,d2
		move.w	(a2)+,d6	; get number of objects in list

Offset_0x041D9E:
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	Offset_0x041DE8
		move.w	a0,Obj_Child_Ref(a1)			; load parent RAM address into $46

		move.l	mappings(a0),mappings(a1)
		; not sure why this is also a longword, given that VRAM is stored as a word
		move.l	art_tile(a0),art_tile(a1)		; mappings and VRAM offset copied from parent object
		move.l	(a2)+,(a1)				; object address
		move.b	d2,Obj_Subtype(a1)			; index of child object
		move.w	x_pos(a0),d0
		move.b	(a2)+,d1				; x positional offset
		move.b	d1,Obj_Control_Var_12(a1)
		ext.w	d1
		add.w	d1,d0
		move.w	d0,x_pos(a1)				; apply offset to new x position
		move.w	y_pos(a0),d0
		move.b	(a2)+,d1				; y positional offset
		move.b	d1,Obj_Control_Var_13(a1)
		ext.w	d1
		add.w	d1,d0
		move.w	d0,y_pos(a1)				; apply offset to new y position
		addq.w	#2,d2
		dbf	d6,Offset_0x041D9E
		moveq	#0,d0

Offset_0x041DE8:
		rts
; End of function SetupChildObject

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to setup a child object, now taking into account velocity
; and other variables
; ---------------------------------------------------------------------------
; Offset_0x041DEA: Load_Child_Object_Complex_A2:
SetupChildObject_Complex:
		moveq	#0,d2
		move.w	(a2)+,d6	; get number of objects in list

Offset_0x041DEE:
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	Offset_0x041E4C
		move.w	a0,Obj_Child_Ref(a1)

		move.l	mappings(a0),mappings(a1)
		move.l	art_tile(A0),art_tile(a1)
		move.l	(a2)+,(a1)
		move.l	(a2)+,Obj_Control_Var_0E(a1)
		move.l	(a2)+,Obj_Control_Var_00(a1)
		move.l	(a2)+,Obj_Control_Var_04(a1)
		move.b	d2,Obj_Subtype(a1)
		move.w	x_pos(a0),d0
		move.b	(a2)+,d1
		move.b	d1,Obj_Control_Var_12(a1)
		ext.w	d1
		add.w	d1,d0
		move.w	d0,x_pos(a1)
		move.w	y_pos(a0),d0
		move.b	(a2)+,d1
		move.b	d1,Obj_Control_Var_13(a1)
		ext.w	d1
		add.w	d1,d0
		move.w	d0,y_pos(a1)
		move.w	(a2)+,x_vel(a1)
		move.w	(a2)+,y_vel(a1)
		addq.w	#2,d2
		dbf	d6,Offset_0x041DEE
		moveq	#0,d0

Offset_0x041E4C:
		rts
; End of function SetupChildObject_Complex

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to setup several identical child objects
; ---------------------------------------------------------------------------
; Offset_0x041E4E: Load_Child_Object_Repeat_A2:
SetupChildObject_Repeat:
		moveq	#0,d2
		move.w	(a2)+,d6	; get number of objects in list

Offset_0x041E52:
		move.l	a2,a3
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	Offset_0x041E9E
		move.w	a0,Obj_Child_Ref(a1)

		move.l	mappings(a0),mappings(a1)
		move.l	art_tile(a0),art_tile(a1)
		move.l	(a3)+,(a1)
		move.b	d2,Obj_Subtype(a1)
		move.w	x_pos(a0),d0
		move.b	(a3)+,d1
		move.b	d1,Obj_Control_Var_12(a1)
		ext.w	d1
		add.w	d1,d0
		move.w	d0,x_pos(a1)
		move.w	y_pos(a0),d0
		move.b	(a3)+,d1
		move.b	d1,Obj_Control_Var_13(a1)
		ext.w	d1
		add.w	d1,d0
		move.w	d0,y_pos(a1)
		addq.w	#2,d2
		dbf	d6,Offset_0x041E52
		moveq	#0,d0

Offset_0x041E9E:
		rts
; End of function SetupChildObject_Repeat

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to setup a child object using a linked list
; ---------------------------------------------------------------------------
; Offset_0x041EA0: Load_Child_Object_Link_List_Repeat_A2:
SetupChildObject_LinkedList:
		move.l	a0,a3
		moveq	#0,d2
		move.w	(a2)+,d6	; get number of objects in list

Offset_0x041EA6:
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	Offset_0x041EDE
		move.w	a3,Obj_Child_Ref(a1)		; store parent address
		move.w	a1,Obj_Height_3(a3)		; store child address
		move.l	a1,a3				; get next parent address
		move.l	mappings(a0),mappings(a1)
		move.l	art_tile(a0),art_tile(a1)
		move.l	(a2),(a1)
		move.b	d2,Obj_Subtype(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		addq.w	#2,d2
		dbf	d6,Offset_0x041EA6
		moveq	#0,d0

Offset_0x041EDE:
		rts
; End of function SetupChildObject_LinkedList

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to setup a child object like SetupChildObject_Complex, but
; adjusting x-position and velocity based on parent's orientation
; ---------------------------------------------------------------------------
; Offset_0x041EE0: Load_Child_Object_Complex_Adjusted_A2:
SetupChildObject_ComplexAdjusted:
		moveq	#0,d2
		move.w	(a2)+,d6	; get number of objects in list

Offset_0x041EE4:
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	Offset_0x041F58
		move.w	a0,Obj_Child_Ref(a1)
		move.l	mappings(a0),mappings(a1)
		move.l	art_tile(a0),art_tile(a1)
		move.l	(a2)+,(a1)
		move.l	(a2)+,Obj_Control_Var_0E(a1)
		move.l	(a2)+,Obj_Control_Var_00(a1)
		move.l	(a2)+,Obj_Control_Var_04(a1)
		move.b	d2,Obj_Subtype(a1)
		move.w	x_pos(a0),d0
		move.b	(a2)+,d1
		move.b	d1,Obj_Control_Var_12(a1)
		ext.w	d1
		btst	#0,render_flags(a0)
		beq.s	Offset_0x041F24
                neg.w	d1

Offset_0x041F24:
		add.w	d1,d0
		move.w	d0,x_pos(a1)
		move.w	y_pos(a0),d0
		move.b	(a2)+,d1
		move.b	d1,Obj_Control_Var_13(a1)
		ext.w	d1
		add.w	d1,d0
		move.w	d0,y_pos(a1)
		move.w	(a2)+,d1
		btst	#0,render_flags(a0)
		beq.s	Offset_0x041F48
                neg.w	d1

Offset_0x041F48:
		move.w	d1,x_vel(a1)
		move.w	(a2)+,y_vel(a1)
		addq.w	#2,d2
		dbf	d6,Offset_0x041EE4
		moveq	#0,d0

Offset_0x041F58:
		rts
; End of function SetupChildObject_ComplexAdjusted

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to setup a child object identical to its parent
; ---------------------------------------------------------------------------
; Offset_0x041F5A: Load_Child_Object_Simple_A2:
SetupChildObject_Simple:
		moveq	#0,d2
		move.w	(a2)+,d6	; get number of objects in list

Offset_0x041F5E:
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	Offset_0x041F84
		move.w	a0,Obj_Child_Ref(a1)
		move.l	(a2),(a1)
		move.b	d2,Obj_Subtype(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		addq.w	#2,d2
		dbf	d6,Offset_0x041F5E
		moveq	#0,d0

Offset_0x041F84:
		rts
; End of function SetupChildObject_Simple

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to setup a child object, but not limited to object slots
; immediately after its parent
; ---------------------------------------------------------------------------
; Offset_0x041F86: Load_Child_Object_A2_2:
SetupChildObject_FindFree:
		moveq	#0,d2
		move.w	(a2)+,d6	; get number of objects in list

Offset_0x041F8A:
		jsr	(AllocateObject).l
		bne.s	Offset_0x041FD4
		move.w	a0,Obj_Child_Ref(a1)
		move.l	mappings(a0),mappings(a1)
		move.l	art_tile(a0),art_tile(a1)
		move.l	(a2)+,(a1)
		move.b	d2,Obj_Subtype(a1)
		move.w	x_pos(a0),d0
		move.b	(a2)+,d1
		move.b	d1,Obj_Control_Var_12(a1)
		ext.w	d1
		add.w	d1,d0
		move.w	d0,x_pos(a1)
		move.w	y_pos(a0),d0
		move.b	(a2)+,d1
		move.b	d1,Obj_Control_Var_13(a1)
		ext.w	d1
		add.w	d1,d0
		move.w	d0,y_pos(a1)
		addq.w	#2,d2
		dbf	d6,Offset_0x041F8A
		moveq	#0,d0

Offset_0x041FD4:
		rts
; End of function SetupChildObject_FindFree

; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to setup a child object similar to a linked list, but
; only with the parent address
; ---------------------------------------------------------------------------
; Offset_0x041FD6: Load_Child_Object_Tree_List_Repeated_A2:
SetupChildObject_TreeList:
		move.l	a0,a3
		moveq	#0,d2
		move.w	(a2)+,d6	; get number of objects in list

Offset_0x041FDC:
		jsr	(AllocateObjectAfterCurrent).l
		bne.s	Offset_0x042014
		move.w	a3,Obj_Child_Ref(a1)
		move.w	a0,Obj_Height_3(a1)
		move.l	a1,a3
		move.l	mappings(a0),mappings(a1)
		move.l	art_tile(a0),art_tile(a1)
		move.l	(a2),(a1)
		move.b	d2,Obj_Subtype(a1)
		move.w	x_pos(a0),x_pos(a1)
		move.w	y_pos(a0),y_pos(a1)
		addq.w	#2,d2
		dbf	d6,Offset_0x041FDC
		moveq	#0,d0

Offset_0x042014:
		rts
; End of function SetupChildObject_TreeList