.section .data
    arr: .long 24, 23, 22, 21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0
    r: .long 25
    format: .string "%d "

.section .text
.globl _start

_start:
    # Initialize data segment
    movl $arr, %esi
    movl $0, %edi
    movl $25, %ecx  # Tamanho do array

    # Initialize the stack frame for printf
    pushl %ebp
    movl %esp, %ebp

print_loop:
    # Load the next array element into %eax
    movl (%esi, %edi, 4), %eax
    pushl %eax

    # Push the format string onto the stack
    pushl $format

    # Call printf
    call printf

    # Clean up the stack
    addl $8, %esp

    # Increment the index
    addl $1, %edi

    # Check if we have printed all elements
    cmpl %edi, r
    jne print_loop
    
end:
    pushl $0
    call exit
