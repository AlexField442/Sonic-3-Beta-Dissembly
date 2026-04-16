;===============================================================================
; Objeto 0x95 - Inimigo Dragonfly na Mushroom Valley
; ->>>           
;===============================================================================
; Offset_0x049B24:
                jsr     (Object_Check_Range)                   ; Offset_0x04326E
                moveq   #$00, D0
                move.b  routine(A0), D0                              ; $0005
                move.w  Offset_0x049B3C(PC, D0), D1
                jsr     Offset_0x049B3C(PC, D1)
                jmp     Delete_Sprite_Clear_Respaw_Flag_Check_X(PC) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x049B3C:
                dc.w    Offset_0x049B42-Offset_0x049B3C
                dc.w    Offset_0x049B9A-Offset_0x049B3C
                dc.w    Offset_0x049BD6-Offset_0x049B3C  
;-------------------------------------------------------------------------------
Offset_0x049B42:
                lea     Dragonfly_Setup_Data(PC), A1           ; Offset_0x049D86
                jsr     (SetupObjectAttributes)                      ; Offset_0x041D72
                move.l  #Offset_0x049DBE, child_data(A0)             ; $0030
                lea     Offset_0x049D9E(PC), A2
                jsr     (SetupChildObject)                 ; Offset_0x041D9A
                lea     Offset_0x049DA6(PC), A2
                jsr     (SetupChildObject_LinkedList) ; Offset_0x041EA0
                move.w  #$0200, D0
                move.w  D0, objoff_3E(A0)                       ; $003E
                move.w  D0, y_vel(A0)                              ; $001A
                move.w  #$0008, objoff_40(A0)                   ; $0040
                bclr    #$00, objoff_38(A0)                     ; $0038
Offset_0x049B80:                
                move.w  #$0200, D0
                move.w  D0, objoff_3A(A0)                       ; $003A
                move.w  D0, x_vel(A0)                              ; $0018
                move.w  #$0020, objoff_3C(A0)                   ; $003C
                bclr    #$03, objoff_38(A0)                     ; $0038
                rts   
;-------------------------------------------------------------------------------
Offset_0x049B9A:
                jsr     (AnimateRaw)                          ; Offset_0x04208E
                jsr     (Swing_Left_And_Right)                 ; Offset_0x042372
                jsr     (Swing_Up_And_Down)                    ; Offset_0x04232E
                jsr     (SpeedToPos)                           ; Offset_0x01111E
                tst.w   y_vel(A0)                                  ; $001A
                beq.s   Offset_0x049BBA
                rts
Offset_0x049BBA:
                move.b  #$04, routine(A0)                            ; $0005
                move.w  #$000F, objoff_2E(A0)                            ; $002E
                move.l  #Offset_0x049BE8, child(A0)                  ; $0034
                bset    #$02, objoff_38(A0)                     ; $0038
                rts  
;-------------------------------------------------------------------------------
Offset_0x049BD6:
                jsr     (Swing_Left_And_Right)                 ; Offset_0x042372
                jsr     (SpeedToPos)                           ; Offset_0x01111E
                jmp     (Run_Object_Wait_Timer_A0)             ; Offset_0x0423D2   
;-------------------------------------------------------------------------------
Offset_0x049BE8:
                move.b  #$02, routine(A0)                            ; $0005
                bclr    #$02, objoff_38(A0)                     ; $0038
                clr.b   anim_frame(A0)                                ; $0023
                clr.b   anim_frame_duration(A0)                                 ; $0024
                move.l  #Offset_0x049DB2, child_data(A0)             ; $0030
                bchg    #01, objoff_38(A0)                      ; $0038
                bne.s   Offset_0x049C14
                move.l  #Offset_0x049DBE, child_data(A0)             ; $0030
Offset_0x049C14:
                rts     
