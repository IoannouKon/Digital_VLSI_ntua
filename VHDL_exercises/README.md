# Digital VLSI Project

This repository contains projects and exercises related to Digital VLSI.

## Table of Contents
- [Exercise 1](#exercise-1)
- [Exercise 2](#exercise-2)
- [Exercise 3](#exercise-3)
- [Exercise 4](#exercise-4)
- [Exercise 5](#exercise-5)
- [Exercise 6](#exercise-6)
- 
###  [Exercise 1](./VLSI-1(introduction))

#### A2) Decoder 3 to 8 with Two Different Architectures: Dataflow and Behavioral

![Decoder 3 to 8 Diagram](https://github.com/IoannouKon/Digital_VLSI_ntua/assets/132226067/d46f0d9f-b2af-4f60-8923-259df7c5e3dd)

#### B2) Shift Register with Selectable Left/Right Shifting

![Shift Register Diagram](https://github.com/IoannouKon/Digital_VLSI_ntua/assets/132226067/d418ddf7-3f22-473f-ab9b-d0fe5dae0391)

This shift register includes an additional input (std_logic) to choose between left and right shifting. In left shifting, the output is the MSB of the register, while the serial input comes from the LSB.

#### B3) Counter

![Counter Diagram](https://github.com/IoannouKon/Digital_VLSI_ntua/assets/132226067/05d5b783-299d-4745-ba78-f1e087a31fb0)

Based on the provided counter, we describe a 3-bit up counter with a parallel input modulo (counting limit) of 3 bits.

We also describe an up/down counter based on the provided counter implementation.

### [Exercise 2](./VLSI-2(ADDERS))
The purpose of the laboratory exercise is to familiarize students with the design methodology using structural description. Specifically, students will design complex computational circuits using pre-implemented hardware modules.

1) Implement a Half Adder (HA) using a Dataflow description.
![Screenshot from 2024-02-11 19-32-58](https://github.com/IoannouKon/Digital_VLSI_ntua/assets/132226067/0563298d-4dbd-42f7-b2cf-3d3a69382dea)

2) Implement a Full Adder (FA) using a Structural description, based on the structural unit of Question 1.
![Screenshot from 2024-02-11 19-33-29](https://github.com/IoannouKon/Digital_VLSI_ntua/assets/132226067/60f0dc92-2946-462d-a1d3-b91582bf82ba)

3) Implement a 4-bit Parallel Adder (4-bit PA) using a Structural description, based on the structural unit of Question 2.
![Screenshot from 2024-02-11 19-34-47](https://github.com/IoannouKon/Digital_VLSI_ntua/assets/132226067/1c30b92d-1760-4c65-8c78-ec6267e05068)

4) Implement a BCD Full Adder (BCD FA) using a Structural description. Utilize the structural unit implemented in Question 3, any structural unit from the previous questions, and any additional logic you consider necessary.
![Screenshot from 2024-02-11 19-35-42](https://github.com/IoannouKon/Digital_VLSI_ntua/assets/132226067/94d43fa5-39e2-421d-97bc-9c7627b20a27)

5) Implement a 4-digit Parallel BCD Adder (4-BCD PA) using a Structural description, based on the structural unit of Question 4.
![Screenshot from 2024-02-11 19-36-20](https://github.com/IoannouKon/Digital_VLSI_ntua/assets/132226067/af23ff82-83f0-4ec5-81e9-ca380a9e7d6b)

### [Exercise 3](./VLSI-3(Syncronus_FA_and_4_bit_multipliers))

The purpose of the laboratory exercise is to familiarize students with the technique of Pipelining. Specifically, the design of modern computational circuits will be conducted using the pipeline technique. The goal is to illustrate how different subsystems of a circuit can process different subsets of data in parallel.

1) **Implement a modern Full Adder (FA) with a Behavioral description.**
   ![Full Adder](https://github.com/IoannouKon/Digital_VLSI_ntua/assets/132226067/3496d037-4f20-40fb-a0a2-43b15c774602)

2) **Implement a modern 4-bit carry lookahead adder using the Pipeline technique.** The circuit should be fed with a different pair of inputs at each clock cycle and should give the correct result in each clock cycle after some initial latency T_latency. The implementation should be based on the structural unit of the Full Adder from Question 1).
   ![4-bit Carry Lookahead Adder](https://github.com/IoannouKon/Digital_VLSI_ntua/assets/132226067/45d42ae3-135d-44c3-be6d-8f7c1be85d1f)

3) **Implement a systolic (pipeline-like) multiplier for 4-bit carry-propagate using synchronous Full Adders.** The circuit should be fed with a different pair of inputs at each clock cycle and should give the correct result in each clock cycle after some initial latency T_latency.
   ![4-bit Systolic Multiplier](https://github.com/IoannouKon/Digital_VLSI_ntua/assets/132226067/a9d798f4-dcdd-49ea-8b5b-d6a189945267)
### [Exercise 4](./VlSI-4(FIR))

In this lab exercise, you will implement an 8-tap FIR filter. The proposed architecture, based on equation (1), is depicted in the diagram below, with a data width of N bits. The implementation will be for N=8 bits data width x.

![FIR Filter Architecture](https://github.com/IoannouKon/Digital_VLSI_ntua/assets/132226067/e5b2050b-11a3-4cb0-ac12-d5bea76e5b83)

**Attention:** When integrating all individual units to create the overall architecture of the filter, appropriate synchronization between them must be considered.

**Control Unit:** Manages the filter's operation based on valid_in and the completion status of the ongoing MAC computation. It determines valid_out & mac_init values. If an input arrives before the completion of the 8 required cycles, it waits until completion. If the next input is delayed, the filter enters a waiting state until the next valid_in=1 value (X) arrives.

**MAC Unit:** Calculates the filter's output (y) by multiplying each filter coefficient (ROM output) with the corresponding input signal (RAM output). It reinitializes the output when mac_init=1 and, for the next 7 cycles, adds the product of RAM and ROM outputs to the existing result. To avoid overflow, the output y is 19 bits.

**RAM Unit:** Stores the current input value (X) and the previous 7 values. Provides the corresponding ram_out output to the MAC unit based on the ram_address value. The read/write selection is made by the control unit, with write occurring when mac_init=1, indicating a new valid input value.

**ROM Unit:** Stores the 8 coefficients of the filter. Provides the corresponding rom_out output to the MAC unit based on the rom_address value. The read/write selection is made by the control unit.

This configuration ensures synchronization through D Flip-Flops for X and mac_init (1 clock cycle delay) and 2 D Flip-Flops for valid_out (2 clock cycle delays).

**WARNING:** Up until now, we have validated all our programs using Vivado 2018.2 with both implementation and testbenches. However, for the next two exercises, in addition to running our codes with testbenches (implementational and functional), we will generate bitstreams to ensure they run correctly, and we will execute them on the FPGA.

For the implementation of the control unit, it is crucial to examine the VHDL directly in Exercise 5. In Exercise 4, we encountered a small logical error that we couldn't detect through simulations in Vivado. We only identified it when we ran it on the FPGA in Exercise 5. 

We adjusted the Control Unit module to ensure that the Counter freezes when it receives valid_in and counts up to 8, disregarding intermediate valid_in signals. Before this modification, our filter produced accurate results only under ideal conditions, where valid_in and the counter started simultaneously. However, this scenario is feasible in the testbench but not in FPGA implementation due to the overhead cycles involved in communication with the processor.

### [Exercise 5](./VLSI-5(FIR_in_Zybo))
In the context of this laboratory exercise, you will implement an 8-tap FIR filter. A proposed architecture for this filter, according to equation (1), is shown in the following diagram, where the data width is N bits. In this exercise, the implementation should be for N=8 bits data width x.

In the context of this laboratory exercise, you are tasked with programming the ZYBO development board to implement a FIR filter. The input data will be sent from the embedded processor (ARM) to the FPGA for processing, and vice versa for the corresponding results. The communication between the processor and FPGA will be based on the AXI protocol. The implementation of the system is divided into the following steps:

1) Introduction of the ZYNQ Processing System (PS).
2) Introduction of the AXI4-Lite interface to the FPGA (PL) for ARM-FPGA communication.
3) Interconnection of the PS with PL.
4) Synthesis and implementation of the system and generation of the bitstream file.
5) Exporting the system description and creating the application.
6) Programming the ZYNQ SoC FPGA and executing the application.

<<<<<<< HEAD

=======
 ![Screenshot from 2024-02-11 21-05-59](https://github.com/IoannouKon/Digital_VLSI_ntua/assets/132226067/34fc2b02-3ad8-44e3-8a6a-3e5b679024ea)
Create FIR IP:
 Initially, after creating a new project, we go to **Tools -> Create and Package New IP** to create a new IP with the FIR filter. In the new window opened by Vivado to create a new IP, we start by adding the VHDL file for the FIR filter via **Add Sources -> Design Sources** (which we created in the previous exercise). 
 Then, we need to modify the code for AXI. Below, we present ONLY the parts of the code that we modified.

AXI-LITE configuration for FIR IP:
 At the point in the code where the hardware receives data from the software (i.e., when we write to the register - we chose to write to slv_reg0), we make the following changes:

- We remove the parts where we write to slv_reg1, which we use for reading, i.e., for sending data from hardware to software. We do this to avoid a multi_drive error.
- We need to add an 'else' statement to the condition `if (ready to read from software)` so that we can set `valid_in = 0`. This ensures that the FIR does not read the same input multiple times but receives and processes each input only once. Similarly, in the process where we send read data (i.e., where the hardware sends data to the software), we follow the logic below:

When the software (master) sends valid data to the hardware (slave), the FIR produces output data with `valid_out = 1`, and the hardware stores it in slv_reg1. Then, until the master (software) sends `Read_ready`, indicating it's ready to receive data, we maintain the valid output value of the FIR filter in slv_reg1. Finally, when the signal comes that the master is ready to read, the slave (hardware) sends the data from slv_reg1 via axi_rdata to the master (software) and clears the bit representing valid_out to avoid storing the same value again. Essentially, the slave waits for the master to send data with `valid_in = 1` so that the FIR can produce output data with `valid_out = 1`.

Once we have saved our changes, the new IP for the FIR filter is ready. We then return to our initial project and via `setting -> IP -> repository`, we add the path we created for the FIR_IP so that we can add it to the design.

We add the Zynq and the FIR_IP to the design, and the connections are made automatically, resulting in the final design as shown below.

![Screenshot from 2024-02-11 21-12-46](https://github.com/IoannouKon/Digital_VLSI_ntua/assets/132226067/9e69550a-9235-4150-a99c-6f7e8db25491)

Next, we perform the HDL wrapper for our design, followed by RTL analysis and running the implementation process to ensure that there are no errors or significant warnings. Finally, we generate the bitstream by navigating to `File -> Export -> Export Hardware`, which automatically opens the SDK.

ARM code:
After retrieving the MY_IP_BASEADDR from the xparameters.h file for our specific application and defining our variables, we prompt the user to enter values for rst, valid_in, and data_in. Then, we shift these values to place them correctly and concatenate them into the 32-bit variable A. Using the Xil_out32 command, we send the data to the slave (hardware), adding 0 to the address because we are writing to slv_reg0.

Next, we read the filter's output value from slv_reg1, whose address corresponds to MY_IP_BASEADDR + 4. If we receive valid_in = 0 or reset = 1, we use the xil_in32 command to read slv_reg1 and isolate valid_out. We expect valid_out to be zero in this if condition.

If we receive a valid input value valid_in = 1 (and obviously, the reset is not active), then within an internal while{} loop, we continuously read slv_reg1 until the slave (FIR_IP) provides us with a valid output value, meaning valid_out = 1. Finally, we isolate the data_out using a simple mask and print it so that the user can see it via serial communication in the SDK terminal. The program then continues and prompts the user for new input values.

It's worth noting that we use the xil_printf command instead of printf because it imposes less overhead on the Zynq.

###  [Exercise 6](./VLSI-6(Debayer_Filter))
coming soon
