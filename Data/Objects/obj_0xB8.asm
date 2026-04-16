;===============================================================================
; Objeto 0xB8 - Coluna na Icecap
; ->>>          
;===============================================================================
; Offset_0x046B0E:
                moveq   #$00, D0
                move.b  routine(A0), D0                              ; $0005
                move.w  Offset_0x046B32(PC, D0), D1
                move.w  x_pos(A0), -(A7)                                 ; $0010
                jsr     Offset_0x046B32(PC, D1)
                moveq   #$2B, D1
                moveq   #$70, D2
                moveq   #$70, D3
                move.w  (A7)+, D4
                jsr     (Solid_Object)                         ; Offset_0x013556
                jmp     MarkObjectGone(PC)              ; Offset_0x042A58 
;-------------------------------------------------------------------------------
Offset_0x046B32:
                dc.w    Offset_0x046B4A-Offset_0x046B32
                dc.w    Offset_0x046B86-Offset_0x046B32
                dc.w    Offset_0x046B98-Offset_0x046B32
                dc.w    Offset_0x046BA0-Offset_0x046B32
                dc.w    Offset_0x046BC6-Offset_0x046B32
                dc.w    Offset_0x046BCE-Offset_0x046B32
                dc.w    Offset_0x046C14-Offset_0x046B32
                dc.w    Offset_0x046C38-Offset_0x046B32
                dc.w    Offset_0x046C48-Offset_0x046B32
                dc.w    Offset_0x046C5E-Offset_0x046B32
                dc.w    Offset_0x046C7A-Offset_0x046B32
                dc.w    Offset_0x046C96-Offset_0x046B32  
;-------------------------------------------------------------------------------
Offset_0x046B4A:
                lea     Crushing_Column_Setup_Data(PC), A1     ; Offset_0x046CD8
                jsr     SetupObjectAttributes(PC)                    ; Offset_0x041D72
                move.b  #$70, y_radius(A0)                           ; $001E
                move.w  y_pos(A0), objoff_3E(A0)         ; $0014, $003E
                move.w  #$001F, objoff_2E(A0)                            ; $002E
                cmpi.b  #$03, subtype(A0)                            ; $002C
                bcc.s   Offset_0x046B7A
                move.b  #$0C, mapping_frame(A0)                             ; $0022
                lea     Offset_0x046CEA(PC), A2
                jsr     SetupChildObject(PC)               ; Offset_0x041D9A
Offset_0x046B7A:
                move.b  subtype(A0), D0                              ; $002C
                add.b   D0, D0
                move.b  D0, routine(A0)                              ; $0005
Offset_0x046B84:
                rts     
;-------------------------------------------------------------------------------
Offset_0x046B86:
                move.b  status(A0), D0                               ; $002A
                andi.b  #$18, D0
                beq.s   Offset_0x046B84
Offset_0x046B90:
                move.b  #$0A, routine(A0)                            ; $0005
                rts 
;-------------------------------------------------------------------------------
Offset_0x046B98:
                subq.w  #$01, objoff_2E(A0)                              ; $002E
                bmi.s   Offset_0x046B90
                rts  
;-------------------------------------------------------------------------------
Offset_0x046BA0:
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                jsr     Find_Other_Object(PC)                  ; Offset_0x04269E
                cmpi.w  #$0028, D2
                bcs     Offset_0x046B84
                btst    #$00, render_flags(A0)                              ; $0004
                beq.s   Offset_0x046BBA
                subq.w  #$02, D0
Offset_0x046BBA:
                tst.w   D0
                beq.s   Offset_0x046B84
Offset_0x046BBE:
                move.b  #$0E, routine(A0)                            ; $0005
                rts    
;-------------------------------------------------------------------------------
Offset_0x046BC6:
                subq.w  #$01, objoff_2E(A0)                              ; $002E
                bmi.s   Offset_0x046BBE
                rts  
;-------------------------------------------------------------------------------
Offset_0x046BCE:
                move.w  y_vel(A0), D0                              ; $001A
                addi.w  #$FFE0, D0
                cmpi.w  #$FC00, D0
                ble.s   Offset_0x046BE0
                move.w  D0, y_vel(A0)                              ; $001A
Offset_0x046BE0:
                jsr     (SpeedToPos)                           ; Offset_0x01111E
                jsr     (Object_HitCeiling)                    ; Offset_0x009FB4
                tst.w   D1
                bpl     Offset_0x046B84
