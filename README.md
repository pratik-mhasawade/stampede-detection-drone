Designed a fully pipelined 4×4 matrix multiplication accelerator on Artix-7 FPGA using parallel MAC architecture with balanced adder trees and DSP-optimized multipliers achieving 3-cycle compute latency at 75 MHz.

About mac4_element.v
  Fully synchronous reset (FPGA safe)
  Explicit signed arithmetic
  Correct bit growth handling
  Clean 3-stage pipeline
  Valid signal aligned with data
  DSP inference preserved
  No latches
  No combinational feedback

Bit width Verification (Worst-case)
  127 × 127 = 16129  (14 bits)
  4 × 16129 = 64516  (17 bits needed)
🚀 4×4 Pipelined Matrix Multiplication Accelerator
Verilog RTL | Artix-7 (Basys-3) | DSP-Optimized Compute Engine
📌 Project Overview

This project implements a high-performance 4×4 matrix multiplication accelerator using a fully pipelined parallel MAC architecture in Verilog.

The design targets the Artix-7 XC7A35T FPGA on the Basys-3 development board and demonstrates:

Balanced adder-tree pipelining

DSP48-based multiplier inference

Timing-aware RTL architecture

Deterministic latency & throughput

Matrix multiplication is the fundamental compute primitive behind modern AI workloads such as CNNs and Transformers.

🧠 Architecture Overview

The accelerator computes:

𝐶
=
𝐴
×
𝐵
C=A×B

Where A and B are 4×4 signed matrices.

Each output element:

𝐶
[
𝑖
]
[
𝑗
]
=
∑
𝑘
=
0
3
𝐴
[
𝑖
]
[
𝑘
]
×
𝐵
[
𝑘
]
[
𝑗
]
C[i][j]=
k=0
∑
3
	​

A[i][k]×B[k][j]
Architecture Highlights

16 parallel MAC compute elements

3-stage pipelined datapath per element

Balanced adder-tree to reduce critical path

Signed fixed-point arithmetic

1 result per clock (after pipeline fill)

🏗️ Micro-Architecture

Each MAC element consists of:

Stage 1 – Parallel Multiplication

4 DSP48-based multipliers

Registered outputs

Stage 2 – First-Level Adder Tree

Two parallel adders

Bit-growth handling

Stage 3 – Final Accumulation

Final addition

Output register

Valid signal alignment

Latency & Throughput

Latency: 3 clock cycles

Throughput: 1 result per clock (pipelined steady-state)

⚙️ Target Platform

FPGA: Xilinx Artix-7 XC7A35T

Board: Basys-3

Toolchain: Vivado

Language: Verilog

📂 Repository Structure
rtl/
  ├── mac4_element.v
  ├── matrix4x4_core.v
  ├── control_fsm.v
  └── top.v

tb/
  └── tb_matrix4x4.v

constraints/
  └── basys3.xdc

🧪 Verification Strategy

Self-checking testbench

Randomized matrix inputs

Corner-case testing (max/min signed values)

Latency verification

Waveform validation using Vivado Simulator

📊 Implementation Results (To Fill After Finalization)

After synthesis & implementation, include this section.

📈 Post-Synthesis Metrics
Metric	Value
Fmax Achieved	XX MHz
DSP Utilization	XX / 90
LUT Utilization	XX / 33K
FF Utilization	XX
BRAM Usage	XX
Power Estimate	XX mW
⚡ Performance Analysis

Latency: 3 cycles

Throughput: 1 result per clock

Speedup vs sequential implementation: XX×

Resource vs performance trade-off discussion

🔍 Timing Analysis

Worst Negative Slack (WNS): XX ns

Critical Path Location: (e.g., final adder stage)

Pipeline balancing effectiveness

🏆 Design Decisions & Trade-offs

Balanced adder tree vs linear accumulation

DSP inference vs LUT multiplication

Register placement for timing closure

Fixed-point arithmetic selection

Clock enable integration for power optimization

🔮 Scalability

The architecture can be extended to:

8×8 matrix accelerator

Time-multiplexed MAC units

AXI-lite interface integration

RISC-V coprocessor attachment

Systolic array upgrade

💼 Resume Impact

This project demonstrates:

RTL datapath design

Pipelining and timing optimization

DSP-aware FPGA design

Hardware accelerator architecture

Control & valid signal alignment

Performance-driven digital design

📚 Future Improvements

Add AXI interface

Add DMA support

Implement fixed-point Q-format scaling

Compare against systolic array architecture

Port to ASIC synthesis flow

👨‍💻 Author

Pratik Uttam Mhasawade
B.Tech Electronics & Telecommunication (VLSI Honors)
Focus: Digital IC Design | AI Hardware | FPGA SoC Architectures
