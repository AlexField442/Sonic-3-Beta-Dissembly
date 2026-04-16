;===============================================================================
; Objeto 0xDC - Anéis usados como prêmio nos caça níqueis na Casino Night
; ->>>
;===============================================================================     
; Offset_0x010FC2:
                moveq   #$00, D0
                move.b  routine(A0), D0                              ; $0005
                move.w  Offset_0x010FD0(PC, D0), D1
                jmp     Offset_0x010FD0(PC, D1)     
;-------------------------------------------------------------------------------
Offset_0x010FD0:
                dc.w    Offset_0x010FD6-Offset_0x010FD0
                dc.w    Offset_0x01102A-Offset_0x010FD0
                dc.w    Offset_0x011036-Offset_0x010FD0  
;-------------------------------------------------------------------------------
Offset_0x010FD6:
                moveq   #$00, D1
                move.w  objoff_3C(A0), D1                       ; $003C
                swap.w  D1
                move.l  objoff_34(A0), D0                       ; $0034
                sub.l   D1, D0
                asr.l   #$04, D0
                sub.l   D0, objoff_34(A0)                       ; $0034
                move.w  objoff_34(A0), x_pos(A0)         ; $0034, $0010
                moveq   #$00, D1
                move.w  objoff_3E(A0), D1                       ; $003E
                swap.w  D1
                move.l  objoff_38(A0), D0                       ; $0038
                sub.l   D1, D0
                asr.l   #$04, D0
                sub.l   D0, objoff_38(A0)                       ; $0038
                move.w  objoff_38(A0), y_pos(A0)         ; $0038, $0014
                lea     Slot_Machine_Rings_Animate_Data(PC), A1 ; Offset_0x01103A
                bsr     AnimateSprite                          ; Offset_0x01115E
                subq.w  #$01, objoff_40(A0)                     ; $0040
                bne     DisplaySprite                          ; Offset_0x011148
                move.l  objoff_2E(A0), A1                                ; $002E
                subq.w  #$01, (A1)
                bsr     CollectRing            ; Offset_0x010A20
                addi.b  #$02, routine(A0)                            ; $0005
;-------------------------------------------------------------------------------                
Offset_0x01102A:
                lea     Rings_Animate_Data(PC), A1             ; Offset_0x010DDA
                bsr     AnimateSprite                          ; Offset_0x01115E
                bra     DisplaySprite                          ; Offset_0x011148
Offset_0x011036:
                bra     DeleteObject                           ; Offset_0x011138
;-------------------------------------------------------------------------------
Slot_Machine_Rings_Animate_Data:                               ; Offset_0x01103A
                dc.w    Offset_0x01103C-Slot_Machine_Rings_Animate_Data
Offset_0x01103C:
                dc.b    $01, $00, $01, $02, $03, $FF                
;===============================================================================
; Objeto 0xDC - Anéis usados como prêmio nos caça níqueis na Casino Night
; <<<-
;===============================================================================