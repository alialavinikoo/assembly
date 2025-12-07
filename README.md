# ⚙️ Assembly Language Exercises & Low-Level Labs

![Architecture](https://img.shields.io/badge/Architecture-x86%20%7C%20MIPS-red?style=for-the-badge)
![Tools](https://img.shields.io/badge/Tools-NASM%20%7C%20Emu8086%20%7C%20MARS-lightgrey?style=for-the-badge)
![Complexity](https://img.shields.io/badge/Complexity-Low--Level-critical?style=for-the-badge)

## 📖 Overview
Welcome to my collection of **Assembly Language** programming exercises. This repository houses my work in understanding Computer Architecture, CPU instruction sets, and direct memory manipulation.

These codes are not just scripts; they are explorations into how software communicates directly with hardware, bypassing high-level abstractions.

## 💻 Environment & Tools
The exercises in this repository are written for specific architectures.

* **Architecture:** Intel x86 (16-bit/32-bit) / MIPS / ARM
* **Assemblers:** NASM (Netwide Assembler), MASM, or TASM.
* **Simulators:** Emu8086, MARS (MIPS Simulator), or DOSBox.

---

## 📂 Project Index

### 🟢 1. Basics & Arithmetic
*Fundamental operations using General Purpose Registers (AX, BX, CX, DX).*
* **Hello World:** Writing to `stdout` using System Calls / Interrupts.
* **Calculator:** Implementing Addition (`ADD`), Subtraction (`SUB`), Multiplication (`MUL`), and Division (`DIV`).
* **Logical Ops:** Using `AND`, `OR`, `XOR`, and `NOT` for bit masking.

### 🟡 2. Control Flow & Loops
*Managing program execution and jumps.*
* **Compare Logic:** Using `CMP` flag handling and Conditional Jumps (`JE`, `JNE`, `JG`, `JL`).
* **Looping:** Iterating through sequences using `LOOP` and `CX` register decrements.
* **Factorial:** Calculating factorials to demonstrate loop efficiency.

### 🔴 3. Memory & Strings
*Direct manipulation of the Data Segment (DS) and Extra Segment (ES).*
* **String Reversal:** Using pointers (`SI`, `DI`) to reverse user input in memory.
* **Palindrome Checker:** Comparing strings character by character from memory addresses.
* **Array Sorting:** Implementing Bubble Sort purely in Assembly.

### ⚫ 4. Advanced & System Calls
* **The Stack:** Using `PUSH` and `POP` to manage data and preserve register states.
* **Procedures:** Writing modular code using `CALL` and `RET`.
* **File I/O:** Reading from and writing to text files via Kernel interrupts.

---

## 📝 Code Snippet Example
A sample from my work demonstrating a loop and system interrupt (x86 syntax):

```nasm
; A simple loop implementation
section .text
    global _start

_start:
    mov ecx, 10      ; Initialize counter to 10
    mov eax, '0'     ; Start with character '0'

l1:
    mov [num], eax   ; Move value to memory
    mov eax, 4       ; Sys_write
    mov ebx, 1       ; Stdout
    push ecx         ; Save counter
    
    ; ... (Logic to print and loop)
    
    pop ecx          ; Restore counter
    loop l1          ; Decrement ECX and jump if not zero
```

## 🧠 Key Learnings
Through these exercises, I have gained deep insights into:
1.  **Registers vs. RAM:** Why registers are faster and how to optimize their usage.
2.  **The Stack:** Understanding Stack Frames, `SP` (Stack Pointer), and `BP` (Base Pointer) to prevent Stack Overflows.
3.  **Interrupts:** How `INT 21h` (DOS) or `INT 0x80` (Linux) bridges the gap between the User and the Kernel.
4.  **Endianness:** Handling Little-Endian byte storage in memory.

## 🚀 How to Assemble & Run
*Example command for NASM on Linux:*

1.  **Assemble:**
    ```bash
    nasm -f elf64 -o program.o program.asm
    ```
2.  **Link:**
    ```bash
    ld -o program program.o
    ```
3.  **Run:**
    ```bash
    ./program
    ```

---
*Developed by [Ali Alavinikoo](https://github.com/alialavinikoo).*
