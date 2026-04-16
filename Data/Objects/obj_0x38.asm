;===============================================================================
; Objeto 0x38 - Ventiladores na Hydrocity
; ->>>  
;===============================================================================
; Offset_0x026408:
                tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
                bne     Obj_0x38_CGz_Fan_2P                    ; Offset_0x026960
                move.l  A0, A1
                tst.b   subtype(A0)                                  ; $002C
                bpl.s   Offset_0x02648A
                jsr     (AllocateObjectAfterCurrent)                  ; Offset_0x011DE0
                bne     Offset_0x0264D4
                move.l  #Offset_0x02669C, (A0)
                move.w  x_pos(A0), x_pos(A1)                      ; $0010, $0010
                move.w  x_pos(A0), objoff_40(A0)         ; $0010, $0040
                move.w  y_pos(A0), y_pos(A1)                      ; $0014, $0014
                addi.w  #$001C, y_pos(A0)                                ; $0014
                move.l  #Water_Stream_Block_Mappings, mappings(A0) ; Offset_0x025C16, $000C
                move.w  #$43D4, art_tile(A0)                         ; $000A
                move.b  #$10, width_pixels(A0)                              ; $0007
                move.b  #$10, height_pixels(A0)                             ; $0006
                move.b  #$04, render_flags(A0)                              ; $0004
                move.w  #$0280, priority(A0)                         ; $0008
                move.w  A1, objoff_3C(A0)                       ; $003C
                move.b  subtype(A0), D0                              ; $002C
                andi.w  #$0030, D0
                add.w   D0, D0
                move.w  D0, objoff_3A(A0)                       ; $003A
                move.b  subtype(A0), subtype(A1)          ; $002C, $002C
                bclr    #$05, subtype(A1)                            ; $002C
                bset    #$04, subtype(A1)                            ; $002C
Offset_0x02648A:
                move.l  #Fan_Mappings, mappings(A1)      ; Offset_0x0267EE, $000C
                move.w  #$240B, art_tile(A1)                         ; $000A
                ori.b   #$04, render_flags(A1)                              ; $0004
                move.w  #$0200, priority(A1)                         ; $0008
                move.b  #$10, width_pixels(A1)                              ; $0007
                move.b  #$0C, height_pixels(A1)                             ; $0006
                move.w  x_pos(A1), objoff_40(A1)         ; $0010, $0040
                move.b  subtype(A1), D0                              ; $002C
                andi.w  #$000F, D0
                addq.w  #$08, D0
                lsl.w   #$04, D0
                move.w  D0, objoff_36(A1)                       ; $0036
                addi.w  #$0030, D0
                move.w  D0, objoff_38(A1)                       ; $0038
                move.l  #Offset_0x0264D6, (A1)
Offset_0x0264D4:
                rts       
;-------------------------------------------------------------------------------
Offset_0x0264D6:
                move.b  subtype(A0), D0                              ; $002C
                btst    #$05, D0
                beq.s   Offset_0x0264F4
                tst.b   (Level_Trigger_Array).w                      ; $FFFFF7E0
                beq     Offset_0x0265E2
                bclr    #$05, subtype(A0)                            ; $002C
                bset    #$04, subtype(A0)                            ; $002C
Offset_0x0264F4:
                tst.b   objoff_42(A0)                           ; $0042
                bne.s   Offset_0x02652A
                btst    #$04, subtype(A0)                            ; $002C
                bne.s   Offset_0x02654A
                subq.w  #$01, objoff_30(A0)                     ; $0030
                bpl.s   Offset_0x026522
                move.w  #$0000, objoff_34(A0)                   ; $0034
                move.w  #$0078, objoff_30(A0)                   ; $0030
                bchg    #00, objoff_32(A0)                      ; $0032
                beq.s   Offset_0x026522
                move.w  #$00B4, objoff_30(A0)                   ; $0030
