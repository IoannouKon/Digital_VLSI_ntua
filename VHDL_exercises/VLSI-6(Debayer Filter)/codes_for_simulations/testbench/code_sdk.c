#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "xparameters_ps.h"
#include "xaxidma.h"
#include "xtime_l.h"
#include <unistd.h>

#define TX_DMA_ID                 XPAR_PS2PL_DMA_DEVICE_ID
#define TX_DMA_MM2S_LENGTH_ADDR  (XPAR_PS2PL_DMA_BASEADDR + 0x28) // Reports actual number of bytes transferred from PS->PL (use Xil_In32 for report)

#define RX_DMA_ID                 XPAR_PL2PS_DMA_DEVICE_ID
#define RX_DMA_S2MM_LENGTH_ADDR  (XPAR_PL2PS_DMA_BASEADDR + 0x58) // Reports actual number of bytes transferred from PL->PS (use Xil_In32 for report)

#define TX_BUFFER (XPAR_DDR_MEM_BASEADDR + 0x10000000) // 0 + 512MByte/2 -> 256Mbyte
#define RX_BUFFER (XPAR_DDR_MEM_BASEADDR + 0x18000000) // 0 + 768MByte/2  ->

//#define TX_BUFFER (XPAR_DDR_MEM_BASEADDR + 0x20000000) // 0 + 512MByte -> 256Mbyte
//#define RX_BUFFER (XPAR_DDR_MEM_BASEADDR + 0x30000000) // 0 + 768MByte  ->

/* User application global variables & defines */
// #define N 1024 ;
XAxiDma TxAxiDma; //PS2PL DMA Engine
XAxiDma RxAxiDma; //PL2PS DMA Engine

