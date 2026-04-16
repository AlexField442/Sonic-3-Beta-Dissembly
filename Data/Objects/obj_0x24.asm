;===============================================================================
; Objeto 0x24 - Atributos dos túneis transportadores na Launch Base 
; ->>>           
;===============================================================================
Obj_Automatic_Tunnel_Delayed: ; usado pelo objeto 0x1B         ; Offset_0x0201B8
                subq.b  #$01, anim_frame_duration(A0)                           ; $0024
                bmi.s   Offset_0x0201C0
                rts
Offset_0x0201C0:
                move.b  #$00, anim_frame_duration(A0) 
;-------------------------------------------------------------------------------                
Obj_0x24_Automatic_Tunnel:                                     ; Offset_0x0201C6
                ori.b   #$04, render_flags(A0)                              ; $0004
                move.b  #$10, width_pixels(A0)                              ; $0007
                move.w  #$0280, priority(A0)                         ; $0008
                move.l  #Offset_0x0201DE, (A0)
Offset_0x0201DE:                
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                lea     objoff_30(A0), A4                       ; $0030
                bsr.s   Offset_0x020204
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                lea     objoff_3A(A0), A4                       ; $003A
                bsr.s   Offset_0x020204
                move.b  objoff_30(A0), D0                       ; $0030
                add.b   objoff_3A(A0), D0                       ; $003A
                beq.s   Offset_0x0201FE
                rts
Offset_0x0201FE:
                jmp     (MarkObjGone_3)                        ; Offset_0x011B3E
Offset_0x020204:
                moveq   #$00, D0
                move.b  (A4), D0
                move.w  Offset_0x020210(PC, D0), D0
                jmp     Offset_0x020210(PC, D0)   
;-------------------------------------------------------------------------------
Offset_0x020210:
                dc.w    Offset_0x020216-Offset_0x020210
                dc.w    Offset_0x02029C-Offset_0x020210
                dc.w    Offset_0x020356-Offset_0x020210   
;-------------------------------------------------------------------------------
Offset_0x020216:
                tst.w   (Debug_Mode_Flag_Index).w                    ; $FFFFFE08
                bne     Offset_0x02029A
                move.w  x_pos(A1), D0                                    ; $0010
                sub.w   x_pos(A0), D0                                    ; $0010
                addi.w  #$0010, D0
                cmpi.w  #$0020, D0
                bcc.s   Offset_0x02029A
                move.w  y_pos(A1), D1                                    ; $0014
                sub.w   y_pos(A0), D1                                    ; $0014
                addi.w  #$0018, D1
                cmpi.w  #$0028, D1
                bcc.s   Offset_0x02029A
                tst.b   objoff_2E(A1)                                    ; $002E
                bne.s   Offset_0x02029A
                addq.b  #$02, (A4)
                move.b  #$81, objoff_2E(A1)                              ; $002E
                move.b  #$02, anim(A1)                         ; $0020
                clr.b   objoff_40(A1)                           ; $0040
                move.w  #$0800, inertia(A1)                          ; $001C
                move.w  #$0000, x_vel(A1)                          ; $0018
                move.w  #$0000, y_vel(A1)                          ; $001A
                bclr    #$05, status(A0)                             ; $002A
                bclr    #$05, status(A1)                             ; $002A
                bset    #$01, status(A1)                             ; $002A
                move.w  x_pos(A0), x_pos(A1)                      ; $0010, $0010
                move.w  y_pos(A0), y_pos(A1)                      ; $0014, $0014
                clr.b   $0001(A4)
                bsr     Offset_0x02036A
                moveq   #Rolling_Sfx, D0                                   ; $3C
                jsr     (PlaySound)                           ; Offset_0x001176
Offset_0x02029A:
                rts     
;-------------------------------------------------------------------------------
Offset_0x02029C:
                subq.b  #$01, $0002(A4)
                bhi     Offset_0x020330
                move.l  $0006(A4), A2
                move.w  (A2)+, D4
                move.w  D4, x_pos(A1)                                    ; $0010
                move.w  (A2)+, D5
                move.w  D5, y_pos(A1)                                    ; $0014
                tst.b   subtype(A0)                                  ; $002C
                bpl.s   Offset_0x0202BC
                subq.w  #$08, A2
Offset_0x0202BC:
                move.l  A2, $0006(A4)
                subq.w  #$04, $0004(A4)
                beq.s   Offset_0x0202D2
                move.w  (A2)+, D4
                move.w  (A2)+, D5
                move.w  #$1000, D2
                bra     Offset_0x0203D0
