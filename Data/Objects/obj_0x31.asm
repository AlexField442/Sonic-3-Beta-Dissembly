;===============================================================================
; Objeto 0x31 - Atributo dos cilindros giratórios horizontais na Launch Base
; ->>>       
;===============================================================================
; Offset_0x02350C:
                moveq   #$00, D0
                move.b  subtype(A0), D0                              ; $002C
                move.w  D0, objoff_32(A0)                       ; $0032
                neg.w   D0
                move.w  D0, objoff_30(A0)                       ; $0030
                move.b  #$80, width_pixels(A0)                              ; $0007
                move.l  #Offset_0x023528, (A0)
Offset_0x023528:                
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                lea     (Sonic_LBz_Cylinder_Angle).w, A2             ; $FFFFF7B2
                moveq   #$03, D6
                bsr.s   Offset_0x023546
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                lea     (Miles_LBz_Cylinder_Angle).w, A2             ; $FFFFF7B3
                addq.b  #$01, D6
                bsr.s   Offset_0x023546
                jmp     (MarkObjGone_3)                        ; Offset_0x011B3E
Offset_0x023546:
                btst    D6, status(A0)                               ; $002A
                bne     Offset_0x0235BC
                move.w  x_pos(A1), D0                                    ; $0010
                sub.w   x_pos(A0), D0                                    ; $0010
                cmp.w   objoff_30(A0), D0                       ; $0030
                blt.s   Offset_0x0235BA
                cmp.w   objoff_32(A0), D0                       ; $0032
                bge.s   Offset_0x0235BA
                move.w  y_pos(A1), D0                                    ; $0014
                sub.w   y_pos(A0), D0                                    ; $0014
                addi.w  #$0053, D0
                cmpi.w  #$00A6, D0
                bcc.s   Offset_0x0235BA
                cmpi.w  #$0093, D0
                bcc.s   Offset_0x023580
                tst.w   y_vel(A1)                                  ; $001A
                bmi.s   Offset_0x0235BA
Offset_0x023580:
                cmpi.b  #$06, routine(A1)                            ; $0005
                bcc.s   Offset_0x0235BA
                tst.w   (Debug_Mode_Flag_Index).w                    ; $FFFFFE08
                bne.s   Offset_0x0235BA
                cmpi.w  #$0008, D0
                bcc.s   Offset_0x023598
                move.b  #$81, (A2)
Offset_0x023598:
                cmpi.w  #$009E, D0
                bcs.s   Offset_0x0235A2
                move.b  #$01, (A2)
Offset_0x0235A2:
                jsr     (Ride_Object_Set_Ride)                 ; Offset_0x013C80
                move.w  #$0001, anim(A1)                       ; $0020
                tst.w   inertia(A1)                                  ; $001C
                bne.s   Offset_0x0235BA
                move.w  #$0001, inertia(A1)                          ; $001C
Offset_0x0235BA:
                rts
Offset_0x0235BC:
                btst    #$01, status(A1)                             ; $002A
                bne.s   Offset_0x0235D8
                move.w  x_pos(A1), D0                                    ; $0010
                sub.w   x_pos(A0), D0                                    ; $0010
                cmp.w   objoff_30(A0), D0                       ; $0030
                blt.s   Offset_0x0235D8
                cmp.w   objoff_32(A0), D0                       ; $0032
                blt.s   Offset_0x023610
Offset_0x0235D8:
                bclr    #$03, status(A1)                             ; $002A
                bclr    D6, status(A0)                               ; $002A
                move.b  #$00, subtype(A1)                            ; $002C
                move.b  #$04, objoff_2D(A1)                            ; $002D
                bset    #$01, status(A1)                             ; $002A
                rts   
;-------------------------------------------------------------------------------
; Offset_0x0235F6:
                move.b  (A2), D0
                addi.b  #$20, D0
                cmpi.b  #$40, D0
                bcc.s   Offset_0x023608
                asr.w   y_vel(A1)                                  ; $001A
                bra.s   Offset_0x0235D8
Offset_0x023608:
                move.w  #$0000, y_vel(A1)                          ; $001A
                bra.s   Offset_0x0235D8
Offset_0x023610:
                btst    #$03, status(A1)                             ; $002A
                beq.s   Offset_0x0235BA
                move.b  (A2), D0
                jsr     (CalcSine)                             ; Offset_0x001B20
                moveq   #$00, D2
                move.b  y_radius(A1), D2                             ; $001E
                lsl.w   #$08, D2
                addi.w  #$4000, D2
                muls.w  D2, D1
                swap.w  D1
                add.w   y_pos(A0), D1                                    ; $0014
                move.w  D1, y_pos(A1)                                    ; $0014
                move.b  (A2), D0
                addi.b  #$80, D0
                move.b  D0, flip_angle(A1)                           ; $0027
                addq.b  #$02, (A2)
                tst.w   inertia(A1)                                  ; $001C
                bne.s   Offset_0x023650
                move.w  #$0001, inertia(A1)                          ; $001C
Offset_0x023650:
                bset    #$07, art_tile(A1)                           ; $000A
                tst.b   D0
                bpl.s   Offset_0x023660
                bclr    #$07, art_tile(A1)                           ; $000A
Offset_0x023660:
                rts                                                                            
;===============================================================================
; Objeto 0x31 - Atributo dos cilindros giratórios horizontais na Launch Base
; <<<-
;===============================================================================  