int main() {
	Xil_DCacheDisable();

	XTime preExecCyclesFPGA = 0;
	XTime postExecCyclesFPGA = 0;
	XTime preExecCyclesSW = 0;
	XTime postExecCyclesSW = 0;

	int N =32;

	print("HELLO 1\r\n");
	// User application local variables
    int TxStatus, RxStatus;
	u8 *TxBufferPtr;
	u32 *RxBufferPtr;
    XAxiDma_Config *TxDMAptr,*RxDMAptr;
	TxBufferPtr = (u8 *)TX_BUFFER; //8bit data to accelerator
	RxBufferPtr = (u32 *)RX_BUFFER; //32bit data from accelerator


	u8 r_gt[N*N];
	u8 g_gt[N*N];
	u8 b_gt[N*N];

	u8 r_hw[N*N];
    u8 g_hw[N*N];
    u8 b_hw[N*N];

    int err = 0;
    float err_per,speedup;
    int FPGA_cycles, SW_cycles;

	init_platform();

	print("\r\n press enter...");
	getchar();

    // Step 1: Initialize TX-DMA Device (PS->PL)
    TxDMAptr = XAxiDma_LookupConfig(TX_DMA_ID); //The configuration structure for the device. If the device ID is not found,a NULL pointer is returned.
    if (!TxDMAptr) {
        xil_printf("No config found for RX-DMA Device\r\n");
        return XST_FAILURE;
    }

    TxStatus = XAxiDma_CfgInitialize(&TxAxiDma, TxDMAptr);
    if (TxStatus != XST_SUCCESS) {
        xil_printf("Initialization failed for RX-DMA Device\r\n");
        return XST_FAILURE;
    }
    else xil_printf("Config found RX-DMA Device\r\n");
    for(int i=0; i<N*N; i++) TxBufferPtr[i] =  i+1 ; //rand()%255;

    // Step 2: Initialize RX-DMA Device (PL->PS)
    RxDMAptr = XAxiDma_LookupConfig(RX_DMA_ID);
    if (!RxDMAptr) {
        xil_printf("No config found TX-DMA Device\r\n");
        return XST_FAILURE;
    }
    else xil_printf("Config found TX-DMA Device\r\n");

    RxStatus = XAxiDma_CfgInitialize(&RxAxiDma, RxDMAptr);
    if (RxStatus != XST_SUCCESS) {
        xil_printf("Initialization failed for RX-DMA Device\r\n");
        return XST_FAILURE;
    }
    else xil_printf("Initialization successful for RX-DMA Device\r\n");
   memset(RxBufferPtr,32,N*N*4);

    XTime_GetTime(&preExecCyclesFPGA);
    // Step 3 : Perform FPGA processing
    //3a: Setup RX-DMA transaction
    RxStatus = XAxiDma_SimpleTransfer(&RxAxiDma,(UINTPTR) RxBufferPtr,N*N*4-N, XAXIDMA_DEVICE_TO_DMA);
    if (RxStatus != XST_SUCCESS) {
        xil_printf("RX-DMA Transaction failed\r\n");
        return XST_FAILURE;
    }
    else xil_printf("Rx Transaction is okay \r\n");
    //3b: Setup TX-DMA transaction
    TxStatus = XAxiDma_SimpleTransfer(&TxAxiDma,(UINTPTR) TxBufferPtr, N*N, XAXIDMA_DMA_TO_DEVICE);
    if (TxStatus != XST_SUCCESS) {
        xil_printf("TX-DMA Transaction failed\r\n");
        return XST_FAILURE;
    }
    else xil_printf("Tx Transaction is okay \r\n");
    ////CHECK XAXIDMA_DEVICE_TO_DMA AND XAXIDMA_DMA_TO_DEVICE

      XAxiDma_IntrDisable(&TxAxiDma, XAXIDMA_IRQ_ALL_MASK,
                          XAXIDMA_DEVICE_TO_DMA);

      XAxiDma_IntrDisable(&TxAxiDma, XAXIDMA_IRQ_ALL_MASK,
                          XAXIDMA_DMA_TO_DEVICE);

      XAxiDma_IntrDisable(&RxAxiDma, XAXIDMA_IRQ_ALL_MASK,
                          XAXIDMA_DEVICE_TO_DMA);

      XAxiDma_IntrDisable(&RxAxiDma, XAXIDMA_IRQ_ALL_MASK,
                          XAXIDMA_DMA_TO_DEVICE);

    //3c: Wait for TX-DMA & RX-DMA to finish
    while((XAxiDma_Busy(&TxAxiDma,XAXIDMA_DMA_TO_DEVICE))) ;
    xil_printf("Finished TX-DMA engine\r\n");
  //  while((XAxiDma_Busy(&RxAxiDma,XAXIDMA_DEVICE_TO_DMA))) ;
     usleep(100*1000);
    xil_printf("Finished RX-DMA engine\r\n");
//   xil_printf("Waiting RX-DMA engine\r\n");
//   while((XAxiDma_Busy(&TxAxiDma,XAXIDMA_DEVICE_TO_DMA))) xil_printf("Waiting TX-DMA engine\r\n");
//   while((XAxiDma_Busy(&RxAxiDma,XAXIDMA_DMA_TO_DEVICE))) xil_printf("Waiting RX-DMA engine\r\n");

    XTime_GetTime(&postExecCyclesFPGA);
    //mallon den prepei na kanoume kati edw
    XTime_GetTime(&preExecCyclesSW);
    // Step 5: Perform SW processing
    for (int i = 0; i < N; i++) {
           for (int j = 0; j < N; j++) {
               int right = (j < N - 1) ? (j + 1) : 0;
               int left = (j > 0) ? (j - 1) : 0;
               int up = (i > 0) ? (i - 1) : 0;
               int down = (i < N - 1) ? (i + 1) : 0;
               int r = (j < N - 1) ? TxBufferPtr[right + N * i] : 0;
               int l = (j > 0) ? TxBufferPtr[i * N + left] : 0;
               int u = (i > 0) ? TxBufferPtr[up * N + j] : 0;
               int d = (i < N - 1) ? TxBufferPtr[down * N + j] : 0;
               int d1 = ((i > 0) && (j > 0)) ? TxBufferPtr[up * N + left] : 0;
               int d2 = ((i > 0) && j < (N - 1)) ? TxBufferPtr[up * N + right] : 0;
               int d3 = ((i < N - 1) && (j > 0)) ? TxBufferPtr[down * N + left] : 0;
               int d4 = ((i < N - 1) && (j < N - 1)) ? TxBufferPtr[down * N + right] : 0;
               int cc = TxBufferPtr[i*N+j];
               if (i % 2) {
                   if (j % 2) { //green
                       r_gt[i*N+j] = (r + l) / 2;
                       g_gt[i*N+j] = cc;
                       b_gt[i*N+j] = (u + d) / 2;
                   }
                   else { //red
                       r_gt[i*N+j] = cc;
                       g_gt[i*N+j] = (u + d + r + l) / 4;
                       b_gt[i*N+j] = (d1 + d2 + d3 + d4) / 4 ;
                   }
               }
               else {
                   if (j % 2) { //blue
                       r_gt[i*N+j] = (d1 + d2 + d3 + d4) / 4;
                       g_gt[i*N+j] = (u + d + r + l) / 4;
                       b_gt[i*N+j] = cc;
                   }
                   else { //green2
                       r_gt[i*N+j] = (u + d) / 2;
                       g_gt[i*N+j] = cc;
                       b_gt[i*N+j] = (r + l) / 2 ;
                   }
               }
           }
       }

    XTime_GetTime(&postExecCyclesSW);

    // Step 6: Compare FPGA and SW results


    for (int  i=0; i<N*N; i++) {
        r_hw[i] = (RxBufferPtr[i] >> 16)&0xff;
        g_hw[i] = (RxBufferPtr[i] >> 8)&0xff;
        b_hw[i] = RxBufferPtr[i]&0xff;
        if ((r_hw[i] != r_gt[i]) || (g_hw[i] != g_gt[i]) || (b_hw[i] != b_gt[i])) err++;

    }



  for (int a =0 ; a<N*N ;a++) {
    printf("%d %d %d ",r_hw[a] , g_hw[a] , b_hw[a] ) ;
    printf("| %d %d %d\n", r_gt[a] , g_gt[a],b_gt[a]) ;
	// printf("%lu \n",(unsigned long)RxBufferPtr[a]);
    }

    //6a: Report total percentage error
    err_per = (float)(err/N*N)*100;
    printf("Total Percentage error is: %0.2f %% \r\n", err_per);
    //6b: Report FPGA execution time in cycles (use preExecCyclesFPGA and postExecCyclesFPGA)
    FPGA_cycles = postExecCyclesFPGA - preExecCyclesFPGA;
    xil_printf("FPGA execution time is: %d% \r\n", FPGA_cycles);
    //6c: Report SW execution time in cycles (use preExecCyclesSW and postExecCyclesSW)
    SW_cycles = postExecCyclesSW - preExecCyclesSW;
    xil_printf("SW execution time is: %d% \r\n",SW_cycles);
    //6d: Report speedup (SW_execution_time / FPGA_exection_time)
    speedup = (float)(SW_cycles/FPGA_cycles);
    printf("Speedup is: %0.2f %% \r\n", speedup);

    cleanup_platform();
    return 0;
}
