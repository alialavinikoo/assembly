.data
msg_input:      .asciiz "Enter the height of the triangle:\n"
newline:        .asciiz "\n"
tab:            .asciiz "\t"

.text
.globl main

main:
    # Prompt user for input
    la $a0, msg_input       # Load the address of the input message
    li $v0, 4               # Print string syscall
    syscall

    # Read integer input
    li $v0, 5               # Read integer syscall
    syscall
    move $t0, $v0           # Store input in $t0 (height)

    # Initialize values for triangle generation
    li $t1, 2               # First prime number
    li $t2, 0               # Current row (counter for rows printed)
    li $t3, 0               # Primes printed in the current row

print_triangle:
    # Check if we've printed all rows
    bge $t2, $t0, end       # If current row >= input height, finish

    # Check if the number in $t1 is prime
    move $t4, $t1           # Copy current number to $t4 (to test divisibility)
    li $t5, 2               # Start divisor from 2

check_prime:
    div $t4, $t5            # Divide $t4 by $t5
    mfhi $t6                # Get remainder
    beq $t6, 0, not_prime   # If remainder == 0, not prime

    addi $t5, $t5, 1        # Increment divisor
    mul $t7, $t5, $t5       # Check if divisor^2 > number
    bgt $t7, $t4, is_prime  # If divisor^2 > number, it's prime
    j check_prime

not_prime:
    addi $t1, $t1, 1        # Move to the next number
    j print_triangle        # Restart loop to check next number

is_prime:
    # Print the prime number
    move $a0, $t1           # Load prime number into $a0
    li $v0, 1               # Print integer syscall
    syscall

    # Print tab for spacing
    la $a0, tab
    li $v0, 4
    syscall

    # Increment counters
    addi $t3, $t3, 1        # Increment primes printed in this row
    addi $t1, $t1, 1        # Move to the next number

    # Check if row is complete
    bne $t3, $t2, print_triangle # If primes in row != current row number, keep going

    # Row complete, print newline
    la $a0, newline
    li $v0, 4
    syscall

    addi $t2, $t2, 1        # Move to the next row
    li $t3, 0               # Reset primes printed for the new row
    j print_triangle
    
end:
    # Exit program
    li $v0, 10
    syscall

