// ============================================================================
// EXAMPLE 08 - A constant lookup table built from one vector
// File: design.v (RTL description)
// Language: Verilog HDL (IEEE 1364-2001/2005); no SystemVerilog syntax.
//
// Key concepts:
//   1. Classic Verilog parameters can hold multi-bit constant vectors.
//   2. Four 8-bit constants can be concatenated into one 32-bit parameter.
//   3. Bit slicing selects an individual eight-bit entry.
//   4. This is a vector-based lookup, not an unpacked parameter array.
//
// These snippets are reading-oriented examples, not production-ready IP.
// A matching design.v/testbench.v pair is included to illustrate behavior.
// ============================================================================
module constant_vector_table (
    output wire [7:0] item0,
    output wire [7:0] item2,
    output wire       item2_bit0
);
    // Order the bytes from high to low: 44, 33, 22, 11.
    parameter [31:0] TABLE = {8'h44, 8'h33, 8'h22, 8'h11};
    // Bits [7:0] form the lowest byte, 0x11.
    assign item0 = TABLE[7:0];
    // Bits [23:16] form the third byte, 0x33.
    assign item2 = TABLE[23:16];
    // The low bit of 0x33 is 1 (bit position 16 overall).
    assign item2_bit0 = TABLE[16];
endmodule
