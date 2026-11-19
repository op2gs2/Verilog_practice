# Verilog HDL - Annotated Reading Examples

## Scope

This packet is for **reading and understanding Verilog HDL**, not for automated execution.
All `.v` files contain **Verilog-2001/2005 syntax only**. Source-code comments are **in English**.
No execution scripts, build automation, generated waveforms, or simulator project files are included.
The testbench modules remain because they demonstrate the distinction between synthesizable RTL and verification code.

## Contents

| Directory | Subjects |
|---|---|
| `00_design_flow/` | Specification, architecture, RTL, verification, synthesis, FPGA/ASIC physical implementation |
| `01_lexical/` | Whitespace, comments, number literals, strings, identifiers, keywords, system tasks/functions, directives, attributes |
| `02_modules/` | Module ports, half adder, full-adder hierarchy, parameterized counter |
| `03_modeling/` | Gate-level, dataflow, combinational behavioral, sequential RTL, two-state FSM |
| `04_testbench/` | Conceptual testbenches for MUX, adders, counter and FSM |
| `05_mini_project/` | Introductory command-filter RTL and corresponding testbench |
| `LEARNING_NOTES.md` | English reading notes and explanations |

## Suggested reading sequence

1. Read the comments in `00_design_flow/00_soc_design_flow.v` to understand the overall design process.
2. Study files in `01_lexical/` to understand each token and writing rule.
3. Read `02_modules/01_half_adder.v` and `02_modules/02_full_adder_structural.v` for module concepts.
4. Compare the three multiplexer implementations in `03_modeling/01_*.v` to `03_modeling/03_*.v`.
5. Study sequential elements and the FSM in `03_modeling/04_*.v` and `03_modeling/05_*.v`.
6. Examine `04_testbench/` to learn why testbenches differ from hardware design modules.
7. Finish with `05_mini_project/`, a small policy-checking example.

## Core distinctions

- `wire` is a net; `reg` is a variable assigned by procedural statements. A `reg` declaration alone does not imply a physical flip-flop.
- Continuous assignments (`assign`) and complete combinational `always @(*)` blocks describe combinational logic.
- A clocked `always @(posedge clk ...)` block with nonblocking `<=` assignments describes registered behavior.
- The delay operator `#` and simulation system tasks are useful in testbench explanations; they are generally not synthesizable RTL.
- The attribute syntax `(* ... *)` is standardized, but particular attribute meanings depend on the implementation tool.
- The command-filter example is **not** a production packet parser or actual security protection device.
