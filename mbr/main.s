	.file	"main.c"
	.code16gcc
	.text
	.section	.rodata
.LC0:
	.string	"welcome to vx-MBR"
.LC1:
	.string	"Backspace working!!"
.LC2:
	.string	">"
.LC3:
	.string	"help"
.LC4:
	.string	"quit"
.LC5:
	.string	"Sorry..."
.LC6:
	.string	"command not found"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	andl	$-16, %esp
	subl	$16, %esp
	call	clear
	movl	$.LC0, %ecx
	call	print
	movl	$nl, %ecx
	call	print
	movl	$.LC1, %ecx
	call	print
	movl	$nl, %ecx
	call	print
.L5:
	movl	$.LC2, %ecx
	call	print
	leal	11(%esp), %eax
	movl	%eax, %ecx
	call	read
	leal	11(%esp), %eax
	movl	$.LC3, %edx
	movl	%eax, %ecx
	call	compare
	testl	%eax, %eax
	je	.L2
	call	help
	jmp	.L5
.L2:
	leal	11(%esp), %eax
	movl	$.LC4, %edx
	movl	%eax, %ecx
	call	compare
	testl	%eax, %eax
	je	.L4
	movl	$.LC5, %ecx
	call	print
	movl	$nl, %ecx
	call	print
	jmp	.L5
.L4:
	leal	11(%esp), %eax
	movl	%eax, %ecx
	call	print
	movl	$.LC6, %ecx
	call	print
	movl	$nl, %ecx
	call	print
	jmp	.L5
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Debian 10.2.1-6) 10.2.1 20210110"
	.section	.note.GNU-stack,"",@progbits
