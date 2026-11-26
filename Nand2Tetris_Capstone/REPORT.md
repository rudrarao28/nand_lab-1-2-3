# Capstone Project Report: Make the Computer Draw a Box
**Course:** Nand to Tetris – I (ETCCNT301)  
**Department:** School of Engineering & Technology, K.R. Mangalam University  
**Marks:** 10 | **Individual Work** | **Course Outcomes:** CO1–CO4  

---

### Student Details
- **Student Name:** Rudra
- **Roll Number:** 2501730451
- **Personal Number (K):** `51` *(last two digits of roll number: 2501730451)*
- **Calculations based on K = 51:**
  - **K mod 3:** `51 mod 3 = 0`  
    **Assigned Assembler Extra Feature:** Save all labels and variables with their addresses in `symbols.txt`.
  - **K mod 4:** `51 mod 4 = 3`
  - **Box Position & Size:**
    - **Starting Row:** Row `K = 51`.
    - **Height:** 20 rows (Rows 51 to 70, inclusive).
    - **Width:** `16 × ((K mod 4) + 1) = 16 × (3 + 1) = 64` pixels from the left edge.
    - **Screen Memory Words:** 16 pixels per word. `64` pixels = `4` consecutive words (Word 0 through Word 3) at the start of each row.
    - **Base Address:** `SCREEN + (32 × 51) = 16384 + 1632 = 18016`.

---

## 1. Project Overview & System Architecture
The objective of this capstone project is to demonstrate the computer-system stack developed in Nand to Tetris (Part I):
1. **Part A (Hardware Layer):** Integrating `CPU.hdl`, `Memory.hdl`, and `Computer.hdl`.
2. **Part B (Software Translation Layer):** Developing a Python assembler (`assembler.py`) that translates Hack assembly (`.asm`) into binary machine language (`.hack`) using two-pass symbol resolution.
3. **Part C (Application / Firmware Layer):** Writing an interactive graphics program (`Box.asm`) that responds to keyboard input, rendering a `64 × 20` pixel black rectangle at Row 51 when a key is pressed, and clearing it when released.

## 2. Part A: Computer Construction & Hardware Verification

### 2.1 Memory Architecture (`Memory.hdl`)
The Hack memory map contains:
- **RAM16K:** addresses `0x0000`–`0x3FFF`.
- **Screen:** addresses `0x4000`–`0x5FFF` (8,192 words).
- **Keyboard:** address `0x6000` (decimal 24576), read-only.
`Memory.hdl` routes the load signal to the selected memory-mapped device and selects the corresponding output.

### 2.2 CPU Implementation (`CPU.hdl`)
The Hack CPU consists of an ALU, A and D registers, and a Program Counter:
- **Instruction decoding:** bit 15 distinguishes A-instructions from C-instructions.
- **A-register logic:** loads the instruction value for A-instructions or the ALU result when a C-instruction writes to A.
- **D-register logic:** loads the ALU result when the C-instruction destination includes D.
- **ALU:** operates on D and either A or M, controlled by the instruction's ALU control bits.
- **Jump logic:** evaluates the ALU zero and negative flags and loads the PC when the selected jump condition is true.

### 2.3 Computer Integration (`Computer.hdl`)
The top-level computer connects `ROM32K`, `CPU`, and `Memory`. The CPU fetches the instruction at `pc`, reads/writes memory through `addressM`, `inM`, `outM`, and `writeM`, and advances or jumps through the program counter.

### 2.4 Official Test Results
Run the supplied official test scripts in your own Nand to Tetris Hardware Simulator and paste the resulting screenshots below. Do not claim a test passed until you have run it in your environment:
- `CPU.tst`
- `Memory.tst`
- `ComputerAdd.tst`
- `ComputerMax.tst`
- `ComputerRect.tst`

## 3. Part B: Python Assembler Design & Extra Feature

### 3.1 Two-Pass Translation Algorithm
The assembler performs two passes:
- **Pass 1:** strips comments and whitespace, counts ROM instructions, and records each `(LABEL)` with its ROM address.
- **Pass 2:** translates A-instructions into a leading `0` plus 15-bit address/value, and C-instructions into `111 + comp + dest + jump`. New variables are allocated from RAM address 16.
- **K-based extra feature:** because `K mod 3 = 0`, the assembler writes the complete symbol table — predefined symbols, labels, and variables with their decimal and hexadecimal addresses — to `symbols.txt`.

### 3.2 Assembler Validation
Use `Add.asm`, `Max.asm`, `Rect.asm`, and `Pong.asm` to test the assembler. Compare the generated `.hack` files with the official assembler output in your course environment.

## 4. Part C: The Box Program (`Box.asm`)

### 4.1 Specification and Coordinate Mapping
The Hack screen is `512 × 256` pixels. Each row has 32 words of 16 pixels each.
- Row start formula: `SCREEN + 32 × row`.
- For `K = 51`: start row = `51` and start address = `18016`.
- Height = 20 rows (`51`–`70`).
- Width = `64` pixels = 4 consecutive words (columns/words 0, 1, 2, 3).
- Each word is `-1` (`0xFFFF`) when a key is pressed, and `0` (`0x0000`) when released.

### 4.2 Control Flow
1. Read the keyboard-mapped address `KBD` (24576).
2. If `KBD != 0`, set `color = -1`; otherwise set `color = 0`.
3. Set the address pointer to `18016` and the row counter to 20.
4. Write four consecutive words in each row.
5. Add 29 to the pointer after the fourth word, reaching the same column in the next row because each screen row is 32 words.
6. Repeat for all 20 rows, then return to the keyboard polling loop.

## 5. One Mistake Encountered and How It Was Fixed
Use this section to describe one genuine mistake from your own implementation or testing. A useful example to discuss, if it matches what you actually encountered, is an incorrect row-stride calculation: after writing four words, the pointer is at offset 3, so the program must add 29 (not 30) to reach offset 32 at the next row. Confirm the mistake and fix from your own work before presenting it as an experience.

## 6. Conclusion
The project combines Hack hardware description, a Python two-pass assembler, and a keyboard-controlled screen program. The personalized values for this submission are `K = 51`, a `64 × 20` pixel box, and starting row `51`. Complete the official simulator tests and insert your own screenshots before final submission.
