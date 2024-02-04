///////////////////////////////////////////////////////////////////////////////
// here for "svmClassification.h"
#define Dsv 18 
#define Nsv 1222 
#define g 8
#define b 2.8180

#define MAX_ROWS 18 // Maximum number of rows in the CSV file
#define MAX_COLS 1222  // Maximum number of columns in the CSV file

// Define data types and constants
typedef double  input_data_type;
typedef double support_vector_type;
typedef double coefficient_type;
typedef int output_type; 

//int svmClassification_top(
//  input_data_type x[Dsv],
//  coefficient_type coefficients[Nsv],
//  support_vector_type support_vectors[Dsv*Nsv],
//  output_type* output
//  );

int svmClassification_top(
  double x[Dsv],
  double coefficients[Nsv],
  double support_vectors[Dsv*Nsv]
 // output_type* output
  );



