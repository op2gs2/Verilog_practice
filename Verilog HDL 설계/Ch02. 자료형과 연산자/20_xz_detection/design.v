// ============================================================================
// EXAMPLE 20 - Detecting unknown/high-impedance bits in classic Verilog
// File: design.v (RTL description)
// Language: Verilog HDL (IEEE 1364-2001/2005); no SystemVerilog syntax.
//
// Key concepts:
//   1. Reduction XOR (^data) is x if any bit of data is x or z.
//   2. Case equality ((^data) === 1'bx) maps that condition to 1 or 0.
//   3. Use this for simulation assertions and debugging, not synthesizable hardware.
//   4. A real gate cannot physically distinguish a symbolic simulation x.
//
// These snippets are reading-oriented examples, not production-ready IP.
// A matching design.v/testbench.v pair is included to illustrate behavior.
// ============================================================================
// This module demonstrates a verification-only expression.
module xz_detector (
    input  wire [7:0] data,
    output wire has_x_or_z
);
    // A definite 1 means at least one bit of data is x or z.
    assign has_x_or_z = ((^data) === 1'bx);
endmodule
