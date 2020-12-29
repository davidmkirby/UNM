// Author-Susan Sapkota
// Date- 07/17/2020
// Lab 7
// program to delete the country with positive longitude or latitude from the given CSV file 
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

#define LINE 1024

// Modified struct to be set-up for a linked list implementation
typedef struct country_capital {
	char country[100];
	char capital[100];
	float cap_lat;
	float cap_long;
	char code[3]; // Make code at least 3 characters long to avoid weird bug
	char continent[50];
	struct country_capital *next_pointer;
} cc;


// This function will delete the appropriate countries and return head, which is a pointer to the first struct in the list
cc * delete_some(cc *head, cc *temp) {
        cc *previous;
        while (temp != NULL && temp->cap_lat>0 && temp->cap_long >0) { // if latitude or longitude is positive, delete and update
		head = temp->next_pointer;
		free(temp);
		temp = head;
	}
	previous = temp;
        // Deal with the remaining links, other than head
	while( temp!= NULL) {
		while (temp != NULL && temp->cap_lat < 0 && temp->cap_long < 0) { // if latitude and longitude are both negative, keep iterating, 
			previous = temp;
			temp = temp->next_pointer;
		}
	
		// We need to check for NULL in case the inner while loop iterated to the end of the list
		if (temp != NULL) {
			previous->next_pointer = temp->next_pointer;
			free(temp);
			temp = previous->next_pointer;
		}
        }
       
        //TODO -> create the code that will iterate through the linked list and delete every country that does not have 
	// both a negative capital latitude and negative capital longitude
	// Hint -> In addition to head and temp, I would initialize a Previous struct pointer to help keep track of where you are, see code I posted to Learn!
	
	return head;

}

void main() {
	
	char *this_token;
	cc *head;
	cc *temp;
	cc *current;
	FILE *f;
	f = fopen("country-capitals.csv", "r");

	if (f == NULL) {
		printf("Try again \n");
		return;
	}

	char my_string[LINE];
	int counter = 0;
	int token_count;

	while(fgets(my_string, LINE, f) != NULL) {

		current  = (cc *) malloc(sizeof(cc));
		this_token = strtok(my_string, ",");
		token_count = 0;

		while (this_token != NULL) {
			if (token_count== 0) {
				strcpy(current->country, this_token);
			} else if (token_count == 1) {
				strcpy(current->capital, this_token);
			} else if (token_count == 2) {
				current->cap_lat = (float) atof(this_token);
			} else if (token_count == 3) {
				current->cap_long = (float) atof(this_token);
			} else if (token_count == 4) {
				strcpy(current->code, this_token);
			} else {
				strcpy(current->continent, this_token);
			}
			
			token_count = token_count + 1; 
			this_token = strtok(NULL, ",");
		}

		if (counter == 0) {
			head = current;
			temp = current;
		} else {
			temp->next_pointer = current;
			temp = current;
		}

		counter = counter + 1;
		
	} // end outer while loop

	temp->next_pointer = NULL;
	temp = head;
	printf("\n");

	while(temp != NULL) {
		if (temp->next_pointer != NULL) {
			printf("%s, ", temp->country);
			temp = temp->next_pointer;

		} else {
			printf("%s", temp->country);
			temp = temp->next_pointer;
		}
	}
	temp=head;
	// deleting every country which has positive longitude or latitude
	printf("\n\nafter deleting:");
	delete_some(head,temp); // calling function to delete all the positive longitude or latitude
	temp=head; // return type is head so i just let my temp equal whather the function return 
	// printing the linked list in vertical form 
        while(temp != NULL) {
		if (temp->next_pointer != NULL) {
			printf("%s\n", temp->country);
			temp = temp->next_pointer;

		} else {
			printf("%s\n", temp->country);
			temp = temp->next_pointer;
		}
	}
	printf("\n");	
} // end main
