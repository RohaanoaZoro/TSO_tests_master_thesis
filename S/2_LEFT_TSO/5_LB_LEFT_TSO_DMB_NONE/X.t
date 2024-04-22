	;START _litmus_P0
	mov	w16, #2
	str	w16, [x14]
	mov	w15, #1
	str	w15, [x13]
	;START _litmus_P1
	ldr	w17, [x15]
	mov	w0, #1
	str	w0, [x16]
