// ============================================================================
// MODELING STYLE 1: GATE-LEVEL MODELING
//
// Built-in primitives include not, and, or, xor, nand, nor, and buf.
// Primitive connections explicitly describe the Boolean gate network.
// For basic gate instances, the output port comes before input ports.
//
// This circuit implements a 2-to-1 multiplexer:
//   y = (a & b) | (~a & c)
// Select a=1 chooses b; select a=0 chooses c.
// Compare this implementation with the next two modeling styles.
// ============================================================================

`timescale 1ns/1ps

module gate_level_model (
    input wire a,
    input wire b,
    input wire c,
    output wire y
);
    // Internal wires connect the primitive gate outputs.
    wire not_a;
    wire term_b;
    wire term_c;

    // Invert the select signal.
    not u_not(not_a, a);
    // Propagate b only when a is asserted.
    and u_and0(term_b, a, b);
    // Propagate c only when a is deasserted.
    and u_and1(term_c, not_a, c);
    // Merge the selected data path.
    or  u_or(y, term_b, term_c);
endmodule
