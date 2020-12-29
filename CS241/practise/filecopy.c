#include <stdio.h>
/* copy input to output */ 
 void main() 
{
int c;
c = getchar();
while ( c | EOF) {
putchar(c);
c=getchar();
}
}

