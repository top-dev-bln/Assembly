section .data
    num db 50
    prompt db 'Guess a number between 1 and 99: ', 0
    prompt_len equ $-prompt
    too_low db 'Too low, try again: ', 0
    too_low_len equ $-too_low
    too_high db 'Too high, try again: ', 0
    too_high_len equ $-too_high
    end db 'You guessed it!', 0
    end_len equ $-end
   

section .bss
    guess resb 11

section .text
    global _start

_start:
    call generate
    mov rbx, rdx

    mov rax, 1             
    mov rdi, 1             
    mov rsi, prompt        
    mov rdx, prompt_len   
    syscall



game:

    mov rax, 0
    mov rdi, 0
    mov rsi, guess
    mov rdx, 11
    syscall

    movzx rax, byte [guess]
    sub rax, '0'   

    cmp rax, rbx
    je exit
    jl tl
    jg th




tl:
    mov rax, 1             
    mov rdi, 1             
    mov rsi, too_low        
    mov rdx, too_low_len  
    syscall
    jmp game


th:
    mov rax, 1             
    mov rdi, 1             
    mov rsi, too_high        
    mov rdx, too_high_len  
    syscall
    jmp game




exit:

    mov rax, 1
    mov rdi, 1
    mov rsi, end
    mov rdx, end_len
    syscall

    mov rax, 60           
    xor rdi, rdi           
    syscall



generate:
    rdtsc
    xor rdx, rdx
    mov rax, rdx
    
    mov rbx, 100000
    xor rdx, rdx
    div rbx

    mov rax, rdx
    xor edx, edx
    mov rbx, 100
    div rbx

    mov rax, rdx

    ret
