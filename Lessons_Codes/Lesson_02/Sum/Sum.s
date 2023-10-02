.section .data 
	number1: .int 3
	number2: .int 5
	text: .asciz "%d\n"
.section .text 

.globl _start
_start:
	movl $number1, %eax
	movl $number2, %ebx

	addl %ebx, %eax
	pushl $text
	call printf
	
	call exit
