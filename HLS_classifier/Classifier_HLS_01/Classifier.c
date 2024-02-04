///////////////////////////////////////////////////////////////////////
#include "Classifier.h"
#include <math.h>
#include <stdio.h>


// SVM classification function
output_type svmClassification(input_data_type x[Dsv],coefficient_type coefficients[Nsv],support_vector_type support_vectors[Dsv*Nsv]) {
    // Compute decision value
    double sum =0;
    double sum_new=0;
    int column ;
    for (int i = 0; i < Nsv; i++) {
        // Compute dot product between input features and support vector
        input_data_type metro_2[9] = {0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0};
        input_data_type total_metro_2 =0;
        double diff[9];
        column=i;
        support_vectors[0] = 0.452850; // something wrong with the  the [0][0]
        for (int s = 0; s < Dsv; s++) {
			  //   #pragma HLS UNROLL factor=9  // auto unroll !

               diff[0] = x[s+0] - support_vectors[column + (s+0)*Nsv];
               metro_2[0] = diff[0] * diff[0];

            total_metro_2 +=   metro_2[0] ;


        }
        sum_new = (coefficients[i]*exp(-g*total_metro_2) ) ;
        sum_new =sum_new -  b;
        sum = sum + sum_new;
        //printf("The step %d  the sum_new is: %f\n",i,  sum_new);
           }

    printf("Totale SUM  is %f\n", sum);
    output_type output;
    if (sum > 0) {
        output = 1;  // Positive class label
    } else if( sum < 0) {
        output = -1;  // Negative class label
    }

    return output;
}

// Top-level function for HLS synthesis
int svmClassification_top(input_data_type x[Dsv],coefficient_type coefficients[Nsv],support_vector_type support_vectors[Dsv*Nsv]) {
	int output;
    output = svmClassification( x,coefficients, support_vectors);
    return output;
}
