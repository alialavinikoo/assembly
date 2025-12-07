.data
buffer: .space 100         
char:   .space 1           
new_line : .asciiz "\n"

.text
.globl main

main:
    la $t0, buffer         # Buffer pointer

read_char:

    li $v0, 12            
    syscall
    sb $v0, char          
    
    sb $v0, 0($t0)         # Add to buffer
    addi $t0, $t0, 1       # update pointer
    
    beq $v0, 'x', print_result
    
    j read_char           

print_result:
    sb $zero, 0($t0)       # Null terminator
    
    la $a0, new_line         # Print
    li $v0, 4
    syscall
    
    la $a0, buffer         # Print
    li $v0, 4
    syscall

exit:
    li $v0, 10             # Exit
    syscall
