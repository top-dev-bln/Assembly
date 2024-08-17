section .bss
    num resb 10
    ascii_char resb 21

section .data   
    newline db 0x0A   
    fib1 dq 1
    fib2 dq 1
    sum dq 0

section .text
    global _start

_start:
    mov rax, 0
    mov rdi, 0
    mov rsi, num
    mov rdx, 10
    syscall

    call string_to_int
    mov rbx, rax

    cmp rbx, 1
    jl exit

    mov rax, [fib1]
    call print_number

    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    mov rax, 1
    syscall

    cmp rbx, 1
    je exit

    mov rax, [fib2]
    call print_number
    dec rbx

    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    mov rax, 1
    syscall
    dec rbx
   
fib:
    cmp rbx, 0
    je exit

    mov rax, [fib1]
    add rax, [fib2]
    mov [sum], rax

    mov rax, [fib2]
    mov [fib1], rax
    
    mov rax, [sum]
    mov [fib2], rax

    call print_number

    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    mov rax, 1
    syscall

    dec rbx
    jmp fib

exit:
    mov rax, 60
    xor rdi, rdi
    syscall

print_number:
    mov rsi, ascii_char + 20
    mov byte [rsi], 0

.convert_loop:
    mov rdx, 0
    mov rcx, 10
    div rcx
    add dl, '0'
    dec rsi
    mov [rsi], dl

    test rax, rax
    jnz .convert_loop

    mov rdx, ascii_char + 20
    sub rdx, rsi
    mov rdi, 1
    mov rax, 1
    syscall
    ret

string_to_int:
    xor rax, rax
    xor rcx, rcx

.convert_digit:
    movzx rdx, byte [rsi + rcx]
    cmp dl, 0x0A
    je .done
    sub dl, '0'
    imul rax, rax, 10
    add rax, rdx
    inc rcx
    jmp .convert_digit

.done:
    ret
