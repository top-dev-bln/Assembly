section .bss
    num resb 1        ; Reserve one byte for the input number

section .text
    global _start

_start:
    ; Read a single character from stdin
    mov rax, 0        ; syscall number for sys_read
    mov rdi, 0        ; file descriptor 0 (stdin)
    mov rsi, num      ; address of buffer to store input
    mov rdx, 1        ; number of bytes to read
    syscall

    ; Check if input is valid ASCII character
    cmp byte [num], '0'
    jb invalid_input  ; If input is less than '0', exit
    cmp byte [num], '9'
    ja invalid_input  ; If input is greater than '9', exit

    ; Convert the ASCII character to an integer
    movzx rax, byte [num] ; Load the byte from buffer into rax
    sub rax, '0'      ; Convert ASCII character to integer ('0' = 48 in ASCII)

    ; Store the number in rbx
    mov rbx, rax

    ; Initialize the counter
    mov rcx, 1        ; Counter starts from 1

print_loop:
    ; Check if rcx > rbx
    cmp rcx, rbx
    jg done           ; If counter > number, exit loop

    ; Print the counter (convert number to ASCII)
    mov rax, 1        ; syscall number for sys_write
    mov rdi, 1        ; file descriptor 1 (stdout)
    mov rdx, 1        ; number of bytes to write
    add rcx, '0'      ; Convert integer to ASCII
    mov [num], cl     ; Store it in buffer
    mov rsi, num      ; Address of buffer to print
    syscall

    ; New line (print '\n')
    mov rax, 1        ; syscall number for sys_write
    mov rdi, 1        ; file descriptor 1 (stdout)
    mov rsi, newline  ; Address of newline character
    mov rdx, 1        ; number of bytes to write
    syscall

    ; Increment the counter
    mov rcx, [num]
    sub rcx, '0'
    inc rcx
    mov [num], cl

    ; Repeat the loop
    jmp print_loop

done:
    ; Exit the program
    mov rax, 60       ; syscall number for sys_exit
    xor rdi, rdi      ; exit code 0
    syscall

invalid_input:
    ; Exit the program with invalid input error code
    mov rax, 60       ; syscall number for sys_exit
    mov rdi, 1        ; exit code 1 (invalid input)
    syscall

section .data
newline db 0xA      ; Newline character
