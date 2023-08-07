/*****************************************************
Getting Started Guide for Zybo
This demo displays the status of the switches on the
LEDs and prints a message to the serial communication
when a button is pressed.
****************************************************/
#include <stdio.h>
#include "platform.h"
#include "xparameters.h"
#include "sleep.h"
#include <inttypes.h> //to set 32 bit output
#include "xil_types.h"
#include "xil_io.h"
#include "platform.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "sleep.h"
#define MY_IP_BASEADDR 0x43C00000 //tha to vroume meta apo to xparameters.h (auto tha prepei na nai to onoma)

int main() {
	init_platform();

      unsigned int A,data_in,y,valid_in ,rst,valid_out,B;

  //  int32_t B,A;
  //  int32_t y;
  //  int B_print, A_print;
  //  int valid_out;
    int RST;
  //  int rst, valid_in, data_in;

     while(1) {
    	 valid_out =0;


       xil_printf("Give input N\n");
       scanf("%d",&data_in);

       xil_printf("give reset\n");
       scanf("%d",&rst);

       xil_printf("give valid in\n");
       scanf("%d",&valid_in);

       valid_in = valid_in << 8;
       RST =rst;
       rst =rst << 9;
       A = rst | valid_in | data_in;

       //for print input
       xil_printf("A is:");
       xil_printf("%d",A);
       xil_printf("/n");


        Xil_Out32((MY_IP_BASEADDR+0x00), A); //write to FIR to reg0

      //  usleep(500); // delay
           if( valid_in == 0  || RST == 1 )  {
                 B = Xil_In32(MY_IP_BASEADDR+0x04);
        	      valid_out = B &  0x80000;
                  xil_printf("\nvalid_out   is: %d \n",  valid_out);
                 } 
         else  { 
           while (valid_out == 0 ) {
        	      B = Xil_In32(MY_IP_BASEADDR+0x04);
        	      valid_out = B &  0x80000;
                  xil_printf("\nB  is: %d \n",  B);

               }

           
               y = B & 0x7FFFF; //mask for y
               xil_printf("%u\n",y);
           } 

     }
    cleanup_platform();
    return 0;
}


/* stratakos logic
loop1 :
Write to reg0; // reg0 =00..0.valid_out.y

loop2:
if(valid_out==1) print(y);
else if(valid_out==0) jump to loop2
jump to loop1
*/
