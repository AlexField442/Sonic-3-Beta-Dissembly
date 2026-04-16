;=============================================================================== 
; Objeto 0x4B - Anel gigante usado no Sonic 1 para acesso ao Special Stage 
; ->>>          não usado (Left over)
;===============================================================================  
; Offset_0x010C60:
                moveq   #$00, D0
                move.b  routine(A0), D0                              ; $0005
                move.w  Offset_0x010C6E(PC, D0), D1
                jmp     Offset_0x010C6E(PC, D1)
;-------------------------------------------------------------------------------
Offset_0x010C6E:
                dc.w    Offset_0x010C76-Offset_0x010C6E
                dc.w    Offset_0x010CC0-Offset_0x010C6E
                dc.w    Offset_0x010CDE-Offset_0x010C6E
                dc.w    Offset_0x010D22-Offset_0x010C6E    
;-------------------------------------------------------------------------------
Offset_0x010C76:
                move.l  #Big_Ring_Mappings, mappings(A0) ; Offset_0x010E36, $000C
                move.w  #$2400, art_tile(A0)                         ; $000A
                ori.b   #$04, render_flags(A0)                              ; $0004
                move.b  #$40, width_pixels(A0)                              ; $0007
                tst.b   render_flags(A0)                                    ; $0004
                bpl.s   Offset_0x010CC0
                cmpi.b  #$06, (SS_Completed_Flag).w                  ; $FFFFFFB0
                beq     Offset_0x010D22
                cmpi.w  #$0032, (Ring_count).w               ; $FFFFFE20
                bcc.s   Offset_0x010CAA
                rts
Offset_0x010CAA:
                addq.b  #$02, routine(A0)                            ; $0005
                move.w  #$0100, priority(A0)                         ; $0008
                move.b  #$52, collision_flags(A0)                          ; $0028
                move.w  #$0C40, (S1_Load_Big_Ring_Art_Flag).w        ; $FFFFF7BE
;-------------------------------------------------------------------------------                
Offset_0x010CC0:
                move.b  (Object_Frame_Buffer).w, mapping_frame(A0) ; $FFFFFEA3, $0022
                move.w  x_pos(A0), D0                                    ; $0010
                andi.w  #$FF80, D0
                sub.w   (Camera_X_Left).w, D0                        ; $FFFFF7DA
                cmpi.w  #$0280, D0
                bhi     DeleteObject                           ; Offset_0x011138
                bra     DisplaySprite                          ; Offset_0x011148
;------------------------------------------------------------------------------- 
Offset_0x010CDE:
                subq.b  #$02, routine(A0)                            ; $0005
                move.b  #$00, collision_flags(A0)                          ; $0028
                bsr     AllocateObject                       ; Offset_0x011DD8
                bne     Offset_0x010D16
                move.l  #Obj_S1_0x7C_Big_Ring_Flash, (A1)      ; Offset_0x010D26
                move.w  x_pos(A0), x_pos(A1)                      ; $0010, $0010
                move.w  y_pos(A0), y_pos(A1)                      ; $0014, $0014
                move.l  A0, objoff_40(A1)                       ; $0040
                move.w  (Obj_Player_One+x_pos).w, D0                 ; $FFFFB010
                cmp.w   x_pos(A0), D0                                    ; $0010
                bcs.s   Offset_0x010D16
                bset    #$00, render_flags(A1)                              ; $0004
Offset_0x010D16:
                move.w  #S2_Enter_Big_Ring_Sfx, D0                       ; $0032      
                jsr     (PlaySound)                           ; Offset_0x001176
                bra.s   Offset_0x010CC0
Offset_0x010D22:
                bra     DeleteObject                           ; Offset_0x011138 
;=============================================================================== 
; Objeto 0x4B - Anel gigante usado no Sonic 1 para acesso ao Special Stage   
; <<<-          não usado (Left over)
;===============================================================================   