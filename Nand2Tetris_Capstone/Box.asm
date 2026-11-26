// Box.asm
// Capstone Project: Make the Computer Draw a Box
// Nand to Tetris - I (ETCCNT301)
// School of Engineering & Technology, K.R. Mangalam University
//
// Student Name: Rudra Pratap Singh
// Roll Number: 2501730451
// Personal Number K: 51 (last two digits of roll number)
//
// Box Specifications for K = 51:
// - Start Row: K = 51
// - Height: 20 rows (Row 51 to Row 70)
// - Width: 16 * ((51 mod 4) + 1) = 16 * (3 + 1) = 64 pixels
//   (which equals 4 words of 16 bits each per row, starting from left edge)
// - Start Address in Screen Memory:
//     SCREEN + 32 * K = 16384 + (32 * 51) = 18016
//
// Operation:
// - Continuously checks keyboard input (RAM[24576] / KBD).
// - If any key is pressed (KBD != 0): fills the 64x20 box with black (-1).
// - If no key is pressed (KBD == 0): clears the 64x20 box to white (0).

(MAIN_LOOP)
    // Read the keyboard register
    @KBD
    D=M

    // If D != 0, a key is pressed -> set color to black (-1)
    @KEY_PRESSED
    D;JNE

    // Otherwise, key is released -> set color to white (0)
    @color
    M=0
    @DRAW_INIT
    0;JMP

(KEY_PRESSED)
    // Set color to -1 (16 bits of 1s = black)
    @color
    M=-1

(DRAW_INIT)
    // Initialize address pointer to start of box: SCREEN + 32 * 51 = 18016
    @18016
    D=A
    @addr
    M=D

    // Initialize row counter: 20 rows
    @20
    D=A
    @rows_left
    M=D

(ROW_LOOP)
    // Check if all rows are completed
    @rows_left
    D=M
    @MAIN_LOOP
    D;JEQ

    // Write word 0 (pixels 0-15)
    @color
    D=M
    @addr
    A=M
    M=D

    // Write word 1 (pixels 16-31)
    @addr
    M=M+1
    @color
    D=M
    @addr
    A=M
    M=D

    // Write word 2 (pixels 32-47)
    @addr
    M=M+1
    @color
    D=M
    @addr
    A=M
    M=D

    // Write word 3 (pixels 48-63)
    @addr
    M=M+1
    @color
    D=M
    @addr
    A=M
    M=D

    // Advance from word 3 to the first word of the next row:
    // 3 words already advanced + 29 = 32 words per screen row.
    @29
    D=A
    @addr
    M=D+M

    // Decrement the row counter
    @rows_left
    M=M-1

    // Repeat for the next row
    @ROW_LOOP
    0;JMP