;-------------------------------------------------------------------------------
Offset_0x049C16:
                moveq   #$00, D0
                move.b  routine(A0), D0                              ; $0005
                move.w  Offset_0x049C2A(PC, D0), D1
                jsr     Offset_0x049C2A(PC, D1)
                jmp     (Child_Display_Touch_Or_Delete)        ; Offset_0x042472  
;-------------------------------------------------------------------------------
Offset_0x049C2A:
                dc.w    Offset_0x049C34-Offset_0x049C2A
                dc.w    Offset_0x049C64-Offset_0x049C2A
                dc.w    Offset_0x049C7A-Offset_0x049C2A
                dc.w    Offset_0x049CA6-Offset_0x049C2A
                dc.w    Offset_0x049CE4-Offset_0x049C2A   
;-------------------------------------------------------------------------------
Offset_0x049C34:
                lea     Dragonfly_Setup_Data_3(PC), A1         ; Offset_0x049D98
                jsr     (SetupObjectAttributes3)                    ; Offset_0x041D7A
                bset    #$01, render_flags(A0)                              ; $0004
                moveq   #$00, D0
                move.b  subtype(A0), D0                              ; $002C
                cmpi.b  #$0C, D0
                bne.s   Offset_0x049C56
                move.b  #$06, mapping_frame(A0)                             ; $0022
Offset_0x049C56:
                move.w  D0, objoff_2E(A0)                                ; $002E
                move.b  #$01, objoff_42(A0)                     ; $0042
                bra     Offset_0x049D58      
;-------------------------------------------------------------------------------
Offset_0x049C64:
                bsr     Offset_0x049D70
                subq.w  #$01, objoff_2E(A0)                              ; $002E
                bmi.s   Offset_0x049C70
                rts
Offset_0x049C70:
                move.b  #$04, routine(A0)                            ; $0005
                bra     Offset_0x049B80  
;-------------------------------------------------------------------------------
Offset_0x049C7A:
                bsr     Offset_0x049D70
                jsr     (Swing_Left_And_Right)                 ; Offset_0x042372
                jsr     (SpeedToPos)                           ; Offset_0x01111E
                move.w  parent3(A0), A1                            ; $0046
                btst    #$02, objoff_38(A1)                     ; $0038
                bne.s   Offset_0x049C98
                rts
Offset_0x049C98:
                move.b  #$06, routine(A0)                            ; $0005
                bset    #$02, objoff_38(A0)                     ; $0038
                rts   
;-------------------------------------------------------------------------------
Offset_0x049CA6:
                jsr     (Swing_Left_And_Right)                 ; Offset_0x042372
                jsr     (SpeedToPos)                           ; Offset_0x01111E
                move.w  parent3(A0), A1                            ; $0046
                move.w  y_pos(A0), D0                                    ; $0014
                move.b  objoff_42(A0), D1                       ; $0042
                ext.w   D1
                add.w   D1, D0
                cmp.w   y_pos(A1), D0                                    ; $0014
                beq.s   Offset_0x049CCE
                move.w  D0, y_pos(A0)                                    ; $0014
                rts
Offset_0x049CCE:
                move.w  y_pos(A1), y_pos(A0)                      ; $0014, $0014
                move.b  #$08, routine(A0)                            ; $0005
                neg.b   objoff_42(A0)                           ; $0042
                neg.b   objoff_43(A0)                           ; $0043
                rts  
;-------------------------------------------------------------------------------
Offset_0x049CE4:
                jsr     (Swing_Left_And_Right)                 ; Offset_0x042372
                jsr     (SpeedToPos)                           ; Offset_0x01111E
                move.w  parent3(A0), A1                            ; $0046
                move.w  y_pos(A1), D0                                    ; $0014
                move.b  objoff_43(A0), D1                       ; $0043
                ext.w   D1
                bmi.s   Offset_0x049D0A
                add.w   D1, D0
                cmp.w   y_pos(A0), D0                                    ; $0014
                bls.s   Offset_0x049D14
                rts
