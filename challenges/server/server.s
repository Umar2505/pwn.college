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

    mov rdi, 0
    mov rax, 60
    syscall

.section .data
