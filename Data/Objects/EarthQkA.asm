;===============================================================================
; Objeto de controle de colisão dos tiles da Marble Garden durante o terremoto
; ->>>      
;===============================================================================                   
; Offset_0x0325CE:
                cmpi.w  #$0008, (Level_Events_Routine).w             ; $FFFFEEC0
                bne.s   Offset_0x0325DC
                jmp     (DeleteObject)                         ; Offset_0x011138
Offset_0x0325DC:
                move.l  Obj_Control_Var_00(A0), A1                       ; $0030
                move.w  Obj_Timer(A0), D0                                ; $002E
                add.w   (A1), D0
                move.w  D0, y_pos(A0)                                    ; $0014
                move.b  #$10, width_pixels(A0)                              ; $0007
                bset    #$07, status(A0)                             ; $002A
                moveq   #$1B, D1
                moveq   #$40, D2
                moveq   #$40, D3
                move.w  x_pos(A0), D4                                    ; $0010
                jmp     (Solid_Object_2)                       ; Offset_0x0135B6                                                                                                                                                                                       
;===============================================================================
; Objeto de controle de colisão dos tiles da Marble Garden durante o terremoto  
; <<<-     
;===============================================================================  