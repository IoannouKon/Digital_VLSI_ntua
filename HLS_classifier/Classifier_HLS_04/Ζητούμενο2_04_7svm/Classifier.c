///////////////////////////////////////////////////////////////////////
#include "Classifier.h"
#include <math.h>
#include <stdio.h>
int N = 7;

// SVM classification function
double svmClassification1(input_data_type x[Dsv],coefficient_type coefficients[Nsv],support_vector_type support_vectors[Nsv][Dsv]) { //support_vectors[Dsv*Nsv]
    // Compute decision value
    double sum =0;
    double sum_new=0;
    int column ;



    // Array partions
  	 #pragma HLS array_partition variable = x  complete  dim =1
     #pragma HLS array_partition variable =support_vectors   complete  dim =2

    for (int i = 0; i < Nsv/N; i++) {
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
	double sum1,sum2,sum3,sum4,sum5,sum6,sum7,sum;
	int i;
	int m=7;
	coefficient_type coefficients1[Nsv/m],coefficients2[Nsv/m],coefficients3[Nsv/m],coefficients4[Nsv/m],coefficients5[Nsv/m],coefficients6[Nsv/m],coefficients7[Nsv/m];
	support_vector_type support_vectors1[Nsv/m][Dsv],support_vectors2[Nsv/m][Dsv],support_vectors3[Nsv/m][Dsv],support_vectors4[Nsv/m][Dsv],support_vectors5[Nsv/m][Dsv],support_vectors6[Nsv/m][Dsv],
	support_vectors7[Nsv/m][Dsv];

	for( i=0; i< Nsv/N; i++ )  { // split  coefficients[Nsv]
		coefficients1[i] = coefficients[i]; // printf("cof1[%d] = %f\n",i,coefficients1[i] );
		coefficients2[i] = coefficients[i +Nsv/m]; // printf("cof2[%d] = %f\n",i,coefficients2[i] );
		coefficients3[i] = coefficients[i +2*(Nsv/m)];
		coefficients4[i] = coefficients[i +3*(Nsv/m)];
		coefficients5[i] = coefficients[i +4*(Nsv/m)];
		coefficients6[i] = coefficients[i +5*(Nsv/m)];
		coefficients7[i] = coefficients[i +6*(Nsv/m)];
		}


	for( i =0; i< Nsv/N;i++) { //// split  support_vectors[Nsv][Dsv]
		for(int j=0;j<Dsv;j++){
			support_vectors1[i][j] = support_vectors[i][j]; // if(i== (Nsv/2)-1)  printf("sv1[%d][%d] = %f\n",i,j,support_vectors1[i][j] );
			support_vectors2[i][j] = support_vectors[i+Nsv/m][j];  //if(i==0)  printf("sv2[%d][%d] = %f\n",i,j,support_vectors2[i][j] );
			support_vectors3[i][j] = support_vectors[i+2*(Nsv/m)][j];
			support_vectors4[i][j] = support_vectors[i+3*(Nsv/m)][j];
			support_vectors5[i][j] = support_vectors[i+4*(Nsv/m)][j];
			support_vectors6[i][j] = support_vectors[i+5*(Nsv/m)][j];
			support_vectors7[i][j] = support_vectors[i+6*(Nsv/m)][j];
		}
	}

	#pragma HLS dataflow  // Add dataflow directive here for parallel execution
    sum1 = svmClassification1( x,coefficients1, support_vectors1);
    sum2 = svmClassification1( x,coefficients2, support_vectors2);
    sum3 = svmClassification1( x,coefficients3, support_vectors3);
    sum4 = svmClassification1( x,coefficients4, support_vectors4);
    sum5 = svmClassification1( x,coefficients5, support_vectors5);
    sum6 = svmClassification1( x,coefficients6, support_vectors6);
    sum7 = svmClassification1( x,coefficients7, support_vectors7);

    sum =sum1+sum2+sum3+sum4+sum5+sum6+sum7;

        output_type output;
        if (sum > 0) {
            output = 1;  // Positive class label
        } else if( sum < 0) {
            output = -1;  // Negative class label
        }
    return output;
}
