;===============================================================================
; Objeto 0x53 - Três plataformas giratórias na Marble Garden
; ->>>           
;===============================================================================
; Offset_0x02A224:
                move.l  #Swinging_Platform_Mappings, mappings(A0) ; Offset_0x02A36C, $000C
                move.w  #$435F, art_tile(A0)                         ; $000A
                move.b  #$04, render_flags(A0)                              ; $0004
                move.b  #$18, width_pixels(A0)                              ; $0007
                move.b  #$0C, height_pixels(A0)                             ; $0006
                move.w  #$0200, priority(A0)                         ; $0008
                move.w  x_pos(A0), Obj_Control_Var_00(A0)         ; $0010, $0030
                move.w  y_pos(A0), Obj_Control_Var_02(A0)         ; $0014, $0032
                move.b  #$02, mapping_frame(A0)                             ; $0022
                jsr     (AllocateObjectAfterCurrent)                  ; Offset_0x011DE0
                bne     Offset_0x02A2BC
                move.l  #Offset_0x02A30E, (A1)
                move.l  #Swinging_Platform_Mappings, mappings(A1) ; Offset_0x02A36C, $000C
                move.w  #$435F, art_tile(A1)                         ; $000A
                move.b  #$04, render_flags(A1)                              ; $0004
                move.b  #$50, width_pixels(A1)                              ; $0007
                move.b  #$50, height_pixels(A1)                             ; $0006
                move.w  #$0280, priority(A1)                         ; $0008
                move.w  x_pos(A0), x_pos(A1)                      ; $0010, $0010
                move.w  y_pos(A0), y_pos(A1)                      ; $0014, $0014
                btst    #$01, status(A0)                             ; $002A
                bne.s   Offset_0x02A2AC
                move.b  #$01, mapping_frame(A1)                             ; $0022
Offset_0x02A2AC:
                bset    #$06, render_flags(A1)                              ; $0004
                move.w  #$0004, y_sub(A1)                            ; $0016
                move.w  A1, Obj_Control_Var_0C(A0)                       ; $003C
Offset_0x02A2BC:
                moveq   #$01, D0
                btst    #$00, status(A0)                             ; $002A
                beq.s   Offset_0x02A2C8
                neg.w   D0
Offset_0x02A2C8:
                move.b  D0, Obj_Control_Var_06(A0)                       ; $0036
                move.b  subtype(A0), D0                              ; $002C
                move.b  D0, Obj_Control_Var_04(A0)                       ; $0034
                move.l  #Offset_0x02A2DA, (A0)
Offset_0x02A2DA:                
                move.w  x_pos(A0), -(A7)                                 ; $0010
                move.w  Obj_Control_Var_0C(A0), A1                       ; $003C
                bsr     Offset_0x02A314
                move.b  Obj_Control_Var_06(A0), D0                       ; $0036
                add.b   D0, Obj_Control_Var_04(A0)                       ; $0034
                moveq   #$00, D1
                move.b  width_pixels(A0), D1                                ; $0007
                moveq   #$00, D3
                move.b  height_pixels(A0), D3                               ; $0006
                addq.w  #$01, D3
                move.w  (A7)+, D4
                jsr     (Platform_Object)                      ; Offset_0x013AF6
                move.w  Obj_Control_Var_00(A0), D0                       ; $0030
                jmp     (MarkObjGone_2)                        ; Offset_0x011B1A
;-------------------------------------------------------------------------------                
Offset_0x02A30E:
                jmp     (MarkObjGone)                          ; Offset_0x011AF2   
;-------------------------------------------------------------------------------  
Offset_0x02A314:
                move.b  Obj_Control_Var_04(A0), D0                       ; $0034
                jsr     (CalcSine)                             ; Offset_0x001B20
                move.w  Obj_Control_Var_02(A0), D2                       ; $0032
                move.w  Obj_Control_Var_00(A0), D3                       ; $0030
                swap.w  D0
                swap.w  D1
                asr.l   #$04, D0
                asr.l   #$04, D1
                move.l  D0, D4
                move.l  D1, D5
                lea     x_vel(A1), A2                              ; $0018
                move.w  y_sub(A1), D6                                ; $0016
                subq.w  #$01, D6
Offset_0x02A33C:
                movem.l D4/D5, -(A7)
                swap.w  D4
                swap.w  D5
                add.w   D2, D4
                add.w   D3, D5
                move.w  D5, (A2)+
                move.w  D4, (A2)+
                movem.l (A7)+, D4/D5
                add.l   D0, D4
                add.l   D1, D5
                addq.w  #$02, A2
                dbra    D6, Offset_0x02A33C
                swap.w  D4
                swap.w  D5
                add.w   D2, D4
                add.w   D3, D5
                move.w  D5, x_pos(A0)                                    ; $0010
                move.w  D4, y_pos(A0)                                    ; $0014
                rts                                                               
;-------------------------------------------------------------------------------
Swinging_Platform_Mappings:                                    ; Offset_0x02A36C
                dc.w    Offset_0x02A372-Swinging_Platform_Mappings
                dc.w    Offset_0x02A37A-Swinging_Platform_Mappings
                dc.w    Offset_0x02A382-Swinging_Platform_Mappings
Offset_0x02A372:
                dc.w    $0001
                dc.w    $F805, $0098, $FFF8
Offset_0x02A37A:
                dc.w    $0001
                dc.w    $F805, $009C, $FFF8
Offset_0x02A382:
                dc.w    $0002
                dc.w    $F40A, $008F, $FFE8
                dc.w    $F40A, $088F, $0000                                 
;===============================================================================
; Objeto 0x53 - Três plataformas giratórias na Marble Garden
; <<<-  
;===============================================================================  