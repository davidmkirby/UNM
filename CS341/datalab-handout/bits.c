/* 
 * CS:APP Data Lab 
 * 
 * <Susan Sapkota UNM id-101753373>
 * 
 * bits.c - Source file with your solutions to the Lab.
 *          This is the file you will hand in to your instructor.
 *
 * WARNING: Do not include the <stdio.h> header; it confuses the dlc
 * compiler. You can still use printf for debugging without including
 * <stdio.h>, although you might get a compiler warning. In general,
 * it's not good practice to ignore compiler warnings, but in this
 * case it's OK.  
 */

#if 0
/*
 * Instructions to Students:
 *
 * STEP 1: Read the following instructions carefully.
 */

You will provide your solution to the Data Lab by
editing the collection of functions in this source file.

INTEGER CODING RULES:
 
  Replace the "return" statement in each function with one
  or more lines of C code that implements the function. Your code 
  must conform to the following style:
 
  int Funct(arg1, arg2, ...) {
      /* brief description of how your implementation works */
      int var1 = Expr1;
      ...
      int varM = ExprM;

      varJ = ExprJ;
      ...
      varN = ExprN;
      return ExprR;
  }

  Each "Expr" is an expression using ONLY the following:
  1. Integer constants 0 through 255 (0xFF), inclusive. You are
      not allowed to use big constants such as 0xffffffff.
  2. Function arguments and local variables (no global variables).
  3. Unary integer operations ! ~
  4. Binary integer operations & ^ | + << >>
    
  Some of the problems restrict the set of allowed operators even further.
  Each "Expr" may consist of multiple operators. You are not restricted to
  one operator per line.

  You are expressly forbidden to:
  1. Use any control constructs such as if, do, while, for, switch, etc.
  2. Define or use any macros.
  3. Define any additional functions in this file.
  4. Call any functions.
  5. Use any other operations, such as &&, ||, -, or ?:
  6. Use any form of casting.
  7. Use any data type other than int.  This implies that you
     cannot use arrays, structs, or unions.

 
  You may assume that your machine:
  1. Uses 2s complement, 32-bit representations of integers.
  2. Performs right shifts arithmetically.
  3. Has unpredictable behavior when shifting an integer by more
     than the word size.

EXAMPLES OF ACCEPTABLE CODING STYLE:
  /*
   * pow2plus1 - returns 2^x + 1, where 0 <= x <= 31
   */
  int pow2plus1(int x) {
     /* exploit ability of shifts to compute powers of 2 */
     return (1 << x) + 1;
  }

  /*
   * pow2plus4 - returns 2^x + 4, where 0 <= x <= 31
   */
  int pow2plus4(int x) {
     /* exploit ability of shifts to compute powers of 2 */
     int result = (1 << x);
     result += 4;
     return result;
  }

FLOATING POINT CODING RULES

For the problems that require you to implent floating-point operations,
the coding rules are less strict.  You are allowed to use looping and
conditional control.  You are allowed to use both ints and unsigneds.
You can use arbitrary integer and unsigned constants.

You are expressly forbidden to:
  1. Define or use any macros.
  2. Define any additional functions in this file.
  3. Call any functions.
  4. Use any form of casting.
  5. Use any data type other than int or unsigned.  This means that you
     cannot use arrays, structs, or unions.
  6. Use any floating point data types, operations, or constants.


NOTES:
  1. Use the dlc (data lab checker) compiler (described in the handout) to 
     check the legality of your solutions.
  2. Each function has a maximum number of operators (! ~ & ^ | + << >>)
     that you are allowed to use for your implementation of the function. 
     The max operator count is checked by dlc. Note that '=' is not 
     counted; you may use as many of these as you want without penalty.
  3. Use the btest test harness to check your functions for correctness.
  4. Use the BDD checker to formally verify your functions
  5. The maximum number of ops for each function is given in the
     header comment for each function. If there are any inconsistencies 
     between the maximum ops in the writeup and in this file, consider
     this file the authoritative source.

