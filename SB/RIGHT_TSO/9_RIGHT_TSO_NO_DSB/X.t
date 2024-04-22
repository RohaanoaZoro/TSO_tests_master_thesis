	;START _litmus_P0
	mov	w0, #1
	str	w0, [x15]
	ldr	w17, [x16]
	;START _litmus_P1
	mov	w0, #1
	str	w0, [x15]
	ldr	w17, [x16]
