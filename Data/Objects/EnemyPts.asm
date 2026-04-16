;===============================================================================
; Pontos obtidos ao destruir alguns objetos
; ->>>     
;===============================================================================                   
; Offset_0x023E42:
                move.l  #Enemy_Points_Mappings, mappings(A0) ; Offset_0x023F1E, $000C
                move.w  #$85E4, art_tile(A0)                         ; $000A
                move.b  #$04, render_flags(A0)                              ; $0004
                move.w  #$0080, priority(A0)                         ; $0008
                move.b  #$08, width_pixels(A0)                              ; $0007
                move.w  #$FD00, y_vel(A0)                          ; $001A
                move.l  #Offset_0x023E6E, (A0)
Offset_0x023E6E:                
                tst.w   y_vel(A0)                                  ; $001A
                bpl     Flickies_DeleteObject                  ; Offset_0x023B3C
                jsr     (SpeedToPos)                           ; Offset_0x01111E
                addi.w  #$0018, y_vel(A0)                          ; $001A
                jmp     (DisplaySprite)                        ; Offset_0x011148                                                                                                                                                                                                                
;===============================================================================
; Pontos obtidos ao destruir alguns objetos 
; <<<-       
;===============================================================================  