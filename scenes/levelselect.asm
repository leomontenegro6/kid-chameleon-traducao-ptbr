LevelSelect_ChkKey:
	btst	#6,(Ctrl_1_Held).w   ;Ctrl_1_Held
	sne	(LevelSelect_Flag).w
	jmp	(j_loc_6E2).w

LevelSelect_Init:
	move.w	#-1,(LevelSelect_PrevSelected).w	; force mismatch on first frame

LevelSelect_Loop:
	jsr	(j_Hibernate_Object_1Frame).w
	jsr	(sub_1CC88).l
	movem.l	d0-d3/a0-a3,-(sp)
	bsr.w	LevelSelect_UpdateMarquee
	bsr.w	LevelSelect_DrawText
	movem.l	(sp)+,d0-d3/a0-a3
	move.w	#73,d6
	bsr.s	LevelSelect_Input
	bclr	#7,(Ctrl_1_Pressed).w
	beq.s	LevelSelect_Loop

;LevelSelect_Exit:
	move.w	(Options_Selected_Option).w,(Current_LevelID).w
	bra.w	CostumeSelect
; ---------------------------------------------------------------------------
; d6 = max number of options
LevelSelect_Input:
	move.w	(Options_Selected_Option).w,d7
	bclr	#0,(Ctrl_Pressed).w
	beq.s	++	; UP pressed?
	jsr	(sub_1BC26).l	; play selection sound
	subq.w	#1,d7
	btst	#6,(Ctrl_Held).w
	beq.s	+	; A held?
	subq.w	#6,d7
+
	tst.w	d7
	bpl.s	+
	clr.w	d7
+
	bclr	#1,(Ctrl_Pressed).w
	beq.s	++	; DOWN pressed?
	jsr	(sub_1BC26).l	; play selection sound
	addq.w	#1,d7
	btst	#6,(Ctrl_Held).w
	beq.s	+	; A held?
	addq.w	#6,d7
+
	cmp.w	d6,d7
	ble.s	+
	move.w	d6,d7
+
	move.w	d7,(Options_Selected_Option).w
	rts

; ---------------------------------------------------------------------------
; DrawLevelSelectName
; Based on DrawIntroText: PREFIX-style accents (accent byte BEFORE the letter).
; Input:  a4 = pointer to null-terminated string
;         d2 = row
;         d3.w = tile base (palette + font - $41):
;                  normal:   $C509
;                  selected: $E509
;         a6 = VDP base ($C00000)
DrawLevelSelectName:
	subq.w	#1,d2		; clear accent row (row - 1)
	bsr.w	.clear_row
	addq.w	#1,d2		; clear text row (d2 restored to original)
	bsr.w	.clear_row

	; If selected line, skip LevelSelect_MarqueeOffset visual columns
	cmpi.w	#$E509,d3
	bne.s	.start_draw
	move.w	(LevelSelect_MarqueeOffset).w,d0
	beq.s	.start_draw

.skip_loop:
	move.b	(a4)+,d6
	beq.s	.done
	cmpi.b	#$C2,d6
	beq.s	.skip_loop
	cmpi.b	#TILDE,d6
	beq.s	.skip_accent
	cmpi.b	#ACCUTE,d6
	beq.s	.skip_accent
	cmpi.b	#CIRCUMFLEX,d6
	beq.s	.skip_accent
	subq.w	#1,d0
	bne.s	.skip_loop
	bra.s	.start_draw

.skip_accent:
	; prefix accent: consume following letter too (counts as 1 visual column)
	move.b	(a4)+,d6
	beq.s	.done
	subq.w	#1,d0
	bne.s	.skip_loop

.start_draw:
	move.w	#7,d1		; starting column
	move.w	#26,d0		; max 26 visible columns
.loop:
	moveq	#0,d6
	move.b	(a4)+,d6
	beq.s	.done

	cmpi.b	#$C2,d6		; skip UTF-8 leader byte
	beq.s	.loop

	cmpi.b	#TILDE,d6
	beq.s	.accent
	cmpi.b	#ACCUTE,d6
	beq.s	.accent
	cmpi.b	#CIRCUMFLEX,d6
	beq.s	.accent

	subq.w	#1,d0
	bmi.s	.done		; exceeded 26 columns
	bsr.s	.write_tile
	addq.w	#1,d1
	bra.s	.loop

