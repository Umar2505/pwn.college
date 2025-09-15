.intel_syntax noprefix
.globl _start

.section .text

_start:
    mov rdi, 2
    mov rsi, 1
    xor rdx, rdx
    mov rax, 41
    syscall
    mov r8, rax

    mov rbp, rsp
    push 0x00000000
    push 0x00000000
    push 0x00000000
    push 0x50000002

    mov rdi, r8
    mov rsi, rsp
    mov rdx, 16
    mov rax, 49
    syscall

    mov rdi, r8
    xor rsi, rsi
    mov rax, 50
    syscall

    mov rdi, r8
    mov rsi, 0
    mov rdx, 0
    mov rax, 43
    syscall

    mov r8, rax

    mov rax, 0x00000A0D0A0D302E
    push rax
    mov rax, 0x312F505454482067
    push rax
    mov rax, 0x616C662F20544547
    push rax
    
    mov rdi, r8
    mov rsi, rsp 
    mov rdx, 256
    mov rax, 0
    syscall

    mov rax, 0x00000000000A0D0A
    push rax
    mov rax, 0x0D4B4F2030303220
    push rax
    mov rax, 0x302E312F50545448
    push rax

    mov rdi, r8
    mov rsi, rsp
    mov rdx, 19
    mov rax, 1
    syscall

    mov rdi, r8
    mov rax, 3
    syscall

    mov rdi, 0
    mov rax, 60
    syscall

.section .data
