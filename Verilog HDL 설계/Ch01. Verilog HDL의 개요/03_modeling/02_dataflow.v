// ============================================================================
// MODELING STYLE 2: DATAFLOW MODELING
//
// assign creates a continuous assignment to a net (typically a wire).
// The Boolean expression is re-evaluated as relevant inputs change.
// It describes the same multiplexer as the gate-level example,
// but uses an expression instead of explicit gate instances.
// This style is concise for small and medium combinational functions.
// ============================================================================

`timescale 1ns/1ps

module dataflow_model (
    input wire a,
    input wire b,
    input wire c,
    output wire y
);
    // Same gate function written as one continuous assignment.
    assign y = (a & b) | (~a & c);
endmodule
