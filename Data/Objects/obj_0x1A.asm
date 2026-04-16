;===============================================================================
; Objeto 0x1A - Objeto desconhecido que pode ser girado usando o 2º controle
; ->>>           
;===============================================================================
; Offset_0x01DFCE:
                move.l  #Unknow_Controled_By_P2_Mappings, mappings(A0) ; Offset_0x01E2AC, $000C
                move.w  #$43C3, art_tile(A0)                         ; $000A
                ori.b   #$04, render_flags(A0)                              ; $0004
                move.b  #$40, width_pixels(A0)                              ; $0007
                move.b  #$40, height_pixels(A0)                             ; $0006
                move.w  #$0200, priority(A0)                         ; $0008
                move.b  #$80, objoff_42(A0)                     ; $0042
                move.b  #$01, mapping_frame(A0)                             ; $0022
                jsr     (AllocateObjectAfterCurrent)                  ; Offset_0x011DE0
                bne     Offset_0x01E058
                move.l  #Offset_0x01E0A8, (A1)
                move.l  #Unknow_Controled_By_P2_Mappings, mappings(A1) ; Offset_0x01E2AC, $000C
                move.w  #$43C3, art_tile(A1)                         ; $000A
                ori.b   #$04, render_flags(A1)                              ; $0004
                move.b  #$40, width_pixels(A1)                              ; $0007
                move.b  #$40, height_pixels(A1)                             ; $0006
                move.w  #$0200, priority(A1)                         ; $0008
                move.w  x_pos(A0), x_pos(A1)                      ; $0010, $0010
                move.w  y_pos(A0), y_pos(A1)                      ; $0014, $0014
                move.b  #$80, objoff_42(A1)                     ; $0042
                bset    #$06, render_flags(A1)                              ; $0004
                move.w  #$0006, y_sub(A1)                            ; $0016
                move.w  A0, objoff_3C(A1)                       ; $003C
Offset_0x01E058:
                move.b  #$10, objoff_42(A0)                     ; $0042
                move.l  #Offset_0x01E064, (A0)
Offset_0x01E064:                
                btst    #$04, (Control_Ports_Buffer_Data+$02).w      ; $FFFFF606
                beq.s   Offset_0x01E072
                move.b  #$00, objoff_42(A0)                     ; $0042
Offset_0x01E072:
                btst    #$05, (Control_Ports_Buffer_Data+$02).w      ; $FFFFF606
                beq.s   Offset_0x01E080
                addi.b  #$01, objoff_42(A0)                     ; $0042
Offset_0x01E080:
                btst    #$06, (Control_Ports_Buffer_Data+$02).w      ; $FFFFF606
                beq.s   Offset_0x01E08E
                subi.b  #$01, objoff_42(A0)                     ; $0042
Offset_0x01E08E:
                moveq   #$00, D1
                move.b  width_pixels(A0), D1                                ; $0007
                moveq   #$08, D2
                move.w  D2, D3
                addq.w  #$01, D3
                move.w  x_pos(A0), D4                                    ; $0010
                bsr     Offset_0x01E138
                jmp     (MarkObjGone)                          ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x01E0A8:
                move.w  objoff_3C(A0), A1                       ; $003C
                move.b  objoff_42(A1), objoff_42(A0) ; $0042, $0042
                bsr     Offset_0x01E0BC
                jmp     (MarkObjGone)                          ; Offset_0x011AF2
Offset_0x01E0BC:
                move.b  objoff_42(A0), D0                       ; $0042
                jsr     (CalcSine)                             ; Offset_0x001B20
                move.w  y_pos(A0), D2                                    ; $0014
                move.w  x_pos(A0), D3                                    ; $0010
                swap.w  D0
                swap.w  D1
                asr.l   #$05, D0
                asr.l   #$05, D1
                move.l  D0, D4
                move.l  D1, D5
                add.l   D0, D0
                add.l   D1, D1
                movem.l D0-D5, -(A7)
                add.l   D0, D4
                add.l   D1, D5
                lea     x_vel(A0), A2                              ; $0018
                moveq   #$02, D6
Offset_0x01E0EC:
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
                dbra    D6, Offset_0x01E0EC
                movem.l (A7)+, D0-D5
                neg.l   D4
                neg.l   D5
                sub.l   D0, D4
                sub.l   D1, D5
                moveq   #$02, D6
Offset_0x01E118:
                movem.l D4/D5, -(A7)
                swap.w  D4
                swap.w  D5
                add.w   D2, D4
                add.w   D3, D5
                move.w  D5, (A2)+
                move.w  D4, (A2)+
                movem.l (A7)+, D4/D5
                sub.l   D0, D4
                sub.l   D1, D5
                addq.w  #$02, A2
                dbra    D6, Offset_0x01E118
                rts
Offset_0x01E138:
                lea     (Interrupt_0C).w, A2                   ; Offset_0x000030
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                moveq   #$03, D6
                movem.l D1-D3, -(A7)
                bsr.s   Offset_0x01E156
                movem.l (A7)+, D1-D3
                lea     (Interrupt_0D).w, A2                   ; Offset_0x000034
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                addq.b  #$01, D6
Offset_0x01E156:
                btst    D6, status(A0)                               ; $002A
                beq     Offset_0x01E214
                move.w  inertia(A1), D0                              ; $001C
                move.b  objoff_42(A0), D4                       ; $0042
                addi.b  #$40, D4
                bpl.s   Offset_0x01E16E
                neg.w   D0
