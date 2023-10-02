.section .data
    floatValue: .double 0.0
    stringFormat_Input: .string "%lf"
    stringFormat_Output: .string "%f\n"
    
    pularLinha: .string "\n"
    stringMessage_Input: .string "Insira um valor flutuante: "
    stringMessage_Output: .string "O valor flutuante é --> "

.section .text
.globl _start
_start:

#Estes devem primeiramente ser levados da memória para os registradores da FPU (Operação de carregamento - load)

# Após serem realizadas as operações desejadas, os dados devem ser retirados dos registradores da FPU e enviados novamente para a memória (Operação de armazenamento - store

# Carregar um dado na memória --> flds
# Armazenar um dado no topo da pilha 'FPU' na memória --> fsts
	# --> OBSERVAÇÃO: A instrução fstx não retira o dado da pilha FPU, apenas o copia.

# Remoção do dado no topo da pilha (pop da pilha FPU) --> fstpx.

# %st(0) --> Registrador que aponta para o 'TOPO DA PILHA'.

    pushl $pularLinha
    call printf
    addl $4, %esp

    # Imprime a mensagem de entrada.
    pushl $stringMessage_Input
    call printf
    addl $4, %esp

    # Recebe o valor de entrada (PF).
    leal floatValue, %eax         # Endereço da variável floatValue
    pushl %eax                    # Passa o endereço como argumento
    pushl $stringFormat_Input     # Formato de leitura
    call scanf
    addl $8, %esp           # Remove os argumentos da pilha
    
    # Imprime a mensagem de resultado.
    pushl $stringMessage_Output
    call printf
    addl $8, %esp

    # Imprime o valor na tela.
    fldl floatValue
    subl $8, %esp
    fstpl (%esp)
    pushl $stringFormat_Output
    call printf
    addl $4, %esp

# Encerra o programa
call exit
