	.file	"stage2.c"
	.code16gcc
	.text
	.section	.rodata
	.align 4
.LC0:
	.string	"Second stage loaded sucessuflly."
.LC1:
	.string	"Welcome to VX-OS"
	.text
	.globl	init
	.type	init, @function
init:
.LFB0:
	.cfi_startproc
	movl	$.LC0, %ecx
	call	print
	movl	$nl, %ecx
	call	print
	movl	$.LC1, %ecx
	call	print
	movl	$nl, %ecx
	call	print
	call	help
	call	OperatingSystem
	call	halt
	nop
	ud2
	.cfi_endproc
.LFE0:
	.size	init, .-init
	.section	.rodata
.LC2:
	.string	">"
.LC3:
	.string	"help"
.LC4:
	.string	"date"
.LC5:
	.string	"Current date is: "
.LC6:
	.string	"time"
.LC7:
	.string	"Current time is: "
.LC8:
	.string	"clear"
.LC9:
	.string	"play"
.LC10:
	.string	"quit"
	.text
	.globl	OperatingSystem
	.type	OperatingSystem, @function
OperatingSystem:
.LFB1:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
.L10:
	movl	$nl, %ecx
	call	print
	movl	$.LC2, %ecx
	call	print
	leal	-13(%ebp), %eax
	movl	%eax, %ecx
	call	read
	leal	-13(%ebp), %eax
	movl	$.LC3, %edx
	movl	%eax, %ecx
	call	compare
	testl	%eax, %eax
	je	.L3
	call	help
	jmp	.L4
.L3:
	leal	-13(%ebp), %eax
	movl	$.LC4, %edx
	movl	%eax, %ecx
	call	compare
	testl	%eax, %eax
	je	.L5
	movl	$.LC5, %ecx
	call	print
	call	get_date
	jmp	.L4
.L5:
	leal	-13(%ebp), %eax
	movl	$.LC6, %edx
	movl	%eax, %ecx
	call	compare
	testl	%eax, %eax
	je	.L6
	movl	$.LC7, %ecx
	call	print
	call	get_time
	jmp	.L4
.L6:
	leal	-13(%ebp), %eax
	movl	$.LC8, %edx
	movl	%eax, %ecx
	call	compare
	testl	%eax, %eax
	je	.L7
	call	clear
	jmp	.L4
.L7:
	leal	-13(%ebp), %eax
	movl	$.LC9, %edx
	movl	%eax, %ecx
	call	compare
	testl	%eax, %eax
	je	.L8
	call	game_init
.L8:
	leal	-13(%ebp), %eax
	movl	$.LC10, %edx
	movl	%eax, %ecx
	call	compare
	testl	%eax, %eax
	jne	.L12
.L4:
	jmp	.L10
.L12:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE1:
	.size	OperatingSystem, .-OperatingSystem
	.ident	"GCC: (Debian 10.2.1-6) 10.2.1 20210110"
	.section	.note.GNU-stack,"",@progbits
