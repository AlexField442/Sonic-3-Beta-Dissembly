.int:		dc.w	.frame1-.int
		dc.w	.frame2-.int
		dc.w	.frame3-.int
		dc.w	.frame4-.int
		dc.w	.frame5-.int
		dc.w	.frame4-.int
		dc.w	.frame3-.int
		dc.w	.frame2-.int
		dc.w	.frame1-.int
		dc.w	.blank-.int
; Offset_0x01073C:
.frame1:	dc.w	4
		dc.w	$5000, $5006, $500C, $5012
; Offset_0x010746:
.frame2:	dc.w	4
		dc.w	$8018, $8021, $802A, $8033
; Offset_0x010750:
.frame3:	dc.w	4
		dc.w	$803C, $8045, $804E, $8057
; Offset_0x01075A:
.frame4:	dc.w	4
		dc.w	$8060, $8069, $5072, $5078
; Offset_0x010764:
.frame5:	dc.w	2
		dc.w	$F07E, $708E
; Offset_0x01076A:
.blank:		dc.	0