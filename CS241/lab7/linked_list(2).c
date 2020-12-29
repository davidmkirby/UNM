#include <stdio.h>
#include <stdlib.h>

void main() {

	// Defintion of link struct
	typedef struct link {
		int num1;
		struct link *next_pointer;
	} link;

	struct link *head;
	struct link *current;
	struct link *temp;
	struct link *previous;

	// Filling our linked list with simple data (for loop counter)
	for (int k = 0; k < 401; k++) {
	
		// allocate space for struct (link)
		current = (link *)malloc(sizeof(link));
		current->num1 = k; // set the data element


		if (k == 0) {
			head = current;
			temp = current;
		} else {
			temp->next_pointer = current;
			temp = current;
		}
	}


	temp->next_pointer = NULL; // Initializing the last link to point to NULL
	temp = head; // Used to begin deleting or traversing

	/*
	/ Deleting every link that has data that when modded by 4 is 0
	*/

	// Deal with head stuff here
	while (temp != NULL && temp->num1 % 4 == 0) {
		head = temp->next_pointer;
		free(temp);
		temp = head;
	}

	previous = temp;

	// Deal with the remaining links, other than head
	while (temp != NULL) {
		while (temp != NULL && temp->num1 % 4 != 0) {
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
	
	// Print out our linked list
	temp = head;
	while(temp != NULL) {
		printf("%d \n", temp->num1);
		temp = temp->next_pointer;
	}


}

