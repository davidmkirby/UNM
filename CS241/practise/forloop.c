#include <stdio.h>
/*print Fahrenheit-Celsius table */
int main()
{
float fahr, celsius;
for( fahr=0; fahr <=300; fahr=fahr+20)
{
celsius=(5.0/9.0) * (fahr-32);
printf("%3.0f %6.1f\n", fahr, celsius);
}
}

