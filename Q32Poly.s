        .syntax		unified
        .cpu		cortex-m4
	.text
	.thumb_func
	.align		2

// Q32  Q32Product(Q32 a, Q32 b)

	.global		Q32Product
Q32Product:

	// The two parameters are passed to this function as follows:
	//
	// a<63..32> is in register R1// a<31..0> is in register R0
	// b<63..32> is in register R3// b<31..0> is in register R2
	//
	// Bits 63..32 of the product must be returned in register R1
	// Bits 31..0 of the product must be returned in register R0
	//
	// The value of all other registers must be preserved!

	PUSH		{R4,R5}

	// Start with 64-bit unsigned product

	UMULL		R5,R4,R0,R2		// LSW:R4 = MSHalf of LSW(A)xLSW(B)
	MUL		R5,R1,R3		// MSW:R5 = LSHalf of MSW(A)xMSW(B)
	UMLAL		R4,R5,R0,R3		// R5.R4 += 64 bits of LSW(A)xMSW(B)
	UMLAL		R4,R5,R1,R2		// R5.R4 += 64 bits of MSW(A)xLSW(B)

	// Apply correction terms to make signed

	AND		R2,R2,R1,ASR 31		// R2 = (a < 0) ? b<31..0> : 0
    SUB		R5,R5,R2		// R5 = R5 - ((a < 0) ? b<31..0> : 0)
    AND		R0,R0,R3,ASR 31		// R0 = (b < 0) ? a<31..0> : 0
	SUB		R1,R5,R0		// R1 = R5 - ((b < 0) ? a<31..0> : 0)
	MOV		R0,R4

	POP		{R4,R5}
	BX		LR			// Return to calling program.

    .global     Q32Poly
Q32Poly:
    PUSH        {R4,R5,R6,R7,R8,R9,R10,R11,LR}
    MOV         R4,R0//Moving x
    MOV         R5,R1//Moving x
    MOV         R6,R2//Moving the address into a different register
    MOV         R7,R3//Copied term value
    MOV         R8,0//low-sum register
    MOV         R9,0//hi-sum register
    MOV         R10,0//low-power register
    MOV         R11,1//high-power register
loop:
    CBZ         R7,done // Comparing to see if the term goes done to 0 and then ends the loop
    LDMIA       R6!,{R2,R3} // Moving the 64 bit term into R2 and R#
    MOV         R0,R10 // Moving the low bit Power into R0
    MOV         R1,R11 // Moving the high bit Power into R1
    BL          Q32Product // Multiply
    ADDS        R8,R0,R8 // Adding the low bit into R8
    ADC         R9,R1,R9 // Adding the high bit into R9
    MOV         R0,R4 // Moving back the x term into R0
    MOV         R1,R5 // Moving back the x term into R1
    MOV         R2,R10// Moving the power into R2
    MOV         R3,R11//Moving the power into R3
    BL          Q32Product // Multiply to find x^power
    MOV         R10,R0 // Storing low bit
    MOV         R11,R1 // Storing high bit
    SUB         R7,R7,1 // Subtracting term by 1
    B           loop
done:
    MOV         R0,R8 // Move the low bit sum
    MOV         R1,R9 // Move the high bit sum
    POP         {R4,R5,R6,R7,R8,R9,R10,R11,LR}
    BX          LR //Returning the polynomial

        .end
