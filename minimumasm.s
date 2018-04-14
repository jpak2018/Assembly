        .syntax     unified
	.cpu        cortex-m4
        .text
        .thumb_func
        .align       2

// uint32_t  Add1(uint32_t x) ;

        .global     minimum_asm
minimum_asm:   MOV         R2,R0      //Mov R0 into R2
               LDR         R0,[R2],4  //Loading the element into R0
               SUB         R1,R1,1    //Subtracting the Count by 1
               CMP         R1,R0      //Checking to see if R1 is 0
               BEQ         done       //If the CMP is true then the program will end
loop:          LDR         R0,[R2],4  //Loading the next value in the array into R0
               CMP         R0,R1      //Compares the Value
               IT          LT
               MOVLT       R1,R0      //Moves the value to R1
               SUBS        R1,R1,1    //Subtracting by 1
               BEQ         done       //If they are equal will proceed to done
               B           loop       //If not equal will go through loop again

done:
               BX          LR        //Returns LR/R0

               .end

