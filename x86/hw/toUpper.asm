section .data
    msg db 'Hello, world!', 0x0A ; Our message with a newline at the end
    len equ $ - msg               ; Calculate length of the message (exclude the null terminator)

section .text
    global _start

_start:
    ; Initialize the pointer to the message
    mov esi, msg             ; Load the address of the string into ESI
    mov ecx, len             ; Load the length of the string into ECX

convert_loop:
    mov al, [esi]            ; Load the current character from the string into AL
    cmp al, 'a'              ; Check if it's less than 'a'
    jb skip                  ; If less than 'a', skip the character
    cmp al, 'z'              ; Check if it's greater than 'z'
    ja skip                  ; If greater than 'z', skip the character

    sub al, 32               ; Convert lowercase to uppercase (ASCII difference)
    mov [esi], al            ; Store the converted character back in the string

skip:
    inc esi                  ; Move to the next character in the string
    loop convert_loop        ; Decrement ECX and continue if ECX != 0

    ; Output the string to stdout
    mov edx, len             ; Load the string length into EDX
    mov ecx, msg             ; Load the address of the string into ECX
    mov ebx, 1               ; File descriptor (stdout)
    mov eax, 4               ; sys_write system call number
    int 0x80                 ; Call kernel to write to stdout

    ; Exit the program
    mov eax, 1               ; sys_exit system call number
    xor ebx, ebx             ; Return code 0
    int 0x80                 ; Call kernel to exit

