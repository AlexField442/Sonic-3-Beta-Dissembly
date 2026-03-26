.int:		dc.w	.frame1-.int
		dc.w	.frame2-.int
		dc.w	.frame3-.int
		dc.w	.frame4-.int
		dc.w	.frame5-.int
		dc.w	.frame6-.int
		dc.w	.frame7-.int
		dc.w	.frame8-.int
		dc.w	.frame9-.int
		dc.w	.blank-.int
; Offset_0x010648:
.frame1:	dc.w	4
		dc.w	$E809, $0000, -$18
		dc.w	$E809, $0006, 0
		dc.w	$0809, $000C, -$18
		dc.w	$0809, $0012, 0
; Offset_0x010662:
.frame2:	dc.w	4
		dc.w	$E80A, $0000, -$18
		dc.w	$E80A, $0009, 0
		dc.w	$000A, $0012, -$18
		dc.w	$000A, $001B, 0
; Offset_0x01067C:
.frame3:	dc.w	4
		dc.w	$E80A, $0000, -$18
		dc.w	$E80A, $0009, 0
		dc.w	$000A, $0012, -$18
		dc.w	$000A, $001B, 0
; Offset_0x010696:
.frame4:	dc.w	4
		dc.w	$EC0A, $0000, -$18
		dc.w	$EC0A, $0009, 0
		dc.w	$0409, $0012, -$18
		dc.w	$0409, $0018, 0
; Offset_0x0106B0:
.frame5:	dc.w	2
		dc.w	$F00F, $0000, -$18
		dc.w	$F007, $0010, $0008
; Offset_0x0106BE:
.frame6:	dc.w	4
		dc.w	$FC0A, $1000, -$18
		dc.w	$FC0A, $1009, 0
		dc.w	$EC09, $1012, -$18
		dc.w	$EC09, $1018, 0
; Offset_0x0106D8:
.frame7:	dc.w	4
		dc.w	$000A, $1000, -$18
		dc.w	$000A, $1009, 0
		dc.w	$E80A, $1012, -$18
		dc.w	$E80A, $101B, 0
; Offset_0x0106F2:
.frame8:	dc.w	4
		dc.w	$000A, $1000, -$18
		dc.w	$000A, $1009, 0
		dc.w	$E80A, $1012, -$18
		dc.w	$E80A, $101B, 0
; Offset_0x01070C:
.frame9:	dc.w	4
		dc.w	$0809, $1000, -$18
		dc.w	$0809, $1006, 0
		dc.w	$E809, $100C, -$18
		dc.w	$E809, $1012, 0
; Offset_0x010726:
.blank:		dc.w	0