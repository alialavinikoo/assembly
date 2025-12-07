.text
.globl main

main:
	li $a0, 8
	li $s0, 1
	jal fib
	
exit:
	move $s0, $v0
	li $v0, 1
	la $a0, ($s0)
	syscall
	li $v0, 10
	syscall
	
.globl fib

fib:
	subi $sp, $sp, 12
	sw $s1, 8($sp)
	sw $s2, 4($sp)
	sw $ra, 0($sp)
	beq $a0, $s0, base
	beq $a0, $0, base
	subi $a0, $a0, 1
	jal fib
	move $s1, $v0
	subi $a0, $a0, 1
	jal fib
	move $s2, $v0
	addi $a0, $a0, 2
	add $v0, $s1, $s2
	lw $s1, 8($sp)
	lw $s2, 4($sp)
	lw $ra, 0($sp)
	addi $sp, $sp, 12
	jr $ra
base:
	li $v0, 1
	lw $s1, 8($sp)
	lw $s2, 4($sp)
	lw $ra, 0($sp)
	addi $sp, $sp, 12
	jr $ra
	
	