Offset_0x0202D2:
                addq.b  #$02, (A4)
                move.b  #$02, $0002(A4)
                andi.w  #$0FFF, y_pos(A1)                                ; $0014
                btst    #$06, subtype(A0)                            ; $002C
                bne.s   Offset_0x0202F4
                move.w  #$0000, x_vel(A1)                          ; $0018
                move.w  #$0000, y_vel(A1)                          ; $001A
Offset_0x0202F4:
                moveq   #Tube_Launcher_Sfx, D0                            ; -$6B
                jsr     (PlaySound)                           ; Offset_0x001176
                btst    #$05, subtype(A0)                            ; $002C
                beq.s   Offset_0x020330
                move.l  A1, A2
                jsr     (AllocateObjectAfterCurrent)                  ; Offset_0x011DE0
                bne     Offset_0x02032E
                move.l  #Obj_Tunnel_Exhaust_Control, (A1)      ; Offset_0x02044E
                move.w  x_pos(A2), x_pos(A1)                      ; $0010, $0010
                move.w  y_pos(A2), y_pos(A1)                      ; $0014, $0014
                move.w  x_vel(A2), x_vel(A1)          ; $0018, $0018
                move.w  y_vel(A2), y_vel(A1)          ; $001A, $001A
Offset_0x02032E:
                move.l  A2, A1
Offset_0x020330:
                move.l  x_pos(A1), D2                                    ; $0010
                move.l  y_pos(A1), D3                                    ; $0014
                move.w  x_vel(A1), D0                              ; $0018
                ext.l   D0
                asl.l   #$08, D0
                add.l   D0, D2
                move.w  y_vel(A1), D0                              ; $001A
                ext.l   D0
                asl.l   #$08, D0
                add.l   D0, D3
                move.l  D2, x_pos(A1)                                    ; $0010
                move.l  D3, y_pos(A1)                                    ; $0014
                rts          
;-------------------------------------------------------------------------------
Offset_0x020356:
                subq.b  #$01, $0002(A4)
                bne.s   Offset_0x020362
                clr.b   objoff_2E(A1)                                    ; $002E
                clr.b   (A4)
Offset_0x020362:
                addi.w  #$0038, y_vel(A1)                          ; $001A
                bra.s   Offset_0x020330
Offset_0x02036A:
                move.b  subtype(A0), D0                              ; $002C
                bpl.s   Offset_0x02039E
                andi.w  #$001F, D0
                add.w   D0, D0
                add.w   D0, D0
                lea     (LBz_Automatic_Tunnel_From_To_Data), A2 ; Offset_0x1F7258
                move.l  $00(A2, D0), A2               
                move.w  (A2)+, D0
                subq.w  #$04, D0
                move.w  D0, $0004(A4)
                lea     $00(A2, D0), A2
                move.w  (A2)+, D4
                move.w  D4, x_pos(A1)                                    ; $0010
                move.w  (A2)+, D5
                move.w  D5, y_pos(A1)                                    ; $0014
                subq.w  #$08, A2
                bra.s   Offset_0x0203C4
Offset_0x02039E:
                andi.w  #$001F, D0
                add.w   D0, D0
                add.w   D0, D0
                lea     (LBz_Automatic_Tunnel_From_To_Data), A2 ; Offset_0x1F7258
                move.l  $00(A2, D0), A2
                move.w  (A2)+, $0004(A4)
                subq.w  #$04, $0004(A4)
                move.w  (A2)+, D4
                move.w  D4, x_pos(A1)                                    ; $0010
                move.w  (A2)+, D5
                move.w  D5, y_pos(A1)                                    ; $0014
Offset_0x0203C4:
                move.l  A2, $0006(A4)
                move.w  (A2)+, D4
                move.w  (A2)+, D5
                move.w  #$1000, D2
Offset_0x0203D0:
                moveq   #$00, D0
                move.w  D2, D3
                move.w  D4, D0
                sub.w   x_pos(A1), D0                                    ; $0010
                bge.s   Offset_0x0203E0
                neg.w   D0
                neg.w   D2
Offset_0x0203E0:
                moveq   #$00, D1
                move.w  D5, D1
                sub.w   y_pos(A1), D1                                    ; $0014
                bge.s   Offset_0x0203EE
                neg.w   D1
                neg.w   D3
