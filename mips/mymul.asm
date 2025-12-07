.data
num1 : .word 123456789
num2 : .word 235163526
new_line : .asciiz "\n"
result : .asciiz "results:\n"

.text
main:
  	lw $s0, num1
  	lw $s1, num2
  
  	# lower and upper num1
    andi $t0, $s0, 0xFFFF
    srl $t1, $s0, 16
    # lower and upper num2
    andi $t2, $s1, 0xFFFF
    srl $t3, $s1, 16
    

    mul $t4, $t0, $t2        #lower1 * lower2
    mul $t5, $t0, $t3        #lower1 * upper2
    mul $t6, $t1, $t2        #lower2 * upper1
    mul $t7, $t1, $t3        #upper1 * upper2
  	
  	# t1 = upper result
  	# t0 = lower result
  	add $t0, $zero, $t4 
  	add $t1, $zero, $t7
  
    # upper result process
  	sll $s2, $t5, 16		# $s2 = helper	
  	addu $s2, $t0, $s2 
  	sltu $t9, $s2, $t0	# carry
  	add $t0, $zero, $s2
  	add  $t1, $t1, $t9
  	sll $s2, $t6, 16
  	addu $s2, $t0, $s2 
  	sltu $t9, $s2, $t0	# carry
  	add $t0, $zero, $s2
  	add  $t1, $t1, $t9 
  	mul $t0, $t0, -1
  	
    
    # upper result process
  	srl $s2, $t5, 16 
  	add $t1, $t1, $s2   
  	srl $s2, $t6, 16 
  	add $t1, $t1, $s2   

	# t1 = upper result
  	# t0 = lower result
  	
  	li $v0, 4
    la $a0, result
    syscall
    
  	li $v0, 1
    move $a0, $t0
    syscall
    
    li $v0, 4
    la $a0, new_line
    syscall

    li $v0, 1
    move $a0, $t1
    syscall

    li $v0, 10
    syscall