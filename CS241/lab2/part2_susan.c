#include<stdio.h>

// Susan Sapkota 06/12/2020:lab2 part2
/* program to input a lines of text and determine whether they have 50 character or less and print in reverse order if they have more than 50 character */

# define MAXLINE 1000 /* maximum size of your input line */

int copy_getline( char input_array[], int maxline); // declare the getline function
void reverse_line( char input_array[], int length);  // declare function for reverse string if they have more than 50 character
int main()
{
 char input_array[MAXLINE];
 int leng; // length of the line 
 printf("input your line\n");
 while((leng = copy_getline(input_array, MAXLINE)) >0) 
     {
    
       reverse_line(input_array,leng); // calling string reverse function to calculate if they have more than 50 character and reverse printing if they have more than 50		
     }
}
/* create getline function and restore on the some variable like v with its length ( reference from book for the getline function page 29 */
int copy_getline(char v[], int lim)
{
  int a, b;
  for ( b=0; b<lim-1 && (a=getchar()) !=EOF && a!='\n'; ++b)
  v[b]=a;
  if (a== '\n') 
     {
       v[b] = a;
       ++b;
     }
  v[b] = '\0';
  return b;
}

// function to determine if the lines of text has 50 character and if more than 50 character then printing in reverse order
 void reverse_line(char ar[],int length)
{
  
   int b;
   if (length <= 50)
   {
     printf("This line has 50 character or less\n");
   }
   else
   {
     printf("This line has more than 50 character\n");
     for (b=length; b>=0; b--)
     {
       printf("%c",ar[b]);
     }
   }  
}
  
   
    
