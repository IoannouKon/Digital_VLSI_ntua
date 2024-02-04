///////////////////////////////////////////////////////////////////////
#include "Classifier.h"
#include <math.h>
#include <stdio.h>

// SVM classification function
double svmClassification1(input_data_type x[Dsv],coefficient_type coefficients[Nsv],support_vector_type support_vectors[Nsv][Dsv]) { //support_vectors[Dsv*Nsv]
    // Compute decision value
    double sum =0;
    double sum_new=0;
    int column ;



    // Array partions
  	 #pragma HLS array_partition variable = x  complete  dim =1
     #pragma HLS array_partition variable =support_vectors   complete  dim =2

    for (int i = 0; i < Nsv/2; i++) {
        input_data_type metro_2 = 0.0;
        column=i;

       // support_vectors[0][0] = 0.452850 ;

        for (int s = 0; s < Dsv; s++) {
              #pragma HLS UNROLL factor=9  // auto unroll !
              //double diff = x[s] - support_vectors[column + s*Nsv]; //for 1D
        	  double diff = x[s] - (support_vectors[i][s]);           // for 2D
               metro_2 += diff * diff;

        }
        sum_new = (coefficients[i]*exp(-g*metro_2) ) ; // printf("function 1: cof[%d] = %f\n",i,coefficients[i] );
        sum = sum + sum_new;

           }
        sum =sum -  b;


    return sum;
}




// Top-level function for HLS synthesis
int svmClassification_top(input_data_type x[Dsv],coefficient_type coefficients[Nsv],support_vector_type support_vectors[Nsv][Dsv]) { //support_vectors[Dsv*Nsv]
	double sum1,sum2,sum;
	int i;
	coefficient_type coefficients1[Nsv/2],coefficients2[Nsv/2];
	support_vector_type support_vectors1[Nsv/2][Dsv],support_vectors2[Nsv/2][Dsv];

	for( i=0; i< Nsv/2; i++ )  { // split  coefficients[Nsv]
		coefficients1[i] = coefficients[i]; // printf("cof1[%d] = %f\n",i,coefficients1[i] );
		coefficients2[i] = coefficients[i +Nsv/2]; // printf("cof2[%d] = %f\n",i,coefficients2[i] );

		}


	for( i =0; i< Nsv/2;i++) { //// split  support_vectors[Nsv][Dsv]
		for(int j=0;j<Dsv;j++){
			support_vectors1[i][j] = support_vectors[i][j]; // if(i== (Nsv/2)-1)  printf("sv1[%d][%d] = %f\n",i,j,support_vectors1[i][j] );
			support_vectors2[i][j] = support_vectors[i+Nsv/2][j];  //if(i==0)  printf("sv2[%d][%d] = %f\n",i,j,support_vectors2[i][j] );
		}
	}

	#pragma HLS dataflow  // Add dataflow directive here for parallel execution
    sum1 = svmClassification1( x,coefficients1, support_vectors1);
    sum2 = svmClassification1( x,coefficients2, support_vectors2);


    sum =sum1+sum2;

        output_type output;
        if (sum > 0) {
            output = 1;  // Positive class label
        } else if( sum < 0) {
            output = -1;  // Negative class label
        }
    return output;
}
