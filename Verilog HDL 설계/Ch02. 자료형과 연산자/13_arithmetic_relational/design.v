// ============================================================================
// EXAMPLE 13 - Arithmetic, relational, and equality operators
// File: design.v (RTL description)
// Language: Verilog HDL (IEEE 1364-2001/2005); no SystemVerilog syntax.
//
// Key concepts:
//   1. Addition can require one extra bit for a carry-out.
//   2. Two 8-bit unsigned operands may produce a 16-bit multiplication result.
//   3. Integer division truncates the fractional part; % returns the remainder.
//   4. Comparison operators return a one-bit truth value for known inputs.
//
// These snippets are reading-oriented examples, not production-ready IP.
// A matching design.v/testbench.v pair is included to illustrate behavior.
// ============================================================================
module arithmetic_example (
    input  wire [7:0] a, b,
    // Use nine bits so an 8-bit-plus-8-bit carry is not lost.
    output wire [8:0] sum9,
    output wire [7:0] subtract,
    // An unsigned 8-by-8 product can need sixteen bits.
    output wire [15:0] product,
    output wire [7:0] quotient,
    output wire [7:0] remainder,
    output wire greater,
    output wire equals
);
    // Explicitly zero-extend both operands before addition.
    assign sum9     = {1'b0,a} + {1'b0,b};
    // Unsigned subtraction wraps modulo the destination width.
    assign subtract = a - b;
    assign product  = a * b;
    // Use a guard so division by zero is not requested.
    assign quotient = (b != 0) ? (a / b) : 8'd0;
    // The remainder follows integer division semantics.
    assign remainder= (b != 0) ? (a % b) : 8'd0;
    // A relational comparison returns 1 when a is greater than b.
    assign greater  = (a > b);
    // Logical equality can return x if operands contain unknown bits.
    assign equals   = (a == b);
endmodule
