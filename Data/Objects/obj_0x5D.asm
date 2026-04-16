;===============================================================================
; Objeto 0x5D - Molas triangulares na Chrome Gadget
; ->>>           
;===============================================================================
; Offset_0x029004:
                move.b  #$08, width_pixels(A0)                              ; $0007
                move.b  #$40, height_pixels(A0)                             ; $0006
                move.b  subtype(A0), D0                              ; $002C
                lsr.b   #$04, D0
                andi.b  #$07, D0
                move.b  D0, mapping_frame(A0)                               ; $0022
                beq.s   Offset_0x029026
                move.b  #$80, height_pixels(A0)                             ; $0006
Offset_0x029026:
                move.l  #Offset_0x02902C, (A0)
Offset_0x02902C:                
                move.w  #$0010, D1
                moveq   #$00, D2
                move.b  height_pixels(A0), D2                               ; $0006
                move.w  D2, D3
                addq.w  #$01, D3
                move.w  x_pos(A0), D4                                    ; $0010
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                moveq   #$03, D6
                movem.l D1-D4, -(A7)
                jsr     (Solid_Object_2_A1)                    ; Offset_0x0135CC
                cmpi.b  #$01, D4
                bne.s   Offset_0x029076
                btst    #$01, status(A1)                             ; $002A
                beq.s   Offset_0x029076
                move.b  status(A0), D1                               ; $002A
                move.w  x_pos(A0), D0                                    ; $0010
                sub.w   x_pos(A1), D0                                    ; $0010
                bcs.s   Offset_0x02906E
                eori.b  #$01, D1
Offset_0x02906E:
                andi.b  #$01, D1
                bne.s   Offset_0x029076
                bsr.s   Offset_0x0290B0
Offset_0x029076:
                movem.l (A7)+, D1-D4
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                moveq   #$04, D6
                jsr     (Solid_Object_2_A1)                    ; Offset_0x0135CC
                cmpi.b  #$01, D4
                bne.s   Offset_0x0290AE
                btst    #$01, status(A1)                             ; $002A
                beq.s   Offset_0x0290AE
                move.b  status(A0), D1                               ; $002A
                move.w  x_pos(A0), D0                                    ; $0010
                sub.w   x_pos(A1), D0                                    ; $0010
                bcs.s   Offset_0x0290A6
                eori.b  #$01, D1
Offset_0x0290A6:
                andi.b  #$01, D1
                bne.s   Offset_0x0290AE
                bsr.s   Offset_0x0290B0
Offset_0x0290AE:
                rts
Offset_0x0290B0:
                cmpi.b  #$04, routine(A1)                            ; $0005
                bcs.s   Offset_0x0290BA
                rts
Offset_0x0290BA:
                move.w  #$F800, x_vel(A1)                          ; $0018
                move.w  #$0400, y_vel(A1)                          ; $001A
                bset    #$00, status(A1)                             ; $002A
                btst    #$00, status(A0)                             ; $002A
                bne.s   Offset_0x0290DE
                bclr    #$00, status(A1)                             ; $002A
                neg.w   x_vel(A1)                                  ; $0018
Offset_0x0290DE:
                move.w  #$000F, move_lock(A1)                ; $0032
                move.w  x_vel(A1), inertia(A1)          ; $0018, $001C
                btst    #$02, status(A1)                             ; $002A
                bne.s   Offset_0x0290F8
                move.b  #$00, anim(A1)                         ; $0020
Offset_0x0290F8:
                move.b  subtype(A0), D0                              ; $002C
                bpl.s   Offset_0x029104
                move.w  #$0000, y_vel(A1)                          ; $001A
Offset_0x029104:
                btst    #$00, D0
                beq.s   Offset_0x029144
                move.w  #$0001, inertia(A1)                          ; $001C
                move.b  #$01, flip_angle(A1)                         ; $0027
                move.b  #$00, anim(A1)                         ; $0020
                move.b  #$01, flips_remaining(A1)                  ; $0030
                move.b  #$08, flip_speed(A1)                  ; $0031
                btst    #$01, D0
                bne.s   Offset_0x029134
                move.b  #$03, flips_remaining(A1)                  ; $0030
Offset_0x029134:
                btst    #$00, status(A1)                             ; $002A
                beq.s   Offset_0x029144
                neg.b   flip_angle(A1)                               ; $0027
                neg.w   inertia(A1)                                  ; $001C
Offset_0x029144:
                andi.b  #$0C, D0
                cmpi.b  #$04, D0
                bne.s   Offset_0x02915A
                move.b  #$0C, top_solid_bit(A1)                   ; $0046
                move.b  #$0D, lrb_solid_bit(A1)                   ; $0047
Offset_0x02915A:
                cmpi.b  #$08, D0
                bne.s   Offset_0x02916C
                move.b  #$0E, top_solid_bit(A1)                   ; $0046
                move.b  #$0F, lrb_solid_bit(A1)                   ; $0047
Offset_0x02916C:
                bclr    #$05, status(A0)                             ; $002A
                bclr    #$06, status(A0)                             ; $002A
                bclr    #$05, status(A1)                             ; $002A
                move.w  #Small_Bumper_Sfx, D0                            ; $FF8B
                jmp     (Play_Music)                           ; Offset_0x001176             
;===============================================================================
; Objeto 0x5D - Molas triangulares na Chrome Gadget
; <<<-  
;===============================================================================  