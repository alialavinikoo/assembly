.data
newline: .asciiz "\n"
result: .asciiz "Sorted:\n"

.text
.globl main

main:

    li $v0, 5 
    syscall
    move $t0, $v0

    li $v0, 5
    syscall
    move $t1, $v0

    li $v0, 5
    syscall
    move $t2, $v0

    li $v0, 5
    syscall
    move $t3, $v0
    
    #t0, t1, t2, t3 are the input numbers

    # Bubble Sort
    # step 1
    jal comparet0t1
    jal comparet1t2
    jal comparet2t3

    # step 2
    jal comparet0t1
    jal comparet1t2

    # step 3
    jal comparet0t1

    la $a0, result
    li $v0, 4
    syscall

    move $a0, $t0
    li $v0, 1
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    move $a0, $t1
    li $v0, 1
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    move $a0, $t2
    li $v0, 1
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    move $a0, $t3
    li $v0, 1
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    li $v0, 10
    syscall

#Compare and Swap $t0 and $t1
comparet0t1:
	# (a + b + |a - b| ) / 2
    add $t4, $t0, $t1
    sub $t5, $t0, $t1
    abs $t5, $t5  
    add $t6, $t4, $t5
    sra $t6, $t6, 1  
    # (a + b - |a - b| ) / 2
    sub $t7, $t4, $t5
    sra $t7, $t7, 1 
    move $t0, $t6
    move $t1, $t7
    jr $ra

#Compare and Swap $t1 and $t2
comparet1t2:
	# (a + b + |a - b| ) / 2
    add $t4, $t1, $t2
    sub $t5, $t1, $t2
    abs $t5, $t5  
    add $t6, $t4, $t5
    sra $t6, $t6, 1 
    # (a + b - |a - b| ) / 2
    sub $t7, $t4, $t5
    sra $t7, $t7, 1 
    move $t1, $t6
    move $t2, $t7
    jr $ra

#Compare and Swap $t2 and $t3
comparet2t3:
	# (a + b + |a - b| ) / 2
    add $t4, $t2, $t3
    sub $t5, $t2, $t3
    abs $t5, $t5 
    add $t6, $t4, $t5
    sra $t6, $t6, 1  
    # (a + b - |a - b| ) / 2
    sub $t7, $t4, $t5
    sra $t7, $t7, 1 
    move $t2, $t6
    move $t3, $t7
    jr $ra
