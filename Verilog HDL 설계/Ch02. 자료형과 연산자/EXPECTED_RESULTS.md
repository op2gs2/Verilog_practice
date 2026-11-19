# Expected Results and Concept Notes

This reference describes the intended behavior of each Verilog HDL example. The examples are primarily **reading material**; no execution script is included. Results involving `x` and `z` assume a four-state simulator such as Icarus Verilog.

## 01. Four-state equality: `==` versus `===`

Directory: `01_four_state_x_comparison`

- Logical equality (`==`) may produce `x` when an operand is unknown.
- Case equality (`===`) treats `x` and `z` as exact symbols and always returns `0` or `1`.
- Expected comparisons: when `a=x`, `(a == x)=x` and `(a === x)=1`; when `a=0`, `a=1`, or `a=z`, `(a === x)=0`.
- **Important:** An `x` comparison does not represent a physical unknown-state detector.

## 02. `wire`, `tri`, and high-impedance shared buses

Directory: `02_wire_tri_shared_bus`

- `z` means that a driver is not actively forcing the net to `0` or `1`.
- `wire` and `tri` behave identically for ordinary net resolution.
- Expected shared-bus sequence: **`z` -> `1` -> `0` -> `x`**.
- The final `x` illustrates conflicting equal-strength drivers (`1` versus `0`).

## 03. Additional net types

Directory: `03_other_net_types`

- `wand` resolves multiple drivers using wired-AND; `wor` uses wired-OR.
- `tri0` and `tri1` provide default weak pull values when no stronger driver is present.
- `supply0` and `supply1` represent constant supply-valued nets.
- Expected values: **`wand=0`, `wor=1`, `tri0=0`, `tri1=1`, `supply0=0`, `supply1=1`**.

## 04. Scalars, vectors, and selects

Directory: `04_scalar_and_vector`

- `wire a` declares a one-bit scalar; `wire [7:0] data` declares an eight-bit vector.
- `data[3]` selects one bit; `data[7:4]` selects four bits.
- For input `10101100`, expected values: **bit 7 = `1`, bit 3 = `1`, upper = `1010`, lower = `1100`**.

## 05. Memory arrays: `memory[2][3]`

Directory: `05_memory_array_index`

- The first index (`[2]`) chooses an array element; the second (`[3]`) chooses a bit within that element.
- Each `memory` entry contains eight bits.
- Expected values: **`memory[2]=8'b00001111` and `memory[2][3]=1'b1`**.

## 06. Numeric literals, width, and sign extension

Directory: `06_constant_size_sign`

- A smaller unsigned value is zero-extended when assigned to a wider unsigned destination.
- Assigning a wider value to a narrower destination discards high-order bits.
- Signed expansion replicates the sign bit when the expression is signed.
- Expected outputs: **`four_bit=1010`, `eight_bit=00001010`, `truncated=0000`, `sign_extended=11111010` (signed -6)**.

## 07. `parameter` and `localparam`

Directory: `07_parameter_localparam`

- A module instance can override a `parameter`, such as `WIDTH`.
- A `localparam` is an internal constant and cannot be overridden by an instance.
- Expected 8-bit instance: **data = `aa`, all-ones constant = `ff`**.
- Expected 16-bit instance: **data = `1234`, all-ones constant = `ffff`**.

## 08. A constant table built from a packed parameter vector

Directory: `08_parameter_vector_table`

- Classic Verilog can concatenate several constants into one wide parameter vector.
- Part-selects then extract individual fixed-width entries.
- Expected values: **item 0 = `8'h11`, item 2 = `8'h33`, item 2 bit 0 = `1`**.
- This is not an unpacked parameter array.

## 09. Combinational logic using `wire` versus `reg`

Directory: `09_wire_vs_reg_comb`

- `assign` drives a net continuously; `always @(*)` allows procedural assignments to a variable.
- Both examples describe an AND function.
- Expected outputs: **`00 -> 0/0`, `01 -> 0/0`, `10 -> 0/0`, `11 -> 1/1`**.
- The `reg` form does not automatically imply a flip-flop.

## 10. Inadvertent latch inference

Directory: `10_latch_inference`

- If a procedural combinational block leaves a signal unassigned on some path, it may infer a latch.
- Providing a default assignment makes a complete combinational implementation possible.
- Expected illustration: **when enabled, both outputs can become `1`; when disabled, the latch retains `1` while the safe combinational output becomes `0`**.