/*
 * STEP 2: Modify the following functions according the coding rules.
 * 
 *   IMPORTANT. TO AVOID GRADING SURPRISES:
 *   1. Use the dlc compiler to check that your solutions conform
 *      to the coding rules.
 *   2. Use the BDD checker to formally verify that your solutions produce 
 *      the correct answers.
 */


#endif
/* Copyright (C) 1991-2016 Free Software Foundation, Inc.
   This file is part of the GNU C Library.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library; if not, see
   <http://www.gnu.org/licenses/>.  */
/* This header is separate from features.h so that the compiler can
   include it implicitly at the start of every compilation.  It must
   not itself include <features.h> or any other header that includes
   <features.h> because the implicit include comes before any feature
   test macros that may be defined in a source file before it first
   explicitly includes a system header.  GCC knows the name of this
   header in order to preinclude it.  */
/* glibc's intent is to support the IEC 559 math functionality, real
   and complex.  If the GCC (4.9 and later) predefined macros
   specifying compiler intent are available, use them to determine
   whether the overall intent is to support these features; otherwise,
   presume an older compiler has intent to support these features and
   define these macros by default.  */
/* wchar_t uses Unicode 8.0.0.  Version 8.0 of the Unicode Standard is
   synchronized with ISO/IEC 10646:2014, plus Amendment 1 (published
   2015-05-15).  */
/* We do not support C11 <threads.h>.  */
/* 
 * allEvenBits - return 1 if all even-numbered bits in word set to 1
 *   Examples allEvenBits(0xFFFFFFFE) = 0, allEvenBits(0x55555555) = 1
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 12
 *   Rating: 2
 */
int allEvenBits(int x) {
       // initial i need some number where even position bit is 1 which is 0x55
       // 0x55 in binary is 0101 0101
       // i will use left shift to make 0x55555555 
       //  use AND with 0x55555555 and x to get match up the digit
       // in even position
       int even_bit;
       int and_bit;
       even_bit = 0x55 + (0x55 << 8);
       even_bit = (even_bit << 16) +even_bit;
       and_bit = x & even_bit;
       return !(and_bit ^ even_bit); // using XOR with even_bit if I have same
       // bit comination (1,1) or (0,0) we get 0 and doing negation we get 1
       // and if i have (1,0) or (0,1) then XOR will be 1 and final result is 0
}
/*
 * bitParity - returns 1 if x contains an odd number of 0's
 *   Examples: bitParity(5) = 0, bitParity(7) = 1
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 20
 *   Rating: 4
 */
int bitParity(int x) {
 // the simple way to solve this problem is using xor in two halves of number either
 // increasing or decreasing shifting order
// i did with increasing shifting order. i took x shifted by 1 and did XOR with X and
//  then shifted by 2,4,8,16 as we have 32 bits. after that ifi use bit (and) operator
//  then i get parity as required. 
 x = x ^(x >> 1);
  x = x ^(x >> 2);
  x = x ^(x >> 4);
  x = x ^(x >> 8);
  x = x ^(x >> 16);
  return x & 1 ;
}
/* 
 * bitXor - x^y using only ~ and & 
 *   Example: bitXor(4, 5) = 1
 *   Legal ops: ~ &
 *   Max ops: 14
 *   Rating: 1
 */
int bitXor(int x, int y) {
  // i keep on trying with bunch of combination and tried de morgan's law through wikipedia 
  // NOR gate is just inverted-input AND gate so the below expression truth table give XOR 
  return  ~(x & y) & (~(~x & ~y));
}
/* 
 * replaceByte(x,n,c) - Replace byte n in x with c
 *   Bytes numbered from 0 (LSB) to 3 (MSB)
 *   Examples: replaceByte(0x12345678,1,0xab) = 0x1234ab78
 *   You can assume 0 <= n <= 3 and 0 <= c <= 255
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 10
 *   Rating: 3
 */
