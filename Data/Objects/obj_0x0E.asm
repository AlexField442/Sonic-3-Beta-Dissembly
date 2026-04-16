;===============================================================================
; Objeto 0x0E - Objeto para fazer o jogador girar ao final das rampas na AIz
; ->>>  
;===============================================================================  
; Offset_0x01BC3A:
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                bsr.s   Offset_0x01BC6C
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                bsr.s   Offset_0x01BC6C
                move.w  x_pos(A0), D0                                    ; $0010
                andi.w  #$FF80, D0
                sub.w   (Camera_X_Left).w, D0                        ; $FFFFF7DA
                cmpi.w  #$0280, D0
                bhi.s   Offset_0x01BC5A
                rts
Offset_0x01BC5A:
                move.w  respawn_index(A0), D0                           ; $0048
                beq.s   Offset_0x01BC66
                move.w  D0, A2
                bclr    #$07, (A2)
Offset_0x01BC66:
                jmp     (DeleteObject)                         ; Offset_0x011138
Offset_0x01BC6C:
                btst    #$01, status(A1)                             ; $002A
                bne     Offset_0x01BCF2
                move.w  x_pos(A1), D0                                    ; $0010
                addi.w  #$0010, D0
                sub.w   x_pos(A0), D0                                    ; $0010
                bcs.s   Offset_0x01BCF2
                cmpi.w  #$0020, D0
                bge.s   Offset_0x01BCF2
                move.w  y_pos(A1), D0                                    ; $0014
                sub.w   y_pos(A0), D0                                    ; $0014
                cmpi.w  #$FFEC, D0
                blt.s   Offset_0x01BCF2
                cmpi.w  #$0020, D0
                bgt.s   Offset_0x01BCF2
                cmpi.w  #$0400, x_vel(A1)                          ; $0018
                blt.s   Offset_0x01BCF2
                tst.b   obj_control(A1)                           ; $002E
                bne.s   Offset_0x01BCF2
                move.w  #$F900, y_vel(A1)                          ; $001A
                addi.w  #$0400, x_vel(A1)                          ; $0018
                bset    #$01, status(A1)                             ; $002A
                move.b  #$02, routine(A1)                            ; $0005
                move.w  #$0001, inertia(A1)                          ; $001C
                move.b  #$01, flip_angle(A1)                         ; $0027
                move.b  #$00, anim(A1)                         ; $0020
                move.b  #$00, flips_remaining(A1)                  ; $0030
                move.b  #$04, flip_speed(A1)                  ; $0031
                btst    #$00, status(A1)                             ; $002A
                beq.s   Offset_0x01BCF2
                neg.b   flip_angle(A1)                               ; $0027
                neg.w   inertia(A1)                                  ; $001C
Offset_0x01BCF2:
                rts                                                                                                                                                                                    
;===============================================================================
; Objeto 0x0E - Objeto para fazer o jogador girar ao final das rampas na AIz
; <<<-  
;===============================================================================  