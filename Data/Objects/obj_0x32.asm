;===============================================================================
; Objeto 0x32 - Ponte ap�s derrotar o chefe no final da Angel Island 2
; ->>>           
;===============================================================================
; Offset_0x02235C:
                move.l  #Draw_Bridge_Mappings, mappings(A0) ; Offset_0x02277E, $000C
                move.w  #$C2F0, art_tile(A0)                         ; $000A
                move.b  #$04, render_flags(A0)                              ; $0004
                move.w  #$0280, priority(A0)                         ; $0008
                move.b  #$08, width_pixels(A0)                              ; $0007
                move.b  #$60, height_pixels(A0)                             ; $0006
                ori.b   #$80, status(A0)                             ; $002A
                move.w  x_pos(A0), objoff_30(A0)         ; $0010, $0030
                move.w  y_pos(A0), objoff_32(A0)         ; $0014, $0032
                subi.w  #$0068, y_pos(A0)                                ; $0014
                move.b  #$C0, objoff_38(A0)                     ; $0038
                moveq   #-$10, D4
                btst    #$01, status(A0)                             ; $002A
                beq.s   Offset_0x0223B8
                addi.w  #$00D0, y_pos(A0)                                ; $0014
                move.b  #$40, objoff_38(A0)                     ; $0038
                neg.w   D4
Offset_0x0223B8:
                move.w  #$0200, D1
                btst    #$00, status(A0)                             ; $002A
                beq.s   Offset_0x0223C6
                neg.w   D1
Offset_0x0223C6:
                move.w  D1, objoff_34(A0)                       ; $0034
                jsr     (AllocateObjectAfterCurrent)                  ; Offset_0x011DE0
                bne     Offset_0x022498
                move.l  #Offset_0x0225B2, (A1)
                move.l  mappings(A0), mappings(A1)                  ; $000C, $000C
                move.w  art_tile(A0), art_tile(A1)        ; $000A, $000A
                move.w  priority(A0), priority(A1)        ; $0008, $0008
                move.b  #$04, render_flags(A1)                              ; $0004
                bset    #$06, render_flags(A1)                              ; $0004
                move.b  #$40, width_pixels(A1)                              ; $0007
                move.b  #$40, height_pixels(A1)                             ; $0006
                move.w  objoff_30(A0), D2                       ; $0030
                move.w  objoff_32(A0), D3                       ; $0032
                moveq   #$08, D1
                move.w  D1, y_sub(A1)                                ; $0016
                subq.w  #$01, D1
                lea     x_vel(A1), A2                              ; $0018
Offset_0x022418:
                add.w   D4, D3
                move.w  D2, (A2)+
                move.w  D3, (A2)+
                move.w  #$0001, (A2)+
                dbra    D1, Offset_0x022418
                move.w  objoff_30(A1), x_pos(A1)         ; $0030, $0010
                move.w  objoff_32(A1), y_pos(A1)         ; $0032, $0014
                move.w  A1, objoff_3C(A0)                       ; $003C
                jsr     (AllocateObjectAfterCurrent)                  ; Offset_0x011DE0
                bne.s   Offset_0x022498
                move.l  #Offset_0x0225B2, (A1)
                move.l  mappings(A0), mappings(A1)                  ; $000C, $000C
                move.w  art_tile(A0), art_tile(A1)        ; $000A, $000A
                move.w  priority(A0), priority(A1)        ; $0008, $0008
                move.b  #$04, render_flags(A1)                              ; $0004
                bset    #$06, render_flags(A1)                              ; $0004
                move.b  #$40, width_pixels(A1)                              ; $0007
                move.b  #$40, height_pixels(A1)                             ; $0006
                moveq   #$04, D1
                move.w  D1, y_sub(A1)                                ; $0016
                subq.w  #$01, D1
                lea     x_vel(A1), A2                              ; $0018