## 11. Flip-flop with a clock and asynchronous reset

Directory: `11_flipflop_clock_reset`

- `always @(posedge clk or negedge rst_n)` models a positive-edge-triggered flip-flop with active-low asynchronous reset.
- `<=` is a nonblocking assignment, conventionally used in clocked RTL.
- Expected sequence: **reset -> `0`; before next rising edge -> `0`; after rising edge with input `1` -> `1`; while clock is low -> still `1`; after next rising edge with input `0` -> `0`**.

## 12. Simulation delays and timescale

Directory: `12_delay_timescale`

- With `` `timescale 1ns/1ps ``, a `#10` delay advances the current procedural thread by 10 ns.
- Delays accumulate within the same sequential block.
- Expected displayed observations: **at 1 ns, `y=0`; at 12 ns, `y=1`; at 18 ns, `y=0`**.

## 13. Arithmetic and relational operators

Directory: `13_arithmetic_relational`

- This example demonstrates addition, subtraction, multiplication, integer division, remainder, and comparison.
- Addition uses an explicitly widened result to avoid losing an eight-bit carry.
- Expected values for `a=10`, `b=3`: **sum `13`, difference `7`, product `30`, quotient `3`, remainder `1`, `(a>b)=1`, `(a==b)=0`**.

## 14. Bitwise versus logical operations

Directory: `14_bitwise_vs_logical`

- Bitwise `&` applies to corresponding bits of two vectors.
- Logical `&&` interprets each entire operand as true or false and produces one result bit.
- For `a=0101`, `b=0011`, expected values: **`a & b=0001` and `a && b=1`**.
- Bitwise `~` and logical `!` are also different operators.

## 15. Reduction operators

Directory: `15_reduction_operators`

- Reduction operators combine a vector's bits into one result bit.
- `&data` requires all bits to be one, `|data` checks whether any bit is one, and `^data` computes XOR parity.
- For `data=1011`, expected values: **`&data=0`, `|data=1`, `^data=1`, `~&data=1`, `~|data=0`**.

## 16. Shifts and signed operands

Directory: `16_shift_and_signed`

- Logical right shift (`>>`) inserts zeros; arithmetic right shift (`>>>`) extends the sign when the left operand is signed.
- Expected illustrations: **`00001111 << 2 = 00111100`**, **`11111000 >> 2 = 00111110`**, and **`11111000 >>> 2 = 11111110` (signed -2)**.

## 17. Concatenation and repetition

Directory: `17_concat_and_repeat`

- `{a,b}` joins two bit vectors in order.
- `{N{a}}` repeats a bit pattern a fixed number of times.
- For `a=0101`, `b=0011`, expected values: **concatenation `01010011`, repetition `01010101`, and an eight-bit zero vector `00000000`**.

## 18. Conditional (`?:`) operator and multiplexers

Directory: `18_ternary_mux`

- `select ? a : b` selects `a` when `select=1`, otherwise `b`.
- This form naturally models a multiplexer (MUX).
- Expected values: **`select=0` -> `8'h55`; `select=1` -> `8'haa`**.

## 19. Explicit truncation and overflow indication

Directory: `19_width_truncation_guard`

- Extracting `[7:0]` from a 16-bit length preserves only the low byte.
- Reduction OR across bits `[15:8]` indicates whether nonzero high bits would be discarded.
- Expected examples: **length `100` -> low byte `100`, overflow `0`; length `1024` -> low byte `0`, overflow `1`**.

## 20. Detecting `x` or `z` in classic Verilog

Directory: `20_xz_detection`

- Reduction XOR (`^data`) becomes `x` if an input bit contains `x` or `z`.
- Comparing that result with `1'bx` using `===` produces a known `1` or `0`.
- Expected results: **known data -> `0`; data containing `x` -> `1`; data containing `z` -> `1`**.
- This is a simulation/verification technique, not a synthesis-ready unknown-state sensor.

## 21. Deliberate bit-width mismatch for lint review

Directory: `21_lint_width_mismatch`

- The example deliberately assigns a 16-bit signal to an 8-bit destination without an explicit slice.
- A lint tool may flag this as potential truncation; warning behavior varies by tool and configuration.
- Expected values: **`wide=16'h1234`, implicit low byte `8'h34`, explicit low byte `8'h34`, high-bits flag `1`**.
- **Do not copy the unsafe implicit-width assignment into production RTL without reviewing the loss of information.**
