;=============================================================================== 
; Objeto 0x92 - Inimigo Toxomister na Lava Reef
; ->>>
;===============================================================================
; Offset_0x04A400:
                jsr     (Object_Check_Range)                   ; Offset_0x04326E
                moveq   #$00, D0
                move.b  routine(A0), D0                              ; $0005
                move.w  Offset_0x04A41E(PC, D0), D1
                jsr     Offset_0x04A41E(PC, D1)
                bsr     Offset_0x04A636
                jmp     (Delete_Sprite_Clear_Respaw_Flag_Check_X) ; Offset_0x042B3C
;-------------------------------------------------------------------------------
Offset_0x04A41E:
                dc.w    Offset_0x04A424-Offset_0x04A41E
                dc.w    Offset_0x04A438-Offset_0x04A41E
                dc.w    Offset_0x04A45C-Offset_0x04A41E  
;-------------------------------------------------------------------------------
Offset_0x04A424:
                lea     Toxomister_Setup_Data(PC), A1          ; Offset_0x04A708
                jsr     (SetupObjectAttributes)                      ; Offset_0x041D72
                lea     Offset_0x04A730(PC), A2
                jmp     (SetupChildObject)                 ; Offset_0x041D9A  
;-------------------------------------------------------------------------------
Offset_0x04A438:
                tst.b   render_flags(A0)                                    ; $0004
                bmi.s   Offset_0x04A440
                rts
Offset_0x04A440:
                move.b  #$04, routine(A0)                            ; $0005
                lea     Offset_0x04A720(PC), A2
                btst    #$00, render_flags(A0)                              ; $0004
                beq.s   Offset_0x04A456
                lea     Offset_0x04A728(PC), A2
Offset_0x04A456:
                jmp     (SetupChildObject)                 ; Offset_0x041D9A   
;-------------------------------------------------------------------------------
Offset_0x04A45C:
                rts    
;-------------------------------------------------------------------------------
Offset_0x04A45E:
                moveq   #$00, D0
                move.b  routine(A0), D0                              ; $0005
                move.w  Offset_0x04A476(PC, D0), D1
                jsr     Offset_0x04A476(PC, D1)
                bsr     Offset_0x04A6B8
                jmp     (Child_Display_Or_Delete)              ; Offset_0x04245C 
;-------------------------------------------------------------------------------
Offset_0x04A476:
                dc.w    Offset_0x04A47A-Offset_0x04A476
                dc.w    Offset_0x04A484-Offset_0x04A476       
;-------------------------------------------------------------------------------
Offset_0x04A47A:
                lea     Toxomister_Setup_Data_2(PC), A1        ; Offset_0x04A714
                jmp     (SetupObjectAttributes3)                    ; Offset_0x041D7A  
;-------------------------------------------------------------------------------
Offset_0x04A484:
                rts                
;-------------------------------------------------------------------------------
Offset_0x04A486:
                moveq   #$00, D0
                move.b  routine(A0), D0                              ; $0005
                move.w  Offset_0x04A49A(PC, D0), D1
                jsr     Offset_0x04A49A(PC, D1)
                jmp     (Delete_Sprite_Clear_Respaw_Flag_Check_X_3) ; Offset_0x042B7C   
;-------------------------------------------------------------------------------
Offset_0x04A49A:
                dc.w    Offset_0x04A4A6-Offset_0x04A49A
                dc.w    Offset_0x04A4D4-Offset_0x04A49A
                dc.w    Offset_0x04A4F4-Offset_0x04A49A
                dc.w    Offset_0x04A510-Offset_0x04A49A
                dc.w    Offset_0x04A514-Offset_0x04A49A
                dc.w    Offset_0x04A56E-Offset_0x04A49A   
