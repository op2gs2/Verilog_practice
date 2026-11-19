// ============================================================================
// EXAMPLE 18 - Conditional operator and 2-to-1 multiplexer
// File: design.v (RTL description)
// Language: Verilog HDL (IEEE 1364-2001/2005); no SystemVerilog syntax.
//
// Key concepts:
//   1. condition ? true_value : false_value selects between two expressions.
//   2. A one-bit select of 1 chooses a; a select of 0 chooses b.
//   3. This is commonly synthesized as a 2-to-1 multiplexer.
//   4. When select is x/z, Verilog may merge corresponding data bits.
//
// These snippets are reading-oriented examples, not production-ready IP.
// A matching design.v/testbench.v pair is included to illustrate behavior.
// ============================================================================
module mux_example (
    input  wire select,
    input  wire [7:0] a,b,
    output wire [7:0] y
);
    // The result uses a if select is true, otherwise b.
    assign y = select ? a : b;
endmodule
