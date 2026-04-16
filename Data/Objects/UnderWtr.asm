;===============================================================================
; Objeto de controle do Sonic / Miles / Knuckles embaixo da água
; ->>>  
;===============================================================================
; Offset_0x00F38C:
                moveq   #$00, D0
                move.b  routine(A0), D0                              ; $0005
                move.w  Offset_0x00F39A(PC, D0), D1
                jmp     Offset_0x00F39A(PC, D1)
;-------------------------------------------------------------------------------                
Offset_0x00F39A:
                dc.w    Offset_0x00F3AC-Offset_0x00F39A
                dc.w    Offset_0x00F404-Offset_0x00F39A
                dc.w    Offset_0x00F410-Offset_0x00F39A
                dc.w    Offset_0x00F47C-Offset_0x00F39A
                dc.w    Offset_0x00F490-Offset_0x00F39A
                dc.w    Offset_0x00F68E-Offset_0x00F39A
                dc.w    Offset_0x00F496-Offset_0x00F39A
                dc.w    Offset_0x00F4D6-Offset_0x00F39A
                dc.w    Offset_0x00F490-Offset_0x00F39A    
;-------------------------------------------------------------------------------    
Offset_0x00F3AC:
                addq.b  #$02, routine(A0)                            ; $0005
                move.l  #Sonic_Underwater_Mappings, mappings(A0) ; Offset_0x025872, $000C
                tst.b   parent+1(A0)                      ; $0043
                beq.s   Offset_0x00F3C6
                move.l  #Miles_Underwater_Mappings, mappings(A0) ; Offset_0x0258A0, $000C
Offset_0x00F3C6:
                move.w  #$045C, art_tile(A0)                         ; $000A
                move.b  #$84, render_flags(A0)                              ; $0004
                move.b  #$10, width_pixels(A0)                              ; $0007
                move.w  #$0080, priority(A0)                         ; $0008
                move.b  subtype(A0), D0                              ; $002C
                bpl.s   Offset_0x00F3F4
                addq.b  #$08, routine(A0)                            ; $0005
                andi.w  #$007F, D0
                move.b  D0, status_tertiary(A0)                      ; $0037
                bra     Offset_0x00F68E
Offset_0x00F3F4:
                move.b  D0, anim(A0)                           ; $0020
                move.w  x_pos(A0), invulnerable_time(A0)      ; $0010, $0034
                move.w  #$FF00, y_vel(A0)                          ; $001A
Offset_0x00F404:
                lea     (Bubbles_Animate_Data), A1             ; Offset_0x00F8E0
                jsr     (AnimateSprite)                        ; Offset_0x01115E
Offset_0x00F410:
                move.w  (Water_Level_Move).w, D0                     ; $FFFFF646
                cmp.w   y_pos(A0), D0                                    ; $0014
                bcs.s   Offset_0x00F436
                move.b  #$06, routine(A0)                            ; $0005
                addq.b  #$07, anim(A0)                         ; $0020
                cmpi.b  #$0D, anim(A0)                         ; $0020
                beq.s   Offset_0x00F47C
                bcs.s   Offset_0x00F47C
                move.b  #$0D, anim(A0)                         ; $0020
                bra.s   Offset_0x00F47C
Offset_0x00F436:
                tst.w   (Sonic_Wind_Flag).w                          ; $FFFFF7C8
                beq.s   Offset_0x00F440
                addq.w  #$04, invulnerable_time(A0)                  ; $0034
Offset_0x00F440:
                move.b  angle(A0), D0                                ; $0026
                addq.b  #$01, angle(A0)                              ; $0026
                andi.w  #$007F, D0
                lea     (Offset_0x00F546), A1
                move.b  $00(A1, D0), D0
                ext.w   D0
                add.w   invulnerable_time(A0), D0                    ; $0034
                move.w  D0, x_pos(A0)                                    ; $0010
                bsr     Offset_0x00F4FA
                jsr     (SpeedToPos)                           ; Offset_0x01111E
                tst.b   render_flags(A0)                                    ; $0004
                bpl.s   Offset_0x00F476
                jmp     (DisplaySprite)                        ; Offset_0x011148
Offset_0x00F476:
                jmp     (DeleteObject)                         ; Offset_0x011138
Offset_0x00F47C:
                bsr.s   Offset_0x00F4FA
                lea     (Bubbles_Animate_Data), A1             ; Offset_0x00F8E0
                jsr     (AnimateSprite)                        ; Offset_0x01115E
                jmp     (DisplaySprite)                        ; Offset_0x011148
Offset_0x00F490:
                jmp     (DeleteObject)                         ; Offset_0x011138