Offset_0x0203EE:
                cmp.w   D0, D1
                bcs.s   Offset_0x020420
                moveq   #$00, D1
                move.w  D5, D1
                sub.w   y_pos(A1), D1                                    ; $0014
                swap.w  D1
                divs.w  D3, D1
                moveq   #$00, D0
                move.w  D4, D0
                sub.w   x_pos(A1), D0                                    ; $0010
                beq.s   Offset_0x02040C
                swap.w  D0
                divs.w  D1, D0
Offset_0x02040C:
                move.w  D0, x_vel(A1)                              ; $0018
                move.w  D3, y_vel(A1)                              ; $001A
                tst.w   D1
                bpl.s   Offset_0x02041A
                neg.w   D1
Offset_0x02041A:
                move.w  D1, $0002(A4)
                rts
Offset_0x020420:
                moveq   #$00, D0
                move.w  D4, D0
                sub.w   x_pos(A1), D0                                    ; $0010
                swap.w  D0
                divs.w  D2, D0
                moveq   #$00, D1
                move.w  D5, D1
                sub.w   y_pos(A1), D1                                    ; $0014
                beq.s   Offset_0x02043A
                swap.w  D1
                divs.w  D0, D1
Offset_0x02043A:
                move.w  D1, y_vel(A1)                              ; $001A
                move.w  D2, x_vel(A1)                              ; $0018
                tst.w   D0
                bpl.s   Offset_0x020448
                neg.w   D0
Offset_0x020448:
                move.w  D0, $0002(A4)
                rts 
;-------------------------------------------------------------------------------
Obj_Tunnel_Exhaust_Control: ; usado também pelo objeto 0x1B    ; Offset_0x02044E
                move.l  #Tunnel_Exhaust_Mappings, mappings(A0) ; Offset_0x020842, $000C
                move.w  #$42EA, art_tile(A0)                         ; $000A
                move.b  #$10, width_pixels(A0)                              ; $0007
                move.b  #$10, height_pixels(A0)                             ; $0006
                ori.b   #$04, render_flags(A0)                              ; $0004
                move.w  #$0180, priority(A0)                         ; $0008
                tst.b   subtype(A0)                                  ; $002C
                beq.s   Offset_0x020484
                move.l  #Obj_Tunnel_Exhaust_Continuous, (A0)   ; Offset_0x02060C
                bra     Obj_Tunnel_Exhaust_Continuous          ; Offset_0x02060C
Offset_0x020484:
                move.w  #$003C, objoff_30(A0)                   ; $0030
                tst.w   y_vel(A0)                                  ; $001A
                beq.s   Offset_0x02049A
                bmi.s   Offset_0x0204AC
                move.w  #$0006, angle(A0)                            ; $0026
                bra.s   Offset_0x0204AC
Offset_0x02049A:
                move.w  #$000C, angle(A0)                            ; $0026
                tst.w   x_vel(A0)                                  ; $0018
                bmi.s   Offset_0x0204AC
                move.w  #$0012, angle(A0)                            ; $0026
Offset_0x0204AC:
                tst.b   (Current_Act).w                                   ; $FFFFFE11
                bne.s   Offset_0x0204BC
                move.l  #Obj_Tunnel_Exhaust_Smoke, (A0)        ; Offset_0x0206B0
                bra     Obj_Tunnel_Exhaust_Smoke               ; Offset_0x0206B0
;-------------------------------------------------------------------------------                
Offset_0x0204BC:
                move.l  #Obj_Tunnel_Exhaust_Control_Main, (A0) ; Offset_0x0204C2
Obj_Tunnel_Exhaust_Control_Main:                               ; Offset_0x0204C2                
                subq.w  #$01, objoff_2E(A0)                              ; $002E
                bpl.s   Offset_0x020538
                move.w  #$0003, objoff_2E(A0)                            ; $002E
                jsr     (AllocateObjectAfterCurrent)                  ; Offset_0x011DE0
                bne     Offset_0x020538
                move.l  #Obj_Tunnel_Exhaust_Up, (A1)           ; Offset_0x02057E
                move.w  x_pos(A0), x_pos(A1)                      ; $0010, $0010
                move.w  y_pos(A0), y_pos(A1)                      ; $0014, $0014
                move.l  #Tunnel_Exhaust_Mappings, mappings(A1) ; Offset_0x020842, $000C
                move.w  #$42EA, art_tile(A1)                         ; $000A
                move.b  #$10, width_pixels(A1)                              ; $0007
                move.b  #$10, height_pixels(A1)                             ; $0006
                move.w  #$0380, priority(A1)                         ; $0008
                move.w  angle(A0), D0                                ; $0026
                cmpi.w  #$0006, D0
                bne.s   Offset_0x02051A
                move.l  #Obj_Tunnel_Exhaust_Down, (A1)         ; Offset_0x0205AC
