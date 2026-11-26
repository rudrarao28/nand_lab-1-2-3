# Capstone Viva Preparation Guide (5-Minute Viva)
**Subject:** Nand to Tetris – I (ETCCNT301)  
**Student:** Rudra Pratap Singh | **Roll No:** 2501730451 | **K = 51**

## 1. On-the-Spot Code Changes

### Q1. Move the box down by 5 rows.
Each screen row has 32 words. Add `5 × 32 = 160` to the start address:
- Original address: `18016`
- New address: `18176`
- Change the address loaded in `DRAW_INIT`, then reassemble `Box.asm`.

### Q2. Make the box taller (30 rows).
Change the row counter initialization from `@20` to `@30`. The box then occupies 30 rows, provided it remains within the screen.

### Q3. Make the box wider.
For this K, the width is already 64 pixels = 4 words. To add another 16 pixels:
- Add a fifth word write (increment the pointer and write `color`).
- Change the row-gap addition from `29` to `28`, because the pointer will already have advanced 4 words from the row start and `4 + 28 = 32`.

### Q4. Reverse the key behavior.
Change the keyboard branch so the zero/non-zero condition selects the opposite `color` value, or swap the values assigned to `color`.

## 2. Fundamental Technical Viva Questions

### Q1. How does the Hack CPU handle instructions?
- **A-instruction (`@value`):** MSB is 0; the remaining 15 bits provide a value loaded into the A register.
- **C-instruction (`dest=comp;jump`):** starts with `111`, followed by ALU control bits, destination bits, and jump bits.

### Q2. What is memory-mapped I/O?
The Hack platform maps devices into the memory address space:
- Screen memory begins at address `16384`.
- Keyboard is at address `24576`; it contains the pressed key's code or 0 when no key is pressed.

### Q3. How does the two-pass assembler work?
- **Pass 1:** removes comments, counts instructions, and records labels with ROM addresses.
- **Pass 2:** translates instructions to 16-bit binary. Variables not already in the symbol table receive RAM addresses beginning at 16.

### Q4. Why does `Box.asm` add 29 words after each row?
A screen row contains 32 words. Four box words are written. The pointer is advanced three times from the first word to the fourth word, so adding 29 more reaches the next row: `3 + 29 = 32`.

### Q5. What does `writeM` do?
`writeM` tells Memory to store the CPU's `outM` value at `addressM`. It is asserted for a C-instruction whose destination includes M.
