#include <stdio.h>
// Susan Sapkota 06/12/2020:lab2 part1
/* program to calculate total number of characters in line and total number of vowels in a line */

# define MAXLINE 1000 /* maximum size of your input line */

int copy_getline( char input_array[], int maxline); // declare the getline function
void count_vowel( char input_array[], int length);  // declare the count vowel function
int main()
{
 char input_array[MAXLINE];
 int leng; // length of the line 
 printf("input your line\n");
 while((leng = copy_getline(input_array, MAXLINE)) >0) 
     {
    
       count_vowel(input_array,leng); // calling count_vowel function to calculate no of        vowels		
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


/* function to count vowel letters in a line */
void count_vowel(char ar[], int length)
{
   int count;
   count=0;
   int i;
   i=0;
   for(i; i<length; ++i)
     {  
       //begine for loop here
	if ( ar[i]== 'A' || ar[i]=='E' || ar[i]=='I' || ar[i]=='O' || ar[i]=='U')
	  {
		count++;
	  }
	else if( ar[i]== 'a' || ar[i]=='e' || ar[i]=='i' || ar[i]=='o' || ar[i]=='u')
	{
		count++;
        }
      }
printf("%s %d\n", "The total number of character in line->", length );
printf("%s %d\n", "The total number of vowels in line -> ", count);
}

