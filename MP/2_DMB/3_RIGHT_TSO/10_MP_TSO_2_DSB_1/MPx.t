	;START _litmus_P0
	mov	w16, #1
	str	w16, [x14]
	dmb	st
	mov	w15, #1
	str	w15, [x13]
	;START _litmus_P1
	ldr	w1, [x16]
	ldr	w0, [x17]
