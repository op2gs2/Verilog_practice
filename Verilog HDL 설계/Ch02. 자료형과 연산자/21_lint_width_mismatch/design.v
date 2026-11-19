// ============================================================================
// EXAMPLE 21 - Width mismatch: deliberately bad versus explicit slicing
// File: design.v (RTL description)
// Language: Verilog HDL (IEEE 1364-2001/2005); no SystemVerilog syntax.
//
// Key concepts:
//   1. This design intentionally contains one implicit 16-to-8-bit assignment.
//   2. A lint checker can warn about potential truncation.
//   3. An explicit slice can document the choice but does not ensure correctness.
//   4. The high-bits flag makes the information loss visible.
//
// These snippets are reading-oriented examples, not production-ready IP.
// A matching design.v/testbench.v pair is included to illustrate behavior.
// ============================================================================
module width_lint_example (
    input  wire [15:0] wide_data,
    output wire [7:0] bad_result,
    output wire [7:0] intended_low,
    output wire high_bits_nonzero
);
    // Intentionally unsafe: high eight bits disappear implicitly.
    assign bad_result = wide_data;

    // Explicitly select the byte that will be kept.
    assign intended_low = wide_data[7:0];
    // Warn if any discarded high bit is asserted.
    assign high_bits_nonzero = |wide_data[15:8];
endmodule
