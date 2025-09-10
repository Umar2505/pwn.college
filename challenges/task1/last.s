.intel_syntax noprefix
.global _start
_start:
    mov rbp, rsp
    sub rsp, 512

zero_out:
    xor rcx, rcx
loop_z:
    cmp rcx, 256
    jge sec_start
    mov word ptr [rbp - 0x200 + rcx*2], 0
    inc rcx
    jmp loop_z

sec_start:
    xor rcx, rcx
loop1:
    cmp rcx, rsi
    jge done
    movzx r8, byte ptr [rdi+rcx]
    shl r8, 1
    movzx r9, word ptr [rbp - 0x200 + r8]
    inc r9w
    mov word ptr [rbp - 0x200 + r8], r9w
    inc rcx
    jmp loop1

done:
    xor rcx, rcx
    xor r8, r8
    xor r9, r9

loop2:
    cmp rcx, 0xff
    jg exit
    cmp word ptr [rbp - 0x200 + rcx*2], r8w
    jle nop
    mov r8w, word ptr [rbp - 0x200 + rcx*2]
    mov r9, rcx
nop:
    inc rcx
    jmp loop2

exit:
    mov rax, r9
    mov rsp, rbp
    ret
