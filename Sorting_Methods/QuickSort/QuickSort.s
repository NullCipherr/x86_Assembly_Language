.section .data
    vetor: .space 32
    msg: .string "Digite um valor: "
    str: .string "%d|"
    msg1: .string "\nVetor ordenado\n|"
    cabecario: .string "\nQuickSort\nAlunos:\nLeonardo Ribeiro Goulart Ra: 115642\nFelipe Piassa Antonucci Esperanca Ra: 112647\nAndrei Roberto da Costa Ra: 107975\n\n"
    aux: .int 

.text
.globl _start

_start:

    pushl $cabecario
    call printf
    addl $4, %esp

    movl $0, %ebx       # Carrega o valor 0 para ebx que sera usado como contador
    leal vetor, %edi    # Carrega o endereço do vetor em %edi
    call ler_input      # Chama função para ler input

    leal vetor, %edi    # Carrega o endereço do vetor em edi
    movl $0, %eax       # Seta eax como lado esquerdo
    movl $7, %ebx       # Seta ebx como lado direito

    call quicksort      # Chama o quicksort

    pushl $msg1
    call printf
    addl $4, %esp

    leal vetor, %edi    # Carrega o endereço do vetor em %edi
    call mostra_vetor   # Chama a função que exibe o vetor
    call exit

# Implementação do quicksort usando pilha;
# Para isso será utilizado a pilha comum do assembly
# Antes de chamar a função quickSort eax é iniciado como lado esquerdo
# ebx é iniciado como lado direto e usamos o -1 para marcar fim da pilha
# do quicksort

quicksort:
    pushl $-1                           # Colocamos o marcador de pilha vazia
    pushl %eax                          # Colocamos o lado esquerdo na pilha
    pushl %ebx                          # Colocamos o lado direito na pilha

    while:
    
    cmpl $-1, (%esp)                    # Verificamos se a pilha está vazia                
    je endwhile

    popl %ebx                           # Ebx é o indice extremo direito
    popl %eax                           # Eax é o indice extremo esquerdo

    movl (%edi, %ebx, 4), %ecx          # Definimos ecx como elemento pivo
    movl %eax, %edx                     # Movemos o lado esquerdo para edx
    subl $1, %edx                       # Decrementamos edx

    movl %eax, %ebp                     # Ebp sera usado como iterador j
    for:                                # for(j = eax; j <= ebx; j++)
        cmpl %ebp, %ebx
        jle endfor

        cmpl %ecx, (%edi, %ebp, 4)      # Verificamos se o pivo é menor que vetor[j], caso for pulamos a iteração
        jg noif

        addl  $1, %edx                  # Incrementamos edx

        movl (%edi, %edx, 4), %esi      # O codigo abaixo realiza a troca dos valores de j e edx
        movl %esi, aux
        movl (%edi, %ebp, 4), %esi
        movl %esi, (%edi, %edx, 4)
        movl aux, %esi
        movl %esi, (%edi, %ebp, 4)

        noif:                           # Incrementamos o contador
        addl $1,  %ebp
        jmp for
    
    endfor:

    addl $1, %edx                       # Incrementamos edx
    movl (%edi, %edx, 4), %esi          # Realiza troca dos elementos vetor[edx] e vetor[ebx]
    movl %esi, aux
    movl (%edi, %ebx, 4), %esi
    movl %esi, (%edi, %edx, 4)
    movl aux, %esi
    movl %esi, (%edi, %ebx, 4)
    
    subl $1, %edx                       # Subtrai um de edx
    cmpl %edx, %eax                     # Verifica se edx é maior que o lado esquerdo
    jge nor1

    pushl %eax                          # Empilha o lado esquerdo e direito
    pushl  %edx

    nor1:

    addl $2, %edx                       # Incrementa em 2 edx, devido ao decremento anterior
    cmpl %edx, %ebx                     # Verifica se edx é menor que o lado direito
    jle nor2

    pushl %edx                          # Empilha o lado direito e esquerdo
    pushl %ebx

    nor2:                               

    jmp while                           # Continua o while

    endwhile:

    popl %eax                           # Retira da pilha o marcador de fim de pilha do quicksort

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
