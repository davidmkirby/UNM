// Author-Susan Sapkota 
// Date- 06/27/2020
// part 1 header file 
void switch_points(float *p1, float *p2);


struct points { float a; float b;}; // a and b are member of structure points

// function to create point with a and b element (a,b)
struct points createpoint (float a, float b)
{
   struct points t; // reserve storage for the points
   t.a=a; // assign the value of the first point of the point
   t.b=b; // assign the value of the second point of the point 
   return t;
}
void switch_points(float *p1, float *p2)
{
   float t1=*p1;
   *p1 = *p2;
   *p2 = t1;
}




