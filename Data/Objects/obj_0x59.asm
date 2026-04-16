;===============================================================================
; Objeto 0x59 - Roda azul ativada através de "Spindash" na Marble Garden.
; ->>>           
;===============================================================================
; Offset_0x01C930:
                move.l  #Dash_Trigger_Mappings, mappings(A0) ; Offset_0x01CB06,$000C
                move.w  #$235F, art_tile(A0)                         ; $000A
                ori.b   #$04, render_flags(A0)                              ; $0004
                move.b  #$10, width_pixels(A0)                              ; $0007
                move.b  #$10, height_pixels(A0)                             ; $0006
                move.w  #$0280, priority(A0)                         ; $0008
                bset    #$06, render_flags(A0)                              ; $0004
                move.w  #$0001, y_sub(A0)                            ; $0016
                lea     x_vel(A0), A2                              ; $0018
                move.w  x_pos(A0), (A2)+                                 ; $0010
                move.w  y_pos(A0), (A2)+                                 ; $0014
                move.w  #$0000, (A2)+
                move.l  #Offset_0x01C978, (A0)
Offset_0x01C978:                
                move.w  #$001B, D1
                move.w  #$0010, D2
                move.w  x_pos(A0), D4                                    ; $0010
                lea     (Offset_0x01CAEA), A2
                jsr     (Solid_Object_3)                       ; Offset_0x01360E
                swap.w  D6
                andi.w  #$0033, D6
                beq.s   Offset_0x01C9FE
                move.b  D6, D0
                andi.b  #$11, D0
                beq.s   Offset_0x01C9CC
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                cmpi.b  #$09, anim(A1)                         ; $0020
                bne.s   Offset_0x01C9CC
                move.w  #$003C, objoff_30(A0)                   ; $0030
                move.b  #$01, objoff_32(A0)                     ; $0032
                move.b  status(A1), D0                               ; $002A
                add.b   status(A0), D0                               ; $002A
                andi.b  #$01, D0
                bne.s   Offset_0x01C9CC
                move.b  #$FF, objoff_32(A0)                     ; $0032
Offset_0x01C9CC:
                andi.b  #$22, D6
                beq.s   Offset_0x01C9FE
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                cmpi.b  #$09, anim(A1)                         ; $0020
                bne.s   Offset_0x01C9FE
                move.w  #$003C, objoff_30(A0)                   ; $0030
                move.b  #$01, objoff_32(A0)                     ; $0032
                move.b  status(A1), D0                               ; $002A
                add.b   status(A0), D0                               ; $002A
                andi.b  #$01, D0
                bne.s   Offset_0x01C9FE
                move.b  #$FF, objoff_32(A0)                     ; $0032
Offset_0x01C9FE:
                tst.w   objoff_30(A0)                           ; $0030
                beq.s   Offset_0x01CA7C
                move.b  subtype(A0), D0                              ; $002C
                andi.w  #$000F, D0
                lea     (Level_Trigger_Array).w, A3                  ; $FFFFF7E0
                lea     $00(A3, D0), A3
                subq.w  #$01, objoff_30(A0)                     ; $0030
                bne.s   Offset_0x01CA26
                move.b  #$00, (A3)
                move.b  #$00, mapping_frame(A0)                             ; $0022
                bra.s   Offset_0x01CA7C
Offset_0x01CA26:
                move.b  #$01, (A3)
                move.b  status(A0), D6                               ; $002A
                andi.w  #$0018, D6
                beq.s   Offset_0x01CA4E
                move.w  D6, D0
                andi.w  #$0008, D0
                beq.s   Offset_0x01CA42
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                bsr.s   Offset_0x01CA82
Offset_0x01CA42:
                andi.w  #$0010, D6
                beq.s   Offset_0x01CA4E
                lea     (Obj_Player_Two).w, A1                       ; $FFFFB04A
                bsr.s   Offset_0x01CA82