Offset_0x02247A:
                add.w   D4, D3
                move.w  D2, (A2)+
                move.w  D3, (A2)+
                move.w  #$0001, (A2)+
                dbra    D1, Offset_0x02247A
                move.w  x_vel(A1), x_pos(A1)                ; $0018, $0010
                move.w  y_vel(A1), y_pos(A1)                ; $001A, $0014
                move.w  A1, objoff_3E(A0)                       ; $003E
Offset_0x022498:
                move.l  #Offset_0x02249E, (A0)
Offset_0x02249E:                
                tst.b   (Boss_Defeated_Flag).w                       ; $FFFFFAA3
                beq.s   Offset_0x0224E2
                tst.b   objoff_36(A0)                           ; $0036
                bne.s   Offset_0x0224E2
                move.b  #$01, objoff_36(A0)                     ; $0036
                moveq   #Draw_Bridge_Move_Sfx, D0                          ; $5C
                jsr     (PlaySound)                           ; Offset_0x001176
                move.w  #$0068, D1
                btst    #$00, status(A0)                             ; $002A
                beq.s   Offset_0x0224C6
                neg.w   D1
Offset_0x0224C6:
                move.w  objoff_30(A0), x_pos(A0)         ; $0030, $0010
                move.w  objoff_32(A0), y_pos(A0)         ; $0032, $0014
                add.w   D1, x_pos(A0)                                    ; $0010
                move.b  #$60, width_pixels(A0)                              ; $0007
                move.b  #$08, height_pixels(A0)                             ; $0006
Offset_0x0224E2:
                tst.b   objoff_36(A0)                           ; $0036
                beq.s   Offset_0x022514
                tst.b   objoff_38(A0)                           ; $0038
                beq.s   Offset_0x0224F6
                cmpi.b  #$80, objoff_38(A0)                     ; $0038
                bne.s   Offset_0x02250C
Offset_0x0224F6:
                move.b  #$00, objoff_36(A0)                     ; $0036
                moveq   #Draw_Bridge_Move_Sfx, D0                          ; $5C
                jsr     (PlaySound)                           ; Offset_0x001176
                move.l  #Offset_0x02251A, (A0)
                bra.s   Offset_0x022514
Offset_0x02250C:
                move.w  objoff_34(A0), D0                       ; $0034
                add.w   D0, objoff_38(A0)                       ; $0038
Offset_0x022514:
                bsr     Offset_0x0225B8
                bra.s   Offset_0x022536             
;-------------------------------------------------------------------------------
Offset_0x02251A:
                tst.b   (Knuckles_Control_Lock_Flag).w               ; $FFFFFAA9
                beq.s   Offset_0x022536
                move.l  #Offset_0x022684, (A0)
                move.b  #$0E, objoff_34(A0)                     ; $0034
                move.l  #Offset_0x02265C, D4
                bra     Offset_0x0226BE
Offset_0x022536:
                move.w  #$0013, D1
                move.w  #$0060, D2
                move.w  #$0061, D3
                move.b  objoff_38(A0), D0                       ; $0038
                beq.s   Offset_0x022554
                cmpi.b  #$40, D0
                beq.s   Offset_0x022560
                cmpi.b  #$C0, D0
                beq.s   Offset_0x022560
Offset_0x022554:
                move.w  #$006B, D1
                move.w  #$0008, D2
                move.w  #$0008, D3
Offset_0x022560:
                move.w  x_pos(A0), D4                                    ; $0010
                jsr     (Solid_Object_2)                       ; Offset_0x0135B6
                move.w  objoff_30(A0), D0                       ; $0030
                andi.w  #$FF80, D0
                sub.w   (Camera_X_Left).w, D0                        ; $FFFFF7DA
                cmpi.w  #$0280, D0
                bhi     Offset_0x022584
                jmp     (DisplaySprite)                        ; Offset_0x011148
Offset_0x022584:
                move.w  objoff_3C(A0), D0                       ; $003C
                beq.s   Offset_0x022592
                move.w  D0, A1
                jsr     (DeleteObject2)                     ; Offset_0x01113A
Offset_0x022592:
                move.w  objoff_3E(A0), D0                       ; $003E
                beq.s   Offset_0x0225A0
                move.w  D0, A1
                jsr     (DeleteObject2)                     ; Offset_0x01113A