Offset_0x00F496:
                move.l  jumping(A0), A2                          ; $0040
                cmpi.b  #$0C, subtype(A2)                            ; $002C
                bhi.s   Offset_0x00F4D0
                subq.w  #$01, stick_to_convex(A0)                   ; $003C
                bne.s   Offset_0x00F4B4
                move.b  #$0E, routine(A0)                            ; $0005
                addq.b  #$07, anim(A0)                         ; $0020
                bra.s   Offset_0x00F47C
Offset_0x00F4B4:
                lea     (Bubbles_Animate_Data), A1             ; Offset_0x00F8E0
                jsr     (AnimateSprite)                        ; Offset_0x01115E
                bsr     Offset_0x00F646
                tst.b   render_flags(A0)                                    ; $0004
                bpl.s   Offset_0x00F4D0
                jmp     (DisplaySprite)                        ; Offset_0x011148
Offset_0x00F4D0:
                jmp     (DeleteObject)                         ; Offset_0x011138
Offset_0x00F4D6:
                move.l  jumping(A0), A2                          ; $0040
                cmpi.b  #$0C, subtype(A2)                            ; $002C
                bhi.s   Offset_0x00F490
                bsr.s   Offset_0x00F4FA
                lea     (Bubbles_Animate_Data), A1             ; Offset_0x00F8E0
                jsr     (AnimateSprite)                        ; Offset_0x01115E
                bsr     Offset_0x00F646
                jmp     (DisplaySprite)                        ; Offset_0x011148
Offset_0x00F4FA:
                tst.w   stick_to_convex(A0)                         ; $003C
                beq.s   Offset_0x00F544
                subq.w  #$01, stick_to_convex(A0)                   ; $003C
                bne.s   Offset_0x00F544
                cmpi.b  #$07, anim(A0)                         ; $0020
                bcc.s   Offset_0x00F544
                move.w  #$000F, stick_to_convex(A0)                 ; $003C
                clr.w   y_vel(A0)                                  ; $001A
                move.b  #$80, render_flags(A0)                              ; $0004
                move.w  x_pos(A0), D0                                    ; $0010
                sub.w   (Camera_X).w, D0                             ; $FFFFEE78
                addi.w  #$0080, D0
                move.w  D0, x_pos(A0)                                    ; $0010
                move.w  y_pos(A0), D0                                    ; $0014
                sub.w   (Camera_Y).w, D0                             ; $FFFFEE7C
                addi.w  #$0080, D0
                move.w  D0, y_pos(A0)                                    ; $0014
                move.b  #$0C, routine(A0)                            ; $0005
Offset_0x00F544:
                rts                       
;-------------------------------------------------------------------------------
Offset_0x00F546:
                dc.b    $00, $00, $00, $00, $00, $00, $01, $01
                dc.b    $01, $01, $01, $02, $02, $02, $02, $02
                dc.b    $02, $02, $03, $03, $03, $03, $03, $03
                dc.b    $03, $03, $03, $03, $03, $03, $03, $03
                dc.b    $03, $03, $03, $03, $03, $03, $03, $03
                dc.b    $03, $03, $03, $03, $03, $03, $03, $02
                dc.b    $02, $02, $02, $02, $02, $02, $01, $01
                dc.b    $01, $01, $01, $00, $00, $00, $00, $00
                dc.b    $00, $FF, $FF, $FF, $FF, $FF, $FE, $FE
                dc.b    $FE, $FE, $FE, $FD, $FD, $FD, $FD, $FD
                dc.b    $FD, $FD, $FC, $FC, $FC, $FC, $FC, $FC
                dc.b    $FC, $FC, $FC, $FC, $FC, $FC, $FC, $FC
                dc.b    $FC, $FC, $FC, $FC, $FC, $FC, $FC, $FC
                dc.b    $FC, $FC, $FC, $FC, $FC, $FC, $FC, $FD
                dc.b    $FD, $FD, $FD, $FD, $FD, $FD, $FE, $FE
                dc.b    $FE, $FE, $FE, $FF, $FF, $FF, $FF, $FF
                dc.b    $00, $00, $00, $00, $00, $00, $01, $01
                dc.b    $01, $01, $01, $02, $02, $02, $02, $02
                dc.b    $02, $02, $03, $03, $03, $03, $03, $03
                dc.b    $03, $03, $03, $03, $03, $03, $03, $03
                dc.b    $03, $03, $03, $03, $03, $03, $03, $03
                dc.b    $03, $03, $03, $03, $03, $03, $03, $02
                dc.b    $02, $02, $02, $02, $02, $02, $01, $01
                dc.b    $01, $01, $01, $00, $00, $00, $00, $00
                dc.b    $00, $FF, $FF, $FF, $FF, $FF, $FE, $FE
                dc.b    $FE, $FE, $FE, $FD, $FD, $FD, $FD, $FD
                dc.b    $FD, $FD, $FC, $FC, $FC, $FC, $FC, $FC
                dc.b    $FC, $FC, $FC, $FC, $FC, $FC, $FC, $FC
                dc.b    $FC, $FC, $FC, $FC, $FC, $FC, $FC, $FC
                dc.b    $FC, $FC, $FC, $FC, $FC, $FC, $FC, $FD
                dc.b    $FD, $FD, $FD, $FD, $FD, $FD, $FE, $FE
                dc.b    $FE, $FE, $FE, $FF, $FF, $FF, $FF, $FF   
