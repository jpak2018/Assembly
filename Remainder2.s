        .syntax     unified
	.cpu        cortex-m4
        .text
        .thumb_func
        .align       2



             .global     Remainder2
Remainder2:   LDR        R2,=1        //Loading 1 into Register 2
              LSL        R2,R2,R1     //Shifting by how much is in Register 1
              SUB        R2,R2,1      //Subtract 1 to get the mask
              AND        R3,R0,R2     //Finding the mod with the And instruction
              ASR        R0,R0,31     //Shifting it incase its negative
              ADD        R2,R2,1      //This gives us back the original power
              AND        R2,R2,R0     //You use the And instruction to see if the number is positive or negative
              SUB        R0,R3,R2     //Subtracts by the mod if its negative to get a negative remainder
              BX         LR

              .end
