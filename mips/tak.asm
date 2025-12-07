.text
.globl main

main:

	li $a0,18	#x
	li $a1,12 	#y
	li $a2,6 	#z
	jal tak
	
	move $a0,$v0
	li $v0,1
	syscall   #print result 
		
	li $v0,10
	syscall 	#end
	
.globl tak
	
tak:
	subiu $sp,$sp,24
	sw $ra,20($sp)	#save ra
	sw $s0,0($sp)  #save x
	move $s0,$a0
	sw $s1,4($sp)  #save y
	move $s1,$a1
	sw $s2,8($sp)  #save z
	move $s2,$a2
	sw $s3,12($sp) 
	sw $s4,16($sp) 
	
	bge $s1,$s0,returnZ 	#if y > x jump to return
	
	subiu $a0,$s0,1	#x1 = x - 1
	move $a1,$s1		#y1 = y
	move $a2,$s2		#z1 = z
	jal tak
	move $s3,$v0		#s3 = f1	
	
	addiu $a0,$s1,-1	#x2 = y - 1
	move $a1,$s2		#y2 = z
	move $a2,$s0		#z2 = x
	jal tak
	move $s0,$v0		#s4 = f2
	
	addiu $a0,$s2,-1	#x3 = z - 1
	move $a1,$s0		#y3 = x
	move $a2,$s1		#z3 = y
	jal tak			#v0 = f3

	move $a0,$s3
	move $a1,$s0
	move $a2,$v0
	jal tak			#v0 = f
	addiu $v0,$v0,1 #v0 = f + 1

restoreAndReturn:	
	lw $ra,20($sp)	#reload s registers
	lw $s0,0($sp)
	lw $s1,4($sp)
	lw $s2,8($sp)
	lw $s3,12($sp)
	lw $s3,16($sp)
	addiu $sp,$sp,24
	jr $ra		#return
	
returnZ:
	move $v0,$s2   #return z
	j restoreAndReturn

