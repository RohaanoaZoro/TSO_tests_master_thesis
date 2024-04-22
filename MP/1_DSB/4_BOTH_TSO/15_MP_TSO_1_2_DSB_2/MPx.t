	;START _litmus_P0
	mov	w16, #1
	str	w16, [x14]
	mov	w15, #1
	str	w15, [x13]
	;START _litmus_P1
	ldr	w1, [x16]
	dsb	ld
	ldr	w0, [x17]
