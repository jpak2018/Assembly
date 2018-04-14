        .syntax     unified
	.cpu        cortex-m4
        .text
        .thumb_func
        .align       2

// uint32_t  Add1(uint32_t x) ;

        .global     pWord
pWord:  Push   {R4,R5,LR} //I pushed R4 and R5 to give myself space to store numbers that assembly will make
        Mul    R4,R1,R2   // Multiply the # of columns and rows and stores it in R4
        Add	   R4,R4,R3   // You add what column you are looking for to your value stored in R4
        LSL    R5,R4,2    // You want to shift by bytes so you LSL 2 which will shift it 4 bytes and store it in R5
        Add    R5,R5,R0   // Then you add R0 to R5 and store it back there so you won't lose the value
        Mov    R0,R5      // Copy the data from R5 back to R0
        Pop    {R4,R5,LR} // Pop back what you pushed
        BX     LR         // Return R0
        .end

