// Author-Susan Sapkota
// UNMid-101753373
#include "cachelab.h"
#include <getopt.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <math.h>

//struct containing parameters and trace as pointer
typedef struct{
	int set;
	int lines;
	int blocks;
	char* trace;

} parameters;

//struct containing valid bit, tag and latest state
typedef struct{
	int latest;
	int valid;
	long long int tag;
} line;

int main(int argc, char** argv)
{
    parameters param;     // struct parameter.
    char cp;          //parsed character from the command line.
    line **linepointer;    // valid and tag bit and latest
    int S;         //Total number of sets 
    char op;    //type of operation from the trace file
    unsigned long int address;  //address from trace file 
    unsigned long int tag;      //the tag value
    unsigned long int set;     //the set value.
    int hit_num =0;          //the number of total hits.
    int miss_num = 0;       //the total number of misses.
    int evict_num =0;    //the total number of evictions.

    //getting each of the parameter using getopt
    while((cp = getopt(argc, argv, "s:E:b:t:")) != -1)
    {
	    switch(cp)
	    {
		    case 's': 
             param.set = atoi(optarg);
			 break;
		    case 'E':
             param.lines = atoi(optarg);       //The number of lines
			 break;
		    case 'b':
             param.blocks = atoi(optarg);      //The number of blocks.
			 break;
		    case 't': 
             param.trace = optarg;           //Trace file as strings
			 break;  
	    }
    }
     S = pow(2, param.set);     //Total number of sets is 2^s
    FILE *pfile;
    pfile = fopen(param.trace, "r");               
    if(pfile== NULL){
	    printf("there is no trace file");
	    exit(1);
    }

    //using malloc function to allocate space for the line set
    linepointer = malloc(S*8);
    int i =0;
    int counter =0;
    for(i =0; i<S;i++){
	    linepointer[i] = malloc(param.lines* sizeof(line));
    }

    //Reading file until reaching end 
    while(fscanf(pfile, " %c %lx", &op, &address)== 2)
    {
	    tag = (address>>param.set)>>param.blocks;
	    int tag_size = 64 - (param.set + param.blocks);   //tag=m-(s+b)
	    set = (address<< tag_size)>>(64-param.set);
	    printf("\nOperation is %c, with address %ld tag = %lx, set = %lx",op,address, tag, set);
        i = 0;
        // initiazing hit,invalid line and eviction to check for hit,invalid line and eviction
        int hit = 0;
        int validline = 0;
        int evict =0;
	    int leastline = -1; //least rectly used line 
	    int m =0;
	    counter =0;
	    if(op == 'M' || op == 'S' || op== 'L'){     
	    while(i<param.lines){
		    if((linepointer[set][i]).valid == 0 && validline ==0 ){
			    validline = 1;
			    counter = i;
		    } else if ((linepointer[set][i]).valid ==1 && (linepointer[set][i]).tag == tag){  //hit
			    hit = 1;
			    for(m = 0; m< param.lines; m++){
				    if(m == i){
					    (linepointer[set][m]).latest = 0;                 //hit since recently use
				    } else {
					    (linepointer[set][m]).latest = (linepointer[set][m]).latest +1;     
				    }
			    }
			    break;
		    }
		    i++;
	    }
	    if(hit==0){
		if(validline == 1 ){    //check for only valid line
			(linepointer[set][counter]).valid = 1;      //set the specific invalid lines of code to valid.
			(linepointer[set][counter]).tag = tag;      //tag for the corresponding line 
				for(m = 0; m< param.lines; m++){    
                       if(m == counter){
                                    (linepointer[set][m]).latest = 0;       
                       } else {
                            (linepointer[set][m]).latest = (linepointer[set][m]).latest +1; 
                               }
				}
				evict= 0;     // invalid cache, so no eviction

                } else if (validline == 0){
			int k  =0;
			int lru =0;

			//least line number stored in lru with the highest latest.
			for( k=0; k<param.lines;k++){
				if(linepointer[set][k].latest >leastline){
						 leastline = (linepointer[set][k]).latest;
						    lru = k;
				}
			}
			for(m = 0; m< param.lines; m++){
                                if(m == lru){
                                        (linepointer[set][m]).latest = 0; //recently used so latest is zero
                                } else {
                                     (linepointer[set][m]).latest = (linepointer[set][m]).latest +1; // increasing latest
				}
			}
				(linepointer[set][lru]).valid = 1;
				(linepointer[set][lru]).tag = tag;
				evict =1;
		}
	    }

		if (hit){  //check for hit
			hit_num += 1;

		} else if(evict){ //check for eviction
			miss_num +=1;
			evict_num +=1;
		} else { //no eviction but is miss
			    miss_num +=1;
		}
		if(op == 'M'){ 
			hit_num +=1;
		}
	    }
    }
    fclose(pfile);
    int r = 0;
    //deallocating the line pointer 
    for(r = 0; r<S;r++){
	    free(linepointer[r]);
    }
    free(linepointer);
    printSummary(hit_num, miss_num, evict_num);
    return 0;
}
