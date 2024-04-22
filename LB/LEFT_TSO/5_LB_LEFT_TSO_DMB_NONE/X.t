	;START _litmus_P0
	ldr	w17, [x15]
	mov	w0, #1
	str	w0, [x16]
	;START _litmus_P1
	ldr	w17, [x15]
	mov	w0, #1
	str	w0, [x16]
