# include <stdio.h>
/* print Fahrenheit-Celsiou table for fahr= 0, 20,......, 300 */
int main()
{
float fahr, celsius;
int lower, upper, step;
lower=0; /* lower limit of temperature*/
upper=300; /* upper limit */
step=20; /*step size*/
fahr=lower;
while (fahr<=upper)
{
celsius = 5.0/9.0 * (fahr-32.0) ; /* first multiplying by 5 because if we multiply by 5/9 then it will truncate to zero*/
printf("%3.0f \t %6.1f \n", fahr, celsius);
fahr=fahr+step;
}
}


