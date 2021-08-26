	.file	"game.c"
	.code16gcc
	.text
	.globl	game_init
	.type	game_init, @function
game_init:
.LFB0:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
#APP
# 4 "game.c" 1
	movb $0x00, %ah;movb $0x03, %al;int $0x10;movw $0xb800, %ax;movw %ax, %es;loop10:xor %di, %di;mov $80*25, %cx;rep stosw;jmp loop10;hlt;
# 0 "" 2
#NO_APP
	nop
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	game_init, .-game_init
	.ident	"GCC: (Debian 10.2.1-6) 10.2.1 20210110"
	.section	.note.GNU-stack,"",@progbits