Offset_0x0225A0:
                move.w  respawn_index(A0), D0                           ; $0048
                beq.s   Offset_0x0225AC
                move.w  D0, A2
                bclr    #$07, (A2)
Offset_0x0225AC:
                jmp     (DeleteObject)                         ; Offset_0x011138    
;-------------------------------------------------------------------------------
Offset_0x0225B2:
                jmp     (DisplaySprite)                        ; Offset_0x011148    
;-------------------------------------------------------------------------------
Offset_0x0225B8:
                tst.b   objoff_36(A0)                           ; $0036
                beq     Offset_0x02265A
                moveq   #$00, D0
                moveq   #$00, D1
                move.b  objoff_38(A0), D0                       ; $0038
                jsr     (CalcSine)                             ; Offset_0x001B20
                move.w  objoff_32(A0), D2                       ; $0032
                move.w  objoff_30(A0), D3                       ; $0030
                moveq   #$00, D6
                move.w  objoff_3C(A0), A1                       ; $003C
                move.w  y_sub(A1), D6                                ; $0016
                subq.w  #$01, D6
                bcs.s   Offset_0x02265A
                swap.w  D0
                swap.w  D1
                asr.l   #$04, D0
                asr.l   #$04, D1
                move.l  D0, D4
                move.l  D1, D5
                lea     x_vel(A1), A2                              ; $0018
Offset_0x0225F4:
                movem.l D4/D5, -(A7)
                swap.w  D4
                swap.w  D5
                add.w   D2, D4
                add.w   D3, D5
                move.w  D5, (A2)+
                move.w  D4, (A2)+
                movem.l (A7)+, D4/D5
                add.l   D0, D4
                add.l   D1, D5
                addq.w  #$02, A2
                dbra    D6, Offset_0x0225F4
                move.w  objoff_30(A1), x_pos(A1)         ; $0030, $0010
                move.w  objoff_32(A1), y_pos(A1)         ; $0032, $0014
                moveq   #$00, D6
                move.w  objoff_3E(A0), A1                       ; $003E
                move.w  y_sub(A1), D6                                ; $0016
                subq.w  #$01, D6
                bcs.s   Offset_0x02265A
                lea     x_vel(A1), A2                              ; $0018
Offset_0x022630:
                movem.l D4/D5, -(A7)
                swap.w  D4
                swap.w  D5
                add.w   D2, D4
                add.w   D3, D5
                move.w  D5, (A2)+
                move.w  D4, (A2)+
                movem.l (A7)+, D4/D5
                add.l   D0, D4
                add.l   D1, D5
                addq.w  #$02, A2
                dbra    D6, Offset_0x022630
                move.w  x_vel(A1), x_pos(A1)                ; $0018, $0010
                move.w  y_vel(A1), y_pos(A1)                ; $001A, $0014
Offset_0x02265A:
                rts      
;-------------------------------------------------------------------------------   
Offset_0x02265C:
                tst.b   objoff_34(A0)                           ; $0034
                beq.s   Offset_0x02266C
                subq.b  #$01, objoff_34(A0)                     ; $0034
                jmp     (DisplaySprite)                        ; Offset_0x011148
Offset_0x02266C:
                jsr     (ObjectFall)                           ; Offset_0x0110FE
                tst.b   render_flags(A0)                                    ; $0004
                bpl.s   Offset_0x02267E
                jmp     (DisplaySprite)                        ; Offset_0x011148
Offset_0x02267E:
                jmp     (DeleteObject)                         ; Offset_0x011138    
;-------------------------------------------------------------------------------
Offset_0x022684:
                tst.b   objoff_34(A0)                           ; $0034
                beq.s   Offset_0x022690
                subq.b  #$01, objoff_34(A0)                     ; $0034
                rts
Offset_0x022690:
                bclr    #$03, status(A0)                             ; $002A
                beq.s   Offset_0x0226A4
                bclr    #$03, (Obj_Player_One+status).w          ; $FFFFB02A
                bset    #$01, (Obj_Player_One+status).w          ; $FFFFB02A
