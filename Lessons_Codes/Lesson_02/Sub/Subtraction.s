.section .data 
	number1: .int 3
	number2: .int 2
	text: .asciz "%d\n"
.section .text 

.globl _start
_start:
	movl $number1, %eax
	movl $number2, %ebx

	subl %eax, %ebx
	pushl $text
	call printf
	
	call exit