Offset_0x02051A:
                lea     Offset_0x02054A(PC, D0), A2
                move.w  (A2)+, x_vel(A1)                           ; $0018
                move.w  (A2)+, y_vel(A1)                           ; $001A
                move.b  (A2)+, render_flags(A1)                             ; $0004
                move.b  (A2)+, mapping_frame(A1)                            ; $0022
                bne.s   Offset_0x020538
                move.l  #Obj_Tunnel_Exhaust_Horizontal, (A1)   ; Offset_0x0205DC
                bsr.s   Offset_0x020562
Offset_0x020538:
                subq.w  #$01, objoff_30(A0)                     ; $0030
                bpl.s   Offset_0x020544
                move.w  #$7FF0, x_pos(A0)                                ; $0010
Offset_0x020544:
                jmp     (MarkObjGone_3)                        ; Offset_0x011B3E     
;-------------------------------------------------------------------------------
Offset_0x02054A:
                dc.w    $0000, $FA00, $8601, $0000, $0400, $8401, $FA00, $0000
                dc.w    $8500, $0600, $0000, $8400        
;-------------------------------------------------------------------------------
Offset_0x020562:
                moveq   #$00, D0
                move.w  objoff_30(A0), D0                       ; $0030
                subi.w  #$003C, D0
                neg.w   D0
                lsl.w   #$04, D0
                tst.w   x_vel(A1)                                  ; $0018
                bmi.s   Offset_0x020578
                neg.w   D0
Offset_0x020578:
                add.w   D0, x_vel(A1)                              ; $0018
                rts           
;-------------------------------------------------------------------------------
Obj_Tunnel_Exhaust_Up:                                         ; Offset_0x02057E
                move.b  (Level_Frame_Count+$01).w, D0                ; $FFFFFE05
                andi.b  #$01, D0
                bne.s   Offset_0x02058E
                bchg    #00, render_flags(A0)                               ; $0004
Offset_0x02058E:
                jsr     (ObjectFall)                           ; Offset_0x0110FE
                tst.b   render_flags(A0)                                    ; $0004
                bmi.s   Offset_0x0205A6
                tst.w   y_vel(A0)                                  ; $001A
                bmi.s   Offset_0x0205A6
                move.w  #$7FF0, x_pos(A0)                                ; $0010
Offset_0x0205A6:
                jmp     (MarkObjGone)                          ; Offset_0x011AF2     
;-------------------------------------------------------------------------------     
Obj_Tunnel_Exhaust_Down:                                       ; Offset_0x0205AC
                move.b  (Level_Frame_Count+$01).w, D0                ; $FFFFFE05
                andi.b  #$01, D0
                bne.s   Offset_0x0205BC
                bchg    #00, render_flags(A0)                               ; $0004
Offset_0x0205BC:
                jsr     (ObjectFall)                           ; Offset_0x0110FE
                tst.b   render_flags(A0)                                    ; $0004
                bmi.s   Offset_0x0205D6
                cmpi.w  #$0C00, y_vel(A0)                          ; $001A
                blt.s   Offset_0x0205D6
                move.w  #$7FF0, x_pos(A0)                                ; $0010
Offset_0x0205D6:
                jmp     (MarkObjGone)                          ; Offset_0x011AF2   
;------------------------------------------------------------------------------- 
Obj_Tunnel_Exhaust_Horizontal:                                 ; Offset_0x0205DC
                move.b  (Level_Frame_Count+$01).w, D0                ; $FFFFFE05
                andi.b  #$01, D0
                bne.s   Offset_0x0205EC
                bchg    #01, render_flags(A0)                               ; $0004
Offset_0x0205EC:
                jsr     (ObjectFall)                           ; Offset_0x0110FE
                tst.b   render_flags(A0)                                    ; $0004
                bmi.s   Offset_0x020606
                cmpi.w  #$0600, y_vel(A0)                          ; $001A
                blt.s   Offset_0x020606
                move.w  #$7FF0, x_pos(A0)                                ; $0010
Offset_0x020606:
                jmp     (MarkObjGone)                          ; Offset_0x011AF2   
