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
In the context of this laboratory exercise, you will implement an 8-tap FIR filter. A proposed architecture for this filter, according to equation (1), is shown in the following diagram, where the data width is N bits. In this exercise, the implementation should be for N=8 bits data width x.
![Screenshot from 2024-02-11 20-28-55](https://github.com/IoannouKon/Digital_VLSI_ntua/assets/132226067/e5b2050b-11a3-4cb0-ac12-d5bea76e5b83)
Attention: When integrating all individual units to create the overall architecture of the filter, appropriate synchronization between them must be considered.

**Control Unit:** Manages the filter's operation based on valid_in and the completion status of the ongoing MAC computation. It determines valid_out & mac_init values. In case an input arrives before the completion of the 8 required cycles, it waits until completion. If the next input is delayed, the filter enters a waiting state until the next valid_in=1 value (X) arrives.

**MAC Unit:** Calculates the filter's output (y) by multiplying each filter coefficient (ROM output) with the corresponding input signal (RAM output). It reinitializes the output when mac_init=1 and, for the next 7 cycles, adds the product of RAM and ROM outputs to the existing result. To avoid overflow, the output y is 19 bits.

**RAM Unit:** Stores the current input value (X) and the previous 7 values. Provides the corresponding ram_out output to the MAC unit based on the ram_address value. The read/write selection is made by the control unit, with write occurring when mac_init=1, indicating a new valid input value.

**ROM Unit:** Stores the 8 coefficients of the filter. Provides the corresponding rom_out output to the MAC unit based on the rom_address value. The read/write selection is made by the control unit.

This configuration ensures synchronization through D Flip-Flops for X and mac_init (1 clock cycle delay) and 2 D Flip-Flops for valid_out (2 clock cycle delays).



