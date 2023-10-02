.section .data

	Input: .asciz "\nDigite um valor (Single Float) => "
	Output: .asciz "\nValor de A = %.4f\n"
	format: .asciz "%f" # Simples Precisão
	float1: .space 4 
    float2: .space 4 

.section .text

.globl _start

_start:
	finit
	
	# Imprime a mensagem de entrada
	pushl $Input
	call printf

	# Recebe o valor do valor flutuante 1
	pushl $float1
	pushl $format
	call scanf
	addl $12, %esp

	# Imprime a mensagem de entrada
    	pushl $Input
	call printf
	
	# Recebe o valor do valor flutuante 2
	pushl $float2
	pushl $format
	call scanf
	addl $12, %esp

	# Empilha e Soma
	flds float1
    	flds float2
    	faddp

	subl $8, %esp
	fstl (%esp)
	
	# Imprime a mensagem de saída com o valor da soma.	
	pushl $Output
	call printf
	addl $4, %esp
    	pushl $0
   	
	# Encerra o programa
    	call exit