Offset_0x049D0A:
                add.w   D1, D0
                cmp.w   y_pos(A0), D0                                    ; $0014
                bcc.s   Offset_0x049D14
                rts
Offset_0x049D14:
                move.b  #$04, routine(A0)                            ; $0005
                move.w  D0, y_pos(A0)                                    ; $0014
                bchg    #01, render_flags(A0)                               ; $0004
                bclr    #$02, objoff_38(A0)                     ; $0038
                rts     
;-------------------------------------------------------------------------------
Offset_0x049D2C:
                lea     Dragonfly_Setup_Data_2(PC), A1         ; Offset_0x049D92
                jsr     (SetupObjectAttributes3)                    ; Offset_0x041D7A
                move.l  #Offset_0x049D42, (A0)
                jmp     (Child_Display_Or_Delete)              ; Offset_0x04245C  
;-------------------------------------------------------------------------------
Offset_0x049D42:
                jsr     (Refresh_Child_Position)               ; Offset_0x042016
                lea     Offset_0x049DAC(PC), A1
                jsr     (Animate_Raw_A1)                       ; Offset_0x042092
                jmp     (Child_Display_Or_Delete)              ; Offset_0x04245C  
;-------------------------------------------------------------------------------
Offset_0x049D58:
                moveq   #$00, D0
                move.b  subtype(A0), D0                              ; $002C
                lsr.w   #$01, D0
                move.b  Offset_0x049D68(PC, D0), objoff_43(A0)  ; $0043
                rts         
;-------------------------------------------------------------------------------
Offset_0x049D68:
                dc.b    $F4, $FB, $FB, $FB, $FB, $FB, $FB, $00     
;-------------------------------------------------------------------------------
Offset_0x049D70:
                move.w  parent3(A0), A1                            ; $0046
                move.w  y_pos(A1), D0                                    ; $0014
                move.b  objoff_43(A0), D1                       ; $0043
                ext.w   D1
                add.w   D1, D0
                move.w  D0, y_pos(A0)                                    ; $0014
                rts      
;-------------------------------------------------------------------------------
Dragonfly_Setup_Data:                                          ; Offset_0x049D86
                dc.l    Dragonfly_Mappings                     ; Offset_0x10DEFA
                dc.w    $A56D, $0280
                dc.b    $08, $08, $04, $17   
;-------------------------------------------------------------------------------
Dragonfly_Setup_Data_2:                                        ; Offset_0x049D92
                dc.w    $0280
                dc.b    $20, $08, $07, $00      
;-------------------------------------------------------------------------------
Dragonfly_Setup_Data_3:                                        ; Offset_0x049D98
                dc.w    $0280
                dc.b    $04, $04, $05, $98        
;-------------------------------------------------------------------------------
Offset_0x049D9E:
                dc.w    $0000
                dc.l    Offset_0x049D2C
                dc.b    $00, $00        
;-------------------------------------------------------------------------------
Offset_0x049DA6:
                dc.w    $0006
                dc.l    Offset_0x049C16   
;-------------------------------------------------------------------------------
Offset_0x049DAC:
                dc.b    $00, $07, $09, $08, $09, $FC  
;-------------------------------------------------------------------------------
Offset_0x049DB2:
                dc.b    $03, $00, $01, $02, $03, $04, $F8    
;-------------------------------------------------------------------------------
; Offset_0x049DB9:
                dc.b    $08, $7F, $04, $04, $FC     
;-------------------------------------------------------------------------------
Offset_0x049DBE:
                dc.b    $03, $04, $03, $02, $01, $00, $F8      
;-------------------------------------------------------------------------------
; Offset_0x049DC5:
                dc.b    $08, $7F, $00, $00, $FC
;===============================================================================
; Objeto 0x95 - Inimigo Dragonfly na Mushroom Valley
; <<<-  
;===============================================================================  