.accent:
	; Prefix accent: draw glyph one row above, without advancing column.
	subq.w	#1,d2
	bsr.s	.write_tile
	addq.w	#1,d2
	bra.s	.loop

.done:
	rts

.write_tile:
	move.w	d2,d5
	lsl.w	#7,d5		; row * $80 bytes (plane width)
	add.w	d1,d5
	add.w	d1,d5		; + column * 2
	move.w	d5,d4
	andi.w	#$3FFF,d4
	ori.w	#$4000,d4
	swap	d4
	rol.w	#2,d5
	andi.w	#3,d5
	move.w	d5,d4
	move.l	d4,4(a6)	; VDP VRAM write command
	move.b	d6,d5
	subi.b	#$41,d5
	ext.w	d5
	add.w	d3,d5
	move.w	d5,(a6)		; write tile
	rts

.clear_row:
	; Clear 26 tiles in row d2, columns 7..32
	move.w	#7,d1
	move.w	#25,d0		; 26 tiles (0..25)
.clr_loop:
	move.w	d2,d5
	lsl.w	#7,d5
	add.w	d1,d5
	add.w	d1,d5
	move.w	d5,d4
	andi.w	#$3FFF,d4
	ori.w	#$4000,d4
	swap	d4
	rol.w	#2,d5
	andi.w	#3,d5
	move.w	d5,d4
	move.l	d4,4(a6)
	move.w	#0,(a6)
	addq.w	#1,d1
	dbf	d0,.clr_loop
	rts

; ---------------------------------------------------------------------------
LevelSelect_DrawText:
	move.w	(Options_Selected_Option).w,d6
	subq.w	#3,d6		; first visible LevelID
	move.w	#$A,d2		; starting row
	move.w	#8,d0		; 9 entries (dbf 8..0)
LevelSelect_DrawText_Loop:
	; Select tile base: row $10 = selected
	move.w	#$C509,d3
	cmpi.w	#$10,d2
	bne.s	+
	move.w	#$E509,d3
+
	; Bounds check
	tst.w	d6
	bmi.s	LevelSelect_DrawText_Blank
	cmpi.w	#73,d6
	bgt.s	LevelSelect_DrawText_Blank

	; Map LevelID to index in LevelNamesText
	move.w	d6,d7
	cmpi.w	#FirstElsewhere_LevelID,d7
	blt.s	+
	moveq	#FirstElsewhere_LevelID,d7
+
	moveq	#0,d5
	move.b	d7,d5

	; Find string at index d5 in LevelNamesText
	lea	LevelNamesText(pc),a4
	tst.b	d5
	beq.s	LevelSelect_DrawText_Call
	subq.w	#1,d5
-
	tst.b	(a4)+
	bne.s	-
	dbf	d5,-
	bra.s	LevelSelect_DrawText_Call

LevelSelect_DrawText_Blank:
	lea	LevelSelect_DrawText_Empty(pc),a4

LevelSelect_DrawText_Call:
	movem.w	d0/d6,-(sp)
	bsr.w	DrawLevelSelectName
	movem.w	(sp)+,d0/d6

	addq.w	#1,d6
	addq.w	#2,d2
	dbf	d0,LevelSelect_DrawText_Loop
	rts

LevelSelect_DrawText_Empty:
	dc.b	0
	align	2

; ---------------------------------------------------------------------------
; LevelSelect_UpdateMarquee
; Updates the marquee scroll state for the selected item.
; Must be called once per frame inside LevelSelect_Loop.
LevelSelect_UpdateMarquee:
	move.w	(Options_Selected_Option).w,d7
	cmp.w	(LevelSelect_PrevSelected).w,d7
	beq.s	.timer_update
	; Selection changed: reset marquee and recompute max offset
	move.w	d7,(LevelSelect_PrevSelected).w
	clr.w	(LevelSelect_MarqueeOffset).w
	move.w	#60,(LevelSelect_MarqueeTimer).w
	bra.w	LevelSelect_ComputeMaxOffset	; tail call

