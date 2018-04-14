        .syntax     unified
	.cpu        cortex-m4
        .text
        .thumb_func
        .align       2

// uint32_t  Add1(uint32_t x) ;

         .global     Modulus
Modulus: SDIV        R2,R0,R1       //Stores the quotient into R2
         MLS         R0,R1,R2,R0    //Stores the remainder back into R0
         Add         R0,R0,R1       // You add the remainder with the divisor
         SDIV        R2,R0,R1       // You need find the quotient again and store that into R2
         MLS         R0,R1,R2,R0    //Divided R2 by the divisor to get the remainder again. This scenario makes it so that it works with both positive and negative numbers.
         BX          LR

         .end
