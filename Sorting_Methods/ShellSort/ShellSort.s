.section .data
    vector: .space 32
    msg: .string "Enter a value: "
    str: .string "%d |"
    msg1: .string "\nSorted Vector\n"

.text
.globl _start

_start:

    movl $0, %ebx       # Load the value 0 into ebx, which will be used as a counter
    leal vector, %edi   # Load the address of the vector into %edi
    call read_input     # Call the function to read input

    movl $0, %eax       # Set the value of eax to 0

    loadfactor:         # Calculate h; h = h * 3 while h < n
        cmpl $8, %eax
        jg endfactor
        addl $3, %eax
        jmp loadfactor

    endfactor:

    addl $1, %eax       # Add one to h

    leal vector, %edi   # Load the address of the vector into %edi
    call shellSort      # Call ShellSort function

    pushl $msg1
    call printf
    addl $4, %esp

    leal vector, %edi   # Load the address of the vector into %edi
    call show_vector    # Call the function to display the vector
    call exit


shellSort:

    beg:                # beg defines the outer while loop of ShellSort while (h > 0)

    movl $0, %edx       # Divide h by 3
    movl $3, %ebx
    div %ebx

    movl %eax, %ebx     # Set ebx as i, receiving the value of h

    call for            # Call the for loop (i = h; i < n; i++)

    cmpl $1, %eax       # Check for continuation of while h > 0
    jg beg

    ret

for:

    movl (%edi, %ebx, 4), %esi      # esi receives the value of array[i]
    movl %ebx, %ecx                 # ecx is initialized as i; j = i

    while:                          # Inner while loop while (j >= h && array[j - h] > c)
        movl %ecx, %edx             # Move j to edx
        subl %eax, %edx             # Subtract h from edx; calculating the position j - h

        movl (%edi, %edx, 4), %edx  # Move the value at array[j - h] into edx
        movl %edx, (%edi, %ecx, 4)  # array[j] = array[j - h]

        cmpl %esi, %edx             # Compare if c > array[j - h]
        jl end

        subl %eax, %ecx             # Subtract h from j

        cmpl %ecx, %eax             # Compare if j is greater than or equal to h
        jle while

    end:

    movl %esi, (%edi, %ecx, 4)      # array[j] = c
    addl $1, %ebx                   # Increment i
    cmp $7, %ebx                    # Check if i has reached the end of the vector
    jg return
    jmp for                         # Call for loop again

return:

    ret

read_input:
    pushl $msg      # Print the message asking for the value
    call printf
    addl $4, %esp

    pushl %edi      # Store the entered value in edi
    pushl $str
    call scanf
    addl $8, %esp   # Clear the arguments from the stack after the scanf call

    addl $1, %ebx   # Increment the counter and edi
    addl $4, %edi

    cmpl $8, %ebx   # Continue the loop if the counter is not 8
    jne read_input

    ret

show_vector:
    movl $0, %ebx  # Initialize the counter
    jmp show_vector_loop

show_vector_loop:
    movl (%edi, %ebx, 4), %eax  # Load the element of the vector into %eax

    pushl %eax
    pushl $str
    call printf
    addl $8, %esp         # Clear the arguments from the stack after the printf call

    addl $1, %ebx         # Move to the next element of the vector
    cmpl $8, %ebx
    jl show_vector_loop  # Continue the iteration while ebx < 8

    ret