int replaceByte(int x, int n, int c) {
// suppose (0x12345678,1,0xab) 
// 1<<3 = 8 (1000 in binary) using left shift operator 
// 0xff<<8 =1111 1111 0000 0000 in binary
// int shift_2 is NOT of 0xff<<8 = 1111 1111 1111 1111 0000 0000 1111 1111
// doing shift_2 AND x will get me 0001 0010 0011 0100 0000 0000 0111 1000
// doing OR with previous step and c<< shift_1 I get 0001 0010 0011 0100 1010 1011 0111 1000
  int shift_1 = n<<3; // using left shift by 3 to form byte shift as 1 byte contain 8 bits 
  int shift_2 = ~(0xff << shift_1);//using 0xff as constant shifted by shift_1 and 
  //did 2's complement 
  return (x & shift_2) |(c << shift_1) ;
 }
/* 
 * TMax - return maximum two's complement integer 
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 4
 *   Rating: 1
 */
int tmax(void) {
/* Tmax value in binary is 0111 1111 1111 1111 1111 1111 1111 1111
 * I just shift 1 by 31 bit  which will give me Tmin and if i do complement(~) to Tmin then I get Tmax
 */ 
 return ~(1<<31);
}
/* 
 * fitsBits - return 1 if x can be represented as an 
 *  n-bit, two's complement integer.
 *   1 <= n <= 32
 *   Examples: fitsBits(5,3) = 0, fitsBits(-4,3) = 1
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 15
 *   Rating: 2
 */
int fitsBits(int x, int n) {
// I created shift with n considering the case of negative
// i have to add 1 to 32 which is diffference between max value of n and size of integer 
 int shift= 32+1+ ~n;
  // in next line x is shifted by shift left and then right and do XOR with X 
  // if we do negation of previous described step then it will return 
  // 1 if it can be represented or 0 if it cannot be represented
 return !(((x << shift) >> shift) ^x);
}
/* 
 * isEqual - return 1 if x == y, and 0 otherwise 
 *   Examples: isEqual(5,5) = 1, isEqual(4,5) = 0
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 5
 *   Rating: 2
 */
int isEqual(int x, int y) {
  /* I kind of thought this solution using XOR(^) and negation(!) operator
   * using XOR between x and y in bitwise level it will give 0 if corresponding bit is alternate or give 1 if corresponding bit is same then doing negation will return be 1 if it is same number 
 */
   return !(x ^ y) ;
}
/* 
 * isPositive - return 1 if x > 0, return 0 otherwise 
 *   Example: isPositive(-1) = 0.
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 8
 *   Rating: 3
 */
int isPositive(int x) {
// i kind of use !, &, << operator to check wheter it is positive or negative 
// textbook says the 1st digit is sign so 1<<31 and using AND operator with x i will get sign// masking if both is 1 then it will return 1 otherwise 0 
// Doing OR with negation of x will get me idea of sign and doing again negation will get me // 1 if int is positive
  return !((!x) |( x & ( 1<<31))); 
}
/* 
 * subOK - Determine if can compute x-y without overflow
 *   Example: subOK(0x80000000,0x80000000) = 1,
 *            subOK(0x80000000,0x70000000) = 0, 
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 20
 *   Rating: 3
 */
int subOK(int x, int y) {
// basic idea is to check whether both number are positive or negative
// according stack link shared by TA overflow occurs when difference is not represented on 32 //bit int 
// and for subtration it occurs if arithmetical correct difference doesn't match
// with computed difference
       	int a = x ^ y; 
  int b = x+(1+~y);
      b = b^x;
      return !((a&b)>>31);
  }
