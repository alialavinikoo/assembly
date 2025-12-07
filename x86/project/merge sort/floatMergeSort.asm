%include "asm_io.inc"

segment .data
    msg_read db "enter 15 numbers:  ", 0
    msg_out db "sorted array:", 10, 0
    arr times 15 dd 0         ; array

    merge1 times 15 dd 0      ; merge first array helper
    merge2 times 15 dd 0      ; merge second array helper
    lowarg dd 0               ; low arg in merge function
    higharg dd 14             ; high arg in merge function
    marg dd 7                 ; m arg in merge function
    n1 dd 0                   ; merge1 size
    n2 dd 0                   ; merge2 size

    format_scanf db "%f", 0     ; Format string for scanf
    format_printf db "%.2f ", 0 ; Format string for printf


segment .text
    extern scanf, printf
    global asm_main

asm_main:
    enter 0, 0               
    pusha                    

    call read
    call merge_sort
    call print

    ;Exit
    popa                     
    mov eax, 0               
    leave                    
    ret


merge_sort:
    pusha
    
    ;base case
    mov eax, [lowarg] 
    cmp [higharg], eax
    jle end_merge_sort

    mov eax, [lowarg]
    mov ebx, [higharg]
    add eax, ebx
    shr eax, 1                ; m = (lowarg + higharg) / 2
    mov [marg], eax           

recursion1:
    ;push variables to stack
    mov eax, [lowarg]
    push eax
    mov eax, [higharg]
    push eax
    mov eax, [marg]
    push eax

    ;mergeSort(arr, low, m);
    mov eax, [marg]
    mov [higharg], eax

    call merge_sort

    ;pop variables
    pop eax
    mov [marg], eax
    pop eax
    mov [higharg], eax
    pop eax
    mov [lowarg], eax

recursion2:
    ;push variables to stack
    mov eax, [lowarg]
    push eax
    mov eax, [higharg]
    push eax
    mov eax, [marg]
    push eax

    ;mergeSort(arr, m + 1, high)
    mov eax, [marg]
    inc eax
    mov [lowarg], eax

    call merge_sort

    ;pop variables
    pop eax
    mov [marg], eax
    pop eax
    mov [higharg], eax
    pop eax
    mov [lowarg], eax
    
    ;merge(arr, low, m, high);
    call merge

end_merge_sort:
    popa
    ret


merge:
    pusha
    mov ecx, [marg]
    sub ecx, [lowarg]
    inc ecx
    mov [n1], ecx
    mov edi, merge1
    mov esi, arr
    mov eax, [lowarg]            ; zero extend
    shl eax, 2               ; mul by 4
    add esi, eax         


;for (int i = 0; i < n1; i++) {
;   a1[i] = arr[low + i];
;}
mergeloop1:
    mov eax, [esi]
    mov [edi], eax
    add edi, 4
    add esi, 4
    loop mergeloop1

    mov ecx, [higharg]
    sub ecx, [marg]
    mov [n2], ecx
    mov edi, merge2
    mov esi, arr
    mov eax, [marg]           
    shl eax, 2               ; mul by 4
    add esi, eax             
    add esi, 4                


;for (int i = 0; i < n2; i++) {
;    a2[i] = arr[m + 1 + i];
;}
mergeloop2:
    mov eax, [esi]
    mov [edi], eax
    add edi, 4
    add esi, 4
    loop mergeloop2

    mov esi, arr
    mov eax, [lowarg]            
    shl eax, 2               ; mul by 4
    add esi, eax             ;add offset to arr pointer
    mov edx, merge2
    mov ebx, merge1


;while (i < n1 && j < n2) {
;            if (a2[j] > a1[i]) {
;                arr[k] = a1[i];
;                i++;
;            } else {
;                arr[k] = a2[j];
;                j++;
;            }
;            k++;
;        }
mergeloop3:

    cmp byte [n1], 0
    je endmergeloop3

    cmp byte [n2], 0
    je endmergeloop3

    ;mov eax, [ebx]
    ;cmp [edx], eax

    movss xmm0, [ebx]
    movss xmm1, [edx]
    ucomiss xmm0, xmm1
    jnb skip1
    ;mov [esi], eax
    movss [esi], xmm0
    add ebx, 4
    add esi, 4
    dec byte [n1]
    jmp mergeloop3

skip1:
    movss [esi], xmm1
    add edx, 4
    add esi, 4
    dec byte [n2]
    jmp mergeloop3

endmergeloop3:


;while (i < n1) {
;           arr[k] = a1[i];
;           i++;
;           k++;
;       }
mergeloop4:
    cmp byte [n1], 0
    je mergeloop5
    ;mov eax, [ebx]
    ;mov [esi], eax
    movss xmm0, [ebx]
    movss [esi], xmm0
    add ebx, 4
    add esi, 4
    dec byte [n1]
    jmp mergeloop4


;while (j < n2) {
;            arr[k] = a2[j];
;            j++;
;            k++;
;        }
mergeloop5:
    cmp byte [n2], 0
    je endmerge
    ;mov eax, [edx]
    ;mov [esi], eax
    movss xmm1, [edx]
    movss [esi], xmm1
    add edx, 4
    add esi, 4
    dec byte [n2]
    jmp mergeloop5

endmerge:
    popa
    ret


read:
    
    mov ecx, 15              ; loop counter for 15 ints
    mov edi, arr            
    mov eax, msg_read        
    call print_string    

read_loop:
        
    push ecx
    push edi
    push format_scanf
    call scanf
    add esp, 8          ; clean stack
    pop ecx                    
    add edi, 4               
    loop read_loop           
    ret


print:
    pusha
    mov eax, msg_out
    call print_string        
    mov ecx, 15              ; loop counter for 15 ints
    mov edi, arr            
print_loop:
    ;mov eax, [edi]           
    ;call print_int           
    movss xmm0, [edi]
    cvtss2sd xmm0, xmm0     ;convert to double for printf

    push ecx
    push edi

    sub esp, 8
    movsd [esp], xmm0
    push format_printf
    call printf
    add esp, 12

    pop edi
    pop ecx

    mov eax, 32
    call print_char          
    add edi, 4               
    loop print_loop          
    call print_nl
    popa
    ret
