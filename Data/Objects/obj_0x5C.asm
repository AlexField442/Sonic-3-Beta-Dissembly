;===============================================================================
; Objeto 0x5C - Base da plataforma em forma de pião giratória na Marble Garden.
; ->>>           
;===============================================================================
; Offset_0x02BED2:
                move.l  #Blue_Spinning_Platform_Mappings, mappings(A0) ; Offset_0x02BEA8, $000C
                move.w  #$43FF, art_tile(A0)                         ; $000A
                ori.b   #$04, render_flags(A0)                              ; $0004
                move.w  #$0200, priority(A0)                         ; $0008
                move.b  #$0C, width_pixels(A0)                              ; $0007
                move.b  #$08, height_pixels(A0)                             ; $0006
                move.b  #$02, mapping_frame(A0)                             ; $0022
                move.w  #$0010, objoff_30(A0)                   ; $0030
                move.w  #$0C00, D0
                btst    #$00, status(A0)                             ; $002A
                beq.s   Offset_0x02BF12
                neg.w   D0
Offset_0x02BF12:
                move.w  D0, x_vel(A0)                              ; $0018
                jsr     (AllocateObjectAfterCurrent)                  ; Offset_0x011DE0
                bne.s   Offset_0x02BF2E
                move.l  #Obj_0x5B_MGz_Blue_Spinning_Platform, (A1) ; Offset_0x02B19A
                move.b  #$01, subtype(A1)                            ; $002C
                move.w  A1, objoff_3E(A0)                       ; $003E
Offset_0x02BF2E:
                move.l  #Offset_0x02BF34, (A0)
Offset_0x02BF34:                
                move.w  objoff_3E(A0), A1                       ; $003E
                move.w  x_pos(A0), x_pos(A1)                      ; $0010, $0010
                move.w  y_pos(A0), y_pos(A1)                      ; $0014, $0014
                addq.w  #$04, anim_frame_duration(A1)                           ; $0024
                cmpi.b  #$04, objoff_40(A1)                     ; $0040
                beq.s   Offset_0x02BF58
                cmpi.b  #$04, objoff_42(A1)                     ; $0042
                bne.s   Offset_0x02BF5E
Offset_0x02BF58:
                move.l  #Offset_0x02BF64, (A0)
Offset_0x02BF5E:
                jmp     (MarkObjGone)                          ; Offset_0x011AF2
;-------------------------------------------------------------------------------
Offset_0x02BF64:
                move.w  objoff_3E(A0), A1                       ; $003E
                addq.w  #$01, y_pos(A0)                                  ; $0014
                subq.w  #$01, objoff_30(A0)                     ; $0030
                bne.s   Offset_0x02BF7E
                move.l  #Offset_0x02BFB8, (A0)
                move.w  #$7F00, x_pos(A0)                                ; $0010
Offset_0x02BF7E:
                cmpi.w  #$0004, objoff_30(A0)                   ; $0030
                beq.s   Offset_0x02BF9A
                bcs.s   Offset_0x02BFB8
                move.w  x_pos(A0), x_pos(A1)                      ; $0010, $0010
                move.w  y_pos(A0), y_pos(A1)                      ; $0014, $0014
                addq.w  #$04, anim_frame_duration(A1)                           ; $0024
                bra.s   Offset_0x02BFB8
Offset_0x02BF9A:
                move.w  x_vel(A0), D1                              ; $0018
                move.w  D1, x_vel(A1)                              ; $0018
                move.w  D1, inertia(A1)                              ; $001C
                move.b  #$01, objoff_34(A1)                     ; $0034
                bclr    #$01, status(A1)                             ; $002A
                move.b  #$00, subtype(A1)                            ; $002C
Offset_0x02BFB8:
                jmp     (MarkObjGone)                          ; Offset_0x011AF2                                                                                                       
;===============================================================================
; Objeto 0x5C - Base da plataforma em forma de pião giratória na Marble Garden.
; <<<-  
;===============================================================================  