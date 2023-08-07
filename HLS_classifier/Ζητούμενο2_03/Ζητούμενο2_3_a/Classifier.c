///////////////////////////////////////////////////////////////////////
#include "Classifier.h"
#include <math.h>
#include <stdio.h>


// SVM classification function
output_type svmClassification(input_data_type x[Dsv],coefficient_type coefficients[Nsv],support_vector_type support_vectors[Nsv][Dsv]) { //support_vectors[Dsv*Nsv]
    // Compute decision value
    double sum =0;
    double sum_new=0;
    int column ;



    // Array partions
  	 #pragma HLS array_partition variable = x  complete  dim =1
     #pragma HLS array_partition variable =support_vectors   complete  dim =2

    for (int i = 0; i < Nsv; i++) {
        input_data_type metro_2 = 0.0;
        column=i;

        support_vectors[0][0] = 0.452850 ;

        for (int s = 0; s < Dsv; s++) {
              #pragma HLS UNROLL factor=9  // auto unroll !
              //double diff = x[s] - support_vectors[column + s*Nsv]; //for 1D
        	  double diff = x[s] - (support_vectors[i][s]);           // for 2D
               metro_2 += diff * diff;

        }
        sum_new = (coefficients[i]*exp(-g*metro_2) ) ;
        sum = sum + sum_new;

           }

	sum =sum -  b;

   // printf("Totale SUM  is %f\n", sum);
    output_type output;
    if (sum > 0) {
        output = 1;  // Positive class label
    } else if( sum < 0) {
        output = -1;  // Negative class label
    }

    return output;
}

// Top-level function for HLS synthesis
int svmClassification_top(input_data_type x[Dsv],coefficient_type coefficients[Nsv],support_vector_type support_vectors[Nsv][Dsv]) { //support_vectors[Dsv*Nsv]
	int output;
    output = svmClassification( x,coefficients, support_vectors);
    return output;
}