Offset_0x01CA4E:
                subq.b  #$01, anim_frame_duration(A0)                           ; $0024
                bpl.s   Offset_0x01CA68
                move.b  #$01, anim_frame_duration(A0)                           ; $0024
                move.b  objoff_32(A0), D0                       ; $0032
                add.b   D0, $001D(A0)
                andi.b  #$03, $001D(A0)
Offset_0x01CA68:
                tst.b   mapping_frame(A0)                                   ; $0022
                beq.s   Offset_0x01CA76
                move.b  #$00, mapping_frame(A0)                             ; $0022
                bra.s   Offset_0x01CA7C
Offset_0x01CA76:
                move.b  #$04, mapping_frame(A0)                             ; $0022
Offset_0x01CA7C:
                jmp     (MarkObjGone)                          ; Offset_0x011AF2
Offset_0x01CA82:
                move.w  x_pos(A0), D1                                    ; $0010
                subi.w  #$0010, D1
                btst    #$00, status(A0)                             ; $002A
                beq.s   Offset_0x01CA96
                addi.w  #$0020, D1
Offset_0x01CA96:
                move.w  y_pos(A0), D2                                    ; $0014
                addi.w  #$0010, D2
                sub.w   x_pos(A1), D1                                    ; $0010
                sub.w   y_pos(A1), D2                                    ; $0014
                jsr     (CalcAngle)                            ; Offset_0x001DB8
                jsr     (CalcSine)                             ; Offset_0x001B20
                muls.w  #$F900, D1
                asr.l   #$08, D1
                move.w  D1, x_vel(A1)                              ; $0018
                muls.w  #$F900, D0
                asr.l   #$08, D0
                move.w  D0, y_vel(A1)                              ; $001A
                bset    #$01, status(A1)                             ; $002A
                bclr    #$04, status(A1)                             ; $002A
                bclr    #$05, status(A1)                             ; $002A
                clr.b   objoff_40(A1)                           ; $0040
                clr.b   objoff_3D(A1)                           ; $003D
                moveq   #Small_Bumper_Sfx, D0                             ; -$75
                jsr     (PlaySound)                           ; Offset_0x001176
                rts            
;-------------------------------------------------------------------------------  
Offset_0x01CAEA:
                dc.b    $10, $10, $10, $10, $10, $10, $10, $10
                dc.b    $10, $0F, $0F, $0E, $0E, $0D, $0C, $0A
                dc.b    $08, $06, $04, $00, $FC, $F8, $F6, $F6
                dc.b    $F6, $F6, $F6, $F6     
;-------------------------------------------------------------------------------                                                              
Dash_Trigger_Mappings:                                         ; Offset_0x01CB06
                dc.w    Offset_0x01CB10-Dash_Trigger_Mappings
                dc.w    Offset_0x01CB24-Dash_Trigger_Mappings
                dc.w    Offset_0x01CB32-Dash_Trigger_Mappings
                dc.w    Offset_0x01CB46-Dash_Trigger_Mappings
                dc.w    Offset_0x01CB54-Dash_Trigger_Mappings
Offset_0x01CB10:
                dc.w    $0003
                dc.w    $0805, $003D, $FFE0
                dc.w    $0805, $083D, $FFF0
                dc.w    $F00F, $0824, $FFF0
Offset_0x01CB24:
                dc.w    $0002
                dc.w    $040A, $0041, $FFE4
                dc.w    $F00F, $0824, $FFF0
Offset_0x01CB32:
                dc.w    $0003
                dc.w    $0005, $004A, $FFE8
                dc.w    $1005, $104A, $FFE8
                dc.w    $F00F, $0824, $FFF0
Offset_0x01CB46:
                dc.w    $0002
                dc.w    $040A, $0841, $FFE4
                dc.w    $F00F, $0824, $FFF0
Offset_0x01CB54:
                dc.w    $0002
                dc.w    $F408, $0834, $FFF0
                dc.w    $FC09, $0837, $FFF8                                                                       
;===============================================================================
; Objeto 0x59 - Roda azul ativada através de "Spindash" na Marble Garden.
; <<<-  
;===============================================================================  