/* howManyBits - return the minimum number of bits required to represent x in
 *             two's complement
 *  Examples: howManyBits(12) = 5
 *            howManyBits(298) = 10
 *            howManyBits(-5) = 4
 *            howManyBits(0)  = 1
 *            howManyBits(-1) = 1
 *            howManyBits(0x80000000) = 32
 *  Legal ops: ! ~ & ^ | + << >>
 *  Max ops: 90
 *  Rating: 4
 */
int howManyBits(int x) {
   /*the simple idea to count the number of bit by right shifting and left shiftting
    * alright the main idea is to check how many bits it required and keep on shifting and
    * adding to the bit_num 
    */
    int bit_num = 0;
    x = x ^ (x >> 31);//sign bit
    bit_num = bit_num + ((!!(x >> (bit_num + 16))) << 4);
    bit_num = bit_num + ((!!(x >> (bit_num + 8))) << 3); 
    bit_num = bit_num + ((!!(x >> (bit_num + 4))) << 2); 
    bit_num = bit_num + ((!!(x >> (bit_num + 2))) << 1);
    bit_num = bit_num + ((!!(x >> (bit_num + 1))));
    bit_num = bit_num + (x >> bit_num);
    return bit_num + 1;
 }
/* 
 * float_abs - Return bit-level equivalent of absolute value of f for
 *   floating point argument f.
 *   Both the argument and result are passed as unsigned int's, but
 *   they are to be interpreted as the bit-level representations of
 *   single-precision floating point values.
 *   When argument is NaN, return argument..
 *   Legal ops: Any integer/unsigned operations incl. ||, &&. also if, while
 *   Max ops: 10
 *   Rating: 2
 */
unsigned float_abs(unsigned uf) {
  /* the plan is to take maximum positive value for 32 bit 0x7fffffff
   * I will use this value and use AND operation to make unsigned positive value and check if it greater than 0x7f800000 this is the value when your exponent is 1111111 */
 unsigned a= (0x7fffffff & uf);
 if (a > 0x7f800000)
   {
     return uf;
   }
 else 
   {
   return a;
   } 
}
/* 
 * float_twice - Return bit-level equivalent of expression 2*f for
 *   floating point argument f.
 *   Both the argument and result are passed as unsigned int's, but
 *   they are to be interpreted as the bit-level representation of
 *   single-precision floating point values.
 *   When argument is NaN, return argument
 *   Legal ops: Any integer/unsigned operations incl. ||, &&. also if, while
 *   Max ops: 30
 *   Rating: 4
 */
unsigned float_twice(unsigned uf) {
 /*here 23 means mantissa 1<<31 determine sign of the uf
 * we can use == as I already form == sign on the above problem
 */ 
  if (uf==0 || uf== 0x80000000) return uf; //if the input is zero
  if ((( uf>>23) & 0xff) == 0xff) return uf; //moving the bits of uf by 23 and applying
  // bitwise AND when input is NaN
  if ((( uf>>23) & 0xff) == 0x00) //when input has few bits
{
    return (uf & (1<<31)) | (uf<<1);
   }
  return uf + (1<<23);
}
/*
 * trueFiveEighths - multiplies by 5/8 rounding toward 0,
 *  avoiding errors due to overflow
 *  Examples: trueFiveEighths(11) = 6
 *            trueFiveEighths(-9) = -5
 *            trueFiveEighths(0x30000000) = 0x1E000000 (no overflow)
 *  Legal ops: ! ~ & ^ | + << >>
 *  Max ops: 25
 *  Rating: 4
 */
int trueFiveEighths(int x)
{
/* i will do this on 3 steps
 * step-1 by divide by 8 using right shift
 * step-2 multiply by 5 using left shift 
 * step-3 calculate remainder use 0x7 as constant to find remainder 
 * then add remainder 
 */   
        int div_8 = x>>3;             
        int rem = x&0x7;         
        int multi_5  = (div_8<<2)+div_8;           
	rem = (rem+(rem<<2) + ((x>>31)&0x7))>>3;                 
        return  multi_5+rem;  
}
