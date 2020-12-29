//Author-Susan Sapkota 
// Date- 06/19/2020
// lab 3 part 3
#include<stdio.h>
// program to calculate if there is alternate pattern in number :

unsigned pattern_(unsigned num_1);

void main ()
{
    unsigned x;
    unsigned outcome;
    x=2863311530; // it has alternate 1 and zero
    outcome= pattern_(x);
    if(outcome==1)
    {
       printf("there is pattern of alternating 1 and 0");
    }
    else
    {
       printf("there is no pattern");
    }   


}


unsigned pattern_(unsigned num_1)
{
  unsigned j;
  unsigned outcome;
  unsigned r1; 
  unsigned r2;
  unsigned num_2= 1; // 255 is the decimal number for 8 bits binary number 11111111
  
  for(j=0; j<31; j++)
  { 
      r1= num_1 & num_2;
      r1=r1<<1;
      r2=r1 & num_2;
      if( r1!=r2)
      {
       return 0;
      }
      num_2=r1; // changing to left side bit
     
                
  }
  return 1;
}

