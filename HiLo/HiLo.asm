section .bss
    random_buffer resb 1
    num resb 10
    guess resb 10
section .data
    prompt db 'Guess a number between 1 and 99: ', 0
    prompt_len equ $ - prompt
    too_low_msg db 'Too low, try again: ', 0
    too_low_len equ $ - too_low_msg
    too_high_msg db 'Too high, try again: ', 0
    too_high_len equ $ - too_high_msg
    end db 'You guessed it!', 0
    end_len equ $ - end

section .text
    global _start

_start:

    mov rax, 1
    mov rdi, 1
    mov rsi, prompt
    mov rdx, prompt_len
    syscall

    mov rdi, random_buffer
    mov rdx, 1 
    mov rax, 318
    syscall

    movzx rax, byte [random_buffer]

    mov rbx, 100
    xor rdx, rdx
    div rbx
    mov rbx, rdx

game:
    mov rax, 0
    mov rdi, 0
    mov rsi, num
    mov rdx, 10
    syscall

    mov rsi, num
    call string_to_int
    mov rdx, rax

    cmp rdx, rbx
    je correct_guess
    jl too_low
    jg too_high

too_low:
    mov rax, 1
    mov rdi, 1
    mov rsi, too_low_msg
    mov rdx, too_low_len
    syscall
    jmp game

too_high:
    mov rax, 1
    mov rdi, 1
    mov rsi, too_high_msg
    mov rdx, too_high_len
    syscall
    jmp game

correct_guess:
    mov rax, 1
    mov rdi, 1
    mov rsi, end
    mov rdx, end_len
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall

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
