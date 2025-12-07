.text
.globl main

main:
	la $s0, array
	li $s1, 10
	li $s2, 0
loop:
	lw $t0, ($s0)
	bne $t0, $s1, exit
	addi $s0, $s0, 4
	addi $s2, $s2, 1
	j loop
	
exit:
	li $v0, 1
	la $a0, ($s2)
	syscall
	li $v0, 10
	syscall
	
.data

array:
	.word 10, 10, 10, 10, 1