;-------------------------------------------------------------------------------
Offset_0x00F646:
                moveq   #$00, D1
                move.b  mapping_frame(A0), D1                               ; $0022
                cmpi.b  #$09, D1
                bcs.s   Offset_0x00F68C
                cmpi.b  #$13, D1
                bcc.s   Offset_0x00F68C
                cmp.b   move_lock(A0), D1                    ; $0032
                beq.s   Offset_0x00F68C
                move.b  D1, move_lock(A0)                    ; $0032
                subi.w  #$0009, D1
                move.w  D1, D0
                add.w   D1, D1
                add.w   D0, D1
                lsl.w   #$06, D1
                addi.l  #Art_Oxygen_Numbers, D1                ; Offset_0x0A8640
                move.w  #$FC00, D2
                tst.b   parent+1(A0)                      ; $0043
                beq.s   Offset_0x00F682
                move.w  #$FE00, D2
Offset_0x00F682:
                move.w  #$0060, D3
                jsr     (QueueDMATransfer)                        ; Offset_0x0012FC
Offset_0x00F68C:
                rts      
;-------------------------------------------------------------------------------
Offset_0x00F68E:
                move.l  jumping(A0), A2                          ; $0040
                tst.w   flips_remaining(A0)                        ; $0030
                bne     Offset_0x00F78C
                cmpi.b  #$06, routine(A2)                            ; $0005
                bcc     Offset_0x00F89C
                btst    #$06, status(A2)                             ; $002A
                beq     Offset_0x00F89C
                subq.w  #$01, stick_to_convex(A0)                   ; $003C
                bpl     Offset_0x00F7B0
                move.w  #$003B, stick_to_convex(A0)                 ; $003C
                move.w  #$0001, next_tilt(A0)                 ; $003A
                jsr     (PseudoRandomNumber)                   ; Offset_0x001AFA
                andi.w  #$0001, D0
                move.b  D0, character_id(A0)                      ; $0038
                moveq   #$00, D0
                move.b  subtype(A2), D0                              ; $002C
                cmpi.w  #$0019, D0
                beq.s   Offset_0x00F712
                cmpi.w  #$0014, D0
                beq.s   Offset_0x00F712
                cmpi.w  #$000F, D0
                beq.s   Offset_0x00F712
                cmpi.w  #$000C, D0
                bhi.s   Offset_0x00F720
                bne.s   Offset_0x00F6FE
                tst.b   parent+1(A0)                      ; $0043
                bne.s   Offset_0x00F6FE
                moveq   #Panic_Snd, D0                                     ; $31
                jsr     (PlaySound)                           ; Offset_0x001176
Offset_0x00F6FE:
                subq.b  #$01, speedshoes_time(A0)                   ; $0036
                bpl.s   Offset_0x00F720
                move.b  status_tertiary(A0), speedshoes_time(A0) ; $0036, $0037
                bset    #$07, next_tilt(A0)                   ; $003A
                bra.s   Offset_0x00F720
Offset_0x00F712:
                tst.b   parent+1(A0)                      ; $0043
                bne.s   Offset_0x00F720
                moveq   #Underwater_Sfx, D0                                ; $79
                jsr     (PlaySound)                           ; Offset_0x001176
Offset_0x00F720:
                subq.b  #$01, subtype(A2)                            ; $002C
                bcc     Offset_0x00F7AE
                move.b  #$81, obj_control(A2)                     ; $002E
                move.w  #Drowning_Sfx, D0                                ; $003B
                jsr     (PlaySound)                           ; Offset_0x001176
                move.b  #$0A, character_id(A0)                    ; $0038
                move.w  #$0001, next_tilt(A0)                 ; $003A
                move.w  #$0078, flips_remaining(A0)                ; $0030
                move.l  A2, A1
                bsr     ResumeMusic                           ; Offset_0x00F89E
                move.l  A0, -(A7)
                move.l  A2, A0
                bsr     Sonic_ResetOnFloor                     ; Offset_0x00BF76
                move.b  #$17, anim(A0)                         ; $0020
                bset    #$01, status(A0)                             ; $002A
                bset    #$07, art_tile(A0)                           ; $000A
                move.w  #$0000, y_vel(A0)                          ; $001A
                move.w  #$0000, x_vel(A0)                          ; $0018
                move.w  #$0000, inertia(A0)                          ; $001C
                move.l  (A7)+, A0
                cmpa.w  #Obj_Player_One, A2                              ; $B000
                bne.s   Offset_0x00F78A
                move.b  #$01, (Rasters_Flag).w                       ; $FFFFEE30
