section .data
    mprime db 'prime'        
    len1 equ $ - mprime        ; Calculate the length of the string
    mnotprime db 'not prime'        
    len2 equ $ - mnotprime        ; Calculate the length of the string

section .text
    global _start

_start:
    mov eax, 133
    mov ecx, 2

myloop:
    mov ebx, ecx
    imul ebx, ebx
    cmp ebx, eax
    jg prime
    
    push eax
    xor edx, edx
    idiv ecx
    pop eax
    
    cmp edx, 0
    jz notprime
    
    inc ecx
    jmp myloop
   

prime:
    ; Output the string
    mov edx, len1         ; Message length
    mov ecx, mprime           ; Address of message
    mov ebx, 1             ; File descriptor (stdout)
    mov eax, 4             ; sys_write syscall
    int 0x80               ; Call kernel
    
    ; Exit program
    mov eax, 1             ; sys_exit syscall
    xor ebx, ebx           ; Exit code 0
    int 0x80               ; Call kernel
    
notprime:
    ; Output the string
    mov edx, len2          ; Message length
    mov ecx, mnotprime      ; Address of message
    mov ebx, 1             ; File descriptor (stdout)
    mov eax, 4             ; sys_write syscall
    int 0x80               ; Call kernel
    
    ; Exit program
    mov eax, 1             ; sys_exit syscall
    xor ebx, ebx           ; Exit code 0
    int 0x80               ; Call kernel
