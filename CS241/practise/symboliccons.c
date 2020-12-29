# include <stdio.h>
#define lower 0 /* lower limit*/
#define upper 300 /* upper limit */
#define step 20 /* step size */
/* fahrenheit and celcius conversion */
int main()
{ 
float fahr, celcius;
fahr=lower;
while ( fahr <= upper)
{
celcius= (5.0/9.0) * (fahr-32);
printf ("%3.0f \t %6.2f \n", fahr, celcius);
fahr = fahr + step;
}
}

