;===============================================================================
; Perdendo anéis após sofrer algum dano
; ->>>    
;===============================================================================                   
; Offset_0x010AD6:
                moveq   #$00, D0
                move.b  routine(A0), D0                              ; $0005
                move.w  Offset_0x010AE4(PC, D0), D1
                jmp     Offset_0x010AE4(PC, D1)    
;-------------------------------------------------------------------------------
Offset_0x010AE4:
                dc.w    Offset_0x010AEE-Offset_0x010AE4
                dc.w    Offset_0x010BD4-Offset_0x010AE4
                dc.w    Offset_0x010C3A-Offset_0x010AE4
                dc.w    Offset_0x010C4E-Offset_0x010AE4
                dc.w    Offset_0x010C5C-Offset_0x010AE4   
;-------------------------------------------------------------------------------
Offset_0x010AEE:
                move.l  A0, A1
                moveq   #$00, D5
                move.w  (Ring_count).w, D5                   ; $FFFFFE20
                tst.b   parent2+1(A0)                        ; $003F
                beq.s   Offset_0x010B00
                move.w  (Ring_Count_Address_P2).w, D5                ; $FFFFFED0
Offset_0x010B00:
                moveq   #$20, D0
                cmp.w   D0, D5
                bcs.s   Offset_0x010B08
                move.w  D0, D5
Offset_0x010B08:
                subq.w  #$01, D5
                move.w  #$0288, D4
                bra.s   Offset_0x010B18
;-------------------------------------------------------------------------------
Offset_0x010B10:
                bsr     AllocateObjectAfterCurrent                    ; Offset_0x011DE0
                bne     Offset_0x010B9E
Offset_0x010B18:
                move.l  #Rings_Lost, (A1)                      ; Offset_0x010AD6
                addq.b  #$02, routine(A1)                            ; $0005
                move.b  #$08, y_radius(A1)                           ; $001E
                move.b  #$08, x_radius(A1)                            ; $001F
                move.w  x_pos(A0), x_pos(A1)                      ; $0010, $0010
                move.w  y_pos(A0), y_pos(A1)                      ; $0014, $0014
                move.l  #Rings_Mappings, mappings(A1)    ; Offset_0x010DE2, $000C
                move.w  #$A6BC, art_tile(A1)                         ; $000A
                move.b  #$84, render_flags(A1)                              ; $0004
                move.w  #$0180, priority(A1)                         ; $0008
                move.b  #$47, collision_flags(A1)                          ; $0028
                move.b  #$08, width_pixels(A1)                              ; $0007
                move.b  #$FF, (Object_Frame_Anim_Counter).w          ; $FFFFFEA6
                tst.w   D4
                bmi.s   Offset_0x010B8E
                move.w  D4, D0
                jsr     (CalcSine)                             ; Offset_0x001B20
                move.w  D4, D2
                lsr.w   #$08, D2
                asl.w   D2, D0
                asl.w   D2, D1
                move.w  D0, D2
                move.w  D1, D3
                addi.b  #$10, D4
                bcc.s   Offset_0x010B8E
                subi.w  #$0080, D4
                bcc.s   Offset_0x010B8E
                move.w  #$0288, D4
Offset_0x010B8E:
                move.w  D2, x_vel(A1)                              ; $0018
                move.w  D3, y_vel(A1)                              ; $001A
                neg.w   D2
                neg.w   D4
                dbra    D5, Offset_0x010B10
Offset_0x010B9E:
                move.w  #Ring_Lost_Sfx, D0                               ; $0034
                jsr     (PlaySound)                           ; Offset_0x001176
                tst.b   parent2+1(A0)                        ; $003F
                bne.s   Offset_0x010BC2
                move.w  #$0000, (Ring_count).w               ; $FFFFFE20
                move.b  #$80, (Update_HUD_rings).w             ; $FFFFFE1D
                move.b  #$00, (Extra_life_flags).w                   ; $FFFFFE1B
                bra.s   Offset_0x010BD4
Offset_0x010BC2:
                move.w  #$0000, (Ring_Count_Address_P2).w            ; $FFFFFED0
                move.b  #$80, (HUD_Rings_Refresh_Flag_P2).w          ; $FFFFFEC9
                move.b  #$00, (Ring_Status_Flag_P2).w                ; $FFFFFEC7
;-------------------------------------------------------------------------------                
Offset_0x010BD4:
                move.b  (Object_Frame_Anim_Frame).w, mapping_frame(A0) ; $FFFFFEA7, $0022
                bsr     SpeedToPos                             ; Offset_0x01111E
                addi.w  #$0018, y_vel(A0)                          ; $001A
                bmi.s   Offset_0x010C14
                move.b  (Vint_runcount+$03).w, D0         ; $FFFFFE0F
                add.b   D7, D0
                andi.b  #$07, D0
                bne.s   Offset_0x010C14
                tst.b   render_flags(A0)                                    ; $0004
                bpl.s   Offset_0x010C30
                jsr     (Ring_FindFloor)                       ; Offset_0x009DE0
                tst.w   D1
                bpl.s   Offset_0x010C14
                add.w   D1, y_pos(A0)                                    ; $0014
                move.w  y_vel(A0), D0                              ; $001A
                asr.w   #$02, D0
                sub.w   D0, y_vel(A0)                              ; $001A
                neg.w   y_vel(A0)                                  ; $001A
Offset_0x010C14:
                tst.b   (Object_Frame_Anim_Counter).w                ; $FFFFFEA6
                beq.s   Offset_0x010C5C
                move.w  (Sonic_Level_Limits_Max_Y).w, D0             ; $FFFFEE1A
                addi.w  #$00E0, D0
                cmp.w   y_pos(A0), D0                                    ; $0014
                bcs.s   Offset_0x010C5C
                bsr     Add_SpriteToCollisionResponseList         ; Offset_0x00A540
                bra     DisplaySprite                          ; Offset_0x011148
Offset_0x010C30:
                tst.w   (Two_Player_Flag).w                          ; $FFFFFFD8
                bne     Offset_0x010C5C
                bra.s   Offset_0x010C14
;-------------------------------------------------------------------------------                
Offset_0x010C3A:
                addq.b  #$02, routine(A0)                            ; $0005
                move.b  #$00, collision_flags(A0)                          ; $0028
                move.w  #$0080, priority(A0)                         ; $0008
                bsr     CollectRing            ; Offset_0x010A20
;-------------------------------------------------------------------------------                
Offset_0x010C4E:
                lea     (Rings_Animate_Data), A1               ; Offset_0x010DDA
                bsr     AnimateSprite                          ; Offset_0x01115E
                bra     DisplaySprite                          ; Offset_0x011148
;-------------------------------------------------------------------------------                
Offset_0x010C5C:
                bra     DeleteObject                           ; Offset_0x011138                                                                                                                                                                                                                                                                                                                                                                           
;===============================================================================
; Perdendo anéis após sofrer algum dano
; <<<-       
;===============================================================================  