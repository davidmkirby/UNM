// Author- Susan Sapkota 
// Date- 07-03-2020
// lab-5 
// program to read array from CSV file and use struct to perform different function
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

#define TOTAL 196 // This number refers to the total number of countries in the csv file
#define LINE_SIZE 1024 // Max line size variable

// struct to use in computation
struct cc {
	char country[100];
	char capital[100];
	float cap_lat;
	float cap_long;
	char code[3]; // Make code at least 3 characters long to avoid weird bug
	char continent[50];
};
// function to find furtherst north based on latitude 
void northern_most_capital(struct cc data[TOTAL]) {
	int i;
	float max;
	int token_counter;
	int temp; // to store the location of the highest latitude;
	temp=0;
	max= data[0].cap_lat;
	for ( i=0; i<196; i++) 
	  {
	      if (data[i].cap_lat > max) // comparing each element of the column and replacing if it is greater than max 
	      {
	         max = data[i].cap_lat;
	         temp = i;
	      }
	  } 
	printf("The northern most capital is -> %s \n", data[temp].capital);
	
	

} 
//function to find the furthest south based on latitude 

void southern_most_capital(struct cc data[TOTAL]) {
	int i;
	float min;
	int token_counter;
	int temp; // to store the location of the lowest latitude;
	temp=0;
	min= data[0].cap_lat;
	for ( i=0; i<196; i++) 
	  {
	      if (data[i].cap_lat < min) //comparing to get the min latitude 
	      {
	         min = data[i].cap_lat;
	         temp = i;
	      }
	  } 
	printf("The southern most capital is -> %s \n", data[temp].capital);
} 

void closest_to_zero_long(struct cc data[TOTAL]) {

	//function to Print out the capital which lies closest to the 0 line of longitude, with  use of the fabs() function, to find the absolute value of a float
       int i;
	float min;
	int token_counter;
	int temp; // to store the location of the lowest longitude;
	temp=0;
	min= fabs(data[0].cap_long);
	for ( i=0; i<196; i++) 
	  {
	      if (fabs(data[i].cap_long) < min) 
	      {
	         min = fabs(data[i].cap_long);
	         temp = i;
	      }
	  } 
	printf("The capital that is closest to the zero longitude line is -> %s \n", data[temp].capital);
} 


void begins_with_k(struct cc data[TOTAL]) {

	//TODO -> this function will print out every country which has a capital that begins with the letter K.
	int i;
	char comp='K'; // store K to compare 
	char temp[50];
	printf("These are the countries that have capitals that begin with K: \n");
	for ( i=0; i<TOTAL; i++) {
	temp[0]=(char)0;
	  strcpy(temp, data[i].capital);
	      if (temp[0]==comp) 
	      {
	         printf("%s \n", data[i].country);
	      }
	}

} // end begins_with_k


void shared_name(struct cc data[TOTAL]) {
         // function to compare the capital name with country name of each country either in full or part and printing the country with it 
         int i;
         char *token;
         printf("The Countries below have capitals which share their country name :\n");
         for( i=0; i<TOTAL; i++) {
          char temp[100];
          strcpy(temp,data[i].capital);
          token=strtok( temp, " "); // breaking the string into series of token 
          while(token!= NULL){
          // checking each token if it has name of country      
             if (strcmp(token,data[i].country)==0) {
              printf("%s  ->  %s \n", data[i].country, data[i].capital); 
             }
             token=strtok( NULL, " ");
          }
         }

} // end shared_name


void main() {

	struct cc array[TOTAL];
	
	char *this_token; // Use this in conjunction with the strtok() function

	FILE *f;
	f = fopen("country-capitals.csv", "r");

	if (f == NULL) {
		printf("Try again \n");
		return;
	}

	char my_string[LINE_SIZE];
	int token_counter; // count for token
	int position = 0; //array position

	while(fgets(my_string, LINE_SIZE, f) != NULL) {
		token_counter = 0;

		this_token = strtok(my_string, ",");

		while (this_token != NULL) {
	
			if (token_counter == 0) {
				strcpy(array[position].country, this_token);
			} else if (token_counter == 1) {
				strcpy(array[position].capital, this_token);
			} else if (token_counter == 2) {
				array[position].cap_lat = (float) atof(this_token);
			} else if (token_counter == 3) {
				array[position].cap_long = (float) atof(this_token);
			} else if (token_counter == 4) {
				strcpy(array[position].code, this_token);
			} else {
				strcpy(array[position].continent, this_token);
			}


			token_counter = token_counter + 1;
			//printf("The token is -> %s \n", this_token);
			this_token = strtok(NULL, ",");
		}
		position = position + 1;


		
		
	}
	// calling the function to do require task 
	northern_most_capital(array);
	southern_most_capital(array);
	closest_to_zero_long(array);
	begins_with_k(array);
	shared_name(array);
   
	
}
