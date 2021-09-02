	.text
main:
	pushl	%esi			# ESP ← <-> 4, [ESP] ← ESI
	pushl	%ebx			# ESP ← <-> 4, [ESP] ← EBX
	## i = 123
	movl	$123, %esi		# ESI ← 123
	## i = i + 1
	addl	$1, %esi		# ESI ← <+> 1
	## j = 456
	movl	$456, %ebx		# EBX ← 456
	## j = i + j
	addl	%esi, %ebx		# EBX ← <+> ESI
	## return j
	movl	%ebx, %eax		# EAX ← EBX
	popl	%ebx			# EBX ← [ESP], ESP ← <+> 4
	popl	%esi			# ESI ← [ESP], ESP ← <+> 4
	ret				# EIP ← [ESP], ESP ← <+> 4