Offset_0x00F78A:
                rts
Offset_0x00F78C:
                subq.w  #$01, flips_remaining(A0)                  ; $0030
                bne.s   Offset_0x00F79A
                move.b  #$06, routine(A2)                            ; $0005
                rts
Offset_0x00F79A:
                move.l  A0, -(A7)
                move.l  A2, A0
                jsr     (SpeedToPos)                           ; Offset_0x01111E
                addi.w  #$0010, y_vel(A0)                          ; $001A
                move.l  (A7)+, A0
                bra.s   Offset_0x00F7B0
Offset_0x00F7AE:
                bra.s   Offset_0x00F7C0
Offset_0x00F7B0:
                tst.w   next_tilt(A0)                         ; $003A
                beq     Offset_0x00F89C
                subq.w  #$01, spindash_counter(A0)                   ; $003E
                bpl     Offset_0x00F89C
Offset_0x00F7C0:
                jsr     (PseudoRandomNumber)                   ; Offset_0x001AFA
                andi.w  #$000F, D0
                addq.w  #$08, D0
                move.w  D0, spindash_counter(A0)                     ; $003E
                jsr     (AllocateObject)                     ; Offset_0x011DD8
                bne     Offset_0x00F89C
                move.l  (A0), (A1)
                move.w  x_pos(A2), x_pos(A1)                      ; $0010, $0010
                moveq   #$06, D0
                btst    #$00, status(A2)                             ; $002A
                beq.s   Offset_0x00F7F4
                neg.w   D0
                move.b  #$40, angle(A1)                              ; $0026
Offset_0x00F7F4:
                add.w   D0, x_pos(A1)                                    ; $0010
                move.w  y_pos(A2), y_pos(A1)                      ; $0014, $0014
                move.l  jumping(A0), jumping(A1)  ; $0040, $0040
                move.b  #$06, subtype(A1)                            ; $002C
                tst.w   flips_remaining(A0)                        ; $0030
                beq     Offset_0x00F846
                andi.w  #$0007, spindash_counter(A0)                 ; $003E
                addi.w  #$0000, spindash_counter(A0)                 ; $003E
                move.w  y_pos(A2), D0                                    ; $0014
                subi.w  #$000C, D0
                move.w  D0, y_pos(A1)                                    ; $0014
                jsr     (PseudoRandomNumber)                   ; Offset_0x001AFA
                move.b  D0, angle(A1)                                ; $0026
                move.w  (Level_Frame_Count).w, D0                    ; $FFFFFE04
                andi.b  #$03, D0
                bne.s   Offset_0x00F892
                move.b  #$0E, subtype(A1)                            ; $002C
                bra.s   Offset_0x00F892
Offset_0x00F846:
                btst    #$07, next_tilt(A0)                   ; $003A
                beq.s   Offset_0x00F892
                moveq   #$00, D2
                move.b  subtype(A2), D2                              ; $002C
                cmpi.b  #$0C, D2
                bcc.s   Offset_0x00F892
                lsr.w   #$01, D2
                jsr     (PseudoRandomNumber)                   ; Offset_0x001AFA
                andi.w  #$0003, D0
                bne.s   Offset_0x00F87A
                bset    #$06, next_tilt(A0)                   ; $003A
                bne.s   Offset_0x00F892
                move.b  D2, subtype(A1)                              ; $002C
                move.w  #$001C, stick_to_convex(A1)                 ; $003C
Offset_0x00F87A:
                tst.b   character_id(A0)                          ; $0038
                bne.s   Offset_0x00F892
                bset    #$06, next_tilt(A0)                   ; $003A
                bne.s   Offset_0x00F892
                move.b  D2, subtype(A1)                              ; $002C
                move.w  #$001C, stick_to_convex(A1)                 ; $003C
Offset_0x00F892:
                subq.b  #$01, character_id(A0)                    ; $0038
                bpl.s   Offset_0x00F89C
                clr.w   next_tilt(A0)                         ; $003A
Offset_0x00F89C:
                rts                                                                                                                           
;===============================================================================
; Objeto de controle do Sonic / Miles / Knuckles embaixo da água
; <<<-  
;===============================================================================  