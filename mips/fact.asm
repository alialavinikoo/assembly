.text
.globl main

main:
	li $a0, 5
	li $s0, 1
	jal fact
	
exit:
	move $s0, $v0
	li $v0, 1
	la $a0, ($s0)
	syscall
	li $v0, 10
	syscall
	
.globl fact

fact:
	subi $sp, $sp, 4
	sw $ra, 0($sp)
	beq $a0, $s0, base
	subi $a0, $a0, 1
	jal fact
	addi $a0, $a0, 1
	mul $v0, $v0, $a0
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
base:
	li $v0, 1
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
	