; tells the Z80 to stop, and waits for it to finish stopping (acquire bus)
stopZ80 macro
	move.w	#$100,(Z80_Bus_Request).l	; stop the Z80
@loop:	btst	#0,(Z80_Bus_Request).l
	bne.s	@loop				; loop until it says it has stopped
    endm

; tells the Z80 to start again
startZ80 macro
	move.w	#0,(Z80_Bus_Request).l    ; start the Z80
    endm

; macro to declare a little-endian 16-bit pointer for the Z80 sound driver
rom_ptr_z80 macro addr
	dc.w	(((addr>>8)|(addr<<8))&$FFFF)
    endm

; we don't have bytesToLcnt or bytesToWcnt yet, so here's examples of when they are used
; bytesToLcnt
; #(XX>>2-YY>>2)-1
; bytesToWcnt
; #(XX>>1-YY>>1)-1

; fills a region of 68k RAM with 0
clearRAM macro startaddr,endaddr
		if startaddr>endaddr
			inform 3,"Starting address of clearRAM $%h is after ending address $%h.",startaddr,endaddr
		elseif startaddr=endaddr
			inform 1,"clearRAM is clearing zero bytes. Turning this into a nop instead."
		mexit
  		endc

		if ((startaddr)&$8000)=0
			lea	(\startaddr).l,a1		; if start address is greater than $FFFF8000
   		else
			lea	(\startaddr).w,a1		; if start address is less than $FFFF8000
	   	endc
			moveq	#0,d0
    	if (\startaddr&1)
			move.b	d0,(a1)+			; clear the first byte if start address is odd
	    endc
		move.w	#((\endaddr-\startaddr)-(\startaddr&1))/4-1,d1

	.loop\@:
		move.l	d0,(a1)+
		dbf	d1,.loop\@
	    if (((endaddr-startaddr)-((startaddr)&1))&2)
			move.w	d0,(a1)+			; if amount to clear is not divisible by longword, clear the last whole word
    	endc
    	if (((endaddr-startaddr)-((startaddr)&1))&1)
			move.b	d0,(a1)+			; if amount to clear is not divisible by word, clear the last byte
    	endc
    	endm

; macro to declare an offset table
offsetTable macro *
\* EQU *
current_offset_table = \*
    endm

; macro to declare an entry in an offset table
offsetTableEntry macro ptr
	dc.\0 ptr-current_offset_table
    endm

; macro to create an entry for object data
objdata macro pri,width,height,frame,collision,VRAM,mapping
  if (narg=7)
	dc.l	mapping
	dc.w	VRAM, pri
	dc.b	width, height, frame, collision
  elseif (narg=6)
	dc.w	VRAM, pri
	dc.b	width, height, frame, collision
  elseif (narg=5)
	dc.w	pri
	dc.b	width, height, frame, collision
  endif
	endm