.timer_update:
	tst.w	(LevelSelect_MarqueeMaxOffset).w
	beq.s	.done			; text fits in 26 columns, no scrolling needed
	subq.w	#1,(LevelSelect_MarqueeTimer).w
	bne.s	.done

	move.w	(LevelSelect_MarqueeOffset).w,d7
	addq.w	#1,d7
	cmp.w	(LevelSelect_MarqueeMaxOffset).w,d7	; single memory read
	bhi.s	.reset_marquee		; offset > max: wrap
	move.w	d7,(LevelSelect_MarqueeOffset).w
	blt.s	.step			; offset < max: short delay
	move.w	#60,(LevelSelect_MarqueeTimer).w	; offset == max: end pause
	bra.s	.done

.reset_marquee:
	clr.w	(LevelSelect_MarqueeOffset).w
	move.w	#60,(LevelSelect_MarqueeTimer).w
	bra.s	.done

.step:
	move.w	#8,(LevelSelect_MarqueeTimer).w	; fall through to .done

.done:
	rts

; ---------------------------------------------------------------------------
; LevelSelect_ComputeMaxOffset
; Counts visual columns of the selected level name and stores
; LevelSelect_MarqueeMaxOffset = max(0, length - 26).
LevelSelect_ComputeMaxOffset:
	move.w	(Options_Selected_Option).w,d7
	cmpi.w	#FirstElsewhere_LevelID,d7
	blt.s	+
	moveq	#FirstElsewhere_LevelID,d7
+
	moveq	#0,d5
	move.b	d7,d5
	lea	LevelNamesText(pc),a4
	tst.b	d5
	beq.s	+
	subq.w	#1,d5
-
	tst.b	(a4)+
	bne.s	-
	dbf	d5,-
+
	moveq	#0,d7
.count_loop:
	move.b	(a4)+,d6
	beq.s	.count_done
	cmpi.b	#$C2,d6
	beq.s	.count_loop
	cmpi.b	#TILDE,d6
	beq.s	.count_accent
	cmpi.b	#ACCUTE,d6
	beq.s	.count_accent
	cmpi.b	#CIRCUMFLEX,d6
	beq.s	.count_accent
	addq.w	#1,d7
	bra.s	.count_loop
.count_accent:
	; accent + letter = 1 visual column
	move.b	(a4)+,d6
	beq.s	.count_done
	addq.w	#1,d7
	bra.s	.count_loop
.count_done:
	subi.w	#26,d7
	bgt.s	+
	moveq	#0,d7
+
	move.w	d7,(LevelSelect_MarqueeMaxOffset).w
	rts

; ---------------------------------------------------------------------------
;x_pos: #7
;y_pos: d4
LevelSelect_make_cmd:
	moveq	#0,d5
	move.w	d4,d5
	lsl.w	#7,d5	; *$80, width of a plane in bytes
	add.w	#$E,d5	; + 2*x_pos
	asl.l	#2,d5
	lsr.w	#2,d5
	add.w	#$4000,d5
	swap	d5

	move.w	#$C509,d7
	tst.b	d3		; set palette line
	beq.s	+
	move.w	#$E509,d7
+
	jsr	(j_sub_914).w
	move.l	d5,4(a6)
	rts
