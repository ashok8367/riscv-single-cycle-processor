# RISC-V RV32I Single Cycle Processor (Verilog)

## Overview

This project implements a **32-bit RISC-V Single Cycle Processor** based on the **RV32I base instruction set architecture**.
The processor is designed using **Verilog HDL** and verified using **assembly firmware programs** executed through simulation.

In a **single-cycle architecture**, each instruction completes execution within a single clock cycle, performing instruction fetch, decode, execute, memory access, and write-back operations in one cycle.

---

## Architecture

The processor datapath consists of the following major components:

* Program Counter (PC)
* Instruction Memory
* Register File (32 registers)
* Arithmetic Logic Unit (ALU)
* Control Unit
* ALU Control
* Immediate Generator
* Branch Address Adder
* Data Memory
* Multiplexers

---

## Supported Instruction Formats

The processor supports **all major instruction formats of the RV32I ISA**, including:

* **R-Type**
* **I-Type**
* **S-Type**
* **B-Type**
* **U-Type**
* **J-Type**

These instruction formats enable arithmetic operations, memory access, branching, and jump instructions.

---

## Project Structure

```text
riscv-single-cycle-processor
│
├── rtl
│   ├── Top_Module.v
│   ├── alu_unit.v
│   ├── alu_control.v
│   ├── control_unit.v
│   ├── reg_file.v
│   ├── program_counter.v
│   ├── instruction_mem.v
│   ├── data_memory.v
│   ├── immediate_generator.v
│   ├── branch_adder.v
│   ├── multiplexer.v
│   └── pcplus4.v
│
├── tb
│   └── Top_Module_tb.v
│
├── firmware
│   ├── code.S
│   ├── code.hex
│   └── build scripts
│
└── README.md
```

---

## Firmware Verification

Assembly programs are written in **RISC-V assembly** and converted into machine code (`code.hex`).
The generated firmware is loaded into instruction memory using:

```
$readmemh("code.hex", memory);
```

This allows the processor to execute assembly programs during simulation.

---

## Simulation

The design is verified using **Icarus Verilog**, and waveforms are analyzed using **GTKWave**.

### Compile

```
iverilog -s Top_Module_tb -o cpu_sim.vvp rtl/*.v tb/Top_Module_tb.v
```

### Run Simulation

```
vvp cpu_sim.vvp
```

### View Waveforms

```
gtkwave cpu.vcd
```

---

## Tools Used

* Verilog HDL
* Icarus Verilog
* GTKWave
* RISC-V GNU Toolchain

---

## Author

**Venna Ashok**  
Electronics and Communication Engineering Graduate  
RGUKT Nuzvid  
