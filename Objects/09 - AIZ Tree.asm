; ===========================================================================
; ---------------------------------------------------------------------------
; Object 09 - Tree in Angel Island (used in first cutscene to mask the
; Fire Breaths in the background)
; ---------------------------------------------------------------------------
; Offset_0x013F24: Obj_0x09_AIz_Tree:
Obj09_AIZTree:
		move.l	#AIZTree_Mappings,mappings(a0)
		move.w	#$180,priority(a0)
		move.b	#8,width_pixels(a0)
		move.b	#4,render_flags(a0)
		move.w	#$4001,Obj_Art_VRAM(a0)
		move.l	#AIZTree_ChkDel,(a0)
; Offset_0x013F4A:
AIZTree_ChkDel:
		jmp	(MarkObjGone).l

; ===========================================================================
; ---------------------------------------------------------------------------
; Sprite Mappings - Tree in Angel Island
; ---------------------------------------------------------------------------
; Offset_0x013F50: AIz_Tree_Mappings:
AIZTree_Mappings:	include	"data/mappings/09 - AIZ Tree.asm"