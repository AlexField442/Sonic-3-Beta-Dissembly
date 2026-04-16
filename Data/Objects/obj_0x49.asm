;===============================================================================
; Objeto 0x49 - Roda na Carnival Night
; ->>>           
;===============================================================================
; Offset_0x028C62:
                move.b  #$60, objoff_32(A0)                     ; $0032
                move.l  #Offset_0x028C6E, (A0)
Offset_0x028C6E:                
                lea     objoff_36(A0), A2                       ; $0036
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                bsr.s   Offset_0x028C86
                addq.w  #$01, A2
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                bsr.s   Offset_0x028C86
                jmp     (MarkObjGone_3)                        ; Offset_0x011B3E
Offset_0x028C86:
                moveq   #$00, D2
                move.b  objoff_32(A0), D2                       ; $0032
                move.w  D2, D3
                add.w   D3, D3
                move.w  x_pos(A1), D0                                    ; $0010
                sub.w   x_pos(A0), D0                                    ; $0010
                add.w   D2, D0
                cmp.w   D3, D0
                bcc.s   Offset_0x028CB8
                move.w  y_pos(A1), D1                                    ; $0014
                sub.w   y_pos(A0), D1                                    ; $0014
                add.w   D2, D1
                cmp.w   D3, D1
                bcc.s   Offset_0x028CB8
                btst    #$01, status(A1)                             ; $002A
                beq.s   Offset_0x028CC4
                clr.b   (A2)
                rts
Offset_0x028CB8:
                tst.b   (A2)
                beq.s   Offset_0x028CC2
                clr.b   objoff_3C(A1)                           ; $003C
                clr.b   (A2)
Offset_0x028CC2:
                rts
Offset_0x028CC4:
                tst.b   (A2)
                bne.s   Offset_0x028CEA
                move.b  #$01, (A2)
                btst    #$02, status(A1)                             ; $002A
                bne.s   Offset_0x028CD8
                clr.b   anim(A1)                               ; $0020
Offset_0x028CD8:
                bclr    #$05, status(A1)                             ; $002A
                move.b  #$01, prev_anim(A1)                           ; $0021
                move.b  #$01, objoff_3C(A1)                     ; $003C
Offset_0x028CEA:
                move.w  inertia(A1), D0                              ; $001C
                btst    #$00, status(A0)                             ; $002A
                beq.s   Offset_0x028D12
                cmpi.w  #$FC00, D0
                ble.s   Offset_0x028D04
                move.w  #$FC00, inertia(A1)                          ; $001C
                rts
Offset_0x028D04:
                cmpi.w  #$F100, D0
                bge.s   Offset_0x028D10
                move.w  #$F100, inertia(A1)                          ; $001C
Offset_0x028D10:
                rts
Offset_0x028D12:
                cmpi.w  #$0400, D0
                bge.s   Offset_0x028D20
                move.w  #$0400, inertia(A1)                          ; $001C
                rts
Offset_0x028D20:
                cmpi.w  #$0F00, D0
                ble.s   Offset_0x028D2C
                move.w  #$0F00, inertia(A1)                          ; $001C
Offset_0x028D2C:
                rts                        
;===============================================================================
; Objeto 0x49 - Roda na Carnival Night
; <<<-  
;===============================================================================  