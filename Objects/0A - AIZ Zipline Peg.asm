; ===========================================================================
; ---------------------------------------------------------------------------
; Object 0A - Zipling Pegs in Angel Island
; ---------------------------------------------------------------------------
; Offset_0x013F66: Obj_0x0A_AIz_Zipline_Peg:
Obj0A_ZiplinePeg:
		move.l	#ZiplinePeg_Mappings,mappings(a0)
		move.w	#$380,priority(a0)
		move.b	#$20,width_pixels(a0)
		move.b	#4,render_flags(a0)
		move.w	#$4324,Obj_Art_VRAM(a0)
		move.l	#ZiplinePeg_ChkDel,(a0)
; Offset_0x013F8C:
ZiplinePeg_ChkDel:
		jmp	(MarkObjGone).l

; ===========================================================================
; ---------------------------------------------------------------------------
; Sprite Mappings - Zipling Pegs in Angel Island
; ---------------------------------------------------------------------------
; Offset_0x013F92 AIz_Zipline_Peg_Mappings:
ZiplinePeg_Mappings:	include	"data/mappings/0A - AIZ Zipline Peg.asm"