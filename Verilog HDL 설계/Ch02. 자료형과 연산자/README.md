# Verilog HDL Annotated Examples

This collection explains essential Verilog HDL concepts through short, heavily commented code examples. It is designed **for reading and understanding the code**, rather than as a required execution workflow.

## Scope and conventions

- **21 topics**, with one `design.v` and one `testbench.v` per topic: **42 Verilog source files**.
- **All source comments, explanations, and Markdown documentation are written in English.**
- Source code uses **classic Verilog HDL (IEEE 1364-2001/2005)** syntax. No SystemVerilog-only examples or `.sv` files are included.
- No execution, compilation, or lint scripts (`.sh`, `.ps1`, `.bat`, etc.) are included.
- Testbenches illustrate expected input transitions, timing, and observations; running them is optional.
- Selected examples are deliberately non-synthesizable or contain intentional design errors to illustrate simulation behavior and verification pitfalls. Read the explanatory comments before reusing them.

## Folder organization

```text
Verilog_HDL_Annotated_Examples_English_Only/
|-- README.md
|-- EXPECTED_RESULTS.md
|-- 01_four_state_x_comparison/
|   |-- design.v
|   `-- testbench.v
|-- 02_wire_tri_shared_bus/
|   |-- design.v
|   `-- testbench.v
|-- ... (21 topic directories in total)
`-- 21_lint_width_mismatch/
    |-- design.v
    `-- testbench.v
```

## Topic index

| No. | Folder | Main concepts |
|---:|---|---|
| 01 | `01_four_state_x_comparison` | Four-state logic (`0`, `1`, `x`, `z`); `==` versus `===` |
| 02 | `02_wire_tri_shared_bus` | `wire`, `tri`, high impedance (`z`), and bus contention |
| 03 | `03_other_net_types` | `wand`, `wor`, `tri0`, `tri1`, `supply0`, and `supply1` |
| 04 | `04_scalar_and_vector` | Scalars, vectors, bit selects, and part selects |
| 05 | `05_memory_array_index` | Unpacked memory arrays and `memory[2][3]` indexing |
| 06 | `06_constant_size_sign` | Numeric literals, widths, truncation, and sign extension |
| 07 | `07_parameter_localparam` | `parameter`, `localparam`, and module configuration |
| 08 | `08_parameter_vector_table` | Storing several constants in one packed parameter vector |
| 09 | `09_wire_vs_reg_comb` | `wire`/`assign` versus `reg`/`always @(*)` for combinational logic |
| 10 | `10_latch_inference` | Incomplete assignments and inferred latches |
| 11 | `11_flipflop_clock_reset` | Clocked logic, nonblocking assignments, and asynchronous reset |
| 12 | `12_delay_timescale` | `initial`, `#10`, and `` `timescale `` |
| 13 | `13_arithmetic_relational` | Arithmetic, relational, and equality operators |
| 14 | `14_bitwise_vs_logical` | Bitwise versus logical operators |
| 15 | `15_reduction_operators` | Reduction operators (`&`, `|`, `^`, `~&`, `~|`) |
| 16 | `16_shift_and_signed` | Logical and arithmetic shifts; signed operands |
| 17 | `17_concat_and_repeat` | Concatenation and repetition (`{}`, `{N{...}}`) |
| 18 | `18_ternary_mux` | Conditional operator (`?:`) and multiplexer behavior |
| 19 | `19_width_truncation_guard` | Intentional slicing and loss-of-information detection |
| 20 | `20_xz_detection` | Detecting `x` or `z` with reduction XOR and case equality |
| 21 | `21_lint_width_mismatch` | An intentionally mismatched width for lint review |

## Suggested reading method

1. Open the topic's `design.v` and read the **Key concepts** comments at the top.
2. Study each declaration, operator, assignment, and the corresponding explanatory comment.
3. Read `testbench.v` to understand how changes in inputs affect the output.
4. Consult `EXPECTED_RESULTS.md` for the expected behavior and important limitations.
5. Compare concepts across topics, especially `wire` versus `reg`, bitwise versus logical operators, and `==` versus `===`.

## Important technical notes

- A `reg` declaration **does not always infer a flip-flop**. The procedural logic determines whether a combinational circuit, latch, or flip-flop is inferred.
- `wire` and `tri` have the same resolution behavior. Both can carry `z`; `tri` merely emphasizes tri-state usage.
- `x` is an unknown simulation value, not a distinct physical voltage that a digital circuit can detect.
- `===` and reduction-based `x`/`z` detection are intended primarily for **simulation and verification**. Do not treat them as synthesizable sensors of unknown physical logic.
- A testbench's `initial`, delay controls (`#1`, `#10`), `$display`, and `$finish` explain simulation behavior; they are not general-purpose hardware delay implementations.
- Topic 21 deliberately contains an **unsafe implicit 16-bit-to-8-bit assignment**. It demonstrates a bug pattern, not a recommended coding style.
- Lint findings depend on tool settings, and simulator behavior for `x`/`z` depends on whether the simulator implements full four-state semantics.
