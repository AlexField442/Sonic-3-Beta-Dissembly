;===============================================================================
; Objeto 0x4A - Bumper na Carnival Night / Balloon Park / Glowing Spheres Bonus
; ->>>           
;===============================================================================
; Offset_0x029188:
                move.l  #Bumper_Mappings, mappings(A0)   ; Offset_0x0293D4, $000C
                move.w  #$4364, art_tile(A0)                         ; $000A
                move.b  #$04, render_flags(A0)                              ; $0004
                move.b  #$10, width_pixels(A0)                              ; $0007
                move.b  #$10, height_pixels(A0)                             ; $0006
                move.w  #$0080, priority(A0)                         ; $0008
                move.b  #$D7, collision_flags(A0)                          ; $0028
                move.w  x_pos(A0), objoff_30(A0)         ; $0010, $0030
                move.w  y_pos(A0), objoff_32(A0)         ; $0014, $0032
                tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
                beq.s   Offset_0x0291DE
                move.l  #Bumper_Mappings_2P, mappings(A0) ; Offset_0x00293F4, $000C
                move.w  #$2300, art_tile(A0)                         ; $000A
                move.l  #Offset_0x029322, (A0)
                bra     Offset_0x029322
Offset_0x0291DE:
                move.l  #Offset_0x029220, (A0)
                move.b  subtype(A0), D0                              ; $002C
                beq.s   Offset_0x029220
                move.b  D0, angle(A0)                                ; $0026
                move.l  #Offset_0x0291F4, (A0)
Offset_0x0291F4:                
                move.b  (Level_Frame_Count+$01).w, D0                ; $FFFFFE05
                btst    #$00, status(A0)                             ; $002A
                beq.s   Offset_0x029202
                neg.b   D0
Offset_0x029202:
                add.b   angle(A0), D0                                ; $0026
                jsr     (CalcSine)                             ; Offset_0x001B20
                asr.w   #$02, D1
                asr.w   #$02, D0
                add.w   objoff_30(A0), D1                       ; $0030
                add.w   objoff_32(A0), D0                       ; $0032
                move.w  D1, x_pos(A0)                                    ; $0010
                move.w  D0, y_pos(A0)                                    ; $0014
Offset_0x029220:
                tst.b   collision_property(A0)                                 ; $0029
                beq     Offset_0x0292E6
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                bclr    #$00, collision_property(A0)                           ; $0029
                beq.s   Offset_0x029236
                bsr.s   Offset_0x02924C
Offset_0x029236:
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                bclr    #$01, collision_property(A0)                           ; $0029
                beq.s   Offset_0x029244
                bsr.s   Offset_0x02924C
Offset_0x029244:
                clr.b   collision_property(A0)                                 ; $0029
                bra     Offset_0x0292E6
Offset_0x02924C:
                move.w  x_pos(A0), D1                                    ; $0010
                move.w  y_pos(A0), D2                                    ; $0014
                sub.w   x_pos(A1), D1                                    ; $0010
                sub.w   y_pos(A1), D2                                    ; $0014
                jsr     (CalcAngle)                            ; Offset_0x001DB8
                move.b  (Level_Frame_Count).w, D1                    ; $FFFFFE04
                andi.w  #$0003, D1
                add.w   D1, D0
                jsr     (CalcSine)                             ; Offset_0x001B20
                muls.w  #$F900, D1
                asr.l   #$08, D1
                move.w  D1, x_vel(A1)                              ; $0018
                muls.w  #$F900, D0
                asr.l   #$08, D0
                move.w  D0, y_vel(A1)                              ; $001A
                bset    #$01, status(A1)                             ; $002A
                bclr    #$04, status(A1)                             ; $002A
                bclr    #$05, status(A1)                             ; $002A
                clr.b   objoff_40(A1)                           ; $0040
                move.b  #$01, anim(A0)                         ; $0020
                moveq   #Small_Bumper_Sfx, D0                             ; -$75
                jsr     (Play_Music)                           ; Offset_0x001176
                move.w  respawn_index(A0), D0                           ; $0048
                beq.s   Offset_0x0292BA
                move.w  D0, A2
                cmpi.b  #$8A, (A2)
                bcc.s   Offset_0x0292E4
                addq.b  #$01, (A2)
Offset_0x0292BA:
                moveq   #$01, D0
                move.w  A1, A3
                jsr     (Add_Points)                           ; Offset_0x007AEC
                jsr     (AllocateObject)                     ; Offset_0x011DD8
                bne.s   Offset_0x0292E4
                move.l  #Obj_Enemy_Points, (A1)                ; Offset_0x023E42
                move.w  x_pos(A0), x_pos(A1)                      ; $0010, $0010
                move.w  y_pos(A0), y_pos(A1)                      ; $0014, $0014
                move.b  #$04, mapping_frame(A1)                             ; $0022