;------------------------------------------------------------------------------- 
Obj_Tunnel_Exhaust_Continuous:                                 ; Offset_0x02060C
                move.b  (Level_Frame_Count+$01).w, D0                ; $FFFFFE05
                andi.b  #$03, D0
                bne.s   Offset_0x020670
                jsr     (AllocateObjectAfterCurrent)                  ; Offset_0x011DE0
                bne     Offset_0x020670
                move.l  #Obj_Tunnel_Exhaust_Timed, (A1)        ; Offset_0x020676
                move.w  x_pos(A0), x_pos(A1)                      ; $0010, $0010
                move.w  y_pos(A0), y_pos(A1)                      ; $0014, $0014
                move.l  #Tunnel_Exhaust_Mappings, mappings(A1) ; Offset_0x020842, $000C
                move.w  #$42EA, art_tile(A1)                         ; $000A
                move.b  #$10, width_pixels(A1)                              ; $0007
                move.b  #$10, height_pixels(A1)                             ; $0006
                move.w  #$0380, priority(A1)                         ; $0008
                move.w  #$0000, x_vel(A1)                          ; $0018
                move.w  #$0400, y_vel(A1)                          ; $001A
                move.b  #$84, render_flags(A1)                              ; $0004
                move.b  #$01, mapping_frame(A1)                             ; $0022
                move.w  #$000B, objoff_2E(A1)                            ; $002E
Offset_0x020670:
                jmp     (MarkObjGone_3)                        ; Offset_0x011B3E   
;-------------------------------------------------------------------------------  
Obj_Tunnel_Exhaust_Timed:                                      ; Offset_0x020676
                subq.w  #$01, objoff_2E(A0)                              ; $002E
                bpl.s   Offset_0x020688
                move.w  #$000B, objoff_2E(A0)                            ; $002E
                move.w  #$7FF0, x_pos(A0)                                ; $0010
Offset_0x020688:
                move.b  (Level_Frame_Count+$01).w, D0                ; $FFFFFE05
                andi.b  #$01, D0
                bne.s   Offset_0x020698
                bchg    #00, render_flags(A0)                               ; $0004
Offset_0x020698:
                jsr     (ObjectFall)                           ; Offset_0x0110FE
                tst.b   render_flags(A0)                                    ; $0004
                bmi.s   Offset_0x0206AA
                move.w  #$7FF0, x_pos(A0)                                ; $0010
Offset_0x0206AA:
                jmp     (MarkObjGone)                          ; Offset_0x011AF2
;-------------------------------------------------------------------------------                
Obj_Tunnel_Exhaust_Smoke:                                      ; Offset_0x0206B0
                move.b  (Level_Frame_Count+$01).w, D0                ; $FFFFFE05
                andi.b  #$03, D0
                bne.s   Offset_0x0206E2
                jsr     (AllocateObjectAfterCurrent)                  ; Offset_0x011DE0
                bne     Offset_0x0206E2
                move.l  #Obj_FireShield_Dissipate, (A1)       ; Offset_0x013E28
                move.w  x_pos(A0), x_pos(A1)                      ; $0010, $0010
                move.w  y_pos(A0), y_pos(A1)                      ; $0014, $0014
                move.w  x_vel(A0), x_vel(A1)          ; $0018, $0018
                move.w  y_vel(A0), y_vel(A1)          ; $001A, $001A
Offset_0x0206E2:
                subq.w  #$01, objoff_30(A0)                     ; $0030
                bpl.s   Offset_0x0206EE
                move.w  #$7FF0, x_pos(A0)                                ; $0010
Offset_0x0206EE:
                jmp     (MarkObjGone_3)                        ; Offset_0x011B3E  
;-------------------------------------------------------------------------------  
; Offset_0x0206F4: ; Left over ??? Não usado.
                move.l  #Tunnel_Exhaust_Mappings, mappings(A0)  ; Offset_0x020842, $000C
                move.w  #$42EA, art_tile(A0)                         ; $000A
                move.b  #$10, width_pixels(A0)                              ; $0007
                move.b  #$10, height_pixels(A0)                             ; $0006
                ori.b   #$04, render_flags(A0)                              ; $0004
                move.w  #$0180, priority(A0)                         ; $0008
                move.w  #$0078, objoff_30(A0)                   ; $0030
                move.l  #Offset_0x020726, (A0)
