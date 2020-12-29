// Author-Susan Sapkota 
// Date- 06/27/2020
// the reference file of char string_2d_array from learn part2_1
// Part2 first part
// program to compute timing of reversing the function with 2d array using strcpy built in function 
#include <stdio.h>
#include <string.h>
#include <time.h>
#define NUMBER_OF_ROWS 100
#define CHARACTERS_PER_ROW 21
// function to reverse the rows 
void reverse_rows_2d(char string_array[NUMBER_OF_ROWS][CHARACTERS_PER_ROW])
{
  char temp_1[21]; // temporary variable to store the row
  char temp_2[21]; // second temporary variable to store the row
  int count_num, i; 
  count_num = 99;

  for(i=0; i<50; i++)
  {
   temp_1[0] = (char)0; // making sure temp_1 and temp_2 are empty on each iteration
   temp_2[0] = (char)0;
   strcpy(temp_1, string_array[i]); // copying the i th row to the temp_1
   string_array[i][0] = (char)0;    // making sure the i th row is empty to copy 
   strcpy(temp_2, string_array[count_num]); // copying the temp_1 to the ith row of array
   string_array[count_num][0] = (char)0; //making sure the count_num th row of array is empty to copy
   strcpy(string_array[i], temp_2);// copying the row from last to temp_2
   strcpy(string_array[count_num],temp_1);// copying temp_2 to the row from the last
   count_num--;
  }
  
 // this is for the checking if it is reversing or not 
// for (int k = 0; k< 100; k++) {
 
 //	printf("%s \n", string_array[k]);
 // } 
}

void main() {

        clock_t start, end;
        double total;
	char string_2d_array[NUMBER_OF_ROWS][CHARACTERS_PER_ROW] = {"This is line -> 1",
									"This is line -> 2",
									"This is line -> 3",
									"This is line -> 4",
									"This is line -> 5",
									"This is line -> 6",
									"This is line -> 7",
									"This is line -> 8",
									"This is line -> 9",
									"This is line -> 10",
									"This is line -> 11",
									"This is line -> 12",
									"This is line -> 13",
									"This is line -> 14",
									"This is line -> 15",
									"This is line -> 16",
									"This is line -> 17",
									"This is line -> 18",
									"This is line -> 19",
									"This is line -> 20",
									"This is line -> 21",
									"This is line -> 22",
									"This is line -> 23",
									"This is line -> 24",
									"This is line -> 25",
									"This is line -> 26",
									"This is line -> 27",
									"This is line -> 28",
									"This is line -> 29",
									"This is line -> 30",
									"This is line -> 31",
									"This is line -> 32",
									"This is line -> 33",
									"This is line -> 34",
									"This is line -> 35",
									"This is line -> 36",
									"This is line -> 37",
									"This is line -> 38",
									"This is line -> 39",
									"This is line -> 40",
									"This is line -> 41",
									"This is line -> 42",
									"This is line -> 43",
									"This is line -> 44",
									"This is line -> 45",
									"This is line -> 46",
									"This is line -> 47",
									"This is line -> 48",
									"This is line -> 49",
									"This is line -> 50",
									"This is line -> 51",
									"This is line -> 52",
									"This is line -> 53",
									"This is line -> 54",
									"This is line -> 55",
									"This is line -> 56",
									"This is line -> 57",
									"This is line -> 58",
									"This is line -> 59",
									"This is line -> 60",
									"This is line -> 61",
									"This is line -> 62",
									"This is line -> 63",
									"This is line -> 64",
									"This is line -> 65",
									"This is line -> 66",
									"This is line -> 67",
									"This is line -> 68",
									"This is line -> 69",
									"This is line -> 70",
									"This is line -> 71",
									"This is line -> 72",
									"This is line -> 73",
									"This is line -> 74",
									"This is line -> 75",
									"This is line -> 76",
									"This is line -> 77",
									"This is line -> 78",
									"This is line -> 79",
									"This is line -> 80",
									"This is line -> 81",
									"This is line -> 82",
									"This is line -> 83",
									"This is line -> 84",
									"This is line -> 85",
									"This is line -> 86",
									"This is line -> 87",
									"This is line -> 88",
									"This is line -> 89",
									"This is line -> 90",
									"This is line -> 91",
									"This is line -> 92",
									"This is line -> 93",
									"This is line -> 94",
									"This is line -> 95",
									"This is line -> 96",
									"This is line -> 97",
									"This is line -> 98",
									"This is line -> 99",
									"This is line -> 100"};

	// a function call here one time after completing the reverse_rows_2d() function
	// reverse_rows_2d(string_2d_array);
	

	start = clock();	
	// calling function to check the time period for iteration
	int i;
	for(i=0; i<100000000; i++) 
	{
	 reverse_rows_2d(string_2d_array);
	}

	end = clock();
	total = (double)(end - start) / CLOCKS_PER_SEC;
	printf("The total time to execute -> %f \n", total);
}
