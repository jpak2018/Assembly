        .syntax     unified
	.cpu        cortex-m4
        .text
        .thumb_func
        .align       2

// uint32_t  Add1(uint32_t x) ;
        zero:      .float      0.0
        one:       .float      1.0

        .global     Poly
Poly:   VLDR        S2,zero     //Storing zero into S2
        VLDR        S3,one      // Storing one into S3
loop:   CBZ         R1,done     // If R1 is 0 that means there's 0 terms so you go to done immediately
        VLDMIA      R0!,{S1}    //Stores the coefficients from R0 into S1
        VMLA.F32    S2,S3,S1    // S2 = X^power * S1(term)*coefficient
        SUB         R1,R1,1     // Subtracting the amount of terms by 1
        VMUL.F32    S3,S3,S0    //Multiplying by the power
        B           loop        // Keeps on looping into terms is 0
done:   VMOV        S0,S2       // When you're done move S2 to S0 so you can return the polynomial
        BX          LR          // Returns




        .end
