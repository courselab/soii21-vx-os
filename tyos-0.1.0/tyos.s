	.file	"tyos.c"
	.code16gcc
	.text
	.section	.rodata
.LC0:
	.string	"System halted"
	.text
	.globl	halt
	.type	halt, @function
halt:
.LFB0:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	movl	$.LC0, %ecx
	call	print
	movl	$nl, %ecx
	call	print
#APP
# 29 "tyos.c" 1
	loop15:           ;        hlt       ;        jmp loop15;
# 0 "" 2
#NO_APP
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	halt, .-halt
	.globl	read
	.type	read, @function
read:
.LFB1:
	.cfi_startproc
	movl	%ecx, %edx
	movl	%edx, %ebx
#APP
# 37 "tyos.c" 1
	   mov $0x0, %si               ;loop30:                         ;   movw $0X0, %ax              ;   int $0x16                    ;   cmp $0x08, %al             ;   jne not_backspace30          ;   dec %si                     ;   mov $0x0e, %ah              ;   int $0x10                    ;   mov $0x20, %al              ;   int $0x10                    ;   mov $0x08, %al              ;   int $0x10                    ;   jmp loop30                   ;   not_backspace30:             ;   movb %al, %es:(%bx, %si) ;   inc %si                     ;   cmp $0xd, %al               ;   mov   $0x0e, %ah            ;   int $0x10                    ;   jne loop30                   ; mov $0x0e, %ah                ; mov $0x0a, %al                ;   int $0x10                    ;   movb $0x0, -1(%bx, %si)    ;   ret                           
# 0 "" 2
#NO_APP
	nop
	ud2
	.cfi_endproc
.LFE1:
	.size	read, .-read
	.section	.rodata
	.align 4
.LC1:
	.string	"-----------------List of commands-----------------\n"
.LC2:
	.string	"help - display this list\n"
	.align 4
.LC3:
	.string	"date - display the date dd/mm/yyyy\n"
	.align 4
.LC4:
	.string	"time - display the time hh:mm:ss\n"
	.align 4
.LC5:
	.string	"play - play a game (not implemented at all)\n"
.LC6:
	.string	"clear - clear screen\n"
.LC7:
	.string	"quit - exit\n"
	.text
	.globl	help
	.type	help, @function
help:
.LFB2:
	.cfi_startproc
	movl	$.LC1, %ecx
	call	print
	movl	$nl, %ecx
	call	print
	movl	$.LC2, %ecx
	call	print
	movl	$nl, %ecx
	call	print
	movl	$.LC3, %ecx
	call	print
	movl	$nl, %ecx
	call	print
	movl	$.LC4, %ecx
	call	print
	movl	$nl, %ecx
	call	print
	movl	$.LC5, %ecx
	call	print
	movl	$nl, %ecx
	call	print
	movl	$.LC6, %ecx
	call	print
	movl	$nl, %ecx
	call	print
	movl	$.LC7, %ecx
	call	print
	movl	$nl, %ecx
	call	print
#APP
# 88 "tyos.c" 1
	ret
# 0 "" 2
#NO_APP
	nop
	ud2
	.cfi_endproc
.LFE2:
	.size	help, .-help
	.globl	compare
	.type	compare, @function
compare:
.LFB3:
	.cfi_startproc
	movl	%ecx, %ebx
	movl	%edx, %edi
	movl	%ebx, %esi
#APP
# 92 "tyos.c" 1
	    mov $4, %cx   ;    mov $0x1, %ax     ;    cld                ;    repe  cmpsb        ;    jecxz  equal       ;    mov $0x0, %ax     ;equal:                 ;    ret                ;
# 0 "" 2
#NO_APP
	movl	$0, %eax
	ud2
	.cfi_endproc
.LFE3:
	.size	compare, .-compare
	.globl	get_date
	.type	get_date, @function
get_date:
.LFB4:
	.cfi_startproc
#APP
# 112 "tyos.c" 1
	    movb $0x04, %ah   ;    clc                ;    int $0x1A          ;    movb $0x0e, %ah   ;    movb %dl, %al    ;    shr $0x04, %al    ;    add $0x30, %al    ;    int $0x10          ;    movb %dl, %al    ;    andb $0x0F, %al    ;    add  $0x30, %al    ;    int  $0x10          ;    movb $0x2F, %al    ;    int  $0x10          ;    movb %dh, %al    ;    shr $0x04, %al    ;    add $0x30, %al    ;    int $0x10          ;    movb %dh, %al    ;    andb $0x0F, %al    ;    add  $0x30, %al    ;    int  $0x10          ;    movb $0x2F, %al    ;    int  $0x10          ;    movb %ch, %al    ;    shr $0x04, %al    ;    add $0x30, %al    ;    int $0x10          ;    movb %ch, %al    ;    andb $0x0F, %al    ;    add  $0x30, %al    ;    int  $0x10          ;    movb %cl, %al    ;    shr $0x04, %al    ;    add $0x30, %al    ;    int $0x10          ;    movb %cl, %al    ;    andb $0x0F, %al    ;    add  $0x30, %al    ;    int  $0x10          ;    ret    ;
# 0 "" 2
#NO_APP
	nop
	ud2
	.cfi_endproc
.LFE4:
	.size	get_date, .-get_date
	.globl	get_time
	.type	get_time, @function
get_time:
.LFB5:
	.cfi_startproc
#APP
# 171 "tyos.c" 1
	    movb $0x02, %ah   ;    clc                ;    int $0x1A          ;    movb $0x0e, %ah   ;    movb %ch, %al    ;    shr $0x04, %al    ;    add $0x30, %al    ;    int $0x10          ;    movb %ch, %al    ;    andb $0x0F, %al    ;    add  $0x30, %al    ;    int  $0x10          ;    movb $0x3A, %al    ;    int  $0x10          ;    movb %cl, %al    ;    shr $0x04, %al    ;    add $0x30, %al    ;    int $0x10          ;    movb %cl, %al    ;    andb $0x0F, %al    ;    add  $0x30, %al    ;    int  $0x10          ;    movb $0x3A, %al    ;    int  $0x10          ;    movb %dh, %al    ;    shr $0x04, %al    ;    add $0x30, %al    ;    int $0x10          ;    movb %dh, %al    ;    andb $0x0F, %al    ;    add  $0x30, %al    ;    int  $0x10          ;    ret    ;
# 0 "" 2
#NO_APP
	nop
	ud2
	.cfi_endproc
.LFE5:
	.size	get_time, .-get_time
	.ident	"GCC: (Debian 10.2.1-6) 10.2.1 20210110"
	.section	.note.GNU-stack,"",@progbits
