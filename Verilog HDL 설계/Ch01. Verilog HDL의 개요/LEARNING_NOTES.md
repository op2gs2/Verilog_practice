# Learning Notes - Reading and Understanding Verilog HDL

## Purpose and scope

These examples are designed for **careful code reading**, not for automated execution.
All explanations, source-code comments, and output messages are in English.
The source files use Verilog HDL syntax (Verilog-2001/2005), not SystemVerilog.
Testbench modules are included because understanding verification code is part of
understanding HDL design; no execution scripts are included.

## 1. HDL-based digital SoC design flow

| Stage | Main objective | Concepts illustrated by these files |
|---|---|---|
| 1. Specification | Define interfaces, behavior, clock/reset assumptions, throughput, latency, and PPA targets. | Define the command-filter inputs, outputs, and blocked opcode. |
| 2. Architecture and microarchitecture | Split the system into modules, datapaths, control logic, state machines, and registers. | Examine module hierarchy, state storage, and input sampling. |
| 3. RTL design | Express cycle-level hardware behavior in an HDL. | Read `module`, `assign`, and `always` statements. |
| 4. Functional verification | Check whether the implementation meets its intended behavior. | Compare DUT outputs with expected values in a testbench. |
| 5. Logic synthesis | Convert synthesizable RTL into a network of technology-mapped gates and storage elements. | Distinguish hardware descriptions from simulation-only constructs. |
| 6. Physical implementation | For FPGA, map, place, route, and generate a bitstream; for ASIC, perform physical design and sign-off. | Recognize that RTL alone is not a finished device. |
| 7. Validation and integration | Check the implemented system and integrate hardware with software or external interfaces. | Understand why timing, power, and system-level testing remain necessary. |

These stages form an iterative process. A failed functional check can require an
RTL change, while an unmet timing, power, or area target can require changes to
the microarchitecture. RTL describes hardware behavior; a testbench describes
an environment used to check that behavior.

## 2. Lexical tokens and writing rules

### Whitespace and comments

- Spaces, tabs, and newlines usually separate tokens; they do not normally
  affect the meaning of an expression.
- `assign y=a&b;` and `assign y = a & b;` have the same meaning.
- `//` starts a comment that ends at the next newline.
- `/* ... */` encloses a block comment. Block comments cannot be nested.
- Identifiers and keywords are case-sensitive. `Data`, `data`, and `DATA`
  refer to different names.

### Numeric literals

The usual sized-literal form is `<width>'[s]<base><digits>`:

| Literal | Meaning |
|---|---|
| `4'b1010` | Four-bit binary `1010` (decimal 10). |
| `8'o17` | Eight-bit octal `17` (decimal 15). |
| `8'd15` | Eight-bit decimal 15. |
| `8'hAF` | Eight-bit hexadecimal `AF` (decimal 175). |
| `8'sd5` | Signed eight-bit decimal 5. |
| `-8'sd5` | Negative five, using a unary minus operator. |
| `8'd300` | The declared width is eight bits; the value is truncated to 44. |
| `8'b10x1_zz00` | A four-state value containing unknown and high-impedance bits. |

The underscore is a readable digit separator. Verilog supports `0`, `1`,
`x` (unknown), and `z` (high impedance). The logical equality operator `==`
may return `x` when an unknown bit prevents a definite result. The case
equality operator `===` compares all four states and returns a definite
true/false result. Explicitly sizing constants helps prevent accidental
truncation and signedness errors.

### Strings, identifiers, and keywords

- Strings use double quotes, as in `"Hello, Verilog!"`.
- A Verilog string literal is represented as a sequence of eight-bit
  character codes and may be stored in a sufficiently wide packed vector.
- Ordinary identifiers begin with a letter or underscore. Subsequent
  characters may include digits, underscores, and dollar signs.
- Reserved words such as `module`, `wire`, `reg`, `always`, `assign`,
  `input`, and `output` cannot be ordinary user identifiers.
- An escaped identifier starts with a backslash and ends at whitespace.
  For example, `\data-out ` is an escaped identifier; the trailing space
  terminates its name.

### System tasks and system functions

- A **system task** performs an operation. Examples: `$display`, `$write`,
  `$monitor`, `$strobe`, and `$finish`.
- A **system function** returns a value. Examples: `$time`, `$signed`,
  and `$unsigned`.
- Such constructs are useful for simulation and inspection. Do not assume
  that simulation output or waveform-generation calls synthesize into hardware.

### Compiler directives

Compiler directives begin with a backtick, not an apostrophe:

