#include <stdio.h>
// Author- Susan Sapkota 
// 06/19/2020
// lab 3 part 1


void masking(int num_1);   // declaring the masking function to call 

int main()
{
  int num_1 = 9000;  // in binary it is 00000000000000000010001100101000

  printf("%s %d \n", "This is the initial unsigned int in main before sent to mask->", num_1);

  masking(num_1);  // calling function to do masking 

}


// mask function to create 4 partion of total 32 bits meaning 8 bits per partition

void masking(int num_1)
{
  int j;
  int outcome;
  int array_1[4]; //array having place to store 4 mask 
  int num_2= 255; // 255 is the decimal number for 8 bits binary number 11111111
  
  for(j=0; j<4; j++)
  { 
      array_1[j]= num_1 & num_2; //story each digit for and command 
      num_2= num_2<<8;           // shifting towards left by 8 bits 
  }
  
  
  outcome= array_1[0] |array_1[1] |array_1[2] |array_1[3]; // using or command to combine the result 
  printf(" %s %d \n", " this is the result after masking into 4 partition and adding with OR->", outcome);
}
  
 
  