Offset_0x046BF2:
                add.w   D1, y_pos(A0)                                    ; $0014
                move.b  #$10, routine(A0)                            ; $0005
                move.w  #$001F, objoff_2E(A0)                            ; $002E
                move.l  #Offset_0x046C4C, child(A0)                  ; $0034
                moveq   #Slide_Thunk_Sfx, D0                              ; -$50
                jsr     (Play_Music)                           ; Offset_0x001176
                rts     
;-------------------------------------------------------------------------------
Offset_0x046C14:
                move.w  y_vel(A0), D0                              ; $001A
                addi.w  #$0020, D0
                cmpi.w  #$0400, D0
                bgt.s   Offset_0x046C26
                move.w  D0, y_vel(A0)                              ; $001A
Offset_0x046C26:
                jsr     (SpeedToPos)                           ; Offset_0x01111E
                jsr     (ObjHitFloor)                          ; Offset_0x009D84
                tst.w   D1
                bmi.s   Offset_0x046BF2
                rts 
;-------------------------------------------------------------------------------
Offset_0x046C38:
                addq.w  #$08, y_pos(A0)                                  ; $0014
                jsr     (ObjHitFloor)                          ; Offset_0x009D84
                tst.w   D1
                bmi.s   Offset_0x046BF2
                rts  
;-------------------------------------------------------------------------------
Offset_0x046C48:
                jmp     Run_Object_Wait_Timer_A0(PC)           ; Offset_0x0423D2  
;-------------------------------------------------------------------------------
Offset_0x046C4C:
                moveq   #$00, D0
                move.b  subtype(A0), D0                              ; $002C
                move.b  (Offset_0x046C5A-$01)(PC, D0), routine(A0)   ; $0005
                rts                             
;-------------------------------------------------------------------------------
Offset_0x046C5A:
                dc.b    $14, $14, $16, $12   
;-------------------------------------------------------------------------------
Offset_0x046C5E:
                move.w  y_pos(A0), D0                                    ; $0014
                subq.w  #$01, D0
                cmp.w   objoff_3E(A0), D0                       ; $003E
                bls.s   Offset_0x046C70
                move.w  D0, y_pos(A0)                                    ; $0014
                rts
Offset_0x046C70:
                move.w  #$005F, objoff_2E(A0)                            ; $002E
                bra     Offset_0x046B7A   
;-------------------------------------------------------------------------------
Offset_0x046C7A:
                move.w  y_pos(A0), D0                                    ; $0014
                addq.w  #$01, D0
                cmp.w   objoff_3E(A0), D0                       ; $003E
                bcc.s   Offset_0x046C8C
                move.w  D0, y_pos(A0)                                    ; $0014
                rts
Offset_0x046C8C:
                move.w  #$005F, objoff_2E(A0)                            ; $002E
                bra     Offset_0x046B7A     
;-------------------------------------------------------------------------------
Offset_0x046C96:
                lea     (Obj_Player_One).w, A1                       ; $FFFFB000
                jsr     Find_Other_Object(PC)                  ; Offset_0x04269E
                btst    #$00, render_flags(A0)                              ; $0004
                beq.s   Offset_0x046CA8
                subq.w  #$02, D0
Offset_0x046CA8:
                tst.w   D0
                bne     Offset_0x046B84
                move.b  #$12, routine(A0)                            ; $0005
                rts
;-------------------------------------------------------------------------------  
Offset_0x046CB6:
                move.l  #Offset_0x046CC4, (A0)
                lea     Crushing_Column_Setup_Data_2(PC), A1   ; Offset_0x046CE4
                jsr     SetupObjectAttributes3(PC)                  ; Offset_0x041D7A
Offset_0x046CC4:                
                move.w  parent3(A0), A1                            ; $0046
                move.w  y_pos(A1), D0                                    ; $0014
                addi.w  #$00B0, D0
                move.w  D0, y_pos(A0)                                    ; $0014
                jmp     Child_Display_Or_Delete(PC)            ; Offset_0x04245C
;------------------------------------------------------------------------------- 
Crushing_Column_Setup_Data:                                    ; Offset_0x046CD8
                dc.l    Crushing_Column_Mappings               ; Offset_0x110938
                dc.w    $4001, $0280
                dc.b    $20, $70, $02, $00     
;-------------------------------------------------------------------------------
Crushing_Column_Setup_Data_2:                                  ; Offset_0x046CE4
                dc.w    $0280
                dc.b    $20, $40, $0D, $00 
;-------------------------------------------------------------------------------  
Offset_0x046CEA:    
                dc.w    $0000
                dc.l    Offset_0x046CB6
                dc.b    $00, $00       
;===============================================================================
; Objeto 0xB8 - Coluna na Icecap
; <<<- 
;===============================================================================  