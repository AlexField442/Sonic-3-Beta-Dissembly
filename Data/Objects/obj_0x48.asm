;===============================================================================
; Objeto 0x48 - Tubos de propulsão na Carnival Night
; ->>>           
;===============================================================================
; Offset_0x028278:
                move.b  subtype(A0), D0                              ; $002C
                beq.s   Offset_0x02828E
                add.b   D0, D0
                move.b  D0, objoff_34(A0)                       ; $0034
                move.l  #Offset_0x02833C, (A0)
                bra     Offset_0x02833C
Offset_0x02828E:
                move.l  #Offset_0x028294, (A0)
Offset_0x028294:                
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                bsr     Offset_0x0282AA
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                bsr     Offset_0x0282AA
                jmp     (MarkObjGone_3)                        ; Offset_0x011B3E
Offset_0x0282AA:
                move.w  x_pos(A1), D0                                    ; $0010
                sub.w   x_pos(A0), D0                                    ; $0010
                btst    #$00, status(A0)                             ; $002A
                bne.s   Offset_0x0282BC
                neg.w   D0
Offset_0x0282BC:
                addi.w  #$0050, D0
                cmpi.w  #$00A0, D0
                bcc.s   Offset_0x02833A
                move.w  y_pos(A1), D1                                    ; $0014
                addi.w  #$0020, D1
                sub.w   y_pos(A0), D1                                    ; $0014
                bcs.s   Offset_0x02833A
                cmpi.w  #$0040, D1
                bcc.s   Offset_0x02833A
                cmpi.b  #$04, routine(A1)                            ; $0005
                bcc.s   Offset_0x02833A
                tst.b   objoff_2E(A1)                                    ; $002E
                bne.s   Offset_0x02833A
                subi.w  #$0050, D0
                bcc.s   Offset_0x02830A
                not.w   D0
                move.w  #$1000, inertia(A1)                          ; $001C
                btst    #$00, status(A0)                             ; $002A
                bne.s   Offset_0x028302
                neg.w   inertia(A1)                                  ; $001C
Offset_0x028302:
                move.w  inertia(A1), x_vel(A1)          ; $001C, $0018
                rts
Offset_0x02830A:
                add.w   D0, D0
                addi.w  #$0060, D0
                btst    #$00, status(A0)                             ; $002A
                bne.s   Offset_0x02831A
                neg.w   D0
Offset_0x02831A:
                neg.b   D0
                asr.w   #$04, D0
                add.w   D0, x_pos(A1)                                    ; $0010
                move.w  objoff_36(A0), D0                       ; $0036
                bne.s   Offset_0x028330
                moveq   #Tunnel_Booster_Sfx, D0                           ; -$7E
                jsr     (Play_Music)                           ; Offset_0x001176
Offset_0x028330:
                addq.w  #$01, objoff_36(A0)                     ; $0036
                andi.w  #$001F, objoff_36(A0)                   ; $0036
Offset_0x02833A:
                rts
Offset_0x02833C:
                lea     objoff_30(A0), A2                       ; $0030
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                bsr     Offset_0x028358
                addq.w  #$01, A2
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                bsr     Offset_0x028358
                jmp     (MarkObjGone_3)                        ; Offset_0x011B3E
Offset_0x028358:
                move.b  (A2), D0
                bne     Offset_0x0283DA
                move.w  x_pos(A1), D0                                    ; $0010
                sub.w   x_pos(A0), D0                                    ; $0010
                addi.w  #$0018, D0
                cmpi.w  #$0030, D0
                bcc.s   Offset_0x0283D8
                move.w  y_pos(A1), D1                                    ; $0014
                sub.w   y_pos(A0), D1                                    ; $0014
                addi.w  #$0030, D1
                cmpi.w  #$0050, D1
                bcc.s   Offset_0x0283D8
                cmpi.b  #$04, routine(A1)                            ; $0005
                bcc.s   Offset_0x0283D8
                tst.b   objoff_2E(A1)                                    ; $002E
                bne.s   Offset_0x0283D8
                subi.w  #$0050, D1
                neg.w   D1
                cmpi.w  #$0040, D1
                bcs.s   Offset_0x0283B2
                move.b  #$01, (A2)
                move.b  objoff_34(A0), $0002(A2)                ; $0034
                move.w  D0, -(A7)
                moveq   #Transporter_Sfx, D0                              ; -$7F
                jsr     (Play_Music)                           ; Offset_0x001176
                move.w  (A7)+, D0
Offset_0x0283B2:
                asr.w   #$03, D1
                sub.w   D1, y_pos(A1)                                    ; $0014
                moveq   #$01, D2
                cmpi.w  #$0018, D0
                beq.s   Offset_0x0283C8
                bcs.s   Offset_0x0283C4
                neg.w   D2
Offset_0x0283C4:
                add.w   D2, x_pos(A1)                                    ; $0010
Offset_0x0283C8:
                bset    #$01, status(A1)                             ; $002A
                move.b  #$0F, anim(A1)                         ; $0020
                clr.b   objoff_40(A1)                           ; $0040
Offset_0x0283D8:
                rts
Offset_0x0283DA:
                subq.b  #$01, D0
                bne.s   Offset_0x02841E
                subq.b  #$01, $0002(A2)
                beq.s   Offset_0x028412
                subi.w  #$0008, y_pos(A1)                                ; $0014
                moveq   #$01, D2
                move.w  x_pos(A1), D0                                    ; $0010
                sub.w   x_pos(A0), D0                                    ; $0010
                beq.s   Offset_0x0283FE
                bcs.s   Offset_0x0283FA
                neg.w   D2
Offset_0x0283FA:
                add.w   D2, x_pos(A1)                                    ; $0010
Offset_0x0283FE:
                move.w  #$0000, x_vel(A1)                          ; $0018
                move.w  #$0000, inertia(A1)                          ; $001C
                move.w  #$0000, y_vel(A1)                          ; $001A
                rts
Offset_0x028412:
                move.w  #$F800, y_vel(A1)                          ; $001A
                move.b  #$00, (A2)
                rts
Offset_0x02841E:
                rts                                                                                       
;===============================================================================
; Objeto 0x48 - Tubos de propulsão na Carnival Night
; <<<-  
;===============================================================================  