// ============================================================================
// EXAMPLE 06 - Sized constants, zero extension, truncation, and sign extension
// File: design.v (RTL description)
// Language: Verilog HDL (IEEE 1364-2001/2005); no SystemVerilog syntax.
//
// Key concepts:
//   1. The syntax 4'b1010 means a four-bit binary value equal to decimal 10.
//   2. Assigning a smaller unsigned value to a wider destination zero-extends it.
//   3. Assigning a wider value to a narrower destination discards high bits.
//   4. Extending a signed negative value copies its sign bit.
//
// These snippets are reading-oriented examples, not production-ready IP.
// A matching design.v/testbench.v pair is included to illustrate behavior.
// ============================================================================
module constant_width_example (
    output wire [3:0] four_bit,
    output wire [7:0] eight_bit,
    output wire [3:0] truncated,
    output wire signed [7:0] sign_extended
);
    // Four-bit signed binary 1010 has the two's-complement value -6.
    wire signed [3:0] negative_six;
    // Keep all four bits of the source literal.
    assign four_bit = 4'b1010;
    // Four-bit unsigned 1010 becomes 00001010 in eight bits.
    assign eight_bit = 4'b1010;
    // Only low four bits survive, leaving 0000.
    assign truncated = 8'b1111_0000;

    // Interpret the same bit pattern as a signed four-bit value.
    assign negative_six = 4'b1010;
    // Replicate the sign bit on expansion: 11111010 (-6).
    assign sign_extended = negative_six;
endmodule
