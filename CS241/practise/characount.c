#include <stdio.h>
/* count the character in input */
void main ()
{
long nc;
nc = 0;
while (getchar() != EOF)
{
++nc;

}
printf("%ld \n", nc);
}

