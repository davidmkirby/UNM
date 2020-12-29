// author- Susan Sapkota
// date- 06/19/2020
// lab 3 part 2

#include <stdio.h>

// declaring all the function we will use on main 
unsigned and1(unsigned num_1, unsigned num_2);
unsigned xor1(unsigned num_1, unsigned num_2);
unsigned add_1(unsigned num_1, unsigned num_2);
unsigned leftshift( unsigned num_1);

void main ()
{
 unsigned a;
 unsigned b;
 unsigned outcome;
 a=32;
 b=22;
 outcome= add_1(a, b);
printf(" %s  %u  %s %u %s %u \n", "The sum of ", a, " and ", b, " is ", outcome);
}



// and1 function this execute and operation between two number 
unsigned and1( unsigned num_1,unsigned num_2)
{

   return num_1 & num_2;
}


// xor1 function this function return xor operator which copies bit if it is set in one operand but not both 

unsigned xor1( unsigned num_1, unsigned num_2)
{
   return num_1 ^ num_2;
}


// add function return sum of two number 

unsigned add_1( unsigned num_1, unsigned num_2)
{

   if( num_1==0 & num_2== 0)
   {
     return num_1;
   }

   else if (num_2==0)
   {
     return num_1;
   }
   else
   {
      unsigned r;
      unsigned rr;
      while (num_2 != 0)
      {
 	 r= and1(num_1, num_2);
	 r=leftshift(r);
	 rr= xor1(num_1, num_2);
 	 num_2 = r;
 	 num_1 = rr;
      }
      return num_1;
    }
}      

// leftshift function return shifts 1 number to the left 
unsigned leftshift( unsigned num_1)
{
   return num_1 << 1 ;
}


