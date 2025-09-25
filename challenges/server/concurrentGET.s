.intel_syntax noprefix
.globl _start

.section .bss
buffer:
    .skip 256      # buffer to read stdin
file_content:
    .skip 256

.section .data
mystring:
    .ascii "HTTP/1.0 200 OK\r\n\r\n"    # string, no null terminator

.section .text

_start:
    # socket
    mov rdi, 2
    mov rsi, 1
    xor rdx, rdx
    mov rax, 41
    syscall
    mov r12, rax

    mov rbp, rsp
    push 0x00000000
    push 0x00000000
    push 0x00000000
    push 0x50000002

    # bind
    mov rdi, r12
    mov rsi, rsp
    mov rdx, 16
    mov rax, 49
    syscall

    # listen
    mov rdi, r12
    xor rsi, rsi
    mov rax, 50
    syscall

parent:
    # accept
    mov rdi, r12
    mov rsi, 0
    mov rdx, 0
    mov rax, 43
    syscall
    mov rbx, rax

    # fork
    mov rax, 57
    syscall

    cmp rax, 0
    jl error
    je server

    mov rdi, rbx
    mov rax, 3
    syscall

    jmp parent
server:
    mov rdi, r12
    mov rax, 3
    syscall
    
    # read into buffer
    mov rax, 0          # syscall: read
    mov rdi, rbx         # fd = stdin
    lea rsi, [buffer]   # pointer to buffer
    mov rdx, 256        # max bytes to read
    syscall
    mov rcx, rax        # rcx = number of bytes read

    # --- skip first part until first space ---
    lea rdi, [buffer]   # rdi = pointer to buffer start

skip_first_space:
    cmp rcx, 0
    je done             # if buffer empty, done
    mov al, [rdi]
    cmp al, ' '         # check for space
    je found_first_space
    inc rdi
    dec rcx
    jmp skip_first_space

found_first_space:
    inc rdi             # move past the space
    dec rcx             # adjust remaining bytes
    mov r8, rdi         # r8 = start of path
    xor r9, r9          # counter

    # --- find second space to null-terminate ---
find_second_space:
    cmp rcx, 0
    je done             # end if no more bytes
    mov al, [rdi]
    cmp al, ' '
    je terminate_path
    inc rdi
    dec rcx
    inc r9
    jmp find_second_space
terminate_path:
    mov byte ptr [rdi], 0x00 

done:
# open
    mov rdi, r8
    mov rsi, 0
    mov rax, 2
    syscall
    mov r8, rax
# read opened file
    mov rdi, rax
    lea rsi, [file_content]
    mov rdx, 256
    mov rax, 0
    syscall
    mov r10, rax
# close file
    mov rax, 3
    mov rdi, r8
    syscall

# write
    mov rdi, rbx
    lea rsi, [mystring]
    mov rdx, 19
    mov rax, 1
    syscall

    mov rdi, rbx
    lea rsi, [file_content]
    mov rdx, r10
    mov rax, 1
    syscall

    mov rdi, 0
    mov rax, 60
    syscall
error:
    mov rdi, 1
    mov rax, 60
    syscall
