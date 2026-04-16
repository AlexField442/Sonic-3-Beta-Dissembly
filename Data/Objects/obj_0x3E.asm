;===============================================================================
; Objeto 0x3E - Atributo invísivel das esteiras na Hydrocity
; ->>>  
;===============================================================================
Offset_0x027184:
                dc.w    $0B28, $0CD8, $0BA8, $0CD8, $0BA8, $0CD8, $0EA8, $1058
                dc.w    $11A8, $12D8, $1928, $19D8, $21A8, $2358, $21A8, $2358
                dc.w    $22A8, $2458, $23A8, $2558, $2528, $26D8, $26A8, $27D8
                dc.w    $26A8, $2958, $2728, $28D8, $3328, $3458, $3328, $33D8    
;-------------------------------------------------------------------------------
Obj_0x3E_Conveyor_Belt_Attributes:                             ; Offset_0x0271C4
                lea     (Conveyor_Belt_Data_Array).w, A1             ; $FFFFCFE0
                moveq   #$00, D0
                move.b  subtype(A0), D0                              ; $002C
                tst.b   $00(A1, D0)
                beq.s   Offset_0x0271DA
                jmp     (DeleteObject)                         ; Offset_0x011138
Offset_0x0271DA:
                move.b  #$01, $00(A1, D0)
                andi.w  #$000F, D0
                lsl.w   #$02, D0
                lea     Offset_0x027184(PC, D0), A1
                move.w  (A1)+, D0
                move.w  D0, objoff_36(A0)                       ; $0036
                btst    #$00, status(A0)                             ; $002A
                bne.s   Offset_0x0271FA
                subq.w  #$08, D0
Offset_0x0271FA:
                move.w  D0, objoff_3A(A0)                       ; $003A
                move.w  (A1)+, D0
                move.w  D0, objoff_38(A0)                       ; $0038
                btst    #$00, status(A0)                             ; $002A
                beq.s   Offset_0x02720E
                addq.w  #$08, D0
Offset_0x02720E:
                move.w  D0, objoff_3C(A0)                       ; $003C
                move.l  #Offset_0x027218, (A0)
Offset_0x027218:                
                lea     objoff_32(A0), A2                       ; $0032
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                move.w  (Control_Ports_Logical_Data).w, D1           ; $FFFFF602
                moveq   #$00, D2
                bsr.s   Offset_0x02727A
                addq.w  #$01, A2
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                move.w  (Control_Ports_Logical_Data_2).w, D1         ; $FFFFF66A
                moveq   #$01, D2
                bsr.s   Offset_0x02727A
                move.w  (Camera_X_Left).w, D1                        ; $FFFFF7DA
                move.w  objoff_36(A0), D0                       ; $0036
                andi.w  #$FF80, D0
                subi.w  #$0280, D0
                cmp.w   D0, D1
                bcs.s   Offset_0x027258
                move.w  objoff_38(A0), D0                       ; $0038
                andi.w  #$FF80, D0
                cmp.w   D0, D1
                bhi.s   Offset_0x027258
                rts
Offset_0x027258:
                lea     (Conveyor_Belt_Data_Array).w, A1             ; $FFFFCFE0
                moveq   #$00, D0
                move.b  subtype(A0), D0                              ; $002C
                move.b  #$00, $00(A1, D0)
                move.w  respawn_index(A0), D0                           ; $0048
                beq.s   Offset_0x027274
                move.w  D0, A2
                bclr    #$07, (A2)
Offset_0x027274:
                jmp     (DeleteObject)                         ; Offset_0x011138
Offset_0x02727A:
                tst.b   (A2)
                beq.s   Offset_0x0272D8
                tst.w   (Debug_Mode_Flag_Index).w                    ; $FFFFFE08
                bne.s   Offset_0x0272C2
                btst    #$0A, D1
                beq.s   Offset_0x02728E
                subq.w  #$01, x_pos(A1)                                  ; $0010
Offset_0x02728E:
                btst    #$0B, D1
                beq.s   Offset_0x027298
                addq.w  #$01, x_pos(A1)                                  ; $0010
Offset_0x027298:
                andi.w  #$0070, D1
                bne     Offset_0x0272C2
                moveq   #$02, D0
                btst    #$00, status(A0)                             ; $002A
                beq.s   Offset_0x0272AC
                neg.w   D0
Offset_0x0272AC:
                add.w   D0, x_pos(A1)                                    ; $0010
                move.w  x_pos(A1), D0                                    ; $0010
                cmp.w   objoff_3A(A0), D0                       ; $003A
                bcs.s   Offset_0x0272C8
                cmp.w   objoff_3C(A0), D0                       ; $003C
                bcc.s   Offset_0x0272C8
                rts
Offset_0x0272C2:
                move.w  #$FB00, y_vel(A1)                          ; $001A
Offset_0x0272C8:
                clr.b   (A2)
                move.b  #$3C, $0002(A2)
                andi.b  #$FE, objoff_2E(A1)                              ; $002E
                rts
Offset_0x0272D8:
                tst.b   $0002(A2)
                beq.s   Offset_0x0272E4
                subq.b  #$01, $0002(A2)
                rts
Offset_0x0272E4:
                move.w  x_pos(A1), D0                                    ; $0010
                cmp.w   objoff_3A(A0), D0                       ; $003A
                bcs.s   Offset_0x027344
                cmp.w   objoff_3C(A0), D0                       ; $003C
                bcc.s   Offset_0x027344
                move.w  y_pos(A0), D0                                    ; $0014
                addi.w  #$0014, D0
                cmp.w   y_pos(A1), D0                                    ; $0014
                bcc.s   Offset_0x027344
                addi.w  #$0010, D0
                cmp.w   y_pos(A1), D0                                    ; $0014
                bcs.s   Offset_0x027344
                cmpi.b  #$04, routine(A1)                            ; $0005
                bcc.s   Offset_0x027344
                tst.b   objoff_2E(A1)                                    ; $002E
                bne.s   Offset_0x027344
                tst.w   y_vel(A1)                                  ; $001A
                bmi.s   Offset_0x027344
                clr.w   x_vel(A1)                                  ; $0018
                clr.w   y_vel(A1)                                  ; $001A
                move.w  y_pos(A0), D0                                    ; $0014
                addi.w  #$0014, D0
                move.w  D0, y_pos(A1)                                    ; $0014
                move.b  #$14, anim(A1)                         ; $0020
                move.b  #$01, objoff_2E(A1)                              ; $002E
                move.b  #$01, (A2)
Offset_0x027344:
                rts                                                                                   
;===============================================================================
; Objeto 0x3E - Atributo invísivel das esteiras na Hydrocity
; <<<-  
;===============================================================================  