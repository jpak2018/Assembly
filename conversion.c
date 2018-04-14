#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#pragma warning(disable:4996)

long decimaltobinary(long n);
int main(void)
{
	while (1) // so that the function keeps on running all the time
	{
		printf("Enter a decimal integer between (-128 to 255)\n"); // asks the user to enter a number between -128 and 255
		int n;
		scanf("%d", &n); // this allows the user to input a number of their choice
		if (n >= -128 && n <= -1)
		{
			printf("2's complement: %08d\n", decimaltobinary(n)); // we use %08d to make sure that we have an 8 digit number and telling the compiler to add 0's to any missing digit
		}
		else if (n >= 0 && n <= 127)
		{
			printf("Unsigned and 2's complement: %08d\n", decimaltobinary(n)); // the print function prints out the corresponding words/title and its binary number by executing the function based off the users input
		}
		else if (n >= 128 && n <= 255)
		{
			printf("Unsigned: %08d\n", decimaltobinary(n));
		}
		else
		{
			printf("Out of Range\n");
		}

	}
}
long decimaltobinary(long n) // this fucntion is used to convert the given decimal number into binary
{

	if (n < 0) // if we want to convert a 2's complement number into binary we can add 256 to that number and we'll get the postive number that will give us the binary number equivalent to the 2's complement number
	{
		n = n + 256;
	}
	int remainder = 0; // setting the variable that will be needed to run the function
	long binary = 0, i = 1;


	while (n != 0) // a while loop is used so that the loop will always run until our number finally reaches 0 so by then we should have all the bit numbers we need
		{
			remainder = n % 2; // we are doing mod 2 to get either 1 or 0 which will be the first bit starting from the right and moving to the left
			n = n / 2;
			binary = binary + (remainder * i);
			i = i * 10; // we multiply by 10 since each digit is a factor of 10 so by multiplying by 10 we move to the next bit

		}
	return binary; // returns the binary number corresponded to the decimal number that the user inputed
}
