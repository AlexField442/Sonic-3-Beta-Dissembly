; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to delete an object
; ---------------------------------------------------------------------------
; Offset_0x011138:
DeleteObject:
		move.l	a0,a1
; Offset_0x01113A: Delete_A1_Object:
DeleteObject2:
		moveq	#(Obj_Size/4)-1,d0

		moveq	#0,d1					; we want to clear up to the next object
								; delete the object by setting all of its bytes to 0
; Offset_0x01113E:
DeleteObject_FreeRam:
		move.l	d1,(a1)+
		dbf	d0,DeleteObject_FreeRam
		move.w	d1,(a1)+
		rts
; End of function DeleteObject