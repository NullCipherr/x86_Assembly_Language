.section .data
pedido1: .asciz "\nDigite um valor (single float) => "
mostra1: .asciz "\nValor de A = %.4f\n"
formato1: .asciz "%f" # para simples precisao
float1: .space 4 # aqui tbem pode ser .single
    float2: .space 4 # aqui tbem pode ser .single

.section .text

.globl _start

_start:

finit

pushl $pedido1
call printf

pushl $float1
pushl $formato1
call scanf
addl $12, %esp

    pushl $pedido1
call printf

pushl $float2
pushl $formato1
call scanf
addl $12, %esp

flds float1
    flds float2
    faddp

subl $8, %esp

fstl (%esp)

pushl $mostra1
call printf
addl $4, %esp

    pushl $0
   
    call exit
