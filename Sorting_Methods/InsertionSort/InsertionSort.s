.section .data
    vetor: .space 32
    msg: .string "Digite um valor: "
    str: .string "%d|"
    msg1: .string "\nVetor ordenado\n"


.text
.globl _start

_start:

    movl $0, %ebx       # Carrega o valor 0 para ebx que sera usado como contador
    leal vetor, %edi    # Carrega o endereço do vetor em %edi
    call ler_input      # Chama função para ler input

    movl $0, %eax
    leal vetor, %edi    # Passa para edi o endereço em memoria do vetor
    call insertionSort      # Chama o insertionSort

    pushl $msg1
    call printf
    addl $4, %esp

    leal vetor, %edi    # Carrega o endereço do vetor em %edi
    call mostra_vetor   # Chama a função que exibe o vetor
    call exit


insertionSort:

    movl %eax, %ebx
    while:
        cmpl $1, %ebx
        jl endwhile

        movl %ebx, %ecx
        subl $1, %ecx
        movl (%edi, %ecx, 4), %esi
        movl (%edi, %ebx, 4), %edx

        cmpl %esi, %edx
        jg noswap

        movl %esi, (%edi, %ebx, 4)
        movl %edx, (%edi, %ecx, 4)

        noswap:

        subl $1, %ebx
        jmp while
    
    endwhile:

    addl $1, %eax
    cmpl $8, %eax
    jge return

    jmp insertionSort
    return:

    ret
ler_input:
    pushl $msg      # Imprime a mensagem pedindo o valor
    call printf
    addl $4, %esp

    pushl %edi      # Armazena o valor digitado em edi
    pushl $str
    call scanf
    addl $8, %esp   # Limpa os argumentos da pilha após a chamada para scanf

    addl $1, %ebx   # Incrementa contador e edi
    addl $4, %edi

    cmpl $8, %ebx   # Continua o laço se o contador não for 8
    jne ler_input

    ret

mostra_vetor:
    movl $0, %ebx  # Inicializa o contador
    jmp mostra_vetor_loop

mostra_vetor_loop:
    movl (%edi, %ebx, 4), %eax  # Carrega o elemento do vetor em %eax

    pushl %eax
    pushl $str
    call printf
    addl $8, %esp         # Limpa os argumentos da pilha após a chamada para printf

    addl $1, %ebx         # Avança para o próximo elemento do vetor
    cmpl $8, %ebx
    jl mostra_vetor_loop  # Continua a iteração enquanto ebx < 8

    ret
