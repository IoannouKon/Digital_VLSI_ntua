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
        for (int s = 0; s < Dsv; s+=9) {
			  //   #pragma HLS UNROLL factor=9  // auto unroll !

        	//!!!!Manual loop unroling!!!!
               diff[0] = x[s+0] - support_vectors[column + (s+0)*Nsv];
               diff[1] = x[s+1] - support_vectors[column + (s+1)*Nsv];
               diff[2] = x[s+2] - support_vectors[column + (s+2)*Nsv];
               diff[3] = x[s+3] - support_vectors[column + (s+3)*Nsv];
               diff[4] = x[s+4] - support_vectors[column + (s+4)*Nsv];
               diff[5] = x[s+5] - support_vectors[column + (s+5)*Nsv];
               diff[6] = x[s+6] - support_vectors[column + (s+6)*Nsv];
               diff[7] = x[s+7] - support_vectors[column + (s+7)*Nsv];
               diff[8] = x[s+8] - support_vectors[column + (s+8)*Nsv];


               metro_2[0] = diff[0] * diff[0];
               metro_2[1] = diff[1] * diff[1];
               metro_2[2] = diff[2] * diff[2];
               metro_2[3] = diff[3] * diff[3];
               metro_2[4] = diff[4] * diff[4];
               metro_2[5] = diff[5] * diff[5];
               metro_2[6] = diff[6] * diff[6];
               metro_2[7] = diff[7] * diff[7];
               metro_2[8] = diff[8] * diff[8];

     total_metro_2 +=   metro_2[0] + metro_2[1] + metro_2[2] + metro_2[3] + metro_2[4] + metro_2[5] + metro_2[6] + metro_2[7] + metro_2[8];


        }
        sum_new = (coefficients[i]*exp(-g*total_metro_2) ) ;
        
        sum = sum + sum_new;
        //printf("The step %d  the sum_new is: %f\n",i,  sum_new);
           }
    sum =sum -  b;
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
