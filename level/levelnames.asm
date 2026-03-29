; \0   = end of line
; \x7C = "The"
; \x7D = "the"
; \x7E = "of"
; \x7F = "to"
; \x83 = "'"
; \x84 = " "
TitleText_00:
	dc.b	"floresta\0\x7E\x84lagoa\0azul"
	dc.b	$FF
TitleText_02:
	dc.b	"highwater\0pass"
	dc.b	$FF
TitleText_04:
	dc.b	"under\0skull\0mountain"
	dc.b	$FF
TitleText_07:
	dc.b	"isle\0\x7E\x84\x7D\0lion\0lord"
	dc.b	$FF
TitleText_08:
	dc.b	"hills\0\x7E\x84\x7D\0warrior"
	dc.b	$FF
TitleText_0A:
	dc.b	"windy\0city"
	dc.b	$FF
TitleText_0B:
	dc.b	"sinister\0sewers"
	dc.b	$FF
TitleText_0C:
	dc.b	"\x7C\0crystal\0crags"
	dc.b	$FF
TitleText_0E:
	dc.b	"dragonspike"
	dc.b	$FF
TitleText_0F:
	dc.b	"stormwalk\0mountain"
	dc.b	$FF
TitleText_10:
	dc.b	"shishkaboss"
	dc.b	$FF
TitleText_34:
	dc.b	"\x7C\0pinnacle"
	dc.b	$FF
TitleText_35:
	dc.b	"hidden\0canyon"
	dc.b	$FF
TitleText_11:
	dc.b	"\x7C\0whispering\0woods"
	dc.b	$FF
TitleText_13:
	dc.b	"devil\x83s\0marsh"
	dc.b	$FF
TitleText_15:
	dc.b	"knight\x83s\0isle"
	dc.b	$FF
TitleText_16:
	dc.b	"whale\0grotto"
	dc.b	$FF
TitleText_17:
	dc.b	"hoverboard\0beach"
	dc.b	$FF
TitleText_18:
	dc.b	"pyramids\0\x7E\0peril"
	dc.b	$FF
TitleText_19:
	dc.b	"madmaze\0mountain"
	dc.b	$FF
TitleText_1A:
	dc.b	"\x7C\0deadly\0skyscrapers"
	dc.b	$FF
TitleText_1B:
	dc.b	"skydragon\0castle"
	dc.b	$FF
TitleText_1D:
	dc.b	"coral\0blade\0grotto"
	dc.b	$FF
TitleText_1E:
	dc.b	"boomerang\0bosses"
	dc.b	$FF
TitleText_3E:
	dc.b	"bloody\0swamp"
	dc.b	$FF
TitleText_37:
	dc.b	"crab\0cove"
	dc.b	$FF
TitleText_39:
	dc.b	"\x7C\0forbidden\0tombs"
	dc.b	$FF
TitleText_3A:
	dc.b	"stairway\0\x7F\0oblivion"
	dc.b	$FF
TitleText_1F:
	dc.b	"woods\0\x7E\0despair"
	dc.b	$FF
TitleText_21:
	dc.b	"forced\0entry"
	dc.b	$FF
TitleText_22:
	dc.b	"\x7C\0cliffs\0\x7E\0illusion"
	dc.b	$FF
TitleText_23:
	dc.b	"lion\x83s\0den"
	dc.b	$FF
TitleText_24:
	dc.b	"wind\0castles"
	dc.b	$FF
TitleText_26:
	dc.b	"blizzard\0mountain"
	dc.b	$FF
TitleText_27:
	dc.b	"caves\0\x7E\0ice"
	dc.b	$FF
TitleText_28:
	dc.b	"\x7C\0nightmare\0peaks"
	dc.b	$FF
TitleText_2A:
	dc.b	"bagel\0brothers"
	dc.b	$FF
TitleText_3B:
	dc.b	"\x7C\0valley\0\x7E\0life"
	dc.b	$FF
TitleText_31:
	dc.b	"\x7C\0land\0below"
	dc.b	$FF
TitleText_3C:
	dc.b	"\x7C\0black\0pit"
	dc.b	$FF
TitleText_3D:
	dc.b	"frosty\0doom"
	dc.b	$FF
TitleText_2B:
	dc.b	"diamond\0edge"
	dc.b	$FF
TitleText_2C:
	dc.b	"\x7C\x84hills\0have\x84eyes"
	dc.b	$FF
TitleText_2D:
	dc.b	"secrets\0in\x84\x7D\0rocks"
	dc.b	$FF
TitleText_2E:
	dc.b	"ice\0god\x83s\0vengeance"
	dc.b	$FF
TitleText_2F:
	dc.b	"beneath\0\x7D\0twisted\0hills"
	dc.b	$FF
