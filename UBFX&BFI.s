        .syntax     unified
	.cpu        cortex-m4
        .text
        .thumb_func
        .align       2



        .global     UBFX
UBFX:   LDR         R3,=1       //Loads R3 with 1
        LSR         R0,R0,R1    //Shifitng the bit by lsb so the bit will now start at 0
        LSL         R3,R3,R2    //Creating the mask
        SUB         R3,R3,1     //So the mask will have 0's at the end
        AND         R0,R0,R3    // Anding with the mask so the end will be all 0's
        BX          LR          //Return the Link Register


        .global     BFI
BFI:    Push        {R4}
        LDR         R4,=1       //Loading R4 with 1
        LSL         R4,R4,R3    //Shifting it by 8 bits
        SUB         R4,R4,1     //Creating the Mask
        AND         R1,R1,R4    // Anding with the Mask to be inserted later
        LSL         R4,R4,R2    //Shifting the mask by lsb to get into the spot where it will be inserted
        BIC         R0,R0,R4    //Clearing the bits in the bitfield where the mask will be inserted
        LSL         R1,R1,R2    //Shifting the mask again
        ORR         R0,R0,R1    // inserting the mask and making sure before and after are still 1's
        Pop         {R4}
        BX          LR
        .end

