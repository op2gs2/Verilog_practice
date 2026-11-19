// ============================================================================
// EXAMPLE 04 - Scalar signals, vectors, and bit selection
// File: design.v (RTL description)
// Language: Verilog HDL (IEEE 1364-2001/2005); no SystemVerilog syntax.
//
// Key concepts:
//   1. A scalar represents one bit; a vector represents several ordered bits.
//   2. For [7:0], the leftmost bit is bit 7 and the rightmost bit is bit 0.
//   3. data[3] selects one bit; data[7:4] selects a four-bit slice.
//
// These snippets are reading-oriented examples, not production-ready IP.
// A matching design.v/testbench.v pair is included to illustrate behavior.
// ============================================================================
module vector_example (
    // Eight individual bits form one vector.
    input  wire [7:0] data,
    // An output without a range is a one-bit scalar.
    output wire       bit7,
    output wire       bit3,
    output wire [3:0] upper,
    output wire [3:0] lower
);
    // Bit-select: extract exactly one position.
    assign bit7 = data[7];
    // A bit index refers to a position, not a decimal place.
    assign bit3 = data[3];
    // Part-select: extract bits 7, 6, 5, and 4 together.
    assign upper = data[7:4];
    // Part-select: extract bits 3, 2, 1, and 0 together.
    assign lower = data[3:0];
endmodule
