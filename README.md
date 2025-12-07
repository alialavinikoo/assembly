---

# assembly-exercises
**Focus:** Low-Level Programming, Computer Architecture, Registers, Memory Management.

This README assumes x86/MIPS assembly, focusing on the "bare metal" nature of the code.

```
# ⚙️ Assembly Language Exercises

![Architecture](https://img.shields.io/badge/Arch-x86%20%7C%20MIPS%20%7C%20ARM-orange)
![Assembler](https://img.shields.io/badge/Assembler-NASM%20%7C%20MASM-lightgrey)
![Level](https://img.shields.io/badge/Level-Low--Level-red)

A curated set of **Assembly Language** programs designed to explore the fundamentals of computer architecture, CPU registers, memory addressing, and system calls. This repository bridges the gap between high-level code and machine execution.

## 📖 Introduction
This project goes deep into the hardware-software interface. It contains exercises ranging from basic arithmetic operations to complex string manipulation and interrupt handling. It is designed for students and enthusiasts learning **x86 (Intel)** or **MIPS** architectures.

## 🗝 Key Concepts Covered
* **Registers:** Usage of General Purpose Registers (AX, BX, CX, DX) and Index Pointers (SI, DI, SP, BP).
* **Memory Management:** Understanding Data Segment (DS), Code Segment (CS), and Stack Segment (SS).
* **Control Flow:** Implementation of Loops (`LOOP`, `JMP`), Conditional Jumps (`JE`, `JNE`, `JG`), and Procedures (`CALL`, `RET`).
* **Interrupts:** Interacting with the OS kernel (e.g., `INT 21h` for DOS/x86 legacy or Syscalls in Linux).
* **Bitwise Operations:** `AND`, `OR`, `XOR`, `SHL`, `SHR` for low-level data masking.

## 📂 Exercise List
1.  **Hello World:** Direct output to stdout using system interrupts.
2.  **Calculator:** Basic addition/subtraction of 8-bit and 16-bit integers.
3.  **String Reversal:** Manipulating memory buffers to reverse user input.
4.  **Factorial Calculation:** Using recursion directly with the Stack Pointer (SP).
5.  **Array Sorting:** Implementing Bubble Sort using purely register-based logic.

## 🛠 Tools & Prerequisites
To run these codes, you will need an assembler and a linker.
* **Windows:** [MASM32](http://www.masm32.com/) or [EMU8086](https://emu8086-microprocessor-emulator.en.softonic.com/) (for legacy learning).
* **Linux:** `NASM` (Netwide Assembler) and `ld` (GNU Linker).

## 🚀 How to Build & Run (x86 NASM Example)

1.  **Assemble** the source code into an object file:
    ```bash
    nasm -f elf64 hello_world.asm -o hello_world.o
    ```

2.  **Link** the object file to create an executable:
    ```bash
    ld hello_world.o -o hello_world
    ```

3.  **Execute:**
    ```bash
    ./hello_world
    ```

## 🧬 Code Snippet Example
A preview of how a loop is structured in this repo (x86):
```nasm
section .text
global _start

_start:
    mov cx, 10      ; Set loop counter to 10
    mov ax, 0       ; Accumulator

loop_start:
    add ax, 1       ; Increment AX
    loop loop_start ; Decrement CX and jump if CX != 0
    
    ; Exit syscall
    mov eax, 1
    int 0x80
