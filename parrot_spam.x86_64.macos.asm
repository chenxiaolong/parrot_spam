default rel

global _main

extern _strlen
extern _write

section .data

    nothing_to_repeat: db "Nothing to repeat", 10, 0
    nothing_to_repeat_len: equ $-nothing_to_repeat

section .text

_main:
    push rbp
    mov rbp, rsp

    ; Give us 32 bytes of stack space and leave stack aligned to 16 bytes
    ; [rbp]              : item_count : int32   : 4 bytes
    ; [rbp - 8]          : items      : char ** : 8 bytes
    ; [rbp - 16]         : r12 backup : [data]  : 8 bytes
    ; [rbp - 24]         : r13 backup : [data]  : 8 bytes
    ; [rbp - 32]         : r14 backup : [data]  : 8 bytes
    ; [rbp - 40]         : r15 backup : [data]  : 8 bytes
    ; [rbp - 40 - 8 * N] : argv sizes : size_t  : 8 bytes * N
    sub rsp, 40

    ; Initialize item_count and items, skipping argv[0]
    mov dword [rbp], edi
    mov qword [rbp - 8], rsi
    sub dword [rbp], 1
    add qword [rbp - 8], 8
    ; Backup callee saved registers
    mov [rbp - 16], r12
    mov [rbp - 24], r13
    mov [rbp - 32], r14
    mov [rbp - 40], r15

    ; Allocate space on stack to store the size for each item
    mov eax, [rbp]
    shl rax, 3
    sub rsp, rax

    ; Align stack to 16 bytes
    and rsp, -16

    ; Callee saved registers
    ; r12d | counter | uint | 4 bytes
    ; r13d | offset  | uint | 4 bytes
    ; r14d | avail   | uint | 4 bytes
    ; r15d | total   | uint | 4 bytes

    ; Initialize counter registers
    xor r12d, r12d
    xor r13d, r13d
    ; Slack supports up to 4000 bytes
    mov r14d, 4000
    ; Clear total bytes counter
    xor r15d, r15d

    ;; Calculate sizes
argv_strlen_loop:
    ; Stop when index >= number of items
    cmp r12d, [rbp]
    jge argv_strlen_loop_done

    ; Calculate offset
    mov r13d, r12d
    shl r13d, 3

    ; Load pointer to current item
    mov rbx, [rbp - 8]
    add rbx, r13

    ; Increment current index
    inc r12d

    ; Call strlen
    mov rdi, [rbx]
    mov al, 0
    call _strlen

    ; Save length on stack
    lea rbx, [rbp - 48]
    sub rbx, r13
    mov [rbx], rax

    ; Add to total
    add r15, rax

    ; Loop again
    jmp argv_strlen_loop

argv_strlen_loop_done:

    ; Fail if total length is empty
    cmp r15, 0
    je empty_input

    ; Reset index to 0
    xor r12d, r12d

    ;; Parrot print
argv_print_loop:
    ; Calculate offset
    mov r13d, r12d
    shl r13d, 3

    ; Load pointer to current item
    mov rbx, [rbp - 8]
    add rbx, r13

    ; Load pointer to current size
    lea rcx, [rbp - 48]
    sub rcx, r13

    ; Increment current index with wrapping
    inc r12d
    cmp r12d, [rbp]
    jl argv_print_loop_no_wrap
    xor r12d, r12d

argv_print_loop_no_wrap:
    ; Stop if we don't have enough bytes available
    cmp r14, [rcx]
    jl success
    sub r14, [rcx]

    ; Print item
    mov rdi, 1
    mov rsi, [rbx]
    mov rdx, [rcx]
    mov al, 0
    call _write

    ; Loop again
    jmp argv_print_loop

success:
    ; Set exit code
    mov rax, 0

done:
    ; Restore callee saved registers
    mov r12, [rbp - 16]
    mov r13, [rbp - 24]
    mov r14, [rbp - 32]
    mov r15, [rbp - 40]

    mov rsp, rbp
    pop rbp
    ret

empty_input:
    mov rdi, 2
    lea rsi, [nothing_to_repeat]
    mov rdx, nothing_to_repeat_len
    mov al, 0
    call _write

    ; Set exit code
    mov rax, 1
    jmp done
