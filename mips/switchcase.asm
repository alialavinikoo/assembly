.data
x: .word 2      # Input value
y: .word 0      # Output value
jump_table: .word case_1, case_2, case_3, default  # Jump table addresses

.text
main:
    lw $t0, x           # Load x into $t0
    li $t1, 1           # Base index (case starts at 1)
    sub $t0, $t0, $t1   # Subtract 1 to make 0-based index
    bltz $t0, default   # If x < 1, go to default
    li $t1, 2           # Number of cases (3 - 1 = 2)
    bgt $t0, $t1, default   # If x > 3, go to default
    sll $t0, $t0, 2     # Multiply by 4 (word size)
    la $t2, jump_table  # Load base address of jump table
    add $t2, $t2, $t0   # Get address of case
    lw $t3, 0($t2)      # Load address of case
    jr $t3              # Jump to case

case_1:
    li $t2, 10          # y = 10
    sw $t2, y
    j end

case_2:
    li $t2, 20          # y = 20
    sw $t2, y
    j end

case_3:
    li $t2, 30          # y = 30
    sw $t2, y
    j end

default:
    li $t2, 0           # y = 0
    sw $t2, y

end:
    # Exit (assumes syscall convention)
    li $v0, 10          # Exit code
    syscall
