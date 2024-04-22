	;START _litmus_P0
	mov	w0, #1
	str	w0, [x15]
	dsb	st
	ldr	w17, [x16]
	dsb	ld
	;START _litmus_P1
	mov	w0, #1
	str	w0, [x15]
	dsb	st
	ldr	w17, [x16]
	dsb	ld