Offset_0x01E16E:
                add.w   D0, (A2)
                btst    #$01, status(A1)                             ; $002A
                bne.s   Offset_0x01E19C
                move.b  objoff_42(A0), D0                       ; $0042
                jsr     (CalcSine)                             ; Offset_0x001B20
                tst.w   D1
                bmi.s   Offset_0x01E188
                neg.w   D1
Offset_0x01E188:
                asr.w   #$02, D1
                move.w  x_pos(A1), D0                                    ; $0010
                sub.w   x_pos(A0), D0                                    ; $0010
                cmp.w   D1, D0
                blt.s   Offset_0x01E19C
                neg.w   D1
                cmp.w   D1, D0
                blt.s   Offset_0x01E1B0
Offset_0x01E19C:
                bclr    #$03, status(A1)                             ; $002A
                bset    #$01, status(A1)                             ; $002A
                bclr    D6, status(A0)                               ; $002A
                moveq   #$00, D4
                rts
Offset_0x01E1B0:
                bsr     Offset_0x01E1B8
                moveq   #$00, D4
                rts
Offset_0x01E1B8:
                move.w  D3, D5
                move.b  objoff_42(A0), D0                       ; $0042
                jsr     (CalcSine)                             ; Offset_0x001B20
                move.w  y_pos(A0), D2                                    ; $0014
                move.w  x_pos(A0), D3                                    ; $0010
                move.w  (A2), D4
                muls.w  D4, D0
                muls.w  D4, D1
                swap.w  D0
                swap.w  D1
                add.w   D0, D2
                add.w   D1, D3
                move.b  objoff_42(A0), D0                       ; $0042
                move.b  D0, D1
                addi.b  #$40, D1
                bpl.s   Offset_0x01E1EA
                addi.b  #$80, D0
Offset_0x01E1EA:
                move.b  D0, angle(A1)                                ; $0026
                moveq   #$00, D1
                move.b  y_radius(A1), D1                             ; $001E
                add.w   D1, D5
                lsl.w   #$08, D5
                jsr     (CalcSine)                             ; Offset_0x001B20
                muls.w  D5, D0
                muls.w  D5, D1
                swap.w  D0
                swap.w  D1
                add.w   D0, D3
                sub.w   D1, D2
                move.w  D2, y_pos(A1)                                    ; $0014
                move.w  D3, x_pos(A1)                                    ; $0010
                rts
Offset_0x01E214:
                tst.w   y_vel(A1)                                  ; $001A
                bmi     Offset_0x01E2AA
                move.b  objoff_42(A0), D0                       ; $0042
                jsr     (CalcSine)                             ; Offset_0x001B20
                move.w  D0, D4
                move.w  D1, D2
                tst.w   D1
                bmi.s   Offset_0x01E230
                neg.w   D1
Offset_0x01E230:
                asr.w   #$02, D1
                move.w  x_pos(A1), D0                                    ; $0010
                sub.w   x_pos(A0), D0                                    ; $0010
                cmp.w   D1, D0
                blt.s   Offset_0x01E2AA
                neg.w   D1
                cmp.w   D1, D0
                bge.s   Offset_0x01E2AA
                swap.w  D0
                divs.w  D2, D0
                move.w  D0, (A2)
                neg.w   D4
                muls.w  D4, D0
                swap.w  D0
                move.w  D3, D5
                add.w   D0, D3
                move.w  y_pos(A0), D0                                    ; $0014
                sub.w   D3, D0
                move.w  y_pos(A1), D2                                    ; $0014
                move.b  y_radius(A1), D1                             ; $001E
                ext.w   D1
                add.w   D2, D1
                addq.w  #$04, D1
                sub.w   D1, D0
                bhi.s   Offset_0x01E2AA
                cmpi.w  #$FFF0, D0
                bcs.s   Offset_0x01E2AA
                tst.b   objoff_2E(A1)                                    ; $002E
                bmi.s   Offset_0x01E2AA
                cmpi.b  #$06, routine(A1)                            ; $0005
                bcc.s   Offset_0x01E2AA
                move.b  objoff_42(A0), D0                       ; $0042
                move.b  D0, D1
                addi.b  #$40, D1
                bpl.s   Offset_0x01E290
                addi.b  #$80, D0
Offset_0x01E290:
                jsr     (CalcSine)                             ; Offset_0x001B20
                muls.w  #$1B00, D0
                swap.w  D0
                sub.w   D0, (A2)
                move.w  D5, D3
                bsr     Offset_0x01E1B8
                jmp     (Ride_Object_Set_Ride)                 ; Offset_0x013C80
Offset_0x01E2AA:
                rts      
;-------------------------------------------------------------------------------
Unknow_Controled_By_P2_Mappings:                               ; Offset_0x01E2AC
                dc.w    Offset_0x01E2B0-Unknow_Controled_By_P2_Mappings
                dc.w    Offset_0x01E2B8-Unknow_Controled_By_P2_Mappings
Offset_0x01E2B0:
                dc.w    $0001
                dc.w    $F805, $0037, $FFF8
Offset_0x01E2B8:
                dc.w    $0002
                dc.w    $F007, $002F, $FFF0
                dc.w    $F007, $082F, $0000                                                                                                                                                                 
;===============================================================================
; Objeto 0x1A - Objeto desconhecido que pode ser girado usando o 2º controle
; <<<-  
;===============================================================================  