;-------------------------------------------------------------------------------
Offset_0x04A4A6:
                lea     Toxomister_Setup_Data_3(PC), A1        ; Offset_0x04A71A
                jsr     (SetupObjectAttributes3)                    ; Offset_0x041D7A
                move.b  #$D8, collision_flags(A0)                          ; $0028
                move.b  #$18, y_radius(A0)                           ; $001E
                move.w  #$006F, objoff_2E(A0)                            ; $002E
                move.l  #Offset_0x04A4DE, child(A0)                  ; $0034
                lea     Offset_0x04A738(PC), A2
                jmp     (SetupChildObject)                 ; Offset_0x041D9A     
;-------------------------------------------------------------------------------
Offset_0x04A4D4:
                bsr     Offset_0x04A654
                jmp     (Run_Object_Wait_Timer_A0)             ; Offset_0x0423D2  
;-------------------------------------------------------------------------------
Offset_0x04A4DE:
                move.b  #$04, routine(A0)                            ; $0005
                move.w  #$0040, y_vel(A0)                          ; $001A
                move.l  #Offset_0x04A504, child(A0)                  ; $0034
                rts        
;-------------------------------------------------------------------------------
Offset_0x04A4F4:
                bsr     Offset_0x04A654
                jsr     (SpeedToPos)                           ; Offset_0x01111E
                jmp     (Run_Object_Hit_Floor_A0)              ; Offset_0x0423E0   
;-------------------------------------------------------------------------------
Offset_0x04A504:
                move.b  #$06, routine(A0)                            ; $0005
                clr.w   y_vel(A0)                                  ; $001A
                rts    
;-------------------------------------------------------------------------------
Offset_0x04A510:
                bra     Offset_0x04A654     
;-------------------------------------------------------------------------------
Offset_0x04A514:
                move.w  default_y_radius(A0), A1                             ; $0044
                cmpi.b  #$09, anim(A1)                         ; $0020
                beq.s   Offset_0x04A566
                jsr     (Check_Left_Right_Controller_Shake)    ; Offset_0x04309C
                bne.s   Offset_0x04A558
                move.w  #$0100, D0
                move.w  #$0100, D1
                jsr     (Chase_Object)                         ; Offset_0x042E6C
                jsr     (SpeedToPos)                           ; Offset_0x01111E
                bsr     Offset_0x04A69E
                subq.w  #$01, objoff_2E(A0)                              ; $002E
                bmi.s   Offset_0x04A548
                rts
Offset_0x04A548:
                move.l  A0, A2
                move.w  default_y_radius(A0), A1                             ; $0044
                move.l  A1, A0
                jsr     (Kill_Player)                          ; Offset_0x00A4A4
                move.l  A2, A0
Offset_0x04A558:
                move.b  #$0A, routine(A0)                            ; $0005
                bset    #$07, status(A0)                             ; $002A
                rts
Offset_0x04A566:
                bset    #$02, objoff_38(A0)                     ; $0038
                bra.s   Offset_0x04A558          
;-------------------------------------------------------------------------------
Offset_0x04A56E:
                jmp     (DeleteObject)                         ; Offset_0x011138  
;-------------------------------------------------------------------------------
Offset_0x04A574:
                lea     Toxomister_Setup_Data_3(PC), A1        ; Offset_0x04A71A
                jsr     (SetupObjectAttributes3)                    ; Offset_0x041D7A
                move.l  #Offset_0x04A5AE, (A0)
                move.l  #Offset_0x04A764, child_data(A0)             ; $0030
                move.b  subtype(A0), D0                              ; $002C
                subi.b  #$0C, D0
                neg.b   D0
                move.b  D0, subtype(A0)                              ; $002C
                lsl.b   #$02, D0
                move.b  D0, objoff_2F(A0)                              ; $002F
                move.l  #Offset_0x04A5CC, child(A0)                  ; $0034
                jmp     (Delete_Sprite_Check_X_3)              ; Offset_0x042ABC 