Offset_0x026522:
                tst.b   objoff_32(A0)                           ; $0032
                beq     Offset_0x02654A
Offset_0x02652A:
                subq.b  #$01, anim_frame_duration(A0)                           ; $0024
                bpl     Offset_0x0265E2
                cmpi.w  #$0400, objoff_34(A0)                   ; $0034
                bcc     Offset_0x0265E2
                addi.w  #$002A, objoff_34(A0)                   ; $0034
                move.b  objoff_34(A0), anim_frame_duration(A0)  ; $0034, $0024
                bra.s   Offset_0x026568
Offset_0x02654A:
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                bsr     Offset_0x0265EC
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                bsr     Offset_0x0265EC
                subq.b  #$01, anim_frame_duration(A0)                           ; $0024
                bpl     Offset_0x02657A
                move.b  #$00, anim_frame_duration(A0)                           ; $0024
Offset_0x026568:
                addq.b  #$01, mapping_frame(A0)                             ; $0022
                cmpi.b  #$05, mapping_frame(A0)                             ; $0022
                bcs.s   Offset_0x02657A
                move.b  #$00, mapping_frame(A0)                             ; $0022
Offset_0x02657A:
                btst    #$06, subtype(A0)                            ; $002C
                beq.s   Offset_0x0265E2
                move.b  (Level_Frame_Count+$01).w, D0                ; $FFFFFE05
                andi.b  #$03, D0
                bne.s   Offset_0x0265E2
                jsr     (AllocateObject)                     ; Offset_0x011DD8
                bne.s   Offset_0x0265E2
                move.l  #Offset_0x026680, (A1)
                move.l  #Sonic_Underwater_Mappings, mappings(A1) ; Offset_0x025872, $000C
                move.w  #$045C, art_tile(A1)                         ; $000A
                move.b  #$84, render_flags(A1)                              ; $0004
                move.b  #$04, width_pixels(A1)                              ; $0007
                move.b  #$04, width_pixels(A1)                              ; $0007
                move.w  #$0300, priority(A1)                         ; $0008
                move.w  x_pos(A0), x_pos(A1)                      ; $0010, $0010
                jsr     (PseudoRandomNumber)                   ; Offset_0x001AFA
                andi.w  #$000F, D0
                subq.w  #$08, D0
                add.w   D0, x_pos(A1)                                    ; $0010
                move.w  y_pos(A0), y_pos(A1)                      ; $0014, $0014
                move.w  #$F800, y_vel(A1)                          ; $001A
Offset_0x0265E2:
                move.w  objoff_40(A0), D0                       ; $0040
                jmp     (MarkObjGone_2)                        ; Offset_0x011B1A
Offset_0x0265EC:
                cmpi.b  #$04, routine(A1)                            ; $0005
                bcc     Offset_0x026676
                tst.b   objoff_2E(A1)                                    ; $002E
                bne.s   Offset_0x026676
                move.w  x_pos(A1), D0                                    ; $0010
                sub.w   x_pos(A0), D0                                    ; $0010
                addi.w  #$0018, D0
                cmpi.w  #$0030, D0
                bcc.s   Offset_0x026676
                moveq   #$00, D1
                move.b  (Oscillate_Data_Buffer+$16).w, D1            ; $FFFFFE74
                add.w   y_pos(A1), D1                                    ; $0014
                add.w   objoff_36(A0), D1                       ; $0036
                sub.w   y_pos(A0), D1                                    ; $0014
                bcs.s   Offset_0x026676
                cmp.w   objoff_38(A0), D1                       ; $0038
                bcc.s   Offset_0x026676
                sub.w   objoff_36(A0), D1                       ; $0036
                bcs.s   Offset_0x026632
                not.w   D1
                add.w   D1, D1
