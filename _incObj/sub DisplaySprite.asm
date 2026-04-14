; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to display a sprite/object, when a0 is the object RAM
; ---------------------------------------------------------------------------
; Offset_0x011148:
DisplaySprite:
		lea	(Sprite_Table_Input).w,a1
		adda.w	priority(a0),a1
		cmpi.w	#$7E,(a1)
		bcc.s	Exit_DisplaySprite
		addq.w	#2,(a1)
		adda.w	(a1),a1
		move.w	a0,(a1)

Exit_DisplaySprite:
		rts
; End of function DisplaySprite