;-------------------------------------------------------------------------------
Offset_0x04A5AE:
                move.w  parent3(A0), A1                            ; $0046
                btst    #$07, status(A1)                             ; $002A
                beq.s   Offset_0x04A5C0
                move.l  #DeleteObject, (A0)                    ; Offset_0x011138
Offset_0x04A5C0:
                jsr     (Run_Object_Wait_Timer_A0)             ; Offset_0x0423D2
                jmp     (Delete_Sprite_Check_X_3)              ; Offset_0x042ABC  
;-------------------------------------------------------------------------------
Offset_0x04A5CC:
                move.l  #Offset_0x04A5AE, (A0)
                move.w  parent3(A0), A1                            ; $0046
                btst    #$07, status(A1)                             ; $002A
                beq.s   Offset_0x04A60C
                btst    #$02, objoff_38(A1)                     ; $0038
                beq.s   Offset_0x04A5EE
                bsr     Offset_0x04A6DC
                bra     Offset_0x04A5F2
Offset_0x04A5EE:
                clr.w   x_vel(A0)                                  ; $0018
Offset_0x04A5F2:
                clr.w   y_vel(A0)                                  ; $001A
                move.l  #Offset_0x04A61E, (A0)
                move.l  #Offset_0x04A775, child_data(A0)             ; $0030
                move.l  #Go_Delete_Object_A0, child(A0) ; Offset_0x042D3E, $0034
Offset_0x04A60C:
                jsr     (Refresh_Child_Position)               ; Offset_0x042016
                jsr     (AnimateRaw)                          ; Offset_0x04208E
                jmp     (Delete_Sprite_Check_X_Y)              ; Offset_0x042AD0  
;-------------------------------------------------------------------------------
Offset_0x04A61E:
                addi.w  #$FFF0, y_vel(A0)                          ; $001A
                jsr     (SpeedToPos)                           ; Offset_0x01111E
                jsr     (AnimateRaw)                          ; Offset_0x04208E
                jmp     (Delete_Sprite_Check_X_Y)              ; Offset_0x042AD0  
;-------------------------------------------------------------------------------
Offset_0x04A636:
                btst    #$02, (Vint_runcount+$03).w       ; $FFFFFE0F
                jsr     (Find_Player)                          ; Offset_0x042634
                bclr    #$00, render_flags(A0)                              ; $0004
                tst.w   D0
                beq.s   Offset_0x04A652
                bset    #$00, render_flags(A0)                              ; $0004
Offset_0x04A652:
                rts     
;-------------------------------------------------------------------------------
Offset_0x04A654:
                move.b  collision_property(A0), D0                             ; $0029
                beq     Offset_0x04A45C
                clr.b   collision_property(A0)                                 ; $0029
                andi.w  #$0003, D0
                lsl.w   #$02, D0
                lea     (Offset_0x04A692-$04)(PC, D0), A1
                move.w  (A1)+, A2
                cmpi.b  #$02, anim(A2)                         ; $0020
                beq     Offset_0x04A45C
                move.w  A2, default_y_radius(A0)                             ; $0044
                move.w  (A1)+, A2
                move.w  A2, objoff_3E(A0)                       ; $003E
                move.w  (A2), objoff_3A(A0)                     ; $003A
                move.b  #$08, routine(A0)                            ; $0005
                move.w  #$0400, objoff_2E(A0)                            ; $002E
                rts                                         
;-------------------------------------------------------------------------------
Offset_0x04A692:
                dc.w    Obj_Player_One                                   ; $B000
                dc.w    Control_Ports_Buffer_Data                        ; $F604
                dc.w    Obj_Player_Two                                   ; $B04A
                dc.w    (Control_Ports_Buffer_Data+$02)                  ; $F606
                dc.w    Obj_Player_One                                   ; $B000
                dc.w    Control_Ports_Buffer_Data                        ; $F604  
;-------------------------------------------------------------------------------  
Offset_0x04A69E:
                moveq   #$1C, D0
                btst    #$01, status(A1)                             ; $002A
                beq.s   Offset_0x04A6AA
                moveq   #$1A, D0
