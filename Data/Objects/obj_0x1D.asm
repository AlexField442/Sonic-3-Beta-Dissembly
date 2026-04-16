;===============================================================================
; Objeto 0x1D - Plataforma não usada em que o jogador pode se aguarrar por baixo   
; ->>>          na Launch Base 
;===============================================================================
; Offset_0x01C228:
                jsr     (AllocateObjectAfterCurrent)                  ; Offset_0x011DE0
                bne     Offset_0x01C27E
                move.w  x_pos(A0), x_pos(A1)                      ; $0010, $0010
                move.w  y_pos(A0), y_pos(A1)                      ; $0014, $0014
                move.b  status(A0), status(A1)            ; $002A, $002A
                move.l  #LBz_Platform_Mappings_2, mappings(A1) ; Offset_0x01C3AA, $000C
                move.w  #$42EA, art_tile(A1)                         ; $000A
                move.b  #$04, render_flags(A1)                              ; $0004
                move.w  #$0180, priority(A1)                         ; $0008
                move.b  #$20, width_pixels(A1)                              ; $0007
                move.b  #$10, height_pixels(A1)                             ; $0006
                move.w  A0, Obj_Control_Var_0E(A1)                       ; $003E
                move.l  #Offset_0x01C282, (A1)
                move.w  A1, Obj_Control_Var_0E(A0)                       ; $003E
                move.b  #$01, Obj_Control_Var_0D(A0)                     ; $003D
Offset_0x01C27E:
                bra     Obj_0x11_LBz_Platform                  ; Offset_0x01BCFC
;-------------------------------------------------------------------------------
Offset_0x01C282:
                move.w  x_pos(A0), D4                                    ; $0010
                move.w  Obj_Control_Var_0E(A0), A1                       ; $003E
                move.w  x_pos(A1), x_pos(A0)                      ; $0010, $0010
                move.w  y_pos(A1), y_pos(A0)                      ; $0014, $0014
                sub.w   x_pos(A1), D4                                    ; $0010
                bsr.s   Offset_0x01C2A2
                jmp     (DisplaySprite)                        ; Offset_0x011148
Offset_0x01C2A2:
                lea     Obj_Control_Var_03(A0), A2                       ; $0033
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                move.w  (Control_Ports_Buffer_Data+$02).w, D0        ; $FFFFF606
                bsr.s   Offset_0x01C2BA
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                subq.w  #$01, A2
                move.w  (Control_Ports_Buffer_Data).w, D0            ; $FFFFF604
Offset_0x01C2BA:
                tst.b   (A2)
                beq     Offset_0x01C336
                tst.b   render_flags(A1)                                    ; $0004
                bpl.s   Offset_0x01C316
                cmpi.b  #$04, routine(A1)                            ; $0005
                bcc.s   Offset_0x01C316
                andi.b  #$70, D0
                beq     Offset_0x01C324
                clr.b   Obj_Timer(A1)                                    ; $002E
                clr.b   (A2)
                move.b  #$12, $0002(A2)
                andi.w  #$0F00, D0
                beq     Offset_0x01C2F0
                move.b  #$3C, $0002(A2)
Offset_0x01C2F0:
                btst    #$0A, D0
                beq.s   Offset_0x01C2FC
                move.w  #$FE00, x_vel(A1)                          ; $0018
Offset_0x01C2FC:
                btst    #$0B, D0
                beq.s   Offset_0x01C308
                move.w  #$0200, x_vel(A1)                          ; $0018
Offset_0x01C308:
                move.w  #$FC80, y_vel(A1)                          ; $001A
                bset    #$01, status(A1)                             ; $002A
                rts
Offset_0x01C316:
                clr.b   Obj_Timer(A1)                                    ; $002E
                clr.b   (A2)
                move.b  #$3C, $0002(A2)
                rts
Offset_0x01C324:
                sub.w   D4, x_pos(A1)                                    ; $0010
                move.w  y_pos(A0), y_pos(A1)                      ; $0014, $0014
                addi.w  #$0024, y_pos(A1)                                ; $0014
                rts
Offset_0x01C336:
                tst.b   $0002(A2)
                beq.s   Offset_0x01C344
                subq.b  #$01, $0002(A2)
                bne     Offset_0x01C3A8
Offset_0x01C344:
                move.w  x_pos(A1), D0                                    ; $0010
                sub.w   x_pos(A0), D0                                    ; $0010
                addi.w  #$001C, D0
                cmpi.w  #$0038, D0
                bcc     Offset_0x01C3A8
                move.w  y_pos(A1), D1                                    ; $0014
                sub.w   y_pos(A0), D1                                    ; $0014
                subi.w  #$0018, D1
                cmpi.w  #$0018, D1
                bcc     Offset_0x01C3A8
                tst.b   Obj_Timer(A1)                                    ; $002E
                bne.s   Offset_0x01C3A8
                cmpi.b  #$04, routine(A1)                            ; $0005
                bcc.s   Offset_0x01C3A8
                tst.w   (Debug_Mode_Flag_Index).w                    ; $FFFFFE08
                bne.s   Offset_0x01C3A8
                clr.w   x_vel(A1)                                  ; $0018
                clr.w   y_vel(A1)                                  ; $001A
                clr.w   inertia(A1)                                  ; $001C
                move.w  y_pos(A0), y_pos(A1)                      ; $0014, $0014
                addi.w  #$0024, y_pos(A1)                                ; $0014
                move.b  #$14, anim(A1)                         ; $0020
                move.b  #$01, Obj_Timer(A1)                              ; $002E
                move.b  #$01, (A2)
Offset_0x01C3A8:
                rts     
;-------------------------------------------------------------------------------
LBz_Platform_Mappings_2:                                       ; Offset_0x01C3AA
                dc.w    Offset_0x01C3AC-LBz_Platform_Mappings_2
Offset_0x01C3AC:
                dc.w    $0002
                dc.w    $080C, $0000, $FFE0
                dc.w    $080C, $0800, $0000                                                                                                                                                                  
;===============================================================================
; Objeto 0x1D - Plataforma não usada em que o jogador pode se aguarrar por baixo
; <<<-          na Launch Base 
;===============================================================================  