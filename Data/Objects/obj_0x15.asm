;===============================================================================
; Objeto 0x15 - Objeto usado para lançar o jogador em alta velocidade na 
; ->>>          Launch Base 
;===============================================================================
Offset_0x01D04C:
                dc.w    $1000, $0A00
;-------------------------------------------------------------------------------                
Obj_0x15_LBz_Player_Launcher:                                  ; Offset_0x01D050
                move.l  #Player_Launcher_Mappings, mappings(A0) ; Offset_0x01D2CA, $000C
                move.w  #$43C3, art_tile(A0)                         ; $000A
                ori.b   #$04, render_flags(A0)                              ; $0004
                move.b  #$20, width_pixels(A0)                              ; $0007
                move.w  #$0080, priority(A0)                         ; $0008
                move.b  subtype(A0), D0                              ; $002C
                andi.w  #$0002, D0
                move.w  Offset_0x01D04C(PC, D0), objoff_34(A0)  ; $0034
                move.l  #Offset_0x01D084, (A0)
Offset_0x01D084:                
                move.w  x_pos(A0), D0                                    ; $0010
                move.w  D0, D1
                subi.w  #$0010, D0
                addi.w  #$0010, D1
                move.w  y_pos(A0), D2                                    ; $0014
                move.w  D2, D3
                subi.w  #$0010, D2
                addi.w  #$0010, D3
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                btst    #$01, status(A1)                             ; $002A
                bne.s   Offset_0x01D0D8
                move.w  x_pos(A1), D4                                    ; $0010
                cmp.w   D0, D4
                bcs     Offset_0x01D0D8
                cmp.w   D1, D4
                bcc     Offset_0x01D0D8
                move.w  y_pos(A1), D4                                    ; $0014
                cmp.w   D2, D4
                bcs     Offset_0x01D0D8
                cmp.w   D3, D4
                bcc     Offset_0x01D0D8
                move.w  D0, -(A7)
                lea     objoff_38(A0), A2                       ; $0038
                bsr     Offset_0x01D112
                move.w  (A7)+, D0
Offset_0x01D0D8:
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                btst    #$01, status(A1)                             ; $002A
                bne.s   Offset_0x01D10C
                move.w  x_pos(A1), D4                                    ; $0010
                cmp.w   D0, D4
                bcs     Offset_0x01D10C
                cmp.w   D1, D4
                bcc     Offset_0x01D10C
                move.w  y_pos(A1), D4                                    ; $0014
                cmp.w   D2, D4
                bcs     Offset_0x01D10C
                cmp.w   D3, D4
                bcc     Offset_0x01D10C
                lea     objoff_3A(A0), A2                       ; $003A
                bsr     Offset_0x01D112
Offset_0x01D10C:
                jmp     (MarkObjGone)                          ; Offset_0x011AF2
Offset_0x01D112:
                tst.w   (A2)
                bne.s   Offset_0x01D140
                move.l  A1, -(A7)
                jsr     (AllocateObjectAfterCurrent)                  ; Offset_0x011DE0
                bne     Offset_0x01D13E
                move.l  #Offset_0x01D1BC, (A1)
                move.w  x_pos(A0), x_pos(A1)                      ; $0010, $0010
                move.w  y_pos(A0), y_pos(A1)                      ; $0014, $0014
                move.b  render_flags(A0), render_flags(A1)              ; $0004, $0004
                move.w  A2, objoff_3C(A1)                       ; $003C
Offset_0x01D13E:
                move.l  (A7)+, A1
Offset_0x01D140:
                addq.w  #$01, (A2)
                cmpi.w  #$0004, (A2)
                beq.s   Offset_0x01D164
                move.w  x_vel(A1), D0                              ; $0018
                btst    #$00, render_flags(A0)                              ; $0004
                beq.s   Offset_0x01D156
                neg.w   D0
Offset_0x01D156:
                tst.w   D0
                bpl.s   Offset_0x01D162
                asr.w   inertia(A1)                                  ; $001C
                asr.w   x_vel(A1)                                  ; $0018
Offset_0x01D162:
                rts
Offset_0x01D164:
                move.w  x_vel(A1), D0                              ; $0018
                btst    #$00, status(A0)                             ; $002A
                beq.s   Offset_0x01D172
                neg.w   D0
Offset_0x01D172:
                cmpi.w  #$1000, D0
                bge.s   Offset_0x01D1B4
                move.w  objoff_34(A0), x_vel(A1)   ; $0034, $0018
                bclr    #$00, status(A1)                             ; $002A
                btst    #$00, status(A0)                             ; $002A
                beq.s   Offset_0x01D196
                bset    #$00, status(A1)                             ; $002A
                neg.w   x_vel(A1)                                  ; $0018