Offset_0x04A6AA:
                move.w  $00(A1, D0), D1
                asr.w   #$03, D1
                neg.w   D1
                add.w   D1, $00(A1, D0)
                rts       
;-------------------------------------------------------------------------------  
Offset_0x04A6B8:
                btst    #$00, (Vint_runcount+$03).w       ; $FFFFFE0F
                beq.s   Offset_0x04A6C8
                move.b  #$1F, collision_flags(A0)                          ; $0028
                rts
Offset_0x04A6C8:
                clr.b   collision_flags(A0)                                ; $0028
                moveq   #$11, D1
                moveq   #$10, D2
                moveq   #$08, D3
                move.w  x_pos(A0), D4                                    ; $0010
                jmp     (Solid_Object)                         ; Offset_0x013556  
;-------------------------------------------------------------------------------  
Offset_0x04A6DC:
                moveq   #$00, D0
                move.b  subtype(A0), D0                              ; $002C
                move.w  Offset_0x04A6FA(PC, D0), D0
                move.w  default_y_radius(A1), A2                             ; $0044
                btst    #$00, render_flags(A2)                              ; $0004
                bne.s   Offset_0x04A6F4
                neg.w   D0
Offset_0x04A6F4:
                move.w  D0, x_vel(A0)                              ; $0018
                rts     
;-------------------------------------------------------------------------------
Offset_0x04A6FA:
                dc.w    $0100, $0180, $0200, $0180, $0100, $0200, $0180  
;-------------------------------------------------------------------------------
Toxomister_Setup_Data:                                         ; Offset_0x04A708
                dc.l    Toxomister_Mappings                    ; Offset_0x10DDAA
                dc.w    $A568, $0280
                dc.b    $08, $08, $00, $18          
;-------------------------------------------------------------------------------
Toxomister_Setup_Data_2:                                       ; Offset_0x04A714
                dc.w    $0280
                dc.b    $08, $10, $01, $00      
;-------------------------------------------------------------------------------
Toxomister_Setup_Data_3:                                       ; Offset_0x04A71A
                dc.w    $0000
                dc.b    $08, $08, $02, $00   
;-------------------------------------------------------------------------------
Offset_0x04A720:
                dc.w    $0000
                dc.l    Offset_0x04A486
                dc.b    $F4, $08          
;-------------------------------------------------------------------------------
Offset_0x04A728:
                dc.w    $0000
                dc.l    Offset_0x04A486
                dc.b    $0C, $08         
;-------------------------------------------------------------------------------
Offset_0x04A730:
                dc.w    $0000
                dc.l    Offset_0x04A45E
                dc.b    $00, $18   
;-------------------------------------------------------------------------------
Offset_0x04A738:
                dc.w    $0006
                dc.l    Offset_0x04A574
                dc.b    $F4, $04
                dc.l    Offset_0x04A574
                dc.b    $0C, $04
                dc.l    Offset_0x04A574
                dc.b    $F8, $FC
                dc.l    Offset_0x04A574
                dc.b    $08, $FC
                dc.l    Offset_0x04A574
                dc.b    $00, $FC
                dc.l    Offset_0x04A574
                dc.b    $FC, $04
                dc.l    Offset_0x04A574
                dc.b    $04, $04      
;-------------------------------------------------------------------------------
Offset_0x04A764:
                dc.b    $07, $02, $03, $04, $05, $06, $07, $F8    
;-------------------------------------------------------------------------------
; Offset_0x04A76C:
                dc.b    $09, $07, $06, $05, $04, $05, $06, $07
                dc.b    $FC       
;-------------------------------------------------------------------------------
Offset_0x04A775:
                dc.b    $07, $07, $06, $05, $04, $03, $02, $F4
                dc.b    $00
;===============================================================================
; Objeto 0x92 - Inimigo Toxomister na Lava Reef
; <<<-    
;===============================================================================