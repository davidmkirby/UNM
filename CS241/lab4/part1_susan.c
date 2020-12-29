// Author-Susan Sapkota
// Date 06/27/2020
// part 1 main file 
#include <stdio.h>
#include "part1_susan.h"






void main ()
{ 
   struct points p1 = createpoint(2,3);  // calling the structure function to assign 1st point
   struct points p2 = createpoint(6, 5); // calling the structure function to assign 2nd point
   struct points p3 = createpoint(2,10); // calling the structure function to assign 3rd point
   printf("first point before ->(%f, %f)\n", p1.a,p1.b);
   printf("second point before ->(%f, %f)\n", p2.a, p2.b);
   printf("third point before ->(%f, %f)\n", p3.a, p3.b);
   // calling switch function for swapping the point 1 and point 3
   switch_points(&p1.a, &p3.a);
   switch_points(&p1.b, &p3.b);
   printf("first point after ->(%f, %f)\n", p1.a,p1.b);
   // calling switch function again for swapping the point 1 and point 3 to unchange the value 
   switch_points(&p1.a, &p3.a);
   switch_points(&p1.b, &p3.b);
   //calling switch function to swap the point 2 and point 1
   switch_points(&p2.a, &p1.a);
   switch_points(&p2.b, &p1.b);
   printf("second point after ->(%f, %f)\n", p2.a, p2.b);
   // calling switch function to swap point 2 and 1 to restore the previous value 
   switch_points(&p2.a, &p1.a);
   switch_points(&p2.b, &p1.b);
   switch_points(&p3.a, &p2.a);
   switch_points(&p3.b, &p2.b);
   printf("third point before ->(%f, %f)\n", p3.a, p3.b);

}



