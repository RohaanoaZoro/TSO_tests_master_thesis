	##START _litmus_P0
	movl	$1, (%rbx,%rdi,4)
	movl	$1, (%rcx,%rdi,4)
	##START _litmus_P1
	movl	(%r9,%rdx,4), %eax
	movl	(%rbx,%rdx,4), %ebp
