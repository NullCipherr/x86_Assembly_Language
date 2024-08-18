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

    movl $7, %eax
    leal vetor, %edi    # Passa para edi o endereço em memoria do vetor
    call bubbleSort      # Chama o bubbleSort

    pushl $msg1
    call printf
    addl $4, %esp

    leal vetor, %edi    # Carrega o endereço do vetor em %edi
    call mostra_vetor   # Chama a função que exibe o vetor
    call exit

# Definições
# eax = n
# ebx = i

bubbleSort:
    cmpl $0, %eax       # Compara n com 0, para o laço while(n > 0)
    jl endBubbleSort

    subl $1, %eax       # Subtrai 1 de n
    movl $0, %ebx       # Zera o contador usando no for; for(i = 0; i < n; i++)
    call for            # Chama o laço for

    jmp bubbleSort      # Continua a iteração do while

    endBubbleSort:      # Fim do bubble sort
    ret

for:
    cmpl %eax, %ebx                 # Verifica se i > n, caso for é o fim do laço for
    jg endFor

    movl %ebx, %edx                 # Armazena a posição i+1 em edx
    addl $1, %edx

    movl (%edi, %ebx, 4), %ecx      # Salva em ecx o valor de array[i]
    movl (%edi, %edx, 4), %esi      # Salva em esi o valor de array[i+1]

    cmpl %esi, %ecx                 # Se array[i] > array[i+1] não realiza o swap
    jl noswap

    movl %ecx, (%edi, %edx, 4)      # Passa o valor de array[i] para array[i+1]
    movl %esi, (%edi, %ebx, 4)      # Passa o valor de array[i+1] para array[i]
    
    noswap:
    
    addl $1, %ebx                   # Incrementa i
    
    jmp for                         # Chama próxima iteração do for
    
    endFor:                         # Fim do laço, retorna para a função
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
