// ============================================================================
// EXAMPLE 15 - Reduction operators
// File: design.v (RTL description)
// Language: Verilog HDL (IEEE 1364-2001/2005); no SystemVerilog syntax.
//
// Key concepts:
//   1. A unary reduction operator processes every bit of a single vector.
//   2. &data is 1 only if all bits are 1.
//   3. |data is 1 if at least one bit is 1.
//   4. ^data is odd parity: 1 if the number of one-bits is odd.
//
// These snippets are reading-oriented examples, not production-ready IP.
// A matching design.v/testbench.v pair is included to illustrate behavior.
// ============================================================================
module reduction_example (
    input  wire [3:0] data,
    output wire all_ones,any_one,odd_parity,
    output wire nand_all,nor_all
);
    // Reduction AND maps many bits to one bit.
    assign all_ones  = &data;
    // Reduction OR detects any asserted input bit.
    assign any_one   = |data;
    // Reduction XOR calculates odd parity.
    assign odd_parity= ^data;
    // Negated reduction AND.
    assign nand_all  = ~&data;
    // Negated reduction OR.
    assign nor_all   = ~|data;
endmodule
