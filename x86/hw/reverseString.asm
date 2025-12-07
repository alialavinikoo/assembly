section .data
    msg db 'Result'        ; Our string
    len equ $ - msg        ; Calculate the length of the string

section .text
    global _start

_start:
    mov ecx, len           ; Load the length of the string into ECX
    dec ecx                 ; Decrement ECX to point to the last character in the string
    mov esi, msg           ; Load the address of the first character into ESI
    mov edi, msg           ; Load the address of the first character into EDI
    add edi, ecx           ; Move EDI to the last character of the string

myloop:
    cmp esi, edi           ; Check if the pointers have met or crossed
    jge endloop            ; If they have, we're done

    mov al, [esi]          ; Load the character at ESI into AL
    mov dl, [edi]          ; Load the character at EDI into DL
    mov [esi], dl          ; Store DL (the character from EDI) at ESI
    mov [edi], al          ; Store AL (the character from ESI) at EDI

    inc esi                ; Move ESI to the next character
    dec edi                ; Move EDI to the previous character
    jmp myloop             ; Repeat the loop

endloop:
    ; Output the string
    mov edx, len           ; Message length
    mov ecx, msg           ; Address of message
    mov ebx, 1             ; File descriptor (stdout)
    mov eax, 4             ; sys_write syscall
    int 0x80               ; Call kernel

    ; Exit program
    mov eax, 1             ; sys_exit syscall
    xor ebx, ebx           ; Exit code 0
    int 0x80               ; Call kernel
