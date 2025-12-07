.data
input: .space 8          # Input string
yes:   .asciiz "\npalindrome\n"
no:    .asciiz "\nnot palindrome\n"

.text
.globl main

main:
    li $v0, 8
    la $a0, input
    li $a1, 8            # Max length
    syscall

    la $t0, input
    addi $t1, $t0, 6     # Last character

check_palindrome:
    lb $t2, 0($t0)
    lb $t3, 0($t1)
    beqz $t2, print_yes   # Null terminator
    bne $t2, $t3, print_no
    addi $t0, $t0, 1      # Move forward
    addi $t1, $t1, -1     # Move backward
    j check_palindrome

print_yes:
    la $a0, yes
    li $v0, 4
    syscall
    j exit

print_no:
    la $a0, no
    li $v0, 4
    syscall

exit:
    li $v0, 10
    syscall
