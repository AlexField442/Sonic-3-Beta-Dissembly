;-------------------------------------------------------------------------------
; Splash de água causado pelo jogador entrando e saindo da água
; ->>>
;------------------------------------------------------------------------------- 
; Offset_0x02E22E:
                tst.b   subtype(A0)                                  ; $002C
                beq.s   Offset_0x02E298
                move.l  #Water_Splash_Mappings_2, mappings(A0) ; Offset_0x02E4EA, $000C
                move.w  #$0447, art_tile(A0)                         ; $000A
                ori.b   #$04, render_flags(A0)                              ; $0004
                move.w  #$0300, priority(A0)                         ; $0008
                move.b  #$A0, width_pixels(A0)                              ; $0007
                move.b  #$80, height_pixels(A0)                             ; $0006
                move.b  #$FF, Obj_Control_Var_01(A0)                     ; $0031
                move.b  #$00, status(A0)                             ; $002A
                bset    #$06, render_flags(A0)                              ; $0004
                move.w  #$0002, y_sub(A0)                            ; $0016
                lea     x_vel(A0), A2                              ; $0018
                move.w  x_pos(A0), (A2)+                                 ; $0010
                move.w  y_pos(A0), (A2)+                                 ; $0014
                move.w  #$0005, (A2)+
                move.w  x_pos(A0), (A2)+                                 ; $0010
                move.w  y_pos(A0), (A2)+                                 ; $0014
                move.w  #$0505, (A2)+
                move.l  #Offset_0x02E318, (A0)
                bra     Offset_0x02E318
Offset_0x02E298:
                move.l  #Water_Splash_Mappings, mappings(A0) ; Offset_0x02E4D0, $000C
                move.w  #$43B2, art_tile(A0)                         ; $000A
                ori.b   #$04, render_flags(A0)                              ; $0004
                move.w  #$0300, priority(A0)                         ; $0008
                move.b  #$28, width_pixels(A0)                              ; $0007
                move.b  #$20, height_pixels(A0)                             ; $0006
                move.b  #$FF, Obj_Control_Var_00(A0)                     ; $0030
                move.l  #Offset_0x02E2CA, (A0)
Offset_0x02E2CA:                
                subq.b  #$01, anim_frame_duration(A0)                           ; $0024
                bpl.s   Offset_0x02E2E0
                move.b  #$07, anim_frame_duration(A0)                           ; $0024
                addq.b  #$01, mapping_frame(A0)                             ; $0022
                andi.b  #$03, mapping_frame(A0)                             ; $0022
Offset_0x02E2E0:
                tst.b   render_flags(A0)                                    ; $0004
                bpl.s   Offset_0x02E312
                moveq   #$00, D1
                move.b  mapping_frame(A0), D1                               ; $0022
                cmp.b   Obj_Control_Var_00(A0), D1                       ; $0030
                beq.s   Offset_0x02E312
                move.b  D1, Obj_Control_Var_00(A0)                       ; $0030
                lsl.w   #$08, D1
                move.w  D1, D0
                add.w   D0, D0
                add.w   D0, D1
                addi.l  #Art_Water_Splash_2, D1                ; Offset_0x131C02
                move.w  #$7640, D2
                move.w  #$0180, D3
                jsr     (QueueDMATransfer)                        ; Offset_0x0012FC
Offset_0x02E312:
                jmp     (MarkObjGone)                          ; Offset_0x011AF2
Offset_0x02E318:
                move.w  (Obj_Player_One+x_pos).w, x_pos(A0)   ; $FFFFB010, $0010
                move.w  (Water_Level_Move).w, y_pos(A0)       ; $FFFFF646, $0014
                bsr.s   Offset_0x02E37C
                tst.b   status(A0)                                   ; $002A
                beq.s   Offset_0x02E34A
                subq.b  #$01, anim_frame_duration(A0)                           ; $0024
                bpl.s   Offset_0x02E34A
                move.b  #$02, anim_frame_duration(A0)                           ; $0024
                addq.b  #$01, Obj_Control_Var_00(A0)                     ; $0030
                cmpi.b  #$05, Obj_Control_Var_00(A0)                     ; $0030
                bcs.s   Offset_0x02E34A
                move.b  #$00, Obj_Control_Var_00(A0)                     ; $0030
Offset_0x02E34A:
                moveq   #$00, D1
                move.b  Obj_Control_Var_00(A0), D1                       ; $0030
                cmp.b   Obj_Control_Var_01(A0), D1                       ; $0031
                beq.s   Offset_0x02E376
                move.b  D1, Obj_Control_Var_01(A0)                       ; $0031
                lsl.w   #$07, D1
                move.w  D1, D0
                add.w   D0, D0
                add.w   D0, D1
                addi.l  #Art_Water_Splash, D1                  ; Offset_0x131482
                move.w  #$88E0, D2
                move.w  #$00C0, D3
                jsr     (QueueDMATransfer)                        ; Offset_0x0012FC
Offset_0x02E376:
                jmp     (MarkObjGone)                          ; Offset_0x011AF2
Offset_0x02E37C:
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                lea     x_vel(A0), A2                              ; $0018
                moveq   #$03, D6
                move.w  (Control_Ports_Logical_Data).w, D5           ; $FFFFF602
                bsr.s   Offset_0x02E3C6
                bclr    #$00, render_flags(A0)                              ; $0004
                btst    #$00, status(A1)                             ; $002A
                beq.s   Offset_0x02E3A0
                bset    #$00, render_flags(A0)                              ; $0004
Offset_0x02E3A0:
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                lea     y_radius(A0), A2                             ; $001E
                moveq   #$04, D6
                move.w  (Control_Ports_Logical_Data_2).w, D5         ; $FFFFF66A
                bsr.s   Offset_0x02E3C6
                move.b  render_flags(A0), D0                                ; $0004
                add.b   status(A1), D0                               ; $002A
                andi.b  #$01, D0
                beq.s   Offset_0x02E3C4
                move.b  #$05, routine(A2)                            ; $0005