TitleText_30:
	dc.b	"alien\0isle"
	dc.b	$FF
TitleText_36:
	dc.b	"the\0caged\0beasts"
	dc.b	$FF
TitleText_33:
	dc.b	"plethora"
	dc.b	$FF
TitleText_3F:
	dc.b	"scorpion\0isle"
	dc.b	$FF
TitleText_40:
	dc.b	"towers\0\x7E\0blood"
	dc.b	$FF
TitleText_38:
	dc.b	"\x7C\0crypt"
	dc.b	$FF
TitleText_42:
	dc.b	"alien\0twilight"
	dc.b	$FF
TitleText_43:
	dc.b	"tunnels\0beneath\0\x7D\0woods"
	dc.b	$FF
TitleText_44:
	dc.b	"hills\0\x7E\0forever"
	dc.b	$FF
TitleText_45:
	dc.b	"monster\0island"
	dc.b	$FF
TitleText_46:
	dc.b	"\x7C\0shimmering\0caves"
	dc.b	$FF
TitleText_48:
	dc.b	"sky\0fortress"
	dc.b	$FF
TitleText_32:
	dc.b	"the\0final\0marathon"
	dc.b	$FF
TitleText_49:
	dc.b	"elsewhere"
	dc.b	$FF

	align	2

; Positions (x pos, y pos) in pixels of the lines in the title.
; The last row is the position of the level number, if the level has one.
; If a level title has no number, the last row can remain unused.
; Note: Lines refers to units separated by \0 bytes. For example, in the title
;   dc.b    "\x7C\x84hills\0have\x84eyes"
; "THE HILLS" is one line and "HAVE EYES" is one line.
TitleTextLayout_3Lines: ; last row is level number
	dc.w	$20, $28
	dc.w	$20, $48
	dc.w	$20, $68
	dc.w	$DC, $50
TitleTextLayout_2Lines: ; last row is level number
	dc.w	$20, $28
	dc.w	$20, $40
	dc.w	$DC, $3C
TitleTextLayout_4Lines: ; no level number here
	dc.w	$20, $28
	dc.w	$20, $3C
	dc.w	$20, $4C
	dc.w	$20, $5C
TitleTextLayout_3LinesDense: ; last row is level number. Less vertical spacing between lines.
	dc.w	$20, $28
	dc.w	$20, $3C
	dc.w	$20, $4C
	dc.w	$DC, $48
TitleTextLayout_1Line: ; no level number here
	dc.w	$20, $28

