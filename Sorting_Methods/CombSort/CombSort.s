.section .data
    vetor: .space 32
    msg: .string "Digite um valor: "
    str: .string "%d|"
    pos: .int 0
    fator: .int 0
    msg1: .string "\nVetor ordenado\n|"
    cabecario: .string "\CombSort\nAlunos:\nLeonardo Ribeiro Goulart Ra: 115642\nFelipe Piassa Antonucci Esperanca Ra: 112647\nAndrei Roberto da Costa Ra: 107975\n\n"
    
.text
.globl _start

_start:

    pushl $cabecario
    call printf
    addl $4, %esp

    movl $0, %ebx       # Carrega o valor 0 para ebx que sera usado como contador
    leal vetor, %edi    # Carrega o endereço do vetor em %edi
    call ler_input      # Chama função para ler input

    movl $8, %edx       # Passa o tamanho do vetor para ebx que sera usado para calcular a posição com base no fator
    call comb_loop      # Chama a função de combsort

    pushl $msg1
    call printf
    addl $4, %esp

    leal vetor, %edi    # Carrega o endereço do vetor em %edi
    call mostra_vetor   # Chama a função que exibe o vetor
 
    call exit

comb_loop:

    imul $10, %edx      # Multiplica o valor de ebx por 10 para evitar usar ponto flutuante

    movl $0, fator      # Seta o valor do fator em 0
    movl $0, pos        # Seta a posição de swap que sera calculada em zero
    call calcula_pos    # Calcula a posição para swap

    subl $1, pos        # Subtrai 1 da posição de swap visto que ela sempre conta 1 a mais
    movl pos, %edx      # Passa o valor da posição de swap para edx

    movl %edx, %ebx     # Passa o valor de edx para ebx que sera usado como em um laço de repetição até chegar no fim do vetor
    leal vetor, %edi    # Seta o valor de edi no inicio do vetor
    leal vetor, %esi    # Seta o valor de esi no inicio do vetor
    movl %edx, %eax     # Passa o valor de edx para eax, visto que é necessário calcular os bits referentes a posição de swap
    imul $4, %eax       # Multiplica eax por 4 calculando os bits da posição de swap
    addl %eax, %esi     # Soma eax em esi, sendo assim esi agora aponta para a posição de swap
    call swap_loop      # Chama a função que realiza swap

    cmpl $1, %edx       # Verificar se edx é um, se não for continua o laço
    jg comb_loop
    ret


# Com o intuito de evitar uso de pontos flutuantes foi criado essa função
# ela armazena em pos o numero de vezes que podemos somar 13 ao fator antes
# dele se tornar maior que ebx. Veja que no comb sort seria calculado assim
# Pos = 8/1,3 = 6, nesse caso podemos somar 13 sete vezes antes de ultrapassar
# 80, e por isso pos é sempre decrementado em um na função comb sort

calcula_pos:
    addl $1, pos        # Adiciona um a pos
    addl $13, fator     # Adiciona 13 no fator
    cmpl %edx, fator    # Verifica se o fator é menor que edx, caso for repete
    jl calcula
    ret

calcula:
    jmp calcula_pos # Laço auxiliar para chamar calcula_pos

# Função swap loop passa pelos elementos comparando e trocando caso estejam em ordem
# decrescente. Faz isso de i até n - pos, comparando os elementos i com os elementos
# na posição i + pos

swap_loop:

    movl (%edi), %ecx   # Passa o valor do elemento i para ecx
    movl (%esi), %eax   # Passa o valor do elemento i+pos para eax

    cmpl %ecx, %eax     # Compara os elementos e pula se estiverem em ordem decrescente
    jl swap

    addl $4, %edi       # Realiza incremento dos ponteiros e do contador
    addl $4, %esi
    inc %ebx

    cmpl $8, %ebx       # Continua o loop se o contador não for igual a 8
    jle swap_loop

    ret

# Função para trocar o valor de dois elementos

swap:

    movl %ecx, (%esi)   # Passa o valor de ecx para o endereço de memoria de esi
    movl %eax, (%edi)   # Passa o valor de eax para o endereço de memori de edi
    addl $4, %edi       # Realiza incremento dos contadores e chama o loop de swap
    addl $4, %esi
    inc %ebx

    jmp swap_loop

# Função para ler o vetor 

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
