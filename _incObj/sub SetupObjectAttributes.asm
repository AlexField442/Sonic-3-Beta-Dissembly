; ===========================================================================
; ---------------------------------------------------------------------------
; Subroutine to setup an object's graphics, size, and collision using
; a set of data, rather than individual instructions
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B R O U T I N E |||||||||||||||||||||||||||||||||||||||

; Offset_0x041D72: Object_Settings:
SetupObjectAttributes:
		move.l	(a1)+,mappings(a0)
; Offset_0x041D76: Object_Settings_2:
SetupObjectAttributes.UsrMap:
		move.w	(a1)+,art_tile(a0)
; Offset_0x041D7A: Object_Settings_3:
SetupObjectAttributes3:
		move.w	(a1)+,priority(a0)
		move.b	(a1)+,width_pixels(a0)
		move.b	(a1)+,height_pixels(a0)
		move.b	(a1)+,mapping_frame(a0)
		move.b	(a1)+,collision_flags(a0)
		bset	#2,render_flags(a0)
		addq.b	#2,routine(a0)
; Offset_0x041D98: Exit_Object_Settings:
SetupObjectAttributes_End:
		rts
; End of function SetupObjectAttributes