; ---------------------------------------------------------------------------
CostumeSelect:
	clr.w	(Options_Selected_Option).w
	move.w	#-1,(CostumeSelect_PrevOption).w

	; Allocate GfxObject for costume preview sprite ($12=1: kid mode, tiles DMA'd automatically)
	move.l	#$2000000,a3
	jsr	(j_Load_GfxObjectSlot).w
	move.l	a3,(CostumeSelect_PreviewObj).w
	st	$13(a3)			; enable display
	move.b	#1,$12(a3)		; kid mode: tiles DMA'd from ROM to VRAM $C4A0 each frame
	move.b	#1,priority(a3)		; high priority: sprite appears over background tiles
	move.b	#3,palette_line(a3)	; palette 3
	move.w	#$120,x_pos(a3)		; x anchor (xcenter will be subtracted)
	; y_pos = Camera_Y_pos + $C0: sprite appears at screen-Y $C0 regardless of camera scroll
	move.w	(Camera_Y_pos).w,d0
	add.w	#$C0,d0
	move.w	d0,y_pos(a3)
	lea	(off_79B2).l,a4
	move.w	(a4),d0			; Data_Index byte offset for costume 0
	move.w	d0,addroffset_sprite(a3)
	; Pre-load costume 0 tiles directly to VRAM $C4A0 (bypasses $FFFFFB49 DMA gate)
	lea	(Data_Index).l,a1
	move.l	(a1,d0.w),a1		; a1 = sprite_frame_unc for costume 0
	bsr.w	CostumeSelect_LoadTilesToVRAM

	; Load costume 0 palette
	moveq	#0,d7
	jsr	(sub_80D0).l

	move.w	#$A,d4

CostumeSelect_loop:
	bsr.w	LevelSelect_make_cmd
	move.w	#$1A,d3		; line width
-
	move.w	#0,(a6)	; clear
	dbf	d3,-

	jsr	(j_sub_924).w
	addq.w	#2,d4
	cmpi.w	#$1E,d4
	blt.s	CostumeSelect_loop

	bclr	#7,(Ctrl_Pressed).w

-:
	jsr	(j_Hibernate_Object_1Frame).w
	jsr	(sub_1CC88).l
	movem.l	d0-d3/a0-a3,-(sp)
	bsr.w	CostumeSelect_UpdatePreview
	bsr.w	CostumeSelect_DrawText
	movem.l	(sp)+,d0-d3/a0-a3
	move.w	#9,d6
	bsr.w	LevelSelect_Input
	bclr	#7,(Ctrl_1_Pressed).w
	beq.s	-

;CostumeSelect_Exit:
	move.w	(Options_Selected_Option).w,d7
	move.w	d7,(Current_Helmet).w
	lea	(unk_7EC2).l,a4	; helmet hitpoints
	move.b	(a4,d7.w),d7
	move.w	d7,(Number_Hitpoints).w
	;move.w	d7,(Extra_hitpoint_slots).w
	;add soundtest: jsr	($E1328).l
	clr.w	($FFFFFBCC).w
	st	($FFFFFBCE).w
	st	($FFFFFC36).w

	jsr	(j_sub_8C2).w
	move.w	#8,(Game_Mode).w
	jsr	(j_StopMusic).l
	jmp	(j_loc_6E2).w
; ---------------------------------------------------------------------------
CostumeSelect_DrawText:
	move.b	#9,(LevelSelect_ActNumber).w

-
	moveq	#0,d5
	move.b	(LevelSelect_ActNumber).w,d5
	cmp.w	(Options_Selected_Option).w,d5
	seq	d3
	lea	CostumeTextOffsets(pc),a4
	add.w	d5,d5
	add.w	(a4,d5.w),a4
	jsr	(DrawTextLine_Offset).l
	sub.b	#1,(LevelSelect_ActNumber).w
	bge.s	-
	rts

; ---------------------------------------------------------------------------
; Updates costume preview: palette, GfxObject frame, and tiles.
CostumeSelect_UpdatePreview:
	move.w	(Options_Selected_Option).w,d7
	cmp.w	(CostumeSelect_PrevOption).w,d7
	beq.s	+
	move.w	d7,(CostumeSelect_PrevOption).w
	jsr	(sub_80D0).l			; update palette (destroys d7)
	move.w	(CostumeSelect_PrevOption).w,d7
	add.w	d7,d7				; word index
	lea	(off_79B2).l,a1
	move.w	(a1,d7.w),d7			; d7 = Data_Index byte offset for this costume
	move.l	(CostumeSelect_PreviewObj).w,a3
	move.w	d7,addroffset_sprite(a3)	; update GfxObject sprite frame
	; Write tiles directly to VRAM $C4A0 (bypasses $FFFFFB49 DMA gate)
	lea	(Data_Index).l,a1
	move.l	(a1,d7.w),a1			; a1 = sprite_frame_unc for this costume
	bsr.w	CostumeSelect_LoadTilesToVRAM
+	rts

; ---------------------------------------------------------------------------
; CostumeSelect_LoadTilesToVRAM
; Writes sprite art tiles directly to VRAM at tile $625 ($C4A0).
; Input:  a1 = pointer to sprite_frame_unc data
;         a6 = VDP_data_port ($C00000, global convention)
; Clobbers: d0, d1, a1
CostumeSelect_LoadTilesToVRAM:
	move.w	2(a1),d0		; width in pixels
	addq.w	#7,d0
	lsr.w	#3,d0			; ceil(width/8) in 8px cells
	move.w	4(a1),d1		; height in pixels
	addq.w	#7,d1
	lsr.w	#3,d1			; ceil(height/8) in 8px cells
	mulu.w	d1,d0			; total tiles
	lsl.w	#4,d0			; * 16 words per tile (32 bytes / 2)
	subq.w	#1,d0			; dbf loop count
	move.l	#vdpComm($C4A0,VRAM,WRITE),4(a6)	; set VRAM write address
	lea	6(a1),a1		; skip 6-byte header, point to art data
-	move.w	(a1)+,(a6)		; write word to VDP data port
	dbf	d0,-
	rts

; ---------------------------------------------------------------------------
CostumeTextOffsets:
	dc.w	cost0-CostumeTextOffsets
	dc.w	cost1-CostumeTextOffsets
	dc.w	cost2-CostumeTextOffsets
	dc.w	cost3-CostumeTextOffsets
	dc.w	cost4-CostumeTextOffsets
	dc.w	cost5-CostumeTextOffsets
	dc.w	cost6-CostumeTextOffsets
	dc.w	cost7-CostumeTextOffsets
	dc.w	cost8-CostumeTextOffsets
	dc.w	cost9-CostumeTextOffsets
; ---------------------------------------------------------------------------
CostumeTexts:
cost0:	dc.b	0,  0, "NONE", 0
cost1:	dc.b	0,  2, "SKYCUTTER", 0
cost2:	dc.b	0,  4, "CYCLONE", 0
cost3:	dc.b	0,  6, "REDmSTEALTH", 0
cost4:	dc.b	0,  8, "EYECLOPS", 0
cost5:	dc.b	0, $A, "JUGGERNAUT", 0
cost6:	dc.b	0, $C, "IRONmKNIGHT", 0
cost7:	dc.b	0, $E, "BERZERKER", 0
cost8:	dc.b	0,$10, "MANIAXE", 0
cost9:	dc.b	0,$12, "MICROMAX", 0

; ---------------------------------------------------------------------------
; Level name strings.
; PREFIX accent encoding: accent byte comes BEFORE the letter.
;   TILDE ($58)      = tilde  (ã, õ)
;   ACCUTE ($5A)     = acute  (á, é, í, ó, ú)
;   CIRCUMFLEX ($6A) = circumflex (â, ê)
;   Ç → C (cedilla not supported by this font)
; Charset Mapping
	charset '~',TILDE
	charset '1',$5C
	charset '2',$5D
	charset '3',$5E
	charset '4',$5F
	charset '5',$60
	charset '6',$61
	charset '7',$62
	charset '8',$63
	charset '9',$64
	charset '0',$65
	charset '.',$66
	charset	$B4,ACCUTE
	charset ',',$68
	charset '!',$69
	charset '^',CIRCUMFLEX
	charset '(',$6B
	charset ')',$6C
LevelNamesText:
	dc.b "MATAS DO LAGO AZUL 1",0			; 0
	dc.b "MATAS DO LAGO AZUL 2",0			; 1
	dc.b "PASSAGEM RIO ACIMA 1",0			; 2
	dc.b "PASSAGEM RIO ACIMA 2",0			; 3
	dc.b "MONTANHA DEBAIXO DA CAVEIRA 1",0	; 4
	dc.b "MONTANHA DEBAIXO DA CAVEIRA 2",0	; 5
	dc.b "MONTANHA DEBAIXO DA CAVEIRA 3",0	; 6
	dc.b "ILHA DO LORDE LE~AO",0			; 7
	dc.b "COLINAS DO GUERREIRO 1",0			; 8
	dc.b "COLINAS DO GUERREIRO 2",0			; 9
	dc.b "CIDADE VENTOSA",0					; A
	dc.b "ESGOTOS SINISTROS",0				; B
	dc.b "AS FRAGAS CRISTALINAS 1",0		; C
	dc.b "AS FRAGAS CRISTALINAS 2",0		; D
	dc.b "PICO DO DRAG~AO",0				; E
	dc.b "MONTANHA TEMPESTUOSA",0			; F
	dc.b "SHISHKACHEFE",0					; 10
	dc.b "AS MATAS SUSSURRANTES 1",0		; 11
	dc.b "AS MATAS SUSSURRANTES 2",0		; 12
	dc.b "BREJO DO DIABO 1",0				; 13
	dc.b "BREJO DO DIABO 2",0				; 14
	dc.b "ILHA DO CAVALEIRO",0				; 15
	dc.b "GRUTA DA BALEIA",0				; 16
	dc.b "PRAIA DA PRANCHA",0				; 17
	dc.b "PIR^AMIDES DO PERIGO",0			; 18
	dc.b "MONTANHA EMARANHADA",0			; 19
	dc.b "OS ARRANHA-C´EUS MORTAIS",0		; 1A
	dc.b "CASTELO DO DRAG~AO CELESTE 1",0	; 1B
	dc.b "CASTELO DO DRAG~AO CELESTE 2",0	; 1C
	dc.b "GRUTA DO CORAL CORTANTE",0		; 1D
	dc.b "CHEFES BUMERANGUES",0				; 1E
	dc.b "MATAS DO DESESPERO 1",0			; 1F
	dc.b "MATAS DO DESESPERO 2",0			; 20
	dc.b "ENTRADA FORCADA",0				; 21
	dc.b "AS FAL´ESIAS DA ILUS~AO",0		; 22
	dc.b "COVIL DO LE~AO",0					; 23
	dc.b "CASTELOS DOS VENTOS 1",0			; 24
	dc.b "CASTELOS DOS VENTOS 2",0			; 25
	dc.b "MONTANHA DA NEVASCA",0			; 26
	dc.b "CAVERNAS DE GELO",0				; 27
	dc.b "OS PICOS DO PESADELO 1",0			; 28
	dc.b "OS PICOS DO PESADELO 2",0			; 29
	dc.b "IRM~AOS BAGEL",0					; 2A
	dc.b "BORDA DIAMANTINA",0				; 2B
	dc.b "AS COLINAS T^EM OLHOS",0			; 2C
	dc.b "SEGREDOS NAS ROCHAS",0			; 2D
	dc.b "VINGANCA DO DEUS DO GELO",0		; 2E
	dc.b "AL´EM DAS COLINAS TORCIDAS",0		; 2F
	dc.b "ILHA ALIEN´IGENA",0				; 30
	dc.b "A TERRA ABAIXO",0					; 31
	dc.b "A MARATONA FINAL",0				; 32
	dc.b "PLETORA",0						; 33
	dc.b "O PIN´ACULO",0					; 34
	dc.b "DESFILADEIRO OCULTO",0			; 35
	dc.b "AS BESTAS ENJAULADAS",0			; 36
	dc.b "ENSEADA DO SIRI",0				; 37
	dc.b "A CRIPTA 1",0						; 38
	dc.b "AS TUMBAS PROIBIDAS",0			; 39
	dc.b "ESCADARIA DO ESQUECIMENTO",0		; 3A
	dc.b "O VALE DA VIDA",0					; 3B
	dc.b "O POCO NEGRO",0					; 3C
	dc.b "PERDIC~AO G´ELIDA",0				; 3D
	dc.b "P^ANTANO SANGRENTO",0				; 3E
	dc.b "ILHA DO ESCORPI~AO",0				; 3F
	dc.b "TORRES DE SANGUE",0				; 40
	dc.b "A CRIPTA 2",0						; 41
	dc.b "CREP´USCULO ALIEN´IGENA",0		; 42	
	dc.b "T´UNEIS MATAS ABAIXO",0			; 43
	dc.b "COLINAS DO ETERNO",0				; 44
	dc.b "ILHA DOS MONSTROS",0				; 45
	dc.b "AS CAVERNAS CINTILANTES",0		; 46
	dc.b "A CRIPTA 3",0						; 47
	dc.b "FORTALEZA CELESTE",0				; 48
	dc.b "LUGAR QUALQUER",0					; 49

	charset

	align	2
