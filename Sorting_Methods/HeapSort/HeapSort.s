.section .data
    vetor: .space 32
    msg: .string "Digite um valor: "
    str: .string "%d|"
    msg1: .string "\nVetor ordenado\n"
    tamver: .int 8

.text
.globl _start

_start:

    movl $0, %ebx       # Carrega o valor 0 para ebx que sera usado como contador
    leal vetor, %edi    # Carrega o endereço do vetor em %edi
    call ler_input      # Chama função para ler input

    movl $0, %eax
    leal vetor, %edi    # Passa para edi o endereço em memoria do vetor
    call heapSort      # Chama o HeapSort

    pushl $msg1
    call printf
    addl $4, %esp

    leal vetor, %edi    # Carrega o endereço do vetor em %edi
    call mostra_vetor   # Chama a função que exibe o vetor
    call exit


# Definições:
# eax = i
# ebx = pai
# ecx = filho
# edx = t

heapSort:
    movl tamver, %eax       # Seta o valor de i em n
    movl $0, %edx
    movl $2, %ebx
    div %ebx                # Divide i por 2
    call firstWhile         # Chama o laço while externo; while(true)
    ret

firstWhile:

    cmpl $0, %eax                   # Verifica se i é zero, caso for vai para o else; if(i > 0)
    jle else
    
    subl $1, %eax                   # Subtrai um do  i
    movl (%edi, %eax, 4), %edx      # t = array[i]

    jmp noelse

    else:
    subl $1, tamver                 # Subtrai 1 de n
    movl tamver, %esi               
    cmpl $0, %esi                   # Verifica se n = 0; caso for retorna
    jle return
    movl (%edi, %esi, 4), %edx      # Passa o valor de array[n] para t
    movl (%edi), %ebp               # Passa o valor de array[0] para ebp
    movl %ebp, (%edi, %esi, 4)      # array[n] = array[0]

    noelse:                         # Jump para caso o else não seja necessário

    movl %eax, %ebx                 # Pai = i
    movl %eax, %ecx                 # Filho = i
    imul $2, %ecx                   # Filho = i * 2
    addl $1, %ecx                   # Filho = i * 2 + 1

    innerWhile:                     # Laço while interno; while(filho < n)
        cmpl tamver, %ecx           # Compara n com filho, caso seja maior é o fim do while
        jge endInnerWhile

        movl %ecx, %esi             # Usa o registrador esi como auxiliar para armazenar filho
        addl $1, %esi               # Esi é igual filho + 1
        
        cmpl tamver, %esi           # Verifica se filho + 1 é menor do que n
        jge secondIf                # Pula para segundo if

        movl (%edi, %esi, 4), %esi  # Passa o valor de array[filho + 1] para esi

        cmpl %esi, (%edi, %ecx, 4)  # Verifica se array[filho + 1] é menor que array[filho]
        jg secondIf                 # Pula para o segundo if

        addl $1, %ecx               # O primeiro if foi satisfeito, logo incrementa filho; if(filho+1 < n && array[filho + 1] > array[filho])

        secondIf:                   # Segundo if; if(array[filho] > t)

        cmpl (%edi, %ecx, 4), %edx  # Se t < array[filho] então if não é satisfeito e acaba o while
        jg endInnerWhile

        movl (%edi, %ecx, 4), %esi  # Passa o valor de array[filho] para esi
        movl %esi, (%edi, %ebx, 4)  # array[pai] = array[filho]
        movl %ecx, %ebx             # pai = filho
        imul $2, %ecx               # filho = filho * 2
        addl $1, %ecx               # filho = filho * 2 + 1

        jmp innerWhile              # Pula para próxima iteração do while

    endInnerWhile:                  # Fim do while interno

    movl %edx, (%edi, %ebx, 4)      # array[pai] = t
    jmp firstWhile                  # Pula para próxima iteração do while externo
    return:                         # Retorna a função quebrando o while(true)
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
