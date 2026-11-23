# Gate Primitives, Modeling Styles, Bus Resolution, and Timing

This self-contained collection is intended to be placed inside the existing
`Verilog HDL 설계` directory of `op2gs2/Verilog_practice`.

## Scope

- Verilog HDL (IEEE 1364 / Verilog-2001) only: **no SystemVerilog**.
- Heavily annotated, independent `.v` learning examples.
- Each `.v` file contains a self-contained design example and a small
  simulation-oriented testbench where useful.
- No execution shell scripts, batch files, Makefiles, or generated waveforms.
- All code comments and documentation are in English.
- Many files are **simulation demonstrations**, not synthesizable RTL.

## Reading order

| File | Focus |
| --- | --- |
| `01_Primitives/01_basic_logic_gates.v` | AND/NAND/OR/NOR/XOR/XNOR/BUF/NOT and four-state logic |
| `01_Primitives/02_modeling_styles.v` | Structural, dataflow, and procedural descriptions in one module |
| `01_Primitives/03_module_vs_function.v` | Module instances vs. reusable combinational functions |
| `01_Primitives/04_gate_instance_arrays.v` | Arrays of gate instances, vector mapping, scalar broadcast |
| `01_Primitives/05_buf_not_multioutput.v` | Multiple outputs vs. multiple primitive instances |
| `02_Tristate_and_Bus/06_tristate_gates.v` | BUFIF0/BUFIF1/NOTIF0/NOTIF1, Z state |
| `02_Tristate_and_Bus/07_shared_bus_resolution.v` | Shared drivers, contention, resolved values |
| `02_Tristate_and_Bus/08_switch_primitives.v` | NMOS/PMOS/TRANIF1 modeling concepts |
| `02_Tristate_and_Bus/09_can_wired_and_model.v` | CAN dominant/recessive logic abstraction |
| `03_Delays/10_gate_delay.v` | Gate propagation delay |
| `03_Delays/11_net_delay.v` | Explicit net-declaration delay |
| `03_Delays/12_continuous_assignment_delay.v` | Continuous-assignment delay vs. net delay |
| `03_Delays/13_rise_fall_turnoff.v` | Three transition-oriented delay values |
| `03_Delays/14_timescale_precision.v` | Time unit vs. time precision |
| `03_Delays/15_inertial_pulse_rejection.v` | Short pulse cancellation at 5 ns delay |
| `04_Synthesis_Concepts/16_fanout_distribution.v` | One result with multiple consumers |
| `04_Synthesis_Concepts/17_logic_equivalence.v` | Same function, different logic structures |
| `04_Synthesis_Concepts/18_resource_sharing.v` | Duplicated operators vs. selected inputs |
| `04_Synthesis_Concepts/19_glitch_hazard_preview.v` | Optional preview of a static-1 hazard |

## How to inspect

Open any file in a Verilog-2001-capable simulator/editor. Each file supplies a
suggested testbench top module named `tb_*`. Study one file at a time. Because
some examples intentionally use delays, unknown states, or multiple drivers,
**do not interpret a successful simulation as proof of synthesizability**.

A local Verilog simulator was not available in the file-generation environment;
the archive was checked for structural consistency and documentation encoding,
not compiled against a simulator. Verify behavior in your own simulator.

## Crucial distinctions

1. `assign` is a **continuous assignment** (dataflow), not a procedural copy.
2. `module` instantiation creates hardware instances; `function` calls reuse
   calculation descriptions. Neither guarantees a particular standard-cell count.
3. `buf` and `not` are logical primitives. Their existence in RTL does **not**
   guarantee retention of corresponding physical buffer/inverter cells.
4. A driver at `Z` is disconnected from the net. The **resolved net** may still
   be 0, 1, or X because of other drivers.
5. Verilog `#` delays model **simulation time**; they are not ASIC wire-delay
   constraints or reliable physical glitch filters.
6. Physical interconnect delay is analyzed using technology/library timing,
   parasitic extraction, timing constraints, and static timing analysis.
7. The CAN example models only dominant/recessive wired-AND logic. A real CAN
   transceiver uses a differential physical layer and a complete controller
   implements synchronization, bit stuffing, framing, arbitration, and errors.
8. The optional hazard example is introductory, not a full timing signoff test.

## Not included

- SystemVerilog (`logic`, `always_comb`, assertions, or classes)
- Automation/execution scripts
- PDK-specific cells or constraints
- Complete CAN controller, synthesizable on-chip tri-state bus, or full STA flow

## Repository placement

The ZIP stores its contents under:
`Verilog HDL 설계/03_Gate_Primitives_and_Timing/`.
Extract at the root of `Verilog_practice` to add this learning unit alongside
existing content without replacing the root README or other chapters.