Offset_0x020726:                
                tst.b   objoff_32(A0)                           ; $0032
                bne.s   Offset_0x0207A0
                subq.w  #$01, objoff_2E(A0)                              ; $002E
                bpl.s   Offset_0x0207A0
                move.w  #$0003, objoff_2E(A0)                            ; $002E
                jsr     (AllocateObjectAfterCurrent)                  ; Offset_0x011DE0
                bne     Offset_0x0207A0
                move.l  #Offset_0x0207B8, (A1)
                move.w  x_pos(A0), x_pos(A1)                      ; $0010, $0010
                move.w  y_pos(A0), y_pos(A1)                      ; $0014, $0014
                move.l  #Tunnel_Exhaust_Mappings, mappings(A1) ; Offset_0x020842, $000C
                move.w  #$42EA, art_tile(A1)                         ; $000A
                move.b  #$10, width_pixels(A1)                              ; $0007
                move.b  #$10, height_pixels(A1)                             ; $0006
                move.w  #$0380, priority(A1)                         ; $0008
                ori.b   #$04, render_flags(A1)                              ; $0004
                bset    #$00, render_flags(A1)                              ; $0004
                move.w  #$F800, x_vel(A1)                          ; $0018
                moveq   #$00, D0
                move.b  subtype(A0), D0                              ; $002C
                addq.w  #$01, D0
                add.w   D0, D0
                move.w  D0, objoff_2E(A1)                                ; $002E
                addi.w  #$0010, x_pos(A1)                                ; $0010
                move.b  #$C6, collision_flags(A1)                          ; $0028
Offset_0x0207A0:
                subq.w  #$01, objoff_30(A0)                     ; $0030
                bpl.s   Offset_0x0207B2
                move.w  #$0078, objoff_30(A0)                   ; $0030
                eori.b  #$FF, objoff_32(A0)                     ; $0032
Offset_0x0207B2:
                jmp     (MarkObjGone_3)                        ; Offset_0x011B3E    
;-------------------------------------------------------------------------------
Offset_0x0207B8:
                move.b  (Level_Frame_Count+$01).w, D0                ; $FFFFFE05
                andi.b  #$01, D0
                bne.s   Offset_0x0207C8
                bchg    #01, render_flags(A0)                               ; $0004
Offset_0x0207C8:
                jsr     (SpeedToPos)                           ; Offset_0x01111E
                subq.w  #$01, objoff_2E(A0)                              ; $002E
                bpl.s   Offset_0x0207DA
                move.w  #$7FF0, x_pos(A0)                                ; $0010
Offset_0x0207DA:
                move.b  collision_property(A0), D0                             ; $0029
                beq     Offset_0x0207FE
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                bclr    #$00, collision_property(A0)                           ; $0029
                beq.s   Offset_0x0207F0
                bsr.s   Offset_0x020804
Offset_0x0207F0:
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                bclr    #$01, collision_property(A0)                           ; $0029
                beq.s   Offset_0x0207FE
                bsr.s   Offset_0x020804
Offset_0x0207FE:
                jmp     (MarkObjGone_5)                        ; Offset_0x011BCC
Offset_0x020804:
                tst.b   objoff_2E(A1)                                    ; $002E
                bne.s   Offset_0x020840
                move.w  y_pos(A0), y_pos(A1)                      ; $0014, $0014
                cmpi.w  #$F000, x_vel(A1)                          ; $0018
                beq.s   Offset_0x020840
                move.b  #$1A, anim(A1)                         ; $0020
                clr.b   objoff_40(A1)                           ; $0040
                move.w  #$0000, inertia(A1)                          ; $001C
                move.w  #$F000, x_vel(A1)                          ; $0018
                move.w  #$0000, y_vel(A1)                          ; $001A
                bclr    #$05, status(A1)                             ; $002A
                bset    #$01, status(A1)                             ; $002A
Offset_0x020840:
                rts      
;-------------------------------------------------------------------------------
Tunnel_Exhaust_Mappings:                                       ; Offset_0x020842
                dc.w    Offset_0x020846-Tunnel_Exhaust_Mappings
                dc.w    Offset_0x02084E-Tunnel_Exhaust_Mappings
Offset_0x020846:
                dc.w    $0001
                dc.w    $F40E, $002A, $FFF0
Offset_0x02084E:
                dc.w    $0001
                dc.w    $F00B, $002A, $FFF4                                                                                                                           
;===============================================================================
; Objeto 0x24 - Atributos dos túneis transportadores na Launch Base 
; <<<-  
;===============================================================================  