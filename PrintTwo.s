        .syntax     unified
	.cpu        cortex-m4
        .text
        .thumb_func
        .align       2

// uint32_t  Add1(uint32_t x) ;

        .global     PrintTwo
PrintTwo:   Push {R4,R5,LR}		// You Push R4 and R5 because you want to store numbers witout them being changed from calling the function
            MOV  R4,R0          //Storing num into R4
            MOV  R5,R1          //Storing int into R5
            BL   printf         //Calling the print function to print out R0 & R1
            MOV  R0,R4          //Moving back num into R0
            MOV  R1,R5          //Moving back int from R5 to R1
            ADD  R1,R1,1        //Adding 1 to the int and returning it to R1
            BL   printf         //Calling the print function to print R0 & R1
            Pop  {R4,R5,LR}     //Pop out the registers that you pushed in the beginning
            BX   LR             //Returns the Link Register

        .end