Offset_0x026632:
                add.w   objoff_36(A0), D1                       ; $0036
                neg.w   D1
                asr.w   #$06, D1
                add.w   D1, y_pos(A1)                                    ; $0014
                bset    #$01, status(A1)                             ; $002A
                move.w  #$0000, y_vel(A1)                          ; $001A
                btst    #$06, subtype(A0)                            ; $002C
                bne.s   Offset_0x026678
                move.w  #$0001, inertia(A1)                          ; $001C
                tst.b   flip_angle(A1)                               ; $0027
                bne.s   Offset_0x026676
                move.b  #$01, flip_angle(A1)                         ; $0027
                move.b  #$00, anim(A1)                         ; $0020
                move.b  #$7F, objoff_30(A1)                     ; $0030
                move.b  #$08, objoff_31(A1)                     ; $0031
Offset_0x026676:
                rts
Offset_0x026678:
                move.b  #$0F, anim(A1)                         ; $0020
                rts     
;-------------------------------------------------------------------------------
Offset_0x026680:
                move.w  (Water_Level_Move).w, D0                     ; $FFFFF646
                cmp.w   y_pos(A0), D0                                    ; $0014
                bcc.s   Offset_0x026696
                jsr     (SpeedToPos)                           ; Offset_0x01111E
                jmp     (DisplaySprite)                        ; Offset_0x011148
Offset_0x026696:
                jmp     (DeleteObject)                         ; Offset_0x011138  
;-------------------------------------------------------------------------------
Offset_0x02669C:
                move.w  objoff_3C(A0), A1                       ; $003C
                move.w  (Obj_Player_One+y_pos).w, D0                 ; $FFFFB014
                sub.w   y_pos(A0), D0                                    ; $0014
                bcs.s   Offset_0x0266D2
                cmpi.w  #$0020, D0
                blt.s   Offset_0x0266F4
                tst.b   objoff_42(A1)                           ; $0042
                bne.s   Offset_0x0266C2
                move.b  #$01, objoff_42(A1)                     ; $0042
                move.w  #$0000, objoff_34(A1)                   ; $0034
Offset_0x0266C2:
                move.w  objoff_3A(A0), D1                       ; $003A
                cmp.w   objoff_30(A0), D1                       ; $0030
                beq.s   Offset_0x0266F4
                addq.w  #$08, objoff_30(A0)                     ; $0030
                bra.s   Offset_0x0266F4
Offset_0x0266D2:
                cmpi.w  #$FFD0, D0
                bge.s   Offset_0x0266F4
                tst.b   objoff_42(A1)                           ; $0042
                beq.s   Offset_0x0266EA
                move.b  #$00, objoff_42(A1)                     ; $0042
                move.b  #$00, anim_frame_duration(A1)                           ; $0024
Offset_0x0266EA:
                tst.w   objoff_30(A0)                           ; $0030
                beq.s   Offset_0x0266F4
                subq.w  #$08, objoff_30(A0)                     ; $0030
Offset_0x0266F4:
                move.w  objoff_30(A0), D0                       ; $0030
                btst    #$00, status(A0)                             ; $002A
                beq.s   Offset_0x026702
                neg.w   D0
Offset_0x026702:
                add.w   objoff_40(A0), D0                       ; $0040
                move.w  D0, x_pos(A0)                                    ; $0010
                move.w  D0, x_pos(A1)                                    ; $0010
                moveq   #$00, D1
                move.b  width_pixels(A0), D1                                ; $0007
                addi.w  #$000B, D1
                moveq   #$00, D2
                move.b  height_pixels(A0), D2                               ; $0006
                move.w  D2, D3
                addq.w  #$01, D3
                move.w  x_pos(A0), D4                                    ; $0010
                jsr     (Solid_Object)                         ; Offset_0x013556
                move.w  objoff_40(A0), D0                       ; $0040
                jmp     (MarkObjGone_2)                        ; Offset_0x011B1A                           
;===============================================================================
; Objeto 0x38 - Ventiladores na Hydrocity
; <<<-  
;===============================================================================  