Offset_0x02E3C4:
                rts
Offset_0x02E3C6:
                btst    D6, status(A0)                               ; $002A
                bne.s   Offset_0x02E41A
                tst.w   y_vel(A1)                                  ; $001A
                bne.s   Offset_0x02E418
                moveq   #$00, D1
                move.b  y_radius(A1), D1                             ; $001E
                add.w   y_pos(A1), D1                                    ; $0014
                addq.w  #$01, D1
                cmp.w   (Water_Level_Move).w, D1                     ; $FFFFF646
                bne.s   Offset_0x02E418
                move.w  x_vel(A1), D0                              ; $0018
                bpl.s   Offset_0x02E3EC
                neg.w   D0
Offset_0x02E3EC:
                cmpi.w  #$0700, D0
                bcs.s   Offset_0x02E418
                bset    D6, status(A0)                               ; $002A
                move.w  x_pos(A1), (A2)                                  ; $0010
                move.w  (Water_Level_Move).w, $0002(A2)              ; $FFFFF646
                move.b  #$00, routine(A2)                            ; $0005
                bclr    #$00, status(A1)                             ; $002A
                tst.w   x_vel(A1)                                  ; $0018
                bpl.s   Offset_0x02E418
                bset    #$00, status(A1)                             ; $002A
Offset_0x02E418:
                rts
Offset_0x02E41A:
                move.w  D5, D0
                andi.w  #$0070, D0
                bne.s   Offset_0x02E49A
                move.w  (Water_Level_Move).w, D0                     ; $FFFFF646
                moveq   #$00, D1
                move.b  y_radius(A1), D1                             ; $001E
                sub.w   D1, D0
                subq.w  #$01, D0
                cmp.w   y_pos(A1), D0                                    ; $0014
                bhi.s   Offset_0x02E48E
                move.w  x_vel(A1), D1                              ; $0018
                bpl.s   Offset_0x02E43E
                neg.w   D1
Offset_0x02E43E:
                cmpi.w  #$0700, D1
                bcs.s   Offset_0x02E48E
                move.w  D0, y_pos(A1)                                    ; $0014
                move.w  #$0000, y_vel(A1)                          ; $001A
                move.w  x_pos(A1), (A2)                                  ; $0010
                move.w  (Water_Level_Move).w, $0002(A2)              ; $FFFFF646
                btst    #$01, status(A1)                             ; $002A
                beq.s   Offset_0x02E498
                andi.w  #$0C00, D5
                bne.s   Offset_0x02E498
                move.w  #$000C, D1
                move.w  x_vel(A1), D0                              ; $0018
                beq.s   Offset_0x02E48E
                bmi.s   Offset_0x02E480
                sub.w   D1, D0
                bcc.s   Offset_0x02E47A
                move.w  #$0000, D0
Offset_0x02E47A:
                move.w  D0, x_vel(A1)                              ; $0018
                bra.s   Offset_0x02E498
Offset_0x02E480:
                add.w   D1, D0
                bcc.s   Offset_0x02E488
                move.w  #$0000, D0
Offset_0x02E488:
                move.w  D0, x_vel(A1)                              ; $0018
                bra.s   Offset_0x02E498
Offset_0x02E48E:
                bclr    D6, status(A0)                               ; $002A
                move.b  #$05, routine(A2)                            ; $0005
Offset_0x02E498:
                rts
Offset_0x02E49A:
                bclr    D6, status(A0)                               ; $002A
                move.b  #$05, routine(A2)                            ; $0005
                move.w  #$F980, y_vel(A1)                          ; $001A
                bset    #$01, status(A1)                             ; $002A
                move.b  #$01, Obj_Control_Var_10(A1)                     ; $0040
                move.b  #$0E, y_radius(A1)                           ; $001E
                move.b  #$07, x_radius(A1)                            ; $001F
                move.b  #$02, anim(A1)                         ; $0020
                bset    #$02, status(A1)                             ; $002A
                rts
;-------------------------------------------------------------------------------
Water_Splash_Mappings:                                         ; Offset_0x02E4D0
                dc.w    Offset_0x02E4DA-Water_Splash_Mappings
                dc.w    Offset_0x02E4DA-Water_Splash_Mappings
                dc.w    Offset_0x02E4DA-Water_Splash_Mappings
                dc.w    Offset_0x02E4DA-Water_Splash_Mappings
                dc.w    Offset_0x02E4F6-Water_Splash_Mappings
Offset_0x02E4DA:
                dc.w    $0002
                dc.w    $F00B, $0000, $FFE8
                dc.w    $F00B, $000C, $0000
Offset_0x02E4E8:
                dc.w    $0000                   
Water_Splash_Mappings_2:                                       ; Offset_0x02E4EA
                dc.w    Offset_0x02E4F6-Water_Splash_Mappings_2
                dc.w    Offset_0x02E4F6-Water_Splash_Mappings_2
                dc.w    Offset_0x02E4F6-Water_Splash_Mappings_2
                dc.w    Offset_0x02E4F6-Water_Splash_Mappings_2
                dc.w    Offset_0x02E4F6-Water_Splash_Mappings_2
                dc.w    Offset_0x02E4E8-Water_Splash_Mappings_2                 
Offset_0x02E4F6:
                dc.w    $0002
                dc.w    $F00D, $0000, $FFC8
                dc.w    $F005, $0008, $FFE8
;-------------------------------------------------------------------------------
; Splash de água causado pelo jogador entrando e saindo da água
; <<<-
;-------------------------------------------------------------------------------