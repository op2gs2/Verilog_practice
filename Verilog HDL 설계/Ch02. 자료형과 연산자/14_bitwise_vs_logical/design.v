// ============================================================================
// EXAMPLE 14 - Bitwise versus logical operators
// File: design.v (RTL description)
// Language: Verilog HDL (IEEE 1364-2001/2005); no SystemVerilog syntax.
//
// Key concepts:
//   1. a & b computes AND independently at corresponding bit positions.
//   2. a && b evaluates each entire vector as a Boolean condition.
//   3. ~a inverts each bit; !a produces a single Boolean result.
//   4. These operators also have defined four-state X/Z propagation rules.
//
// These snippets are reading-oriented examples, not production-ready IP.
// A matching design.v/testbench.v pair is included to illustrate behavior.
// ============================================================================
module logic_ops_example (
    input  wire [3:0] a,b,
    output wire [3:0] bit_and,bit_or,bit_xor,bit_not,
    output wire logical_and,logical_or,logical_not
);
    // Apply AND to each matching pair of input bits.
    assign bit_and = a & b;
    // Apply OR to each matching pair of input bits.
    assign bit_or  = a | b;
    // Apply XOR to each matching pair of input bits.
    assign bit_xor = a ^ b;
    // Invert every bit of the a vector.
    assign bit_not = ~a;
    // Return one bit: true when neither operand is zero.
    assign logical_and = a && b;
    // Return one bit: true when either operand is nonzero.
    assign logical_or  = a || b;
    // Return one bit: true only when a is zero.
    assign logical_not = !a;
endmodule
