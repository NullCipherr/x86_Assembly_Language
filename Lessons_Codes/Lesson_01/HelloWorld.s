.section .data
	text: .asciz "Hello World!\n"
.section .text

.globl _start
_start:
	movl $text, %eax
	pushl %eax
	call printf
	addl $4, %esp
	call exit	
