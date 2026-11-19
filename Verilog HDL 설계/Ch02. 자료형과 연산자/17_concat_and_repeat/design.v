// ============================================================================
// EXAMPLE 17 - Concatenation and replication operators
// File: design.v (RTL description)
// Language: Verilog HDL (IEEE 1364-2001/2005); no SystemVerilog syntax.
//
// Key concepts:
//   1. {a,b} forms a vector with a as the high bits and b as the low bits.
//   2. {2{a}} repeats the bit sequence a two times.
//   3. {WIDTH{1'b0}} builds WIDTH zero bits using a constant repetition count.
//   4. Concatenation is useful for packet fields, masks, and data assembly.
//
// These snippets are reading-oriented examples, not production-ready IP.
// A matching design.v/testbench.v pair is included to illustrate behavior.
// ============================================================================
module concat_example #(
    // This parameter controls the width of the zero output.
    parameter WIDTH = 8
)(
    input  wire [3:0] a,b,
    output wire [7:0] concatenated,
    output wire [7:0] repeated,
    output wire [WIDTH-1:0] zeros
);
    // Place a in bits [7:4] and b in bits [3:0].
    assign concatenated = {a,b};
    // Repeat the four-bit a pattern to form eight bits.
    assign repeated = {2{a}};
    // Create exactly WIDTH zeros without an ambiguous literal width.
    assign zeros = {WIDTH{1'b0}};
endmodule
