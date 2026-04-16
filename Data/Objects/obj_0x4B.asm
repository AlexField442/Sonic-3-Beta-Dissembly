;===============================================================================
; Objeto 0x4B - Molas triangulares na Carnival Night
; ->>>           
;===============================================================================
; Offset_0x028D2E:
                moveq   #$00, D0
                move.b  subtype(A0), D0                              ; $002C
                move.w  D0, objoff_34(A0)                       ; $0034
                add.w   D0, D0
                move.w  D0, objoff_32(A0)                       ; $0032
                move.l  #Offset_0x028D44, (A0)
Offset_0x028D44:                
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                bsr.s   Offset_0x028D56
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                bsr.s   Offset_0x028D56
                jmp     (MarkObjGone_3)                        ; Offset_0x011B3E
Offset_0x028D56:
                move.w  x_pos(A1), D0                                    ; $0010
                sub.w   x_pos(A0), D0                                    ; $0010
                add.w   objoff_34(A0), D0                       ; $0034
                cmp.w   objoff_32(A0), D0                       ; $0032
                bcc.s   Offset_0x028D82
                move.w  y_pos(A1), D1                                    ; $0014
                sub.w   y_pos(A0), D1                                    ; $0014
                addi.w  #$0014, D1
                cmpi.w  #$0028, D1
                bcc.s   Offset_0x028D82
                cmpi.b  #$04, routine(A1)                            ; $0005
                bcs.s   Offset_0x028D84
Offset_0x028D82:
                rts
Offset_0x028D84:
                move.w  #$F800, x_vel(A1)                          ; $0018
                move.w  #$F800, y_vel(A1)                          ; $001A
                bset    #$00, status(A1)                             ; $002A
                btst    #$00, status(A0)                             ; $002A
                bne.s   Offset_0x028DA8
                bclr    #$00, status(A1)                             ; $002A
                neg.w   x_vel(A1)                                  ; $0018
Offset_0x028DA8:
                btst    #$01, status(A0)                             ; $002A
                beq.s   Offset_0x028DB4
                neg.w   y_vel(A1)                                  ; $001A
Offset_0x028DB4:
                move.w  #$000F, objoff_32(A1)                   ; $0032
                move.w  x_vel(A1), inertia(A1)          ; $0018, $001C
                btst    #$02, status(A1)                             ; $002A
                bne.s   Offset_0x028DCE
                move.b  #$00, anim(A1)                         ; $0020
Offset_0x028DCE:
                tst.b   flip_angle(A1)                               ; $0027
                bne.s   Offset_0x028DF8
                move.b  #$01, flip_angle(A1)                         ; $0027
                move.b  #$00, anim(A1)                         ; $0020
                move.b  #$03, objoff_30(A1)                     ; $0030
                move.b  #$08, objoff_31(A1)                     ; $0031
                btst    #$00, status(A1)                             ; $002A
                beq.s   Offset_0x028DF8
                neg.b   flip_angle(A1)                               ; $0027
Offset_0x028DF8:
                clr.b   objoff_40(A1)                           ; $0040
                bset    #$01, status(A1)                             ; $002A
                bclr    #$05, status(A1)                             ; $002A
                move.w  #S2_Spring_Sfx, D0                               ; $00CC
                jmp     (PlaySound)                           ; Offset_0x001176
;===============================================================================
; Objeto 0x4B - Molas triangulares na Carnival Night
; <<<-  
;===============================================================================  