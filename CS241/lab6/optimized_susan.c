// Author-Susan Sapkota 
// Date- 07/10/2020
// lab 6 part 2 
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void naive_bubble(int *dynamic, int iter) {

	// an optimized version of bubblesort here that will sort dynamic array 
	  int i;
    int j;
    for ( i=0; i<iter; i++) {
        for ( j=1; j<iter-i; j++) {
           int temp;
           // using if to check the two element of the array if array at the begin is greater 
           if( *(dynamic+ j-1)> *(dynamic+j)) {
             temp= *(dynamic+j-1); // initializing for the swapping element
             *(dynamic+j-1)= *(dynamic+j); // swapping the element 
             *(dynamic+j)=temp; // using temporary variable to get j element 
             }
         }
    }
}

	
void main() {

	clock_t start, end;
    double total;
	int num_of_array_ele[8] = {10, 100, 1000, 10000, 100000, 1000000, 10000000, 100000000};
	int *dynam_array;
	srand(0);

	for (int k = 0; k < (sizeof(num_of_array_ele) / sizeof(num_of_array_ele[0])); k++) {

		
		// dynamically allocating the array 
		
		dynam_array=(int *)malloc(num_of_array_ele[k]*sizeof(int));

		// This will check to see if space was properly allocated, if not, return and print useful info to screen
		if (dynam_array == NULL) {

			printf("No space available\n");
			return;
		}

		//fill with random elements
		for (int y = 0; y < num_of_array_ele[k]; y++) {
			dynam_array[y] = rand();
		}

		// This will time each sort
		start = clock();
		naive_bubble(dynam_array, num_of_array_ele[k]);
		end = clock();

		// This will calculate the total running time and print it out to the screen for user to see
		total = (double)(end - start) / CLOCKS_PER_SEC;
		printf("The total time to execute for array of size %d -> %f \n",num_of_array_ele[k], total);

		free(dynam_array); //free this space for next iteration
	
	}
	
}