Offset_0x0226A4:
                bclr    #$04, status(A0)                             ; $002A
                beq.s   Offset_0x0226B8
                bclr    #$03, (Obj_Player_Two+status).w          ; $FFFFB074
                bset    #$01, (Obj_Player_Two+status).w          ; $FFFFB074
Offset_0x0226B8:
                jmp     (DeleteObject)                         ; Offset_0x011138
Offset_0x0226BE:
                move.w  objoff_3C(A0), D0                       ; $003C
                beq.s   Offset_0x0226C8
                move.w  D0, A3
                bsr.s   Offset_0x0226D4
Offset_0x0226C8:
                move.w  objoff_3E(A0), D0                       ; $003E
                beq.s   Offset_0x0226D2
                move.w  D0, A3
                bsr.s   Offset_0x0226D4
Offset_0x0226D2:
                rts
Offset_0x0226D4:
                lea     (Offset_0x02276E), A4
                lea     x_vel(A3), A2                              ; $0018
                move.w  y_sub(A3), D6                                ; $0016
                subq.w  #$01, D6
                bclr    #$06, render_flags(A3)                              ; $0004
                move.l  A3, A1
                bra.s   Offset_0x0226F6        
;-------------------------------------------------------------------------------
Offset_0x0226EE:
                jsr     (AllocateObjectAfterCurrent)                  ; Offset_0x011DE0
                bne.s   Offset_0x02275A
Offset_0x0226F6:
                move.l  D4, (A1)
                move.l  mappings(A3), mappings(A1)                  ; $000C, $000C
                move.b  render_flags(A3), render_flags(A1)              ; $0004, $0004
                move.w  art_tile(A3), art_tile(A1)        ; $000A, $000A
                move.w  priority(A3), priority(A1)        ; $0008, $0008
                move.b  width_pixels(A3), width_pixels(A1)              ; $0007, $0007
                move.b  height_pixels(A3), height_pixels(A1)            ; $0006, $0006
                move.w  priority(A3), priority(A1)        ; $0008, $0008
                move.w  (A2)+, x_pos(A1)                                 ; $0010
                move.w  (A2)+, y_pos(A1)                                 ; $0014
                move.w  (A2)+, D0
                move.b  D0, mapping_frame(A1)                               ; $0022
                move.b  (A4)+, objoff_34(A1)                    ; $0034
                move.l  A1, A5
                jsr     (AllocateObjectAfterCurrent)                  ; Offset_0x011DE0
                bne.s   Offset_0x02275A
                move.l  #Obj_Dissipate, (A1)                   ; Offset_0x013E86
                move.w  x_pos(A5), x_pos(A1)                      ; $0010, $0010
                move.w  y_pos(A5), y_pos(A1)                      ; $0014, $0014
                move.b  -1(A4), anim_frame_duration(A1)                      ; $0024
                dbra    D6, Offset_0x0226EE
Offset_0x02275A:
                move.w  #$0000, x_vel(A3)                          ; $0018
                move.w  #$0000, y_vel(A3)                          ; $001A
                moveq   #Bridge_Collapse_Sfx, D0                          ; -$69
                jmp     (PlaySound)                           ; Offset_0x001176 
;-------------------------------------------------------------------------------
Offset_0x02276E:
                dc.b    $08, $10, $0C, $0E, $06, $0A, $04, $02
                dc.b    $08, $10, $0C, $0E, $06, $0A, $04, $02    
;-------------------------------------------------------------------------------  
Draw_Bridge_Mappings:                                          ; Offset_0x02277E
                dc.w    Offset_0x022782-Draw_Bridge_Mappings
                dc.w    Offset_0x022784-Draw_Bridge_Mappings
Offset_0x022782:
                dc.w    $0000
Offset_0x022784:
                dc.w    $0001
                dc.w    $F805, $0122, $FFF8                                                                                                             
;===============================================================================
; Objeto 0x32 - Ponte ap�s derrotar o chefe no final da Angel Island 2
; <<<-  
;===============================================================================  