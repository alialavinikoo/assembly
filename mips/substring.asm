.data
prompt_a:      .asciiz "Enter string a:\n"
prompt_b:      .asciiz "Enter string b:\n"
no_match:      .asciiz "no match found\n"
newline:       .asciiz "\n"
buffer_a:      .space 128       # Buffer for string a
buffer_b:      .space 128       # Buffer for string b

.text
.globl main

main:
    # Prompt for string a
    la $a0, prompt_a          # Load prompt for string a
    li $v0, 4                 # Print string syscall
    syscall

    # Read string a
    la $a0, buffer_a          # Load address of buffer_a
    li $a1, 128               # Maximum length for input
    li $v0, 8                 # Read string syscall
    syscall

    # Prompt for string b
    la $a0, prompt_b          # Load prompt for string b
    li $v0, 4                 # Print string syscall
    syscall

    # Read string b
    la $a0, buffer_b          # Load address of buffer_b
    li $a1, 128               # Maximum length for input
    li $v0, 8                 # Read string syscall
    syscall

    # Check if b is a substring of a
    la $t0, buffer_a          # Pointer to string a
    la $t1, buffer_b          # Pointer to string b
    li $t2, 0                 # Index counter for string a

find_substring:
    lb $t3, 0($t0)            # Load current character of a
    beq $t3, $zero, no_match  # If end of a, no match found

    # Check if substring matches
    move $t4, $t0             # Pointer to current position in a
    move $t5, $t1             # Pointer to start of b

compare:
    lb $t6, 0($t4)            # Load current character of a
    lb $t7, 0($t5)            # Load current character of b
    beq $t7, $zero, match     # If end of b, match found
    beq $t6, $t7, continue    # If characters match, continue
    j next_char               # If mismatch, move to next char in a

continue:
    addi $t4, $t4, 1          # Move to next char in a
    addi $t5, $t5, 1          # Move to next char in b
    j compare                 # Repeat comparison

next_char:
    addi $t0, $t0, 1          # Move to next char in a
    addi $t2, $t2, 1          # Increment index in a
    j find_substring          # Restart substring search

match:
    # Print starting index
    move $a0, $t2             # Starting index of match
    li $v0, 1                 # Print integer syscall
    syscall

    # Print newline
    la $a0, newline
    li $v0, 4
    syscall
    j end

no_match:
    # Print "no match found"
    la $a0, no_match
    li $v0, 4                 # Print string syscall
    syscall

end:
    # Exit program
    li $v0, 10                # Exit syscall
    syscall

