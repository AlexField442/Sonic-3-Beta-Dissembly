;===============================================================================
; Objeto Cauda do Miles no modo 2 jogadores
; ->>>  
;===============================================================================
; Offset_0x00F2AE:
                move.l  #Miles_Tails_2P_Mappings, mappings(A0) ; Offset_0x1030DA, $000C
                move.w  #$06B0, art_tile(A0)                         ; $000A
                cmpa.w  #$CC0A, A0
                beq.s   Offset_0x00F2C8
                move.w  #$0690, art_tile(A0)                         ; $000A
Offset_0x00F2C8:
                move.w  #$0100, priority(A0)                         ; $0008
                move.b  #$18, width_pixels(A0)                              ; $0007
                move.b  #$04, render_flags(A0)                              ; $0004
                move.l  #Offset_0x00F2E0, (A0)
Offset_0x00F2E0:                
                move.w  flips_remaining(A0), A2                    ; $0030
                move.b  angle(A2), angle(A0)              ; $0026, $0026
                move.b  status(A2), status(A0)            ; $002A, $002A
                move.b  render_flags(A2), render_flags(A0)              ; $0004, $0004
                move.w  x_pos(A2), x_pos(A0)                      ; $0010, $0010
                move.w  y_pos(A2), y_pos(A0)                      ; $0014, $0014
                move.w  priority(A2), priority(A0)        ; $0008, $0008
                andi.w  #$7FFF, art_tile(A0)                         ; $000A
                tst.w   art_tile(A2)                                 ; $000A
                bpl.s   Offset_0x00F31A
                ori.w   #$8000, art_tile(A0)                         ; $000A
Offset_0x00F31A:
                moveq   #$00, D0
                move.b  anim(A2), D0                           ; $0020
                btst    #$05, status(A2)                             ; $002A
                beq.s   Offset_0x00F330
                cmpi.b  #$05, D0
                beq.s   Offset_0x00F330
                moveq   #$04, D0
Offset_0x00F330:
                cmp.b   invulnerable_time(A0), D0                    ; $0034
                beq.s   Offset_0x00F340
                move.b  D0, invulnerable_time(A0)                    ; $0034
                move.b  Offset_0x00F354(PC, D0), anim(A0)      ; $0020
Offset_0x00F340:
                lea     (Miles_Tails_2P_Animate_Data), A1      ; Offset_0x00F376
                bsr     Miles_Animate_Sprite_2P_A1             ; Offset_0x00EDD6
                bsr     Load_Miles_Tails_Dynamic_PLC_2P        ; Offset_0x00F122
                jmp     (DisplaySprite)                        ; Offset_0x011148 
;-------------------------------------------------------------------------------
Offset_0x00F354:
                dc.b    $00, $00, $03, $03, $00, $01, $01, $01
                dc.b    $01, $00, $01, $01, $01, $00, $00, $00
                dc.b    $00, $00, $00, $00, $00, $00, $00, $00
                dc.b    $00, $00, $00, $00, $00, $00, $00, $00
                dc.b    $00, $00    
;-------------------------------------------------------------------------------  
Miles_Tails_2P_Animate_Data:                                   ; Offset_0x00F376
                dc.w    Miles_Tails_2P_Ani_00-Miles_Tails_2P_Animate_Data ; Offset_0x00F37E
                dc.w    Miles_Tails_2P_Ani_01-Miles_Tails_2P_Animate_Data ; Offset_0x00F381
                dc.w    Miles_Tails_2P_Ani_01-Miles_Tails_2P_Animate_Data ; Offset_0x00F381
                dc.w    Miles_Tails_2P_Ani_02-Miles_Tails_2P_Animate_Data ; Offset_0x00F386
Miles_Tails_2P_Ani_00:                                         ; Offset_0x00F37E
                dc.b    $20, $00, $FF
Miles_Tails_2P_Ani_01:                                         ; Offset_0x00F381
                dc.b    $07, $01, $02, $03, $FF
Miles_Tails_2P_Ani_02:                                         ; Offset_0x00F386
                dc.b    $FC, $04, $05, $06, $FF, $00                                                                                                                                                                                                                                                                                                                                                                                                                                                             
;===============================================================================
; Objeto Cauda do Miles no modo 2 jogadores
; <<<-  
;===============================================================================  