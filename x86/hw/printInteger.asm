section .data
    msg db 'Result: ', 0  ; Message to print before the result
    newline db 10         ; Newline character for formatting
    
section .bss
    result resb 10        ; Buffer for result (10 digits max)

section .text
    global _start

_start:
    ; Load numbers into registers
    mov eax, 123          ; First number
    mov ebx, 456          ; Second number

    ; Add the numbers
    add eax, ebx          ; eax = eax + ebx → eax = 123 + 456 = 579

    ; Convert result to ASCII
    mov ecx, 10           ; Decimal base
    mov edi, result + 10  ; Point edi to the end of the buffer

convert_loop:
    xor edx, edx          ; Clear edx (remainder)
    div ecx               ; Divide eax by 10, quotient in eax, remainder in edx
    add dl, '0'           ; Convert remainder to ASCII (add '0' to convert to character)
    dec edi               ; Move backwards in the buffer
    mov [edi], dl         ; Store ASCII character in the buffer

    ; Check if quotient is zero
    test eax, eax
    jnz convert_loop      ; If eax is not zero, continue loop

    ; Print message "Result: "
    mov edx, msg          ; Load address of message
    mov ebx, 1            ; File descriptor (stdout)
    mov eax, 4            ; sys_write syscall
    int 0x80              ; call kernel

    ; Print the result (in result buffer)
    mov edx, result + 10  ; Calculate the length of the result string
    sub edx, edi          ; Calculate length (from edi to end of buffer)
    mov ecx, edi          ; Point to the start of the result string
    mov eax, 4            ; sys_write syscall
    int 0x80              ; call kernel

    ; Print newline
    mov edx, 1            ; Print 1 byte
    mov ecx, newline     ; Address of newline
    mov eax, 4            ; sys_write syscall
    int 0x80              ; call kernel

    ; Exit program
    mov eax, 1            ; sys_exit syscall
    xor ebx, ebx          ; Exit code 0
    int 0x80              ; call kernel
