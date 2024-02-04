#include <stdio.h>
#include <math.h>
#include <string.h>
#include "Classifier.h"
#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdlib.h>


void extractNumbers( char buffer[], double numbers[], int maxNumbers,int line) { // line =0 take all the lines.
    char* token = strtok(buffer, ",");  // Tokenize the string using comma as the delimiter
    int count = 0;
   // printf("char token is: %s\n",token);

    while (token != NULL && count < maxNumbers) {
        numbers[count + maxNumbers*line] =   atof(token);  // Convert the token to a double and store it in the numbers array
        count++;
        token = strtok(NULL, ",");  // Move to the next token
    }
}

void readCSVFile(const char* filePath,double values[],int maxValues,int line) {
    FILE* file = fopen(filePath, "r");
    if (file == NULL) {
        printf("Failed to open the file.\n");
        return;
    }

    int count = 0;
    if(line ==0){ // take all the lines of csv file
    char buffer[1222*270];

    while (fgets(buffer, 100*sizeof(buffer), file) != NULL) {
      //  printf("%s", buffer);
        extractNumbers(  buffer,  values, 1222,count);
        count++;
     }
    }
    else if (line > 0){ // take the line you choose from csv file
    	char buffer[18*100];
    	while (fgets(buffer, 100*sizeof(buffer), file) != NULL) {
    	      //  printf("%s", buffer);
    		    count++;
    		    if(line == count ) {
    	        extractNumbers(  buffer,  values, 1222,0);
    	        break;
    		    }
    }
   }
    else { // for the annotation ONLY
    	char buffer[1000*2];
    	while (fgets(buffer, sizeof(buffer), file) && count < 1000) {
    	        double value = atof(buffer);
    	        values[count++] = value;
    	    }
   }
   // printf("counter is %d\n",count);

    fclose(file);
}





///////////////////////////////////////////////////////// for test bench
int main() {
const int SAMPLES = 1000; // 1000 input x vectors
input_data_type x[Dsv];
//coefficient_type coefficients[Nsv];
//support_vector_type support_vectors[MAX_ROWS][MAX_COLS];
//support_vector_type support_vectors[MAX_ROWS*MAX_COLS];
output_type* output;
int temp_array[SAMPLES+10];
double hit =0;
double miss =0;
FILE    *fp;


fp=fopen("out.dat","w");
//// function    coefficients <- line[0]
    const char* filePath1 = "C:/CSV_VLSI/sv_coef.csv";
    const int maxValues1 = 1222;  // Maximum number of values to store
    double coefficients[maxValues1];
   readCSVFile(filePath1,coefficients,maxValues1,0);
//        for (int s = 0; s < maxValues1; s++) {
//                  printf("Value %d: %.2f\n", s, coefficients[s]);
//             }


//// function  full  support_vecotrs[] <-scv all lines
    const char* filePath2 = "C:/CSV_VLSI/support_vectors.csv";
    const int maxValues2 = 1222;  // Maximum number of values to store
    double support_vectors[maxValues2*19];
     readCSVFile(filePath2,support_vectors,maxValues2,0);
//                 for (int s = 0  ; s < maxValues2*18; s++) {
//                            printf("Value %d: %.2f\n", s,support_vectors[s]);
//                        }


     //make the 1D array to 2D array
               support_vectors[0] = 0.452850; // something wrong with the  the [0][0]
               support_vector_type array[Nsv][Dsv];
               for(int q = 0;q <Nsv; q++) {
                   for(int m =0 ; m < Dsv;m++) {

                  	array[q][m]= support_vectors[Nsv*m +q];
                  }
                 }




 for(int n = 0 ; n < SAMPLES;n++) {

/// function full  X <-  line[n]
	  const char* filePath3 = "C:/CSV_VLSI/testing_set.csv";
	  const int maxValues3 = 18;  // Maximum number of values to store
	  double x[maxValues3];
	  readCSVFile(filePath3,x,maxValues3,n+1);

	  array[0][0] = 0.452850;

//  Save the results.
       // temp_array[n] = svmClassification_top(x,coefficients,support_vectors); // for 1D
	      temp_array[n] = svmClassification_top(x,coefficients,array); 			 // for 2D
      //  printf("My output  is %d\n", temp_array[n]);

   }

   fclose(fp);
   printf ("Comparing against output data \n");

   const char* filePath4 = "C:/CSV_VLSI/annotation.csv";
             const int maxValues4 = 1000;  // Maximum number of values to store
             double given_values[maxValues4];
            readCSVFile(filePath4,given_values,maxValues4,-1);


    for (int i =0 ; i <SAMPLES; i++) {
    	if(given_values[i] == temp_array[i]) hit++;
    	else miss++;
    }

   double acc = (hit/SAMPLES)*100;
   printf("The accuracy is %.2f%%\n", acc);


}