Offset_0x01D196:
                move.w  #$000F, objoff_32(A1)                   ; $0032
                move.w  x_vel(A1), inertia(A1)          ; $0018, $001C
                bclr    #$05, status(A0)                             ; $002A
                bclr    #$06, status(A0)                             ; $002A
                bclr    #$05, status(A1)                             ; $002A
Offset_0x01D1B4:
                moveq   #Spring_Sfx, D0                                   ; -$2E
                jmp     (PlaySound)                           ; Offset_0x001176
;-------------------------------------------------------------------------------
Offset_0x01D1BC:
                move.l  #Player_Launcher_Mappings, mappings(A0) ; Offset_0x01D2CA, $000C
                move.w  #$43C3, art_tile(A0)                         ; $000A
                ori.b   #$04, render_flags(A0)                              ; $0004
                move.b  #$08, width_pixels(A0)                              ; $0007
                move.w  #$0080, priority(A0)                         ; $0008
                move.w  x_pos(A0), objoff_30(A0)         ; $0010, $0030
                addi.w  #$0010, y_pos(A0)                                ; $0014
                move.w  y_pos(A0), objoff_32(A0)         ; $0014, $0032
                move.b  #$01, mapping_frame(A0)                             ; $0022
                move.b  #$80, objoff_40(A0)                     ; $0040
                bset    #$06, render_flags(A0)                              ; $0004
                move.w  #$0004, y_sub(A0)                            ; $0016
                move.l  #Offset_0x01D20C, (A0)
Offset_0x01D20C:                
                move.w  objoff_36(A0), D0                       ; $0036
                move.w  Offset_0x01D222(PC, D0), D1
                jsr     Offset_0x01D222(PC, D1)
                bsr     Offset_0x01D258
                jmp     (MarkObjGone)                          ; Offset_0x011AF2   
;-------------------------------------------------------------------------------
Offset_0x01D222:
                dc.w    Offset_0x01D226-Offset_0x01D222
                dc.w    Offset_0x01D242-Offset_0x01D222    
;-------------------------------------------------------------------------------
Offset_0x01D226:
                addi.b  #$10, objoff_40(A0)                     ; $0040
                cmpi.b  #$D0, objoff_40(A0)                     ; $0040
                bne.s   Offset_0x01D240
                move.w  objoff_3C(A0), A2                       ; $003C
                move.w  #$0000, (A2)
                addq.w  #$02, objoff_36(A0)                     ; $0036
Offset_0x01D240:
                rts   
;-------------------------------------------------------------------------------
Offset_0x01D242:
                subi.b  #$04, objoff_40(A0)                     ; $0040
                cmpi.b  #$80, objoff_40(A0)                     ; $0040
                bne.s   Offset_0x01D256
                move.w  #$7F00, objoff_30(A0)                   ; $0030
Offset_0x01D256:
                rts
Offset_0x01D258:
                move.b  objoff_40(A0), D0                       ; $0040
                btst    #$00, render_flags(A0)                              ; $0004
                beq.s   Offset_0x01D26A
                neg.b   D0
                addi.b  #$80, D0
Offset_0x01D26A:
                jsr     (CalcSine)                             ; Offset_0x001B20
                move.w  objoff_32(A0), D2                       ; $0032
                move.w  objoff_30(A0), D3                       ; $0030
                moveq   #$00, D6
                move.w  y_sub(A0), D6                                ; $0016
                subq.w  #$01, D6
                bcs.s   Offset_0x01D2C8
                swap.w  D0
                swap.w  D1
                asr.l   #$04, D0
                asr.l   #$04, D1
                moveq   #$00, D4
                moveq   #$00, D5
                add.l   D0, D4
                add.l   D1, D5
                lea     x_vel(A0), A2                              ; $0018
Offset_0x01D296:
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
                addq.w  #$01, A2
                move.b  #$01, (A2)+
                dbra    D6, Offset_0x01D296
                swap.w  D4
                swap.w  D5
                add.w   D2, D4
                add.w   D3, D5
                move.w  D5, x_pos(A0)                                    ; $0010
                move.w  D4, y_pos(A0)                                    ; $0014
Offset_0x01D2C8:
                rts    
;-------------------------------------------------------------------------------
Player_Launcher_Mappings:                                      ; Offset_0x01D2CA
                dc.w    Offset_0x01D2CE-Player_Launcher_Mappings
                dc.w    Offset_0x01D2E2-Player_Launcher_Mappings
Offset_0x01D2CE:
                dc.w    $0003
                dc.w    $F805, $0014, $FFE0
                dc.w    $F80D, $0018, $FFF0
                dc.w    $F805, $0814, $0010
Offset_0x01D2E2:
                dc.w    $0001
                dc.w    $F805, $0020, $FFF8                                                                                                                                                                              
;===============================================================================
; Objeto 0x15 - Objeto usado para lançar o jogador em alta velocidade na 
; <<<-          Launch Base 
;===============================================================================  