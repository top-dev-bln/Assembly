section .bss
    num resb 1     
    ascii_char resb 1 

section .data   
    newline db 0x0A   
    fib1 dw 1
    fib2 dw 1
    sum dw 0
    

section .text
    global _start


_start:

    mov rax, 0        
    mov rdi, 0       
    mov rsi, num     
    mov rdx, 1       
    syscall

    
    movzx rax, byte [num] 
    sub rax, '0'     


    mov rbx, rax


    mov rcx, 1  

    cmp rbx, 1
    jl exit

init:
    movzx rax, word [fib1]
    add rax, '0'
    mov [ascii_char], al

    mov rdi, 1
    mov rsi, ascii_char
    mov rdx, 1
    mov rax, 1
    syscall
    cmp rbx, 1
    je exit

    
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    mov rax, 1
    syscall

    movzx rax, word [fib2]
    add rax, '0'
    mov [ascii_char], al
    dec rbx

    mov rdi, 1
    mov rsi, ascii_char
    mov rdx, 1
    mov rax, 1
    syscall

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
    mov [sum], ax

    mov ax, [fib2]
    mov [fib1], ax
    
    mov ax, [sum]
    mov [fib2], ax



    movzx rax, word [sum]
    add rax, '0'
    mov [ascii_char], al

    mov rdi, 1
    mov rsi, ascii_char
    mov rdx, 1
    mov rax, 1
    syscall

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