| Directive | Purpose |
|---|---|
| `` `timescale`` | Specify a simulation time unit and precision. |
| `` `include`` | Insert the contents of another source file. |
| `` `define`` / `` `undef`` | Define or remove a textual macro. |
| `` `ifdef`` / `` `ifndef`` | Conditionally include source text. |
| `` `else`` / `` `elsif`` / `` `endif`` | Form conditional preprocessing branches. |
| `` `default_nettype none`` | Prevent accidental creation of implicit nets. |

A `parameter` is part of a module's elaborated configuration, whereas a
`` `define`` macro performs textual substitution during preprocessing.
These are different mechanisms. The example header `demo_macros.vh` explains
macro guards and parenthesized macro arguments.

### Attributes

The syntax `(* attribute_name = constant_value *)` attaches metadata to
supported Verilog constructs. Synthesis tools may recognize hints such as
`keep` or `dont_touch`, but the meaning and support of a particular
attribute depend on the tool. An attribute is not a Boolean operator and
should not be treated as a substitute for correct RTL behavior.

## 3. Modules and modeling methods

### Module interfaces and signal types

- `module` and `endmodule` delimit a hardware design block.
- `input`, `output`, and `inout` describe interface directions.
- `wire` is a net type, typically driven by continuous assignments,
  primitive gates, or module outputs.
- `reg` is a variable type that may be assigned from a procedural block.
  Declaring a signal as `reg` does **not** automatically create a flip-flop.
- A `parameter` allows an instance to use a configurable constant, such as
  the width of a counter.

### Four useful modeling approaches

| Approach | Typical Verilog construct | What it emphasizes |
|---|---|---|
| Gate-level | `and`, `or`, `not` primitives | Connections among individual logic gates. |
| Dataflow | `assign y = (a & b) | (~a & c);` | Continuous Boolean relationships. |
| Behavioral combinational | `always @(*)` with complete `if/else` assignments | Conditions that determine combinational outputs. |
| Structural | Instances of previously defined modules | Composition of smaller modules into larger designs. |

The first three approaches are demonstrated using a 2-to-1 multiplexer.
Read the implementations side by side and check that they implement the
same truth table. Structural modeling is demonstrated by building a full
adder from two half-adder instances.

### Sequential RTL

A clocked `always @(posedge clk or negedge rst_n)` block represents logic
that responds to a rising clock edge or an active-low asynchronous reset.
Nonblocking assignments (`<=`) are commonly used for clocked state updates.
In the counter example, `enable` controls whether the registered count
increments or holds its previous value.

An `always @(*)` block for combinational logic must assign each output for
every relevant control path. Missing assignments can imply a latch.

### Finite-state machines (FSMs)

An FSM has a current state, next-state logic, and behavior determined by
state and inputs. The `two_bad_event_detector` example has two encoded
states and detects the second consecutive bad **valid** event. Invalid
events preserve the current state. Study why a registered `alert` uses
the previous value of `state` on the active clock edge.

## 4. Testbench modules

A testbench drives a **Device Under Test (DUT)** with stimulus and checks
actual results against expected results. A testbench is generally not
intended for logic synthesis.

- `initial` runs a procedural sequence at the beginning of simulation.
- `#1` delays a simulation process by one simulation time unit; it does
  not prescribe a physical propagation delay for a synthesized circuit.
- `@(posedge clk)` waits for a rising clock edge.
- `!==` performs a four-state-aware inequality check.
- `task ... endtask` packages a reusable stimulus/check sequence.

The included testbenches demonstrate comparisons for three MUX modeling
styles, adder arithmetic, a parameterized counter, an FSM, and the
command-filter mini-project. Testbench files remain for conceptual study;
they are not accompanied by scripts or build-system files.

## 5. Small command-filter example

`05_mini_project/01_command_filter.v` describes a simple registered
command check. It samples `valid_in` and `opcode_in` on a clock edge.
A matching blocked opcode raises `alert_out`; other valid commands raise
`pass_out`. An asynchronous active-low reset clears the outputs.

This example illustrates hardware control logic and a basic decision
pipeline. It does **not** implement a complete protocol parser, packet
firewall, or production intrusion detection/prevention system.

## 6. Questions for code-reading practice

1. Why does a half adder use XOR for `sum` and AND for `carry`?
2. Why can three different MUX descriptions implement the same truth table?
3. When does a procedurally assigned `output reg` still describe
   combinational rather than sequential logic?
4. What happens to `count` while a counter's `enable` is low?
5. How do `state` and `next_state` differ, and why does that matter to an
   FSM's registered output?
6. Why is a simulation delay such as `#1` normally absent from
   synthesizable RTL?
7. Why is the blocked opcode a `parameter` in the command-filter module?
8. Which statements in the testbench describe simulation operations,
   rather than gates or registers intended for a chip?
