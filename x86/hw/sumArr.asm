section .data
    msg db 'Result: ', 0      ; Message to print before the result
    newline db 10             ; Newline character for formatting
    arr dw 10, 245, 12, 76    ; Array of words (2 bytes each)
    len equ ($ - arr) / 2     ; Calculate the number of elements (len = size / 2 for word-sized elements)

section .bss
    result resb 10            ; Buffer for result (10 digits max)

section .text
    global _start

_start:

    ; Initialize sum to 0 (EAX register)
    xor eax, eax             ; Clear EAX to ensure the sum starts at 0
    mov ecx, len             ; Load array length
    mov esi, arr             ; Point ESI to the start of the array
arrloop:
    
    add ax, word [esi]      ; Add the 16-bit word to EAX
    add esi, 2               ; Move to the next word (2 bytes)
    loop arrloop             ; Continue until ECX reaches 0

    ; Convert result (EAX contains the sum)
    mov ecx, 10              ; Decimal base (for division)
    mov edi, result + 10     ; Point EDI to the end of the result buffer
    xor edx, edx             ; Clear EDX to handle any remainder

convert_loop:
    xor edx, edx             ; Clear EDX (remainder)
    div ecx                  ; Divide EAX by 10, result in EAX, remainder in EDX
    add dl, '0'              ; Convert remainder to ASCII (add '0' to convert to character)
    dec edi                  ; Move backwards in the buffer
    mov [edi], dl            ; Store ASCII character in the buffer

    ; Check if quotient (EAX) is zero
    test eax, eax
    jnz convert_loop         ; If EAX is not zero, continue loop

    ; Print message "Result: "
    mov edx, msg             ; Load address of message
    mov ebx, 1               ; File descriptor (stdout)
    mov eax, 4               ; sys_write syscall
    int 0x80                 ; Call kernel

    ; Print the result (in result buffer)
    mov edx, result + 10     ; Calculate the length of the result string
    sub edx, edi             ; Length is the difference between edi and end of the buffer
    mov ecx, edi             ; Point to the start of the result string
    mov eax, 4               ; sys_write syscall
    int 0x80                 ; Call kernel

    ; Print newline
    mov edx, 1               ; Print 1 byte
    mov ecx, newline         ; Address of newline
    mov eax, 4               ; sys_write syscall
    int 0x80                 ; Call kernel

    ; Exit program
    mov eax, 1               ; sys_exit syscall
    xor ebx, ebx             ; Exit code 0
    int 0x80                 ; Call kernel