AddrTbl_LevelNames:   ;1A842
	levnamhdr	TitleText_00, TitleTextLayout_3Lines, 1	;  0
	levnamhdr	TitleText_00, TitleTextLayout_3Lines, 2	;  1
	levnamhdr	TitleText_02, TitleTextLayout_2Lines, 1	;  2
	levnamhdr	TitleText_02, TitleTextLayout_2Lines, 2	;  3
	levnamhdr	TitleText_04, TitleTextLayout_3Lines, 1	;  4
	levnamhdr	TitleText_04, TitleTextLayout_3Lines, 2	;  5
	levnamhdr	TitleText_04, TitleTextLayout_3Lines, 3	;  6
	levnamhdr	TitleText_07, TitleTextLayout_4Lines, 0	;  7
	levnamhdr	TitleText_08, TitleTextLayout_3LinesDense, 1	;  8
	levnamhdr	TitleText_08, TitleTextLayout_3LinesDense, 2	;  9
	levnamhdr	TitleText_0A, TitleTextLayout_2Lines, 0	;  A
	levnamhdr	TitleText_0B, TitleTextLayout_2Lines, 0	;  B
	levnamhdr	TitleText_0C, TitleTextLayout_3Lines, 1	;  C
	levnamhdr	TitleText_0C, TitleTextLayout_3Lines, 2	;  D
	levnamhdr	TitleText_0E, TitleTextLayout_3Lines, 0	;  E
	levnamhdr	TitleText_0F, TitleTextLayout_2Lines, 0	;  F
	levnamhdr	TitleText_10, TitleTextLayout_3Lines, 0	; 10
	levnamhdr	TitleText_11, TitleTextLayout_3Lines, 1	; 11
	levnamhdr	TitleText_11, TitleTextLayout_3Lines, 2	; 12
	levnamhdr	TitleText_13, TitleTextLayout_2Lines, 1	; 13
	levnamhdr	TitleText_13, TitleTextLayout_2Lines, 2	; 14
	levnamhdr	TitleText_15, TitleTextLayout_2Lines, 0	; 15
	levnamhdr	TitleText_16, TitleTextLayout_2Lines, 0	; 16
	levnamhdr	TitleText_17, TitleTextLayout_2Lines, 0	; 17
	levnamhdr	TitleText_18, TitleTextLayout_3Lines, 0	; 18
	levnamhdr	TitleText_19, TitleTextLayout_2Lines, 0	; 19
	levnamhdr	TitleText_1A, TitleTextLayout_3Lines, 0	; 1A
	levnamhdr	TitleText_1B, TitleTextLayout_2Lines, 1	; 1B
	levnamhdr	TitleText_1B, TitleTextLayout_2Lines, 2	; 1C
	levnamhdr	TitleText_1D, TitleTextLayout_3Lines, 0	; 1D
	levnamhdr	TitleText_1E, TitleTextLayout_2Lines, 0	; 1E
	levnamhdr	TitleText_1F, TitleTextLayout_3Lines, 1	; 1F
	levnamhdr	TitleText_1F, TitleTextLayout_3Lines, 2	; 20
	levnamhdr	TitleText_21, TitleTextLayout_2Lines, 0	; 21
	levnamhdr	TitleText_22, TitleTextLayout_4Lines, 0	; 22
	levnamhdr	TitleText_23, TitleTextLayout_2Lines, 0	; 23
	levnamhdr	TitleText_24, TitleTextLayout_2Lines, 1	; 24
	levnamhdr	TitleText_24, TitleTextLayout_2Lines, 2	; 25
	levnamhdr	TitleText_26, TitleTextLayout_2Lines, 0	; 26
	levnamhdr	TitleText_27, TitleTextLayout_3Lines, 0	; 27
	levnamhdr	TitleText_28, TitleTextLayout_3Lines, 1	; 28
	levnamhdr	TitleText_28, TitleTextLayout_3Lines, 2	; 29
	levnamhdr	TitleText_2A, TitleTextLayout_2Lines, 0	; 2A
	levnamhdr	TitleText_2B, TitleTextLayout_2Lines, 0	; 2B
	levnamhdr	TitleText_2C, TitleTextLayout_2Lines, 0	; 2C
	levnamhdr	TitleText_2D, TitleTextLayout_4Lines, 0	; 2D
	levnamhdr	TitleText_2E, TitleTextLayout_3Lines, 0	; 2E
	levnamhdr	TitleText_2F, TitleTextLayout_4Lines, 0	; 2F
	levnamhdr	TitleText_30, TitleTextLayout_2Lines, 0	; 30
	levnamhdr	TitleText_31, TitleTextLayout_3Lines, 0	; 31
	levnamhdr	TitleText_32, TitleTextLayout_3Lines, 0	; 32
	levnamhdr	TitleText_33, TitleTextLayout_3Lines, 0	; 33
	levnamhdr	TitleText_34, TitleTextLayout_2Lines, 0	; 34
	levnamhdr	TitleText_35, TitleTextLayout_2Lines, 0	; 35
	levnamhdr	TitleText_36, TitleTextLayout_3Lines, 0	; 36
	levnamhdr	TitleText_37, TitleTextLayout_2Lines, 0	; 37
	levnamhdr	TitleText_38, TitleTextLayout_2Lines, 0	; 38
	levnamhdr	TitleText_39, TitleTextLayout_3Lines, 0	; 39
	levnamhdr	TitleText_3A, TitleTextLayout_3Lines, 0	; 3A
	levnamhdr	TitleText_3B, TitleTextLayout_4Lines, 0	; 3B
	levnamhdr	TitleText_3C, TitleTextLayout_3Lines, 0	; 3C
	levnamhdr	TitleText_3D, TitleTextLayout_3Lines, 0	; 3D
	levnamhdr	TitleText_3E, TitleTextLayout_2Lines, 0	; 3E
	levnamhdr	TitleText_3F, TitleTextLayout_2Lines, 0	; 3F
	levnamhdr	TitleText_40, TitleTextLayout_3Lines, 0	; 40
	levnamhdr	TitleText_38, TitleTextLayout_2Lines, 0	; 41
	levnamhdr	TitleText_42, TitleTextLayout_2Lines, 0	; 42
	levnamhdr	TitleText_43, TitleTextLayout_4Lines, 0	; 43
	levnamhdr	TitleText_44, TitleTextLayout_3Lines, 0	; 44
	levnamhdr	TitleText_45, TitleTextLayout_2Lines, 0	; 45
	levnamhdr	TitleText_46, TitleTextLayout_3Lines, 0	; 46
	levnamhdr	TitleText_38, TitleTextLayout_2Lines, 0	; 47
	levnamhdr	TitleText_48, TitleTextLayout_2Lines, 0	; 48
	levnamhdr	TitleText_49, TitleTextLayout_1Line, 0	; 49