Offset_0x0292E4:
                rts
Offset_0x0292E6:
                lea     (Bumper_Animate_Data), A1              ; Offset_0x0293C6
                jsr     (AnimateSprite)                        ; Offset_0x01115E
                move.w  objoff_30(A0), D0                       ; $0030
                andi.w  #$FF80, D0
                sub.w   (Camera_X_Left).w, D0                        ; $FFFFF7DA
                cmpi.w  #$0280, D0
                bhi.s   Offset_0x029310
                jsr     (Add_SpriteToCollisionResponseList)       ; Offset_0x00A540
                jmp     (DisplaySprite)                        ; Offset_0x011148
Offset_0x029310:
                move.w  respawn_index(A0), D0                           ; $0048
                beq.s   Offset_0x02931C
                move.w  D0, A2
                bclr    #$07, (A2)
Offset_0x02931C:
                jmp     (DeleteObject)                         ; Offset_0x011138
Offset_0x029322:
                tst.b   collision_property(A0)                                 ; $0029
                beq     Offset_0x0293AE
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                bclr    #$00, collision_property(A0)                           ; $0029
                beq.s   Offset_0x029338
                bsr.s   Offset_0x02934E
Offset_0x029338:
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                bclr    #$01, collision_property(A0)                           ; $0029
                beq.s   Offset_0x029346
                bsr.s   Offset_0x02934E
Offset_0x029346:
                clr.b   collision_property(A0)                                 ; $0029
                bra     Offset_0x0293AE
Offset_0x02934E:
                move.w  x_pos(A0), D1                                    ; $0010
                move.w  y_pos(A0), D2                                    ; $0014
                sub.w   x_pos(A1), D1                                    ; $0010
                sub.w   y_pos(A1), D2                                    ; $0014
                jsr     (CalcAngle)                            ; Offset_0x001DB8
                move.b  (Level_Frame_Count).w, D1                    ; $FFFFFE04
                andi.w  #$0003, D1
                add.w   D1, D0
                jsr     (CalcSine)                             ; Offset_0x001B20
                muls.w  #$F900, D1
                asr.l   #$08, D1
                move.w  D1, x_vel(A1)                              ; $0018
                muls.w  #$F900, D0
                asr.l   #$08, D0
                move.w  D0, y_vel(A1)                              ; $001A
                bset    #$01, status(A1)                             ; $002A
                bclr    #$04, status(A1)                             ; $002A
                bclr    #$05, status(A1)                             ; $002A
                clr.b   objoff_40(A1)                           ; $0040
                move.b  #$01, anim(A0)                         ; $0020
                moveq   #Small_Bumper_Sfx, D0                             ; -$75
                jsr     (Play_Music)                           ; Offset_0x001176
                rts
Offset_0x0293AE:
                lea     (Bumper_Animate_Data), A1              ; Offset_0x0293C6
                jsr     (AnimateSprite)                        ; Offset_0x01115E
                jsr     (Add_SpriteToCollisionResponseList)       ; Offset_0x00A540
                jmp     (DisplaySprite)                        ; Offset_0x011148  
;-------------------------------------------------------------------------------   
Bumper_Animate_Data:                                           ; Offset_0x0293C6
                dc.w    Offset_0x0293CA-Bumper_Animate_Data
                dc.w    Offset_0x0293CD-Bumper_Animate_Data
Offset_0x0293CA:
                dc.b    $0F, $00, $FF
Offset_0x0293CD:
                dc.b    $03, $01, $00, $01, $FD, $00, $00   
;-------------------------------------------------------------------------------  
Bumper_Mappings:                                               ; Offset_0x0293D4
                dc.w    Offset_0x0293D8-Bumper_Mappings
                dc.w    Offset_0x0293E6-Bumper_Mappings
Offset_0x0293D8:
                dc.w    $0002
                dc.w    $F007, $0000, $FFF0
                dc.w    $F007, $0800, $0000
Offset_0x0293E6:
                dc.w    $0002
                dc.w    $F007, $0008, $FFF0
                dc.w    $F007, $0808, $0000       
;-------------------------------------------------------------------------------  
Bumper_Mappings_2P:                                            ; Offset_0x0293F4
                dc.w    Offset_0x0293F8-Bumper_Mappings_2P
                dc.w    Offset_0x029400-Bumper_Mappings_2P
Offset_0x0293F8:
                dc.w    $0001
                dc.w    $F40A, $0000, $FFF4
Offset_0x029400:
                dc.w    $0001
                dc.w    $F40A, $0009, $FFF4
;===============================================================================
; Objeto 0x4A - Bumper na Carnival Night / Balloon Park / Glowing Spheres Bonus
; <<<-  
;===============================================================================  